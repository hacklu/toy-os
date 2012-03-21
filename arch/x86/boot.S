/*
 * for boot ,we will go to protect mode
 */


#BOOTSEG		= 0x07C0		/* original address of boot-sector */

	.code16
	#.section ".text", "ax"
	.text

	.global _start
_start:
bootsect_start:

	# Normalize the start address
	#ljmp	$0x0, $start2
#	jmp	 start2
	ljmp	$0x7c0,$start2
#.byte 0x33
#.byte 0x44

start2:
	movw	%cs, %ax
	movw	%ax, %ds
	movw	%ax, %es
	movw	%ax, %ss
	xorw	%sp, %sp
	sti
	cld
	
	movw 	%sp,0x2000
	call where_am_i 	#改成位置无关代码，不依赖链接地址，hoho。2012.3.20
where_am_i:	pop %ax	
#	movw	$where_am_i, %si
	movw 	$bugger_off_msg,%bx
	sub 	$where_am_i,%bx
	add 	%bx,%ax
	movw	%ax, %si

msg_loop:
	lodsb
	andb	%al, %al
	jz	bs_die
	movb	$0xe, %ah
	movw	$7, %bx
	int	$0x10
	jmp	msg_loop

bs_die:
	# Allow the user to press a key, then reboot
	xorw	%ax, %ax
	int	$0x16
	int	$0x19

	# int 0x19 should never return.  In case it does anyway,
	# invoke the BIOS reset code...
	ljmp	$0xf000,$0xfff0

#	.section ".bsdata", "a"
bugger_off_msg:
	.ascii  "hacklu test MBR for fun...\r\n"
	.ascii  "we don't support for booting from floppy now.\r\n"
	.ascii	"Remove disk and press any key to reboot . . .\r\n"
	.byte	0


#here:
#.space (here -bootsect_start) ,0
#.byte 0
#.endr
. = bootsect_start + 0x1fe 
boot_flag:	.word 0xAA55

