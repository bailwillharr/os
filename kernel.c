#include "video.h"

void _start()
{
	video_test();
	video_write_str(0, 3, VIDEO_TEST_STR);
	video_write_str(0, 10, "TEST");
	for ( ;; ) ;	// stop the CPU from executing random RAM
}
