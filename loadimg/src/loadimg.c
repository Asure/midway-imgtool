/*
 * loadimg - Williams/Midway arcade image loader replacement
 * Reads a .lod file + .img containers, outputs .tbl/.asm/.glo/.irw files
 *
 * Compatible with LOAD2 / LOADW tool output (Williams Electronics, 1992-1995)
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <stdarg.h>
#include <ctype.h>
#include <math.h>

#ifdef _WIN32
#include <direct.h>
#define PATH_SEP '\\'
#else
#include <sys/stat.h>
#define PATH_SEP '/'
#endif

/* =========================================================================
 * Constants
 * ========================================================================= */

#define MAX_IMAGES      4096
#define MAX_PALETTES    2000
#define MAX_IMGFILES    64
#define MAX_PATH        512
#define MAX_NAME        16
#define PAL_NAME_LEN    10
#define IRW_HDR_SIZE    0x44
#define IRW_DATE_STR    "03/14/95"
#define NUMDEFPAL       3

/* =========================================================================
 * IMG container format structures
 * ========================================================================= */

#pragma pack(push, 2)

typedef struct {
    uint16_t imgcnt;
    uint16_t palcnt;
    uint32_t oset;
    uint16_t version;
    uint16_t seqcnt;
    uint16_t scrcnt;
    uint16_t damcnt;
    uint16_t temp;
    uint8_t  bufscr[4];
    uint16_t spare1, spare2, spare3;
} LIB_HDR;

/* IMG_REC struct may have padding — file format uses 50-byte records */
#define IMG_REC_SIZE 50
/* IMG files always use 4-byte aligned row stride */
#define IMG_STRIDE(w) (((w) + 3) & ~3)
/* Output stride: follows /P flag (padded if set, raw otherwise), minimum 3 */
#define OUT_STRIDE(w) (g.pad4bits ? (((w) + 3) & ~3) : ((w) > 2 ? (w) : 3))

typedef struct {
    char     name[MAX_NAME];
    uint16_t flags;
    int16_t  anix;
    int16_t  aniy;
    uint16_t w;
    uint16_t h;
    uint16_t palnum;
    uint32_t oset;
    uint32_t data_p;
    uint16_t lib;
    int16_t  anix2;
    int16_t  aniy2;
    int16_t  aniz2;
    uint16_t frm;
    int16_t  pttblnum;
    uint16_t opals;
} IMG_REC;

typedef struct {
    char     name[PAL_NAME_LEN];
    uint8_t  flags;
    uint8_t  bitspix;
    uint16_t numc;
    uint32_t oset;
    uint16_t data_p;
    uint16_t lib;
    uint8_t  colind;
    uint8_t  cmap;
    uint16_t spare;
} PAL_REC;

#pragma pack(pop)

#pragma pack(push, 1)
/* PTTBL: 12-byte entries stored after palette records.
 * Layout (all fields are 1-based in LOADW docs, 0-based in code):
 *   BOX[1] = box[0]: primary bounding box (w = compression width)
 *   BOX[2] = box[1]: secondary bounding box
 *   BOX[3] = box[2]: tertiary bounding box
 * When x1 is non-zero, the first 6 bytes are x1/x2/x3 instead. */
typedef struct { uint8_t x, y, w, h; } PTBOX;

typedef struct {
    uint16_t flags;
    int16_t  x1, x2, x3;
    int16_t  X, Y, Z;
    uint16_t id;
    PTBOX    box[5];
    PTBOX    cbox;
} PTTBL;
#pragma pack(pop)

/* =========================================================================
 * IHDR field definitions
 * ========================================================================= */

#define IHDR_SIZX   0
#define IHDR_SIZY   1
#define IHDR_SAG    2
#define IHDR_CTRL   3
#define IHDR_ANIX   4
#define IHDR_ANIY   5
#define IHDR_PAL    6
#define IHDR_ALT    7
#define IHDR_PT0X   8
#define IHDR_PT0Y   9
#define IHDR_PT1X   10
#define IHDR_PT1Y   11
#define IHDR_PT2X   12
#define IHDR_PT2Y   13
#define IHDR_PT3X   14
#define IHDR_PT3Y   15
#define IHDR_PT4X   16
#define IHDR_PT4Y   17
#define IHDR_PT5X   18
#define IHDR_PT5Y   19
#define IHDR_PWRD1  20
#define IHDR_PWRD2  21
#define IHDR_PWRD3  22
#define IHDR_MAX    23

typedef enum { SZ_B=1, SZ_W=2, SZ_L=4 } FieldSize;

typedef struct {
    int      field;
    FieldSize size;
} IhdrField;

/* =========================================================================
 * Image entry
 * ========================================================================= */

typedef struct {
    char     name[MAX_NAME];
    int      anix, aniy;
    int      w, h;
    int      palnum;
    int      sizx, sizy;
    uint32_t sag;
    uint16_t ctrl;
    char     pal_name[PAL_NAME_LEN];
    int      pwrd1, pwrd2, pwrd3;
    int      pt3y;
    int      extra_pts[8];
    int      n_extra_pts;
    PTTBL   *pttbl;
    PTTBL   *pttbl_shared;
    PTTBL   *pttbl_pt0x;
    uint32_t scale_sags[4];
    uint16_t scale_ctrls[4];
    int      n_scales;
    uint32_t checksum;
} ImageEntry;

typedef struct {
    char     name[PAL_NAME_LEN];
    int      numc;
    int      bitspix;
    uint16_t *colors;
    int      written;
} PaletteEntry;

/* =========================================================================
 * Global state
 * ========================================================================= */

typedef struct {
    int      zon;
    int      dedup;  /* 1 = CON> (checksums ON), 0 = COF> (checksums OFF) */
    int      pon;
    int      xon;
    int      verbose;
    int      build_tables;
    int      build_raw;
    int      raw_headerless;    /* /R flag: omit IRW header */
    int      dual_bank;
    int      limit3scales;
    int      pad4bits;
    int      align16;
    int      bpp_from_pal;
    int      append;
    int      ppp;

    char     imgdir[MAX_PATH];
    char     tbldir[MAX_PATH];
    char     rawdir[MAX_PATH];
    char     loddir[MAX_PATH];

    uint32_t base_addr;
    uint32_t end_addr;
    int      bank;

    IhdrField ihdr[IHDR_MAX];
    int      n_ihdr;

    char     asm_file[MAX_PATH];
    char     asm_path[MAX_PATH];      /* current TBL file path for append matching */
    char     tbl_files[32][MAX_PATH]; /* all opened TBL files for final .TEXT write */
    int      n_tbl_files;
    char     glo_file[MAX_PATH];
    char     pal_file[MAX_PATH];
    char     raw_file[MAX_PATH];

    FILE     *asm_fp;
    FILE     *glo_fp;
    FILE     *main_glo_fp;  /* IMGTBL.GLO (never redirected) */
    FILE     *pal_fp;
    FILE     *bgnd_fp;     /* BGNDTBL.ASM */
    FILE     *bgndpal_fp;  /* BGNDPAL.ASM */
    FILE     *bgndequ_fp;  /* BGNDEQU.H */
    FILE     *bgndtbl_glo_fp; /* BGNDTBL.GLO */

    ImageEntry images[MAX_IMAGES];
    int      n_images;

    PaletteEntry palettes[MAX_PALETTES];
    int      n_palettes;

    uint32_t irw_bit;

    uint8_t  *irw_data;
    size_t   irw_size;
    size_t   irw_alloc;

    int      global_bpp;
    int      global_max_pixel;
    int      n_small_uncompressed;    /* images <10px not zero-compressed */
    int      bgnd_dedup_bytes;        /* bytes saved by BGND checksum matches */
    int      bgnd_dedup_matches;      /* count of BGND checksum matches */
    int      n_glo_files;
    char     glo_files[64][64];
} State;

static State g;

/* =========================================================================
 * Utility functions
 * ========================================================================= */

static void die(const char *fmt, ...) {
    va_list ap;
    va_start(ap, fmt);
    fprintf(stderr, "ERROR: ");
    vfprintf(stderr, fmt, ap);
    fprintf(stderr, "\n");
    va_end(ap);
    exit(1);
}

static void upcase(char *s) {
    for (; *s; s++) *s = (char)toupper((unsigned char)*s);
}

static void str_trim(char *s) {
    int len = (int)strlen(s);
    while (len > 0 && (s[len-1] == '\r' || s[len-1] == '\n' || s[len-1] == ' '))
        s[--len] = 0;
}

static void path_cat(char *dst, const char *dir, const char *file, size_t dstsz) {
    if (dir[0] && dir[strlen(dir)-1] != '/' && dir[strlen(dir)-1] != '\\')
        snprintf(dst, dstsz, "%s%c%s", dir, PATH_SEP, file);
    else
        snprintf(dst, dstsz, "%s%s", dir, file);
}

static const char *basename_p(const char *path) {
    const char *p = path + strlen(path);
    while (p > path && p[-1] != '/' && p[-1] != '\\') p--;
    return p;
}

static void change_ext(char *dst, const char *src, const char *ext, size_t dstsz) {
    const char *dot = strrchr(src, '.');
    if (dot) {
        size_t base_len = (size_t)(dot - src);
        if (base_len >= dstsz) base_len = dstsz - 1;
        strncpy(dst, src, base_len);
        dst[base_len] = 0;
    } else {
        strncpy(dst, src, dstsz-1);
        dst[dstsz-1] = 0;
    }
    strncat(dst, ext, dstsz - strlen(dst) - 1);
}

/* =========================================================================
 * IRW bit stream writer
 * ========================================================================= */

static void irw_ensure(size_t need_bytes) {
    if (g.irw_size + need_bytes > g.irw_alloc) {
        g.irw_alloc = (g.irw_alloc + need_bytes) * 2;
        g.irw_data = (uint8_t*)realloc(g.irw_data, g.irw_alloc);
        if (!g.irw_data) die("out of memory");
        memset(g.irw_data + g.irw_size, 0, g.irw_alloc - g.irw_size);
    }
}

/* LOADW FUN_1854_35fc checksum: sum + max over stride width */
static uint16_t loadw_checksum(uint8_t *pix, int stride, int w, int h, uint16_t *out_max) {
    uint16_t sum = 0, max_val = 0;
    int n_words = (stride * h) / 2;
    uint16_t *wp = (uint16_t*)pix;
    for (int i = 0; i < n_words; i++) {
        uint16_t v = wp[i];
        sum = (uint16_t)(sum + v);
        uint8_t lo = (uint8_t)(v & 0xff);
        uint8_t hi = (uint8_t)(v >> 8);
        if (lo > max_val) max_val = lo;
        if (hi > max_val) max_val = hi;
    }
    *out_max = max_val;
    return sum;
}

#define MAX_DEDUP 4096
typedef struct { uint16_t sum, max_val; int sizx, sizy; uint16_t ctrl; uint32_t sag; int sag_idx; } DedupEntry;
static DedupEntry dedup_table[MAX_DEDUP];
static int n_dedup = 0;

static void irw_write_bits(uint32_t val, int nbits) {
    uint32_t bit_pos = g.irw_bit;
    size_t need = (bit_pos + nbits + 7) / 8 + 1;
    if (need > g.irw_size) {
        irw_ensure(need - g.irw_size + 16);
        g.irw_size = need;
    }
    for (int i = 0; i < nbits; i++) {
        uint32_t b = bit_pos / 8;
        uint32_t bi = bit_pos % 8;
        if (val & (1u << i))
            g.irw_data[b] |= (uint8_t)(1u << bi);
        else
            g.irw_data[b] &= (uint8_t)~(1u << bi);
        bit_pos++;
    }
    g.irw_bit = bit_pos;
}

static void irw_write_byte(uint8_t val) {
    irw_write_bits(val, 8);
}

/* =========================================================================
 * IMG file reader
 * ========================================================================= */

typedef struct {
    uint8_t  *data;
    size_t    size;
    char      path[MAX_PATH];
    IMG_REC  *images;
    IMG_REC  *norm_images;  /* allocated for old-format conversion */
    PAL_REC  *pals;
    PTTBL    *pttbls;
    int       n_images;
    int       n_palettes;
    int       n_pttbls;
    int       n_special;
    LIB_HDR   hdr;
} ImgFile;

static ImgFile* img_load(const char *path);

static ImgFile* img_load_try(const char *dir, const char *fname) {
    char path[MAX_PATH];
    char upper[MAX_PATH], lower[MAX_PATH];
    strncpy(upper, fname, MAX_PATH-1); upcase(upper);
    strncpy(lower, fname, MAX_PATH-1);
    for (int i = 0; lower[i]; i++) lower[i] = (char)tolower((unsigned char)lower[i]);

    /* LOADW does NOT fall back to basename when DOS-style path has a directory
     * separator — e.g. "COURT\UGROUND2.IMG" fails entirely in DOSBox. */
    int has_dir_sep = 0;
    for (const char *p = fname; *p; p++) {
        if (*p == '\\' || *p == '/' || *p == ':') { has_dir_sep = 1; break; }
    }
    const char *base = fname;
    for (const char *p = fname; *p; p++) {
        if (*p == '\\' || *p == '/' || *p == ':') base = p + 1;
    }
    char base_upper[MAX_PATH], base_lower[MAX_PATH];
    strncpy(base_upper, base, MAX_PATH-1); upcase(base_upper);
    strncpy(base_lower, base, MAX_PATH-1);
    for (int i = 0; base_lower[i]; i++) base_lower[i] = (char)tolower((unsigned char)base_lower[i]);

    const char *tries[10];
    char p1[MAX_PATH], p2[MAX_PATH], p3[MAX_PATH], p4[MAX_PATH], p5[MAX_PATH], p6[MAX_PATH];
    int n = 0;
    if (dir && dir[0]) {
        path_cat(p1, dir, fname, MAX_PATH);  tries[n++] = p1;
        path_cat(p2, dir, upper, MAX_PATH);  tries[n++] = p2;
        path_cat(p3, dir, lower, MAX_PATH);  tries[n++] = p3;
        if (!has_dir_sep) {
            path_cat(p4, dir, base, MAX_PATH);   tries[n++] = p4;
            path_cat(p5, dir, base_upper, MAX_PATH); tries[n++] = p5;
            path_cat(p6, dir, base_lower, MAX_PATH); tries[n++] = p6;
        }
    }
    tries[n++] = fname;
    tries[n++] = upper;
    tries[n++] = lower;
    if (!has_dir_sep) {
        tries[n++] = base;
        tries[n++] = base_upper;
        tries[n++] = base_lower;
    }
    (void)path;

    for (int i = 0; i < n; i++) {
        ImgFile *img = img_load(tries[i]);
        if (img) return img;
    }
    fprintf(stderr, "WARNING: cannot open %s (tried %d paths)\n", fname, n);
    return NULL;
}

