.text
.code16
.globl	_start
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

	/* load LBA 1-16 off of the disk into 0x10000 */
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

	movw	$LOADED_STR, %si
	call	message

	

	ljmp	$0x1000, $0x0000	/* jump to loaded memory */

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
	.asciz	"Loading...\r\n"

DISK_ERR_STR:
	.asciz	"ERROR: Unable to read disk.\r\n"

LOADED_STR:
	.asciz	"Loaded Disk.\r\n"

/* Disk Address Packet */
DAP:
	.byte	0x10	/* size of DAP */
	.byte	0x00	/* unused (0) */
	.word	16	/* read 16 sectors, 8 KB */
	.word	0x0000	/* offset of destination memory buffer */
	.word	0x1000	/* segment of destination memory buffer */
	.quad	1	/* first LBA */

	.org	0x1B8	/* leave room for the disk ID and partition table */
	.org	510
	.word	0xAA55
