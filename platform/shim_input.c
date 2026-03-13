/*************************************************************
 * platform/shim_input.c
 * SDL2 keyboard / mouse shim
 *************************************************************/

#include <SDL.h>
#include "shim_input.h"

/* ---- relay globals (extern declared in shim_file.h too) ---- */
/* These are defined in shim_file.c; see shim_file.h for the authoritative decl */
extern DWORD shim_eax;
extern DWORD shim_ebx;
extern DWORD shim_ecx;
extern DWORD shim_edx;

/* keyboard-specific */
DWORD shim_zf      = 1;   /* 1 = no key */
WORD  shim_keycode = 0;

/* ---- software key-repeat ----
   SDL2 on Linux/WSLg does not reliably deliver SDL_KEYDOWN repeat events
   (depends on the compositor).  We implement our own repeat in pump_events. */
#define KEY_REPEAT_DELAY_MS  400   /* pause before first repeat */
#define KEY_REPEAT_RATE_MS    50   /* interval between repeats  */
static SDL_Keycode s_held_sym    = SDLK_UNKNOWN;
static WORD        s_held_code   = 0;
static Uint32      s_repeat_next = 0;

/* ---- internal key queue ---- */
#define KEYQ_SIZE 64
static WORD  s_keyq[KEYQ_SIZE];
static int   s_keyq_head = 0;
static int   s_keyq_tail = 0;
static int   s_keyq_count = 0;

static void keyq_push(WORD code)
{
    if (s_keyq_count < KEYQ_SIZE) {
        s_keyq[s_keyq_tail] = code;
        s_keyq_tail = (s_keyq_tail + 1) % KEYQ_SIZE;
        s_keyq_count++;
    }
}

static WORD keyq_pop(void)
{
    WORD code = 0;
    if (s_keyq_count > 0) {
        code = s_keyq[s_keyq_head];
        s_keyq_head = (s_keyq_head + 1) % KEYQ_SIZE;
        s_keyq_count--;
    }
    return code;
}

