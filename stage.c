#include <gb/gb.h>
#include "placement.c"
#include "hUGEDriver.h"

typedef struct Stage {
    UINT8 * roadlayout;
    UINT8 roadlength;
    Placement * enlayout;
    unsigned char * bkgtiles;
    UINT8 bkgtilesnum;
    unsigned char * bkgmap;
    UBYTE hasclouds;
    UINT8 stagebank;
    hUGESong_t * theme;
    UINT8 themebank;
} Stage;