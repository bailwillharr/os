#include "video.h"
#include "math.h"

static char * const VRAM = (char *)0xA0000;

void video_plot_px(int x, int y, char c) {
	VRAM[y * WIDTH + x] = c;
}

void video_draw_line(int x0, int y0, int x1, int y1, char c) {
    int dx = abs(x1-x0);
    int dy = abs(y1-y0);
    signed short sx,sy;
    signed int err,e2;

    if (x0 < x1) {sx = 1;} else {sx = -1;}
    if (y0 < y1) {sy = 1;} else {sy = -1;}
    err = dx-dy;

    while (!(x0==x1 && y0==y1))
    {
		video_plot_px(x0, y0, c);
        e2 = 2*err;
        if (e2 > -dy) 
        {
            err = err - dy;
            x0 += sx;
        }
        if (e2 < dx) 
        {
            err = err + dx;
            y0 += sy;
        }
    }
}

void video_draw_triangle(int x0, int y0, int x1, int y1, int x2, int y2, char c) {
	video_draw_line(x0, y0, x1, y1, c);
	video_draw_line(x1, y1, x2, y2, c);
	video_draw_line(x2, y2, x0, y0, c);
}

void video_clear(char c) {
	for (int i = 0; i < WIDTH * HEIGHT; i++) {
		VRAM[i] = c;
	}
}