/* ---- SDL scancode → DOS key (AH=scan, AL=ASCII) ---- */
/* Returns 0 if unmapped */
static WORD sdl_to_dos_key(SDL_Keysym ks)
{
    SDL_Keycode sym   = ks.sym;
    SDL_Keymod  mod   = ks.mod;
    int         shift = (mod & KMOD_SHIFT) != 0;
    int         ctrl  = (mod & KMOD_CTRL)  != 0;
    int         alt   = (mod & KMOD_ALT)   != 0;

    /* ASCII printable range */
    if (sym >= SDLK_SPACE && sym <= SDLK_z && !ctrl && !alt) {
        BYTE ascii = (BYTE)sym;
        BYTE scan  = 0;
        /* DOS scan codes for printable keys */
        if (sym >= SDLK_a && sym <= SDLK_z) {
            /* QWERTY keyboard order — NOT alphabetical */
            static const BYTE alpha_scan[26] = {
                0x1E, /* a */ 0x30, /* b */ 0x2E, /* c */ 0x20, /* d */
                0x12, /* e */ 0x21, /* f */ 0x22, /* g */ 0x23, /* h */
                0x17, /* i */ 0x24, /* j */ 0x25, /* k */ 0x26, /* l */
                0x32, /* m */ 0x31, /* n */ 0x18, /* o */ 0x19, /* p */
                0x10, /* q */ 0x13, /* r */ 0x1F, /* s */ 0x14, /* t */
                0x16, /* u */ 0x2F, /* v */ 0x11, /* w */ 0x2D, /* x */
                0x15, /* y */ 0x2C  /* z */
            };
            scan = alpha_scan[sym - SDLK_a];
            if (shift) ascii = (BYTE)(sym - SDLK_a + 'A');
        } else if (sym >= SDLK_0 && sym <= SDLK_9) {
            scan = (BYTE)(shift ? (0x29 + (sym - SDLK_0)) : (0x0B + (sym - SDLK_0)));
            if (!shift) ascii = (BYTE)sym;
            else {
                const char shifted[] = ")!@#$%^&*(";
                ascii = (BYTE)shifted[sym - SDLK_0];
            }
        } else if (sym == SDLK_SPACE) {
            scan = 0x39; ascii = ' ';
        } else if (sym == SDLK_MINUS) {
            scan = 0x0C; ascii = shift ? '_' : '-';
        } else if (sym == SDLK_EQUALS) {
            scan = 0x0D; ascii = shift ? '+' : '=';
        } else if (sym == SDLK_LEFTBRACKET)  { scan = 0x1A; ascii = shift ? '{' : '['; }
        else if (sym == SDLK_RIGHTBRACKET) { scan = 0x1B; ascii = shift ? '}' : ']'; }
        else if (sym == SDLK_BACKSLASH)    { scan = 0x2B; ascii = shift ? '|' : '\\'; }
        else if (sym == SDLK_SEMICOLON)    { scan = 0x27; ascii = shift ? ':' : ';'; }
        else if (sym == SDLK_QUOTE)        { scan = 0x28; ascii = shift ? '"' : '\''; }
        else if (sym == SDLK_BACKQUOTE)    { scan = 0x29; ascii = shift ? '~' : '`'; }
        else if (sym == SDLK_COMMA)        { scan = 0x33; ascii = shift ? '<' : ','; }
        else if (sym == SDLK_PERIOD)       { scan = 0x34; ascii = shift ? '>' : '.'; }
        else if (sym == SDLK_SLASH)        { scan = 0x35; ascii = shift ? '?' : '/'; }
        if (scan) return (WORD)((scan << 8) | ascii);
    }

    /* Special keys → extended scan codes (AL=0) */
    switch (sym) {
    case SDLK_RETURN:    return (WORD)(0x1C00 | 0x0D); /* Enter */
    case SDLK_ESCAPE:    return (WORD)(0x0100 | 0x1B); /* Esc   */
    case SDLK_BACKSPACE: return (WORD)(0x0E00 | 0x08); /* BS    */
    case SDLK_TAB:       return (WORD)(0x0F00 | 0x09); /* Tab   */
    case SDLK_DELETE:    return ctrl ? 0x9300 : 0x5300;  /* Ctrl+Del / Del */
    case SDLK_INSERT:    return 0x5200;  /* Ins */
    case SDLK_HOME:      return ctrl ? 0x7700 : 0x4700;  /* Ctrl+Home / Home */
    case SDLK_END:       return ctrl ? 0x7500 : 0x4F00;  /* Ctrl+End  / End  */
    case SDLK_PAGEUP:    return alt ? 0x9900 : 0x4900;  /* Alt+PgUp / PgUp */
    case SDLK_PAGEDOWN:  return alt ? 0xA100 : 0x5100;  /* Alt+PgDn / PgDn */
    case SDLK_UP:        return ctrl ? 0x8D00 : (alt ? 0x9800 : 0x4800);
    case SDLK_DOWN:      return ctrl ? 0x9100 : (alt ? 0xA000 : 0x5000);
    case SDLK_LEFT:      return ctrl ? 0x7300 : (alt ? 0x9B00 : 0x4B00);
    case SDLK_RIGHT:     return ctrl ? 0x7400 : (alt ? 0x9D00 : 0x4D00);
    case SDLK_F1:        return 0x3B00;
    case SDLK_F2:        return 0x3C00;
    case SDLK_F3:        return 0x3D00;
    case SDLK_F4:        return 0x3E00;
    case SDLK_F5:        return 0x3F00;
    case SDLK_F6:        return 0x4000;
    case SDLK_F7:        return 0x4100;
    case SDLK_F8:        return 0x4200;
    case SDLK_F9:        return 0x4300;
    case SDLK_F10:       return 0x4400;
    case SDLK_F11:       return 0x8500;
    case SDLK_F12:       return 0x8600;
    default: break;
    }

    /* ctrl+key */
    if (ctrl && sym >= SDLK_a && sym <= SDLK_z) {
        static const BYTE alpha_scan[26] = {
            0x1E, 0x30, 0x2E, 0x20, 0x12, 0x21, 0x22, 0x23,
            0x17, 0x24, 0x25, 0x26, 0x32, 0x31, 0x18, 0x19,
            0x10, 0x13, 0x1F, 0x14, 0x16, 0x2F, 0x11, 0x2D,
            0x15, 0x2C
        };
        BYTE scan  = alpha_scan[sym - SDLK_a];
        BYTE ascii = (BYTE)(sym - SDLK_a + 1);   /* ctrl+A=1 .. ctrl+Z=26 */
        return (WORD)((scan << 8) | ascii);
    }

    /* alt+letter: DOS format AH=scan, AL=0 */
    if (alt && sym >= SDLK_a && sym <= SDLK_z) {
        static const BYTE alpha_scan[26] = {
            0x1E, 0x30, 0x2E, 0x20, 0x12, 0x21, 0x22, 0x23,
            0x17, 0x24, 0x25, 0x26, 0x32, 0x31, 0x18, 0x19,
            0x10, 0x13, 0x1F, 0x14, 0x16, 0x2F, 0x11, 0x2D,
            0x15, 0x2C
        };
        return (WORD)(alpha_scan[sym - SDLK_a] << 8);
    }
    /* alt+backtick */
    if (alt && sym == SDLK_BACKQUOTE) return 0x2900;

    return 0;
}

