#include <gb/gb.h>
#include "tiles/roadtiles.c"
#include "tiles/hudtiles.c"
#include "tiles/enemyspritetiles.c"
#include "tiles/cloudtiles.c"
#include "tiles/playerspritetiles.c"
#include "tiles/projectiletiles.c"
#include "tiles/bossspritetiles.c"
#include "maps/cloudmap.c"
#include "maps/hudmap.c"
#include "machine.c"


const UINT8 mechbackwtilesintro[] = {31, 29, 32, 30, 34, 33};
const UINT8 mechforwtilesintro[] = {29, 31, 30, 32, 33, 34};
const INT8 mechprops[] = {0, 50, 1, 1, 14, 22, 16, 16, 9, 29};
const INT8 backhboffintrox = -10, fronthboffintrox = 16;


void init_machine_props(UINT8 x, UINT8 y, const INT8 * mchprops) NONBANKED;
void incr_oam_sprite_tile_idx(INT8 steps) NONBANKED;
void move_machine(Machine * mch, INT8 speedx, INT8 speedy) NONBANKED;
void anim_reverse_blackout() NONBANKED;
void init_mech(UINT8 x, UINT8 y) BANKED;
void init_mechboss() BANKED;
void init_mechbrosboss() BANKED;
void move_mech_intro(Machine * mech, INT8 x, INT8 y) BANKED;
void flip_mech_intro(Machine * mch) BANKED;


extern UINT8 i, oamidx;
extern Machine machines[], * crntenemy, * fsten;


void move_mech_intro(Machine * mech, INT8 x, INT8 y) BANKED {
    move_machine(mech, x, y);
    move_sprite(mech->oamtilenums[3] + 1, mech->x, mech->y + 16);
    move_sprite(mech->oamtilenums[3] + 2, mech->x + 8, mech->y + 16);
}


void flip_mech_intro(Machine * mch) BANKED {
    UINT8 sprdir = get_sprite_prop(mch->oamtilenums[0]) == 32 ? 0 : 32; // Assign opposite sprite direction
    const UINT8 * mechtiles = sprdir == 32 ? mechbackwtilesintro : mechforwtilesintro;
    mch->gunoffx = sprdir == 32 ? backhboffintrox : fronthboffintrox;
    for(i = 0; i < 6; i++) {
        set_sprite_prop(mch->oamtilenums[0] + i, sprdir);
        set_sprite_tile(mch->oamtilenums[0] + i, mch->oamtilenums[0] == 4 ? mechtiles[i] : mechtiles[i] + 19);
    }
}


void init_mech(UINT8 x, UINT8 y) BANKED {
    for(i = 0; i < 6; i++) {    // Resetting sprite properties
        set_sprite_prop((crntenemy - 1)->oamtilenums[0] + i, 0);
    }
    init_machine_props(x, y, mechprops);
    set_sprite_tile(oamidx, mechforwtilesintro[4]);
    move_sprite(oamidx, (crntenemy - 1)->x, (crntenemy - 1)->y + 16);
    set_sprite_tile(oamidx + 1, mechforwtilesintro[5]);
    move_sprite(oamidx + 1, (crntenemy - 1)->x + 8, (crntenemy - 1)->y + 16);
    incr_oam_sprite_tile_idx(2);
}


void init_mechboss() BANKED {
    init_mech(167, 64);
    flip_mech_intro(fsten);
    fsten->shield = 49;

    anim_reverse_blackout();
    do {    // Intro
        move_mech_intro(fsten, -1, 0);
        wait_vbl_done();
    } while(fsten->x != 143);
}


void init_mechbrosboss() BANKED {
    init_mech(249, 64);
    init_mech(167, 64);
    fsten = machines + 1;
    flip_mech_intro(machines + 2);

    anim_reverse_blackout();
    do {    // Intro
        move_mech_intro(fsten, 1, 0);
        move_mech_intro(machines + 2, -1, 0);
        wait_vbl_done();
    } while(fsten->x != 16 && (machines + 2)->x != 144);
}
