;*************************************************************
;* platform/shim_file_thunks.asm
;* MASM thunks: bridge DOS register convention → C relay globals → CF result
;*
;* Convention for each thunk:
;*   1. Copy live input registers to relay globals
;*   2. call the _impl function
;*   3. Restore output registers from relay globals
;*   4. Set CF from shim_carry (0=success, 1=error)
;*************************************************************
    .386P
    .model  flat, syscall
    option  casemap:none

    .data
    externdef   _shim_eax:dword
    externdef   _shim_ebx:dword
    externdef   _shim_ecx:dword
    externdef   _shim_edx:dword
    externdef   _shim_esi:dword
    externdef   _shim_carry:dword

    .code
    externdef   _shim_i21_openr_impl:near
    externdef   _shim_i21_close_impl:near
    externdef   _shim_i21_read_impl:near
    externdef   _shim_i21_write_impl:near
    externdef   _shim_i21_create_impl:near
    externdef   _shim_i21_setfps_impl:near
    externdef   _shim_i21_setfpc_impl:near
    externdef   _shim_i21_setfpe_impl:near
    externdef   _shim_i21_getdrv_impl:near
    externdef   _shim_i21_setdrv_impl:near
    externdef   _shim_i21_setcd_impl:near
    externdef   _shim_i21_getcwd_impl:near
    externdef   _shim_i21_rename_impl:near
    externdef   _shim_i21_delete_impl:near
    externdef   _shim_i21_findfile_impl:near
    externdef   _shim_i21_findnext_impl:near

;----- helper macro: set CF from shim_carry, then ret -----
; Uses no registers.
SET_CF_AND_RET macro
    cmp     _shim_carry, 0
    jz      @F
    stc
    ret
@@: clc
    ret
endm

;*************************************************************
;* I21OPENR  (3D00h): EDX=*filename → EAX=handle
;*************************************************************
    public shim_i21_openr
shim_i21_openr proc near
    mov     _shim_edx, edx
    call    _shim_i21_openr_impl
    mov     eax, _shim_eax
    SET_CF_AND_RET
shim_i21_openr endp

;*************************************************************
;* I21CLOSE  (3Eh): EBX=handle
;*************************************************************
    public shim_i21_close
shim_i21_close proc near
    mov     _shim_ebx, ebx
    call    _shim_i21_close_impl
    SET_CF_AND_RET
shim_i21_close endp

;*************************************************************
;* I21READ   (3Fh): EBX=handle, ECX=count, EDX=buffer → EAX=bytes
;*************************************************************
    public shim_i21_read
shim_i21_read proc near
    mov     _shim_ebx, ebx
    mov     _shim_ecx, ecx
    mov     _shim_edx, edx
    call    _shim_i21_read_impl
    mov     eax, _shim_eax
    mov     edx, _shim_edx  ; restore: DOS INT 21h preserves DX across read
    SET_CF_AND_RET
shim_i21_read endp

;*************************************************************
;* I21WRITE  (40h): EBX=handle, ECX=count, EDX=buffer → EAX=bytes
;*************************************************************
    public shim_i21_write
shim_i21_write proc near
    mov     _shim_ebx, ebx
    mov     _shim_ecx, ecx
    mov     _shim_edx, edx
    call    _shim_i21_write_impl
    mov     eax, _shim_eax
    mov     edx, _shim_edx  ; restore: DOS INT 21h preserves DX across write
    SET_CF_AND_RET
shim_i21_write endp

;*************************************************************
;* I21CREATE (3Ch): ECX=attrs, EDX=*filename → EAX=handle
;*************************************************************
    public shim_i21_create
shim_i21_create proc near
    mov     _shim_ecx, ecx
    mov     _shim_edx, edx
    call    _shim_i21_create_impl
    mov     eax, _shim_eax
    SET_CF_AND_RET
shim_i21_create endp

;*************************************************************
;* I21SETFPS (4200h): EBX=hdl, ECX=offhi, EDX=offlo → EDX:AX=pos
;*************************************************************
    public shim_i21_setfps
shim_i21_setfps proc near
    mov     _shim_ebx, ebx
    mov     _shim_ecx, ecx
    mov     _shim_edx, edx
    call    _shim_i21_setfps_impl
    mov     eax, _shim_eax   ; low 16 in AX
    mov     edx, _shim_edx   ; high 16 in DX
    SET_CF_AND_RET