/* Process SDL events, populating the key queue and mouse state */
static void pump_events(void)
{
    extern void shim_vid_present(void);
    shim_vid_present();   /* flush shadow buffer before waiting for input */
    SDL_Event e;
    while (SDL_PollEvent(&e)) {
        switch (e.type) {
        case SDL_QUIT:
            ExitProcess(0);
            break;
        case SDL_KEYDOWN: {
            if (e.key.repeat) break;   /* handled by our own repeat logic below */
            WORD code = sdl_to_dos_key(e.key.keysym);
            if (code) {
                keyq_push(code);
                s_held_sym    = e.key.keysym.sym;
                s_held_code   = code;
                s_repeat_next = SDL_GetTicks() + KEY_REPEAT_DELAY_MS;
            }
            break;
        }
        case SDL_KEYUP:
            if (e.key.keysym.sym == s_held_sym) {
                s_held_sym  = SDLK_UNKNOWN;
                s_held_code = 0;
            }
            break;
        case SDL_MOUSEMOTION: {
            /* Window: 1280x810, VGA content at (0,10,1280,800) — 2x scale, 10px menu strip */
            int cx = e.motion.x / 2;
            int cy = (e.motion.y - 10) / 2;
            if (cx < 0) cx = 0; else if (cx > 632) cx = 632;
            if (cy < 0) cy = 0; else if (cy > 392) cy = 392;
            shim_ecx = (DWORD)(cx * 4);
            shim_edx = (DWORD)(cy * 4);
            break;
        }
        case SDL_MOUSEBUTTONDOWN:
        case SDL_MOUSEBUTTONUP: {
            Uint32 state = SDL_GetMouseState(NULL, NULL);
            shim_ebx = 0;
            if (state & SDL_BUTTON(SDL_BUTTON_LEFT))  shim_ebx |= 1;
            if (state & SDL_BUTTON(SDL_BUTTON_RIGHT)) shim_ebx |= 2;
            break;
        }
        default:
            break;
        }
    }

    /* Software key-repeat: fire if the held key's timer has elapsed */
    if (s_held_code) {
        Uint32 now = SDL_GetTicks();
        if (now >= s_repeat_next) {
            keyq_push(s_held_code);
            s_repeat_next = now + KEY_REPEAT_RATE_MS;
        }
    }
}

/* ---- mouse scroller anchor (for gad_mousescroller in itos.asm) ---- */
/* The DOS original warped the mouse to center (16000,16000) on entry, then
   computed position = initial_val + (mouse_x - 16000) * mscrollxm / 256.
   We replicate this by capturing the SDL pixel anchor on entry and returning
   (current - anchor)*4 + 16000 so the existing sub cx,RNG/2 logic still works.
   Scale *4 makes mscrollxm=64 give ≈1 data-unit per pixel of drag. */
