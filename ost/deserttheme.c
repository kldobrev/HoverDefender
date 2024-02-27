#pragma bank 2
#include "hUGEDriver.h"
#include <stddef.h>

static const unsigned char order_cnt = 16;

static const unsigned char P0[] = {
    DN(B_4,4,0x000),
    DN(___,0,0x000),
    DN(B_4,4,0x000),
    DN(___,0,0x000),
    DN(B_4,4,0x000),
    DN(___,0,0x000),
    DN(B_4,4,0x000),
    DN(___,0,0x000),
    DN(B_4,4,0x000),
    DN(___,0,0x000),
    DN(B_4,4,0x000),
    DN(___,0,0x000),
    DN(B_4,4,0x000),
    DN(___,0,0x000),
    DN(B_4,4,0x000),
    DN(___,0,0x000),
    DN(D_5,4,0x000),
    DN(___,0,0x422),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(E_5,4,0x000),
    DN(___,0,0x000),
    DN(B_4,4,0x000),
    DN(___,0,0x422),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(A_4,4,0x000),
    DN(___,0,0x000),
    DN(A_4,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(B_4,4,0x000),
    DN(___,0,0x000),
    DN(B_4,4,0x000),
    DN(___,0,0x000),
    DN(B_4,4,0x000),
    DN(___,0,0x000),
    DN(B_4,4,0x000),
    DN(___,0,0x000),
    DN(B_4,4,0x000),
    DN(___,0,0x000),
    DN(B_4,4,0x000),
    DN(___,0,0x000),
    DN(B_4,4,0x000),
    DN(___,0,0x000),
    DN(B_4,4,0x000),
    DN(___,0,0x000),
    DN(G_5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(G_5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(A_5,4,0x000),
    DN(___,0,0x420),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(A_5,4,0x000),
    DN(___,0,0x420),
    DN(___,0,0x000),
    DN(___,0,0x000),
};
static const unsigned char P1[] = {
    DN(___,0,0xE00),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Fs5,2,0x000),
    DN(___,0,0x000),
    DN(___,0,0xE00),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Fs5,2,0x000),
    DN(___,0,0x000),
    DN(___,0,0xE00),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(A_5,2,0x000),
    DN(___,0,0x422),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(B_5,2,0x000),
    DN(___,0,0x000),
    DN(Fs5,2,0x000),
    DN(___,0,0x422),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(E_5,2,0x000),
    DN(___,0,0x000),
    DN(E_5,2,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0xE00),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Fs5,2,0x000),
    DN(___,0,0x000),
    DN(___,0,0xE00),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Fs5,2,0x000),
    DN(___,0,0x000),
    DN(___,0,0xE00),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(D_6,2,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(D_6,2,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(E_6,2,0x000),
    DN(___,0,0x420),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(E_6,2,0x000),
    DN(___,0,0x420),
    DN(___,0,0x000),
    DN(___,0,0x000),
};
static const unsigned char P2[] = {
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
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
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
    DN(___,0,0x000),
    DN(___,0,0x000),
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
static const unsigned char P3[] = {
    DN(___,0,0xE00),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Fs5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Fs5,4,0x000),
    DN(___,0,0x000),
    DN(Fs5,4,0x000),
    DN(___,0,0x000),
    DN(Fs5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(B_5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(A_5,4,0x000),
    DN(___,0,0x000),
    DN(Fs5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(E_5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(A_5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(A_5,4,0x000),
    DN(___,0,0x000),
    DN(B_5,4,0x000),
    DN(___,0,0x000),
    DN(E_5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(B_5,4,0x000),
    DN(___,0,0x000),
    DN(A_5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(A_5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(B_5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
};
static const unsigned char P4[] = {
    DN(B_3,1,0x000),
    DN(___,0,0x000),
    DN(B_3,1,0x000),
    DN(___,0,0x000),
    DN(B_3,1,0x000),
    DN(___,0,0x000),
    DN(B_3,1,0x000),
    DN(___,0,0x000),
    DN(B_3,1,0x000),
    DN(___,0,0x000),
    DN(B_3,1,0x000),
    DN(___,0,0x000),
    DN(B_3,1,0x000),
    DN(___,0,0x000),
    DN(B_3,1,0x000),
    DN(___,0,0x000),
    DN(D_4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(D_4,1,0x000),
    DN(___,0,0x000),
    DN(E_4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(E_4,1,0x000),
    DN(___,0,0x000),
    DN(E_4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(B_3,1,0x000),
    DN(___,0,0x000),
    DN(B_3,1,0x000),
    DN(___,0,0x000),
    DN(B_3,1,0x000),
    DN(___,0,0x000),
    DN(B_3,1,0x000),
    DN(___,0,0x000),
    DN(B_3,1,0x000),
    DN(___,0,0x000),
    DN(B_3,1,0x000),
    DN(___,0,0x000),
    DN(B_3,1,0x000),
    DN(___,0,0x000),
    DN(B_3,1,0x000),
    DN(___,0,0x000),
    DN(E_4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(E_4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(D_4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(D_4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
};
static const unsigned char P5[] = {
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
    DN(B_5,1,0x000),
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
    DN(B_5,1,0x000),
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
    DN(B_5,1,0x000),
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
    DN(B_5,1,0x000),
    DN(___,0,0x000),
    DN(F_5,2,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
};
static const unsigned char P6[] = {
    DN(___,0,0xE00),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(B_4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(B_4,1,0x000),
    DN(___,0,0x000),
    DN(B_4,1,0x000),
    DN(___,0,0x000),
    DN(B_4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(E_5,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(D_5,1,0x000),
    DN(___,0,0x000),
    DN(B_4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(A_4,1,0x000),
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
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(D_5,4,0x000),
    DN(___,0,0x000),
    DN(E_5,4,0x000),
    DN(___,0,0x000),
    DN(A_4,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(E_5,4,0x000),
    DN(___,0,0x000),
    DN(D_5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(D_5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(E_5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
};
static const unsigned char P7[] = {
    DN(B_3,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(B_3,1,0x000),
    DN(___,0,0x000),
    DN(B_3,1,0x000),
    DN(___,0,0x000),
    DN(B_3,1,0x000),
    DN(___,0,0x000),
    DN(B_3,1,0x000),
    DN(___,0,0x000),
    DN(B_3,1,0x000),
    DN(___,0,0x000),
    DN(B_3,1,0x000),
    DN(___,0,0x000),
    DN(A_3,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(A_3,1,0x000),
    DN(___,0,0x000),
    DN(A_3,1,0x000),
    DN(___,0,0x000),
    DN(A_3,1,0x000),
    DN(___,0,0x000),
    DN(A_3,1,0x000),
    DN(___,0,0x000),
    DN(A_3,1,0x000),
    DN(___,0,0x000),
    DN(A_3,1,0x000),
    DN(___,0,0x000),
    DN(E_4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(E_4,1,0x000),
    DN(___,0,0x000),
    DN(E_4,1,0x000),
    DN(___,0,0x000),
    DN(E_4,1,0x000),
    DN(___,0,0x000),
    DN(E_4,1,0x000),
    DN(___,0,0x000),
    DN(E_4,1,0x000),
    DN(___,0,0x000),
    DN(E_4,1,0x000),
    DN(___,0,0x000),
    DN(D_4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(D_4,1,0x000),
    DN(___,0,0x000),
    DN(D_4,1,0x000),
    DN(___,0,0x000),
    DN(D_4,1,0x000),
    DN(___,0,0x000),
    DN(E_4,1,0x000),
    DN(___,0,0x000),
    DN(E_4,1,0x000),
    DN(___,0,0x000),
    DN(E_4,1,0x000),
    DN(___,0,0x000),
};
static const unsigned char P8[] = {
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(B_5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(A_5,4,0x000),
    DN(___,0,0x000),
    DN(Gs5,4,0x000),
    DN(___,0,0x000),
    DN(E_5,4,0x000),
    DN(___,0,0x000),
    DN(A_5,4,0x000),
    DN(___,0,0x000),
    DN(Gs5,4,0x000),
    DN(___,0,0x000),
    DN(E_5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(B_5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(E_5,4,0x000),
    DN(___,0,0x000),
    DN(A_5,4,0x000),
    DN(___,0,0x000),
    DN(Gs5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Fs5,4,0x000),
    DN(___,0,0x000),
    DN(A_5,4,0x000),
    DN(___,0,0x000),
    DN(Gs5,4,0x000),
    DN(___,0,0x000),
    DN(D_5,4,0x000),
    DN(___,0,0x000),
    DN(B_5,4,0x000),
    DN(___,0,0x000),
    DN(B_5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(B_5,4,0xC7F),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0xB03),
};
static const unsigned char P9[] = {
    DN(___,0,0xE00),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(As5,4,0x104),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(B_5,4,0x000),
    DN(___,0,0x000),
    DN(B_5,4,0x000),
    DN(___,0,0x000),
    DN(B_5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(A_5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(A_5,4,0x000),
    DN(___,0,0x000),
    DN(Gs5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Gs5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(A_5,4,0x000),
    DN(___,0,0x000),
    DN(B_5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(E_5,4,0x000),
    DN(___,0,0x422),
    DN(___,0,0x422),
    DN(___,0,0x422),
    DN(___,0,0x422),
    DN(___,0,0x422),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Cs6,4,0x000),
    DN(___,0,0x000),
    DN(B_5,4,0x000),
    DN(___,0,0x000),
    DN(Gs5,4,0x000),
    DN(___,0,0x000),
    DN(B_5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(E_6,4,0x000),
    DN(___,0,0x000),
    DN(E_6,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
};
static const unsigned char P10[] = {
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(E_6,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(D_6,4,0x000),
    DN(___,0,0x000),
    DN(Cs6,4,0x000),
    DN(___,0,0x000),
    DN(A_5,4,0x000),
    DN(___,0,0x000),
    DN(D_6,4,0x000),
    DN(___,0,0x000),
    DN(Cs6,4,0x000),
    DN(___,0,0x000),
    DN(A_5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(E_6,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(A_5,4,0x000),
    DN(___,0,0x000),
    DN(D_6,4,0x000),
    DN(___,0,0x000),
    DN(Cs6,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(B_5,4,0x000),
    DN(___,0,0x000),
    DN(D_6,4,0x000),
    DN(___,0,0x000),
    DN(Cs6,4,0x000),
    DN(___,0,0x000),
    DN(G_5,4,0x000),
    DN(___,0,0x000),
    DN(E_6,4,0x000),
    DN(___,0,0x000),
    DN(E_6,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(E_6,4,0xC7F),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
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
    DN(___,0,0xE00),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Fs4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(E_4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(B_4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Fs5,4,0x000),
    DN(___,0,0x000),
    DN(E_5,4,0x000),
    DN(___,0,0x000),
    DN(Cs5,4,0x000),
    DN(___,0,0x000),
    DN(E_5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(B_5,4,0x000),
    DN(___,0,0x000),
    DN(B_5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
};
static const unsigned char P12[] = {
    DN(___,0,0xE00),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(As5,4,0x104),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(B_5,4,0x000),
    DN(___,0,0x000),
    DN(B_5,4,0x000),
    DN(___,0,0x000),
    DN(B_5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(A_5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Gs5,4,0x000),
    DN(___,0,0x000),
    DN(E_5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Cs6,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(A_5,4,0x000),
    DN(___,0,0x000),
    DN(Gs5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(D_5,4,0x000),
    DN(___,0,0x424),
    DN(___,0,0x424),
    DN(___,0,0x424),
    DN(___,0,0x424),
    DN(___,0,0x424),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Cs6,4,0x000),
    DN(___,0,0x000),
    DN(B_5,4,0x000),
    DN(___,0,0x000),
    DN(Gs5,4,0x000),
    DN(___,0,0x000),
    DN(B_5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(E_6,4,0x000),
    DN(___,0,0x000),
    DN(E_6,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
};

static const unsigned char* const order1[] = {P0,P0,P0,P0,P9,P12,P3,P8};
static const unsigned char* const order2[] = {P1,P1,P1,P1,P11,P11,P6,P10};
static const unsigned char* const order3[] = {P2,P2,P4,P4,P7,P7,P7,P7};
static const unsigned char* const order4[] = {P2,P2,P5,P5,P5,P5,P5,P5};

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
176,113,26,28,227,236,0,0,
176,64,7,24,29,229,0,29,
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
    0,0,0,0,0,0,0,0,0,0,0,9,153,153,153,153,
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
    61,189,10,184,3,215,35,165,193,229,154,27,208,21,44,236,
    163,107,96,202,225,119,150,73,64,32,204,212,21,190,16,5,
    131,237,235,187,152,113,112,158,41,228,112,87,21,158,227,171,
    205,100,124,26,157,151,187,76,204,72,161,76,128,147,56,115,
    23,9,181,135,32,43,51,54,44,162,173,74,133,46,100,226,
};

const hUGESong_t deserttheme = {5, &order_cnt, order1, order2, order3,order4, duty_instruments, wave_instruments, noise_instruments, NULL, waves};
