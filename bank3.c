#include <gb/gb.h>
#include "machine.c"
#include "placement.c"
#include "tiles/bossspritetiles.c"
#include "tiles/scorpbosstiles.c"
#include "maps/scorpbossmap.c"
#include "tiles/juggernautbosstiles.c"
#include "maps/juggernautbossmap1.c"
#include "maps/juggernautbossmap2.c"


extern Machine machines[], * crntenemy, * pl, * hitmchptr;
extern UINT8 pllives, bossclearflg, lockmvmnt, oamidx, i, citr, cloudposx, sceneryposx, roadposx, stagenum, hitanimtmr, ascendflg, plgroundspeed, cyccount;
extern UBYTE iframeflg;
extern const UINT8 enlimit;

const INT8 scorpgunprops[] = {1, 9, 1, 0, 8, 8, -3, 1, 9, 0};
const INT8 stingprops[] = {1, 9, 1, 0, 8, 13, 1, 0, 9, 0};
const UINT8 scorpbossexpl[5][2] = {{98, 112}, {107, 121}, {125, 118}, {134, 112}, {116, 121}};
const UINT8 jggrbossexpl[7][2] = {{39, 14}, {66, 5}, {13, 17}, {80, 0}, {16, 6}, {71, 10}, {85, 13}};
const INT8 mechbossexpl[4][2] = {{-2, -1}, {4, 12}, {-2, 10}, {6, -2}};

const UINT8 mechforwtiles[] = {29, 31, 30, 32, 33, 34};
const UINT8 mechbackwtiles[] = {31, 29, 32, 30, 34, 33};
const UINT8 mechprops[] = {0, 50, 1, 1, 14, 22, 16, 16, 9, 29};
const INT8 jgrgunprops[] = {0, 18, 0, 0, 8, 8, 1, 9, 9, 44};
const INT8 backhboffx = -10, fronthboffx = 16;
UINT8 chargeidx = 255;    // Charge sprite tile index
UINT8 jgrbkgposx = 255, jgrposx;
Machine * fstmch = machines + 1;
const UBYTE bombptrns[3][5] = {{0, 0, 1, 1, 1}, {1, 1, 0, 0, 1}, {1, 0, 0, 1, 1}};  // Bomb drop patterns
const INT8 jgrxoffsets[7] = {-74, -60, -46, -32, -18, 1, 16};    // Hatches and gun offsets



void check_boss_damaged() BANKED;
void init_machine_props(UINT8 x, UINT8 y, const INT8 * mchprops) NONBANKED;
void set_machine_tile(Machine * mch, UINT8 tlnum) NONBANKED;
void place_machine(Machine * mch, UINT8 x, UINT8 y) NONBANKED;
inline void itr_enemies_ptr() NONBANKED;
inline void incr_cycle_counter() NONBANKED;
inline UBYTE is_alive(Machine * mch) NONBANKED;
UBYTE cooldown_enemy(Machine * mch, UINT8 period) NONBANKED;
void fire_projctl(Machine * mch, UINT8 type, INT8 speedx, INT8 speedy) NONBANKED;
void fire_projctl_aimed(Machine * mch, UINT8 type, INT8 speedxy) NONBANKED;
void take_damage(Machine * mch, UINT8 dmgamt) NONBANKED;
void manage_projectiles() NONBANKED;
void manage_machines(UINT8 limit) NONBANKED;
void anim_jump() NONBANKED;
void clear_all_projectiles() NONBANKED;
void manage_sound_chnls() NONBANKED;
void manage_player() NONBANKED;
void init_stage(UBYTE hasscenery, UBYTE hasscroll) NONBANKED;
void init_scorpboss_gun(UINT8 x, UINT8 y) BANKED;
void init_scorpboss() BANKED;
void scorpboss_loop() BANKED;
void set_pincer_tiles(Machine * mch) BANKED;
void set_stinger_tiles() BANKED;
void scorpboss_hit_anim() BANKED;
void flip_mech(Machine * mch) BANKED;
void init_mechboss(UINT8 x, UINT8 y) BANKED;
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
void mech_hit_anim() BANKED;
void incr_boss_bkg_x_coords(UINT8 roadsp, UINT8 jgrspeed) NONBANKED;
void move_jggr_in_distance(UINT8 posx) BANKED;
void scroll_boss_bkg() NONBANKED;
void init_jggrrboss() BANKED;
void jggrboss_hit_anim() BANKED;
void open_hatch(UINT8 hatchnum) BANKED;
void jggrr_open_hatch_above_player() BANKED;
void exec_bombing_ptrn(UINT8 ptrnnum) BANKED;
void disable_boss_bkg_scroll() BANKED;
void jggrrboss_loop() BANKED;
void init_mechbrosboss() BANKED;
UINT8 explode_mech(Machine * mch, Machine ** prevexpl, UINT8 explleft) BANKED;
void mechbrosboss_loop() BANKED;
Machine * create_explosion(UINT8 x, UINT8 y) NONBANKED;
void destroy_mech(Machine * mech) BANKED;






