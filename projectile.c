#include <gb/gb.h>

typedef struct Projectile {
    UINT8 speedx, speedy, height, width, damage;
    OAM_item_t * oam;
} Projectile;
