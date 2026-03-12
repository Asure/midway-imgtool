/*************************************************************
 * platform/shim_file.c
 * DOS INT 21h file / directory / find shims
 *************************************************************/
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#ifdef _WIN32
#  include <direct.h>   /* _getcwd, _chdir, _chdrive, _getdrive */
#else
#  include <dirent.h>
#  include <fnmatch.h>
#  include <sys/stat.h>
#  ifndef FNM_CASEFOLD
#    define FNM_CASEFOLD 0   /* fallback: case-sensitive on non-GNU */
#  endif
#endif
#include "shim_file.h"

/* ---- relay globals (defined here, extern'd by other shims) ---- */
DWORD shim_eax   = 0;
DWORD shim_ebx   = 0;
DWORD shim_ecx   = 0;
DWORD shim_edx   = 0;
DWORD shim_esi   = 0;
DWORD shim_carry = 0;

/* ---- exe directory ---- */
char exe_dir[MAX_PATH] = "";

/* ---- file handle table (max 16 open files) ---- */
#define MAX_HANDLES 16
static FILE *s_handles[MAX_HANDLES];
static char  s_tmpfiles[MAX_HANDLES][MAX_PATH]; /* temp paths for converted old-IMG files */
static int   s_handles_init = 0;

static void handles_init(void)
{
    if (!s_handles_init) {
        memset(s_handles,  0, sizeof(s_handles));
        memset(s_tmpfiles, 0, sizeof(s_tmpfiles));
        s_handles_init = 1;
    }
}

static WORD handle_alloc(FILE *f)
{
    int i;
    handles_init();
    for (i = 0; i < MAX_HANDLES; i++) {
        if (!s_handles[i]) {
            s_handles[i] = f;
            return (WORD)i;
        }
    }
    return 0xFFFF;  /* no free handle */
}

static FILE *handle_get(WORD h)
{
    handles_init();
    if (h < MAX_HANDLES) return s_handles[h];
    return NULL;
}

static void handle_free(WORD h)
{
    handles_init();
    if (h < MAX_HANDLES) {
        s_handles[h] = NULL;
        if (s_tmpfiles[h][0]) {
            remove(s_tmpfiles[h]);   /* remove() is standard C, works everywhere */
            s_tmpfiles[h][0] = '\0';
        }
    }
}

/* ---- path remapping ----
   "c:\bin\it.hlp" and "c:\bin\it.cfg" → <exe_dir>\it.hlp / it.cfg */
static void path_remap(const char *src, char *dst, int dstsz)
{
    const char *bin = "c:\\bin\\";
    if (_strnicmp(src, bin, strlen(bin)) == 0 && exe_dir[0]) {
        _snprintf(dst, dstsz, "%s" PATH_SEP "%s", exe_dir, src + strlen(bin));
    } else {
        strncpy(dst, src, dstsz);
    }
    dst[dstsz-1] = '\0';
}

/* ---- old-format IMG conversion ------------------------------------------- */
/*
 * Pre-WimpV5 IMG containers use a 42-byte IMAGE record and have TEMP != 0xABCD.
 * We detect them on open and transparently convert to the 50-byte new format
 * so the tool can load them without a separate offline conversion step.
 *
 * Layout (old):  [LIB_HDR(28)] [blob data] [OLD_IMAGE×N(42)] [PALETTE×P(26)]
 * Layout (new):  [LIB_HDR(28)] [blob data] [NEW_IMAGE×N(50)] [PALETTE×P(26)]
 */

#pragma pack(push, 1)
typedef struct {
    WORD  IMGCNT, PALCNT;
    DWORD OSET;
    WORD  VERSION, SEQCNT, SCRCNT, DAMCNT, TEMP;
    BYTE  BUFSCR[4];
    WORD  spare1, spare2, spare3;
} OLD_LIB_HDR;  /* 28 bytes */

typedef struct {
    char   name[16];
    short  xoff, yoff;
    WORD   xsize, ysize;
    signed char palind;
    BYTE   flags;
    DWORD  oset, data;
    short  lib, pword1, pword2;
    BYTE   frame, pbyte1;
} OLD_IMAGE;    /* 42 bytes */

