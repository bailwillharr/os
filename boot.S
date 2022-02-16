.text
.code16
.globl _start
_start:
	ljmp	$0, $real_start	/* ensure CS = 0x0000 */
real_start:
	cli

	/* setup segments */
	xorw	%ax, %ax
	movw	%ax, %ds
	movw	%ax, %ss

	movw	$0x2000, %sp

	sti

	pushw	%dx		/* save drive reference */

	movw	$LOADING_STR, %si
	call	message

	/* load 64K from the disk into 0x10000 */
	movb	$0x42, %ah
	popw	%dx		/* restore drive reference */
	movw	$DAP, %si
	int	$0x13		/* extended read from disk */
	jnc	disk_read_success
	movw	$DISK_ERR_STR, %si
	call	message
1:
	jmp	1b
disk_read_success:

	/* change video mode */
	movb	$0x00, %ah
	movb	$0x13, %al
	int	$0x10

	/* enable protected (32 bit) mode */
	cli

	in	$0x92, %al		/* enable A20 line */
	or	$2, %al
	out	%al, $0x92

	lgdt	GDTD			/* load global descriptor table */
	movl	%cr0, %eax
	orl	$1, %eax
	movl	%eax, %cr0
	ljmp	$0x08, $clear_pipe	/* clear instruction pipeline */
	.code32
clear_pipe:
	movw	$0x10, %ax		/* 2nd GDT entry for data segment */
	movw	%ax, %ds
	movw	%ax, %ss
	movl	$0x00070000, %esp	/* almost top of 480K memory space */
	jmp	0x00010000
	.code16
/*
 * message: write the string pointed to by %si
 * WARNING: trashes %si, %ax, and %bx
 */
1:
	movw	$0x0001, %bx
	movb	$0xe, %ah
	int	$0x10		/* display a byte */
message:
	lodsb
	cmpb	$0, %al
	jne	1b	/* if not end of string, jmp to display */
	ret

LOADING_STR:
	.asciz	"Loading os...\r\n"

DISK_ERR_STR:
	.asciz	"ERROR: Unable to read disk.\r\n"

/* Disk Address Packet */
DAP:
	.byte	0x10	/* size of DAP */
	.byte	0x00	/* unused (0) */
	.word	32	/* read 128 sectors, 64 KB */
	.word	0x0000	/* offset of destination memory buffer */
	.word	0x1000	/* segment of destination memory buffer */
	.quad	1	/* first LBA */

/* GDT */
	.align	16
GDTD:
	.word	GDT_END - GDT - 1
	.long	GDT

	.align	16
GDT:
GDT_NULL:
	.quad	0
GDT_CODE:
	.word	0xFFFF		/* limit 0:15 */
	.word	0x0000		/* base 0:15 */
	.byte	0x00		/* base 16:23 */
	.byte	0b10011010	/* type and attributes */
	.byte	0b11001111	/* limit 16:19 (0xF) and attributes */
	.byte	0x00		/* base 24:31 */
GDT_DATA_SEGMENT:
	.word	0xFFFF		/* limit 0:15 */
	.word	0x0000		/* base 0:15 */
	.byte	0x00		/* base 16:23 */
	.byte	0b10010010	/* type and attributes */
	.byte	0b11001111	/* limit 16:19 (0xF) and attributes */
	.byte	0x00		/* base 24:31 */
GDT_END:

	.org	0x1B8	/* leave room for the disk ID and partition table */
	.org	510
	.word	0xAA55
