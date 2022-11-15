#include <gb/gb.h>
#include "../tiles/citytiles.c"
#include "../maps/citymap.c"


extern Machine machines[], * crntenemy, * pl, * hitmchptr;
extern UINT8 pllives, bossclearflg, lockmvmnt, oamidx, i;


// Stage 2 data
const UINT8 stage2road[] = {70, 30, 110, 10, 20, 10, 120, 10, 10, 10, 10, 20, 50, 10, 120, 40, 130, 10, 10, 10, 10, 10, 10, 10, 160};
const Placement stage2objs[] = {{0, 40, 167, 114, 0}, {1, 15, 167, 133, 3}, 
{2, 10, 167, 60, 1}, {2, 20, 167, 96, 0}, {2, 40, 167, 133, 0}, {2, 50, 167, 30, 4}, {2, 65, 167, 114, 0},
{4, 5, 167, 30, 1},  {6, 10, 167, 133, 0}, {6, 18, 167, 30, 4}, {6, 35, 167, 96, 0}, {6, 45, 167, 50, 4}, {6, 60, 167, 114, 0}, {6, 80, 167, 40, 4},
{11, 9, 167, 133, 3}, {12, 15, 167, 133, 5}, {14, 20, 167, 96, 0}, {14, 55, 167, 133, 5}, {14, 60, 167, 96, 0}, {14, 95, 167, 133, 5},
{15, 9, 167, 133, 3}, {15, 32, 167, 133, 3}, {16, 9, 167, 96, 5}, {16, 14, 167, 60, 1}, {16, 15, 167, 114, 0}, {16, 50, 167, 96, 5}, {16, 55, 167, 60, 1}, {16, 80, 167, 133, 0},
{22, 1, 167, 50, 1}, {24, 10, 167, 30, 4}, {24, 20, 167, 96, 0}, {24, 35, 167, 50, 1}, {24, 55, 167, 133, 0}, {24, 65, 167, 40, 4}, 
{24, 80, 167, 50, 1}, {24, 95, 167, 114, 0}, {24, 110, 167, 30, 4}, {24, 120, 167, 50, 1}};

const UINT8 mechforwtiles[] = {28, 30, 29, 31, 32, 33};
const UINT8 mechbackwtiles[] = {30, 28, 31, 29, 33, 32};
const UINT8 mechprops[] = {0, 20, 1, 1, 14, 22, 16, 16, 6, 28};
const INT8 backhboffx = -10, fronthboffx = 16;
UINT8 chargeidx = 255;    // Charge sprite tile index
Machine * mech = machines + 1;


void init_machine_props(UINT8 x, UINT8 y, const INT8 * mchprops) NONBANKED;
void set_machine_tile(Machine * mch, UINT8 tlnum) NONBANKED;
void place_machine(Machine * mch, UINT8 x, UINT8 y) NONBANKED;
inline void itr_enemies_ptr() NONBANKED;
void move_enemy(Machine * en, INT8 speedx, INT8 speedy) NONBANKED;
inline UBYTE is_alive(Machine * mch) NONBANKED;
UBYTE cooldown_enemy(Machine * mch, UINT8 period) NONBANKED;
void fire_projctl(Machine * mch, UINT8 type, INT8 speedx, INT8 speedy) NONBANKED;
void fire_projctl_aimed_vert(Machine * mch, UINT8 type, INT8 speedy) NONBANKED;
void fire_projctl_aimed_horz(Machine * mch, UINT8 type, INT8 speedx) NONBANKED;
void take_damage(Machine * mch, UINT8 dmgamt) NONBANKED;
void manage_projectiles() NONBANKED;
void manage_machines() NONBANKED;
void anim_jump() NONBANKED;
void clear_all_projectiles() NONBANKED;
void manage_sound_chnls() NONBANKED;
void manage_player() NONBANKED;
void init_stage(UBYTE hasscenery, UBYTE hasscroll) NONBANKED;
void flip_mech(Machine * mch) BANKED;
void init_mechboss() BANKED;
void mechboss_loop() BANKED;
void move_mech(Machine * mech, INT8 x, INT8 y) BANKED;
void incr_oam_sprite_tile_idx(INT8 steps) NONBANKED;
void move_machine(Machine * mch, INT8 speedx, INT8 speedy) NONBANKED;
void incr_bkg_x_coords(UINT8 roadsp) NONBANKED;
void build_boss_road() NONBANKED;
void charge_gun(Machine * mch, UINT8 phase) BANKED;
void se_charge_gun(UINT8 addfreq) NONBANKED;
void mech_clear_sequence() BANKED;
void se_explode() NONBANKED;
void mech_hit_anim(Machine * mch, UINT8 animcyc) BANKED;



