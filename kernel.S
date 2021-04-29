.text
.code16

.globl	_start
_start:
	/* CS:IP = 0x0000:0x7E00 */
	/* 16 KB of disk loaded to 0x9EFF */
done:
	jmp	done

	.org	0x1FFF	/* ensure the file is 8 KB */
