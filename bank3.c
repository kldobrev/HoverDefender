#include <gb/gb.h>
#include "machine.c"
#include "placement.c"
#include "tiles/bossspritetiles.c"
#include "tiles/scorpbosstiles.c"
#include "maps/scorpbossmap.c"


extern Machine machines[], * crntenemy, * pl, * hitmchptr;
extern UINT8 pllives, bossclearflg, lockmvmnt, oamidx, i, citr;

const INT8 scorpgunprops[] = {1, 10, 1, 0, 8, 8, -3, 1, 6, 0};
const INT8 stingprops[] = {1, 10, 1, 0, 8, 13, 1, 0, 6, 0};
const UINT8 scorpbossexpl[5][2] = {{98, 112}, {107, 121}, {125, 118}, {134, 112}, {116, 121}};

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
void init_scorpboss_gun(UINT8 x, UINT8 y) BANKED;
void init_scorpboss() BANKED;
void scorpboss_loop() BANKED;
void set_pincer_tiles(Machine * mch, UINT8 animcyc) BANKED;
void set_stinger_tiles(UINT8 animcyc) BANKED;
void scorpboss_hit_anim(UINT8 animcyc) BANKED;
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






// BOSS 1 FUNCTIONS

void init_scorpboss_gun(UINT8 x, UINT8 y) BANKED {
    init_machine_props(x, y, scorpgunprops);
    set_pincer_tiles(crntenemy - 1, 0);
}


void init_scorpboss() BANKED {
    //init_stage(1, 0);
    set_bkg_data(100, 40, scorpbosstiles);
    set_bkg_tiles(11, 10, 9, 6, scorpbossmap);
    set_sprite_data(20, 6, bossspritetiles);

    // Initialize Stinger
    init_machine_props(121, 96, stingprops);
    set_stinger_tiles(0);
    place_machine(crntenemy - 1, 121, 96);

    // Initialize Right gun
    init_scorpboss_gun(100, 105);

    // Initialize Left gun
    init_scorpboss_gun(96, 136);
}



void set_stinger_tiles(UINT8 animcyc) BANKED {
    set_machine_tile(machines + 1, 127);
    set_sprite_tile((machines + 1)->oamtilenums[0], animcyc == 10 ? 23 : 20);
    set_sprite_tile((machines + 1)->oamtilenums[2], animcyc == 10 ? 24 : 21);
}


void set_pincer_tiles(Machine * mch, UINT8 animcyc) BANKED {
    set_machine_tile(mch, 127);
    set_sprite_tile(mch->oamtilenums[0], animcyc == 10 ? 25 : 22);
}


void scorpboss_hit_anim(UINT8 animcyc) BANKED {
    if(hitmchptr == machines + 1) {
        set_stinger_tiles(animcyc);
    } else {
        set_pincer_tiles(hitmchptr, animcyc);
    }
}


void scorpboss_loop() BANKED {
    UINT8 pattrn = 0, firedbull = 0, explidx = 0, gunidx, hitanimtmr = 10;
    while(1) {

        if(pllives == 0 && pl->explcount == 0) {
            break;  // Game over
        }

        if(pl->x + pl->width > 98 && pl->y + pl->height > 95 && pl->explcount == 0 && bossclearflg == 0) {
            take_damage(pl, pl->shield);    // Collision with boss bkg
        }

        if(pattrn == 0) {  // Initial time for the player to adjust before boss attacks
            if(cooldown_enemy(machines + 1, 0)) {
                pattrn = 1;
            }
        }
        
        gunidx = pattrn == 1 ? 2 : 3; // Set gun to be fired depending on pattern num
        if(pattrn == 1 || pattrn == 2) {  // Fire top or bottom gun
            if(is_alive(machines + gunidx) && firedbull != 3) {
                if(cooldown_enemy(machines + gunidx, 20)) {
                    fire_projctl(machines + gunidx, 1, -2, 0);
                    firedbull++;
                }
            } else if(cooldown_enemy(machines + gunidx, 30)) {  // Cooldown until next attack
                firedbull = 0;
                pattrn++;
            }
        } else if(pattrn == 3) {  // Stinger pattern
            if(is_alive(machines + 1)) {
                machines[1].groundflg = pl->groundflg;
                if(machines[1].cyccount == 0) {
                    move_enemy(machines + 1, -2, 2);
                    if(machines[1].y == 114) { // Rewrite
                        machines[1].cyccount++;
                    }
                } else if(machines[1].cyccount == 1) {
                    move_enemy(machines + 1, -4, 0);
                    if(machines[1].x < 16) {
                        machines[1].cyccount++;
                    }
                } else if(machines[1].cyccount == 2) {
                    move_enemy(machines + 1, 2, -2);
                    if(machines[1].y == 96) {
                        machines[1].cyccount++;
                    }
                } else {
                    move_enemy(machines + 1, 4, 0);
                    if(machines[1].x == 121) {
                        machines[1].cyccount = 0;
                        pattrn = 1;  // Reset boss pattern
                    }
                }
            } else {
                pattrn = 1;
            }
        }

        manage_projectiles();
        manage_machines();

        if(hitmchptr != NULL) {
            if(hitanimtmr == 10) {
                scorpboss_hit_anim(hitanimtmr);
            } else if(hitanimtmr == 0) {
                scorpboss_hit_anim(hitanimtmr);
                hitmchptr = NULL;
                hitanimtmr = 11;
            }
            hitanimtmr--;
        }

        if(bossclearflg == 0 && (!(is_alive(machines + 1) || is_alive(machines + 2) || is_alive(machines + 3))) ) {
            bossclearflg = 1;
        }

        if(bossclearflg == 1 && machines[1].explcount == 0 && machines[2].explcount == 0 && machines[3].explcount == 0 ) {
            if(lockmvmnt == 2) {    // Wait until the end of the jumping animation
                anim_jump();
            } else if(pl->explcount == 0) {
                clear_all_projectiles();
                break;  // Boss cleared
            }
        }

        manage_sound_chnls();
        manage_player();
        wait_vbl_done();
    }
}





// BOSS 2 FUNCTIONS


void move_mech(Machine * mech, INT8 x, INT8 y) BANKED {
    move_machine(mech, x, y);
    move_sprite(mech->oamtilenums[3] + 1, mech->x, mech->y + 16);
    move_sprite(mech->oamtilenums[3] + 2, mech->x + 8, mech->y + 16);
}


void init_mechboss() BANKED {
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