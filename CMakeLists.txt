cmake_minimum_required(VERSION 3.20)

# ---------------------------------------------------------------------------
# Assembler selection — must happen BEFORE project() enables the ASM language.
#
# Windows : MASM (ships with Visual Studio, no extra install needed).
# Linux   : jwasm or uasm — open-source MASM-compatible assembler.
#           Install:  sudo apt install jwasm
#               or    https://github.com/Terraspace/UASM/releases
# ---------------------------------------------------------------------------
if(WIN32)
    set(ASM_LANG ASM_MASM)
else()
    find_program(JWASM_EXECUTABLE NAMES jwasm uasm
        DOC "MASM-compatible assembler (jwasm or uasm)")
    if(NOT JWASM_EXECUTABLE)
        message(FATAL_ERROR
            "jwasm/uasm not found.\n"
            "  sudo apt install jwasm\n"
            "  or https://github.com/Terraspace/UASM/releases")
    endif()
    set(CMAKE_ASM_COMPILER "${JWASM_EXECUTABLE}" CACHE FILEPATH "" FORCE)
    set(ASM_LANG ASM)
endif()

project(imgtool C ${ASM_LANG})

# SDL2: on Windows pass -DSDL2_DIR=... (handled by build.ps1).
#       on Linux we build 32-bit, so manually target i386 SDL2.
if(WIN32)
    find_package(SDL2 REQUIRED)
else()
    # 32-bit build: use i386 SDL2 directly to avoid linking 64-bit .so
    set(SDL2_INCLUDE_DIRS "/usr/include/SDL2;/usr/include/x86_64-linux-gnu")
    set(SDL2_LIBRARIES "-L/usr/lib/i386-linux-gnu -lSDL2")
    add_library(SDL2::SDL2 INTERFACE IMPORTED)
    set_target_properties(SDL2::SDL2 PROPERTIES
        INTERFACE_INCLUDE_DIRECTORIES "${SDL2_INCLUDE_DIRS}"
        INTERFACE_LINK_LIBRARIES      "${SDL2_LIBRARIES}")
    add_library(SDL2::SDL2main INTERFACE IMPORTED)
endif()

# ---- Assembler flags -------------------------------------------------------
if(WIN32)
    # /c=compile-only  /Zi=debug  /Zp1=byte-pack structs  /coff=32-bit COFF
    set(CMAKE_ASM_MASM_FLAGS "/c /Zi /Zp1 /coff")
else()
    # -elf=ELF32 output  -Zp1=byte-pack structs  -Zi=debug info
    set(CMAKE_ASM_COMPILE_OBJECT
        "<CMAKE_ASM_COMPILER> -elf -Zp1 <INCLUDES> -Fo <OBJECT> <SOURCE>")
endif()

# ---- Sources ---------------------------------------------------------------
add_executable(imgtool
    IT/it.c
    IT/itos.asm
    IT/itimg.asm
    platform/it3d_stub.asm
    platform/shim_file_thunks.asm
    platform/shim_vid.c
    platform/shim_input.c
    platform/shim_file.c
)

target_include_directories(imgtool PRIVATE
    platform
    IT
)

target_link_libraries(imgtool PRIVATE
    SDL2::SDL2
    SDL2::SDL2main
)

# ---- Platform-specific flags -----------------------------------------------
if(WIN32)
    # GUI subsystem — SDL2main bridges WinMain -> main
    set_target_properties(imgtool PROPERTIES WIN32_EXECUTABLE TRUE)
endif()

if(MSVC)
    target_compile_options(imgtool PRIVATE /W3)
    # MASM /coff objects carry no SAFESEH records
    target_link_options(imgtool PRIVATE /SAFESEH:NO /MAP)
endif()

if(NOT WIN32)
    # asm + shim layer is all x86-32; force 32-bit output
    target_compile_options(imgtool PRIVATE -m32 -mstackrealign)
    target_link_options(imgtool PRIVATE -m32 -no-pie -Wl,-z,noexecstack
        "-Wl,--version-script=${CMAKE_CURRENT_SOURCE_DIR}/platform/linux_hide_syms.ld")

    # ELF has no leading underscore on C symbols, but all .asm files were
    # written for COFF/Windows where C symbols are _name.  Create linker
    # aliases  _foo = foo  for every C symbol the asm references as _foo.
    set(_ELF_SYMS
        g_plane_ptrs fpath_s
        imgenv_s tgaenv_s mdlenv_s usr1env_s usr2env_s usr3env_s
        shim_carry shim_eax shim_ebx shim_ecx shim_edx shim_esi
        shim_zf shim_keycode
        shim_get_shift_state shim_gettick
        shim_vid_init shim_vid_present shim_vid_shutdown
        shim_scr_clr shim_iwin_clr
        shim_setvgapal18_impl shim_setvgapal15_impl
        shim_mouse_detect shim_mouse_read shim_mouse_show shim_mouse_hide
        shim_mouse_scroll_anchor shim_mouse_read_scroller
        shim_key_check shim_key_get
        shim_msgbox_error
        shim_i21_openr_impl shim_i21_close_impl
        shim_i21_read_impl shim_i21_write_impl shim_i21_create_impl
        shim_i21_setfps_impl shim_i21_setfpc_impl shim_i21_setfpe_impl
        shim_i21_getdrv_impl shim_i21_setdrv_impl shim_i21_setcd_impl
        shim_i21_getcwd_impl shim_i21_rename_impl shim_i21_delete_impl
        shim_i21_findfile_impl shim_i21_findnext_impl
        vga_base_p
    )
    set(_ELF_DEFSYMS "")
    foreach(_s ${_ELF_SYMS})
        list(APPEND _ELF_DEFSYMS "-Wl,--defsym,_${_s}=${_s}")
    endforeach()
    # These are defined in itos.asm with COFF-style _name; C references them without underscore
    list(APPEND _ELF_DEFSYMS "-Wl,--defsym,osmain=_osmain")
    list(APPEND _ELF_DEFSYMS "-Wl,--defsym,mempool_p=_mempool_p")
    list(APPEND _ELF_DEFSYMS "-Wl,--defsym,mempoolsz=_mempoolsz")
    target_link_options(imgtool PRIVATE ${_ELF_DEFSYMS})
endif()
