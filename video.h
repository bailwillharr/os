#ifndef VIDEO_H
#define VIDEO_H

void video_write_char(int x, int y, char c);
void video_write_str(int x, int y, const char* str);
void video_clear();
void video_test();

#define VIDEO_TEST_STR "This is a test."

#endif
