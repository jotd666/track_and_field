* Converted with 6809to68k by JOTD
*
* make sure you call "cpu_init" first so all bits of data registers
* are zeroed out so we can use add.l dy,ax with dy > 0x7FFF
* without systematic masking
*
* WARNING: you also have to call "cpu_init"
* at start of any interrupt you could hook
*
* the GET_ADDRESS macro can just call get_address or it can also use
* conditional compilation to select the proper memory banks at compile time
* (see my burger time 6502 conversion which does that in RELEASE mode)

	.global	cpu_init

	.macro	ERROR     arg
	.error "\arg"
	.endm

	
	.ifdef	RELEASE
	.macro	GET_ADDRESS_FUNC
	lea		(a6,a0.l),a0
	.endm
	
	.else
	
	.macro	GET_ADDRESS_FUNC
	jbsr	get_address
	.endm
	
* dev mode, more checks about the address
get_address:
	cmp.l	#0x6000,a0
	jcc		10f		| rom: ok
	cmp.l	#0x4000,a0
	jcs		0f
	BREAKPOINT	"unsupported address range 0x4000-0x5FFF"
	illegal
0:
	cmp.l	#0x1800,a0
	jcc		0f
	BREAKPOINT	"unsupported address range 0-0x1800"
	illegal
0:
	* 0X1800 <= range < 0x4000, ram, video ram & special ram/scroll

10:
	lea		(a6,a0.l),a0
	rts

	.endif 
	
	
	.macro	MAKE_D
* add value of A in B MSB so D&0xFF == B
	rol.w	#8,d1
	move.b	d0,d1
	rol.w	#8,d1
	.endm

	.macro	BIT	reg,arg
	move.b	\reg,d6
	and.b	\arg,d6
	.endm


	.macro	LOAD_D
	move.b	(a0),d0
	move.b	(1,a0),d1
	MAKE_D
	.endm

	.macro CLR_XC_FLAGS
	move.w	d7,-(a7)
	moveq	#0,d6
	roxl.b	#1,d6
	movem.w	(a7)+,d6
	.endm

	.macro SET_XC_FLAGS
	move.w	d6,-(a7)
	st	d6
	roxl.b	#1,d6
	movem.w	(a7)+,d6
	.endm



	.macro INVERT_XC_FLAGS
	PUSH_SR
	move.w	(sp),d6
	eor.b	#0x11,d6
	move.w	d6,(sp)
	POP_SR
	.endm

* useful to recall C from X (add then move then bcx)
	.macro	SET_C_FROM_X
	PUSH_SR
	move.w	(sp),d6
	bset	#0,d6   | set C
	btst	#4,d6
	jne	0f
	bclr	#0,d6   | X is clear: clear C
0:
	move.w	d6,(sp)
	POP_SR
	.endm

	.macro	SET_X_FROM_CLEARED_C
	PUSH_SR
	move.w	(sp),d6
	bset	#4,d6   | set X
	btst	#0,d6
	jeq	0f
	bclr	#4,d6   | C is set: clear X
0:
	move.w	d6,(sp)
	POP_SR
	.endm



	.macro CLR_I_FLAG
    * not useful
	.endm

	.macro	JXX_A_INDEXED
	and.w	#0xFF,d0  | mask 8 bits
	add.w	d0,d0    | *2 (16 -> 32 bits)
	.endm

	.ifdef	MC68020

* 68020 compliant & optimized

	.macro PUSH_SR
	move.w	ccr,-(sp)
	.endm
	.macro POP_SR
	move.w	(sp)+,ccr
	.endm

* registers must be masked out to proper size before use
	.macro	GET_INDIRECT_ADDRESS_REGS	reg1,reg2,destreg
	move.l	\reg1,a0
	add.l	\reg2,a0
	move.w	(a0),\destreg
	.endm

	.macro	MOVE_W_TO_REG	src,dest
	move.w	\src,\dest
	.endm

	.macro    MOVE_W_FROM_REG    src,dest
	move.w	\dest,\src
	.endm

	.macro	JSR_A_INDEXED	reg
	JXX_A_INDEXED
	jsr	([\reg,d0.W])
	.endm
	.macro	JMP_A_INDEXED	reg
	JXX_A_INDEXED
	jmp	([\reg,d0.W])
	.endm

	.else

* 68000 compliant

	.macro PUSH_SR
	move.w	sr,-(sp)
	.endm
	.macro POP_SR
	move.w	(sp)+,sr
	.endm

	.macro	MOVE_W_TO_REG	src,dest
	ror.w	#8,\dest
	move.b	\src+,\dest
	ror.w	#8,\dest
	move.b	\src,\dest
	subq	#1,\dest
	.endm

	.macro	MOVE_W_FROM_REG	src,dest
	ror.w	#8,\src
	move.b	\src,\dest+
	ror.w	#8,\src
	move.b	\src,\dest
	subq	#1,\dest
	.endm


	.macro	JSR_A_INDEXED	reg
	JXX_A_INDEXED
	move.l	(\reg,d0.w),\reg
	jsr	(\reg)
	.endm

	.macro	JMP_A_INDEXED	reg
	JXX_A_INDEXED
	move.l	(\reg,d0.w),\reg
	jmp	(\reg)
	.endm

