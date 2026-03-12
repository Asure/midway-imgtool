/****************************************************************
*
* Title:				Image tool (IT)
* Software:			Shawn Liptak
* Initiated:		6/2/92
*
* Modified:			12/10/93 - Started Watcom C / DOS4GW version
*
* COPYRIGHT (C) 1992,1993,1994 WILLIAMS ELECTRONICS GAMES, INC.
*
*.Last mod - 3/4/94 20:01
****************************************************************/



#include	<string.h>
#include	<stdlib.h>
#include	<stdio.h>
#include	<time.h>
#include	<sys/types.h>
#include	<sys/stat.h>
#include	<signal.h>
#ifndef WIN32_LEAN_AND_MEAN
#define WIN32_LEAN_AND_MEAN
#endif
#include	<windows.h>
#include	"shim_vid.h"
#include	"shim_file.h"


long	conv_ftoi(float *f);
long	conv_radtoi(float *f);

char	imgenv_s[80];
char	tgaenv_s[80];
char	mdlenv_s[80];
char	usr1env_s[80];
char	usr2env_s[80];
char	usr3env_s[80];

extern long	*mempool_p;
extern long	mempoolsz;


sig_atomic_t	sigcnt;

void	cbreak(int sig_no)
{
	++sigcnt;
}


/* asm entry point — itos.asm defines _osmain (MSVC _cdecl convention).
   The original Watcom trailing-underscore has been renamed in itos.asm. */
void osmain(char *c_p);

int	main(int argc,char *argv[])
{
//	int	i;
//	FILE	*f_p;
//	char	buf[80];

	char	*c_p;

	/* Populate exe_dir so shim_file.c can remap "c:\bin\" paths */
	{
		char full[MAX_PATH];
		if (GetModuleFileNameA(NULL, full, sizeof(full))) {
			char *slash = strrchr(full, '\\');
			if (slash) { *slash = '\0'; strncpy(exe_dir, full, MAX_PATH-1); }
		}
	}


	if (c_p = getenv("IMGDIR")) strcpy(imgenv_s, c_p);
	if (c_p = getenv("TGADIR")) strcpy(tgaenv_s, c_p);
	if (c_p = getenv("MODELS")) strcpy(mdlenv_s, c_p);
	if (c_p = getenv("ITUSR1")) strcpy(usr1env_s, c_p);
	if (c_p = getenv("ITUSR2")) strcpy(usr2env_s, c_p);
	if (c_p = getenv("ITUSR3")) strcpy(usr3env_s, c_p);


	mempoolsz = 16*1024*1024;

	while ( !(mempool_p = malloc(mempoolsz)) ) {

		mempoolsz -= 256*1024;
		if (mempoolsz <= 0) break;
	}



//	if (!(f_p = fopen("it.hlp","r")) ) {
//		return;
//	}
//
//	fread(buf,10,1,f_p);
//	fclose(f_p);


	c_p = 0;
	if (argc > 1) c_p = argv[1];

	{
		LPEXCEPTION_POINTERS g_ep = NULL;
		__try {
			osmain(c_p);
		} __except (g_ep = GetExceptionInformation(), EXCEPTION_EXECUTE_HANDLER) {
			DWORD code  = g_ep ? g_ep->ExceptionRecord->ExceptionCode   : 0;
			PVOID addr  = g_ep ? g_ep->ExceptionRecord->ExceptionAddress : 0;
			DWORD base  = (DWORD)(UINT_PTR)GetModuleHandleA(NULL);
			DWORD rva   = (DWORD)(UINT_PTR)addr - base;
			DWORD acc   = (g_ep && g_ep->ExceptionRecord->NumberParameters >= 2)
			              ? (DWORD)g_ep->ExceptionRecord->ExceptionInformation[1] : 0;
			DWORD eax_v = g_ep ? (DWORD)g_ep->ContextRecord->Eax : 0;
			DWORD ecx_v = g_ep ? (DWORD)g_ep->ContextRecord->Ecx : 0;
			DWORD edx_v = g_ep ? (DWORD)g_ep->ContextRecord->Edx : 0;
			DWORD esi_v = g_ep ? (DWORD)g_ep->ContextRecord->Esi : 0;
			DWORD edi_v = g_ep ? (DWORD)g_ep->ContextRecord->Edi : 0;
			DWORD esp_v = g_ep ? (DWORD)g_ep->ContextRecord->Esp : 0;
			{
				char crash_path[MAX_PATH];
				_snprintf(crash_path, sizeof(crash_path), "%s\\crash.txt", exe_dir);
				FILE *f = fopen(crash_path, "w");
				if (f) {
					fprintf(f,
						"Exception: 0x%08X\n"
						"EIP:       0x%08X\n"
						"RVA:       0x%08X\n"
						"Accessed:  0x%08X\n"
						"Base:      0x%08X\n"
						"EAX=%08X ECX=%08X EDX=%08X\n"
						"ESI=%08X EDI=%08X ESP=%08X\n",
						(unsigned)code, (unsigned)(UINT_PTR)addr,
						(unsigned)rva, (unsigned)acc, (unsigned)base,
						eax_v, ecx_v, edx_v, esi_v, edi_v, esp_v);
					fclose(f);
				}
				MessageBoxA(NULL, crash_path, "Crash written to:", MB_OK | MB_ICONERROR);
			}
		}
	}



}


long	conv_ftoi(float *f)
{
	return( (long) *f );
}


long	conv_radtoi(float *f)
{
	return( (long) (*f*512/3.141592654) );
}



// EOF
