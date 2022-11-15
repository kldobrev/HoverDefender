#include <gb/gb.h>
#include "../tiles/deserttiles.c"
#include "../tiles/scorpbosstiles.c"
#include "../maps/desertmap.c"
#include "../maps/scorpbossmap.c"
#include "../Machine.c"
#include "../Placement.c"


extern Machine machines[], * crntenemy, * pl, * hitmchptr;
extern UINT8 pllives, bossclearflg, lockmvmnt, i, citr;
const INT8 scorpgunprops[] = {1, 10, 1, 0, 8, 8, -3, 1, 6, 0};
const INT8 stingprops[] = {1, 10, 1, 0, 8, 13, 1, 0, 6, 0};

// Stage 1 data
const UINT8 stage1road[] = {50, 30, 95, 25, 110, 25, 160, 25, 110, 35, 10, 10, 10, 10, 10, 10, 70};
const Placement stage1objs[] = {{2, 50, 167, 114, 0}
, {4, 20, 167, 98, 0}, {4, 40, 167, 130, 0}, {4, 60, 167, 114, 0}
, {6, 20, 167, 130, 0}, {6, 40, 167, 55, 1}, {6, 60, 167, 98, 0}, {6, 80, 167, 55, 1}, {6, 100, 167, 114, 0}
, {8, 30, 167, 130, 0}, {8, 40, 167, 55, 1}, {8, 50, 167, 98, 0}, {8, 60, 167, 114, 0}, {8, 70, 167, 55, 1}, {8, 80, 167, 114, 0}
, {9, 16, 167, 133, 3} ,{16, 20, 167, 114, 0}, {16, 30, 167, 55, 1}
};
const UINT8 scorpbossexpl[5][2] = {{98, 112}, {107, 121}, {125, 118}, {134, 112}, {116, 121}};


void init_machine_props(UINT8 x, UINT8 y, const INT8 * mchprops) NONBANKED;
void set_machine_tile(Machine * mch, UINT8 tlnum) NONBANKED;
void place_machine(Machine * mch, UINT8 x, UINT8 y) NONBANKED;
inline void itr_enemies_ptr() NONBANKED;
void move_enemy(Machine * en, INT8 speedx, INT8 speedy) NONBANKED;
inline UBYTE is_alive(Machine * mch) NONBANKED;
UBYTE cooldown_enemy(Machine * mch, UINT8 period) NONBANKED;
void fire_projctl(Machine * mch, UINT8 type, INT8 speedx, INT8 speedy) NONBANKED;
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



// STAGE 1 FUNCTIONS

void init_scorpboss_gun(UINT8 x, UINT8 y) BANKED {
    init_machine_props(x, y, scorpgunprops);
    set_pincer_tiles(crntenemy - 1, 0);
}


void init_scorpboss() BANKED {
    init_stage(1, 0);
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
