	.ifdef	RELEASE
	.macro	BREAKPOINT comment
	.endm

	.else
LOG_BUFFER_SIZE = 0x80000
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
	

     

	.endc
	
	.macro	GET_MEMORY_START_AND_DP
	move.l	m6809_direct_page_pointer,a4
	.ifdef	RELEASE
	lea		ram_buffer-0x1800,a6
	.else
	move.l		ram_start_1800,a6
	
	* adjust offset to avoid subbing at run-time
	sub.w	#RAM_START,a6
	.endif
	.endm

NB_POSSIBLE_SPRITES = 256
NB_POSSIBLE_TILES = 768

