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
extern UINT8 pllives, bossclearflg, lockmvmnt, oamidx, i, citr, cloudposx, sceneryposx, roadposx, stagenum, hitanimtmr, ascendflg, plgroundspeed;
extern UBYTE iframeflg;

const INT8 scorpgunprops[] = {1, 9, 1, 0, 8, 8, -3, 1, 6, 0};
const INT8 stingprops[] = {1, 9, 1, 0, 8, 13, 1, 0, 6, 0};
const UINT8 scorpbossexpl[5][2] = {{98, 112}, {107, 121}, {125, 118}, {134, 112}, {116, 121}};
const UINT8 jggrbossexpl[7][2] = {{54, 38}, {81, 29}, {28, 41}, {100, 20}, {31, 30}, {116, 34}, {94, 37}};

const UINT8 mechforwtiles[] = {28, 30, 29, 31, 32, 33};
const UINT8 mechbackwtiles[] = {30, 28, 31, 29, 33, 32};
const UINT8 mechprops[] = {0, 15, 1, 1, 14, 22, 16, 16, 6, 28};
const INT8 jgrgunprops[] = {0, 18, 0, 0, 8, 8, 1, 9, 6, 43};
const INT8 backhboffx = -10, fronthboffx = 16;
UINT8 chargeidx = 255;    // Charge sprite tile index
UINT8 jgrbkgposx;
Machine * fstmch = machines + 1;
const UBYTE bombptrns[3][5] = {{0, 0, 1, 1, 1}, {1, 1, 0, 0, 1}, {1, 0, 0, 1, 1}};  // Bomb drop patterns
const INT8 jgrxoffsets[7] = {-74, -60, -46, -32, -18, 1, 16};    // Hatches and gun offsets


void check_boss_damaged() BANKED;
void init_machine_props(UINT8 x, UINT8 y, const INT8 * mchprops) NONBANKED;
void set_machine_tile(Machine * mch, UINT8 tlnum) NONBANKED;
void place_machine(Machine * mch, UINT8 x, UINT8 y) NONBANKED;
inline void itr_enemies_ptr() NONBANKED;
inline UBYTE is_alive(Machine * mch) NONBANKED;
UBYTE cooldown_enemy(Machine * mch, UINT8 period) NONBANKED;
void fire_projctl(Machine * mch, UINT8 type, INT8 speedx, INT8 speedy) NONBANKED;
void fire_projctl_aimed_vert(Machine * mch, UINT8 type, INT8 speedy) NONBANKED;
void fire_projctl_aimed_horz(Machine * mch, UINT8 type, INT8 speedx) NONBANKED;
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








// COMMON BOSS FUNCTIONS

