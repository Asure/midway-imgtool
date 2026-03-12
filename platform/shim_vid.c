/*************************************************************
 * platform/shim_vid.c
 * VGA Mode X shadow buffer + SDL2 rendering (renderer path)
 *************************************************************/
#include <string.h>
#include <SDL.h>
#include "shim_vid.h"
#include "shim_file.h"   /* relay globals (shim_eax, shim_ecx, shim_esi) */

/* ---- shadow buffer ---- */
/* Each VGA plane is 64 KB on real hardware; the assembly code uses 16-bit DI
   arithmetic that can transiently address offsets 64000..65535 (e.g. when the
   image starts above y=0).  Allocating exactly 65536 bytes per plane matches
   the real hardware and prevents those transient accesses from overflowing. */
BYTE  g_vga_plane[4][65536];
BYTE *g_plane_ptrs[4] = {
    g_vga_plane[0],
    g_vga_plane[1],
    g_vga_plane[2],
    g_vga_plane[3]
};

/* Current write-plane pointer (DWORD holds pointer value) */
DWORD vga_base_p = 0;   /* initialised in shim_vid_init */

/* ---- SDL2 state ---- */
SDL_Color    g_palette[256];
SDL_Window  *g_window   = NULL;
SDL_Surface *g_surface  = NULL;   /* kept for API compat; not used for display */

static SDL_Renderer *s_renderer = NULL;
static SDL_Texture  *s_texture  = NULL;
static Uint32        s_argb_buf[640*400];  /* ARGB8888 conversion buffer */

/* ---- init / shutdown ---- */

void shim_vid_init(void)
{
    if (SDL_Init(SDL_INIT_VIDEO | SDL_INIT_EVENTS) != 0) {
        MessageBoxA(NULL, SDL_GetError(), "SDL_Init failed", MB_OK|MB_ICONERROR);
        ExitProcess(1);
    }

    g_window = SDL_CreateWindow(
        "Image Tool",
        SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED,
        1280, 810,      /* 2x VGA (1280x800) + 10px menu strip */
        SDL_WINDOW_SHOWN);
    if (!g_window) {
        MessageBoxA(NULL, SDL_GetError(), "SDL_CreateWindow failed", MB_OK|MB_ICONERROR);
        ExitProcess(1);
    }

    s_renderer = SDL_CreateRenderer(g_window, -1,
        SDL_RENDERER_ACCELERATED | SDL_RENDERER_PRESENTVSYNC);
    if (!s_renderer) {
        /* fallback to software renderer */
        s_renderer = SDL_CreateRenderer(g_window, -1, SDL_RENDERER_SOFTWARE);
        if (!s_renderer) {
            MessageBoxA(NULL, SDL_GetError(), "SDL_CreateRenderer failed", MB_OK|MB_ICONERROR);
            ExitProcess(1);
        }
    }

    s_texture = SDL_CreateTexture(s_renderer,
        SDL_PIXELFORMAT_ARGB8888,
        SDL_TEXTUREACCESS_STREAMING,
        640, 400);
    if (!s_texture) {
        MessageBoxA(NULL, SDL_GetError(), "SDL_CreateTexture failed", MB_OK|MB_ICONERROR);
        ExitProcess(1);
    }

    /* default initialise palette to greyscale */
    {
        int i;
        for (i = 0; i < 256; i++) {
            g_palette[i].r = (BYTE)i;
            g_palette[i].g = (BYTE)i;
            g_palette[i].b = (BYTE)i;
            g_palette[i].a = 0xFF;
        }
    }

    /* seed vga_base_p to plane 0 */
    vga_base_p = (DWORD)(UINT_PTR)g_vga_plane[0];

    /* clear shadow buffer */
    shim_scr_clr();
}

void shim_vid_shutdown(void)
{
    if (s_texture)  { SDL_DestroyTexture(s_texture);   s_texture  = NULL; }
    if (s_renderer) { SDL_DestroyRenderer(s_renderer); s_renderer = NULL; }
    if (g_window)   { SDL_DestroyWindow(g_window);     g_window   = NULL; }
    SDL_Quit();
}

/* ---- present: deplanarize + palette expand + upload texture ---- */

