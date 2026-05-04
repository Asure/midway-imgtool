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

#define MAX_IMAGES      2000
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
typedef struct { uint8_t x, y, w, h; } PTBOX;

typedef struct {
    uint16_t flags;
    int16_t  x1, x2, x3;
    int16_t  x_anipt3, y_anipt3, z_anipt3;
    uint16_t id;
    PTBOX    box[5];
    PTBOX    cbox[1];
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
#define IHDR_PWRD1  18
#define IHDR_PWRD2  19
#define IHDR_PWRD3  20
#define IHDR_MAX    21

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
    char     glo_file[MAX_PATH];
    char     pal_file[MAX_PATH];
    char     raw_file[MAX_PATH];

    FILE     *asm_fp;
    FILE     *glo_fp;
    FILE     *pal_fp;

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
static uint32_t loadw_checksum(uint8_t *pix, int stride, int w, int h, uint32_t *out_max) {
    uint32_t sum = 0, max_val = 0;
    int rw = stride > w ? stride : w;
    for (int y = 0; y < h; y++) {
        uint32_t *dw = (uint32_t*)(pix + y * stride);
        for (int x = 0; x < rw / 4; x++) {
            uint32_t v = dw[x];
            sum += v;
            uint32_t lo = v & 0xff;
            uint32_t hi = (v >> 8) & 0xff;
            if (lo > max_val) max_val = lo;
            if (hi > max_val) max_val = hi;
        }
    }
    *out_max = max_val;
    return sum;
}

#define MAX_DEDUP 4096
typedef struct { uint32_t sum, max_val; int sizx, sizy; uint16_t ctrl; uint32_t sag; } DedupEntry;
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

    /* Extract basename from DOS-style paths (e.g. "c:\video\kombat2\img\FILE.IMG" -> "FILE.IMG") */
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
        path_cat(p4, dir, base, MAX_PATH);   tries[n++] = p4;
        path_cat(p5, dir, base_upper, MAX_PATH); tries[n++] = p5;
        path_cat(p6, dir, base_lower, MAX_PATH); tries[n++] = p6;
    }
    tries[n++] = fname;
    tries[n++] = upper;
    tries[n++] = lower;
    tries[n++] = base;
    tries[n++] = base_upper;
    tries[n++] = base_lower;
    (void)path;

    for (int i = 0; i < n; i++) {
        ImgFile *img = img_load(tries[i]);
        if (img) return img;
    }
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
        /* Patch hdr so rest of img_load works: adjust oset to skip old records */
        img->hdr.temp    = 0xabcd;
        img->hdr.version = 0x634;
        img->hdr.seqcnt  = 0;
        img->hdr.scrcnt  = 0;
    }

    uint32_t oset = img->hdr.oset;

    int n_special = 0;
    for (int i = 0; i < 10; i++) {
        IMG_REC *rec = (IMG_REC*)(img->data + oset + i * (int)sizeof(IMG_REC));
        if (rec->name[0] == '!') n_special++;
        else break;
    }

    img->n_special = n_special;
    if (img->norm_images)
        img->images = img->norm_images + n_special;
    else
        img->images = (IMG_REC*)(img->data + oset + n_special * (int)sizeof(IMG_REC));
    img->n_images = img->hdr.imgcnt - n_special;

    /* Palette records: stored with 3 defaults prepended */
    uint32_t pal_ofs = oset + (uint32_t)img->hdr.imgcnt * (uint32_t)sizeof(IMG_REC);
    img->pals = (PAL_REC*)(img->data + pal_ofs);
    img->n_palettes = img->hdr.palcnt;

    /* PTTBL offset: after palette records + sequences + scripts */
    uint32_t pttbl_ofs = pal_ofs + (uint32_t)img->n_palettes * sizeof(PAL_REC);
    /* SEQSCR entries between palettes and PTTBL */
    int n_seqscr = (int)img->hdr.seqcnt + (int)img->hdr.scrcnt;
    if (n_seqscr > 0) {
        /* SEQSCR struct (pack 2): name[16] + flags(2) + num(2) + entry_t[16](dd=4*16) + startx(2) + starty(2) + dam[6] + spare1(2) + spare2(2) = 98 */
        pttbl_ofs += (uint32_t)n_seqscr * 98;
    }

    /* Compute max PTTBL index */
    int max_pttbl = -1;
    for (int i = 0; i < img->hdr.imgcnt; i++) {
        IMG_REC *rec = (IMG_REC*)(img->data + oset + i * (int)sizeof(IMG_REC));
        if (rec->pttblnum >= 0 && rec->pttblnum > max_pttbl)
            max_pttbl = rec->pttblnum;
    }
    img->n_pttbls = (max_pttbl >= 0) ? max_pttbl + 1 : 0;

    /* Clamp to what fits in the file */
    int max_fit = (int)((img->size - pttbl_ofs) / sizeof(PTTBL));
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
    int stride = (rec->w + 3) & ~3;
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
    int sizx, sizy;
    uint16_t ctrl;
    int running_lead;
    int running_trail;
    int lookahead_lead;
    int lookahead_trail;
} CompParams;