typedef struct {
    char  N_s[16];
    WORD  FLAGS, ANIX, ANIY, W, H, PALNUM;
    DWORD OSET, DATA;
    WORD  LIB, ANIX2, ANIY2, ANIZ2, FRM, PTTBLNUM, OPALS;
} NEW_IMAGE;    /* 50 bytes */
#pragma pack(pop)

/* Returns a FILE* pointing to converted data, or NULL if not old format.
   On success, writes the temp-file path into tmppath_out[MAX_PATH]. */
static FILE *try_convert_old_img(FILE *f, char *tmppath_out)
{
    OLD_LIB_HDR hdr;
    rewind(f);
    if (fread(&hdr, sizeof(hdr), 1, f) != 1)   return NULL;
    if (hdr.TEMP    == 0xABCD)                  return NULL; /* already new */
    if (hdr.VERSION >= 0x500)                   return NULL; /* unknown new */
    if (hdr.IMGCNT  == 0)                       return NULL; /* nothing to do */

    /* Read whole file */
    fseek(f, 0, SEEK_END);
    long fsize = ftell(f);
    rewind(f);
    BYTE *inbuf = (BYTE *)malloc((size_t)fsize);
    if (!inbuf) return NULL;
    if ((long)fread(inbuf, 1, (size_t)fsize, f) != fsize) { free(inbuf); return NULL; }

    /* Validate table extents */
    long imgs_start = (long)hdr.OSET;
    long imgs_end   = imgs_start + hdr.IMGCNT * (long)sizeof(OLD_IMAGE);
    long pals_end   = imgs_end   + hdr.PALCNT * 26L;
    if (imgs_start < (long)sizeof(OLD_LIB_HDR) || pals_end > fsize) {
        free(inbuf); return NULL;
    }

    /* Build converted buffer */
    long blob_sz  = imgs_start - (long)sizeof(OLD_LIB_HDR);
    long new_imgs = hdr.IMGCNT * (long)sizeof(NEW_IMAGE);
    long pal_sz   = hdr.PALCNT * 26L;
    long outsz    = (long)sizeof(OLD_LIB_HDR) + blob_sz + new_imgs + pal_sz;
    BYTE *out = (BYTE *)malloc((size_t)outsz);
    if (!out) { free(inbuf); return NULL; }

    /* Modified header */
    OLD_LIB_HDR nhdr = hdr;
    nhdr.VERSION = 0x0634;
    nhdr.TEMP    = 0xABCD;
    nhdr.SEQCNT  = 0;
    nhdr.SCRCNT  = 0;
    BYTE *p = out;
    memcpy(p, &nhdr, sizeof(nhdr));             p += sizeof(nhdr);
    memcpy(p, inbuf + sizeof(nhdr), (size_t)blob_sz); p += blob_sz;

    /* Convert each IMAGE record */
    for (int i = 0; i < hdr.IMGCNT; i++) {
        OLD_IMAGE *o = (OLD_IMAGE *)(inbuf + imgs_start + i * (long)sizeof(OLD_IMAGE));
        NEW_IMAGE  n;
        memcpy(n.N_s, o->name, 16);
        n.FLAGS    = (WORD)(o->flags & ~0x12u);  /* clear LOADED + DOWN */
        n.ANIX     = (WORD)o->xoff;
        n.ANIY     = (WORD)o->yoff;
        n.W        = o->xsize;
        n.H        = o->ysize;
        n.PALNUM   = (WORD)(BYTE)o->palind;
        n.OSET     = o->oset;
        n.DATA     = o->data;
        n.LIB      = (WORD)o->lib;
        n.ANIX2    = (WORD)o->pword1;
        n.ANIY2    = (WORD)o->pword2;
        n.ANIZ2    = 0;
        n.FRM      = (WORD)o->frame;
        n.PTTBLNUM = 0xFFFF;
        n.OPALS    = 0xFFFF;
        memcpy(p, &n, sizeof(n)); p += sizeof(n);
    }
    memcpy(p, inbuf + imgs_end, (size_t)pal_sz);
    free(inbuf);

    /* Write to a temp file (auto-deleted when handle is closed) */
    FILE *tmp;
#ifdef _WIN32
    {
        char tmpdir[MAX_PATH];
        GetTempPathA(MAX_PATH, tmpdir);
        GetTempFileNameA(tmpdir, "itl", 0, tmppath_out);
        tmp = fopen(tmppath_out, "w+b");
    }
#else
    {
        const char *tmpdir = getenv("TMPDIR");
        if (!tmpdir || !*tmpdir) tmpdir = "/tmp";
        _snprintf(tmppath_out, MAX_PATH, "%s/itlXXXXXX", tmpdir);
        int fd = mkstemp(tmppath_out);
        tmp = (fd >= 0) ? fdopen(fd, "w+b") : NULL;
    }
#endif
    if (!tmp) { free(out); tmppath_out[0] = '\0'; return NULL; }
    fwrite(out, 1, (size_t)outsz, tmp);
    free(out);
    rewind(tmp);
    return tmp;
}

