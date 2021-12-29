#include <gb/gb.h>

typedef struct Placement { // Used to place assets inside levels during level construction
    UINT8 arridx; // Road or hole index
    UINT8 elemidx;  // Area inside road or hole where the item should be placed
    UINT8 x, y; // Screen coordinates of placed item
    UINT8 type; // Type of asset to be placed(ramp, enemy, powerup etc.)
} Placement;