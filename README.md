# midway-imgtool
IMGTOOL for editing and creating IMG container files used by various Midway games.

![imgtool image](https://raw.githubusercontent.com/Asure/midway-imgtool/main/main.png)

# Dosbox users: 

You MUST use dosbox with ET4000 support, and the bios bin file.
Set the options in the conf file:

machine                                         = svga_et4000

Include the ET4000.BIN file in the dosbox installation. 
https://github.com/BaRRaKudaRain/PCem-ROMs/blob/master/

# Setup

Copy DOS4GW.EXE, IT.EXE and IT.HLP into C:\BIN. This is the default directory where IT checks for cfg and hlp files.

# useage

Press l to load a .img file. press h for help. I updated the hlp file quite a bit.
Right-click the top row of pixels for main menu options.

# Notes

There's  learning curve and understanding curve.. 
The IMG files are later build into IRW data for roms using the LOD files and load2.exe.
This generates a bunch if IMGPAL*.ASM and IMGTBL*.ASM along with .tbl and .glo files.
If you change an IMG file 'early' in the rom, ALL gfx roms and your whole game project needs to be rebuilt.