void move_mech(Machine * mech, INT8 x, INT8 y) BANKED {
    move_machine(mech, x, y);
    move_sprite(mech->oamtilenums[3] + 1, mech->x, mech->y + 16);
    move_sprite(mech->oamtilenums[3] + 2, mech->x + 8, mech->y + 16);
}


void init_mechboss() BANKED {
    init_stage(1, 1);
    set_sprite_data(22, 21, bossspritetiles);
    for(i = 0; i < 6; i++) {    // Resetting sprite properties
        set_sprite_prop((crntenemy - 1)->oamtilenums[0] + i, 0);
    }
    init_machine_props(167, 64, mechprops);
    set_sprite_tile(oamidx, mechforwtiles[4]);
    move_sprite(oamidx, (crntenemy - 1)->x, (crntenemy - 1)->y + 16);
    set_sprite_tile(oamidx + 1, mechforwtiles[5]);
    move_sprite(oamidx + 1, (crntenemy - 1)->x + 8, (crntenemy - 1)->y + 16);
    incr_oam_sprite_tile_idx(2);
    flip_mech(crntenemy - 1);
}



void flip_mech(Machine * mch) BANKED {
    UINT8 sprdir = get_sprite_prop(mch->oamtilenums[0]) == 32 ? 0 : 32; // Assign opposite sprite direction
    const UINT8 * mechtiles = sprdir == 32 ? mechbackwtiles : mechforwtiles;
    (machines + 1)->gunoffx = sprdir == 32 ? backhboffx : fronthboffx;
    for(i = 0; i < 6; i++) {
        set_sprite_prop(mch->oamtilenums[0] + i, sprdir);
        set_sprite_tile(mch->oamtilenums[0] + i, mechtiles[i]);
    }
}



void charge_gun(Machine * mch, UINT8 phase) BANKED {
    if(phase == 0) {
        chargeidx = oamidx;
        set_sprite_tile(oamidx, 40 + phase);
        set_sprite_prop(oamidx, 32);
        move_sprite(oamidx, mch->x - 6, mch->y + 15);
        se_charge_gun(0);
        incr_oam_sprite_tile_idx(1);
    } else if(phase < 3) {
        set_sprite_tile(chargeidx, 40 + phase);
        se_charge_gun(phase * 100);
    } else {
        set_sprite_tile(chargeidx, 0);
        set_sprite_prop(chargeidx, 0);
        move_sprite(chargeidx, 0, 0);
    }
}


void mech_hit_anim(Machine * mch, UINT8 animcyc) BANKED {
    UINT8 sprdir = get_sprite_prop(mch->oamtilenums[0]);
    const UINT8 * mechtiles = sprdir == 32 ? mechbackwtiles : mechforwtiles;
    for(i = 0; i < 6; i++) {
        set_sprite_tile(mch->oamtilenums[0] + i, animcyc == 10 ? mechtiles[i] + 6 : mechtiles[i]);
    }
}


