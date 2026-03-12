/*************************************************************
 * platform/shim_vid.h
 * VGA Mode X (planar 640x400) shadow buffer + SDL2 rendering
 *************************************************************/
#pragma once
#include "compat.h"
#include <SDL.h>

#ifdef __cplusplus
extern "C" {
#endif

/* 4-plane VGA Mode X shadow buffer: 65536 bytes per plane (matches real VGA 64 KB) */
extern BYTE g_vga_plane[4][65536];

/* Array of pointers into each plane (g_plane_ptrs[n] = &g_vga_plane[n][0]) */
extern BYTE *g_plane_ptrs[4];

/* Current write-plane base pointer — updated on every SC_MAPMASK write.
   Declared as DWORD (holds a pointer value) so asm can do: mov eax,[_vga_base_p] */
extern DWORD vga_base_p;

/* SDL2 state */
extern SDL_Color  g_palette[256];
extern SDL_Window  *g_window;
extern SDL_Surface *g_surface;  /* kept for API compat; display uses renderer */

/* Relay globals shared with asm (defined in shim_file.c) */
extern DWORD shim_eax;
extern DWORD shim_ecx;
extern DWORD shim_esi;

/* Functions */
void shim_vid_init(void);
void shim_vid_present(void);
void shim_vid_shutdown(void);
void shim_setvgapal18_impl(void);   /* AL=1st color, CX=count, ESI=*RGB18 */
void shim_setvgapal15_impl(void);   /* AL=1st color, CX=count, ESI=*RGB15 words */
void shim_scr_clr(void);
void shim_iwin_clr(void);  /* clear 320x200 image window (80 bytes/row, 200 rows, all 4 planes) */
DWORD shim_gettick(void);  /* replaces ds:[46Ch] BIOS 18.2Hz timer — returns GetTickCount() */

#ifdef __cplusplus
}
#endif