* registers must be masked out to proper size before use
	.macro	GET_INDIRECT_ADDRESS_REGS	reg1,reg2,destreg
	move.l	\reg1,a0
	add.l	\reg2,a0
	move.b	(a0),\destreg
	lsl.w	#8,\destreg
	move.b	(1,a0),\destreg
	.endm

	.endif



	.macro READ_BE_WORD	srcreg
	move.b	(\srcreg),d6
	lsl.w	#8,d6
	move.b	(1,\srcreg),d6
	move.w	d6,\srcreg
	.endm

	.macro GET_ADDRESS	offset
	lea	\offset,a0
	GET_ADDRESS_FUNC
	.endm

	.macro GET_DP_ADDRESS	offset
	lea	(a4,\offset\().W),a0
	.endm


	.macro GET_INDIRECT_ADDRESS	offset
	GET_ADDRESS	\offset
	READ_BE_WORD	a0
	GET_ADDRESS_FUNC
	.endm

	.macro SET_DP_FROM_A
	lsl.w    #8,d0
	move.l    d0,a0
	GET_ADDRESS_FUNC
	move.l	a0,a4
	lsr.w    #8,d0
	.endm



	.macro SET_DP_FROM    reg
	exg	d0,\reg
	SET_DP_FROM_A

	exg	d0,\reg
	.endm

	.macro GET_X_ADDRESS	offset
	.ifeq	\offset
	move.l	d2,a0
	.else
	lea	\offset,a0
	add.l	d2,a0
	.endif
	GET_ADDRESS_FUNC
	.endm

	.macro GET_X_INDIRECT_ADDRESS	offset
	.ifeq	\offset
	move.l	d2,a0
	.else
	lea	\offset,a0
	add.l	d2,a0
	.endif
	READ_BE_WORD	a0
	GET_ADDRESS_FUNC
	.endm

	.macro GET_X_ADDRESS_FROM_REG	reg
	move.l	\reg,a0
	add.l	d2,a0
	GET_ADDRESS_FUNC
	.endm

	.macro GET_Y_ADDRESS	offset
	.ifeq	\offset
	move.l	d3,a0
	.else
	lea	\offset,a0
	add.l	d3,a0
	.endif
	GET_ADDRESS_FUNC
	.endm

	.macro GET_Y_INDIRECT_ADDRESS	offset
	.ifeq	\offset
	move.l	d3,a0
	.else
	lea	\offset,a0
	add.l	d3,a0
	.endif
	READ_BE_WORD	a0
	GET_ADDRESS_FUNC
	.endm

	.macro GET_Y_ADDRESS_FROM_REG	reg
	move.l	\reg,a0
	add.l	d3,a0
	GET_ADDRESS_FUNC
	.endm

	.macro GET_S_ADDRESS	offset
	.ifeq	\offset
	move.l	d5,a0
	.else
	lea	\offset,a0
	add.l	d5,a0
	.endif
	GET_ADDRESS_FUNC
	.endm

	.macro GET_S_INDIRECT_ADDRESS	offset
	.ifeq	\offset
	move.l	d5,a0
	.else
	lea	\offset,a0
	add.l	d5,a0
	.endif
	READ_BE_WORD	a0
	GET_ADDRESS_FUNC
	.endm

	.macro GET_S_ADDRESS_FROM_REG	reg
	move.l	\reg,a0
	add.l	d5,a0
	GET_ADDRESS_FUNC
	.endm

	.macro GET_U_ADDRESS	offset
	.ifeq	\offset
	move.l	d4,a0
	.else
	lea	\offset,a0
	add.l	d4,a0
	.endif
	GET_ADDRESS_FUNC
	.endm

	.macro GET_U_INDIRECT_ADDRESS	offset
	.ifeq	\offset
	move.l	d4,a0
	.else
	lea	\offset,a0
	add.l	d4,a0
	.endif
	READ_BE_WORD	a0
	GET_ADDRESS_FUNC
	.endm

	.macro GET_U_ADDRESS_FROM_REG	reg
	move.l	\reg,a0
	add.l	d4,a0
	GET_ADDRESS_FUNC
	.endm

cpu_init:
	moveq	#0,d0
	moveq	#0,d1
	moveq	#0,d2
	moveq	#0,d3
	moveq	#0,d4
	moveq	#0,d5
	moveq	#0,d6
	moveq	#0,d7
	rts



multiply_ab:
	and.w	#0xFF,d0
	and.w	#0xFF,d1
	mulu	d0,d1
	ror.w	#8,d1
	move.b	d1,d0
	ror.w	#8,d1
	rts