shim_i21_setfps endp

;*************************************************************
;* I21SETFPC (4201h): same calling convention as SETFPS
;*************************************************************
    public shim_i21_setfpc
shim_i21_setfpc proc near
    mov     _shim_ebx, ebx
    mov     _shim_ecx, ecx
    mov     _shim_edx, edx
    call    _shim_i21_setfpc_impl
    mov     eax, _shim_eax
    mov     edx, _shim_edx
    SET_CF_AND_RET
shim_i21_setfpc endp

;*************************************************************
;* I21SETFPE (4202h): same
;*************************************************************
    public shim_i21_setfpe
shim_i21_setfpe proc near
    mov     _shim_ebx, ebx
    mov     _shim_ecx, ecx
    mov     _shim_edx, edx
    call    _shim_i21_setfpe_impl
    mov     eax, _shim_eax
    mov     edx, _shim_edx
    SET_CF_AND_RET
shim_i21_setfpe endp

;*************************************************************
;* I21GETDRV (19h): → AL=drive (0=A)
;*************************************************************
    public shim_i21_getdrv
shim_i21_getdrv proc near
    call    _shim_i21_getdrv_impl
    mov     al, byte ptr _shim_eax
    clc
    ret
shim_i21_getdrv endp

;*************************************************************
;* I21SETDRV (0Eh): DL=drive → AL=num_drives
;*************************************************************
    public shim_i21_setdrv
shim_i21_setdrv proc near
    movzx   eax, dl
    mov     _shim_edx, eax
    call    _shim_i21_setdrv_impl
    mov     al, byte ptr _shim_eax
    clc
    ret
shim_i21_setdrv endp

;*************************************************************
;* I21SETCD  (3Bh): EDX=*path
;*************************************************************
    public shim_i21_setcd
shim_i21_setcd proc near
    mov     _shim_edx, edx
    call    _shim_i21_setcd_impl
    SET_CF_AND_RET
shim_i21_setcd endp

;*************************************************************
;* shim_i21_getcwd (47h): DL=drive, ESI=*buf
;*************************************************************
    public shim_i21_getcwd
shim_i21_getcwd proc near
    movzx   eax, dl
    mov     _shim_edx, eax
    mov     _shim_esi, esi
    call    _shim_i21_getcwd_impl
    SET_CF_AND_RET
shim_i21_getcwd endp

;*************************************************************
;* I21RENAME (56h): EDX=*old, EDI=*new
;*************************************************************
    public shim_i21_rename
shim_i21_rename proc near
    mov     _shim_edx, edx
    mov     _shim_esi, edi      ; DOS: ES:DI = new name → flat: EDI
    call    _shim_i21_rename_impl
    mov     ax, word ptr _shim_eax   ; AX = error code on CF=1
    SET_CF_AND_RET
shim_i21_rename endp

;*************************************************************
;* I21DELETE (41h): EDX=*path
;*************************************************************
    public shim_i21_delete
shim_i21_delete proc near
    mov     _shim_edx, edx
    call    _shim_i21_delete_impl
    SET_CF_AND_RET
shim_i21_delete endp

;*************************************************************
;* shim_i21_findfile (4Eh): ECX=attr, EDX=*pattern
;*************************************************************
    public shim_i21_findfile
shim_i21_findfile proc near
    mov     _shim_ecx, ecx
    mov     _shim_edx, edx
    call    _shim_i21_findfile_impl
    SET_CF_AND_RET
shim_i21_findfile endp

;*************************************************************
;* shim_i21_findnext (4Fh): (uses saved HANDLE)
;* DOS INT 21h 4Fh preserves all regs except AX/flags.
;* EDX is live in dir_scan's insert loops (fentry write ptr),
;* so it must be preserved across the C call.
;*************************************************************
    public shim_i21_findnext
shim_i21_findnext proc near
    push    edx                     ; preserve — caller uses EDX as fentry write ptr
    push    ecx                     ; preserve — match DOS INT 21h convention
    call    _shim_i21_findnext_impl
    pop     ecx
    pop     edx
    SET_CF_AND_RET
shim_i21_findnext endp

    end