static ImgFile* img_load(const char *path) {
    FILE *f = fopen(path, "rb");
    if (!f) return NULL;

    fseek(f, 0, SEEK_END);
    size_t sz = (size_t)ftell(f);
    fseek(f, 0, SEEK_SET);

    ImgFile *img = (ImgFile*)calloc(1, sizeof(ImgFile));
    img->data = (uint8_t*)malloc(sz);
    if (!img->data) die("out of memory");
    img->size = sz;
    fread(img->data, 1, sz, f);
    fclose(f);
    strncpy(img->path, path, MAX_PATH-1);

    memcpy(&img->hdr, img->data, sizeof(LIB_HDR));

    if (img->hdr.temp != 0xabcd) {
        /* Old pre-WimpV5 format: 42-byte IMG_REC (pack 1).
         * Convert to normalized 50-byte IMG_REC table.
         * Layout: +0 name[16] +16 xoff(sw) +18 yoff(sw) +20 xsize(w) +22 ysize(w)
         *         +24 palind(b) +25 flags(b) +26 oset(dd) +30 data(dd)
         *         +34 lib(sw) +36 pword1(sw) +38 pword2(sw) +40 frame(b) +41 spare(b) */
        int n = img->hdr.imgcnt;
        uint32_t old_oset = img->hdr.oset;
        if (n <= 0 || old_oset + (uint32_t)n * 42 > (uint32_t)sz) {
            fprintf(stderr, "WARNING: %s: old format but table OOB, skipping\n", path);
            free(img->data); free(img); return NULL;
        }
        IMG_REC *norm = (IMG_REC*)calloc(n, sizeof(IMG_REC));
        if (!norm) die("out of memory");
        for (int i = 0; i < n; i++) {
            const uint8_t *o = img->data + old_oset + i * 42;
            IMG_REC *r = &norm[i];
            memcpy(r->name, o, 16);
            r->anix    = (int16_t) (o[16] | (o[17] << 8));
            r->aniy    = (int16_t) (o[18] | (o[19] << 8));
            r->w       = (uint16_t)(o[20] | (o[21] << 8));
            r->h       = (uint16_t)(o[22] | (o[23] << 8));
            r->palnum  = (uint16_t)(o[24]);
            r->flags   = (uint16_t)(o[25]);
            r->oset    = (uint32_t)(o[26]|(o[27]<<8)|(o[28]<<16)|(o[29]<<24));
            r->data_p  = (uint32_t)(o[30]|(o[31]<<8)|(o[32]<<16)|(o[33]<<24));
            r->lib     = (uint16_t)(o[34] | (o[35] << 8));
            r->anix2   = (int16_t) (o[36] | (o[37] << 8));
            r->aniy2   = (int16_t) (o[38] | (o[39] << 8));
            r->frm     = (uint16_t)(o[40]);
            r->pttblnum = -1;
            r->opals    = (uint16_t)0xffff;
        }
        img->norm_images = norm;
        /* Update oset to point past the old records so palette/PAL_REC
         * offsets are computed correctly from the old record table size. */
        img->hdr.oset = old_oset + (uint32_t)n * 42;
        /* Patch hdr so rest of img_load works: adjust oset to skip old records */
        img->hdr.temp    = 0xabcd;
        img->hdr.version = 0x634;
        img->hdr.seqcnt  = 0;
        img->hdr.scrcnt  = 0;
    }

    uint32_t oset = img->hdr.oset;

    int n_special = 0;
    for (int i = 0; i < 10; i++) {
        IMG_REC *rec = (IMG_REC*)(img->data + oset + i * (int)IMG_REC_SIZE);
        if (rec->name[0] == '!') n_special++;
        else break;
    }

    img->n_special = n_special;
    if (img->norm_images)
        img->images = img->norm_images + n_special;
    else
        img->images = (IMG_REC*)(img->data + oset + n_special * IMG_REC_SIZE);
    img->n_images = img->hdr.imgcnt - n_special;

    /* Palette records: stored with 3 defaults prepended */
    uint32_t pal_ofs = oset + (uint32_t)img->hdr.imgcnt * (uint32_t)IMG_REC_SIZE;
    img->pals = (PAL_REC*)(img->data + pal_ofs);
    img->n_palettes = img->hdr.palcnt;

    /* PTTBL offset: after palette records + 6-byte gap + sequences/scripts, minus special records */
    uint32_t pttbl_ofs = pal_ofs + (uint32_t)img->n_palettes * sizeof(PAL_REC) + 6;
    /* SEQSCR entries between palettes and PTTBL */
    int n_seqscr = (int)img->hdr.seqcnt + (int)img->hdr.scrcnt;
    if (n_seqscr > 0) {
        /* SEQSCR struct (pack 2): name[16] + flags(2) + num(2) + entry_t[16](dd=4*16) + startx(2) + starty(2) + dam[6] + spare1(2) + spare2(2) = 98 */
        pttbl_ofs += (uint32_t)n_seqscr * 98;
    }


    /* Compute max PTTBL index */
    int max_pttbl = -1;
    for (int i = 0; i < img->hdr.imgcnt; i++) {
        IMG_REC *rec = (IMG_REC*)(img->data + oset + i * (int)IMG_REC_SIZE);
        if (rec->pttblnum >= 0 && rec->pttblnum > max_pttbl)
            max_pttbl = rec->pttblnum;
    }
    img->n_pttbls = (max_pttbl >= 0) ? max_pttbl + 1 : 0;

    /* Clamp to what fits in the file (allow 2 extra for shared entry access past boundary) */
    int max_fit = (int)((img->size - pttbl_ofs) / sizeof(PTTBL)) + 2;
    if (img->n_pttbls > max_fit) img->n_pttbls = max_fit;
    if (img->n_pttbls > 0)
        img->pttbls = (PTTBL*)(img->data + pttbl_ofs);
    else
        img->pttbls = NULL;

    return img;
}

static uint8_t* img_pixels(ImgFile *img, IMG_REC *rec) {
    if (rec->oset == 0 || rec->oset >= (uint32_t)img->size) return NULL;
    return img->data + rec->oset;
}

static uint16_t* img_pal_colors(ImgFile *img, PAL_REC *pal) {
    if (pal->oset == 0 || pal->oset >= (uint32_t)img->size) return NULL;
    return (uint16_t*)(img->data + pal->oset);
}

/* =========================================================================
 * Pixel analysis
 * ========================================================================= */

static int img_max_pixel(ImgFile *img, IMG_REC *rec) {
    uint8_t *pix = img_pixels(img, rec);
    if (!pix) return 0;
    int stride = IMG_STRIDE(rec->w);
    int max_val = 0;
    for (int y = 0; y < rec->h; y++) {
        for (int x = 0; x < rec->w; x++) {
            int v = pix[y * stride + x];
            if (v > max_val) max_val = v;
        }
    }
    return max_val;
}

static int bpp_for_max(int max_val) {
    if (max_val <= 0) return 1;
    int bpp = 1;
    while ((1 << bpp) <= max_val) bpp++;
    return bpp;
}

/* =========================================================================
 * DMA2 CTRL word computation
 * ========================================================================= */

static int choose_mult(int max_zeros) {
    if (max_zeros <= 15) return 0;
    if (max_zeros <= 30) return 1;
    if (max_zeros <= 60) return 2;
    return 3;
}

static int mult_value(int m) {
    return 1 << m;
}

static uint16_t compute_ctrl(int bpp, int lm, int tm, int cmp) {
    uint16_t pix = (bpp == 8) ? 0 : (uint16_t)bpp;
    uint16_t ctrl = (uint16_t)((pix << 12) | (tm << 10) | (lm << 8) | (cmp ? 0x80 : 0));
    return ctrl;
}

/* =========================================================================
 * Analyze image
 * ========================================================================= */

typedef struct {
    int lm, tm;
    int lm_mult, tm_mult;
    int      sizx, sizy;
    uint16_t ctrl;
    int      ctrl_zero;
    int      running_lead;
    int running_trail;
    int lookahead_lead;
    int lookahead_trail;
} CompParams;

/* Compute content-based SIZX: rightmost non-zero pixel + 1 */
static int compute_content_sizx(ImgFile *img, IMG_REC *rec) {
    uint8_t *pix = img_pixels(img, rec);
    if (!pix) return rec->w;
    int stride = IMG_STRIDE(rec->w);
    int max_x = 0;
    for (int y = 0; y < rec->h; y++) {
        for (int x = rec->w - 1; x >= 0; x--) {
            if (pix[y * stride + x] != 0) {
                if (x > max_x) max_x = x;
                break;
            }
        }
    }
    return max_x + 1;
}

/* Compute content-based SIZY: bottommost non-zero pixel row + 1 */
static int compute_content_sizy(ImgFile *img, IMG_REC *rec) {
    uint8_t *pix = img_pixels(img, rec);
    if (!pix) return rec->h;
    int stride = IMG_STRIDE(rec->w);
    for (int y = rec->h - 1; y >= 0; y--) {
        for (int x = 0; x < rec->w; x++) {
            if (pix[y * stride + x] != 0)
                return y + 1;
        }
    }
    return rec->h;
}

static CompParams analyze_image(ImgFile *img, IMG_REC *rec, int bpp, int pttbl_sizx) {
    int real_bpp = bpp;
    CompParams p;
    memset(&p, 0, sizeof(p));

    p.sizx = pttbl_sizx > 0 ? pttbl_sizx : OUT_STRIDE(rec->w);
    p.sizy = rec->h;
    if (g.xon) { p.sizx = OUT_STRIDE(p.sizx + 1); p.sizy++; }
    if (p.sizx < 1) p.sizx = 1;
    if (p.sizy < 1) p.sizy = 1;
    p.ctrl_zero = (real_bpp & 0x100) ? 1 : 0;
    bpp = real_bpp & 0xff;

    if (!g.zon) {
        p.lm = p.tm = 0;
        p.lm_mult = p.tm_mult = 1;
        p.ctrl = compute_ctrl(bpp, 0, 0, 0);
        if (p.ctrl_zero) p.ctrl &= 0x0fff;
        return p;
    }

    /* FUN_1000_6f20 error-minimizing LM/TM selection.
     * For each row, count lead (120 cap, bVar8) and trail (only after lead finishes).
     * Then accumulate waste per multiplier: waste = sum(mult*lead_n - lead) across rows.
     * Select LM/TM with minimum total waste. */
    uint8_t *pix = img_pixels(img, rec);
    int stride = IMG_STRIDE(rec->w);
     int lead_err[4] = {0}, trail_err[4] = {0};
    int lookahead_lead_min = 999;
    int rows = p.sizy;
    if (rows < 1) rows = 1;
    int la_window = rows < 4 ? rows : 4;
    int sizx = p.sizx;

    for (int y = 0; y < rows; y++) {
        uint8_t *row = (y < rec->h) ? pix + y * stride : NULL;
        int lead = 0, trail = 0, lead_done = 0;

        for (int x = 0; x < sizx; x++) {
            uint8_t px = (row && x < stride) ? row[x] : 0;
            if (!lead_done) {
                if (lead == 120) {
                    lead_done = 1;
                } else if (px == 0) {
                    lead++;
                } else {
                    lead_done = 1;
                }
            } else if (sizx - 120 < x) {
                if (px == 0) trail++;
                else trail = 0;
            }
        }

        for (int m = 0; m < 4; m++) {
            int mult = 1 << m;
            int ln = lead / mult;
            if (ln > 15) ln = 15;
            lead_err[m] += lead - mult * ln;
            int tn = trail / mult;
            if (tn > 15) tn = 15;
            trail_err[m] += trail - mult * tn;
        }

        if (y < la_window && lead < lookahead_lead_min)
            lookahead_lead_min = lead;
    }

    if (lookahead_lead_min == 999) lookahead_lead_min = 0;

    {
        int best_lm = 0;
        for (int m = 1; m < 4; m++)
            if (lead_err[m] < lead_err[best_lm]) best_lm = m;
        int best_tm = 0;
        for (int m = 1; m < 4; m++)
            if (trail_err[m] < trail_err[best_tm]) best_tm = m;
        p.lm = best_lm;
        p.tm = best_tm;
    }
    p.lm_mult = mult_value(p.lm);
    p.tm_mult = mult_value(p.tm);

    p.running_lead = lookahead_lead_min;
    p.running_trail = 0;
    p.lookahead_lead = lookahead_lead_min;
    p.lookahead_trail = 0;

    /* FUN_1000_6f20 space check: if compressed size >= raw size, CMP=0 */
    int raw_bits = sizx * rows * bpp;
    int comp_bits = 0;
    for (int y = 0; y < rows; y++) {
        uint8_t *row = (y < rec->h) ? pix + y * stride : NULL;
        int lead = 0, trail = 0, lead_done = 0;
        for (int x = 0; x < sizx; x++) {
            uint8_t px = (row && x < stride) ? row[x] : 0;
            if (!lead_done) {
                if (lead == 120) { lead_done = 1; }
                else if (px == 0) { lead++; }
                else { lead_done = 1; }
            } else if (sizx - 120 < x) {
                if (px == 0) trail++;
                else trail = 0;
            }
        }
        int lead_n = lead / p.lm_mult;
        if (lead_n > 15) lead_n = 15;
        int lead_c = lead_n * p.lm_mult;
        int trail_n = trail / p.tm_mult;
        if (trail_n > 15) trail_n = 15;
        int trail_c = trail_n * p.tm_mult;
        if (lead_c + trail_c > sizx) trail_c = sizx - lead_c;
        int stored = sizx - lead_c - trail_c;
        if (stored < 0) stored = 0;
        if (stored < 10) {
            int iVar6 = lead_c;
            int iVar7 = sizx - trail_c - 1;
            if ((iVar7 - iVar6) + 1 < 10) {
                int local_2c = (iVar6 - iVar7) + 9;
                int iVar9 = local_2c;
                if (iVar6 < local_2c) {
                    iVar9 = local_2c - iVar6;
                    local_2c = iVar6;
                }
                lead_n = p.lm_mult > 0 ? (lead_c - local_2c) / p.lm_mult : 0;
                if (((iVar7 - (lead_c - local_2c)) + 1) < 10)
                    trail_n = p.tm_mult > 0 ? (trail_c - iVar9) / p.tm_mult : 0;
                lead_c = lead_n * p.lm_mult;
                trail_c = trail_n * p.tm_mult;
                if (lead_c + trail_c > sizx) trail_c = sizx - lead_c;
                stored = sizx - lead_c - trail_c;
                if (stored < 0) stored = 0;
            }
        }
        comp_bits += 8 + stored * bpp;
    }
    int do_cmp = (sizx >= 10 && comp_bits <= raw_bits) ? 1 : 0;
    if (sizx < 10) g.n_small_uncompressed++;

    p.ctrl = compute_ctrl(bpp, p.lm, p.tm, do_cmp);
    if (p.ctrl_zero) p.ctrl &= 0x0fff;  /* zero the bpp nibble, preserve LM/TM/CMP */

    return p;
}

/* =========================================================================
 * Encode one image row to IRW bit stream
 * ========================================================================= */

