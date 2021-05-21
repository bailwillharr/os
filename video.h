#ifndef VIDEO_H
#define VIDEO_H

// video colour attributes
#define BLACK		0x0
#define BLUE		0x1
#define GREEN		0x2
#define CYAN		0x3
#define RED		0x4
#define MAGENTA		0x5
#define BROWN		0x6
#define L_GREY		0x7
#define D_GREY		0x8
#define L_BLUE		0x9
#define LIGHT_GREEN	0xA
#define LIGHT_CYAN	0xB
#define LIGHT_RED	0xC
#define LIGHT_MAGENTA	0xD
#define YELLOW		0xE
#define WHITE		0xF

#define colour(b, f)	(b << 4) | f

extern int video_cursor_pos;
extern int video_colour;

void video_write_char(int x, int y, char c);
void video_write_str(int x, int y, const char* str);
void video_clear();
void video_test();

void print(const char* str);
void println(const char* str);

#endif
