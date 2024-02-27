#pragma bank 6
#include "hUGEDriver.h"
#include <stddef.h>

static const unsigned char order_cnt = 12;

static const unsigned char P0[] = {
    DN(G_5,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Fs5,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(E_5,1,0x000),
    DN(___,0,0x000),
    DN(Cs5,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(B_4,1,0x000),
    DN(___,0,0x000),
    DN(Cs5,1,0x000),
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
    DN(___,0,0xD01),
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
    DN(D_6,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Cs6,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(B_5,4,0x000),
    DN(___,0,0x000),
    DN(Gs5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Fs5,4,0x000),
    DN(___,0,0x000),
    DN(Gs5,4,0x000),
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
    DN(G_4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(G_4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(G_4,1,0x000),
    DN(Fs4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Fs4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(B_3,1,0x000),
    DN(Cs4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Cs4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(B_3,1,0x000),
    DN(Cs4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Cs4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(B_3,1,0x000),
    DN(Cs4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Cs4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(B_3,1,0x000),
    DN(Cs4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Cs4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(B_3,1,0x000),
    DN(Cs4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Cs4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(B_3,1,0x000),
    DN(Cs4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Cs4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
};
static const unsigned char P3[] = {
    DN(F_5,2,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(G_5,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(F_5,2,0x000),
    DN(F_5,2,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(G_5,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(F_5,2,0x000),
    DN(F_5,2,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(G_5,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(F_5,2,0x000),
    DN(F_5,2,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(G_5,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(F_5,2,0x000),
    DN(F_5,2,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(G_5,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(F_5,2,0x000),
    DN(F_5,2,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(G_5,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(F_5,2,0x000),
    DN(F_5,2,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(G_5,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(F_5,2,0x000),
    DN(F_5,2,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(G_5,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
};
static const unsigned char P4[] = {
    DN(G_5,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Fs5,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(B_4,1,0x000),
    DN(___,0,0x000),
    DN(Cs5,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(E_5,1,0x000),
    DN(___,0,0x000),
    DN(Cs5,1,0x000),
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
    DN(___,0,0xD01),
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
static const unsigned char P5[] = {
    DN(D_6,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Cs6,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Fs5,4,0x000),
    DN(___,0,0x000),
    DN(Gs5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(B_5,4,0x000),
    DN(___,0,0x000),
    DN(Gs5,4,0x000),
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
static const unsigned char P6[] = {
    DN(E_6,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(E_6,4,0x000),
    DN(___,0,0x000),
    DN(E_6,4,0x000),
    DN(___,0,0x000),
    DN(Fs6,4,0x000),
    DN(___,0,0x000),
    DN(Fs6,4,0x000),
    DN(___,0,0x000),
    DN(Fs6,4,0x000),
    DN(___,0,0x000),
    DN(Fs6,4,0x101),
    DN(___,0,0x101),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Fs6,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(B_5,4,0x000),
    DN(___,0,0x000),
    DN(E_6,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Ds6,4,0x000),
    DN(___,0,0x000),
    DN(D_6,4,0x000),
    DN(___,0,0x000),
    DN(Cs6,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(B_5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Fs6,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Ds6,4,0x000),
    DN(___,0,0x000),
    DN(D_6,4,0x000),
    DN(___,0,0x000),
    DN(Cs6,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0xD01),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
};
static const unsigned char P7[] = {
    DN(E_5,3,0xC0B),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Fs5,3,0xC0B),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(G_5,3,0xC0B),
    DN(___,0,0x000),
    DN(Cs4,4,0xC0B),
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
};
static const unsigned char P8[] = {
    DN(E_5,4,0x000),
    DN(___,0,0x000),
    DN(Fs5,4,0x000),
    DN(___,0,0x000),
    DN(G_5,4,0x000),
    DN(___,0,0x000),
    DN(Fs5,4,0x000),
    DN(___,0,0x000),
    DN(G_5,4,0x000),
    DN(___,0,0x000),
    DN(Fs5,4,0x000),
    DN(___,0,0x000),
    DN(G_5,4,0x000),
    DN(___,0,0x000),
    DN(A_5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(E_5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(E_6,4,0x000),
    DN(___,0,0x000),
    DN(Ds6,4,0x000),
    DN(___,0,0x000),
    DN(D_6,4,0x000),
    DN(___,0,0x000),
    DN(Cs6,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(B_5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Fs6,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Ds6,4,0x000),
    DN(___,0,0x000),
    DN(D_6,4,0x000),
    DN(___,0,0x000),
    DN(Cs6,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0xD01),
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
static const unsigned char P9[] = {
    DN(E_4,3,0xC0B),
    DN(___,0,0x000),
    DN(Fs4,3,0xC0B),
    DN(___,0,0x000),
    DN(G_4,3,0xC0B),
    DN(___,0,0x000),
    DN(Fs4,3,0xC0B),
    DN(___,0,0x000),
    DN(G_4,3,0xC0B),
    DN(___,0,0x000),
    DN(Fs4,3,0xC0B),
    DN(___,0,0x000),
    DN(G_4,3,0xC0B),
    DN(___,0,0x000),
    DN(A_4,3,0xC0B),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(E_5,3,0xC0B),
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
static const unsigned char P10[] = {
    DN(E_5,4,0x000),
    DN(___,0,0x000),
    DN(Fs5,4,0x000),
    DN(___,0,0x000),
    DN(G_5,4,0x000),
    DN(___,0,0x000),
    DN(Fs5,4,0x000),
    DN(___,0,0x000),
    DN(G_5,4,0x000),
    DN(___,0,0x000),
    DN(Fs5,4,0x000),
    DN(___,0,0x000),
    DN(G_5,4,0x000),
    DN(___,0,0x000),
    DN(A_5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(D_5,4,0x000),
    DN(___,0,0x000),
    DN(E_5,4,0x000),
    DN(___,0,0x000),
    DN(F_5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(D_5,4,0x000),
    DN(___,0,0x000),
    DN(G_5,4,0x000),
    DN(___,0,0x000),
    DN(F_5,4,0x000),
    DN(___,0,0x000),
    DN(E_5,4,0x000),
    DN(___,0,0x000),
    DN(Ds5,4,0x000),
    DN(___,0,0x000),
    DN(D_5,4,0x000),
    DN(___,0,0x000),
    DN(B_4,4,0x000),
    DN(___,0,0x000),
    DN(D_5,4,0x000),
    DN(___,0,0x000),
    DN(E_5,4,0x000),
    DN(___,0,0x000),
    DN(F_5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(F_5,4,0x000),
    DN(___,0,0x000),
    DN(F_5,4,0x000),
    DN(___,0,0xD01),
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
static const unsigned char P11[] = {
    DN(E_4,3,0xC0B),
    DN(___,0,0x000),
    DN(Fs4,3,0xC0B),
    DN(___,0,0x000),
    DN(G_4,3,0xC0B),
    DN(___,0,0x000),
    DN(Fs4,3,0xC0B),
    DN(___,0,0x000),
    DN(G_4,3,0xC0B),
    DN(___,0,0x000),
    DN(Fs4,3,0xC0B),
    DN(___,0,0x000),
    DN(G_4,3,0xC0B),
    DN(___,0,0x000),
    DN(A_4,3,0xC0B),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(A_5,4,0xC0B),
    DN(___,0,0x000),
    DN(B_5,4,0xC0B),
    DN(___,0,0x000),
    DN(C_6,4,0xC0B),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(A_5,4,0xC0B),
    DN(___,0,0x000),
    DN(D_6,4,0xC0B),
    DN(___,0,0x000),
    DN(C_6,4,0x000),
    DN(___,0,0x000),
    DN(B_5,4,0xC0B),
    DN(___,0,0x000),
    DN(As5,4,0x000),
    DN(___,0,0x000),
    DN(A_5,4,0xC0B),
    DN(___,0,0x000),
    DN(Fs5,4,0x000),
    DN(___,0,0x000),
    DN(A_5,4,0xC0B),
    DN(___,0,0x000),
    DN(B_5,4,0x000),
    DN(___,0,0x000),
    DN(C_6,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(C_6,4,0x000),
    DN(___,0,0x000),
    DN(C_6,4,0x000),
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
static const unsigned char P12[] = {
    DN(G_4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(G_4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(G_4,1,0x000),
    DN(Fs4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Fs4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(B_3,1,0x000),
    DN(Gs4,2,0xC0B),
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

static const unsigned char* const order1[] = {P0,P4,P6,P8,P6,P10};
static const unsigned char* const order2[] = {P1,P5,P7,P9,P7,P11};
static const unsigned char* const order3[] = {P2,P2,P12,P2,P12,P2};
static const unsigned char* const order4[] = {P3,P3,P3,P3,P3,P3};

static const unsigned char duty_instruments[] = {
8,0,240,128,
8,64,240,128,
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
160,113,26,28,227,236,0,0,
160,102,7,24,29,229,0,29,
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
    178,180,18,42,130,152,60,132,139,232,153,183,142,65,5,123,
    42,153,38,77,238,58,168,219,6,166,8,59,211,88,91,104,
    218,86,155,158,11,152,20,53,137,219,231,131,171,18,3,141,
    66,69,66,135,233,23,192,217,62,193,17,168,109,116,59,227,
    138,193,98,208,62,148,118,233,140,0,128,62,2,198,146,118,
};

const hUGESong_t fortstratostheme = {6, &order_cnt, order1, order2, order3,order4, duty_instruments, wave_instruments, noise_instruments, NULL, waves};