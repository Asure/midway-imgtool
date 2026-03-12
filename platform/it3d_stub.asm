;*************************************************************
;* platform/it3d_stub.asm
;* Stub replacements for it3d.asm and ittex.asm
;* Add more stubs here as link errors identify missing symbols.
;*************************************************************
    .386P
    .model  flat, syscall
    option  casemap:none

    .code

    public  _3d_editorinit
_3d_editorinit proc near
    mov     eax, 0
    ret
_3d_editorinit endp

    public  _3d_draw
_3d_draw proc near
    ret
_3d_draw endp

    public  _3d_drawsync
_3d_drawsync proc near
    ret
_3d_drawsync endp

    public  _3d_drawall
_3d_drawall proc near
    ret
_3d_drawall endp

    end
