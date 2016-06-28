

    .section	__TEXT,__text,regular,pure_instructions
	.globl	_fooTestAsm
	.align	1
    .thumb_func	_fooTestAsm
_fooTestAsm:
    bx	lr
    //两个参数
    .globl	_testAddAsm
	.align	1
	.code	16
	.thumb_func	_testAddAsm
_testAddAsm:
    add	r0, r1
	bx	lr

    //三个参数
    .globl	_testAddAsm1
	.align	1
	.code	16
	.thumb_func	_testAddAsm1
_testAddAsm1:
    add	r0, r1
    add r0, r2
	bx	lr
    //五个参数
    .globl	_testAddAsm5
	.align	1
	.code	16
	.thumb_func	_testAddAsm5
_testAddAsm5:
    sub	sp, #24
    add	r0, r1
    add	r0, r2
    add	r0, r3
    ldr	r1, [sp, #28]
    add	r0, r1
    ldr	r1, [sp, #24]
    add	r0, r1
    add	sp, #24
	bx	lr
    //
    .globl	_testAddAsm4
	.align	1
	.code	16
	.thumb_func	_testAddAsm4
_testAddAsm4:
	sub	sp, #16
    add r0, r1
    add r0, r2
    add r0, r3
	add	sp, #16
	bx	lr

    //不定参数
    .globl	_sumAsm
	.align	1
	.code	16
	.thumb_func	_sumAsm
_sumAsm:
	sub	sp, #12
	sub	sp, #20
	str	r3, [sp, #28]
	str	r2, [sp, #24]
	str	r1, [sp, #20]
	movs	r1, #0
	add	r2, sp, #8
	str	r0, [sp, #12]
	add	r0, sp, #20
	str	r0, [r2]
    str	r1, [sp, #4]
LBB0_1:
	ldr	r0, [sp, #4]
	cmn.w	r0, #1
	beq	LBB0_3
Ltmp3:
	ldr	r0, [sp, #4]
    ldr	r1, [sp, #12]
	add	r0, r1
	str	r0, [sp, #12]
    ldr	r0, [sp, #8]
	adds	r1, r0, #4
	str	r1, [sp, #8]
    str	r0, [sp, #4]
Ltmp4:
    b	LBB0_1
LBB0_3:
	add	r0, sp, #8
    ldr	r1, [sp, #12]
    str	r0, [sp]
	mov	r0, r1
	add	sp, #20
	add	sp, #12
	bx	lr


