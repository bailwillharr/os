void video_write_char(int x, int y, char c);
void video_write_str(int x, int y, char* str);

void _start()
{
	video_write_str(0, 0, "finally 32 bit and C are working");
	for ( ;; ) ;	// stop the CPU from executing random RAM
}

void video_write_char(int x, int y, char c)
{
	char* ptr = (char*)0xB8000;	// start of VRAM
	ptr += y * 80 + x * 2;
	*ptr = c;
	ptr++;
	*ptr = 0x0A;
}

void video_write_str(int x, int y, char* str)
{
	for (int i = 0; str[i] != 0; i++)
		video_write_char(x+i, y, str[i]);
}
