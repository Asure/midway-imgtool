cmake_minimum_required(VERSION 3.20)
project(imgtool C ASM_MASM)

enable_language(ASM_MASM)

# SDL2: set SDL2_DIR to the cmake/ subdir of the SDL2 VC dev package
# (handled by build.ps1 which passes -DSDL2_DIR=...)
find_package(SDL2 REQUIRED)

# MASM flags: /c=compile only, /Zi=debug, /Zp1=byte align structs,
#             /coff=COFF output (32-bit), /safeseh-=disable safe SEH
set(CMAKE_ASM_MASM_FLAGS "/c /Zi /Zp1 /coff")

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

# Windows GUI subsystem (SDL2main provides WinMain → main bridge)
set_target_properties(imgtool PROPERTIES WIN32_EXECUTABLE TRUE)

if(MSVC)
    # /Zp1 only for ASM (via CMAKE_ASM_MASM_FLAGS); C files use default alignment
    # so Windows SDK headers (winnt.h) are not broken.
    target_compile_options(imgtool PRIVATE /W3)
    # MASM /coff objects have no SAFESEH records; disable the requirement
    target_link_options(imgtool PRIVATE /SAFESEH:NO /MAP)
endif()
