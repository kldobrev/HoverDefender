#include <gb/gb.h>
#include "placement.c"
#include "hUGEDriver.h"

typedef struct Stage {
    UINT8 * roadlayout;
    UINT8 roadlength;
    Placement * enlayout;
    UINT8 ennum;
    unsigned char * bkgtiles;
    UINT8 bkgtilesnum;
    unsigned char * bkgmap;
    UBYTE hasclouds;
    hUGESong_t * theme;
} Stage;