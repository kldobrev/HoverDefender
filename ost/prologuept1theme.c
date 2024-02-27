#pragma bank 12
#include "hUGEDriver.h"
#include <stddef.h>

static const unsigned char order_cnt = 24;

static const unsigned char P0[] = {
    DN(F_5,1,0xE05),
    DN(F_5,1,0x705),
    DN(___,0,0xE05),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(F_5,1,0xE05),
    DN(F_5,1,0x705),
    DN(___,0,0xE05),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Fs5,1,0xE05),
    DN(Fs5,1,0x705),
    DN(___,0,0xE05),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Fs5,1,0xE05),
    DN(Fs5,1,0x705),
    DN(___,0,0xE05),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
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
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
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
    DN(F_4,1,0x446),
    DN(___,0,0x446),
    DN(___,0,0x446),
    DN(___,0,0x446),
    DN(___,0,0x446),
    DN(___,0,0x446),
    DN(___,0,0x446),
    DN(___,0,0x446),
    DN(___,0,0x446),
    DN(___,0,0x446),
    DN(___,0,0x446),
    DN(___,0,0x446),
    DN(Gs4,1,0x446),
    DN(___,0,0x446),
    DN(___,0,0x446),
    DN(___,0,0x446),
    DN(___,0,0x446),
    DN(___,0,0x446),
    DN(___,0,0x446),
    DN(___,0,0x446),
    DN(___,0,0x446),
    DN(___,0,0x446),
    DN(___,0,0x446),
    DN(___,0,0x446),
    DN(Fs4,1,0x446),
    DN(___,0,0x446),
    DN(___,0,0x446),
    DN(___,0,0x446),
    DN(___,0,0x446),
    DN(___,0,0x446),
    DN(___,0,0x446),
    DN(___,0,0x446),
    DN(___,0,0x446),
    DN(___,0,0x446),
    DN(___,0,0x446),
    DN(___,0,0x446),
    DN(As4,1,0x446),
    DN(___,0,0x446),
    DN(___,0,0x446),
    DN(___,0,0x446),
    DN(___,0,0x446),
    DN(___,0,0x446),
    DN(___,0,0x446),
    DN(___,0,0x446),
    DN(___,0,0x446),
    DN(___,0,0x446),
    DN(___,0,0x446),
    DN(___,0,0x446),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
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
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
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
    DN(C_5,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(C_5,1,0x000),
    DN(F_5,2,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(C_5,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(C_5,1,0x000),
    DN(F_5,2,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(C_5,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(C_5,1,0x000),
    DN(F_5,2,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(F_4,1,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(C_5,1,0x000),
    DN(F_5,2,0x000),
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
static const unsigned char P6[] = {
    DN(As5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Gs5,4,0x000),
    DN(Fs5,4,0x000),
    DN(F_5,4,0x442),
    DN(___,0,0x442),
    DN(___,0,0x442),
    DN(___,0,0x442),
    DN(___,0,0x442),
    DN(___,0,0x442),
    DN(Ds5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(F_5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Fs5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Ds5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(F_5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Gs4,4,0x000),
    DN(Fs4,4,0x000),
    DN(F_4,4,0x428),
    DN(___,0,0x428),
    DN(___,0,0x428),
    DN(___,0,0x428),
    DN(___,0,0x428),
    DN(___,0,0x428),
    DN(F_5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Fs5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Gs5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(As5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
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
    DN(F_5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(As5,4,0x000),
    DN(Gs5,4,0x000),
    DN(Fs5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(F_5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Gs5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(As5,4,0x000),
    DN(Gs5,4,0x000),
    DN(Fs5,4,0x000),
    DN(As5,4,0x000),
    DN(___,0,0x442),
    DN(___,0,0x442),
    DN(___,0,0x442),
    DN(___,0,0x442),
    DN(___,0,0x442),
    DN(Ds6,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(F_6,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Fs6,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Gs6,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(As6,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Cs7,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Ds7,4,0x441),
    DN(___,0,0x441),
    DN(___,0,0x441),
    DN(___,0,0x441),
    DN(___,0,0x441),
    DN(___,0,0x441),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
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
    DN(F_4,4,0x000),
    DN(___,0,0x000),
    DN(F_4,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(F_4,4,0xC6F),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Gs4,4,0x000),
    DN(___,0,0x000),
    DN(Gs4,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Gs4,4,0xC6F),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(As4,4,0x000),
    DN(___,0,0x000),
    DN(As4,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(As4,4,0xC6F),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Fs4,4,0x000),
    DN(___,0,0x000),
    DN(Fs4,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Fs4,4,0xC6F),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
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
    DN(C_5,4,0x000),
    DN(___,0,0x000),
    DN(C_5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(C_5,4,0xC6F),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Ds5,4,0x000),
    DN(___,0,0x000),
    DN(Ds5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Ds5,4,0xC6F),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(F_5,4,0x000),
    DN(___,0,0x000),
    DN(F_5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(F_5,4,0xC6F),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Cs5,4,0x000),
    DN(___,0,0x000),
    DN(Cs5,4,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Cs5,4,0xC6F),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
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
static const unsigned char P4[] = {
    DN(F_5,4,0x000),
    DN(___,0,0x000),
    DN(F_5,4,0x000),
    DN(___,0,0x000),
    DN(F_5,4,0xC7F),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Ds5,4,0x000),
    DN(___,0,0x000),
    DN(Ds5,4,0x000),
    DN(___,0,0x000),
    DN(Ds5,4,0xC7F),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(As5,4,0x000),
    DN(___,0,0x000),
    DN(As5,4,0x000),
    DN(___,0,0x000),
    DN(As5,4,0xC7F),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Gs5,4,0x000),
    DN(___,0,0x000),
    DN(Gs5,4,0x000),
    DN(___,0,0x000),
    DN(Gs5,4,0xC7F),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
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
    DN(C_6,4,0x000),
    DN(___,0,0x000),
    DN(C_6,4,0x000),
    DN(___,0,0x000),
    DN(C_6,4,0xC7F),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(As5,4,0x000),
    DN(___,0,0x000),
    DN(As5,4,0x000),
    DN(___,0,0x000),
    DN(As5,4,0xC7F),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(F_6,4,0x000),
    DN(___,0,0x000),
    DN(F_6,4,0x000),
    DN(___,0,0x000),
    DN(F_6,4,0xC7F),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(Ds6,4,0x000),
    DN(___,0,0x000),
    DN(Ds6,4,0x000),
    DN(___,0,0x000),
    DN(Ds6,4,0xC7F),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0xB09),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
    DN(___,0,0x000),
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

static const unsigned char* const order1[] = {P3,P3,P3,P3,P0,P0,P0,P0,P0,P0,P8,P4};
static const unsigned char* const order2[] = {P1,P1,P1,P1,P1,P1,P1,P1,P6,P7,P9,P10};
static const unsigned char* const order3[] = {P2,P2,P2,P2,P2,P2,P2,P2,P2,P2,P2,P2};
static const unsigned char* const order4[] = {P3,P3,P3,P3,P3,P3,P5,P5,P5,P5,P5,P5};

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
240,113,26,28,227,236,0,0,
240,84,7,24,29,229,0,29,
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
    0,0,0,0,0,0,0,0,0,0,170,170,170,170,170,170,
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
    233,48,56,135,98,33,53,125,36,103,6,19,154,187,133,82,
    218,177,187,107,56,179,56,29,196,150,133,88,212,213,117,182,
    162,96,130,204,57,188,230,221,14,219,212,13,1,165,45,226,
    72,126,154,78,166,96,24,201,99,37,214,112,52,185,150,102,
    185,130,114,97,211,150,163,13,182,231,170,222,132,152,51,139,
};

const hUGESong_t prologuethemept1 = {10, &order_cnt, order1, order2, order3,order4, duty_instruments, wave_instruments, noise_instruments, NULL, waves};