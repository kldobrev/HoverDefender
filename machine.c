#include <gb/gb.h>

typedef struct Machine {

    UINT8 x, y, hboffx, hboffy, width, height, explcnt;
    INT8 gunoffx, gunoffy, shield;
    UINT8 oamtilenums[4];

} Machine;