/* ---- impl functions ---- */

void shim_i21_openr_impl(void)
{
    char remapped[MAX_PATH];
    path_remap((const char *)(UINT_PTR)shim_edx, remapped, sizeof(remapped));
    FILE *f = fopen(remapped, "rb");
    if (!f) {
        shim_carry = 1;
        shim_eax   = 0x0002;  /* file not found */
        return;
    }
    /* Transparently upgrade old-format IMG containers */
    char tmppath[MAX_PATH] = "";
    FILE *converted = try_convert_old_img(f, tmppath);
    if (converted) {
        fclose(f); f = converted;
        /* Notify user, matching the style of "Bogus file version!" */
        char msg[MAX_PATH + 64];
        const char *fname = strrchr(remapped, '\\');
        fname = fname ? fname + 1 : remapped;
        _snprintf(msg, sizeof(msg), "Ancient format IMG converted:\n%s", fname);
        MessageBoxA(NULL, msg, "imgtool", MB_OK | MB_ICONINFORMATION);
    } else rewind(f);  /* detection reads 28 bytes; reset for asm sequential read */

    WORD h = handle_alloc(f);
    if (h == 0xFFFF) { fclose(f); shim_carry = 1; shim_eax = 0x0004; return; }
    if (tmppath[0]) memcpy(s_tmpfiles[h], tmppath, MAX_PATH);
    shim_eax   = h;
    shim_carry = 0;
}

void shim_i21_close_impl(void)
{
    WORD h = (WORD)(shim_ebx & 0xFFFF);
    FILE *f = handle_get(h);
    if (!f) { shim_carry = 1; return; }
    fclose(f);
    handle_free(h);
    shim_carry = 0;
}

void shim_i21_read_impl(void)
{
    WORD h   = (WORD)(shim_ebx & 0xFFFF);
    DWORD cnt = shim_ecx;
    void *buf = (void *)(UINT_PTR)shim_edx;
    FILE *f  = handle_get(h);
    if (!f) { shim_carry = 1; shim_eax = 0; return; }
    size_t n = fread(buf, 1, cnt, f);
    shim_eax   = (DWORD)n;
    shim_carry = ferror(f) ? 1 : 0;
}

void shim_i21_write_impl(void)
{
    WORD h   = (WORD)(shim_ebx & 0xFFFF);
    DWORD cnt = shim_ecx;
    const void *buf = (const void *)(UINT_PTR)shim_edx;
    FILE *f  = handle_get(h);
    if (!f) { shim_carry = 1; shim_eax = 0; return; }
    size_t n = fwrite(buf, 1, cnt, f);
    shim_eax   = (DWORD)n;
    shim_carry = (n < cnt) ? 1 : 0;
}

void shim_i21_create_impl(void)
{
    char remapped[MAX_PATH];
    path_remap((const char *)(UINT_PTR)shim_edx, remapped, sizeof(remapped));
    FILE *f = fopen(remapped, "wb");
    if (!f) {
        shim_carry = 1;
        shim_eax   = 0x0003;
        return;
    }
    WORD h = handle_alloc(f);
    if (h == 0xFFFF) { fclose(f); shim_carry = 1; shim_eax = 0x0004; return; }
    shim_eax   = h;
    shim_carry = 0;
}

static void seek_common(int whence)
{
    WORD h  = (WORD)(shim_ebx & 0xFFFF);
    long off = (long)(((shim_ecx & 0xFFFF) << 16) | (shim_edx & 0xFFFF));
    FILE *f = handle_get(h);
    if (!f) { shim_carry = 1; return; }
    if (fseek(f, off, whence) != 0) { shim_carry = 1; return; }
    long pos   = ftell(f);
    shim_eax   = (DWORD)(pos & 0xFFFF);
    shim_edx   = (DWORD)((pos >> 16) & 0xFFFF);
    shim_carry = 0;
}

