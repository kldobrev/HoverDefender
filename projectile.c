#include <gb/gb.h>

typedef struct Projectile {
    UINT8 speedx, speedy, height, width, damage;
    INT16 slope, gradient;
    OAM_item_t * oam;
} Projectile;