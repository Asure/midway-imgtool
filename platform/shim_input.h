/*************************************************************
 * platform/shim_input.h
 * SDL2 keyboard / mouse relay
 *************************************************************/
#pragma once
#include "compat.h"

#ifdef __cplusplus
extern "C" {
#endif

/* Mouse relay globals (read by asm after shim_mouse_read) */
extern DWORD shim_ebx;   /* button bits (bit0=left, bit1=right) */
extern DWORD shim_ecx;   /* mouse X * 4 */
extern DWORD shim_edx;   /* mouse Y * 4 */

/* Keyboard relay globals */
extern DWORD shim_zf;      /* 1 = no key waiting, 0 = key available */
extern WORD  shim_keycode; /* AH=DOS scan code, AL=ASCII */

/* eax relay (used by mouse_detect) */
extern DWORD shim_eax;

/* Functions called from asm */
void shim_mouse_detect(void);          /* AX=0 reset: always succeeds */
void shim_mouse_read(void);            /* AX=3 read: fills shim_ebx/ecx/edx */
void shim_mouse_show(void);            /* AX=1 show cursor */
void shim_mouse_hide(void);            /* AX=2 hide cursor */
void shim_mouse_scroll_anchor(void);   /* capture drag anchor for gad_mousescroller */
void shim_mouse_read_scroller(void);   /* anchor-relative read: ecx/edx = (delta*4)+16000 */
void shim_key_check(void);      /* AH=11h peek: sets shim_zf */
void shim_key_get(void);        /* AH=10h get: sets shim_keycode */
DWORD shim_get_shift_state(void); /* returns bit0=LShift, bit1=RShift */

#ifdef __cplusplus
}
#endif
