#include "video.h"

void kernel_entry()
{

	video_clear(DARK_GREY);

	video_draw_triangle(10, 10, 100, 20, 50, 130, RED);

	for ( ;; ) ;

}