// COMMON BOSS FUNCTIONS

void check_boss_damaged() BANKED {
    if(hitmchptr != NULL) {
        if(hitanimtmr == 10 || hitanimtmr == 0) {
            switch(stagenum) {
                case 0:
                    scorpboss_hit_anim();
                    break;
                case 1:
                    mech_hit_anim();
                    break;
                case 2:
                    jggrboss_hit_anim();
                    break;
                case 3:
                    mech_hit_anim();
                    break;
            }
        }
        if(hitanimtmr == 0) {
            hitmchptr = NULL;
            hitanimtmr = 11;
        }
        hitanimtmr--;
    }
}



// BOSS 1 FUNCTIONS

void init_scorpboss_gun(UINT8 x, UINT8 y) BANKED {
    init_machine_props(x, y, scorpgunprops);
    set_pincer_tiles(crntenemy - 1);
}



void init_scorpboss() BANKED {
    //init_stage(1, 0);
    set_bkg_data(100, 40, scorpbosstiles);
    set_bkg_tiles(11, 10, 9, 6, scorpbossmap);

    // Initialize Stinger
    init_machine_props(121, 96, stingprops);
    set_stinger_tiles();
    place_machine(crntenemy - 1, 121, 96);

    // Initialize Right gun
    init_scorpboss_gun(100, 105);

    // Initialize Left gun
    init_scorpboss_gun(96, 136);
    fstmch = machines + 1;
}



void set_stinger_tiles() BANKED {
    set_machine_tile(fstmch, 0);
    set_sprite_tile(fstmch->oamtilenums[0], hitanimtmr == 10 ? 26 : 23);
    set_sprite_tile(fstmch->oamtilenums[2], hitanimtmr == 10 ? 27 : 24);
}



void set_pincer_tiles(Machine * mch) BANKED {
    set_machine_tile(mch, 0);
    set_sprite_tile(mch->oamtilenums[0], hitanimtmr == 10 ? 28 : 25);
}



void scorpboss_hit_anim() BANKED {
    if(hitmchptr == fstmch) {
        set_stinger_tiles();
    } else {
        set_pincer_tiles(hitmchptr);
    }
}



