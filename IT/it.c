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
#include	<dos.h>
#include	<sys\types.h>
#include	<sys\stat.h>
#include	<signal.h>


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


void	main(int argc,char *argv[])
{
//	int	i;
//	FILE	*f_p;
//	char	buf[80];

	char	*c_p;


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

	osmain(c_p);



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