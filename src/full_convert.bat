..\assets\amiga\merge_used.py
..\assets\amiga\convert_graphics.py
6809to68k.py -i mot -o mit --data data.s --code conv.s -I include.inc trackfld_6809.asm
..\tools\post_process.py
rem add_reg_log.py -s 6000 -e 615E -p 1 track_and_field.68k
rem add_reg_log.py -s 617F -e FF00 -p 1 track_and_field.68k
rem add_reg_log.py -s 97DF -e 98C2 -p 1 -c 97DF track_and_field.68k
rem add_reg_log.py -s DEFF -e E039 -p 1 track_and_field.68k
rem add_reg_log.py -s FB6A -e FB8E -p 1 track_and_field.68k
rem m68k-amigaos-as --defsym MC68020=1 track_and_field.68k 2>&1
build.bat