void mechboss_loop() BANKED {
    do {    // Intro
        move_mech(mech, -1, 0);
        wait_vbl_done();
    } while(mech->x != 143);

    UINT8 ptrn = 0, mechdir = 1;  // mechdir: 0 - left, 1 - right
    INT8 mechspx = 0, mechspy = 0, hitanimtmr = 10;
    while(1) {

        if((!is_alive(pl)) && pl->explcount == 0) {
            break;  // Game over
        }

        if(mech->shield < 6 && is_alive(pl)) { // Boss HP = 15 regular hits
            if(lockmvmnt == 2) {    // Wait until the end of the jumping animation
                anim_jump();
            } else if(pl->explcount == 0) {
                bossclearflg = 1;
                clear_all_projectiles();
                return;  // Boss cleared
            }
        }

        build_boss_road();
        incr_bkg_x_coords(4);

        if(mech->x == 143 && mech->y == 64) {
            if(ptrn == 0) {
                charge_gun(mech, 0);
                ptrn = 1;
            }
            if(ptrn == 1 && cooldown_enemy(mech, 20)) {
                charge_gun(mech, 1);
                ptrn = 2;
            } else if(ptrn == 2 && cooldown_enemy(mech, 20)) {
                charge_gun(mech, 2);
                ptrn = 3;
            } else if(ptrn == 3 && cooldown_enemy(mech, 20)) {
                charge_gun(mech, 3);
                if(pl->x < 120) {
                    fire_projctl_aimed_horz(mech, 4, -4);
                } else {
                    fire_projctl_aimed_vert(mech, 4, 3);
                }
                ptrn = 4;
            } else if(ptrn == 4 && cooldown_enemy(mech, 50)) {
                mechspy = -3;
                mechdir = 0;
                ptrn = 0;
            }
        } else if(mech->x == 143 && mech->y == 46) {
            mechspx = mechdir == 0 ? -3 : 0;
            mechspy = mechdir == 0 ? -1 : 3;
            if(mech->gunoffx == fronthboffx) {
                flip_mech(mech);
            } 
        } else if(mech->x == 80 && mech->y == 25) {
            ptrn = ptrn == 0 ? 1 : ptrn;
            if(ptrn == 1 && cooldown_enemy(mech, 25)) {
                if((pl->x > mech->x && mech->gunoffx == backhboffx) || (pl->x < mech->x && mech->gunoffx == fronthboffx)) {
                    flip_mech(mech);  // Face towards the player
                }
                fire_projctl_aimed_vert(mech, 1, 1);
                ptrn = 2;
            } else if(ptrn == 2 && cooldown_enemy(mech, 25)) {
                mechspx = mechdir == 0 ? -3 : 3;
                mechspy = 1;
                ptrn = 0;
            }
        } else if(mech->x == 17 && mech->y == 46) {
            mechspx = mechdir == 0 ? 0 : 3;
            mechspy = mechdir == 0 ? 3 : -1;
            if(mech->gunoffx == backhboffx) {
                flip_mech(mech);
            } 
        } else if(mech->x == 17 && mech->y == 64) {
            ptrn = ptrn == 0 ? 1 : ptrn;
            if(ptrn == 1 && cooldown_enemy(mech, 10)) {
                fire_projctl(mech, 1, 2, 0);
                ptrn = 2;
            } else if(ptrn == 2 && cooldown_enemy(mech, 10)) {
                fire_projctl(mech, 1, 2, 1);
                ptrn = 3;
            } else if(ptrn == 3 && cooldown_enemy(mech, 10)) {
                fire_projctl(mech, 1, 1, 2);
                ptrn = 4;
            } else if(ptrn == 4 && cooldown_enemy(mech, 10)) {
                fire_projctl(mech, 1, 0, 2);
                ptrn = 5;
            } else if(ptrn == 5 && cooldown_enemy(mech, 20)) {
                mechspy = -3;
                mechdir = 1;
                ptrn = 0;
            }
        }
        if(ptrn == 0) {
            move_mech(mech, mechspx, mechspy);
        }

        if(hitmchptr != NULL) {
            if(hitanimtmr == 10) {
                mech_hit_anim(mech, hitanimtmr);
            } else if(hitanimtmr == 0) {
                mech_hit_anim(mech, hitanimtmr);
                hitmchptr = NULL;
                hitanimtmr = 11;
            }
            hitanimtmr--;
        }


        manage_projectiles();
        manage_machines();
        manage_sound_chnls();
        manage_player();
        wait_vbl_done();
    }
}



void mech_clear_sequence() BANKED {
    set_sprite_tile(chargeidx, 0);
    while(1) {
        
        build_boss_road();
        incr_bkg_x_coords(4);
    
        move_mech(mech, 1, 0);
        if(mech->x > 168) {
            break;  // Boss has left the screen
        }

        manage_machines();
        manage_sound_chnls();
        wait_vbl_done();
    }
}
