#include "screen.h"

int get_screen_offset(int, int);
int get_cursor_offset();
int set_cursor(int);

//Print char at col, row, or cursor position
void print_char(char character, int col, int row, char attribute_byte) {
    unsigned char *vidmem = (unsigned char *) VIDEO_ADDRESS;

    if(!attribute_byte) attribute_byte = WHITE_ON_BLACK;

    int offset;
    if(col >= 0 && row >= 0) {
        offset = get_screen_offset(row, col);
    } else {
        offset = get_cursor();
    }

    if(char == '\n') {
        int rows = offset / (2 * MAX_COLS);
        offset = get_screen_offset(79, rows);
    } else {
        vidmem[offset] = character;
        vidmem[offset+1] = attribute_byte;
    }

    offset += 2;
    offset = handle_scrolling(offset);
    set_cursor(offset);
}

int get_screen_offset(int row, int col) {
    return (2 * (row * MAX_COLS + col));
}

void set_cursor(int offset) {
    port_byte_out(REG_SCREEN_CTRL, 14);
    port_byte_out(REG_SCREEN_DATA, (unsigned char)(offset >> 8));
    port_byte_out(REG_SCREEN_CTRL, 15);
}

int get_cursor() 
{
    cursor_offset -= 2 * MAX_COLS;
    return cursor_offset;
}