#define SCROLLER_CENTER 16000

static int s_scroll_anchor_x = 0;
static int s_scroll_anchor_y = 0;

__attribute__((force_align_arg_pointer))
void shim_mouse_scroll_anchor(void)
{
    int raw_x, raw_y;
    SDL_GetMouseState(&raw_x, &raw_y);
    s_scroll_anchor_x = raw_x / 2;
    s_scroll_anchor_y = (raw_y - 10) / 2;
    SDL_GetRelativeMouseState(NULL, NULL);
}

__attribute__((force_align_arg_pointer))
void shim_mouse_read_scroller(void)
{
    int mx, my;
    Uint32 state;
    pump_events();
    state = SDL_GetMouseState(&mx, &my);
    mx = mx / 2;
    my = (my - 10) / 2;
    shim_ecx = (DWORD)(((mx - s_scroll_anchor_x) * 4) + SCROLLER_CENTER);
    shim_edx = (DWORD)(((my - s_scroll_anchor_y) * 4) + SCROLLER_CENTER);
    shim_ebx = 0;
    if (state & SDL_BUTTON(SDL_BUTTON_LEFT))  shim_ebx |= 1;
    if (state & SDL_BUTTON(SDL_BUTTON_RIGHT)) shim_ebx |= 2;
}

/* ---- public functions ---- */

__attribute__((force_align_arg_pointer))
void shim_mouse_detect(void)
{
    shim_eax = 0xFFFF;  /* mouse always present */
}

__attribute__((force_align_arg_pointer))
void shim_mouse_read(void)
{
    pump_events();
    /* shim_ebx/ecx/edx already updated by pump_events via cached state */
    /* Ensure current mouse position is captured */
    {
        int mx, my;
        Uint32 state = SDL_GetMouseState(&mx, &my);
        /* Window: 1280x810, VGA content at (0,10,1280,800) — 2x scale, 10px menu strip */
        mx = mx / 2;
        my = (my - 10) / 2;
        if (mx < 0) mx = 0; else if (mx > 632) mx = 632;
        if (my < 0) my = 0; else if (my > 392) my = 392;
        shim_ecx = (DWORD)(mx * 4);
        shim_edx = (DWORD)(my * 4);
        shim_ebx = 0;
        if (state & SDL_BUTTON(SDL_BUTTON_LEFT))  shim_ebx |= 1;
        if (state & SDL_BUTTON(SDL_BUTTON_RIGHT)) shim_ebx |= 2;
    }
}

__attribute__((force_align_arg_pointer))
void shim_mouse_show(void)
{
    SDL_ShowCursor(SDL_ENABLE);
}

__attribute__((force_align_arg_pointer))
void shim_mouse_hide(void)
{
    SDL_ShowCursor(SDL_DISABLE);
}

__attribute__((force_align_arg_pointer))
void shim_key_check(void)
{
    pump_events();
    shim_zf = (s_keyq_count == 0) ? 1 : 0;
}

__attribute__((force_align_arg_pointer))
void shim_key_get(void)
{
    pump_events();
    if (s_keyq_count > 0) {
        shim_keycode = keyq_pop();
        shim_zf = 0;
    } else {
        shim_keycode = 0;
        shim_zf = 1;
    }
}

__attribute__((force_align_arg_pointer))
DWORD shim_get_shift_state(void)
{
    pump_events();
    const Uint8 *ks = SDL_GetKeyboardState(NULL);
    DWORD result = 0;
    if (ks[SDL_SCANCODE_RSHIFT])  result |= 1;   /* bit 0 = Right Shift  (BIOS 0x417) */
    if (ks[SDL_SCANCODE_LSHIFT])  result |= 2;   /* bit 1 = Left Shift                */
    if (ks[SDL_SCANCODE_LCTRL] ||
        ks[SDL_SCANCODE_RCTRL])   result |= 4;   /* bit 2 = Ctrl                      */
    if (ks[SDL_SCANCODE_LALT]  ||
        ks[SDL_SCANCODE_RALT])    result |= 8;   /* bit 3 = Alt                       */
    return result;
}


