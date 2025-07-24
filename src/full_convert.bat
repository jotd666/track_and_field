rem ..\assets\amiga\merge_used.py
rem ..\assets\amiga\convert_graphics_aga.py
6809to68k.py -i mot -o mit --data data.s --code conv.s -I include.inc trackfld_6809.asm
..\tools\post_process.py
goto skip_instrum
add_reg_log.py -s 6000 -e 615E -p 6 track_and_field.68k
add_reg_log.py -s 617F -e FF00 -p 6 track_and_field.68k
:skip_instrum
rem m68k-amigaos-as --defsym MC68020=1 track_and_field.68k 2>&1
build.bat