static void encode_row(uint8_t *row, int w, int sizx, int bpp,
                       int lm_mult, int tm_mult, int *running_lead)
{
    int lim = sizx;
    if (lim < 1) lim = 1;

    int lead = 0, trail = 0, lead_done = 0;
    for (int x = 0; x < lim; x++) {
        uint8_t px = (x < w) ? row[x] : 0;
            if (!lead_done) {
                if (lead == 120) {
                    lead_done = 1;
                } else if (px == 0) {
                    lead++;
                } else {
                    lead_done = 1;
                }
            } else if (sizx - 120 < x) {
                if (px == 0) trail++;
                else trail = 0;
            }
    }

    /* LOADW _packbits: per-row lead, no running minimum.
     * FUN_1000_6f20 second pass computes each row's lead_n directly. */
    int lead_n = lead / lm_mult;
    if (lead_n > 15) lead_n = 15;
    int lead_c = lead_n * lm_mult;
    if (lead_c > sizx) lead_c = sizx;

    int trail_n = trail / tm_mult;
    if (trail_n > 15) trail_n = 15;
    int trail_c = trail_n * tm_mult;
    if (lead_c + trail_c > sizx) trail_c = sizx - lead_c;
    int stored = sizx - lead_c - trail_c;
    if (stored < 0) stored = 0;

    /* FUN_1000_6f20 second pass: minimum 10 stored pixels.
     * Exact algorithm from Ghidra decompilation:
     *   iVar6 = lead_c
     *   iVar7 = sizx - trail_c - 1  (= -1 - (trail_c - sizx))
     *   if ((iVar7 - iVar6) + 1 < 10) { // stored < 10
     *       local_2c = iVar6 - iVar7 + 9  (= need)
     *       iVar9 = local_2c
     *       if (iVar6 < local_2c) { iVar9 = local_2c - iVar6; local_2c = iVar6; }
     *       lead_n = (lead_c - local_2c) / lm_mult
     *       if ((iVar7 - lead_c + local_2c) + 1 < 10)
     *           trail_n = (trail_c - iVar9) / tm_mult
     *   } */
    if (stored < 10) {
        int iVar6 = lead_c;
        int iVar7 = sizx - trail_c - 1;
        if ((iVar7 - iVar6) + 1 < 10) {
            int local_2c = (iVar6 - iVar7) + 9;
            int iVar9 = local_2c;
            if (iVar6 < local_2c) {
                iVar9 = local_2c - iVar6;
                local_2c = iVar6;
            }
            lead_n = lm_mult > 0 ? (lead_c - local_2c) / lm_mult : 0;
            if (((iVar7 - (lead_c - local_2c)) + 1) < 10)
                trail_n = tm_mult > 0 ? (trail_c - iVar9) / tm_mult : 0;
            lead_c = lead_n * lm_mult;
            trail_c = trail_n * tm_mult;
            if (lead_c + trail_c > sizx)
                trail_c = sizx - lead_c;
            stored = sizx - lead_c - trail_c;
            if (stored < 0) stored = 0;
        }
    }

    uint8_t header = (uint8_t)((trail_n << 4) | (lead_n & 0xf));
    irw_write_byte(header);

    for (int i = 0; i < stored; i++) {
        int px_idx = lead_c + i;
        uint8_t px = (px_idx < w) ? row[px_idx] : 0;
        irw_write_bits(px, bpp);
    }
}

static uint8_t zero_row_buf[4096];

/* =========================================================================
 * Encode one image to IRW
 * ========================================================================= */

static uint32_t encode_image(ImgFile *img, IMG_REC *rec, CompParams *cp, int bpp) {
    uint32_t sag = g.irw_bit;
    uint8_t *pix = img_pixels(img, rec);
    int img_stride = IMG_STRIDE(rec->w);
    int sizx = cp->sizx;
    if (sizx < 1) sizx = 1;

    /* LOADW _do_sclpad: create internal buffer with stride = SIZX.
     * Pixel data copied from IMG buffer, zero-padded beyond rec->w. */
    int scl_stride = sizx;
    int rows = cp->sizy;
    if (rows < 1) rows = 1;
    uint8_t *scl_buf = NULL;
    if (g.zon && rows > 0) {
        scl_buf = (uint8_t*)calloc((size_t)scl_stride * rows, 1);
        for (int y = 0; y < rows && y < rec->h; y++) {
            uint8_t *src = pix + y * img_stride;
            uint8_t *dst = scl_buf + y * scl_stride;
            int copy = scl_stride < img_stride ? scl_stride : img_stride;
            memcpy(dst, src, copy);
        }
    }

    int running_lead = cp->lookahead_lead;

    /* Check CMP bit in CTRL: LOADW disables compression (CMP=0) for small images
     * where "Need 10 non-zero pixels minimum" fails. Use raw pixel mode in that case. */
    int do_cmp = (cp->ctrl & 0x80) ? 1 : 0;

    for (int y = 0; y < rows; y++) {
        uint8_t *row = (g.zon && do_cmp) ? scl_buf + y * scl_stride : pix + y * img_stride;
        if (g.zon && do_cmp) {
            encode_row(row, scl_stride, scl_stride, bpp, cp->lm_mult, cp->tm_mult, &running_lead);
        } else {
            int zw = g.pad4bits ? OUT_STRIDE(rec->w) : rec->w;
            if (g.xon && (!g.zon || !do_cmp)) zw = OUT_STRIDE(rec->w + 1);
            if (zw < 1) zw = 1;
            for (int x = 0; x < zw; x++)
                irw_write_bits(x < rec->w ? row[x] : 0, bpp);
        }
    }

    free(scl_buf);
    return sag;
}

/* =========================================================================
 * Encode one scaled-sub-image row to IRW bit stream
 * ========================================================================= */

static uint32_t encode_scaled(ImgFile *img, IMG_REC *rec, int bpp, int denom) {
    int sw = rec->w / denom;
    int sh = rec->h / denom;
    if (sw < 1) sw = 1;
    if (sh < 1) sh = 1;

    int stride = IMG_STRIDE(rec->w);
    uint8_t *pix = img_pixels(img, rec);
    uint8_t *sbuf = (uint8_t*)calloc(sw, 1);
    uint32_t sag = g.irw_bit;

    for (int y = 0; y < sh; y++) {
        int src_y = y * denom;
        uint8_t *src_row = pix + src_y * stride;
        for (int x = 0; x < sw; x++) {
            int src_x = x * denom;
            sbuf[x] = src_row[src_x];
        }
        for (int x = 0; x < sw; x++)
            irw_write_bits(sbuf[x], bpp);
    }
    free(sbuf);
    return sag;
}

/* =========================================================================
 * TBL/PAL/GLO output
 * ========================================================================= */

static void write_tbl_header(FILE *fp) {
    fprintf(fp, "\t.DATA\r\n");
}

static void write_palette(PaletteEntry *pe, ImgFile *img, int palnum, int actual_idx) {
    if (pe->written) return;
    pe->written = 1;

    if (actual_idx < 0 || actual_idx >= img->n_palettes) return;
    PAL_REC *prec = &img->pals[actual_idx];
    uint16_t *colors = img_pal_colors(img, prec);
    if (!colors) return;

    FILE *fp = g.pal_fp;
    if (!fp) return;
    fprintf(fp, "%s:\r\n", pe->name);
    fprintf(fp, "\t.word\t%3d\r\n", pe->numc);

    int per_line = 8;
    for (int i = 0; i < pe->numc; i++) {
        if (i % per_line == 0) fprintf(fp, "\t.word\t");
        uint16_t v = colors[i];
        if (v < 0x10)
            fprintf(fp, "%02XH", v);
        else if (v < 0x100)
            fprintf(fp, "%03XH", v);
        else if (v < 0x1000)
            fprintf(fp, "%04XH", v);
        else
            fprintf(fp, "%05XH", v);
        if (i % per_line == per_line-1 || i == pe->numc-1)
            fprintf(fp, "\r\n");
        else
            fprintf(fp, ",");
    }

    /* Palette file blank line separator between entries */
    if (g.pal_fp)
        fprintf(g.pal_fp, "\r\n");

    if (g.main_glo_fp) {
        fprintf(g.main_glo_fp, "\t.globl\t%s\r\n", pe->name);
    }
}

/* Get the value for an IHDR field for a given scale */
static int get_ihdr_word_value(ImageEntry *ie, int field, int denom) {
    int sanix = ie->anix / denom;
    int saniy = ie->aniy / denom;
    int ssizx = ie->sizx / denom;
    int ssizy = ie->sizy / denom;

    switch (field) {
    case IHDR_SIZX: return ssizx;
    case IHDR_SIZY: return ssizy;
    case IHDR_ANIX: return sanix;
    case IHDR_ANIY: return saniy;
    case IHDR_PWRD1: return ie->pwrd1;
    case IHDR_PWRD2: return ie->pwrd2;
    case IHDR_PWRD3: return ie->pwrd3;
    /* PT IHDR fields: LOADW tries shared PTTBL header fields first, then own entry's
     * box[0]/box[1] fields as fallback (when header fields are all zero). */
    case IHDR_PT0X: { PTTBL *p = ie->pttbl_pt0x ? ie->pttbl_pt0x : ie->pttbl; return p ? (int16_t)((uint16_t)(uint8_t)p->cbox.x | ((uint16_t)(uint8_t)p->cbox.y << 8)) : -1; }
    case IHDR_PT2X: {
        if (ie->pttbl_shared && ie->pttbl_shared->x2) return (int)ie->pttbl_shared->x2;
        if (ie->pttbl) return (int)ie->pttbl->id;
        return -1;
    }
    case IHDR_PT2Y: {
        if (ie->pttbl_shared && ie->pttbl_shared->x3) return (int)ie->pttbl_shared->x3;
        if (ie->pttbl) return (int)(int8_t)ie->pttbl->box[0].x;
        return -1;
    }
    case IHDR_PT3X: {
        if (ie->pttbl_shared && ie->pttbl_shared->X) return (int)ie->pttbl_shared->X;
        if (ie->pttbl) return (int)(int8_t)ie->pttbl->box[0].w;
        return 0;
    }
    case IHDR_PT3Y: {
        if (ie->pttbl_shared && ie->pttbl_shared->Y) return (int)ie->pttbl_shared->Y;
        if (ie->pttbl) return (int)(int8_t)ie->pttbl->box[1].x;
        return 0;
    }
    case IHDR_PT5X: return 0;
    default: return -1;
    }
}

/* Write one image entry to TBL file */
static void write_image_tbl(FILE *fp, ImageEntry *ie) {
    fprintf(fp, "%s:\r\n", ie->name);

    /* Write IHDR fields as specified by IHDR> directive */
    int have_pal = (g.pon && ie->pal_name[0]);
    int word_buf[32];
    int n_words = 0;

    for (int i = 0; i < g.n_ihdr; i++) {
        int f = g.ihdr[i].field;
        FieldSize sz = g.ihdr[i].size;

        if (f == IHDR_PAL && !g.pon) continue;

        if (sz == SZ_L) {
            if (n_words > 0) {
                fprintf(fp, "\t.word   ");
                for (int j = 0; j < n_words; j++) {
                    if (j > 0) fputc(',', fp);
                    fprintf(fp, "%d", word_buf[j]);
                }
                fprintf(fp, "\r\n");
                n_words = 0;
            }
            if (f == IHDR_SAG) {
                uint32_t base = g.base_addr;
                if (g.dual_bank) {
                    /* Dual-bank: bank = (base - 0x2000000) / 0x4000000 */
                    int dbank = g.base_addr >= 0x2000000 ? (int)((g.base_addr - 0x2000000) / 0x4000000) : 0;
                    base += (uint32_t)dbank * 0x2000000;
                }
                fprintf(fp, "\t.long   0%xH\r\n", base + ie->sag);
            } else if (f == IHDR_PAL) {
                if (have_pal)
                    fprintf(fp, "\t.long   %s\r\n", ie->pal_name);
                else
                    fprintf(fp, "\t.long   -1\r\n");
            } else {
                fprintf(fp, "\t.long   -1\r\n");
            }
        } else {
            if (f == IHDR_CTRL) {
                if (n_words > 0) {
                    fprintf(fp, "\t.word   ");
                    for (int j = 0; j < n_words; j++) {
                        if (j > 0) fputc(',', fp);
                        fprintf(fp, "%d", word_buf[j]);
                    }
                    fprintf(fp, "\r\n");
                    n_words = 0;
                }
                fprintf(fp, "\t.word   0%xH\r\n", ie->ctrl);
            } else {
                int val = get_ihdr_word_value(ie, f, 1);
                word_buf[n_words++] = val;
            }
        }
    }

    if (n_words > 0) {
        fprintf(fp, "\t.word   ");
        for (int j = 0; j < n_words; j++) {
            if (j > 0) fputc(',', fp);
            fprintf(fp, "%d", word_buf[j]);
        }
        fprintf(fp, "\r\n");
        n_words = 0;
    }
}

        static void write_global(const char *name) {
     fprintf(g.glo_fp, "\t.%s\t%s\r\n",
             strcmp(name, "ENDMARKER") == 0 ? "global" : "globl", name);
 }

/* =========================================================================
 * LOD parser
 * ========================================================================= */

typedef struct {
    char     imgpath[MAX_PATH];
    ImgFile  *imgfile;
} CurrentImg;

static void parse_ihdr(const char *line) {
    g.n_ihdr = 0;
    const char *p = line + 5;
    while (*p && g.n_ihdr < IHDR_MAX) {
        char fname[32] = {0};
        char fsize[4] = {0};
        int fi = 0, si = 0;
        while (*p && *p != ':') fname[fi++] = (char)toupper((unsigned char)*p++);
        if (*p == ':') p++;
        while (*p && *p != ',' && *p != '\r' && *p != '\n') fsize[si++] = *p++;
        if (*p == ',') p++;

        IhdrField *f = &g.ihdr[g.n_ihdr];
        if (!strcmp(fname, "SIZX")) f->field = IHDR_SIZX;
        else if (!strcmp(fname, "SIZY")) f->field = IHDR_SIZY;
        else if (!strcmp(fname, "SAG"))  f->field = IHDR_SAG;
        else if (!strcmp(fname, "CTRL")) f->field = IHDR_CTRL;
        else if (!strcmp(fname, "ANIX")) f->field = IHDR_ANIX;
        else if (!strcmp(fname, "ANIY")) f->field = IHDR_ANIY;
        else if (!strcmp(fname, "PAL"))  f->field = IHDR_PAL;
        else if (!strcmp(fname, "ALT"))  f->field = IHDR_ALT;
        else if (!strcmp(fname, "PWRD1")) f->field = IHDR_PWRD1;
        else if (!strcmp(fname, "PWRD2")) f->field = IHDR_PWRD2;
        else if (!strcmp(fname, "PWRD3")) f->field = IHDR_PWRD3;
        else if (!strcmp(fname, "PT3Y"))  f->field = IHDR_PT3Y;
        else if (!strncmp(fname, "PT", 2)) {
            int pt_idx = fname[2] - '0';
            int is_y = (fname[3] == 'Y');
            if (pt_idx >= 0 && pt_idx <= 5)
                f->field = IHDR_PT0X + pt_idx * 2 + (is_y ? 1 : 0);
            else
                f->field = IHDR_PT0X;
        }
        else { p++; continue; }

        if (fsize[0] == 'B') f->size = SZ_B;
        else if (fsize[0] == 'L') f->size = SZ_L;
        else f->size = SZ_W;

        g.n_ihdr++;
    }
}

static void parse_addr(const char *line) {
    unsigned long addr = 0, end = 0;
    int bank = 0;
    sscanf(line + 4, "%lx,%lx,%d", &addr, &end, &bank);
    if (addr == 0) sscanf(line + 4, "%lx", &addr);
    g.base_addr = (uint32_t)addr;
    g.end_addr = (uint32_t)end;
    g.bank = bank;
    g.irw_bit = 0;
}

/* Find palette by adjusting for defaults */
static PAL_REC* find_user_palette(ImgFile *img, int stored_palnum) {
    int idx = stored_palnum;
    if (idx >= NUMDEFPAL && idx < img->n_palettes)
        idx -= NUMDEFPAL;
    if (idx < 0 || idx >= img->n_palettes)
        return NULL;
    return &img->pals[idx];
}