void shim_vid_present(void)
{
    if (!s_renderer || !s_texture) return;

    /* Deplanarize and convert indexed → ARGB8888 */
    {
        int x, y;
        for (y = 0; y < 400; y++) {
            for (x = 0; x < 640; x++) {
                BYTE idx = g_vga_plane[x & 3][y*160 + (x >> 2)];
                SDL_Color c = g_palette[idx];
                s_argb_buf[y*640 + x] =
                    (0xFF000000u) |
                    ((Uint32)c.r << 16) |
                    ((Uint32)c.g <<  8) |
                    ((Uint32)c.b);
            }
        }
    }

    SDL_UpdateTexture(s_texture, NULL, s_argb_buf, 640 * sizeof(Uint32));
    SDL_RenderClear(s_renderer);
    /* 10px menu strip at top */
    {
        SDL_Rect menu = { 0, 0, 1280, 10 };
        SDL_SetRenderDrawColor(s_renderer, 40, 40, 40, 255);
        SDL_RenderFillRect(s_renderer, &menu);
    }
    /* VGA content 2x scaled below the menu strip */
    {
        SDL_Rect dst = { 0, 10, 1280, 800 };
        SDL_RenderCopy(s_renderer, s_texture, NULL, &dst);
    }
    SDL_RenderPresent(s_renderer);
}

/* ---- palette ---- */

/* Called from asm relay:
   shim_eax (low byte) = 1st DAC color #
   shim_ecx (low word) = # colors
   shim_esi             = pointer to 18-bit (6-bit per channel) RGB triplets */
void shim_setvgapal18_impl(void)
{
    BYTE    first = (BYTE)(shim_eax & 0xFF);
    int     count = (int)(shim_ecx & 0xFFFF);
    const BYTE *src = (const BYTE *)(UINT_PTR)shim_esi;
    int i;

    for (i = 0; i < count && (first + i) < 256; i++) {
        BYTE r6 = *src++;
        BYTE g6 = *src++;
        BYTE b6 = *src++;
        int idx = first + i;
        /* 6-bit → 8-bit: shift left 2, duplicate top 2 bits in low 2 */
        g_palette[idx].r = (BYTE)((r6 << 2) | (r6 >> 4));
        g_palette[idx].g = (BYTE)((g6 << 2) | (g6 >> 4));
        g_palette[idx].b = (BYTE)((b6 << 2) | (b6 >> 4));
        g_palette[idx].a = 0xFF;
    }
}

/* Called from asm relay:
   shim_eax (low byte) = 1st DAC color #
   shim_ecx (low word) = # colors
   shim_esi             = pointer to packed 15-bit RGB words (GGGBBBBB XRRRRRGG) */
void shim_setvgapal15_impl(void)
{
    BYTE    first = (BYTE)(shim_eax & 0xFF);
    int     count = (int)(shim_ecx & 0xFFFF);
    const BYTE *src = (const BYTE *)(UINT_PTR)shim_esi;
    int i;

    for (i = 0; i < count && (first + i) < 256; i++) {
        /* DOS 15-bit format: word = XRRRRRGG GGGBBBBB (little-endian) */
        BYTE lo = *src++;
        BYTE hi = *src++;
        WORD w  = (WORD)(lo | (hi << 8));
        int idx = first + i;
        BYTE r5 = (BYTE)((w >> 10) & 0x1F);
        BYTE g5 = (BYTE)((w >>  5) & 0x1F);
        BYTE b5 = (BYTE)( w        & 0x1F);
        /* 5-bit → 8-bit */
        g_palette[idx].r = (BYTE)((r5 << 3) | (r5 >> 2));
        g_palette[idx].g = (BYTE)((g5 << 3) | (g5 >> 2));
        g_palette[idx].b = (BYTE)((b5 << 3) | (b5 >> 2));
        g_palette[idx].a = 0xFF;
    }
}

/* ---- clear screen ---- */

void shim_scr_clr(void)
{
    memset(g_vga_plane, 0, sizeof(g_vga_plane));
}

/* Replaces ds:[46Ch] BIOS 18.2Hz tick counter used in test_main benchmark */
DWORD shim_gettick(void)
{
    return GetTickCount();
}

/* Clear 320x200 image window: 80 bytes/row (320/4), 200 rows, all 4 planes */
void shim_iwin_clr(void)
{
    int p, y;
    for (p = 0; p < 4; p++)
        for (y = 0; y < 200; y++)
            memset(&g_vga_plane[p][y * 160], 0, 80);
}
