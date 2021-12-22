#include "hUGEDriver.h"
#include <stddef.h>

static const unsigned char order_cnt = 2;

static const unsigned char P0[] = {
    DN(E_4,2,0xE04),
    DN(___,0,0x000),
    DN(E_4,2,0xE04),
    DN(___,0,0x000),
    DN(E_4,2,0xE04),
    DN(___,0,0x000),
    DN(E_4,2,0xE04),
    DN(___,0,0x000),
    DN(E_4,2,0xE04),
    DN(___,0,0x000),
    DN(E_4,2,0xE04),
    DN(___,0,0x000),
    DN(E_4,2,0xE04),
    DN(___,0,0x000),
    DN(E_4,2,0xE04),
    DN(___,0,0x000),
    DN(E_4,2,0xE04),
    DN(___,0,0x000),
    DN(E_4,2,0xE04),
    DN(___,0,0x000),
    DN(E_4,2,0xE04),
    DN(___,0,0x000),
    DN(E_4,2,0xE04),
    DN(___,0,0x000),
    DN(E_4,2,0xE04),
    DN(___,0,0x000),
    DN(E_4,2,0xE04),
    DN(___,0,0x000),
    DN(E_4,2,0xE04),
    DN(___,0,0x000),
    DN(E_4,2,0xE04),
    DN(___,0,0x000),
    DN(G_4,2,0xE04),
    DN(___,0,0x000),
    DN(G_4,2,0xE04),
    DN(___,0,0x000),
    DN(G_4,2,0xE04),
    DN(___,0,0x000),
    DN(G_4,2,0xE04),
    DN(___,0,0x000),
    DN(G_4,2,0xE04),
    DN(___,0,0x000),
    DN(G_4,2,0xE04),
    DN(___,0,0x000),
    DN(G_4,2,0xE04),
    DN(___,0,0x000),
    DN(G_4,2,0xE04),
    DN(___,0,0x000),
    DN(A_4,2,0xE04),
    DN(___,0,0x000),
    DN(A_4,2,0xE04),
    DN(___,0,0x000),
    DN(A_4,2,0xE04),
    DN(___,0,0x000),
    DN(A_4,2,0xE04),
    DN(___,0,0x000),
    DN(A_4,2,0xE04),
    DN(___,0,0x000),
    DN(A_4,2,0xE04),
    DN(___,0,0x000),
    DN(A_4,2,0xE04),
    DN(___,0,0x000),
    DN(A_4,2,0xE04),
    DN(___,0,0x000),
};
static const unsigned char P1[] = {
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
};
static const unsigned char P2[] = {
    DN(E_4,2,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(G_4,2,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(A_4,2,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
};

static const unsigned char* const order1[] = {P0};
static const unsigned char* const order2[] = {P1};
static const unsigned char* const order3[] = {P2};
static const unsigned char* const order4[] = {P1};

static const unsigned char duty_instruments[] = {
8,0,128,128,
8,64,128,128,
8,128,240,128,
8,192,240,128,
8,0,241,128,
8,64,241,128,
8,128,241,128,
8,192,241,128,
8,128,240,128,
8,128,240,128,
8,128,240,128,
8,128,240,128,
8,128,240,128,
8,128,240,128,
8,128,240,128,
};
static const unsigned char wave_instruments[] = {
130,64,0,192,
0,64,1,128,
0,32,2,128,
0,32,3,128,
0,32,4,128,
0,32,5,128,
0,32,6,128,
0,32,7,128,
0,32,8,128,
0,32,9,128,
0,32,10,128,
0,32,11,128,
0,32,12,128,
0,32,13,128,
0,32,14,128,
};
static const unsigned char noise_instruments[] = {
128,108,32,239,0,0,0,0,
240,0,0,0,0,0,0,0,
240,0,0,0,0,0,0,0,
240,0,0,0,0,0,0,0,
240,0,0,0,0,0,0,0,
240,0,0,0,0,0,0,0,
240,0,0,0,0,0,0,0,
240,0,0,0,0,0,0,0,
240,0,0,0,0,0,0,0,
240,0,0,0,0,0,0,0,
240,0,0,0,0,0,0,0,
240,0,0,0,0,0,0,0,
240,0,0,0,0,0,0,0,
240,0,0,0,0,0,0,0,
240,0,0,0,0,0,0,0,
};

static const unsigned char waves[] = {
    255,255,255,255,255,255,255,255,247,119,119,119,119,119,119,255,
    0,0,0,0,255,255,255,255,255,255,255,255,255,255,255,255,
    0,0,0,0,0,0,0,0,255,255,255,255,255,255,255,255,
    0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,
    0,1,18,35,52,69,86,103,120,137,154,171,188,205,222,239,
    254,220,186,152,118,84,50,16,18,52,86,120,154,188,222,255,
    122,205,219,117,33,19,104,189,220,151,65,1,71,156,221,184,
    15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,
    254,252,250,248,246,244,242,240,242,244,246,248,250,252,254,255,
    254,221,204,187,170,153,136,119,138,189,241,36,87,138,189,238,
    132,17,97,237,87,71,90,173,206,163,23,121,221,32,3,71,
    19,203,75,171,2,108,9,104,100,56,46,94,237,87,0,152,
    105,198,96,5,217,30,0,34,27,104,17,182,233,66,202,62,
    71,67,36,182,154,189,56,90,176,154,150,165,169,123,114,30,
    67,33,103,16,164,17,227,186,208,135,153,158,155,236,89,137,
    110,203,105,134,50,115,68,186,149,104,209,38,49,84,153,174,
};

const hUGESong_t road1 = {5, &order_cnt, order1, order2, order3,order4, duty_instruments, wave_instruments, noise_instruments, NULL, waves};