static void parse_imglist(const char *line, CurrentImg *cur, int n_scales_override) {
    /* Track image names already processed within the current IMG file.
     * LOADW skips duplicate name references in ---> lines. */
    static char seen_names[4096][MAX_NAME];
    static int n_seen = 0;
    /* Use imgpath (file path string) for identity, not the ImgFile pointer
     * which may be recycled by calloc after free. */
    static char last_imgpath[MAX_PATH] = "";
    if (strcmp(cur->imgpath, last_imgpath) != 0) {
        n_seen = 0;
        strncpy(last_imgpath, cur->imgpath, MAX_PATH-1);
        last_imgpath[MAX_PATH-1] = 0;
    }
    const char *p = line + 5;
    while (*p) {
        while (*p == ' ' || *p == ',') p++;
        if (!*p || *p == '\r' || *p == '\n') break;

        char name[MAX_NAME];
        int ni = 0;
        int scale_n = 2;

        while (*p && *p != ':' && *p != '*' && *p != ',' && *p != '\r' && *p != '\n')
            name[ni++] = *p++;
        name[ni] = 0;

        /* Skip duplicate names (LOADW only processes first occurrence per IMG) */
        int dup = 0;
        for (int si = 0; si < n_seen; si++)
            if (strcmp(seen_names[si], name) == 0) { dup = 1; break; }
        if (!dup && n_seen < 4096) strncpy(seen_names[n_seen++], name, MAX_NAME-1);
        if (dup) {
            while (*p && *p != ',' && *p != '\r' && *p != '\n') p++;
            continue;
        }

        if (*p == ':') { p++; (void)strtol(p, (char**)&p, 16); }
        if (*p == '*') { p++; scale_n = (int)strtol(p, (char**)&p, 10); }
        if (n_scales_override > 0) scale_n = n_scales_override;
        if (g.limit3scales && scale_n > 3) scale_n = 3;

        if (!cur->imgfile) {
            fprintf(stderr, "WARNING: no IMG file loaded for image %s\n", name);
            continue;
        }

        /* Find in image list (skipping special records).
         * Old-format IMG (0x634 from 42-byte conversion): first match wins.
         * New-format IMG: last match wins (LOADW overwrites duplicates). */
        IMG_REC *rec = NULL;
        int img_is_oldfmt = (cur->imgfile->hdr.version == 0x634);
        for (int i = 0; i < cur->imgfile->n_images; i++) {
            char n[MAX_NAME];
            strncpy(n, cur->imgfile->images[i].name, MAX_NAME-1);
            n[MAX_NAME-1] = 0;
            for (int j = 0; j < MAX_NAME; j++) if (!n[j]) break;
             if (strcmp(n, name) == 0) {
                 rec = &cur->imgfile->images[i];
                 if (img_is_oldfmt) break;
             }
         }
         if (!rec) {
             fprintf(stderr, "WARNING: image %s not found in %s\n", name, cur->imgpath);
             continue;
         }

        /* Determine SIZX from PTTBL: SIZX = PTTBL[pttblnum - n_special].BOX[1].W */
        int pttbl_sizx = 0;
        if (rec->pttblnum >= 0 && cur->imgfile->pttbls) {
            if (rec->pttblnum >= 0 && rec->pttblnum < cur->imgfile->n_pttbls) {
                PTTBL *pt = &cur->imgfile->pttbls[rec->pttblnum];
                /* LOADW uses BOX[1].W (= box[0].w) as compression width */
                int bw = pt->box[0].w;
                if (bw > 0 && bw < rec->w)
                    pttbl_sizx = bw;
            }
        }

        int bpp;
        if (g.ppp > 0) {
            bpp = g.ppp;
            /* Check if palette has more colors than 2^bpp can address.
             * LOADW outputs CTRL=0 for bpp in TBL but still compresses using
             * the palette's bitspix (not the forced PP bpp). */
            int bpp_overflow = 0;
            PAL_REC *pal_rec = find_user_palette(cur->imgfile, rec->palnum);
            if (pal_rec && pal_rec->numc > 1 && pal_rec->numc <= 256 &&
                (int)pal_rec->numc > (1 << bpp)) {
                bpp_overflow = 1;
                if (pal_rec->bitspix >= 1 && pal_rec->bitspix <= 8 && pal_rec->bitspix > bpp)
                    bpp = pal_rec->bitspix;  /* use palette bitspix for compression, not forced bpp */
                if (g.verbose)
                    fprintf(stderr, "[%s] Can't fit into %d bits per pixel (palette has %d colors).\n",
                            name, g.ppp, pal_rec->numc);
            }
             /* Auto pixel packing: LOADW only reduces bpp below PPP when PPP=0 (auto mode).
              * When PPP>0 forces a specific bpp, it is never reduced — only the
              * bpp overflow check above applies. */
            if (bpp_overflow) bpp |= 0x100;  /* flag for ctrl_zero */
        } else {
              /* Auto pixel packing: select bpp per image */
              uint8_t *pix = img_pixels(cur->imgfile, rec);
              if (pix) {
                 int pstride = IMG_STRIDE(rec->w);
                  uint32_t maxpx = 0;
                  for (int y = 0; y < rec->h; y++)
                      for (int x = 0; x < rec->w; x++) {
                          uint8_t px = pix[y * pstride + x];
                          if (px > maxpx) maxpx = px;
                      }
                  int per_bpp = bpp_for_max(maxpx);
                  if (per_bpp >= 1 && per_bpp <= 8) bpp = per_bpp;
                  else bpp = g.global_bpp;
                  /* When maxpx exceeds what any reasonable palette can
                   * index (>127, high bit set), the pixel data likely
                   * contains garbage bytes. Cap to palette bitspix. */
                  if (maxpx > 127) {
                      PAL_REC *pal_rec = find_user_palette(cur->imgfile, rec->palnum);
                      if (pal_rec && pal_rec->bitspix >= 1 && pal_rec->bitspix <= 8 &&
                          pal_rec->numc > 1 && pal_rec->numc <= 256 &&
                          (int)maxpx >= (int)pal_rec->numc &&
                          pal_rec->bitspix < bpp) {
                          bpp = pal_rec->bitspix;
                      }
                  }
             } else {
                 bpp = g.global_bpp;
             }
          }
        CompParams cp = analyze_image(cur->imgfile, rec, bpp, pttbl_sizx);

        if (g.n_images >= MAX_IMAGES) die("too many images");
        ImageEntry *ie = &g.images[g.n_images++];
        memset(ie, 0, sizeof(*ie));
        /* Use IMG record name (preserving case) for TBL label */
        {
            char n[MAX_NAME];
            strncpy(n, rec->name, MAX_NAME-1);
            n[MAX_NAME-1] = 0;
            strncpy(ie->name, n, MAX_NAME-1);
        }
        ie->anix = rec->anix;
        ie->aniy = rec->aniy;
        ie->w = OUT_STRIDE(rec->w);
        ie->h = rec->h;
        /* TBL SIZX/SIZY: LOADW outputs rec->w/rec->h (with XON) regardless of PTTBL compression width */
        ie->sizx = OUT_STRIDE(rec->w);
        ie->sizy = rec->h;
        if (g.xon) { ie->sizx = OUT_STRIDE(rec->w + 1); ie->sizy++; }
        if (ie->sizx < 1) ie->sizx = 1;
        if (ie->sizy < 1) ie->sizy = 1;
        ie->ctrl = cp.ctrl;
        if (g.verbose && (strcmp(name, "smfirebone3") == 0 || strcmp(name, "smfirebone6") == 0)) {
            uint8_t *dpix = img_pixels(cur->imgfile, rec);
            int dstride = IMG_STRIDE(rec->w);
            int dsizx = cp.sizx;
            fprintf(stderr, "\nDBG %s: sizx=%d sizy=%d bpp=%d ctrl=0x%04x lm=%d tm=%d\n",
                    name, dsizx, rec->h, bpp, cp.ctrl, cp.lm, cp.tm);
            int dlead_err[4]={0}, dtrail_err[4]={0};
            for (int dy = 0; dy < cp.sizy; dy++) {
                uint8_t *drow = (dy < rec->h) ? dpix + dy * dstride : NULL;
                int dlead=0, dtrail=0, dlead_done=0;
                for (int dx = 0; dx < dsizx; dx++) {
                    uint8_t dpx = (drow && dx < dstride) ? drow[dx] : 0;
                    if (!dlead_done) {
                        if (dlead == 120) dlead_done = 1;
                        else if (dpx == 0) dlead++;
                        else dlead_done = 1;
                    } else if (dsizx - 120 < dx) {
                        if (dpx == 0) dtrail++;
                        else dtrail = 0;
                    }
                }
                for (int dm = 0; dm < 4; dm++) {
                    int dmult = 1 << dm;
                    int dln = dlead / dmult; if (dln > 15) dln = 15;
                    dlead_err[dm] += dlead - dmult * dln;
                    int dtn = dtrail / dmult; if (dtn > 15) dtn = 15;
                    dtrail_err[dm] += dtrail - dmult * dtn;
                }
                if (dy < 3 || dy >= rec->h-1 || (dy >= rec->h && dy < rec->h+2))
                    fprintf(stderr, "  row%3d: lead=%4d trail=%4d\n", dy, dlead, dtrail);
            }
            fprintf(stderr, "  LEAD_ERR: %d %d %d %d\n", dlead_err[0], dlead_err[1], dlead_err[2], dlead_err[3]);
            fprintf(stderr, "  TRAIL_ERR: %d %d %d %d\n", dtrail_err[0], dtrail_err[1], dtrail_err[2], dtrail_err[3]);
            int dblm=0; for(int dm=1;dm<4;dm++) if(dlead_err[dm]<dlead_err[dblm]) dblm=dm;
            int dbtm=0; for(int dm=1;dm<4;dm++) if(!(dtrail_err[dbtm]<=dtrail_err[dm])) dbtm=dm;
            fprintf(stderr, "  best_lm=%d best_tm=%d\n", dblm, dbtm);
        }
        if (g.verbose && strcmp(name, "dcslogo") == 0) {
            uint8_t *pix = img_pixels(cur->imgfile, rec);
            int stride = IMG_STRIDE(rec->w);
            int sizx = cp.sizx;
            fprintf(stderr, "\n=== dcslogo analyse ===\n");
            int lead_err2[4]={0}, trail_err2[4]={0};
            for (int y = 0; y < rec->h && y < 88; y++) {
                uint8_t *row = pix + y * stride;
                int lead=0, trail=0, lead_done=0;
                for (int x=0; x < sizx; x++) {
                    uint8_t px = (x < stride) ? row[x] : 0;
                    if (!lead_done) {
                        if (lead == 120) {lead_done=1;}
                        else if (px==0) lead++;
                        else lead_done=1;
                    } else if (sizx-120 < x) {
                        if (px==0) trail++;
                        else trail=0;
                    }
                }
                for (int m=0;m<4;m++) {
                    int mult=1<<m;
                    int ln = lead/mult; if(ln>15)ln=15;
                    lead_err2[m] += lead - mult*ln;
                    int tn = trail/mult; if(tn>15)tn=15;
                    trail_err2[m] += trail - mult*tn;
                }
                fprintf(stderr, "row%3d: lead=%4d trail=%4d\n", y, lead, trail);
            }
            fprintf(stderr, "lead_err: %d %d %d %d\n", lead_err2[0],lead_err2[1],lead_err2[2],lead_err2[3]);
            fprintf(stderr, "trail_err: %d %d %d %d\n", trail_err2[0],trail_err2[1],trail_err2[2],trail_err2[3]);
            int best_lm=0;
            for(int m=1;m<4;m++) if(lead_err2[m] < lead_err2[best_lm]) best_lm=m;
            int best_tm=0;
            for(int m=1;m<4;m++) if(trail_err2[m] < trail_err2[best_tm]) best_tm=m;
            fprintf(stderr, "best_lm=%d best_tm=%d\n", best_lm, best_tm);
        }
        ie->n_scales = scale_n;
        ie->pwrd1 = rec->anix2;
        ie->pwrd2 = rec->aniy2;
        ie->pwrd3 = rec->aniz2;
        ie->pt3y = 0;

        /* PT pairs from PTTBL fields or computed from box geometry.
         * PTTBL entries are 12 bytes: three PTBOXes (box[0], box[1], box[2]).
         * LOADW interprets the 12 bytes as 6 int16 fields (x1..z_anipt3)
         * when non-zero, or falls back to box geometry when x1==x2==0.
         * PTTBL index = pttblnum (not adjusted by n_special — the PTTBL
         * array includes entries for all IMG records including !-prefixed). */
        /* Set PTTBL pointers: own entry, shared entries for PT2 and PT0 fields.
          * LOADW allows shared entries even when the own entry is out of bounds
          * (e.g. PTTBL count doesn't include trailing entries past file limit). */
          if (cur->imgfile->pttbls) {
              if (rec->pttblnum >= 0 && rec->pttblnum < cur->imgfile->n_pttbls) {
                  ie->pttbl = &cur->imgfile->pttbls[rec->pttblnum];
              }
              if (rec->pttblnum >= 2 && rec->pttblnum - 2 < cur->imgfile->n_pttbls) {
                  ie->pttbl_shared = &cur->imgfile->pttbls[rec->pttblnum - 2];
              }
              if (rec->pttblnum >= 3 && rec->pttblnum - 3 < cur->imgfile->n_pttbls) {
                  ie->pttbl_pt0x = &cur->imgfile->pttbls[rec->pttblnum - 3];
              }
              if (!ie->pttbl_pt0x) ie->pttbl_pt0x = ie->pttbl_shared ? ie->pttbl_shared : ie->pttbl;
          }
        if (ie->pttbl) {
            PTTBL *pt = ie->pttbl;
            PTTBL *pt0 = cur->imgfile->pttbls ? &cur->imgfile->pttbls[0] : NULL;
            /* Read stored PT fields from PTTBL header fields */
                int16_t px1 = pt->x1;
                int16_t px2 = pt->x2;
                int16_t px3 = pt->x3;
                int16_t pax3 = pt->X;
                int16_t pay3 = pt->Y;
                int16_t paz3 = pt->Z;
                
                ie->extra_pts[0] = px1;
                ie->extra_pts[1] = px2;
                ie->extra_pts[2] = px3;
                ie->extra_pts[3] = pax3;
                ie->extra_pts[4] = pay3;
                ie->extra_pts[5] = paz3;
                ie->extra_pts[6] = 0;
                ie->extra_pts[7] = 0;
                ie->n_extra_pts = 6;
                
                /* If stored fields are zero, compute 4 PT pairs from geometry */
                if (px1 == 0 && px2 == 0) {
                    /* PT1 from CBOX */
                    ie->extra_pts[0] = (int)(int8_t)pt->cbox.x - ie->anix + pt->cbox.w;
                    ie->extra_pts[1] = (int)(int8_t)pt->cbox.y - ie->aniy + pt->cbox.h;
                    
                    /* PT2 from shared PTTBL[0] (!STAND2):
                       (BOX[1].W + CBOX.W - CBOX.H - 1, BOX[1].Y - CBOX.W - 1) */
                    ie->extra_pts[2] = pt0->box[0].w + pt0->cbox.w - pt0->cbox.h - 1;
                    ie->extra_pts[3] = pt0->box[0].y - pt0->cbox.w - 1;
                    
                    /* PT3 = (BOX[2].X + 1, ANIY - BOX[1].H + shared_CBOX.H) */
                    ie->extra_pts[4] = pt->box[1].x + 1;
                    ie->extra_pts[5] = ie->aniy - pt->box[0].h + pt0->cbox.h;
                    
                    /* PT4 = (ANIX - BOX[1].W, ANIY - BOX[1].H) */
                    ie->extra_pts[6] = ie->anix - pt->box[0].w;
                    ie->extra_pts[7] = ie->aniy - pt->box[0].h;
                    
                    ie->n_extra_pts = 8;
                }
            }

        /* Palette: stored palnum includes 3 defaults */
        PAL_REC *prec = find_user_palette(cur->imgfile, rec->palnum);
        if (prec && g.pon) {
            char pname[PAL_NAME_LEN+1];
            strncpy(pname, prec->name, PAL_NAME_LEN);
            pname[PAL_NAME_LEN] = 0;
            for (int j = PAL_NAME_LEN-1; j >= 0; j--) {
                if (!isprint((unsigned char)pname[j]) || pname[j] == ' ') pname[j] = 0;
                else break;
            }
            if (pname[0]) {
                strncpy(ie->pal_name, pname, PAL_NAME_LEN-1);
                int found = 0;
                for (int pi = 0; pi < g.n_palettes; pi++) {
                    if (!strcmp(g.palettes[pi].name, pname)) { found = 1; break; }
                }
                if (!found && g.n_palettes < MAX_PALETTES) {
                    PaletteEntry *pe = &g.palettes[g.n_palettes++];
                    memset(pe, 0, sizeof(*pe));
                    strncpy(pe->name, pname, PAL_NAME_LEN-1);
                    pe->numc = prec->numc;
                    pe->bitspix = prec->bitspix;
                    uint16_t *cols = img_pal_colors(cur->imgfile, prec);
                    if (cols && pe->numc > 0) {
                        pe->colors = (uint16_t*)malloc(pe->numc * sizeof(uint16_t));
                        memcpy(pe->colors, cols, pe->numc * sizeof(uint16_t));
                    }
                    int pal_actual = rec->palnum;
                    if (pal_actual >= NUMDEFPAL && pal_actual < cur->imgfile->n_palettes)
                        pal_actual -= NUMDEFPAL;
                    write_palette(pe, cur->imgfile, rec->palnum, pal_actual);
                }
            }
        }

         /* CON> dedup: check if identical image already encoded */
        int dedup_idx = -1;
        if (g.dedup) {
            uint8_t *pix_data = img_pixels(cur->imgfile, rec);
            int pstride = (rec->w + 3) & ~3;
            uint16_t max_val;
            uint16_t ck = loadw_checksum(pix_data, pstride, rec->w, rec->h, &max_val);
            if (g.verbose && (strcmp(name, "smfirebone3") == 0 || strcmp(name, "smfirebone6") == 0 ||
                              rec->w == 8 || rec->h == 21))
                fprintf(stderr, "DEDUP_CHK %s: ck=%u max=%u sizx=%d sizy=%d ctrl=0x%04x\n",
                        name, ck, max_val, cp.sizx, cp.sizy, cp.ctrl);
            for (int di = 0; di < n_dedup; di++) {
                if (dedup_table[di].sum == ck && dedup_table[di].max_val == max_val &&
                    dedup_table[di].sizx == cp.sizx && dedup_table[di].sizy == cp.sizy &&
                    dedup_table[di].ctrl == cp.ctrl) {
                    dedup_idx = di; break;
                }
            }
            if (g.verbose && dedup_idx >= 0 && (strcmp(name, "smfirebone3") == 0 || strcmp(name, "smfirebone6") == 0))
                fprintf(stderr, "DEDUP_HIT %s: matched table[%d] sag=0x%x\n", name, dedup_idx, dedup_table[dedup_idx].sag);
        }

        if (dedup_idx >= 0) {
            ie->sag = dedup_table[dedup_idx].sag;
            if (g.verbose)
                printf("  Checksum match on image [%s].\n", name);
        } else {
            ie->sag = encode_image(cur->imgfile, rec, &cp, bpp & 0xff);
             if (g.dedup && n_dedup < MAX_DEDUP) {
                uint8_t *pix_data = img_pixels(cur->imgfile, rec);
                int pstride = IMG_STRIDE(rec->w);
                uint16_t max_val;
                dedup_table[n_dedup].sum = loadw_checksum(pix_data, pstride, rec->w, rec->h, &max_val);
                dedup_table[n_dedup].max_val = max_val;
                dedup_table[n_dedup].sizx = cp.sizx;
                dedup_table[n_dedup].sizy = cp.sizy;
                dedup_table[n_dedup].ctrl = cp.ctrl;
                dedup_table[n_dedup].sag = ie->sag;
                dedup_table[n_dedup].sag_idx = -1;
                n_dedup++;
            }
        }
        ie->scale_sags[0] = ie->sag;
        ie->scale_ctrls[0] = cp.ctrl;
        for (int s = 1; s < scale_n; s++) {
            ie->scale_sags[s] = ie->sag;
            ie->scale_ctrls[s] = cp.ctrl;
        }

          if (g.build_tables && g.asm_fp)
              write_image_tbl(g.asm_fp, ie);

         /* Only write .globl for ENDMARKER and special symbols, not every image */
         if (g.glo_fp && strcmp(name, "ENDMARKER") == 0)
            write_global(name);
    }
}

