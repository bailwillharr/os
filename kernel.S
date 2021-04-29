#include "video.h"

.text
.code32

.globl	_start
_start:
	/* ESP = 0x00010000 */
	movb	$'T', VIDEO_VRAM
	movb	$0x1B, VIDEO_VRAM + 1
done:
	jmp	done
