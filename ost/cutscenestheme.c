#pragma bank 15
#include "hUGEDriver.h"
#include <stddef.h>

static const unsigned char order_cnt = 2;

static const unsigned char P0[] = {
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
static const unsigned char P1[] = {
    DN(F_4,3,0xC09),
    DN(___,0,0x444),
    DN(___,0,0x444),
    DN(___,0,0x444),
    DN(___,0,0x444),
    DN(___,0,0x444),
    DN(___,0,0x444),
    DN(___,0,0x444),
    DN(___,0,0x444),
    DN(___,0,0x444),
    DN(___,0,0x444),
    DN(___,0,0x444),
    DN(___,0,0x444),
    DN(___,0,0x444),
    DN(___,0,0x444),
    DN(___,0,0x444),
    DN(E_4,3,0xC09),
    DN(___,0,0x444),
    DN(___,0,0x444),
    DN(___,0,0x444),
    DN(___,0,0x444),
    DN(___,0,0x444),
    DN(___,0,0x444),
    DN(___,0,0x444),
    DN(___,0,0x444),
    DN(___,0,0x444),
    DN(___,0,0x444),
    DN(___,0,0x444),
    DN(___,0,0x444),
    DN(___,0,0x444),
    DN(___,0,0x444),
    DN(___,0,0x444),
    DN(G_4,3,0xC09),
    DN(___,0,0x444),
    DN(___,0,0x444),
    DN(___,0,0x444),
    DN(___,0,0x444),
    DN(___,0,0x444),
    DN(___,0,0x444),
    DN(___,0,0x444),
    DN(___,0,0x444),
    DN(___,0,0x444),
    DN(___,0,0x444),
    DN(___,0,0x444),
    DN(___,0,0x444),
    DN(___,0,0x444),
    DN(___,0,0x444),
    DN(___,0,0x444),
    DN(Fs4,3,0xC09),
    DN(___,0,0x444),
    DN(___,0,0x444),
    DN(___,0,0x444),
    DN(___,0,0x444),
    DN(___,0,0x444),
    DN(___,0,0x444),
    DN(___,0,0x444),
    DN(___,0,0x444),
    DN(___,0,0x444),
    DN(___,0,0x444),
    DN(___,0,0x444),
    DN(___,0,0x444),
    DN(___,0,0x444),
    DN(___,0,0x444),
    DN(___,0,0x444),
};

static const unsigned char* const order1[] = {P0};
static const unsigned char* const order2[] = {P0};
static const unsigned char* const order3[] = {P1};
static const unsigned char* const order4[] = {P0};

static const unsigned char duty_instruments[] = {
8,0,208,128,
8,64,208,128,
8,128,208,128,
8,192,208,128,
8,0,241,128,
8,64,241,128,
8,128,241,128,
8,192,241,128,
8,128,208,128,
8,128,208,128,
8,128,208,128,
8,128,208,128,
8,128,208,128,
8,128,208,128,
8,128,208,128,
};
static const unsigned char wave_instruments[] = {
0,32,0,128,
0,32,1,128,
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
240,0,0,0,0,0,0,0,
};

static const unsigned char waves[] = {
    0,0,255,255,255,255,255,255,255,255,255,255,255,255,255,255,
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
    68,161,216,162,137,87,179,192,106,25,114,160,29,81,154,11,
    237,88,56,185,171,82,225,93,27,183,68,71,78,124,9,20,
    82,213,188,194,61,166,27,178,158,164,118,236,10,86,158,167,
    55,105,185,20,89,51,10,128,52,6,226,101,184,233,195,215,
    216,221,74,225,164,138,87,75,205,28,56,109,5,25,154,137,
};

const hUGESong_t cutscenestheme = {6, &order_cnt, order1, order2, order3,order4, duty_instruments, wave_instruments, noise_instruments, NULL, waves};