void scorpboss_loop() BANKED {
    UINT8 pattrn = 0, firedbull = 0, gunidx;
    while(1) {

        if(pllives == 0 && pl->explcount == 0) {
            break;  // Game over
        }

        if(pl->x + pl->width > 98 && pl->y + pl->height > 95 && pl->explcount == 0 && bossclearflg == 0) {
            if(iframeflg) {
                move_machine(pl, -plgroundspeed, 0);
            } else {
                take_damage(pl, pl->shield);    // Collision with boss bkg
            }
        }

        if(pattrn == 0) {  // Initial time for the player to adjust before boss attacks
            if(cooldown_enemy(fstmch, 0)) {
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
            if(is_alive(fstmch)) {
                fstmch->groundflg = pl->groundflg;
                if(fstmch->cyccount == 0) {
                    move_machine(fstmch, -2, 2);
                    if(fstmch->y == 114) { // Rewrite
                        fstmch->cyccount++;
                    }
                } else if(fstmch->cyccount == 1) {
                    move_machine(fstmch, -4, 0);
                    if(fstmch->x < 16) {
                        fstmch->cyccount++;
                    }
                } else if(fstmch->cyccount == 2) {
                    move_machine(fstmch, 2, -2);
                    if(fstmch->y == 96) {
                        fstmch->cyccount++;
                    }
                } else {
                    move_machine(fstmch, 4, 0);
                    if(fstmch->x == 121) {
                        fstmch->cyccount = 0;
                        pattrn = 1;  // Reset boss pattern
                    }
                }
            } else {
                pattrn = 1;
            }
        }

        incr_cycle_counter();
        manage_projectiles();
        manage_machines(3);
        check_boss_damaged();

        if(bossclearflg == 0 && (!(is_alive(fstmch) || is_alive(machines + 2) || is_alive(machines + 3))) ) {
            bossclearflg = 1;
        }

        if(bossclearflg == 1 && fstmch->explcount == 0 && machines[2].explcount == 0 && machines[3].explcount == 0 ) {
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



void init_mechboss(UINT8 x, UINT8 y) BANKED {
    fstmch = machines + 1;
    for(i = 0; i < 6; i++) {    // Resetting sprite properties
        set_sprite_prop((crntenemy - 1)->oamtilenums[0] + i, 0);
    }
    init_machine_props(x, y, mechprops);
    set_sprite_tile(oamidx, mechforwtiles[4]);
    move_sprite(oamidx, (crntenemy - 1)->x, (crntenemy - 1)->y + 16);
    set_sprite_tile(oamidx + 1, mechforwtiles[5]);
    move_sprite(oamidx + 1, (crntenemy - 1)->x + 8, (crntenemy - 1)->y + 16);
    incr_oam_sprite_tile_idx(2);
}



void flip_mech(Machine * mch) BANKED {
    UINT8 sprdir = get_sprite_prop(mch->oamtilenums[0]) == 32 ? 0 : 32; // Assign opposite sprite direction
    const UINT8 * mechtiles = sprdir == 32 ? mechbackwtiles : mechforwtiles;
    mch->gunoffx = sprdir == 32 ? backhboffx : fronthboffx;
    for(i = 0; i < 6; i++) {
        set_sprite_prop(mch->oamtilenums[0] + i, sprdir);
        set_sprite_tile(mch->oamtilenums[0] + i, mch->oamtilenums[0] == 4 ? mechtiles[i] : mechtiles[i] + 19);
    }
}



void charge_gun(Machine * mch, UINT8 phase) BANKED {
    if(phase == 0) {
        chargeidx = oamidx;
        set_sprite_tile(oamidx, 41 + phase);
        set_sprite_prop(oamidx, get_sprite_prop(mch->oamtilenums[0]));
        move_sprite(oamidx, mch->x + mch->gunoffx, mch->y + mch->gunoffy);
        se_charge_gun(0);
        incr_oam_sprite_tile_idx(1);
    } else if(phase < 3) {
        set_sprite_tile(chargeidx, 41 + phase);
        se_charge_gun(phase * 100);
    } else {
        set_sprite_tile(chargeidx, 0);
        set_sprite_prop(chargeidx, 0);
        move_sprite(chargeidx, 0, 0);
    }
}



void mech_hit_anim() BANKED {
    UINT8 sprdir = get_sprite_prop(hitmchptr->oamtilenums[0]);
    const UINT8 * mechtiles = sprdir == 32 ? mechbackwtiles : mechforwtiles;
    for(i = 0; i < 6; i++) {
        set_sprite_tile(hitmchptr->oamtilenums[0] + i, hitanimtmr == 10 ? mechtiles[i] + 6 : (hitmchptr->oamtilenums[0] == 4 ? mechtiles[i] : mechtiles[i] + 19));
    }
}



void mechboss_loop() BANKED {
    flip_mech(fstmch);
    do {    // Intro
        move_mech(fstmch, -1, 0);
        wait_vbl_done();
    } while(fstmch->x != 143);

    UINT8 ptrn = 0, mechdir = 1;  // mechdir: 0 - left, 1 - right
    INT8 mechspx = 0, mechspy = 0;
    while(1) {

        if((!is_alive(pl)) && pl->explcount == 0) {
            break;  // Game over
        }

        if(fstmch->shield < 36 && is_alive(pl)) { // Boss HP = 15 regular hits
            if(lockmvmnt == 2) {    // Wait until the end of the jumping animation
                anim_jump();
            } else if(pl->explcount == 0) {
                bossclearflg = 1;
                hitanimtmr = 0;
                check_boss_damaged();   // Making sure mech sprite is reset to normal before ending sequence
                clear_all_projectiles();
                return;  // Boss cleared
            }
        }

        build_boss_road();
        incr_bkg_x_coords(4);
        incr_cycle_counter();

        if(fstmch->x == 143 && fstmch->y == 64) {
            if(ptrn == 0) {
                charge_gun(fstmch, 0);
                ptrn = 1;
            }
            if(ptrn == 1 && cooldown_enemy(fstmch, 20)) {
                charge_gun(fstmch, 1);
                ptrn = 2;
            } else if(ptrn == 2 && cooldown_enemy(fstmch, 20)) {
                charge_gun(fstmch, 2);
                ptrn = 3;
            } else if(ptrn == 3 && cooldown_enemy(fstmch, 20)) {
                charge_gun(fstmch, 3);
                if(pl->x < 120) {
                    fire_projctl_aimed(fstmch, 4, 4);
                } else {
                    fire_projctl_aimed(fstmch, 4, 3);
                }
                ptrn = 4;
            } else if(ptrn == 4 && cooldown_enemy(fstmch, 50)) {
                mechspy = -3;
                mechdir = 0;
                ptrn = 0;
            }
        } else if(fstmch->x == 143 && fstmch->y == 46) {
            mechspx = mechdir == 0 ? -3 : 0;
            mechspy = mechdir == 0 ? -1 : 3;
            if(fstmch->gunoffx == fronthboffx) {
                flip_mech(fstmch);
            } 
        } else if(fstmch->x == 80 && fstmch->y == 25) {
            ptrn = ptrn == 0 ? 1 : ptrn;
            if(ptrn == 1 && cooldown_enemy(fstmch, 25)) {
                if((pl->x > fstmch->x && fstmch->gunoffx == backhboffx) || (pl->x < fstmch->x && fstmch->gunoffx == fronthboffx)) {
                    flip_mech(fstmch);  // Face towards the player
                }
                fire_projctl_aimed(fstmch, 1, 1);
                ptrn = 2;
            } else if(ptrn == 2 && cooldown_enemy(fstmch, 25)) {
                mechspx = mechdir == 0 ? -3 : 3;
                mechspy = 1;
                ptrn = 0;
            }
        } else if(fstmch->x == 17 && fstmch->y == 46) {
            mechspx = mechdir == 0 ? 0 : 3;
            mechspy = mechdir == 0 ? 3 : -1;
            if(fstmch->gunoffx == backhboffx) {
                flip_mech(fstmch);
            } 
        } else if(fstmch->x == 17 && fstmch->y == 64) {
            ptrn = ptrn == 0 ? 1 : ptrn;
            if(ptrn == 1 && cooldown_enemy(fstmch, 10)) {
                fire_projctl(fstmch, 1, 2, 0);
                ptrn = 2;
            } else if(ptrn == 2 && cooldown_enemy(fstmch, 10)) {
                fire_projctl(fstmch, 1, 2, 1);
                ptrn = 3;
            } else if(ptrn == 3 && cooldown_enemy(fstmch, 10)) {
                fire_projctl(fstmch, 1, 1, 2);
                ptrn = 4;
            } else if(ptrn == 4 && cooldown_enemy(fstmch, 10)) {
                fire_projctl(fstmch, 1, 0, 2);
                ptrn = 5;
            } else if(ptrn == 5 && cooldown_enemy(fstmch, 20)) {
                mechspy = -3;
                mechdir = 1;
                ptrn = 0;
            }
        }
        if(ptrn == 0) {
            move_mech(fstmch, mechspx, mechspy);
        }

        
        manage_projectiles();
        manage_machines(1);
        check_boss_damaged();
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
    
        move_mech(fstmch, 1, 0);
        if(fstmch->x > 168) {
            break;  // Boss has left the screen
        }

        manage_machines(1);
        manage_sound_chnls();
        wait_vbl_done();
    }
}


// BOSS 3 FUNCTIONS


void move_jggr_in_distance(UINT8 posx) BANKED {
    move_sprite(4, posx, 40);
    move_sprite(5, posx + 8, 40);
}



void init_jggrrboss() BANKED {
    fstmch = machines + 1;
    jgrposx = 170;
    jgrbkgposx = 0;
    fill_bkg_rect(0, 1, 32, 4, 0);
    set_bkg_data(116, 68, juggernautbosstiles);
    set_sprite_tile(4, 46);
    set_sprite_tile(5, 47);
    incr_oam_sprite_tile_idx(2);
    move_jggr_in_distance(248);

    init_machine_props(255, 56, jgrgunprops);
    set_machine_tile(fstmch, 0);
}



void jggrboss_hit_anim() BANKED {
    set_sprite_tile(hitmchptr->oamtilenums[0], hitanimtmr == 10 ? 45 : 44);
}



void open_hatch(UINT8 hatchnum) BANKED {
    fstmch->gunoffx = jgrxoffsets[hatchnum];
    fire_projctl(fstmch, 3, 0, 2);
}



void jggrr_open_hatch_above_player() BANKED {
    if(citr != 7 && pl->x < fstmch->x + jgrxoffsets[citr] && 
    pl->x + 8 > fstmch->x + jgrxoffsets[citr]) {
        if(citr == 5) { // Do this inside a function
            fstmch->gunoffx = jgrgunprops[6];
            fstmch->gunoffy = jgrgunprops[7];
            fire_projctl(fstmch, 4, 0, 2);
        } else {
            fstmch->gunoffy = 4;
            open_hatch(citr);
        }
        citr++;
    }
}



void exec_bombing_ptrn(UINT8 ptrnnum) BANKED {
    for(citr = 0; citr < 5; citr++) {
        if(bombptrns[ptrnnum][citr] == 1) {
            open_hatch(citr);
        }
    }
}



void disable_boss_bkg_scroll() BANKED {
    __critical {
        cloudposx = sceneryposx = roadposx = jgrbkgposx = 0;
        scroll_boss_bkg();
        remove_LCD(scroll_boss_bkg);
        disable_interrupts();
    }
}



void jggrrboss_loop() BANKED {
    UINT8 jgrspeed = 1, pattrn = 0, attkcnt = 0;
    INT8 bombatkdir = 1; // Direction in which the bombing patterns will be executed(0 - 2 || 2 - 0)
    while(1) {

        build_boss_road();
        incr_boss_bkg_x_coords(4, jgrspeed);
        incr_cycle_counter();

        if((!is_alive(pl)) && pl->explcount == 0) {
            break;  // Game over
        }

        if(fstmch->shield < 1) {
            jgrspeed = 0;
            if(lockmvmnt == 2) {    // Wait until the end of the jumping animation
                anim_jump();
            } else if(pl->explcount == 0 && fstmch->explcount == 0) {
                bossclearflg = 1;
                clear_all_projectiles();
                return;  // Boss cleared
            }
        }

        jgrposx -= jgrspeed;
        move_machine(fstmch, -jgrspeed, 0);

        if(pattrn == 0) {  // Moving
            jgrspeed = 1;
            if(attkcnt == 127 && jgrposx < 168) {  // Pattern 1 has been executed on last cycle
                jggrr_open_hatch_above_player();
            }
            if(jgrposx == 168) {
                set_bkg_tiles(20, 1, 8, 5, juggernautbossmap1);
                set_sprite_tile(fstmch->oamtilenums[0], 44);
                citr = 0;
            } else if(jgrposx == 104) {
                set_bkg_tiles(28, 1, 9, 5, juggernautbossmap2);
            }  else if(jgrposx == 16) {
                pattrn = attkcnt == 127 ? 2 : 1;
                if(pattrn == 1) {
                    attkcnt = bombatkdir == 1 ? 1 : 4;
                }
            }
        } else if(pattrn == 1) {
            jgrspeed = 0;
            if(cooldown_enemy(fstmch, 40)) {
                if(pl->x + pl->width > fstmch->x) {  // Change bombing pattern based on player location
                    fstmch->gunoffx = jgrgunprops[6];
                    fstmch->gunoffy = jgrgunprops[7];
                    if(pl->x == 140 && pl->y == 127) {
                        fire_projctl(fstmch, 4, 4, 5);   // Edge case
                    } else {
                        fire_projctl_aimed(fstmch, 4, 5);
                    }
                    fstmch->gunoffx = jgrxoffsets[6];
                    fstmch->gunoffy = 4;
                    fire_projctl(fstmch, 3, 0, 2);
                } else {
                    fstmch->gunoffy = 4;
                    exec_bombing_ptrn(attkcnt - 1);
                }
                attkcnt += bombatkdir;
            }
            if(bombatkdir == 1 && attkcnt == 4) {   // Change attack direction for next bombing
                bombatkdir = -1;
                pattrn = 2;
            } else if(bombatkdir == -1 && attkcnt == 0) {
                bombatkdir = 1;
                pattrn = 2;
            }
        } else if(pattrn == 2) {
            if(jgrspeed == 1 && jgrposx == 16) {
                attkcnt = 127;  // Used as bombing flag
            } else {
                jgrspeed = 1;
            }
            if(attkcnt == 127 && jgrposx + 136 > 16) {  // Pattern 1 has been executed on last cycle
                jggrr_open_hatch_above_player();
            }
            if(jgrposx == 199) {
                fill_bkg_rect(20, 1, 8, 5, 0);
            }
            if(jgrposx == 127) {
                fill_bkg_rect(28, 1, 9, 5, 0);
                set_sprite_tile(fstmch->oamtilenums[0], 127);
                move_machine(fstmch, 0, -36);
                pattrn = 3;
            }
        } else if(pattrn == 3) {      // Flying backwards in the distance
            if(shadow_OAM[5].x < 176) {
                move_jggr_in_distance(shadow_OAM[4].x + 3);
            } else if(jgrposx == 180) {
                move_jggr_in_distance(248);
                move_machine(fstmch, 0, 36);
                attkcnt = attkcnt == 127 ? 0 : 127;   // Pattern for next bombing
                pattrn = 0;
            }
        }

        if(pattrn != 3 && pl->x < ((UINT8)(jgrposx + 136)) && 
        (pl->x + pl->width > jgrposx || pattrn == 2) && pl->y < 60 && pl->explcount == 0 && bossclearflg == 0) {
            if(iframeflg) {
                ascendflg = 0;
            } else {
                take_damage(pl, pl->shield);    // Collision with boss bkg
            }
        }

        manage_projectiles();
        manage_machines(1);
        check_boss_damaged();
        manage_sound_chnls();
        manage_player();
        wait_vbl_done();
    }
}



// BOSS 4 FUNCTIONS


void init_mechbrosboss() BANKED {
    init_mechboss(249, 64);
    init_mechboss(167, 64);
    fstmch = machines + 1;
    flip_mech(machines + 2);
}



void destroy_mech(Machine * mech) BANKED {
    for(citr = mech->oamtilenums[0]; citr != mech->oamtilenums[0] + 6; citr++) {
        move_sprite(citr, 0, 0);
        set_sprite_prop(citr, 0);
    }
    mech->explcount = mech->cyccount = mech->x = mech->y = mech->shield = 0;
}



UINT8 explode_mech(Machine * mch, Machine ** prevexpl, UINT8 explleft) BANKED {
    if((*prevexpl)->explcount == 0) {   // Previous explosion animation has finished
        if(explleft == 0) { // Destroy mech
            destroy_mech(mch);
            return 255;
        }
        *prevexpl = create_explosion(mch->x + mechbossexpl[explleft - 1][0], mch->y + mechbossexpl[explleft - 1][1]);
        return explleft - 1;
    }
    return explleft;
}



void move_active_mech(Machine * mech, INT8 x, INT8 y) BANKED {
    if(mech->shield > 35) {
        move_mech(mech, x, y);
    }
}



UINT8 fire_charged_aimed_shot(Machine * mech, UINT8 initnum, UINT8 crntpatnum) BANKED {
    if(crntpatnum != (initnum + 4) && cooldown_enemy(mech, 10)) {
        charge_gun(mech, crntpatnum - initnum);
        return crntpatnum + 1;
    } else if(crntpatnum == (initnum + 4)) {
        fire_projctl_aimed(mech, 4, 4);
        return crntpatnum + 1;
    }
    return crntpatnum;
}



void stop_charging() BANKED {
    if(shadow_OAM[chargeidx].y != 0) {
        move_sprite(chargeidx, 0, 0);
    }
}



UINT8 exec_limited_pattern(UINT8 crntptrn) BANKED {
    if(crntptrn > 39 && crntptrn < 45) {
        return fire_charged_aimed_shot(fstmch, 40, crntptrn);
    } else if(crntptrn == 45) {    // Start of patterns for 1 mech standing
        move_active_mech(fstmch, 4, -4);
        if(fstmch->x == 56 && fstmch->y == 24) {
            return 46;
        }
    } else if(crntptrn == 46) {
        move_active_mech(fstmch, 4, 0);
        if(fstmch->x == 84) {
            flip_mech(fstmch);
            return 47;
        }
    } else if(crntptrn == 47 && cooldown_enemy(fstmch, 10)) {
        fire_projctl(fstmch, 1, -2, 3);
        return 48;
    } else if(crntptrn == 48 && cooldown_enemy(fstmch, 10)) {
        fire_projctl(fstmch, 1, -1, 3);
        flip_mech(fstmch);
        return 49;
    } else if(crntptrn == 49 && cooldown_enemy(fstmch, 10)) {
        fire_projctl(fstmch, 1, 1, 3);
        return 50;
    } else if(crntptrn == 50 && cooldown_enemy(fstmch, 10)) {
        fire_projctl(fstmch, 1, 2, 3);
        flip_mech(fstmch);
        return 51;
    } else if(crntptrn == 51) {
        move_active_mech(fstmch, 4, 0);
        if(fstmch->x == 104) {
            return 52;
        }
    } else if(crntptrn == 52) {
        move_active_mech(fstmch, 4, 4);
        if(fstmch->x == 144 && fstmch->y == 64) {
            return 53;
        }
    } else if(crntptrn > 52 && crntptrn < 58) {
        return fire_charged_aimed_shot(fstmch, 53, crntptrn);
    } else if(crntptrn == 58) {
        move_active_mech(fstmch, -4, -4);
        if(fstmch->x == 104 && fstmch->y == 24) {
            return 59;
        }
    } else if(crntptrn == 59) {
        move_active_mech(fstmch, -4, 0);
        if(fstmch->x == 84) {
            flip_mech(fstmch);
            return 60;
        }
    } else if(crntptrn == 60 && cooldown_enemy(fstmch, 10)) {
        fire_projctl(fstmch, 1, 2, 3);
        flip_mech(fstmch);
        return 61;
    } else if(crntptrn == 61 && cooldown_enemy(fstmch, 10)) {
        fire_projctl(fstmch, 1, 0, 3);
        return 62;
    } else if(crntptrn == 62 && cooldown_enemy(fstmch, 10)) {
        fire_projctl(fstmch, 1, -2, 3);
        return 63;
    } else if(crntptrn == 63) {
        move_active_mech(fstmch, -4, 0);
        if(fstmch->x == 56) {
            flip_mech(fstmch);
            return 64;
        }
    } else if(crntptrn == 64) {
        move_active_mech(fstmch, -4, 4);
        if(fstmch->x == 16 && fstmch->y == 64) {
            return 40;
        }
    }
    return crntptrn;
}



UINT8 exec_mechbros_pattern(Machine * mech1, Machine * mech2, UINT8 ptrnnum) BANKED {
    if(ptrnnum == 0) {
        move_active_mech(mech1, 4, -4);
        if(mech1->x == 56 && mech1->y == 24) {
            return 1;
        }
    } else if(ptrnnum == 1 && cooldown_enemy(mech1, 10)) {
        flip_mech(mech1);
        fire_projctl(mech1, 1, -1, 3);
        return 2;
    } else if(ptrnnum == 2 && cooldown_enemy(mech1, 10)) {
        flip_mech(mech1);
        fire_projctl(mech1, 1, 0, 3);
        return 3;
    } else if(ptrnnum == 3 && cooldown_enemy(mech1, 10)) {
        fire_projctl(mech1, 1, 3, 2);
        return 4;
    } else if(ptrnnum == 4 && cooldown_enemy(mech1, 30)) {
        return 6;
    } else if(ptrnnum == 6 && cooldown_enemy(mech2, 10)) {
        fire_projctl(mech2, 1, -2, 1);
        return 7;
    } else if(ptrnnum == 7 && cooldown_enemy(mech2, 10)) {
        fire_projctl(mech2, 1, -1, 1);
        return 8;
    } else if(ptrnnum == 8 && cooldown_enemy(mech2, 10)) {
        fire_projctl(mech2, 1, 0, 1);
        return 9;
    } else if(ptrnnum == 9 && cooldown_enemy(mech2, 40)) {
        return 10;
    } else if(ptrnnum == 10) {
        move_active_mech(mech1, 4, 0);
        if(mech1->x == 84) {
            flip_mech(mech1);
        }
        if(mech2->y != 32) {
            move_active_mech(mech2, 0, -4);
        }
        if(mech1->x == 104) {
            return 11;
        }
    } else if(ptrnnum == 11) {
        move_active_mech(mech1, 4, 4);
        if(mech1->x == 144 && mech1->y == 64) {
            return 12;
        }
        if(mech2->x != 136 && mech2->y != 24) {
            move_active_mech(mech2, -4, -4);
        }
    } else if(ptrnnum == 12) {
        move_active_mech(mech2, -4, 0);
        if(mech2->x == 84) {
            return 13;
        }
    } else if(ptrnnum == 13 && cooldown_enemy(mech2, 10)) {
        fire_projctl(mech2, 1, -2, 3);
        return 14;
    } else if(ptrnnum == 14 && cooldown_enemy(mech2, 10)) {
        fire_projctl(mech2, 1, -1, 3);
        flip_mech(mech2);
        return 15;
    } else if(ptrnnum == 15 && cooldown_enemy(mech2, 10)) {
        fire_projctl(mech2, 1, 0, 3);
        return 16;
    } else if(ptrnnum == 16 && cooldown_enemy(mech2, 10)) {
        fire_projctl(mech2, 1, 2, 3);
        return 17;
    } else if(ptrnnum == 17 && cooldown_enemy(mech2, 50)) {
        return 18;
    } else if(ptrnnum == 18) {
        move_active_mech(mech2, -4, 0);
        if(mech2->x == 56) {
            return 19;
        }
    } else if(ptrnnum == 19) {
        move_active_mech(mech2, -4, 4);
        if(mech2->x == 16 && mech2->y == 64) {
            return 20;
        }
    } else if(ptrnnum > 19 && ptrnnum < 25) {
        return fire_charged_aimed_shot(mech1, 20, ptrnnum);
    } else if(ptrnnum > 24 && ptrnnum < 30) {
        return fire_charged_aimed_shot(mech2, 25, ptrnnum);
    } else if(ptrnnum == 30 && cooldown_enemy(mech2, 20)) {
        return 0;
    }
    return ptrnnum;
}



void readjust_position(Machine * mech) BANKED {
    if(mech->y != 24) {
        move_mech(mech, 0, -2);
    }
    if(mech->x != 84) {
        move_mech(mech, mech->x < 84 ? 2 : -2, 0);
    }
} 


void mechbrosboss_loop() BANKED {
    Machine * sndmch  = machines + 2;
    UINT8 fstexplcnt = 4, sndexplcnt = 4;
    UINT8 pattrn = 0, swappattrns = 0;
    
    do {    // Intro
        move_mech(fstmch, 1, 0);
        move_mech(sndmch, -1, 0);
        wait_vbl_done();
    } while(fstmch->x != 16 && sndmch->x != 144);

    Machine * fstprevexpl = fstmch, * sndprevexpl = sndmch;

    while(1) {

        build_boss_road();
        incr_bkg_x_coords(4);
        incr_cycle_counter();

        if((!is_alive(pl)) && pl->explcount == 0) {
            break;  // Game over
        }

        if(fstexplcnt == 255 || sndexplcnt == 255) {    // At least 1 mech is destroyed
            if(pattrn == 35) {
                if(fstmch->shield < 36) {
                    fstmch = sndmch;    // Mech 1 has been destroyed
                }
                fstmch->cyccount = 0;   // Resetting cycle if mech is stuck in  a cooldown period
                pattrn = 63;  // Switching patterns for 1 active mech
            }

            
            if(fstmch->shield < 36) {
                if(lockmvmnt == 2) {    // Wait until the end of the jumping animation
                    anim_jump();
                } else if(pl->explcount == 0) {
                    stop_charging();
                    bossclearflg = 1;
                    hitanimtmr = 0;
                    check_boss_damaged();   // Making sure mech sprite is reset to normal before ending sequence
                    hitmchptr = fstmch; // Used to refer to the correct mech during explosion
                    clear_all_projectiles();
                    return;
                }
            }
        }

        if(fstmch->shield < 36 && fstexplcnt != 255) {    // Explode mech 1
            fstexplcnt = explode_mech(fstmch, &fstprevexpl, fstexplcnt);
            if(fstprevexpl->explcount == 1 && fstexplcnt == 3 && sndexplcnt != 255) {
                stop_charging();
                if(get_sprite_prop(sndmch->oamtilenums[0]) == 0) {
                    flip_mech(sndmch);
                }
                pattrn = 35;
            }
            if(pattrn == 35) {
                readjust_position(sndmch);
            }
        }

        if(sndmch->shield < 36 && sndexplcnt != 255) {    // Explode mech 2
            sndexplcnt = explode_mech(sndmch, &sndprevexpl, sndexplcnt);
            if(sndprevexpl->explcount == 1 && sndexplcnt == 3 && fstexplcnt != 255) {
                stop_charging();
                if(get_sprite_prop(fstmch->oamtilenums[0]) == 0) {
                    flip_mech(fstmch);
                }
                pattrn = 35;
            }
            if(pattrn == 35) {
                readjust_position(fstmch);
            }
        }

        if(sndmch->x == 16) {
            swappattrns = 1;
        } else if(fstmch->x == 16) {
            swappattrns = 0;
        }

        if(pattrn < 35) {   // Patterns for both mechs active
            if(swappattrns == 0) {
                pattrn = exec_mechbros_pattern(fstmch, sndmch, pattrn);
            } else {
                pattrn = exec_mechbros_pattern(sndmch, fstmch, pattrn);
            }
        } else {
            pattrn = exec_limited_pattern(pattrn);
        }
        

        manage_projectiles();
        manage_machines(enlimit);
        check_boss_damaged();
        manage_sound_chnls();
        manage_player();
        wait_vbl_done();
    }
}