void shim_i21_setfps_impl(void) { seek_common(SEEK_SET); }
void shim_i21_setfpc_impl(void) { seek_common(SEEK_CUR); }
void shim_i21_setfpe_impl(void) { seek_common(SEEK_END); }

void shim_i21_getdrv_impl(void)
{
#ifdef _WIN32
    shim_eax = (DWORD)(_getdrive() - 1);  /* _getdrive: 1=A → return 0=A */
#else
    shim_eax = 2;  /* pretend 'C:' (drive 2) */
#endif
    shim_carry = 0;
}

void shim_i21_setdrv_impl(void)
{
#ifdef _WIN32
    int drv = (int)(shim_edx & 0xFF);  /* DL = drive (0=A, 1=B ...) */
    _chdrive(drv + 1);                 /* _chdrive: 1=A */
#endif
    shim_eax   = 26;   /* pretend 26 drives available */
    shim_carry = 0;
}

void shim_i21_setcd_impl(void)
{
    const char *path = (const char *)(UINT_PTR)shim_edx;
    shim_carry = (_chdir(path) == 0) ? 0 : 1;
}

void shim_i21_getcwd_impl(void)
{
    char buf[MAX_PATH];
    char *dest = (char *)(UINT_PTR)shim_esi;
#ifdef _WIN32
    if (!GetCurrentDirectoryA(sizeof(buf), buf)) { shim_carry = 1; return; }
    /* Strip "X:\" prefix */
    char *p = buf;
    if (p[1] == ':' && p[2] == '\\') p += 3;
    { int len = (int)strlen(p); if (len > 0 && p[len-1] == '\\') p[len-1] = '\0'; }
#else
    if (!getcwd(buf, sizeof(buf))) { shim_carry = 1; return; }
    /* Strip leading '/' so the asm tool sees a relative-looking path */
    char *p = buf;
    if (*p == '/') p++;
    { int len = (int)strlen(p); if (len > 0 && p[len-1] == '/') p[len-1] = '\0'; }
#endif
    strcpy(dest, p);
    shim_carry = 0;
}

void shim_i21_rename_impl(void)
{
    const char *oldpath = (const char *)(UINT_PTR)shim_edx;
    const char *newpath = (const char *)(UINT_PTR)shim_esi;
    shim_carry = (rename(oldpath, newpath) == 0) ? 0 : 1;
    shim_eax   = shim_carry ? 5 : 0;
}

void shim_i21_delete_impl(void)
{
    const char *path = (const char *)(UINT_PTR)shim_edx;
    shim_carry = (remove(path) == 0) ? 0 : 1;
    shim_eax   = shim_carry ? 2 : 0;
}

/* ---- find first / next ---- */
/* The asm code accesses dta[21] (attribute) and dta[30..] (filename).
   We write to the asm 'dta' symbol directly.
   MASM (.model flat,syscall) exports 'dta' with no underscore.
   Windows/MSVC: C 'extern _dta[]' → linker symbol '__dta';
     /alternatename redirects it to the asm 'dta'.
   Linux/GCC + jwasm (ELF): asm exports 'dta', C 'extern dta[]' matches
     directly (GCC adds no underscore prefix). */
#ifdef _WIN32
#  pragma comment(linker, "/alternatename:__dta=dta")
   extern BYTE _dta[];
#  define dta _dta
#else
   extern BYTE dta[];
#endif

/* Write filename + attribute into the DOS DTA buffer */
static void fill_dta(const char *name, BYTE attr)
{
    dta[21] = attr;
    strncpy((char *)&dta[30], name, 12);
    dta[30+12] = '\0';
    /* Uppercase — consistent with original DOS tool */
    {
        int i;
        for (i = 30; i < 30+12 && dta[i]; i++)
            if (dta[i] >= 'a' && dta[i] <= 'z') dta[i] -= 32;
    }
}

#ifdef _WIN32

static HANDLE s_find_handle = INVALID_HANDLE_VALUE;

