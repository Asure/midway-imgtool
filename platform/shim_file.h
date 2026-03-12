/*************************************************************
 * platform/shim_file.h
 * DOS INT 21h file/directory shims
 * Relay globals used by all shim modules
 *************************************************************/
#pragma once
#ifndef WIN32_LEAN_AND_MEAN
#define WIN32_LEAN_AND_MEAN
#endif
#include <windows.h>

#ifdef __cplusplus
extern "C" {
#endif

/* ---- relay globals ---- */
/* All shim C impl functions read inputs / write outputs via these globals.
   The MASM thunks in shim_file_thunks.asm load asm regs → relay before call,
   then restore relay → asm regs after call. */
extern DWORD shim_eax;   /* return value (handle, bytes read/written, new pos low) */
extern DWORD shim_ebx;   /* BX = file handle, drive number, button bits           */
extern DWORD shim_ecx;   /* CX = byte count, find-first attribute, offset high    */
extern DWORD shim_edx;   /* DX = buffer/filename pointer, offset low, Y*4         */
extern DWORD shim_esi;   /* SI = rename-target, getcwd buffer, RGB palette ptr    */
extern DWORD shim_carry; /* 0 = success (CF=0), 1 = error (CF=1)                 */

/* ---- exe directory (populated by main before any file ops) ---- */
extern char exe_dir[MAX_PATH];

/* ---- file I/O impl functions ---- */
/* Each is called by an asm thunk in shim_file_thunks.asm */
void shim_i21_openr_impl(void);    /* 3D00h: EDX=*path  → EAX=handle */
void shim_i21_close_impl(void);    /* 3Eh:   EBX=handle             */
void shim_i21_read_impl(void);     /* 3Fh:   EBX=hdl, ECX=cnt, EDX=buf → EAX=bytes_read */
void shim_i21_write_impl(void);    /* 40h:   EBX=hdl, ECX=cnt, EDX=buf → EAX=bytes_written */
void shim_i21_create_impl(void);   /* 3Ch:   ECX=attrs, EDX=*path → EAX=handle */
void shim_i21_setfps_impl(void);   /* 4200h: EBX=hdl, ECX=offhi, EDX=offlo → EDX:AX=pos */
void shim_i21_setfpc_impl(void);   /* 4201h: same */
void shim_i21_setfpe_impl(void);   /* 4202h: same */
void shim_i21_getdrv_impl(void);   /* 19h:   → AL=drive (0=A) */
void shim_i21_setdrv_impl(void);   /* 0Eh:   DL=drive → AL=num_drives */
void shim_i21_setcd_impl(void);    /* 3Bh:   EDX=*path */
void shim_i21_getcwd_impl(void);   /* 47h:   DL=drive, ESI=*buf */
void shim_i21_rename_impl(void);   /* 56h:   EDX=*old, ESI=*new */
void shim_i21_delete_impl(void);   /* 41h:   EDX=*path */
void shim_i21_findfile_impl(void); /* 4Eh:   ECX=attr, EDX=*pattern */
void shim_i21_findnext_impl(void); /* 4Fh:   (uses saved HANDLE) */

/* error message box */
void shim_msgbox_error(void);      /* EDX = *DOS '$'-terminated string */

#ifdef __cplusplus
}
#endif
