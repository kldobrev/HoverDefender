#pragma bank 2
#include "hUGEDriver.h"
#include <stddef.h>

static const unsigned char order_cnt = 10;

static const unsigned char P0[] = {
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
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
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
    DN(D_4,1,0x000),
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
    DN(D_4,1,0x000),
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
    DN(D_4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(D_4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(F_4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(F_4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(F_4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(F_4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Ds4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Ds4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Ds4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(F_4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
};
static const unsigned char P3[] = {
    DN(D_5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(C_5,2,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(D_5,4,0x000),
    DN(___,0,0x000),
    DN(D_5,4,0x000),
    DN(___,0,0x000),
    DN(C_5,2,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(D_5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(C_5,2,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(D_5,4,0x000),
    DN(___,0,0x000),
    DN(D_5,4,0x000),
    DN(___,0,0x000),
    DN(C_5,2,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(D_5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(C_5,2,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(D_5,4,0x000),
    DN(___,0,0x000),
    DN(D_5,4,0x000),
    DN(___,0,0x000),
    DN(C_5,2,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(D_5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(C_5,2,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(D_5,4,0x000),
    DN(___,0,0x000),
    DN(D_5,4,0x000),
    DN(___,0,0x000),
    DN(C_5,2,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
};
static const unsigned char P4[] = {
    DN(D_4,1,0x000),
    DN(___,0,0x000),
    DN(D_4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(D_4,1,0x000),
    DN(___,0,0x000),
    DN(C_4,1,0x000),
    DN(___,0,0x000),
    DN(D_4,1,0x000),
    DN(___,0,0x000),
    DN(A_4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(G_4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Fs4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(G_4,1,0x000),
    DN(___,0,0x000),
    DN(G_4,1,0x000),
    DN(___,0,0x000),
    DN(G_4,1,0x000),
    DN(___,0,0x000),
    DN(D_4,1,0x000),
    DN(___,0,0x000),
    DN(D_4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(D_4,1,0x000),
    DN(___,0,0x000),
    DN(C_4,1,0x000),
    DN(___,0,0x000),
    DN(D_4,1,0x000),
    DN(___,0,0x000),
    DN(As3,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(As3,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(C_4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(C_4,1,0x000),
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
    DN(A_4,1,0x000),
    DN(___,0,0x000),
    DN(A_4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(A_4,1,0x000),
    DN(___,0,0x000),
    DN(G_4,1,0x000),
    DN(___,0,0x000),
    DN(A_4,1,0x000),
    DN(___,0,0x000),
    DN(E_5,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(D_5,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Cs5,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(D_5,1,0x000),
    DN(___,0,0x000),
    DN(D_5,1,0x000),
    DN(___,0,0x000),
    DN(D_5,1,0x000),
    DN(___,0,0x000),
    DN(A_4,1,0x000),
    DN(___,0,0x000),
    DN(A_4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(A_4,1,0x000),
    DN(___,0,0x000),
    DN(G_4,1,0x000),
    DN(___,0,0x000),
    DN(A_4,1,0x000),
    DN(___,0,0x000),
    DN(F_4,1,0x000),
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
    DN(G_4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0xB00),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
};
static const unsigned char P6[] = {
    DN(D_4,1,0x000),
    DN(___,0,0x000),
    DN(D_4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(D_4,1,0x000),
    DN(___,0,0x000),
    DN(C_4,1,0x000),
    DN(___,0,0x000),
    DN(D_4,1,0x000),
    DN(___,0,0x000),
    DN(D_4,1,0x000),
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
    DN(D_4,1,0x000),
    DN(___,0,0x000),
    DN(D_4,1,0x000),
    DN(___,0,0x000),
    DN(D_4,1,0x000),
    DN(___,0,0x000),
    DN(D_4,1,0x000),
    DN(___,0,0x000),
    DN(D_4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(D_4,1,0x000),
    DN(___,0,0x000),
    DN(C_4,1,0x000),
    DN(___,0,0x000),
    DN(D_4,1,0x000),
    DN(___,0,0x000),
    DN(F_4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(F_4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(C_4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(C_4,1,0x000),
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
static const unsigned char P7[] = {
    DN(Gs3,1,0x000),
    DN(___,0,0x000),
    DN(Gs3,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Gs3,1,0x000),
    DN(___,0,0x000),
    DN(As3,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(As3,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(C_4,1,0x000),
    DN(___,0,0x000),
    DN(C_4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(C_4,1,0x000),
    DN(___,0,0x000),
    DN(C_4,1,0x000),
    DN(___,0,0x000),
    DN(C_4,1,0x000),
    DN(___,0,0x000),
    DN(C_4,1,0x000),
    DN(___,0,0x000),
    DN(C_4,1,0x000),
    DN(___,0,0x000),
    DN(Gs3,1,0x000),
    DN(___,0,0x000),
    DN(Gs3,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Gs3,1,0x000),
    DN(___,0,0x000),
    DN(As3,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(As3,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Ds4,1,0x000),
    DN(___,0,0x000),
    DN(D_4,1,0x000),
    DN(___,0,0x000),
    DN(C_4,1,0x000),
    DN(___,0,0x000),
    DN(Ds4,1,0x000),
    DN(___,0,0x000),
    DN(D_4,1,0x000),
    DN(___,0,0x000),
    DN(C_4,1,0x000),
    DN(___,0,0x000),
    DN(As3,1,0x000),
    DN(___,0,0x000),
    DN(C_4,1,0x000),
    DN(___,0,0x000),
};
static const unsigned char P8[] = {
    DN(Ds4,1,0x000),
    DN(___,0,0x000),
    DN(Ds4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Ds4,1,0x000),
    DN(___,0,0x000),
    DN(F_4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(F_4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(G_4,1,0x000),
    DN(___,0,0x000),
    DN(G_4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(G_4,1,0x000),
    DN(___,0,0x000),
    DN(G_4,1,0x000),
    DN(___,0,0x000),
    DN(G_4,1,0x000),
    DN(___,0,0x000),
    DN(G_4,1,0x000),
    DN(___,0,0x000),
    DN(G_4,1,0x000),
    DN(___,0,0x000),
    DN(Ds4,1,0x000),
    DN(___,0,0x000),
    DN(Ds4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Ds4,1,0x000),
    DN(___,0,0x000),
    DN(F_4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(F_4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Ds5,1,0x000),
    DN(___,0,0x000),
    DN(D_5,1,0x000),
    DN(___,0,0x000),
    DN(C_5,1,0x000),
    DN(___,0,0x000),
    DN(Ds5,1,0x000),
    DN(___,0,0x000),
    DN(D_5,1,0x000),
    DN(___,0,0x000),
    DN(C_5,1,0x000),
    DN(___,0,0x000),
    DN(As4,1,0x000),
    DN(___,0,0x000),
    DN(C_5,1,0x000),
    DN(___,0,0x000),
};
static const unsigned char P9[] = {
    DN(Gs3,1,0x000),
    DN(___,0,0x000),
    DN(Gs3,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Gs3,1,0x000),
    DN(___,0,0x000),
    DN(As3,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(As3,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(C_4,1,0x000),
    DN(___,0,0x000),
    DN(C_4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(C_4,1,0x000),
    DN(___,0,0x000),
    DN(C_4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(C_4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Gs3,1,0x000),
    DN(___,0,0x000),
    DN(Gs3,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Gs3,1,0x000),
    DN(___,0,0x000),
    DN(As3,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(As3,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(C_4,1,0x000),
    DN(___,0,0x000),
    DN(C_4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(C_4,1,0x000),
    DN(___,0,0x000),
    DN(C_4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(C_4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
};
static const unsigned char P10[] = {
    DN(D_5,4,0x000),
    DN(___,0,0x000),
    DN(D_5,4,0x000),
    DN(___,0,0x000),
    DN(C_5,2,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(D_5,4,0x000),
    DN(___,0,0x000),
    DN(D_5,4,0x000),
    DN(___,0,0x000),
    DN(C_5,2,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(D_5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(C_5,2,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(D_5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(C_5,2,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(D_5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(C_5,2,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(D_5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(C_5,2,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(D_5,4,0x000),
    DN(___,0,0x000),
    DN(D_5,4,0x000),
    DN(___,0,0x000),
    DN(C_5,2,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(D_5,4,0x000),
    DN(___,0,0x000),
    DN(D_5,4,0x000),
    DN(___,0,0x000),
    DN(C_5,2,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
};
static const unsigned char P11[] = {
    DN(Gs3,1,0x000),
    DN(___,0,0x000),
    DN(Gs3,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Gs3,1,0x000),
    DN(___,0,0x000),
    DN(As3,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(As3,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(C_4,1,0x000),
    DN(___,0,0x000),
    DN(C_4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(C_4,1,0x000),
    DN(___,0,0x000),
    DN(C_4,1,0x000),
    DN(___,0,0x000),
    DN(C_4,1,0x000),
    DN(___,0,0x000),
    DN(C_4,1,0x000),
    DN(___,0,0x000),
    DN(C_4,1,0x000),
    DN(___,0,0x000),
    DN(Gs3,1,0x000),
    DN(___,0,0x000),
    DN(Gs3,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Gs3,1,0x000),
    DN(___,0,0x000),
    DN(G_3,1,0x000),
    DN(___,0,0x000),
    DN(G_3,1,0x000),
    DN(___,0,0x000),
    DN(G_3,1,0x000),
    DN(___,0,0x000),
    DN(G_3,1,0x000),
    DN(___,0,0x000),
    DN(F_3,1,0x000),
    DN(___,0,0x000),
    DN(F_3,1,0x000),
    DN(___,0,0x000),
    DN(F_3,1,0x000),
    DN(___,0,0x000),
    DN(F_3,1,0x000),
    DN(___,0,0x000),
    DN(Ds3,1,0x000),
    DN(___,0,0x000),
    DN(Ds3,1,0x000),
    DN(___,0,0x000),
    DN(Ds3,1,0x000),
    DN(___,0,0x000),
    DN(Ds3,1,0x000),
    DN(___,0,0x000),
};
static const unsigned char P12[] = {
    DN(Ds4,1,0x000),
    DN(___,0,0x000),
    DN(Ds4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Ds4,1,0x000),
    DN(___,0,0x000),
    DN(F_4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(F_4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(G_4,1,0x000),
    DN(___,0,0x000),
    DN(G_4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(G_4,1,0x000),
    DN(___,0,0x000),
    DN(G_4,1,0x000),
    DN(___,0,0x000),
    DN(G_4,1,0x000),
    DN(___,0,0x000),
    DN(G_4,1,0x000),
    DN(___,0,0x000),
    DN(G_4,1,0x000),
    DN(___,0,0x000),
    DN(Ds4,1,0x000),
    DN(___,0,0x000),
    DN(Ds4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Ds4,1,0x000),
    DN(___,0,0x000),
    DN(D_4,1,0x000),
    DN(___,0,0x000),
    DN(D_4,1,0x000),
    DN(___,0,0x000),
    DN(Cs4,1,0x000),
    DN(___,0,0x000),
    DN(Cs4,1,0x000),
    DN(___,0,0x000),
    DN(C_4,1,0x000),
    DN(___,0,0x000),
    DN(C_4,1,0x000),
    DN(___,0,0x000),
    DN(B_3,1,0x000),
    DN(___,0,0x000),
    DN(B_3,1,0x000),
    DN(___,0,0x000),
    DN(As3,1,0x000),
    DN(___,0,0x000),
    DN(As3,1,0x000),
    DN(___,0,0x000),
    DN(A_3,1,0x000),
    DN(___,0,0x000),
    DN(A_3,1,0x000),
    DN(___,0,0x000),
};
static const unsigned char P13[] = {
    DN(Gs3,1,0x000),
    DN(___,0,0x000),
    DN(Gs3,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Gs3,1,0x000),
    DN(___,0,0x000),
    DN(As3,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(As3,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(C_4,1,0x000),
    DN(___,0,0x000),
    DN(C_4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(C_4,1,0x000),
    DN(___,0,0x000),
    DN(C_4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(C_4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Gs3,1,0x000),
    DN(___,0,0x000),
    DN(Gs3,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Gs3,1,0x000),
    DN(___,0,0x000),
    DN(G_3,1,0x000),
    DN(___,0,0x000),
    DN(G_3,1,0x000),
    DN(___,0,0x000),
    DN(G_3,1,0x000),
    DN(___,0,0x000),
    DN(G_3,1,0x000),
    DN(___,0,0x000),
    DN(F_3,1,0x000),
    DN(___,0,0x000),
    DN(F_3,1,0x000),
    DN(___,0,0x000),
    DN(F_3,1,0x000),
    DN(___,0,0x000),
    DN(F_3,1,0x000),
    DN(___,0,0x000),
    DN(Ds3,1,0x000),
    DN(___,0,0x000),
    DN(Ds3,1,0x000),
    DN(___,0,0x000),
    DN(Ds3,1,0x000),
    DN(___,0,0x000),
    DN(Ds3,1,0x000),
    DN(___,0,0x000),
};
static const unsigned char P14[] = {
    DN(D_5,4,0x000),
    DN(___,0,0x000),
    DN(D_5,4,0x000),
    DN(___,0,0x000),
    DN(C_5,2,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(D_5,4,0x000),
    DN(___,0,0x000),
    DN(D_5,4,0x000),
    DN(___,0,0x000),
    DN(C_5,2,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(D_5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(C_5,2,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(D_5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(C_5,2,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(D_5,4,0x000),
    DN(___,0,0x000),
    DN(D_5,4,0x000),
    DN(___,0,0x000),
    DN(C_5,2,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(D_5,4,0x000),
    DN(___,0,0x000),
    DN(D_5,4,0x000),
    DN(___,0,0x000),
    DN(C_5,2,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(D_5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(C_5,2,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(D_5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(C_5,2,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
};

static const unsigned char* const order1[] = {P0,P4,P4,P7,P11};
static const unsigned char* const order2[] = {P0,P5,P5,P8,P12};
static const unsigned char* const order3[] = {P2,P6,P6,P9,P13};
static const unsigned char* const order4[] = {P3,P3,P3,P10,P14};

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
112,64,0,0,0,233,0,0,
112,64,232,25,30,232,0,0,
240,64,0,228,0,7,0,0,
112,64,231,25,15,0,0,0,
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
    0,0,238,238,238,189,221,221,219,238,238,238,238,0,0,0,
    0,0,238,238,238,189,221,221,219,238,238,238,238,0,0,0,
    0,0,0,0,0,0,0,0,255,255,255,255,255,255,255,255,
    0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,
    0,1,18,35,52,69,86,103,120,137,154,171,188,205,222,239,
    254,220,186,152,118,84,50,16,18,52,86,120,154,188,222,255,
    122,205,219,117,33,19,104,189,220,151,65,1,71,156,221,184,
    15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,
    254,252,250,248,246,244,242,240,242,244,246,248,250,252,254,255,
    254,221,204,187,170,153,136,119,138,189,241,36,87,138,189,238,
    132,17,97,237,87,71,90,173,206,163,23,121,221,32,3,71,
    156,101,77,199,84,211,23,202,192,151,64,151,70,195,69,48,
    104,206,99,16,113,183,38,76,235,70,148,43,162,188,202,91,
    57,68,195,162,5,71,87,40,112,28,13,90,142,112,39,215,
    0,160,148,210,50,228,12,211,160,52,134,180,11,161,130,149,
    236,226,218,128,4,99,114,108,77,171,35,5,33,99,172,153,
};

const hUGESong_t mountaintheme = {6, &order_cnt, order1, order2, order3,order4, duty_instruments, wave_instruments, noise_instruments, NULL, waves};