void shim_i21_findfile_impl(void)
{
    const char *pattern = (const char *)(UINT_PTR)shim_edx;
    WIN32_FIND_DATAA fd;
    if (s_find_handle != INVALID_HANDLE_VALUE) {
        FindClose(s_find_handle);
        s_find_handle = INVALID_HANDLE_VALUE;
    }
    s_find_handle = FindFirstFileA(pattern, &fd);
    if (s_find_handle == INVALID_HANDLE_VALUE) {
        shim_carry = 1; shim_eax = 0x0012; return;
    }
    const char *name = fd.cAlternateFileName[0] ? fd.cAlternateFileName : fd.cFileName;
    fill_dta(name, (BYTE)(fd.dwFileAttributes & 0xFF));
    shim_carry = 0; shim_eax = 0;
}

void shim_i21_findnext_impl(void)
{
    WIN32_FIND_DATAA fd;
    if (s_find_handle == INVALID_HANDLE_VALUE) {
        shim_carry = 1; shim_eax = 0x0012; return;
    }
    if (!FindNextFileA(s_find_handle, &fd)) {
        FindClose(s_find_handle);
        s_find_handle = INVALID_HANDLE_VALUE;
        shim_carry = 1; shim_eax = 0x0012; return;
    }
    const char *name = fd.cAlternateFileName[0] ? fd.cAlternateFileName : fd.cFileName;
    fill_dta(name, (BYTE)(fd.dwFileAttributes & 0xFF));
    shim_carry = 0; shim_eax = 0;
}

#else /* Linux -------------------------------------------------------- */

static DIR  *s_find_dir = NULL;
static char  s_find_pat[64];     /* filename glob, e.g. "*.IMG" */

void shim_i21_findfile_impl(void)
{
    const char *pattern = (const char *)(UINT_PTR)shim_edx;

    if (s_find_dir) { closedir(s_find_dir); s_find_dir = NULL; }

    /* Split "dir/pattern" or "dir\pattern" into directory + glob */
    char dirpath[MAX_PATH];
    const char *sep = strrchr(pattern, '/');
    if (!sep) sep = strrchr(pattern, '\\');
    if (sep) {
        size_t dlen = (size_t)(sep - pattern);
        if (dlen >= MAX_PATH) dlen = MAX_PATH - 1;
        memcpy(dirpath, pattern, dlen);
        dirpath[dlen] = '\0';
        strncpy(s_find_pat, sep + 1, sizeof(s_find_pat) - 1);
    } else {
        strcpy(dirpath, ".");
        strncpy(s_find_pat, pattern, sizeof(s_find_pat) - 1);
    }
    s_find_pat[sizeof(s_find_pat) - 1] = '\0';

    s_find_dir = opendir(dirpath);
    if (!s_find_dir) { shim_carry = 1; shim_eax = 0x0012; return; }

    struct dirent *ent;
    while ((ent = readdir(s_find_dir)) != NULL) {
        if (fnmatch(s_find_pat, ent->d_name, FNM_CASEFOLD) == 0) {
            fill_dta(ent->d_name, 0x20 /* archive */);
            shim_carry = 0; shim_eax = 0; return;
        }
    }
    closedir(s_find_dir); s_find_dir = NULL;
    shim_carry = 1; shim_eax = 0x0012;
}

void shim_i21_findnext_impl(void)
{
    if (!s_find_dir) { shim_carry = 1; shim_eax = 0x0012; return; }
    struct dirent *ent;
    while ((ent = readdir(s_find_dir)) != NULL) {
        if (fnmatch(s_find_pat, ent->d_name, FNM_CASEFOLD) == 0) {
            fill_dta(ent->d_name, 0x20);
            shim_carry = 0; shim_eax = 0; return;
        }
    }
    closedir(s_find_dir); s_find_dir = NULL;
    shim_carry = 1; shim_eax = 0x0012;
}

#endif /* !_WIN32 */

/* ---- message box error ---- */

void shim_msgbox_error(void)
{
    /* EDX points to a DOS '$'-terminated string */
    const char *msg = (const char *)(UINT_PTR)shim_edx;
    if (msg && *msg) {
        char buf[256];
        int i = 0;
        while (i < 255 && msg[i] && msg[i] != '$') {
            buf[i] = msg[i];
            i++;
        }
        buf[i] = '\0';
        MessageBoxA(NULL, buf, "Image Tool Error", MB_OK | MB_ICONERROR);
    }
}