void check_boss_damaged() BANKED {
    if(hitmchptr != NULL) {
        if(hitanimtmr == 10 || hitanimtmr == 0) {
            switch(stagenum) {
                case 0:
                    scorpboss_hit_anim();
                    break;
                case 2:
                    jggrboss_hit_anim();
                    break;
                default:    // Case for bosses 2 and 4
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
    set_sprite_data(20, 6, bossspritetiles);

    // Initialize Stinger
    init_machine_props(121, 96, stingprops);
    set_stinger_tiles();
    place_machine(crntenemy - 1, 121, 96);

    // Initialize Right gun
    init_scorpboss_gun(100, 105);

    // Initialize Left gun
    init_scorpboss_gun(96, 136);
}



void set_stinger_tiles() BANKED {
    set_machine_tile(fstmch, 127);
    set_sprite_tile(fstmch->oamtilenums[0], hitanimtmr == 10 ? 23 : 20);
    set_sprite_tile(fstmch->oamtilenums[2], hitanimtmr == 10 ? 24 : 21);
}


void set_pincer_tiles(Machine * mch) BANKED {
    set_machine_tile(mch, 127);
    set_sprite_tile(mch->oamtilenums[0], hitanimtmr == 10 ? 25 : 22);
}


void scorpboss_hit_anim() BANKED {
    if(hitmchptr == fstmch) {
        set_stinger_tiles();
    } else {
        set_pincer_tiles(hitmchptr);
    }
}


void scorpboss_loop() BANKED {
    UINT8 pattrn = 0, firedbull = 0, explidx = 0, gunidx;
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
                machines[1].groundflg = pl->groundflg;
                if(machines[1].cyccount == 0) {
                    move_machine(fstmch, -2, 2);
                    if(machines[1].y == 114) { // Rewrite
                        machines[1].cyccount++;
                    }
                } else if(machines[1].cyccount == 1) {
                    move_machine(fstmch, -4, 0);
                    if(machines[1].x < 16) {
                        machines[1].cyccount++;
                    }
                } else if(machines[1].cyccount == 2) {
                    move_machine(fstmch, 2, -2);
                    if(machines[1].y == 96) {
                        machines[1].cyccount++;
                    }
                } else {
                    move_machine(fstmch, 4, 0);
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
        manage_machines(3);
        check_boss_damaged();

        if(bossclearflg == 0 && (!(is_alive(fstmch) || is_alive(machines + 2) || is_alive(machines + 3))) ) {
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
    fstmch->gunoffx = sprdir == 32 ? backhboffx : fronthboffx;
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


void mech_hit_anim() BANKED {
    UINT8 sprdir = get_sprite_prop(hitmchptr->oamtilenums[0]);
    const UINT8 * mechtiles = sprdir == 32 ? mechbackwtiles : mechforwtiles;
    for(i = 0; i < 6; i++) {
        set_sprite_tile(hitmchptr->oamtilenums[0] + i, hitanimtmr == 10 ? mechtiles[i] + 6 : mechtiles[i]);
    }
}


void mechboss_loop() BANKED {
    do {    // Intro
        move_mech(fstmch, -1, 0);
        wait_vbl_done();
    } while(fstmch->x != 143);

    UINT8 ptrn = 0, mechdir = 1;  // mechdir: 0 - left, 1 - right
    INT8 mechspx = 0, mechspy = 0;
    fstmch->shield = 20;
    while(1) {

        if((!is_alive(pl)) && pl->explcount == 0) {
            break;  // Game over
        }

        if(fstmch->shield < 6 && is_alive(pl)) { // Boss HP = 15 regular hits
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
                    fire_projctl_aimed_horz(fstmch, 4, -4);
                } else {
                    fire_projctl_aimed_vert(fstmch, 4, 3);
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
                fire_projctl_aimed_vert(fstmch, 1, 1);
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

        
        check_boss_damaged();
        manage_projectiles();
        manage_machines(1);
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
    jgrbkgposx = 0;
    set_sprite_data(22, 25, bossspritetiles);
    fill_bkg_rect(0, 1, 32, 4, 0);
    set_bkg_data(116, 68, juggernautbosstiles);
    set_sprite_tile(4, 45);
    set_sprite_tile(5, 46);
    incr_oam_sprite_tile_idx(2);
    move_jggr_in_distance(248);

    init_machine_props(255, 56, jgrgunprops);
    set_machine_tile(fstmch, 127);
}


void jggrboss_hit_anim() BANKED {
    set_sprite_tile(hitmchptr->oamtilenums[0], hitanimtmr == 10 ? 44 : 43);
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
    UINT8 jgrspeed = 1, pattrn = 0;
    UINT8 jgrposx = 170, attkcnt = 0;
    INT8 bombatkdir = 1; // Direction in which the bombing patterns will be executed(0 - 2 || 2 - 0)
    
    while(1) {

        build_boss_road();
        incr_boss_bkg_x_coords(4, jgrspeed);

        if((!is_alive(pl)) && pl->explcount == 0) {
            break;  // Game over
        }

        if(fstmch->shield < 1 && (pattrn == 1 || pattrn == 2)) {
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
                set_sprite_tile(fstmch->oamtilenums[0], 43);
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
                    fire_projctl_aimed_vert(fstmch, 4, 5);
                    fstmch->gunoffx = jgrxoffsets[6];
                    fstmch->gunoffy = 4;
                    fire_projctl(fstmch, 4, 0, 2);
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

        check_boss_damaged();
        manage_projectiles();
        manage_machines(1);
        manage_sound_chnls();
        manage_player();
        wait_vbl_done();
    }
}