/* Scan all images to determine global bpp */
static void scan_bpp(const char *lod_path) {
    FILE *f = fopen(lod_path, "r");
    if (!f) die("cannot open LOD file: %s", lod_path);

    char line[1024];
    char imgdir[MAX_PATH];
    strncpy(imgdir, g.imgdir, MAX_PATH-1);
    CurrentImg cur;
    memset(&cur, 0, sizeof(cur));

    g.global_max_pixel = 0;
    int saved_ppp = g.ppp;

    while (fgets(line, sizeof(line), f)) {
        str_trim(line);
        if (!line[0] || line[0] == ';' || line[0] == '/') continue;

        char upper[1024];
        strncpy(upper, line, sizeof(upper)-1);
        upcase(upper);

        if (!strncmp(upper, "PPP>", 4)) {
            g.ppp = atoi(line + 4);
        }
        else if (strstr(upper, ".IMG")) {
            char fname[MAX_PATH];
            sscanf(line, "%s", fname);
            if (cur.imgfile) { free(cur.imgfile->norm_images); free(cur.imgfile->data); free(cur.imgfile); }
            cur.imgfile = img_load_try(imgdir, fname);
        }
        else if (!strncmp(upper, "--->", 4) && cur.imgfile) {
            const char *s = line + 5;
            while (*s) {
                while (*s == ' ' || *s == ',') s++;
                if (!*s || *s == '\r' || *s == '\n') break;
                char nm[MAX_NAME]; int ni = 0;
                while (*s && *s != ':' && *s != '*' && *s != ',' && *s != '\r' && *s != '\n')
                    nm[ni++] = (char)toupper((unsigned char)*s++);
                nm[ni] = 0;
                if (*s == ':') while (*s && *s != ',' && *s != '*') s++;
                if (*s == '*') { s++; while (*s >= '0' && *s <= '9') s++; }
                for (int i = 0; i < cur.imgfile->n_images; i++) {
                    char n[MAX_NAME];
                    strncpy(n, cur.imgfile->images[i].name, MAX_NAME-1);
                    n[MAX_NAME-1] = 0;
                    for (int j = 0; j < MAX_NAME; j++) if (!n[j]) break;
                    if (strcmp(n, nm) == 0) {
                        int mv = img_max_pixel(cur.imgfile, &cur.imgfile->images[i]);
                        if (mv > g.global_max_pixel) g.global_max_pixel = mv;
                        break;
                    }
                }
            }
        }
    }
    fclose(f);
    if (cur.imgfile) { free(cur.imgfile->norm_images); free(cur.imgfile->data); free(cur.imgfile); }

    g.ppp = saved_ppp;

    if (g.ppp > 0)
        g.global_bpp = g.ppp;
    else {
        g.global_bpp = bpp_for_max(g.global_max_pixel);
        if (g.global_bpp < 1) g.global_bpp = 1;
        if (g.global_bpp > 8) g.global_bpp = 8;
    }

    if (g.verbose)
        printf("Global max pixel=%d, bpp=%d\n", g.global_max_pixel, g.global_bpp);
}

