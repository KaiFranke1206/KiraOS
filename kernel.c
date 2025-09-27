#define VGA_WIDTH 320
#define VGA_HEIGHT 200
#define VGA_ADDRESS 0xA0000

unsigned char *vga = (unsigned char *)VGA_ADDRESS;

static inline void putpixel(unsigned short x, unsigned short y, unsigned char color) {
    vga[y * VGA_WIDTH + x] = color;
}

__attribute__((noreturn))
void kernel_main(void) {
    for (int i = 0; i < VGA_WIDTH * VGA_HEIGHT; i++) {
        vga[i] = 15;
    }

    putpixel(50,50,0);

    for (;;) {}
}
