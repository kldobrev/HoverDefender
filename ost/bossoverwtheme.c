#pragma bank 9
#include "hUGEDriver.h"
#include <stddef.h>

static const unsigned char order_cnt = 14;

static const unsigned char P0[] = {
    DN(F_4,4,0x000),
    DN(___,0,0x000),
    DN(D_4,4,0x000),
    DN(___,0,0x000),
    DN(C_4,4,0x000),
    DN(___,0,0x000),
    DN(D_4,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(G_4,4,0x000),
    DN(___,0,0x000),
    DN(D_4,4,0x000),
    DN(___,0,0x000),
    DN(C_4,4,0x000),
    DN(___,0,0x000),
    DN(D_4,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(A_4,4,0x000),
    DN(___,0,0x000),
    DN(D_4,4,0x000),
    DN(___,0,0x000),
    DN(C_4,4,0x000),
    DN(___,0,0x000),
    DN(D_4,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(G_4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Gs4,1,0x000),
    DN(___,0,0x000),
    DN(G_4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(F_4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(G_4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
};
static const unsigned char P1[] = {
    DN(C_5,4,0x000),
    DN(___,0,0x000),
    DN(A_4,4,0x000),
    DN(___,0,0x000),
    DN(G_4,4,0x000),
    DN(___,0,0x000),
    DN(A_4,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(D_5,4,0x000),
    DN(___,0,0x000),
    DN(A_4,4,0x000),
    DN(___,0,0x000),
    DN(G_4,4,0x000),
    DN(___,0,0x000),
    DN(A_4,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(E_5,4,0x000),
    DN(___,0,0x000),
    DN(A_4,4,0x000),
    DN(___,0,0x000),
    DN(G_4,4,0x000),
    DN(___,0,0x000),
    DN(A_4,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(D_5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Ds5,4,0x000),
    DN(___,0,0x000),
    DN(D_5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(C_5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(D_5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
};
static const unsigned char P2[] = {
    DN(D_4,2,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(C_4,2,0x000),
    DN(___,0,0x000),
    DN(D_4,2,0x000),
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
    DN(C_4,2,0x000),
    DN(___,0,0x000),
    DN(D_4,2,0x000),
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
    DN(C_4,2,0x000),
    DN(___,0,0x000),
    DN(D_4,2,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(A_4,2,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Gs4,2,0x000),
    DN(___,0,0x000),
    DN(G_4,2,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(F_4,2,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(C_4,2,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
};
static const unsigned char P3[] = {
    DN(F_5,2,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(B_5,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(B_5,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(B_5,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(B_5,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(B_5,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(F_5,2,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(B_5,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(F_5,2,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(B_5,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(B_5,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(B_5,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(F_5,2,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(B_5,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(F_5,2,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(B_5,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
};
static const unsigned char P4[] = {
    DN(D_4,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0xE00),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(F_4,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(D_4,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0xE00),
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
    DN(E_4,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0xE00),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(F_4,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(E_4,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0xE00),
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
static const unsigned char P5[] = {
    DN(A_4,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0xE00),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(C_5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(A_4,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0xE00),
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
    DN(B_4,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0xE00),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(C_5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(B_4,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0xE00),
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
static const unsigned char P6[] = {
    DN(D_4,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(D_4,4,0x000),
    DN(___,0,0x000),
    DN(D_4,4,0x000),
    DN(___,0,0x000),
    DN(D_4,4,0x000),
    DN(___,0,0x000),
    DN(D_4,4,0x000),
    DN(___,0,0x000),
    DN(F_4,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(D_4,4,0x000),
    DN(___,0,0x000),
    DN(D_4,4,0x000),
    DN(___,0,0x000),
    DN(D_4,4,0x000),
    DN(___,0,0x000),
    DN(D_4,4,0x000),
    DN(___,0,0x000),
    DN(D_4,4,0x000),
    DN(___,0,0x000),
    DN(D_4,4,0x000),
    DN(___,0,0x000),
    DN(D_4,4,0x000),
    DN(___,0,0x000),
    DN(D_4,4,0x000),
    DN(___,0,0x000),
    DN(E_4,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(E_4,4,0x000),
    DN(___,0,0x000),
    DN(E_4,4,0x000),
    DN(___,0,0x000),
    DN(E_4,4,0x000),
    DN(___,0,0x000),
    DN(E_4,4,0x000),
    DN(___,0,0x000),
    DN(F_4,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(E_4,4,0x000),
    DN(___,0,0x000),
    DN(E_4,4,0x000),
    DN(___,0,0x000),
    DN(E_4,4,0x000),
    DN(___,0,0x000),
    DN(E_4,4,0x000),
    DN(___,0,0x000),
    DN(E_4,4,0x000),
    DN(___,0,0x000),
    DN(E_4,4,0x000),
    DN(___,0,0x000),
    DN(E_4,4,0x000),
    DN(___,0,0x000),
    DN(E_4,4,0x000),
    DN(___,0,0x000),
};
static const unsigned char P7[] = {
    DN(D_5,1,0x000),
    DN(___,0,0x000),
    DN(D_5,1,0x000),
    DN(D_5,1,0x000),
    DN(F_5,2,0x000),
    DN(___,0,0x000),
    DN(F_5,2,0x000),
    DN(___,0,0x000),
    DN(D_5,1,0x000),
    DN(___,0,0x000),
    DN(D_5,1,0x000),
    DN(D_5,1,0x000),
    DN(F_5,2,0x000),
    DN(___,0,0x000),
    DN(F_5,2,0x000),
    DN(___,0,0x000),
    DN(D_5,1,0x000),
    DN(___,0,0x000),
    DN(D_5,1,0x000),
    DN(D_5,1,0x000),
    DN(F_5,2,0x000),
    DN(___,0,0x000),
    DN(F_5,2,0x000),
    DN(___,0,0x000),
    DN(D_5,1,0x000),
    DN(___,0,0x000),
    DN(D_5,1,0x000),
    DN(D_5,1,0x000),
    DN(F_5,2,0x000),
    DN(___,0,0x000),
    DN(F_5,2,0x000),
    DN(___,0,0x000),
    DN(D_5,1,0x000),
    DN(___,0,0x000),
    DN(D_5,1,0x000),
    DN(D_5,1,0x000),
    DN(F_5,2,0x000),
    DN(___,0,0x000),
    DN(F_5,2,0x000),
    DN(___,0,0x000),
    DN(D_5,1,0x000),
    DN(___,0,0x000),
    DN(D_5,1,0x000),
    DN(D_5,1,0x000),
    DN(F_5,2,0x000),
    DN(___,0,0x000),
    DN(F_5,2,0x000),
    DN(___,0,0x000),
    DN(D_5,1,0x000),
    DN(___,0,0x000),
    DN(D_5,1,0x000),
    DN(D_5,1,0x000),
    DN(F_5,2,0x000),
    DN(___,0,0x000),
    DN(F_5,2,0x000),
    DN(___,0,0x000),
    DN(D_5,1,0x000),
    DN(___,0,0x000),
    DN(D_5,1,0x000),
    DN(D_5,1,0x000),
    DN(F_5,2,0x000),
    DN(___,0,0x000),
    DN(F_5,2,0x000),
    DN(___,0,0x000),
};
static const unsigned char P8[] = {
    DN(D_5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0xE00),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(G_5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(D_5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0xE00),
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
    DN(E_5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0xE00),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(F_5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(E_5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0xE00),
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
static const unsigned char P9[] = {
    DN(A_5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0xE00),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(D_6,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(A_5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0xE00),
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
    DN(B_5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0xE00),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(C_6,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(B_5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0xE00),
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
static const unsigned char P10[] = {
    DN(E_5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Ds5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(D_5,4,0x000),
    DN(___,0,0x442),
    DN(___,0,0x442),
    DN(___,0,0x442),
    DN(___,0,0x442),
    DN(___,0,0x442),
    DN(D_4,4,0x000),
    DN(___,0,0x000),
    DN(E_4,4,0x000),
    DN(___,0,0x000),
    DN(Ds4,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(D_4,4,0x000),
    DN(___,0,0x446),
    DN(___,0,0x446),
    DN(___,0,0x446),
    DN(___,0,0x446),
    DN(___,0,0x446),
    DN(___,0,0x446),
    DN(___,0,0x446),
    DN(___,0,0x446),
    DN(___,0,0x446),
    DN(E_5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Ds5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(D_5,4,0x000),
    DN(___,0,0x442),
    DN(___,0,0x442),
    DN(___,0,0x442),
    DN(___,0,0x442),
    DN(___,0,0x442),
    DN(D_4,4,0x000),
    DN(___,0,0x000),
    DN(Ds5,4,0x000),
    DN(___,0,0x000),
    DN(E_5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Fs5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Gs5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(B_5,4,0x000),
    DN(___,0,0x000),
};
static const unsigned char P11[] = {
    DN(B_5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(As5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(A_5,4,0x000),
    DN(___,0,0x442),
    DN(___,0,0x442),
    DN(___,0,0x442),
    DN(___,0,0x442),
    DN(___,0,0x442),
    DN(A_4,4,0x000),
    DN(___,0,0x000),
    DN(B_4,4,0x000),
    DN(___,0,0x000),
    DN(As4,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(A_4,4,0x000),
    DN(___,0,0x446),
    DN(___,0,0x446),
    DN(___,0,0x446),
    DN(___,0,0x446),
    DN(___,0,0x446),
    DN(___,0,0x446),
    DN(___,0,0x446),
    DN(___,0,0x446),
    DN(___,0,0x446),
    DN(B_5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(As5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(A_5,4,0x000),
    DN(___,0,0x442),
    DN(___,0,0x442),
    DN(___,0,0x442),
    DN(___,0,0x442),
    DN(___,0,0x442),
    DN(A_4,4,0x000),
    DN(___,0,0x000),
    DN(As5,4,0x000),
    DN(___,0,0x000),
    DN(B_5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Cs6,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Ds6,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Fs6,4,0x000),
    DN(___,0,0xB03),
};
static const unsigned char P12[] = {
    DN(D_4,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(F_4,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(D_4,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(D_4,4,0x000),
    DN(___,0,0x000),
    DN(F_4,4,0x000),
    DN(___,0,0x000),
    DN(D_4,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(E_4,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(D_4,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(F_4,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(D_4,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(D_4,4,0x000),
    DN(___,0,0x000),
    DN(Ds4,4,0x000),
    DN(___,0,0x000),
    DN(E_4,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Fs4,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Gs4,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(B_4,4,0x000),
    DN(___,0,0x000),
};
static const unsigned char P13[] = {
    DN(F_5,2,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(F_5,2,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(F_5,2,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(D_5,1,0x000),
    DN(D_5,1,0x000),
    DN(D_5,1,0x000),
    DN(F_5,2,0x000),
    DN(___,0,0x000),
    DN(F_5,2,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(F_5,2,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(D_5,1,0x000),
    DN(___,0,0x000),
    DN(D_5,1,0x000),
    DN(D_5,1,0x000),
    DN(D_5,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(F_5,2,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(F_5,2,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(F_5,2,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(D_5,1,0x000),
    DN(D_5,1,0x000),
    DN(D_5,1,0x000),
    DN(F_5,2,0x000),
    DN(___,0,0x000),
    DN(F_5,2,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(F_5,2,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(D_5,1,0x000),
    DN(___,0,0x000),
    DN(F_5,2,0x000),
    DN(___,0,0x000),
    DN(D_5,1,0x000),
    DN(___,0,0x000),
};

static const unsigned char* const order1[] = {P0,P0,P4,P4,P8,P8,P10};
static const unsigned char* const order2[] = {P1,P1,P5,P5,P9,P9,P11};
static const unsigned char* const order3[] = {P2,P2,P6,P6,P6,P6,P12};
static const unsigned char* const order4[] = {P3,P7,P7,P7,P7,P7,P13};

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
144,113,26,28,227,236,0,0,
144,64,7,24,29,229,0,29,
128,64,0,228,0,7,0,0,
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
    0,0,136,136,136,136,128,0,0,0,0,0,0,0,0,0,
    0,0,2,34,34,34,119,119,119,119,119,112,0,0,0,0,
    0,0,0,0,0,0,0,0,255,255,255,255,255,255,255,255,
    0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,
    0,1,18,35,52,69,86,103,120,137,154,171,188,205,222,239,
    254,220,186,152,118,84,50,16,18,52,86,120,154,188,222,255,
    122,205,219,117,33,19,104,189,220,151,65,1,71,156,221,184,
    15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,
    254,252,250,248,246,244,242,240,242,244,246,248,250,252,254,255,
    254,221,204,187,170,153,136,119,138,189,241,36,87,138,189,238,
    132,17,97,237,87,71,90,173,206,163,23,121,221,32,3,71,
    193,30,40,39,145,25,9,55,99,139,190,226,45,218,130,200,
    158,12,138,129,52,165,58,183,227,153,208,174,13,8,156,169,
    120,134,153,23,76,164,238,208,124,113,183,142,155,12,80,163,
    69,172,134,101,26,82,0,114,55,73,187,122,177,133,176,164,
    198,185,73,158,42,110,149,117,126,212,18,112,65,158,235,5,
};

const hUGESong_t bossoverwtheme = {5, &order_cnt, order1, order2, order3,order4, duty_instruments, wave_instruments, noise_instruments, NULL, waves};