/* Compute content-based SIZX: rightmost non-zero pixel + 1 */
static int compute_content_sizx(ImgFile *img, IMG_REC *rec) {
    uint8_t *pix = img_pixels(img, rec);
    if (!pix) return rec->w;
    int stride = (rec->w + 3) & ~3;
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
    int stride = (rec->w + 3) & ~3;
    for (int y = rec->h - 1; y >= 0; y--) {
        for (int x = 0; x < rec->w; x++) {
            if (pix[y * stride + x] != 0)
                return y + 1;
        }
    }
    return rec->h;
}

static CompParams analyze_image(ImgFile *img, IMG_REC *rec, int bpp, int pttbl_sizx) {
    CompParams p;
    memset(&p, 0, sizeof(p));

    p.sizx = pttbl_sizx > 0 ? pttbl_sizx : (rec->w + 3) & ~3;
    p.sizy = rec->h;
    if (p.sizx < 1) p.sizx = 1;
    if (p.sizy < 1) p.sizy = 1;

    if (!g.zon) {
        p.lm = p.tm = 0;
        p.lm_mult = p.tm_mult = 1;
        p.ctrl = compute_ctrl(bpp, 0, 0, 0);
        return p;
    }

    /* FUN_1000_6f20 error-minimizing LM/TM selection.
     * For each row, count lead (120 cap, bVar8) and trail (only after lead finishes).
     * Then accumulate waste per multiplier: waste = sum(mult*lead_n - lead) across rows.
     * Select LM/TM with minimum total waste. */
    uint8_t *pix = img_pixels(img, rec);
    int stride = (rec->w + 3) & ~3;
    int lead_err[4] = {0}, trail_err[4] = {0};
    int lookahead_lead_min = 999;
    int rows = rec->h;
    int la_window = rows < 4 ? rows : 4;
    int sizx = p.sizx;

    for (int y = 0; y < rec->h; y++) {
        uint8_t *row = pix + y * stride;
        int lead = 0, trail = 0, lead_done = 0;

        for (int x = 0; x < sizx; x++) {
            uint8_t px = row[x];
            if (!lead_done) {
                if (lead == 120) {
                    lead_done = 1;
                } else if (px == 0) {
                    lead++;
                } else {
                    lead_done = 1;
                }
            }
            if (lead_done) {
                if (sizx - 120 < x) {
                    if (px == 0) trail++;
                    else trail = 0;
                }
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
    int raw_bits = sizx * rec->h * bpp;
    int comp_bits = 0;
    for (int y = 0; y < rec->h; y++) {
        uint8_t *row = pix + y * stride;
        int lead = 0, trail = 0, lead_done = 0;
        for (int x = 0; x < sizx; x++) {
            uint8_t px = row[x];
            if (!lead_done) {
                if (lead == 120) { lead_done = 1; }
                else if (px == 0) { lead++; }
                else { lead_done = 1; }
            }
            if (lead_done && sizx - 120 < x) {
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
    int do_cmp = (sizx >= 10 && comp_bits < raw_bits) ? 1 : 0;

    p.ctrl = compute_ctrl(bpp, p.lm, p.tm, do_cmp);

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
        }
        if (lead_done) {
            if (sizx - 120 < x) {
                if (px == 0) trail++;
                else trail = 0;
            }
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
    int img_stride = (rec->w + 3) & ~3;
    int sizx = cp->sizx;
    if (sizx < 1) sizx = 1;

    /* LOADW _do_sclpad: create internal buffer with stride = SIZX.
     * Pixel data copied from IMG buffer, zero-padded beyond rec->w. */
    int scl_stride = sizx;
    uint8_t *scl_buf = NULL;
    if (g.zon && rec->h > 0) {
        scl_buf = (uint8_t*)calloc((size_t)scl_stride * rec->h, 1);
        for (int y = 0; y < rec->h; y++) {
            uint8_t *src = pix + y * img_stride;
            uint8_t *dst = scl_buf + y * scl_stride;
            memcpy(dst, src, scl_stride);
        }
    }

    int running_lead = cp->lookahead_lead;

    /* Check CMP bit in CTRL: LOADW disables compression (CMP=0) for small images
     * where "Need 10 non-zero pixels minimum" fails. Use raw pixel mode in that case. */
    int do_cmp = (cp->ctrl & 0x80) ? 1 : 0;

    for (int y = 0; y < rec->h; y++) {
        uint8_t *row = (g.zon && do_cmp) ? scl_buf + y * scl_stride : pix + y * img_stride;
        if (g.zon && do_cmp) {
            encode_row(row, scl_stride, scl_stride, bpp, cp->lm_mult, cp->tm_mult, &running_lead);
        } else {
            int zw = g.pad4bits ? (rec->w + 3) & ~3 : rec->w;
            if (zw < 1) zw = 1;
            for (int x = 0; x < zw; x++)
                irw_write_bits(x < rec->w ? row[x] : 0, bpp);
        }
    }

    free(scl_buf);
    return sag;
}

static uint32_t encode_scaled(ImgFile *img, IMG_REC *rec, int bpp, int denom) {
    int sw = rec->w / denom;
    int sh = rec->h / denom;
    if (sw < 1) sw = 1;
    if (sh < 1) sh = 1;

    int stride = (rec->w + 3) & ~3;
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
    fprintf(fp, "\t.word\t\t%d\r\n", pe->numc);

    int per_line = 8;
    for (int i = 0; i < pe->numc; i++) {
        if (i % per_line == 0) fprintf(fp, "\t.word\t\t");
        fprintf(fp, "%04XH", colors[i]);
        if (i % per_line == per_line-1 || i == pe->numc-1)
            fprintf(fp, "\r\n");
        else
            fprintf(fp, ",");
    }
    fprintf(fp, "\r\n");

    if (g.glo_fp) {
        fprintf(g.glo_fp, "\t.globl\t%s\r\n", pe->name);
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
    case IHDR_PT3Y:  return ie->pt3y;
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
                fprintf(fp, "\t.word\t");
                for (int j = 0; j < n_words; j++) {
                    if (j > 0) fputc(',', fp);
                    fprintf(fp, "%d", word_buf[j]);
                }
                fprintf(fp, "\r\n");
                n_words = 0;
            }
            if (f == IHDR_SAG) {
                uint32_t base = g.base_addr;
                fprintf(fp, "\t.long\t0%XH\r\n", base + ie->sag);
            } else if (f == IHDR_PAL) {
                if (have_pal)
                    fprintf(fp, "\t.long\t%s\r\n", ie->pal_name);
                else
                    fprintf(fp, "\t.long\t-1\r\n");
            } else {
                fprintf(fp, "\t.long\t-1\r\n");
            }
        } else {
            if (f == IHDR_CTRL) {
                if (n_words > 0) {
                    fprintf(fp, "\t.word\t");
                    for (int j = 0; j < n_words; j++) {
                        if (j > 0) fputc(',', fp);
                        fprintf(fp, "%d", word_buf[j]);
                    }
                    fprintf(fp, "\r\n");
                    n_words = 0;
                }
                fprintf(fp, "\t.word\t0%04XH\r\n", ie->ctrl);
            } else {
                int val = get_ihdr_word_value(ie, f, 1);
                word_buf[n_words++] = val;
            }
        }
    }

    if (n_words > 0) {
        fprintf(fp, "\t.word\t");
        for (int j = 0; j < n_words; j++) {
            if (j > 0) fputc(',', fp);
            fprintf(fp, "%d", word_buf[j]);
        }
        fprintf(fp, "\r\n");
        n_words = 0;
    }
}

static void write_global(const char *name) {
    fprintf(g.glo_fp, "\t.global %s\r\n", name);
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
            if (pt_idx >= 0 && pt_idx <= 4)
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

        if (*p == ':') { p++; (void)strtol(p, (char**)&p, 16); }
        if (*p == '*') { p++; scale_n = (int)strtol(p, (char**)&p, 10); }
        if (n_scales_override > 0) scale_n = n_scales_override;
        if (g.limit3scales && scale_n > 3) scale_n = 3;

        if (!cur->imgfile) {
            fprintf(stderr, "WARNING: no IMG file loaded for image %s\n", name);
            continue;
        }

        /* Find in image list (skipping special records) */
        IMG_REC *rec = NULL;
        for (int i = 0; i < cur->imgfile->n_images; i++) {
            char n[MAX_NAME];
            strncpy(n, cur->imgfile->images[i].name, MAX_NAME-1);
            n[MAX_NAME-1] = 0;
            for (int j = 0; j < MAX_NAME; j++) if (!n[j]) break;
            if (strcasecmp(n, name) == 0) { rec = &cur->imgfile->images[i]; break; }
        }
        if (!rec) {
            fprintf(stderr, "WARNING: image %s not found in %s\n", name, cur->imgpath);
            continue;
        }

        /* Determine SIZX from PTTBL: SIZX = PTTBL[pttblnum - n_special].BOX[1].W */
        int pttbl_sizx = 0;
        if (rec->pttblnum >= 0 && cur->imgfile->pttbls) {
            int pt_idx = (int)rec->pttblnum - (int)cur->imgfile->n_special;
            if (pt_idx >= 0 && pt_idx < cur->imgfile->n_pttbls) {
                PTTBL *pt = &cur->imgfile->pttbls[pt_idx];
                int bw = pt->box[1].w;
                if (bw > 0 && bw < rec->w)
                    pttbl_sizx = bw;
            }
        }

        int bpp;
        if (g.ppp > 0) {
            bpp = g.ppp;
        } else {
            /* Auto pixel packing: select bpp per image */
            uint8_t *pix = img_pixels(cur->imgfile, rec);
            if (pix) {
                int pstride = (rec->w + 3) & ~3;
                uint32_t maxpx = 0;
                for (int y = 0; y < rec->h; y++)
                    for (int x = 0; x < rec->w; x++) {
                        uint8_t px = pix[y * pstride + x];
                        if (px > maxpx) maxpx = px;
                    }
                int per_bpp = bpp_for_max(maxpx);
                if (per_bpp >= 1 && per_bpp <= 8) bpp = per_bpp;
                else bpp = g.global_bpp;
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
        ie->w = rec->w;
        ie->h = rec->h;
        ie->sizx = cp.sizx;
        ie->sizy = cp.sizy;
        ie->ctrl = cp.ctrl;
        ie->n_scales = scale_n;
        ie->pwrd1 = -1;
        ie->pwrd2 = -1;
        ie->pwrd3 = -1;
        ie->pt3y = 0;

        /* PT pairs from PTTBL fields or computed from box/CBOX geometry */
        if (rec->pttblnum >= (int16_t)cur->imgfile->n_special && cur->imgfile->pttbls) {
            int pt_idx = (int)rec->pttblnum - cur->imgfile->n_special;
            if (pt_idx < cur->imgfile->n_pttbls) {
                PTTBL *pt = &cur->imgfile->pttbls[pt_idx];
                PTTBL *pt0 = &cur->imgfile->pttbls[0];
                
                /* Read stored PT fields */
                ie->extra_pts[0] = pt->x1;
                ie->extra_pts[1] = pt->x2;
                ie->extra_pts[2] = pt->x3;
                ie->extra_pts[3] = pt->x_anipt3;
                ie->extra_pts[4] = pt->y_anipt3;
                ie->extra_pts[5] = pt->z_anipt3;
                ie->extra_pts[6] = 0;
                ie->extra_pts[7] = 0;
                ie->n_extra_pts = 6;
                
                /* If stored fields are zero, compute 4 PT pairs from geometry */
                if (ie->extra_pts[0] == 0 && ie->extra_pts[1] == 0) {
                    int cx = (int)((int8_t)pt->cbox[0].x);
                    int cy = (int)((int8_t)pt->cbox[0].y);
                    int cw = pt->cbox[0].w;
                    int ch = pt->cbox[0].h;
                    
                    /* PT1 = (CBOX.X - ANIX + CBOX.W, CBOX.Y - ANIY + CBOX.H) */
                    ie->extra_pts[0] = cx - ie->anix + cw;
                    ie->extra_pts[1] = cy - ie->aniy + ch;
                    
                    /* PT2 from shared PTTBL[0] (!STAND2):
                       (BOX[1].W + CBOX.W - CBOX.H - 1, BOX[1].Y - CBOX.W - 1) */
                    ie->extra_pts[2] = pt0->box[1].w + pt0->cbox[0].w - pt0->cbox[0].h - 1;
                    ie->extra_pts[3] = pt0->box[1].y - pt0->cbox[0].w - 1;
                    
                    /* PT3 = (BOX[2].X + 1, ANIY - BOX[1].H + shared_CBOX.H) */
                    ie->extra_pts[4] = pt->box[2].x + 1;
                    ie->extra_pts[5] = ie->aniy - pt->box[1].h + pt0->cbox[0].h;
                    
                    /* PT4 = (ANIX - BOX[1].W, ANIY - BOX[1].H) */
                    ie->extra_pts[6] = ie->anix - pt->box[1].w;
                    ie->extra_pts[7] = ie->aniy - pt->box[1].h;
                    
                    ie->n_extra_pts = 8;
                }
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
            uint32_t max_val;
            uint32_t ck = loadw_checksum(pix_data, pstride, rec->w, rec->h, &max_val);
            for (int di = 0; di < n_dedup; di++) {
                if (dedup_table[di].sum == ck && dedup_table[di].max_val == max_val &&
                    dedup_table[di].sizx == cp.sizx && dedup_table[di].sizy == cp.sizy &&
                    dedup_table[di].ctrl == cp.ctrl) {
                    dedup_idx = di; break;
                }
            }
        }

        if (dedup_idx >= 0) {
            ie->sag = dedup_table[dedup_idx].sag;
            if (g.verbose)
                printf("  Checksum match on image [%s].\n", name);
        } else {
            ie->sag = encode_image(cur->imgfile, rec, &cp, bpp);
            if (g.dedup && n_dedup < MAX_DEDUP) {
                uint8_t *pix_data = img_pixels(cur->imgfile, rec);
                int pstride = (rec->w + 3) & ~3;
                uint32_t max_val;
                dedup_table[n_dedup].sum = loadw_checksum(pix_data, pstride, rec->w, rec->h, &max_val);
                dedup_table[n_dedup].max_val = max_val;
                dedup_table[n_dedup].sizx = cp.sizx;
                dedup_table[n_dedup].sizy = cp.sizy;
                dedup_table[n_dedup].ctrl = cp.ctrl;
                dedup_table[n_dedup].sag = ie->sag;
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

        if (g.glo_fp)
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
            n_dedup = 0;  /* LOADW resets dedup table per IMG library */
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
                    if (strcasecmp(n, nm) == 0) {
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
            if (g.build_tables) {
                if (g.asm_fp) fclose(g.asm_fp);
                char full[MAX_PATH];
                if (g.tbldir[0]) path_cat(full, g.tbldir, fname, MAX_PATH);
                else strncpy(full, fname, MAX_PATH-1);
                /* LOADW appends to existing TBL files (ASM> can be used
                 * multiple times for the same table) */
                g.asm_fp = fopen(full, "a");
                if (!g.asm_fp) die("cannot create %s", full);
                /* Write header only for new files */
                fseek(g.asm_fp, 0, SEEK_END);
                if (ftell(g.asm_fp) == 0)
                    write_tbl_header(g.asm_fp);
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
                g.glo_fp = fopen(full, g.append ? "a" : "w");
                if (!g.glo_fp) die("cannot create %s", full);
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
                if (g.build_tables && g.asm_fp) {
                    fprintf(g.asm_fp, "%s\t.set\t0%XH\r\n", fname, g.base_addr + g.irw_bit);
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
                if (g.verbose)
                    printf("  FRM %s at bit %u (%ld bytes)\n", fname, sag, bsz);
            } else {
                fprintf(stderr, "WARNING: cannot open .BIN file: %s.BIN\n", fname);
            }
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
    fwrite(hdr, 1, sizeof(hdr), f);
    fwrite(g.irw_data, 1, data_bytes, f);
    fclose(f);

    if (g.verbose)
        printf("Wrote IRW: %s (%u bytes data, %u bits)\n", path, data_bytes, g.irw_bit);
}

/* =========================================================================
 * Command line
 * ========================================================================= */

static void print_usage(void) {
    printf("loadimg <lod_file> [flags]\n");
    printf("  /X  - do not generate IRW file\n");
    printf("  /T= - directory for table files (.tbl/.asm/.glo)\n");
    printf("  /F= - directory and base for raw file (.irw)\n");
    printf("  /I  - use IMGDIR for source images\n");
    printf("  /D= - specify directory for .lod file\n");
    printf("  /V  - verbose\n");
    printf("  /E  - dual-banked image memory (ED adjustment)\n");
    printf("  /P  - pad to 4-bit boundary\n");
    printf("  /L  - align to 16-bit boundary\n");
    printf("  /B  - bpp from palette size\n");
    printf("  /3  - limit scales to 3\n");
    printf("  /A  - append mode\n");
}

int main(int argc, char *argv[]) {
    if (argc < 2) { print_usage(); return 1; }

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
            case 'X': g.build_raw = 0; break;
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
            case 'L': g.align16 = 1; break;
            case 'B': g.bpp_from_pal = 1; break;
            case '3': g.limit3scales = 1; break;
            case 'A': g.append = 1; break;
            case 'H': print_usage(); return 0;
            default: fprintf(stderr, "Unknown flag: %s\n", a); break;
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
        g.pal_fp = fopen(pal_path, g.append ? "a" : "w");
        if (!g.pal_fp) die("cannot create: %s", pal_path);
    }

    g.irw_alloc = 1024 * 1024;
    g.irw_data = (uint8_t*)calloc(1, g.irw_alloc);
    g.irw_size = 0;
    g.irw_bit = 0;

    scan_bpp(lod_file);
    process_lod(lod_file);

    if (g.build_raw) write_irw(irw_path);

    if (g.asm_fp) {
        fprintf(g.asm_fp, "\t.TEXT\r\n");
        fputc(0x1a, g.asm_fp);
        fclose(g.asm_fp);
    }
    if (g.glo_fp) fclose(g.glo_fp);
    if (g.pal_fp) fclose(g.pal_fp);
    free(g.irw_data);

    printf("Done. %d images processed.\n", g.n_images);
    return 0;
}
