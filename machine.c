#include <gb/gb.h>

typedef struct Machine {    // Used for player and enemy sprites

    UBYTE groundflg;
    UINT8 x, y, width, height, explcount, cyccount;
    INT8 hboffx, hboffy, gunoffx, gunoffy, shield, type;
    UINT8 oamtilenums[4];

} Machine;