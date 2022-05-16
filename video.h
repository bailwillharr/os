#ifndef VIDEO_H
#define VIDEO_H

#define WIDTH 320
#define HEIGHT 200

enum colors {
	BLACK,
	BLUE,
	GREEN,
	CYAN,
	RED,
	MAGENTA,
	BROWN,
	LIGHT_GREY,
	DARK_GREY,
	LIGHT_BLUE,
	LIGHT_GREEN,
	LIGHT_CYAN,
	LIGHT_RED,
	LIGHT_MAGENTA,
	YELLOW,
	WHITE
}; // the first 16 colors

void video_plot_px(int x, int y, char c);
void video_draw_line(int x0, int y0, int x1, int y1, char c);
void video_draw_triangle(int x0, int y0, int x1, int y1, int x2, int y2, char c);
void video_clear(char c);

#endif
