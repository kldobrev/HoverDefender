#include <gb/gb.h>

typedef struct Machine {    // Used for player and enemy sprites

    UBYTE groundflg;
    UINT8 x, y, hboffx, hboffy, width, height, explcount, cyccount;
    INT8 gunoffx, gunoffy, shield, type;
    UINT8 oamtilenums[4];

} Machine;