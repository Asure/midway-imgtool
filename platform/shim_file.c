/*************************************************************
 * platform/shim_file.c
 * DOS INT 21h file / directory / find shims
 *************************************************************/
#ifndef WIN32_LEAN_AND_MEAN
#define WIN32_LEAN_AND_MEAN
#endif
#include <windows.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <direct.h>   /* _getcwd, _chdir, _chdrive, _getdrive */
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
static int   s_handles_init = 0;

static void handles_init(void)
{
    if (!s_handles_init) {
        memset(s_handles, 0, sizeof(s_handles));
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
    if (h < MAX_HANDLES) s_handles[h] = NULL;
}

/* ---- path remapping ----
   "c:\bin\it.hlp" and "c:\bin\it.cfg" → <exe_dir>\it.hlp / it.cfg */
static void path_remap(const char *src, char *dst, int dstsz)
{
    const char *bin = "c:\\bin\\";
    if (_strnicmp(src, bin, strlen(bin)) == 0 && exe_dir[0]) {
        _snprintf(dst, dstsz, "%s\\%s", exe_dir, src + strlen(bin));
    } else {
        strncpy(dst, src, dstsz);
    }
    dst[dstsz-1] = '\0';
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
    WORD h = handle_alloc(f);
    if (h == 0xFFFF) { fclose(f); shim_carry = 1; shim_eax = 0x0004; return; }
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
    shim_eax   = (DWORD)(_getdrive() - 1);  /* _getdrive: 1=A → return 0=A */
    shim_carry = 0;
}

void shim_i21_setdrv_impl(void)
{
    int drv = (int)(shim_edx & 0xFF);  /* DL = drive (0=A, 1=B ...) */
    _chdrive(drv + 1);                 /* _chdrive: 1=A */
    shim_eax   = 26;                   /* pretend 26 drives available */
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
    if (!GetCurrentDirectoryA(sizeof(buf), buf)) {
        shim_carry = 1;
        return;
    }
    /* Strip "X:\" prefix so we return only the path component */
    char *p = buf;
    if (p[1] == ':' && p[2] == '\\') p += 3;
    /* Remove trailing backslash */
    {
        int len = (int)strlen(p);
        if (len > 0 && p[len-1] == '\\') p[len-1] = '\0';
    }
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
   We write to the asm 'dta' symbol directly. */
/* asm symbol is 'dta' (no underscore); C 'extern BYTE _dta[]' would look for '__dta'.
   Redirect via linker alternatename so __dta → dta. */
#pragma comment(linker, "/alternatename:__dta=dta")
extern BYTE _dta[];    /* defined in itos.asm as BSS dta,256 */

static HANDLE s_find_handle = INVALID_HANDLE_VALUE;

static void fill_dta_from_fd(const WIN32_FIND_DATAA *fd)
{
    /* attribute byte */
    _dta[21] = (BYTE)(fd->dwFileAttributes & 0xFF);
    /* 8.3 filename: use cAlternateFileName if available */
    const char *name = fd->cAlternateFileName[0]
                       ? fd->cAlternateFileName
                       : fd->cFileName;
    strncpy((char *)&_dta[30], name, 12);
    _dta[30+12] = '\0';
    /* Uppercase for consistency with original DOS tool */
    {
        int i;
        for (i = 30; i < 30+12 && _dta[i]; i++)
            if (_dta[i] >= 'a' && _dta[i] <= 'z') _dta[i] -= 32;
    }
}

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
        shim_carry = 1;
        shim_eax   = 0x0012;  /* no more files */
        return;
    }
    fill_dta_from_fd(&fd);
    shim_carry = 0;
    shim_eax   = 0;
}

void shim_i21_findnext_impl(void)
{
    WIN32_FIND_DATAA fd;
    if (s_find_handle == INVALID_HANDLE_VALUE) {
        shim_carry = 1; shim_eax = 0x0012;
        return;
    }
    if (!FindNextFileA(s_find_handle, &fd)) {
        FindClose(s_find_handle);
        s_find_handle = INVALID_HANDLE_VALUE;
        shim_carry = 1; shim_eax = 0x0012;
        return;
    }
    fill_dta_from_fd(&fd);
    shim_carry = 0;
    shim_eax   = 0;
}

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
