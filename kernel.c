#include "video.h"

void _start()
{
	video_write_str(0, 3, "finally 32 bit and C are working");
	for ( ;; ) ;	// stop the CPU from executing random RAM
}
