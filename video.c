#include "video.h"

// Externs
int video_cursor_pos = 0;
int video_colour = colour(BLACK, GREEN);

void video_write_char(int x, int y, char c)
{
	char* ptr = (char*)0xB8000;	// start of VRAM
	ptr += (y * 160) + (x * 2);
	*ptr = c;
	ptr++;
	*ptr = video_colour;
}

void video_write_str(int x, int y, const char* str)
{
	for (int i = 0; str[i] != 0; i++)
		video_write_char(x+i, y, str[i]);
}

void video_clear()
{
	char* ptr = (char*)0xB8000;
	for (int i = 0; i < 80*25; i++) {
		ptr[i * 2 + 0] = ' ';
		ptr[i * 2 + 1] = 0;
	}
}

void video_test()
{
	char* ptr = (char*)0xB8000;
	for (int i = 0; i < 80*25; i++) {
		ptr[i * 2 + 0] = ' '+(i & 63);
		ptr[i * 2 + 1] = i;
	}
}

void print(const char* str)
{
	int row = video_cursor_pos / 80;
	int col = video_cursor_pos % 80;
	for (int i = 0; str[i] != 0; i++) {
		char c = str[i];
		switch (c) {
		case '\n':
			video_cursor_pos += 80 - (video_cursor_pos % 80);
			break;
		default:
			video_write_char(
					video_cursor_pos % 80,
					video_cursor_pos / 80, c
					);
			video_cursor_pos++;
		}
	}
}

void println(const char* str)
{
	print(str);
	video_cursor_pos += 80 - (video_cursor_pos % 80);
	video_cursor_pos++;
}
