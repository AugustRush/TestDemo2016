	.section	__TEXT,__text,regular,pure_instructions
	.ios_version_min 9, 3
	.syntax unified
	.align	1
	.code	16
	.thumb_func	"-[TestModel1 fooWithBar:baz:]"
"-[TestModel1 fooWithBar:baz:]":
	sub	sp, #16
	str	r0, [sp, #12]
	str	r1, [sp, #8]
	str	r2, [sp, #4]
	str	r3, [sp]
	ldr	r0, [sp, #4]
	ldr	r1, [sp]
	add	r0, r1
    mov r0, #88
	add	sp, #16
	bx	lr

    ///////

    

	.section	__TEXT,__objc_classname,cstring_literals
L_OBJC_CLASS_NAME_:                     @ @OBJC_CLASS_NAME_
	.asciz	"TestModel1"

	.section	__DATA,__objc_const
	.align	2                       @ @"\01l_OBJC_METACLASS_RO_$_TestModel1"
l_OBJC_METACLASS_RO_$_TestModel1:
	.long	129                     @ 0x81
	.long	20                      @ 0x14
	.long	20                      @ 0x14
	.long	0
	.long	L_OBJC_CLASS_NAME_
	.long	0
	.long	0
	.long	0
	.long	0
	.long	0

	.section	__DATA,__objc_data
	.globl	_OBJC_METACLASS_$_TestModel1 @ @"OBJC_METACLASS_$_TestModel1"
	.align	2
_OBJC_METACLASS_$_TestModel1:
	.long	_OBJC_METACLASS_$_NSObject
	.long	_OBJC_METACLASS_$_NSObject
	.long	__objc_empty_cache
	.long	0
	.long	l_OBJC_METACLASS_RO_$_TestModel1

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_:                  @ @OBJC_METH_VAR_NAME_
	.asciz	"fooWithBar:baz:"

	.section	__TEXT,__objc_methtype,cstring_literals
L_OBJC_METH_VAR_TYPE_:                  @ @OBJC_METH_VAR_TYPE_
	.asciz	"i16@0:4i8i12"

	.section	__DATA,__objc_const
	.align	2                       @ @"\01l_OBJC_$_INSTANCE_METHODS_TestModel1"
l_OBJC_$_INSTANCE_METHODS_TestModel1:
	.long	12                      @ 0xc
	.long	1                       @ 0x1
	.long	L_OBJC_METH_VAR_NAME_
	.long	L_OBJC_METH_VAR_TYPE_
	.long	"-[TestModel1 fooWithBar:baz:]"

	.align	2                       @ @"\01l_OBJC_CLASS_RO_$_TestModel1"
l_OBJC_CLASS_RO_$_TestModel1:
	.long	128                     @ 0x80
	.long	4                       @ 0x4
	.long	4                       @ 0x4
	.long	0
	.long	L_OBJC_CLASS_NAME_
	.long	l_OBJC_$_INSTANCE_METHODS_TestModel1
	.long	0
	.long	0
	.long	0
	.long	0

	.section	__DATA,__objc_data
	.globl	_OBJC_CLASS_$_TestModel1 @ @"OBJC_CLASS_$_TestModel"
	.align	2
_OBJC_CLASS_$_TestModel1:
	.long	_OBJC_METACLASS_$_TestModel1
	.long	_OBJC_CLASS_$_NSObject
	.long	__objc_empty_cache
	.long	0
	.long	l_OBJC_CLASS_RO_$_TestModel1

	.section	__DATA,__objc_classlist,regular,no_dead_strip
	.align	2                       @ @"OBJC_LABEL_CLASS_$"
L_OBJC_LABEL_CLASS_$:
	.long	_OBJC_CLASS_$_TestModel1

	.section	__LLVM,__bitcode
	.globl	_llvm.embedded.module   @ @llvm.embedded.module
_llvm.embedded.module:
	.byte	0

	.section	__LLVM,__cmdline
	.globl	_llvm.cmdline           @ @llvm.cmdline
_llvm.cmdline:
	.byte	0

	.linker_option "-framework", "Foundation"
	.linker_option "-framework", "CFNetwork"
	.linker_option "-framework", "Security"
	.linker_option "-framework", "CoreFoundation"
	.section	__DATA,__objc_imageinfo,regular,no_dead_strip
L_OBJC_IMAGE_INFO:
	.long	0
	.long	0

