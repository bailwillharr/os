#include "video.h"

void video_write_char(int x, int y, char c)
{
	char* ptr = (char*)0xB8000;	// start of VRAM
	ptr += (y * 160) + (x * 2);
	*ptr = c;
	ptr++;
	*ptr = 0x0A;
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
