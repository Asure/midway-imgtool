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
#       on Linux install libsdl2-dev; find_package works automatically.
find_package(SDL2 REQUIRED)

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
    target_compile_options(imgtool PRIVATE -m32)
    target_link_options(imgtool PRIVATE -m32)
endif()