/* Main LOD processing pass */
static void process_lod(const char *lod_path) {
    FILE *f = fopen(lod_path, "r");
    if (!f) die("cannot open LOD file: %s", lod_path);

    char line[1024];
    CurrentImg cur;
    memset(&cur, 0, sizeof(cur));

    parse_ihdr("IHDR SIZX:W,SIZY:W,ANIX:W,ANIY:W,SAG:L,CTRL:W,PAL:L,PWRD1:W,PWRD2:W,PWRD3:W,PT3Y:W");

    while (fgets(line, sizeof(line), f)) {
        str_trim(line);
        if (!line[0] || line[0] == ';' || line[0] == '/') continue;

        char upper[1024];
        strncpy(upper, line, sizeof(upper)-1);
        upcase(upper);

        if (!strncmp(upper, "ASM>", 4)) {
            char fname[MAX_PATH];
            sscanf(line + 4, " %255s", fname);
            char *comma = strchr(fname, ',');
            if (comma) *comma = 0;
            upcase(fname);  /* DOS filenames are case-insensitive */
              if (g.build_tables) {
                 char full[MAX_PATH];
                 if (g.tbldir[0]) path_cat(full, g.tbldir, fname, MAX_PATH);
                 else strncpy(full, fname, MAX_PATH-1);
                 /* Check if same file — LOADW appends without .DATA/.TEXT separators */
                 if (g.asm_fp) {
                     /* Simple filename comparison */
                     if (strcmp(g.asm_path, full) != 0) {
                         /* Different file: close old WITHOUT trailer (written at end) */
                         fclose(g.asm_fp);
                         g.asm_fp = NULL;
                     }
                 }
                 if (!g.asm_fp) {
                     g.asm_fp = fopen(full, "a");
                     if (!g.asm_fp) die("cannot create %s", full);
                     strncpy(g.asm_path, full, MAX_PATH-1);
                     fseek(g.asm_fp, 0, SEEK_END);
                     if (ftell(g.asm_fp) == 0)
                         write_tbl_header(g.asm_fp);
                     /* Track file for final .TEXT write */
                     if (g.n_tbl_files < 32) {
                         int found = 0;
                         for (int ft = 0; ft < g.n_tbl_files; ft++)
                             if (strcmp(g.tbl_files[ft], full) == 0) { found = 1; break; }
                         if (!found)
                             strncpy(g.tbl_files[g.n_tbl_files++], full, MAX_PATH-1);
                     }
                 }
             }
        }
        else if (!strncmp(upper, "GLO>", 4)) {
            char fname[MAX_PATH];
            sscanf(line + 4, " %255s", fname);
            if (g.build_tables) {
                if (g.glo_fp) fclose(g.glo_fp);
                char full[MAX_PATH];
                if (g.tbldir[0]) path_cat(full, g.tbldir, fname, MAX_PATH);
                else strncpy(full, fname, MAX_PATH-1);
                g.glo_fp = fopen(full, "a");
                if (!g.glo_fp) die("cannot create %s", full);
                /* Track GLO filename for IMGTBL.ASM generation */
                if (g.n_glo_files < 64) {
                    strncpy(g.glo_files[g.n_glo_files], fname, 63);
                    g.glo_files[g.n_glo_files][63] = 0;
                    g.n_glo_files++;
                }
            }
        }
        else if (!strncmp(upper, "***>", 4)) parse_addr(line);
        else if (!strncmp(upper, "IHDR", 4)) parse_ihdr(line);
        else if (!strncmp(upper, "ZON>", 4)) g.zon = 1;
        else if (!strncmp(upper, "ZOF>", 4)) g.zon = 0;
        else if (!strncmp(upper, "PON>", 4)) g.pon = 1;
        else if (!strncmp(upper, "POF>", 4)) g.pon = 0;
        else if (!strncmp(upper, "XON>", 4)) g.xon = 1;
        else if (!strncmp(upper, "XOF>", 4)) g.xon = 0;
        else if (!strncmp(upper, "CON>", 4)) g.dedup = 1;
        else if (!strncmp(upper, "COF>", 4)) g.dedup = 0;
        else if (!strncmp(upper, "PPP>", 4)) g.ppp = atoi(line+4);
        else if (!strncmp(upper, "FRM>", 4)) {
            char fname[MAX_PATH];
            sscanf(line + 4, " %255s", fname);
            /* Try locating the .BIN file */
            char binpath[MAX_PATH];
            FILE *bf = NULL;
            if (g.imgdir[0]) {
                snprintf(binpath, MAX_PATH, "%s%c%s.BIN", g.imgdir, PATH_SEP, fname);
                bf = fopen(binpath, "rb");
            }
            if (!bf) {
                snprintf(binpath, MAX_PATH, "%s.BIN", fname);
                bf = fopen(binpath, "rb");
            }
            if (bf) {
                fseek(bf, 0, SEEK_END);
                long bsz = ftell(bf);
                fseek(bf, 0, SEEK_SET);
                /* FRM files always start on an even byte address (word-aligned).
                 * First byte-align, then word-align to even byte boundary. */
                if (g.irw_bit & 7) irw_write_bits(0, 8 - (g.irw_bit & 7));
                if ((g.irw_bit / 8) & 1) irw_write_byte(0);
                if (g.build_tables && g.asm_fp) {
                    fprintf(g.asm_fp, "%s\t.set\t0%xh\r\n", fname, g.base_addr + g.irw_bit);
                }
                if (g.glo_fp) {
                    fprintf(g.glo_fp, "\t.globl\t%s\r\n", fname);
                }
                uint32_t sag = g.irw_bit;
                uint8_t *buf = (uint8_t*)malloc(bsz);
                if (buf) {
                    fread(buf, 1, bsz, bf);
                    for (long i = 0; i < bsz; i++)
                        irw_write_byte(buf[i]);
                    free(buf);
                }
                fclose(bf);
                /* LOADW word-aligns FRM entries: pad to even byte after data if odd */
                if ((g.irw_bit / 8) & 1) irw_write_byte(0);
                if (g.verbose)
                    printf("  FRM %s at bit %u (%ld bytes)\n", fname, sag, bsz);
            } else {
                fprintf(stderr, "WARNING: cannot open .BIN file: %s.BIN\n", fname);
            }
        }
                else if (!strncmp(upper, "BBB>", 4)) {
            char bgname[MAX_PATH];
            sscanf(line + 4, " %255s", bgname);
            const char *base = bgname;
            for (const char *p = bgname; *p; p++)
                if (*p == '\\' || *p == '/' || *p == ':') base = p + 1;
            if (!base[0]) continue;

            if (g.build_tables && !g.bgnd_fp) {
                g.bgnd_fp = fopen("BGNDTBL.ASM", "w");
                if (g.bgnd_fp) {
                    fprintf(g.bgnd_fp, "\t.OPTION\tB,D,L,T\r\n");
                    fprintf(g.bgnd_fp, "\t.include\t\"BGNDTBL.GLO\"\r\n");
                    fprintf(g.bgnd_fp, "\t.DATA\r\n\r\n");
                }
                g.bgndpal_fp = fopen("BGNDPAL.ASM", "w");
                if (g.bgndpal_fp) {
                    fprintf(g.bgndpal_fp, "\t.OPTION\tB,D,L,T\r\n");
                    fprintf(g.bgndpal_fp, "\t.include\t\"BGNDTBL.GLO\"\r\n");
                    fprintf(g.bgndpal_fp, "\t.DATA\r\n\r\n");
                }
                g.bgndequ_fp = fopen("BGNDEQU.H", "w");
                g.bgndtbl_glo_fp = fopen("BGNDTBL.GLO", "w");
            }

            char bdb_path[MAX_PATH], bdd_path[MAX_PATH];
            FILE *bdb_f = NULL, *bdd_f = NULL;
            const char *dirs[] = { g.imgdir, "." };
            for (int di = 0; di < 2 && !bdb_f; di++) {
                if (!dirs[di][0]) continue;
                snprintf(bdb_path, MAX_PATH, "%s%c%s.BDB", dirs[di], PATH_SEP, base);
                bdb_f = fopen(bdb_path, "rb");
            }
            for (int di = 0; di < 2 && !bdd_f; di++) {
                if (!dirs[di][0]) continue;
                snprintf(bdd_path, MAX_PATH, "%s%c%s.BDD", dirs[di], PATH_SEP, base);
                bdd_f = fopen(bdd_path, "rb");
            }
            if (!bdb_f) { fprintf(stderr, "WARNING: cannot open %s.BDB\n", base); continue; }
            if (!bdd_f) { fclose(bdb_f); fprintf(stderr, "WARNING: cannot open %s.BDD\n", base); continue; }

            char bdb_buf[65536];
            size_t bdb_len = fread(bdb_buf, 1, sizeof(bdb_buf)-1, bdb_f);
            bdb_buf[bdb_len] = 0;
            fclose(bdb_f);

            fseek(bdd_f, 0, SEEK_END);
            long bdd_sz = ftell(bdd_f);
            fseek(bdd_f, 0, SEEK_SET);
            uint8_t *bdd_data = (uint8_t*)malloc(bdd_sz);
            if (!bdd_data) { fclose(bdd_f); continue; }
            fread(bdd_data, 1, bdd_sz, bdd_f);
            fclose(bdd_f);

            char *bp = bdb_buf;
            while (*bp == '\r' || *bp == '\n') bp++;
            char *nl = strchr(bp, '\n');
            if (!nl) { free(bdd_data); continue; }
            *nl = 0;
            char bdb_name[64]; int bdb_w = 0, bdb_h = 0;
            int bdb_md = 0, bdb_nm = 0, bdb_np = 0, bdb_no = 0;
            sscanf(bp, "%63s %d %d %d %d %d %d", bdb_name, &bdb_w, &bdb_h,
                   &bdb_md, &bdb_nm, &bdb_np, &bdb_no);
            bp = nl + 1;

            /* HDRS label: last 2 chars of BDB header name + "HDRS" */
            int bdb_nlen = (int)strlen(bdb_name);
            /* HDRS/PALS suffix: chars from index 4 to end of padded 8-char DOS name,
             * trimmed of trailing spaces. "NUPOOL" → "OL", "TOMB" → "", "FOREST2" → "st2". */
            char bdb8[9]; int idx;
            for (idx = 0; idx < 8 && idx < bdb_nlen; idx++) bdb8[idx] = bdb_name[idx];
            while (idx < 8) bdb8[idx++] = ' ';
            bdb8[8] = 0;
            char hdr_buf[8]; int hi = 0;
            for (int ci = 4; ci < 8; ci++)
                if (bdb8[ci] != ' ') hdr_buf[hi++] = bdb8[ci];
            hdr_buf[hi] = 0;
             const char *hdr_suffix = hdr_buf;
            char cur_hdrs[64] = "";
            if (g.bgnd_fp) {
                snprintf(cur_hdrs, sizeof(cur_hdrs), "%sHDRS", hdr_suffix);
                fprintf(g.bgnd_fp, "%s:\r\n", cur_hdrs);
            }
            if (g.bgndtbl_glo_fp) {
                fprintf(g.bgndtbl_glo_fp, "\t.globl\t%sPALS\r\n", hdr_suffix);
            }

#define MAX_GLOBJ 4096
            struct { char name[64]; int is_mod; int wx, dp, sy, ii, fl; } gobjs[MAX_GLOBJ];
            int ng = 0;
            char cur_mod[64] = "";

            while (*bp && ng < MAX_GLOBJ) {
                while (*bp == '\r' || *bp == '\n') { bp++; if (!*bp) break; }
                if (!*bp) break;
                char *eol = strchr(bp, '\n');
                if (!eol) eol = bp + strlen(bp);
                char tmp[256]; int tlen = (int)(eol - bp);
                if (tlen > 255) tlen = 255;
                memcpy(tmp, bp, tlen); tmp[tlen] = 0;

                int wx_t, dp_t, sy_t, ii_t, fl_t; char modname[64];
                /* Image line = 5 fields, first hex, ii hex (same convention as BDD idx) */
                if (sscanf(tmp, "%x %d %d %x %d", &wx_t, &dp_t, &sy_t, &ii_t, &fl_t) == 5) {
                    strncpy(gobjs[ng].name, cur_mod, 63);
                    gobjs[ng].is_mod = 0;
                    gobjs[ng].wx = wx_t; gobjs[ng].dp = dp_t; gobjs[ng].sy = sy_t;
                    gobjs[ng].ii = ii_t; gobjs[ng].fl = fl_t; ng++;
                } else if (sscanf(tmp, "%63s", modname) == 1) {
                    char *endp = modname;
                    strtol(modname, &endp, 16);
                    int is_hex = (*endp == 0 && endp > modname);
                    if (!is_hex) {
                        strncpy(cur_mod, modname, 63);
                        strncpy(gobjs[ng].name, modname, 63);
                        gobjs[ng].is_mod = 1;
                        /* Module params: NAME w x y z (all decimal in BDB) */
                        int wxt, dpt, syt, iit;
                        if (sscanf(tmp, "%*s %d %d %d %d", &wxt, &dpt, &syt, &iit) >= 4) {
                            gobjs[ng].wx = wxt; gobjs[ng].dp = dpt;
                            gobjs[ng].sy = syt; gobjs[ng].ii = iit;
                        }
                        ng++;
                    }
                }
                bp = *eol ? eol + 1 : eol;
            }

            /* Byte-level BDD parser */
            long bdp = 0;
            while (bdp < bdd_sz && bdd_data[bdp] != 0x0a && bdd_data[bdp] != 0x0d) bdp++;
            int n_bdd = atoi((char*)bdd_data);
            while (bdp < bdd_sz && (bdd_data[bdp] == 0x0a || bdd_data[bdp] == 0x0d)) bdp++;

            struct { int idx, w, h, fl; uint8_t *pix; } bdds[256];
            int n_bdds = 0;
            for (int i = 0; i < n_bdd && n_bdds < 256; i++) {
                long hs = bdp;
                while (bdp < bdd_sz && bdd_data[bdp] != 0x0a && bdd_data[bdp] != 0x0d) bdp++;
                char hl[128]; int hlen = (int)(bdp - hs);
                if (hlen > 127) hlen = 127; memcpy(hl, bdd_data + hs, hlen); hl[hlen] = 0;
                /* skip line ending: handle both \n and \r\n */
                if (bdp < bdd_sz && bdd_data[bdp] == 0x0d) { bdp++; if (bdp < bdd_sz && bdd_data[bdp] == 0x0a) bdp++; }
                else if (bdp < bdd_sz && bdd_data[bdp] == 0x0a) bdp++;
                int idx = 0, w = 0, h = 0, f = 0;
                int nf = sscanf(hl, "%x %d %d %d", &idx, &w, &h, &f);
                if (nf < 4 || w <= 0 || h <= 0) { bdp = hs; break; } /* end of image data, restore bdp */
                if (w > 4096 || h > 4096 || bdp + w * h > bdd_sz) {
                    if (g.verbose) printf("  BDD skip: idx=%x w=%d h=%d pix=%d bdp=%ld sz=%ld\n", idx, w, h, w*h, bdp, bdd_sz);
                    continue;
                }
                bdds[n_bdds].idx = idx; bdds[n_bdds].w = w; bdds[n_bdds].h = h;
                bdds[n_bdds].fl = f; bdds[n_bdds].pix = (w > 0 && h > 0) ? bdd_data + bdp : NULL;
                n_bdds++; bdp += (w * h > 0) ? w * h : 0;
            }

            /* Palettes */
            struct { char name[64]; int cnt; uint16_t *colors; } pals[64];
            int np = 0;
            while (bdp < bdd_sz && np < 64) {
                while (bdp < bdd_sz && (bdd_data[bdp] == 0x0a || bdd_data[bdp] == 0x0d)) bdp++;
                if (bdp >= bdd_sz) break;
                long ns = bdp;
                while (bdp < bdd_sz && bdd_data[bdp] != 0x0a && bdd_data[bdp] != 0x0d && bdd_data[bdp] != 0x20) bdp++;
                long ne = bdp;
                if (bdp < bdd_sz && bdd_data[bdp] == 0x20) bdp++;
                long cs = bdp;
                while (bdp < bdd_sz && bdd_data[bdp] != 0x0a && bdd_data[bdp] != 0x0d) bdp++;
                char cs2[32]; int cl2 = (int)(bdp - cs);
                if (cl2 > 31) cl2 = 31; memcpy(cs2, bdd_data + cs, cl2); cs2[cl2] = 0;
                while (bdp < bdd_sz && (bdd_data[bdp] == 0x0a || bdd_data[bdp] == 0x0d)) bdp++;
                int cnt = atoi(cs2);
                if (cnt <= 0 || cnt > 256 || bdp + cnt * 2 > bdd_sz) break;
                int nlen = (int)(ne - ns); if (nlen > 63) nlen = 63;
                memcpy(pals[np].name, bdd_data + ns, nlen); pals[np].name[nlen] = 0;
                pals[np].cnt = cnt; pals[np].colors = (uint16_t*)(bdd_data + bdp);
                np++; bdp += cnt * 2;
            }

            int img_written[256] = {0};
            uint32_t img_sags[256] = {0};
            int img_lm[256] = {0}, img_tm[256] = {0}, img_bpp[256] = {0}, img_cmp[256] = {0};
            char bmod_list[64][64];
            int n_bmod = 0, mod_obj_count[64] = {0};
            int img_module[256]; /* which module index owns each BDD image */
            for (int i = 0; i < 256; i++) img_module[i] = -1;
            for (int mi = 0; mi < 64; mi++) mod_obj_count[mi] = 0;
            int mod_ds[64], mod_de[64], mod_ys[64], mod_ye[64]; /* module depth/sy ranges */
            int mod_first_depth[64]; /* depth of first object in BDB file order */
            for (int i = 0; i < 64; i++) mod_first_depth[i] = -1;

            /* Phase 1: Output module BLKS labels and build module list */
            for (int gi = 0; gi < ng; gi++) {
                if (gobjs[gi].is_mod) {
                    const char *mn = gobjs[gi].name;
                    if (n_bmod < 64) {
                        strncpy(bmod_list[n_bmod], mn, 63);
                        mod_ds[n_bmod] = gobjs[gi].wx;
                        mod_de[n_bmod] = gobjs[gi].dp;
                        mod_ys[n_bmod] = gobjs[gi].sy;
                        mod_ye[n_bmod] = gobjs[gi].ii;
                        n_bmod++;
                    }
                    continue;
                }
                /* Assign object to module by depth/sy range */
                int obj_ds = gobjs[gi].dp, obj_sy = gobjs[gi].sy;
                int mi = n_bmod; /* default: no match */
                for (int mj = 0; mj < n_bmod; mj++)
                    if (obj_ds >= mod_ds[mj] && obj_ds <= mod_de[mj] &&
                        obj_sy >= mod_ys[mj] && obj_sy <= mod_ye[mj])
                        { mi = mj; mod_obj_count[mj]++; break; }
                /* Track first object depth per module (BDB file order) */
                if (mi < n_bmod && mod_first_depth[mi] < 0)
                    mod_first_depth[mi] = obj_ds;
                /* Map each BDD image to its module via first-referencing GOBJ */
                int ii = gobjs[gi].ii;
                for (int di = 0; di < n_bdds; di++) {
                    if (bdds[di].idx == ii && img_module[di] < 0) {
                        if (mi < n_bmod) img_module[di] = mi;
                        break;
                    }
                }
            }

            /* Phase 2: Process BDD images in FILE ORDER (only GOBJ-referenced) */
            int bgnd_count = 0;
            for (int di = 0; di < n_bdds; di++) {
                if (img_module[di] < 0) continue;
                 bgnd_count++;

                 int w = bdds[di].w, h = bdds[di].h;
                 uint8_t *pix = bdds[di].pix;
                 int sizx_a = ((w + 3) & ~3) > 0 ? ((w + 3) & ~3) : 1;
                 int mod_i = img_module[di]; /* -1 if unreferenced */
                 int bg_dedup_idx = -1;

                  if (!img_written[di]) {
                      img_written[di] = 1;
                      img_sags[di] = g.irw_bit;

                       int per_bpp;
                       if (g.ppp > 0) {
                           per_bpp = g.ppp;
                       } else {
                           uint32_t maxpx = 0;
                           if (pix && w > 0 && h > 0)
                               for (int pi = 0; pi < w * h; pi++)
                                   if (pix[pi] > maxpx) maxpx = pix[pi];
                           per_bpp = bpp_for_max(maxpx);
                           if (per_bpp < 1 || per_bpp > 8) per_bpp = 4;
                       }
                      /* Increase bpp if unique colors exceed capacity */
                      if (pix && w > 0 && h > 0) {
                          uint8_t seen[256] = {0};
                          int nunique = 0;
                          for (int pi = 0; pi < w * h; pi++) {
                              if (!seen[pix[pi]]) { seen[pix[pi]] = 1; nunique++; }
                          }
                          while (nunique > (1 << per_bpp) && per_bpp < 8) per_bpp++;
                     }

                    int best_lm = 0, best_tm = 0, do_cmp = 0;
                    int lmm = 1, tmm = 1;
                    if (w > 0 && h > 0) {
                        /* Per-image LM/TM selection */
                        int64_t lead_err[4] = {0}, trail_err[4] = {0};
                        for (int row = 0; row < h; row++) {
                            uint8_t *rp = pix + row * w;
                            int lead = 0, trail = 0, lead_done = 0;
                            for (int x = 0; x < w; x++) {
                                uint8_t px2 = rp[x];
                                if (!lead_done) {
                                    if (lead == 120) { lead_done = 1; }
                                    else if (px2 == 0) { lead++; }
                                    else { lead_done = 1; }
                                } else if (w - 120 < x) {
                                    if (px2 == 0) trail++;
                                    else trail = 0;
                                }
                            }
                            for (int m = 0; m < 4; m++) {
                                int mult = 1 << m;
                                int ln = lead / mult; if (ln > 15) ln = 15;
                                int tn = trail / mult; if (tn > 15) tn = 15;
                                lead_err[m] += lead - ln * mult;
                                trail_err[m] += trail - tn * mult;
                            }
                        }

                        for (int m = 1; m < 4; m++) {
                            if (lead_err[m] < lead_err[best_lm]) best_lm = m;
                            if (!(trail_err[best_tm] <= trail_err[m])) best_tm = m;
                        }

                        /* Per-image CMP decision */
                        lmm = 1 << best_lm; tmm = 1 << best_tm;
                        int64_t comp_bits = 0, raw_bits = (int64_t)h * w * per_bpp;
                            for (int row = 0; row < h; row++) {
                                uint8_t *rp = pix + row * w;
                                 int lead = 0, trail = 0, lead_done2 = 0;
                                 for (int x = 0; x < w; x++) {
                                     uint8_t px2 = rp[x];
                                     if (!lead_done2) {
                                         if (lead == 120) { lead_done2 = 1; }
                                         else if (px2 == 0) { lead++; }
                                         else { lead_done2 = 1; }
                                     } else if (w - 120 < x) {
                                         if (px2 == 0) trail++;
                                         else trail = 0;
                                     }
                                 }
                                 int ln = lead / lmm; if (ln > 15) ln = 15;
                             int tn = trail / tmm; if (tn > 15) tn = 15;
                            int lc = ln * lmm, tc = tn * tmm;
                            if (lc + tc > w) tc = w - lc;
                            int stored = w - lc - tc;
                            if (stored < 0) stored = 0;
                            if (stored < 10) {
                                int i6 = lc, i7 = w - tc - 1;
                                if ((i7 - i6) + 1 < 10) {
                                    int l2c = (i6 - i7) + 9, i9 = l2c;
                                    if (i6 < l2c) { i9 = l2c - i6; l2c = i6; }
                                    ln = lmm > 0 ? (lc - l2c) / lmm : 0;
                                    if (((i7 - (lc - l2c)) + 1) < 10)
                                        tn = tmm > 0 ? (tc - i9) / tmm : 0;
                                    lc = ln * lmm; tc = tn * tmm;
                                    if (lc + tc > w) tc = w - lc;
                                    stored = w - lc - tc;
                                    if (stored < 0) stored = 0;
                                }
                            }
                             comp_bits += 8 + stored * per_bpp;
                         }
                           do_cmp = (g.zon && sizx_a >= 10 && comp_bits <= raw_bits) ? 1 : 0;
                          /* Images smaller than 10 pixels wide/tall are never compressed */
                          if (w < 10 || h < 10) { do_cmp = 0; g.n_small_uncompressed++; }
                          /* When not compressing, LM/TM are irrelevant — reset to 0 */
                          if (!do_cmp) { best_lm = 0; best_tm = 0; }
                          img_bpp[di] = per_bpp; img_cmp[di] = do_cmp;
                          img_lm[di] = best_lm; img_tm[di] = best_tm;

                         /* Dedup check before encoding */
                          if (g.dedup && pix && w > 0 && h > 0) {
                              uint16_t max_val;
                              uint16_t ck = loadw_checksum(pix, w, w, h, &max_val);
                              uint16_t bg_ctrl = (uint16_t)((per_bpp << 12) | (best_tm << 10) |
                                                            (best_lm << 8) | (do_cmp ? 0x80 : 0));
                              for (int di2 = 0; di2 < n_dedup; di2++) {
                                  if (dedup_table[di2].sum == ck && dedup_table[di2].max_val == max_val &&
                                      dedup_table[di2].ctrl == bg_ctrl) {
                                      bg_dedup_idx = di2; break;
                                  }
                              }
                              if (g.verbose)
                                  printf("  BGND %s/0x%02X (%dx%d) ck=%u max=%u ctrl=0x%04x dedup=%s",
                                         bdb_name, bdds[di].idx, w, h, ck, max_val, bg_ctrl,
                                         bg_dedup_idx >= 0 ? "HIT" : "MISS");
                              if (g.verbose && bg_dedup_idx < 0 && ck == 39578)
                                  for (int di2 = 0; di2 < n_dedup; di2++)
                                      printf(" [tbl[%d]: ck=%u max=%u ctrl=0x%04x sag=%u]",
                                             di2, dedup_table[di2].sum, dedup_table[di2].max_val,
                                             dedup_table[di2].ctrl, dedup_table[di2].sag);
                              if (g.verbose) printf("\n");
                          }

                           if (bg_dedup_idx >= 0) {
                               img_sags[di] = dedup_table[bg_dedup_idx].sag;
                               g.bgnd_dedup_bytes += (w * h * per_bpp + 7) / 8;
                               g.bgnd_dedup_matches++;
                               if (g.verbose)
                                   printf("  BGND %s/0x%02X (%dx%d) cksum match at bit=%u (orig BDD 0x%02X)\n",
                                          bdb_name, bdds[di].idx, w, h, dedup_table[bg_dedup_idx].sag,
                                          dedup_table[bg_dedup_idx].sag_idx);
                         } else {

                         if (do_cmp) {
                          for (int row = 0; row < h; row++) {
                              uint8_t *rp = pix + row * w;
                              int lead = 0, trail = 0, lead_done3 = 0;
                              for (int x = 0; x < w; x++) {
                                  uint8_t px2 = rp[x];
                                  if (!lead_done3) {
                                      if (lead == 120) { lead_done3 = 1; }
                                      else if (px2 == 0) { lead++; }
                                      else { lead_done3 = 1; }
                                  } else if (w - 120 < x) {
                                      if (px2 == 0) trail++;
                                      else trail = 0;
                                  }
                              }
                                 int ln = lead / lmm; if (ln > 15) ln = 15;
                                int tn = trail / tmm; if (tn > 15) tn = 15;
                                int lc = ln * lmm, tc = tn * tmm;
                                if (lc + tc > sizx_a) tc = sizx_a - lc;
                                int stored = sizx_a - lc - tc;
                                if (stored < 0) stored = 0;
                                if (stored < 10) {
                                    int i6 = lc, i7 = sizx_a - tc - 1;
                                if ((i7 - i6) + 1 < 10) {
                                    int l2c = (i6 - i7) + 9, i9 = l2c;
                                    if (i6 < l2c) { i9 = l2c - i6; l2c = i6; }
                                    ln = lmm > 0 ? (lc - l2c) / lmm : 0;
                                    if (((i7 - (lc - l2c)) + 1) < 10)
                                        tn = tmm > 0 ? (tc - i9) / tmm : 0;
                                    lc = ln * lmm; tc = tn * tmm;
                                    if (lc + tc > sizx_a) tc = sizx_a - lc;
                                    stored = sizx_a - lc - tc;
                                    if (stored < 0) stored = 0;
                                }
                            }
                            irw_write_byte((uint8_t)((tn << 4) | (ln & 0xf)));
                            for (int si = 0; si < stored; si++)
                                irw_write_bits((lc + si < w) ? rp[lc + si] : 0, per_bpp);
                        }
                    } else {
                        for (int row = 0; row < h; row++) {
                            uint8_t *rp = pix + row * w;
                            for (int x = 0; x < sizx_a; x++)
                                irw_write_bits(x < w ? rp[x] : 0, per_bpp);
                        }
                    }
                     }
                     }
                     /* Add to dedup table */
                      if (g.dedup && bg_dedup_idx < 0 && n_dedup < MAX_DEDUP) {
                          uint16_t max_val;
                          uint16_t ck = loadw_checksum(pix, w, w, h, &max_val);
                         uint16_t bg_ctrl = (uint16_t)((per_bpp << 12) | (best_tm << 10) |
                                                       (best_lm << 8) | (do_cmp ? 0x80 : 0));
                         dedup_table[n_dedup].sum = ck;
                         dedup_table[n_dedup].max_val = max_val;
                         dedup_table[n_dedup].sizx = sizx_a;
                         dedup_table[n_dedup].sizy = h;
                         dedup_table[n_dedup].ctrl = bg_ctrl;
                         dedup_table[n_dedup].sag = img_sags[di];
                         dedup_table[n_dedup].sag_idx = bdds[di].idx;
                         n_dedup++;
                     }
                     if (g.verbose) printf("  BGND 0x%02X (%dx%d) bit=%u bpp=%d LM=%d TM=%d CMP=%d\n",
                           bdds[di].idx, w, h, img_sags[di], per_bpp, best_lm, best_tm, do_cmp);
                }

                if (g.bgnd_fp) {
                    uint16_t ctrl = (uint16_t)(((img_bpp[di] == 8 ? 0 : img_bpp[di]) << 12) | (img_tm[di] << 10) |
                                                (img_lm[di] << 8) | (img_cmp[di] ? 0x80 : 0));
                    static int first_bgnd = 1;
                    fprintf(g.bgnd_fp, "\t.word\t%d,%d%s\r\n", w, h, first_bgnd ? "\t;x size, y size" : "");
                    fprintf(g.bgnd_fp, "\t.long\t0%XH%s\r\n", g.base_addr + img_sags[di], first_bgnd ? "\t;address" : "");
                    fprintf(g.bgnd_fp, "\t.word\t0%XH%s\r\n", ctrl, first_bgnd ? "\t;dma ctrl" : "");
                    first_bgnd = 0;
                }
            }

            /* Phase 3: Output BLKS map layout data (after image entries, before BMOD) */
            if (g.bgnd_fp && n_bmod > 0) {
                  /* First pass: compute min_sy per module (LOUDW adjusts ys to min sy of matching objects) */
                  int mod_min_sy[64];
                  for (int mi = 0; mi < n_bmod; mi++) {
                      mod_min_sy[mi] = 99999;
                      for (int gi = 0; gi < ng; gi++) {
                          if (gobjs[gi].is_mod) continue;
                          int od = gobjs[gi].dp, osy = gobjs[gi].sy;
                          int ii = gobjs[gi].ii;
                          int w = 0, h = 0;
                          for (int di = 0; di < n_bdds; di++) {
                              if (bdds[di].idx == ii) { w = bdds[di].w; h = bdds[di].h; break; }
                          }
                          if (od >= mod_ds[mi] && od <= mod_de[mi] &&
                              osy >= mod_ys[mi] && osy <= mod_ye[mi] &&
                              od + (w > 0 ? w - 1 : 0) <= mod_de[mi] &&
                              osy + (h > 0 ? h - 1 : 0) <= mod_ye[mi]) {
                              if (osy < mod_min_sy[mi]) mod_min_sy[mi] = osy;
                          }
                      }
                      if (mod_min_sy[mi] == 99999) mod_min_sy[mi] = mod_ys[mi];
                  }
                 for (int mi = 0; mi < n_bmod; mi++) {
                     const char *mn = bmod_list[mi];
                     fprintf(g.bgnd_fp, "%sBLKS:\r\n", mn);
                     /* Collect objects for this module, convert to module-local coords */
                     struct { int wx, x, y, ii; } blk_objs[2048];
                     int n_blk = 0;
                      for (int gi = 0; gi < ng; gi++) {
                          if (gobjs[gi].is_mod) continue;
                          int od = gobjs[gi].dp, osy = gobjs[gi].sy;
                          /* First-fit: check all modules in file order to see which one claims this object */
                          int assigned_mi = -1;
                          for (int ti = 0; ti < n_bmod; ti++) {
                              if (od >= mod_ds[ti] && od <= mod_de[ti] &&
                                  osy >= mod_ys[ti] && osy <= mod_ye[ti]) {
                                  assigned_mi = ti;
                                  break;
                              }
                          }
                          if (assigned_mi != mi) continue;
                           int wx_blks = gobjs[gi].wx;
                          int ii = gobjs[gi].ii;
                          int hdr_idx = 0;
                          for (int di = 0; di < n_bdds; di++) {
                              if (bdds[di].idx == ii) {
                                   wx_blks = (wx_blks & 0xFFF0) | 0x0040 | (gobjs[gi].fl & 0x0F);
                                  hdr_idx = di;
                                  break;
                              }
                          }
                          blk_objs[n_blk].wx = wx_blks;
                         /* Module-local coordinates: x relative to first object, y relative to sy_base */
                         int first_d = mod_first_depth[mi];
                         blk_objs[n_blk].x = od - (first_d >= 0 ? first_d : mod_ds[mi]);
                          blk_objs[n_blk].y = osy - mod_min_sy[mi];
                         blk_objs[n_blk].ii = hdr_idx;
                         n_blk++;
                     }
                     /* Output in BDB file order (no sorting) */
                      for (int bi = 0; bi < n_blk; bi++) {
                          if (bi == 0) {
                              fprintf(g.bgnd_fp, "\t.word\t0%XH\t;flags\r\n", blk_objs[bi].wx);
                              fprintf(g.bgnd_fp, "\t.word\t%d,%d ;x,y\r\n", blk_objs[bi].x, blk_objs[bi].y);
                              fprintf(g.bgnd_fp, "\t.word\t0%XH\t;pal5,pal4,hdr13-0\r\n", blk_objs[bi].ii);
                          } else {
                             fprintf(g.bgnd_fp, "\t.word\t0%XH,%d,%d,0%XH\r\n",
                                     blk_objs[bi].wx, blk_objs[bi].x, blk_objs[bi].y, blk_objs[bi].ii);
                         }
                     }
                     fprintf(g.bgnd_fp, "\t.word\t0FFFFH\t;End Marker\r\n");
                 }
             }

            /* BMOD sections (after all BLKS sections) */
            if (g.verbose) {
                printf("  BMOD enter ng=%d n_bmod=%d bmod[0]='%s'\n", ng, n_bmod, n_bmod>0?bmod_list[0]:"?");
                for (int z = 0; z < ng && z < 8; z++)
                    printf("  ][%d] is_mod=%d name='%s'\n", z, gobjs[z].is_mod, gobjs[z].name);
            }
            if (g.bgnd_fp && n_bmod > 0) {
                for (int mi = 0; mi < n_bmod; mi++) {
                    const char *mn = bmod_list[mi];
                    int mw = 0, mh = 0;
                    /* Compute bounding box from object positions + image sizes */
                    int min_d = 99999, max_de = 0, min_sy = 99999, max_se = 0;
                    int found_any = 0;
                     for (int gj = 0; gj < ng; gj++) {
                         if (gobjs[gj].is_mod) continue;
                         int od = gobjs[gj].dp, osy = gobjs[gj].sy;
                         /* First-fit: check all modules in file order */
                         int assigned_mi = -1;
                         for (int ti = 0; ti < n_bmod; ti++) {
                             if (od >= mod_ds[ti] && od <= mod_de[ti] &&
                                 osy >= mod_ys[ti] && osy <= mod_ye[ti]) {
                                 assigned_mi = ti;
                                 break;
                             }
                         }
                         if (assigned_mi != mi) continue;
                         int ii = gobjs[gj].ii;
                        int iw = 0, ih = 0;
                        for (int di = 0; di < n_bdds; di++)
                            if (bdds[di].idx == ii) { iw = bdds[di].w; ih = bdds[di].h; break; }
                        if (od < min_d) min_d = od;
                        if (od + iw > max_de) max_de = od + iw;
                        if (osy < min_sy) min_sy = osy;
                        if (osy + ih > max_se) max_se = osy + ih;
                        found_any = 1;
                    }
                    if (found_any) {
                        mw = max_de - min_d;
                        mh = max_se - min_sy;
                    } else {
                        mw = mod_de[mi] - mod_ds[mi];
                        mh = mod_ye[mi] - mod_ys[mi];
                    }
                    if (g.bgndequ_fp && mod_obj_count[mi] > 0) {
                        fprintf(g.bgndequ_fp, "W%s .EQU\t%d\r\n", mn, mw);
                        fprintf(g.bgndequ_fp, "H%s .EQU\t%d\r\n", mn, mh);
                    }
                fprintf(g.bgnd_fp, "%sBMOD:\r\n", mn);
                fprintf(g.bgnd_fp, "\t.word\t%d,%d,%d\t;x size, y size, #blocks\r\n", mw, mh, mod_obj_count[mi]);
                    fprintf(g.bgnd_fp, "\t.long\t%sBLKS, %s, %sPALS\r\n", mn, cur_hdrs, hdr_suffix);
                }
            }
            if (g.bgndtbl_glo_fp) {
                /* Palette .globl before BMOD (matching LOADW output order) */
                for (int pi = 0; pi < np; pi++)
                    fprintf(g.bgndtbl_glo_fp, "\t.globl\t%s\r\n", pals[pi].name);
                for (int bi = 0; bi < n_bmod; bi++)
                    fprintf(g.bgndtbl_glo_fp, "\t.globl\t%sBMOD\r\n", bmod_list[bi]);
            }

            if (g.bgndpal_fp)
                for (int pi = 0; pi < np; pi++) {
                    /* Skip palettes already defined in IMGPAL.ASM */
                    int already_written = 0;
                    for (int pi2 = 0; pi2 < g.n_palettes; pi2++)
                        if (g.palettes[pi2].written && strcmp(g.palettes[pi2].name, pals[pi].name) == 0)
                            { already_written = 1; break; }
                    if (already_written) continue;
                    fprintf(g.bgndpal_fp, "%s:\t;PAL #%d\r\n", pals[pi].name, pi);
                    fprintf(g.bgndpal_fp, "\t.word\t%d\t;pal size\r\n", pals[pi].cnt);
                    fputs("\t.word ", g.bgndpal_fp);
                    for (int ci = 0; ci < pals[pi].cnt; ci++) {
                        fprintf(g.bgndpal_fp, "%04XH", pals[pi].colors[ci]);
                        if (ci < pals[pi].cnt - 1) fputc(',', g.bgndpal_fp);
                    }
                    fputs("\r\n\r\n", g.bgndpal_fp);
                }

            if (g.verbose) printf("  %s: %d BDD images, %d BGND output, %d palettes\n", bdb_name, n_bdds, bgnd_count, np);
            free(bdd_data);
        }

else if (!strncmp(upper, "MON>", 4)) { }
        else if (!strncmp(upper, "BON>", 4)) { }
        else if (!strncmp(upper, "ROM>", 4)) { }
        else if (!strncmp(upper, "--->", 4)) {
            if (cur.imgfile) parse_imglist(line, &cur, 0);
        }
        else if (strstr(upper, ".IMG")) {
            char fname[MAX_PATH];
            sscanf(line, "%s", fname);
            upcase(fname);
            if (cur.imgfile) { free(cur.imgfile->norm_images); free(cur.imgfile->data); free(cur.imgfile); }
            cur.imgfile = img_load_try(g.imgdir, fname);
            if (!cur.imgfile)
                fprintf(stderr, "WARNING: cannot load IMG file: %s\n", fname);
            else {
                strncpy(cur.imgpath, fname, MAX_PATH-1);
                if (g.verbose) printf("Loaded: %s (%d images)\n", fname, cur.imgfile->n_images);
            }
        }
    }

    fclose(f);
    if (g.asm_fp) { fclose(g.asm_fp); g.asm_fp = NULL; }
    /* Write .TEXT/^Z trailer to all opened TBL files (LOADW writes trailer only at end) */
    for (int ft = 0; ft < g.n_tbl_files; ft++) {
        FILE *tf = fopen(g.tbl_files[ft], "r+");
        if (tf) {
            fseek(tf, 0, SEEK_END);
            fprintf(tf, "\t.TEXT\r\n");
            fputc(0x1a, tf);
            fclose(tf);
        }
    }
    g.n_tbl_files = 0;
    if (cur.imgfile) { free(cur.imgfile->norm_images); free(cur.imgfile->data); free(cur.imgfile); }
}

