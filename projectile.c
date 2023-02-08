#include <gb/gb.h>

typedef struct Projectile {
    INT8 speedx, speedy;
    UINT8 height, width, damage, aimedflg;
    OAM_item_t * oam;
} Projectile;