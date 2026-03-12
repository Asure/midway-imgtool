/*************************************************************
 * platform/compat.h
 * Cross-platform compatibility layer.
 *
 * On Windows : thin wrapper around <windows.h> — no change to
 *              existing code.
 * On Linux   : provide equivalent types + map the small set of
 *              Win32 calls we use to SDL2 / POSIX equivalents.
 *************************************************************/
#pragma once

#ifdef _WIN32

#  ifndef WIN32_LEAN_AND_MEAN
#    define WIN32_LEAN_AND_MEAN
#  endif
#  include <windows.h>

#else /* Linux / Unix ------------------------------------------------- */

#  include <stdint.h>
#  include <stdlib.h>
#  include <string.h>
#  include <strings.h>    /* strncasecmp */
#  include <limits.h>
#  include <unistd.h>
#  include <SDL.h>

/* ---- Windows primitive types ---- */
typedef uint8_t   BYTE;
typedef uint16_t  WORD;
typedef uint32_t  DWORD;
typedef int16_t   SHORT;
typedef int32_t   LONG;
typedef uint32_t  UINT;
typedef uintptr_t UINT_PTR;
typedef char *    LPSTR;
typedef const char * LPCSTR;

#  ifndef MAX_PATH
#    define MAX_PATH  PATH_MAX
#  endif
#  ifndef TRUE
#    define TRUE  1
#    define FALSE 0
#  endif

/* ---- MessageBoxA → SDL_ShowSimpleMessageBox ---- */
#  define MB_OK              0x00u
#  define MB_ICONERROR       0x10u
#  define MB_ICONINFORMATION 0x40u

static inline void _compat_msgbox(const char *title, const char *text, unsigned flags)
{
    Uint32 sdl_flags = (flags & MB_ICONERROR)
                       ? SDL_MESSAGEBOX_ERROR
                       : SDL_MESSAGEBOX_INFORMATION;
    SDL_ShowSimpleMessageBox(sdl_flags, title, text, NULL);
}
#  define MessageBoxA(hwnd, text, title, flags) \
    _compat_msgbox((title), (text), (unsigned)(flags))

/* ---- ExitProcess → exit ---- */
#  define ExitProcess(code) exit(code)

/* ---- GetTickCount → SDL_GetTicks ---- */
#  define GetTickCount() ((DWORD)SDL_GetTicks())

/* ---- MSVC string helpers ---- */
#  define _snprintf   snprintf
#  define _strnicmp   strncasecmp

/* ---- Drive ops — no-op on Linux ---- */
#  define _chdrive(d) ((void)0)
#  define _getdrive() (3)        /* pretend 'C:' */
#  define _chdir      chdir

/* ---- Path separator ---- */
#  define PATH_SEP_CHAR '/'
#  define PATH_SEP      "/"

#endif /* !_WIN32 */

/* Windows always uses backslash */
#ifdef _WIN32
#  define PATH_SEP_CHAR '\\'
#  define PATH_SEP      "\\"
#endif
