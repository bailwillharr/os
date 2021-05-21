#include "video.h"

void _start()
{
	video_clear();
	print("The quick\nbrown fox\njumps over\nthe lazy\ndog.\n");
	video_colour = 0x01;
	print("asdf\n");
	for ( ;; ) ;	// stop the CPU from executing random RAM
}