/* =========================================================================
 * IRW file writer
 * ========================================================================= */

static void write_irw(const char *path) {
    uint8_t hdr[IRW_HDR_SIZE];
    memset(hdr, 0, sizeof(hdr));
    strncpy((char*)hdr, IRW_DATE_STR, strlen(IRW_DATE_STR));

    uint32_t data_bytes = (g.irw_bit + 7) / 8;
    hdr[0x20] = (uint8_t)((g.n_images >> 0) & 0xff);
    hdr[0x21] = (uint8_t)((g.n_images >> 8) & 0xff);
    hdr[0x22] = g.global_bpp;
    hdr[0x2e] = 0x02;
    uint32_t total_size = IRW_HDR_SIZE + data_bytes;
    hdr[0x30] = (uint8_t)(total_size & 0xff);
    hdr[0x31] = (uint8_t)((total_size >> 8) & 0xff);
    hdr[0x32] = (uint8_t)((total_size >> 16) & 0xff);
    hdr[0x33] = (uint8_t)((total_size >> 24) & 0xff);

    FILE *f = fopen(path, "wb");
    if (!f) die("cannot create IRW file: %s", path);
    if (!g.raw_headerless)
        fwrite(hdr, 1, sizeof(hdr), f);
    fwrite(g.irw_data, 1, data_bytes, f);
    fclose(f);

    if (g.verbose)
        printf("Wrote IRW: %s (%u bytes data, %u bits)%s\n",
               path, data_bytes, g.irw_bit,
               g.raw_headerless ? " [headerless]" : "");
}

