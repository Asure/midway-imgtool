if .%1==. goto instr
if not .%2==. goto loadonly
call makeclip %1
:loadonly
REM e:
REM cd\frm
makelod %1  %1
set srcdir=c:\video\kombat\movie
set imgdir=c:\video\kombat\movie
LOADIMG %1 /Y8 /V 
set srcdir=c:\video\kombat\img
set imgdir=c:\video\kombat\img
if .%2==./LG goto gspot
sdbl unzip.out
goto byebye
:gspot
gspot -fgo.scr unzip
goto byebye
:instr
echo off
echo  .Invoke the MOVIE command as follows...
echo  .
echo  .        MOVIE  name       where name was the name given to
echo  . 			 the frame file in the WTARG program.
echo  .
echo  .To view a previously compressed sequence, type...
echo  .
echo  .        MOVIE  name  /L       (for Load only)
echo  .
:byebye
