	.ifdef	RELEASE
	.macro	BREAKPOINT comment
	.endm

	.else
LOG_BUFFER_SIZE = 0x10000
	* amiga specific
	.macro	BREAKPOINT comment
	move.l	a0,-(a7)
	lea		comment\@(pc),a0
	jbsr	osd_break
	move.l	(a7)+,a0
	jra		next\@
comment\@:
	.asciz	"\comment"
	.align	2
next\@:
	.endm
	
* page $28xx
hammer_speed_38 = 0x38
p1_attempts_left_81 = 0x81
p1_attempts_left_a1 = 0xA1
current_level_84 = 0x84
jump_foul_C9 = 0xc9
false_start_D9 = 0xD9
high_jump_fault_9F = 0x9F
jump_foul_c9 = 0xC9
false_start_d9 = 0xD9

watchdog_1000 = 0x1000
flip_screen_set_1080 = 0x1080
irq_mask_w_1087 = 0x1087

     

	.endc