/* =========================================================================
 * Command line
 * ========================================================================= */

static void print_usage(const char *arg) {
    printf("loadimg <lod_file> [flags]\n");
    printf("\n");
    printf("Flags:\n");
    printf("  /R[=PATH]  Headerless raw IRW (no 0x44-byte header)\n");
    printf("  /T[=DIR]   Generate table files (.tbl/.asm/.glo)\n");
    printf("  /F[=DIR]   Raw file output directory\n");
    printf("  /I PATH    Image source directory\n");
    printf("  /D=PATH    LOD file directory\n");
    printf("  /V         Verbose output\n");
    printf("  /E         Dual-banked image memory (ED adjustment)\n");
    printf("  /P         Pad output stride to 4-pixel boundary\n");
    printf("  /L         Align to 16-bit boundary\n");
    printf("  /B         bpp from palette size\n");
    printf("  /3         Limit scales to 3\n");
    printf("  /A         Append mode (don't overwrite existing tables)\n");
    printf("  /H         This help\n");
    printf("\n");
    if (arg) {
        printf("Unknown argument: %s\n", arg);
        printf("Did you mean one of these?\n");
        printf("  /R, /T, /F, /I, /D, /V, /E, /P, /L, /B, /3, /A, /H\n");
        printf("\n");
    }
    printf("Example:\n");
    printf("  loadimg MK2MIL /P /T=C:\\TMP\n");
    printf("  loadimg MK2MIL.LOD /P /T /V\n");
    printf("  loadimg MK2MIL /R          (headerless raw)\n");
    printf("  loadimg MK2MIL /R=/tmp/out (headerless raw to path)\n");
}

int main(int argc, char *argv[]) {
    if (argc < 2) { print_usage(NULL); return 1; }

    memset(&g, 0, sizeof(g));
    g.dedup = 1;  /* CON> (checksums ON) by default, matching LOADW */
    g.pon = 1;
    g.build_raw = 1;
    g.build_tables = 0;

    char lod_file[MAX_PATH] = {0};
    char tbl_dir[MAX_PATH] = {0};
    char raw_dir[MAX_PATH] = {0};

    for (int i = 1; i < argc; i++) {
        char *a = argv[i];
        if (a[0] == '/') {
            char flag = (char)toupper((unsigned char)a[1]);
            char *val = a + 2;

            switch (flag) {
            case 'T':
                g.build_tables = 1;
                if (*val == '=') strncpy(tbl_dir, val+1, MAX_PATH-1);
                else if (*val == 'I') strncpy(tbl_dir, g.imgdir, MAX_PATH-1);
                break;
            case 'F':
                g.build_raw = 1;
                if (*val == '=') strncpy(raw_dir, val+1, MAX_PATH-1);
                else if (*val == 'I') strncpy(raw_dir, g.imgdir, MAX_PATH-1);
                break;
            case 'I': strncpy(g.imgdir, val[0]=='='?val+1:val, MAX_PATH-1); break;
            case 'D': strncpy(g.loddir, val[0]=='='?val+1:val, MAX_PATH-1); break;
            case 'O': strncpy(g.imgdir, val[0]=='='?val+1:val, MAX_PATH-1); break;
            case 'V': g.verbose = 1; break;
            case 'E': g.dual_bank = 1; break;
            case 'P': g.pad4bits = 1; break;
            case 'R':
                g.raw_headerless = 1;
                g.build_raw = 1;
                if (*val == '=') strncpy(raw_dir, val+1, MAX_PATH-1);
                break;
            case 'L': g.align16 = 1; break;
            case 'B': g.bpp_from_pal = 1; break;
            case '3': g.limit3scales = 1; break;
            case 'A': g.append = 1; break;
            case 'H': print_usage(NULL); return 0;
            default:
                fprintf(stderr, "Unknown flag: %s\n", a);
                print_usage(a);
                return 1;
            }
        } else {
            strncpy(lod_file, a, MAX_PATH-1);
        }
    }

    if (!lod_file[0]) { fprintf(stderr, "No LOD file specified.\n"); return 1; }

    if (tbl_dir[0]) strncpy(g.tbldir, tbl_dir, MAX_PATH-1);

    char lod_base[MAX_PATH];
    change_ext(lod_base, basename_p(lod_file), "", MAX_PATH);
    int bl = (int)strlen(lod_base);
    if (bl > 0 && lod_base[bl-1] == '.') lod_base[bl-1] = 0;

    char asm_path[MAX_PATH], glo_path[MAX_PATH], pal_path[MAX_PATH], irw_path[MAX_PATH];
    char lod_base_upper[MAX_PATH];
    strncpy(lod_base_upper, lod_base, MAX_PATH-1);
    upcase(lod_base_upper);

    char tbl_name[MAX_PATH];
    snprintf(tbl_name, MAX_PATH, "%sIMG.TBL", lod_base_upper);

    if (tbl_dir[0]) {
        path_cat(asm_path, tbl_dir, tbl_name, MAX_PATH);
        path_cat(glo_path, tbl_dir, "IMGTBL.GLO", MAX_PATH);
        path_cat(pal_path, tbl_dir, "IMGPAL.ASM", MAX_PATH);
    } else {
        strncpy(asm_path, tbl_name, MAX_PATH-1);
        strncpy(glo_path, "IMGTBL.GLO", MAX_PATH-1);
        strncpy(pal_path, "IMGPAL.ASM", MAX_PATH-1);
    }

    char irw_name[MAX_PATH];
    snprintf(irw_name, MAX_PATH, "%s.IRW", lod_base_upper);
    if (raw_dir[0])
        path_cat(irw_path, raw_dir, irw_name, MAX_PATH);
    else
        strncpy(irw_path, irw_name, MAX_PATH-1);

    if (g.build_tables) {
        g.asm_fp = fopen(asm_path, "w");
        if (!g.asm_fp) die("cannot create: %s", asm_path);
        write_tbl_header(g.asm_fp);
        g.glo_fp = fopen(glo_path, g.append ? "a" : "w");
        if (!g.glo_fp) die("cannot create: %s", glo_path);
        g.main_glo_fp = fopen(glo_path, g.append ? "a" : "w");
        if (!g.main_glo_fp) die("cannot create main GLO: %s", glo_path);
        g.pal_fp = fopen(pal_path, g.append ? "a" : "w+");
        if (!g.pal_fp) die("cannot create: %s", pal_path);
        if (!g.append) {
            fprintf(g.pal_fp, "\t.FILE \"imgpal.asm\"\r\n");
            fprintf(g.pal_fp, "\t.OPTION B,D,L,T\r\n");
            fprintf(g.pal_fp, "\r\n");
            fprintf(g.pal_fp, "\t.include imgtbl.glo\r\n");
            fprintf(g.pal_fp, "\t.DATA\r\n");
            fprintf(g.pal_fp, "\t.even\r\n\r\n");
        }
    }

    g.irw_alloc = 1024 * 1024;
    g.irw_data = (uint8_t*)calloc(1, g.irw_alloc);
    g.irw_size = 0;
    g.irw_bit = 0;

    scan_bpp(lod_file);
    process_lod(lod_file);

    if (g.build_raw) write_irw(irw_path);

    /* Generate IMGTBL.ASM wrapper (includes all GLO files) */
    if (g.build_tables && g.pal_fp) {
        char imgasm_path[MAX_PATH];
        if (g.tbldir[0])
            path_cat(imgasm_path, g.tbldir, "IMGTBL.ASM", MAX_PATH);
        else
            strncpy(imgasm_path, "IMGTBL.ASM", MAX_PATH-1);
        /* Check if already written (via ASM> directive) */
        int need_write = 1;
        if (g.asm_path[0]) {
            char up_asm[64]; strncpy(up_asm, g.asm_path, 63); upcase(up_asm);
            char up_img[64]; strncpy(up_img, "IMGTBL.ASM", 63); upcase(up_img);
            if (strstr(up_asm, up_img)) need_write = 0;
        }
        if (need_write) {
            FILE *imgasm_fp = fopen(imgasm_path, "w");
            if (imgasm_fp) {
                fprintf(imgasm_fp, "\t.FILE \"imgtbl.asm\"\r\n");
                fprintf(imgasm_fp, "\t.OPTION B,D,L,T\r\n");
                fprintf(imgasm_fp, "\r\n");
                fprintf(imgasm_fp, "\t.include imgtbl.glo\r\n");
                fprintf(imgasm_fp, "\t.DATA\r\n");
                fprintf(imgasm_fp, "\t.even\r\n\r\n");
                for (int gi = 0; gi < g.n_glo_files; gi++) {
                    fprintf(imgasm_fp, "\t.include %s\r\n", g.glo_files[gi]);
                    if (gi < g.n_glo_files - 1)
                        fprintf(imgasm_fp, "\r\n");
                }
                fclose(imgasm_fp);
            }
        }
    }

    if (g.asm_fp) {
        fprintf(g.asm_fp, "\t.TEXT\r\n");
        fputc(0x1a, g.asm_fp);
        fclose(g.asm_fp);
    }
    if (g.glo_fp) fclose(g.glo_fp);
    if (g.main_glo_fp) fclose(g.main_glo_fp);
    if (g.pal_fp) {
        fseek(g.pal_fp, 0, SEEK_END);
        long pos = ftell(g.pal_fp);
        fprintf(stderr, "PAL_TRUNC: pos=%ld\n", pos);
        if (pos >= 2) {
            fseek(g.pal_fp, pos - 2, SEEK_SET);
            uint8_t last2[2];
            if (fread(last2, 1, 2, g.pal_fp) == 2) {
                fprintf(stderr, "PAL_TRUNC: last2=0x%02x%02x\n", last2[0], last2[1]);
                if (last2[0] == 0x0d && last2[1] == 0x0a) {
                    ftruncate(fileno(g.pal_fp), pos - 2);
                    fprintf(stderr, "PAL_TRUNC: truncated to %ld\n", pos - 2);
                }
            }
        }
        fclose(g.pal_fp);
    }
    if (g.bgnd_fp) fclose(g.bgnd_fp);
    if (g.bgndpal_fp) fclose(g.bgndpal_fp);
    if (g.bgndequ_fp) fclose(g.bgndequ_fp);
    if (g.bgndtbl_glo_fp) fclose(g.bgndtbl_glo_fp);
    free(g.irw_data);

    {
        uint32_t total_bytes = g.irw_bit ? ((g.irw_bit + 7) / 8) : 0;
        printf("\nBytes Written to Raw File...\n");
        printf("\tIn IMAGE RAM records        %u dec\t   %X hex\n", total_bytes, total_bytes);
        printf("\n");
        printf("\tTOTAL bytes written         %u dec\t   %X hex, in %d records.\n",
               total_bytes, total_bytes, g.n_images > 0 ? g.n_images : 1);
        printf("\n");
        printf("Bytes Represented in Tables ... %u dec %X hex\n", total_bytes, total_bytes);
        printf("\n");
        if (g.n_small_uncompressed > 0)
            printf("%d images were NOT zero-compressed because they are\n"
                   "\tsmaller than 10 pixels wide.\n", g.n_small_uncompressed);
        if (g.bgnd_dedup_matches > 0)
            printf("Skipped %d duplicate bytes in %d background checksum matches.\n",
                   g.bgnd_dedup_bytes, g.bgnd_dedup_matches);
    }

    printf("Done. %d images processed.\n", g.n_images);
    return 0;
}
