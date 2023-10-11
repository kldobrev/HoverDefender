#include <gb/gb.h>
#include "machine.c"
#include "tiles/encoretiles1.c"
#include "tiles/encoretiles2.c"
#include "tiles/finalbossspritetiles.c"
#include "maps/encorebossbkgmap.c"
#include "maps/encorebossmap.c"
#include "maps/encorebossnobarriermap.c"
#include "maps/encorepremap.c"



extern Machine machines[], * crntenemy, * pl, * hitmchptr, * fsten, * machptr;
extern UINT8 pllives, bossclearflg, lockmvmnt, oamidx, i, citr, cloudposx, sceneryposx, roadposx, stagenum, hitanimtmr, ascendflg, plgroundspeed, cyccount;
extern UBYTE iframeflg;
extern const UINT8 enlimit;
extern const unsigned char goodroadmap[];

const INT8 encoreemitterprops[] = {0, 10, -3, 0, 20, 9, 0, 0, 9, 23};
const INT8 encoreprops[] = {0, 120, -5, -20, 40, 50, -64, -35, 9, 25};  // HP = 30
const INT8 arcptrnshotspeeds[8][2] = {{-3, 1}, {-3, 2}, {-2, 3}, {-1, 3}, {0, 3}, {1, 3}, {3, 3}, {4, 3}};
const UINT8 emittersexpl[5][2] = {{132, 56}, {154, 120} ,{132, 120}, {154, 56}, {66, 38}};
const INT8 ultgenprops[] = {0, 40, 0, 0, 16, 32, 18, 16, 9, 0};
const INT8 ultgentileposs[7][8][2] = {
{{0, 0}, {0, 8}, {8, 0}, {8, 8}, {0, 16}, {0, 24}, {8, 16}, {8, 24}},   // Normal/charged facing right
{{8, 0}, {8, 8}, {0, 0}, {0, 8}, {8, 16}, {8, 24}, {0, 16}, {0, 24}},   // Normal/charged facing left
{{0, 0}, {0, 8}, {8, 0}, {8, 8}, {16, 8}, {24, 8}, {16, 16}, {24, 16}},   // Diagonal facing right
{{0, 0}, {8, 0}, {16, 0}, {24, 0}, {0, 8}, {8, 8}, {16, 8}, {24, 8}},   // Horizontal facing right
{{24, 0}, {24, 8}, {16, 0}, {16, 8}, {8, 8}, {0, 8}, {8, 16}, {0, 16}},   // Diagonal facing left
{{24, 0}, {16, 0}, {8, 0}, {0, 0}, {24, 8}, {16, 8}, {8, 8}, {0, 8}},   // Horizontal facing left
{{0, 8}, {0, 16}, {8, 8}, {8, 16}, {16, 16}, {16, 0}, {16, 8}, {8, 0}}    // Defeated facing left
};
const INT8 pattrn10shots[8][2] = {{1, 3}, {0, 3}, {-1, 4}, {-4, 3}, {-4, 2}, {-4, 1}, {-4, -1}, {-4, -2}};
const INT8 sparkcoordsair[][2] = {{2, 8}, {-4, 18}, {4, 2}};
const INT8 sparkcoordsground[][2] = {{2, 8}, {-4, 18}, {4, 2}, {4, 2}};
const UINT8 ultgenexplcrdsair[][2] = {{8, 8}, {0, 17}, {4, 0}, {0, 8}};
const UINT8 ultgenexplcrdsground[][2] = {{1, 10}, {19, 1}, {5, 7}, {11, 0}};
const UINT8 ultgenbossexpl[][2] = {{14, 0}, {0, 4}, {9, 2}, {4, 6}, {12, 8}};
const UINT8 endingexplcoords[12][2] = {{19, 35}, {46, 84}, {112, 55}, {32, 26}, {71, 71}, {139, 48}, {103, 30}, {14, 83}, {59, 62}, {81, 47}, {22, 27}, {108, 78}};

INT8 shakedir = 1;  // Used for shaking background during destruction sequences


void update_hit_anim_counter() NONBANKED;
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
void incr_oam_sprite_tile_idx(INT8 steps) NONBANKED;
void move_machine(Machine * mch, INT8 speedx, INT8 speedy) NONBANKED;
void incr_bkg_x_coords(UINT8 roadsp) NONBANKED;
void build_boss_road() NONBANKED;
void se_charge_gun(UINT8 addfreq) NONBANKED;
void incr_boss_bkg_x_coords(UINT8 roadsp, UINT8 jgrspeed) NONBANKED;
void scroll_boss_bkg() NONBANKED;
Machine * create_explosion(UINT8 x, UINT8 y) NONBANKED;
void mute_music_pl_chnl(UINT8 chnum) NONBANKED;
void anim_reverse_blackout() NONBANKED;
void anim_blackout() NONBANKED;
void anim_stage_end() NONBANKED;
void scroll_stage_bkg_ind() NONBANKED;
void anim_explode_boss(const UINT8 explarr[][2], UINT8 numexpl, UINT8 hasscroll, UINT8 offsx, UINT8 offsy) NONBANKED;
void custom_delay(UINT8 cycles) NONBANKED;
void set_machine_sprite_tiles(Machine * mch, UINT8 fsttile) NONBANKED;
void explode_machine(Machine * mch) NONBANKED;
void preserve_boss_shield(Machine * boss) BANKED;
void check_encore_boss_bkg_collision() BANKED;
void play_pre_encore_cutscene() BANKED;
void init_emitters_boss() BANKED;
void emitter_hit_anim() BANKED;
void emitters_boss_loop() BANKED;
void set_ultgen_defeated_tiles() BANKED;
void set_ultgen_tiles(UINT8 state) BANKED;
void turn_ultgen(UINT8 state, UINT8 dir) BANKED;
void move_ultgen(INT8 speedx, INT8 speedy) BANKED;
void place_ultgen(UINT8 x, UINT8 y) BANKED;
void init_ultgen_boss() BANKED;
void final_boss_hit_anim() BANKED;
void turn_gen_towards_player() BANKED;
void set_ultgen_default() BANKED;
void ultgen_boss_loop() BANKED;
void ultgen_spark_overload() BANKED;
void ending_sequence_prep() BANKED;
void ultgen_flash_sparks(INT8 coordsarr[][2], UINT8 arrlen) BANKED;
void manage_explosions() BANKED;
void shake_stage_bkg_ind() BANKED;
void anim_airbase_destr(UBYTE moveplflg) BANKED;
void se_spark() BANKED;
void se_ultgen_hit_ground() BANKED;
void se_ultgen_dash() BANKED;
void se_ultgen_charge(UINT8 addfreq) BANKED;



// COMMON BOSS FUNCTIONS

void preserve_boss_shield(Machine * boss) BANKED {
    if(boss->shield < 10) {
        boss->shield = 100; // Simulate invincibility by resetting health
    }
}


void check_encore_boss_bkg_collision() BANKED {
    if(pl->x + pl->width > 118 && pl->explcount == 0 && bossclearflg == 0) {
        if(iframeflg) {
            move_machine(pl, -plgroundspeed, 0);
        } else {
            take_damage(pl, pl->shield);    // Collision with boss bkg
        }
    }
}


// FINAL BOSS FUNCTIONS

void play_pre_encore_cutscene() BANKED {
    set_bkg_data(73, 64, encoretiles1);
    for(i = 0; i != 32; i += 8) {
        set_bkg_tiles(i, 0, 8, 10, encorepremap);
    }
    HIDE_WIN;
    anim_reverse_blackout();
    anim_stage_end();
    anim_blackout();
    cloudposx = sceneryposx = roadposx = 0;
    scroll_stage_bkg_ind();
    remove_LCD(scroll_stage_bkg_ind);
    move_machine(pl, 80, 0);
}


void init_emitters_boss() BANKED {
    set_bkg_data(73, 64, encoretiles1);
    set_bkg_data(137, 99, encoretiles2);
    set_bkg_tiles(0, 0, 14, 17, encorebossbkgmap);
    set_bkg_tiles(14, 0, 6, 17, encorebossmap);
    set_sprite_data(23, 47, finalbossspritetiles);
    init_machine_props(135, 86, encoreprops);
    init_machine_props(120, 120, encoreemitterprops);
    set_machine_tile(machines + 2, 0);
    set_sprite_tile(8, 23);
    init_machine_props(120, 56, encoreemitterprops);
    set_machine_tile(machines + 3, 0);
    set_sprite_tile(12, 23);
    set_sprite_prop(12, 64);
    set_sprite_tile(16, 23);
    move_sprite(16, 157, 120);
    set_sprite_tile(17, 23);
    move_sprite(17, 157, 56);
    set_sprite_prop(17, 64);
    incr_oam_sprite_tile_idx(2);
    wait_vbl_done();
}


void emitter_hit_anim() BANKED {
    if(hitmchptr != (machines + 1)) {
        set_sprite_tile(hitmchptr->oamtilenums[0], hitanimtmr == 0 ? 23 : 24);
    }
}


void emitters_boss_loop() BANKED {
    UINT8 pattrn = 0, pattrnrep = 0;
    while(1) {

        if((!is_alive(pl)) && pl->explcount == 0) {
            break;  // Game over
        }

        (machines + 1)->groundflg = pl->groundflg;
        if((machines + 2)->shield < 1 && (machines + 3)->shield < 1 && is_alive(pl) && (machines + 1)->explcount == 0) {
            if(lockmvmnt == 2) {    // Wait until the end of the jumping animation
                anim_jump();
            } else if(pl->explcount == 0 && (machines + 2)->explcount == 0 &&(machines + 3)->explcount == 0) {
                hitanimtmr = 0;
                bossclearflg = 1;
                if(hitmchptr != NULL) {
                    emitter_hit_anim();
                    update_hit_anim_counter();
                }
                clear_all_projectiles();
                set_machine_sprite_tiles(pl, 1);
                return;  // Boss cleared
            }
        }

        if(pattrn == 0 && cooldown_enemy(machines + 1, 20)) {
            fire_projctl(machines + 1, 4, arcptrnshotspeeds[pattrnrep][0], arcptrnshotspeeds[pattrnrep][1]);
            pattrnrep++;
            if(pattrnrep == 8) {
                pattrn = 1;
            }
        } else if(pattrn == 1 && cooldown_enemy(machines + 1, 45)) {
            fire_projctl(machines + 1, 4, -1, 3);
            fire_projctl(machines + 1, 4, -3, 3);
            fire_projctl(machines + 1, 4, 0, 3);
            fire_projctl(machines + 1, 4, 3, 3);
            fire_projctl(machines + 1, 4, 4, 3);
            pattrn = 2;
        } else if(pattrn == 2 && cooldown_enemy(machines + 1, 60)) {
            pattrn = 3;
        } else if(pattrn == 3 && cooldown_enemy(machines + 1, 20)) {
            pattrnrep--;
            fire_projctl(machines + 1, 4, arcptrnshotspeeds[pattrnrep][0], arcptrnshotspeeds[pattrnrep][1]);
            if(pattrnrep == 0) {
                pattrn = 4;
            }
        } else if(pattrn == 4 && cooldown_enemy(machines + 1, 45)) {
            fire_projctl(machines + 1, 4, -4, 3);
            fire_projctl(machines + 1, 4, -2, 3);
            fire_projctl(machines + 1, 4, 0, 3);
            fire_projctl(machines + 1, 4, 3, 3);
            fire_projctl(machines + 1, 4, 4, 3);
            pattrn = 5;
        } else if(pattrn == 5 && cooldown_enemy(machines + 1, 60)) {
            pattrn = 0;
        }

        check_encore_boss_bkg_collision();
        incr_cycle_counter();
        preserve_boss_shield(machines + 1);
        manage_projectiles();
        manage_machines(3);
        if(hitmchptr != NULL) {
            emitter_hit_anim();
            update_hit_anim_counter();
        }
        manage_sound_chnls();
        manage_player();
        wait_vbl_done();
    }
}


void set_ultgen_defeated_tiles() BANKED {
    for(i = 0; i != 8; i++) {
        move_sprite(i + 8, fsten->x + ultgentileposs[6][i][0], fsten->y + ultgentileposs[6][i][1]);
        if(i < 5) {
            set_sprite_tile(i + 8, i + 59);
            set_sprite_prop(i + 8, 0);
        } else {
            set_sprite_tile(i + 8, i + 25);
            set_sprite_prop(i + 8, 32);
        }
    }
}


void set_ultgen_tiles(UINT8 state) BANKED {
    if(state != 3) {
        for(i = 0; i != 8; i++) {
            set_sprite_tile(i + 8, i + 30 + (8 * state));
        }
    } else {
        for(i = 0; i != 3; i++) {
            set_sprite_tile(i + 8, i + 54);
            set_sprite_tile(i + 12, i + 54);
            set_sprite_prop(i + 12, 64);    // Vertical flip
        }
        set_sprite_tile(11, 57);
        set_sprite_tile(15, 58);
        set_sprite_prop(15, 64);    // Vertical flip
    }
}


void turn_ultgen(UINT8 state, UINT8 dir) BANKED {   // direction 0 - facing right, 1 - facing left
    for(i = 0; i != 8; i++) {
        if(state == 0 || state == 1) {    // Setting sprite tiles' position
            move_sprite(i + 8, fsten->x + ultgentileposs[dir][i][0], fsten->y + ultgentileposs[dir][i][1]);
            fsten->gunoffx = dir == 1 ? -16 : 24;
        } else {
            move_sprite(i + 8, fsten->x + ultgentileposs[state + (dir << 1)][i][0], fsten->y + ultgentileposs[state + (dir << 1)][i][1]);
        }
        if(state == 3 && (i == 4 || i == 5 || i == 6)) {    // Setting sprite tiles' direction
            set_sprite_prop(i + 8, dir == 0 ? 64 : 96);
        } else {
            set_sprite_prop(i + 8, dir == 0 ? 0 : 32);
        }
    }
}


void move_ultgen(INT8 speedx, INT8 speedy) BANKED {
    fsten->x += speedx;
    fsten->y += speedy;
    for(i = 8; i != 16; i++) {
        scroll_sprite(i, speedx, speedy);
    }
}


void place_ultgen(UINT8 x, UINT8 y) BANKED {
    move_ultgen((INT8) (x - fsten-> x),  (INT8) (y - fsten->y));
}


void init_ultgen_boss() BANKED {
    set_sprite_prop(12, 0);
    set_sprite_prop(17, 0);
    move_sprite(16, 0, 0);
    move_sprite(17, 0, 0);
    set_bkg_tile_xy(8, 3, 235);
    set_bkg_tile_xy(8, 4, 75);
    set_bkg_tiles(14, 6, 6, 7, encorebossnobarriermap);
    oamidx = 8;
    crntenemy = fsten = machines + 2;
    hitanimtmr = 11;
    (machines + 1)->shield =  encoreprops[1];
    init_machine_props(248, 33, ultgenprops);
    set_ultgen_tiles(0);
    turn_ultgen(0, 0);
    incr_oam_sprite_tile_idx(4);
    set_sprite_tile(oamidx, 64);
    move_sprite(oamidx, 170, 1);
    incr_oam_sprite_tile_idx(1);

    custom_delay(20);
    while(fsten->x != 98) { // Move ultgen to x: 98, y: 33
        move_ultgen(1, 0);
        if(fsten->x == 49) {
            turn_ultgen(0, 1);
        }
        wait_vbl_done();
    }
}


void final_boss_hit_anim() BANKED {
    if(hitmchptr == machines + 1) {
        if(hitanimtmr == 0) {
            set_machine_sprite_tiles(machines + 1, encoreprops[9]);
            scroll_sprite(hitmchptr->oamtilenums[0], -2, -2);
            BGP_REG = 0xE4;
        } else if(hitanimtmr == 10) {
            set_machine_tile(machines + 1, 0);
            set_sprite_tile(hitmchptr->oamtilenums[0], 29);
            scroll_sprite(hitmchptr->oamtilenums[0], 2, 2);
            BGP_REG = 0xD8;
        }
    }
}


void turn_gen_towards_player() BANKED {
    if(pl->x > fsten->x && get_sprite_prop(fsten->oamtilenums[0]) == 32) {
        turn_ultgen(0, 0);
    } else if(pl->x <= fsten->x && get_sprite_prop(fsten->oamtilenums[0]) == 0) {
        turn_ultgen(0, 1);
    }
}


void set_ultgen_default() BANKED { // Default props used for multiple phases
    set_ultgen_tiles(0);
    turn_ultgen(0, 1);
    fsten->hboffx = ultgenprops[2];
    fsten->hboffy = ultgenprops[3];
    fsten->width = ultgenprops[4];
    fsten->height = ultgenprops[5];
}


void ultgen_boss_loop() BANKED {
    (machines + 1)->hboffx = (machines + 1)->hboffy = 0;
    (machines + 1)->width = (machines + 1)->height = 12;
    UINT8 pattrn = 0;
    INT8 pattrnrep = 0;
    while(1) {
        if((!is_alive(pl)) && pl->explcount == 0) {
            break;  // Game over
        }

        (machines + 1)->groundflg = fsten->groundflg = pl->groundflg;
        if((machines + 1)->shield < 91) {
            if(get_sprite_tile((machines + 1)->oamtilenums[0]) != 66)  {
                set_machine_sprite_tiles(machines + 1, 66); // Setting broken core sprite
            }
            if(lockmvmnt == 2 & pattrn == 2) {    // Wait until the end of the jumping animation
                anim_jump();
            } else if(pl->explcount == 0 && pattrn == 2) {    // Ending at charge pattern
                bossclearflg = 1;
                clear_all_projectiles();
                set_machine_sprite_tiles(pl, 1);
                ultgen_spark_overload();
                return;  // Boss cleared
            }
        }

        if(pattrn == 0 && cooldown_enemy(fsten, 40)) {
            pattrn = 1;
            pattrnrep = -1;
        } else if(pattrn == 1) {
            move_ultgen(pattrnrep, 0);
            if(fsten->x == 48) {
                fire_projctl_aimed(fsten, 4, 3);
            } else if(fsten->x == 16) {
                fire_projctl_aimed(fsten, 4, 3);
                pattrnrep = 1;
            } else if(fsten->x == 96) {
                fire_projctl_aimed(fsten, 4, 3);
            } else if(fsten->x == 98) {
                pattrn = 2;
                pattrnrep = 0;
            }
            turn_gen_towards_player();
        } else if(pattrn == 2) {    // Charge ultgen with sparks
            if(fsten->cyccount == 0) {
                move_sprite(23, (machines + 1)->x, (machines + 1)->y);
                set_sprite_tile(23, 64);
                fsten->cyccount++;
                se_ultgen_charge(pattrnrep * 100);
            } else if(fsten->cyccount != 27) {
                scroll_sprite(23, -1, -1);
                set_sprite_tile(23, get_sprite_tile(23) == 64 ? 65 : 64);
                fsten->cyccount++;
            } else if(pattrnrep != 2) {
                fsten->cyccount = 0;
                pattrnrep++;
                set_ultgen_tiles(get_sprite_tile(fsten->oamtilenums[0]) == 30 ? 1 : 0);
            } else {
                pattrn = 3;
                pattrnrep = 0;
                fsten->cyccount = 0;
                move_sprite(23, 180, 9);    // Move spark offscreen
            }
        } else if(pattrn == 3) {    // Move ultgen offscreen
            if(pattrnrep == 0) {
                set_ultgen_tiles(1);
                pattrnrep++;
            }
            move_ultgen(0, -1);
            if(fsten->y == 239) {
                pattrn = 4;
                pattrnrep = 0;
            }
        } else if(pattrn == 4 && cooldown_enemy(fsten, 40)) {
            set_ultgen_tiles(2);
            turn_ultgen(2, 1);
            fsten->hboffx = 1;
            fsten->hboffy = 2;
            fsten->width = 30;
            fsten->height = 18;
            place_ultgen(168, 3);
            pattrn = 5;
            se_ultgen_dash();
        } else if(pattrn == 5) {    // Fly ultgen from top right to bottom left
            move_ultgen(-5, 4);
            if(fsten->y == 155) {   // x: 234
                pattrn = 6;
            }
        } else if(pattrn == 6) {
            turn_ultgen(2, 0);
            place_ultgen(174, 3);
            pattrn = 7;
            se_ultgen_dash();
        } else if(pattrn == 7) {    // Fly ultgen from top left to bottom right
            move_ultgen(5, 4);
            if(fsten->y == 163) {
                pattrn = 8;
            }
        } else if(pattrn == 8 && cooldown_enemy(fsten, 40)) {
            set_ultgen_default();
            place_ultgen(108, 239);
            pattrn = 9;
        } else if(pattrn == 9) {
            move_ultgen(0, 1);
            if(fsten->y == 75) {  // x: 108, y: 75
                fsten->gunoffx = -9;
                pattrn = 10;
            }
        } else if(pattrn == 10) {
            if(cooldown_enemy(fsten, 20)) {
                fire_projctl(fsten, 1, pattrn10shots[pattrnrep][0], pattrn10shots[pattrnrep][1]);
                pattrnrep++;
            }
            if(pattrnrep == 8) {
                pattrnrep = 0;
                pattrn = 11;
            }
        } else if(pattrn == 11) {
            move_ultgen(1, 0);
            if(fsten->x == 168) {  // x: 168, y: 75
                set_ultgen_tiles(3);
                turn_ultgen(3, 1);
                place_ultgen(168, 114);
                fsten->width = 32;
                fsten->height = 16;
                pattrn = 12;
                se_ultgen_dash();
            }
        } else if(pattrn == 12) {    // Fly ultgen from right to left, middle lane
            move_ultgen(-5, 0);
            if(fsten->x == 229) {  // x: 229, y: 114
                pattrn = 13;
            }
        } else if(pattrn == 13) {
            move_ultgen(0, -16);  // x: 229, y: 98
            turn_ultgen(3, 0);
            pattrn = 14;
            se_ultgen_dash();
        } else if(pattrn == 14) {    // Fly ultgen from left to right, top lane
            move_ultgen(5, 0);
            if(fsten->x == 168) {  // x: 168, y: 98
                pattrn = 15;
            }
        } else if(pattrn == 15) {
            move_ultgen(0, 32);  // x: 168, y: 130
            turn_ultgen(3, 1);
            pattrn = 16;
            se_ultgen_dash();
        } else if(pattrn == 16) {    // Fly ultgen from right to left, bottom lane
            move_ultgen(-5, 0);
            if(fsten->x == 229) {  // x: 229, y: 130
                place_ultgen(98, 223);
                set_ultgen_default();
                pattrn = 17;
            }
        } else if(pattrn == 17) {
            move_ultgen(0, 1);
            if(fsten->y == 33) {  // x: 98, y: 33
                pattrn = 0;
            }
        }

        check_encore_boss_bkg_collision();
        incr_cycle_counter();
        preserve_boss_shield(fsten);
        manage_projectiles();
        manage_machines(2);
        if(hitmchptr != NULL && (machines + 1)->shield > 90) {
            final_boss_hit_anim();
            update_hit_anim_counter();
        }
        manage_sound_chnls();
        manage_player();
        wait_vbl_done();
    }
}


void ultgen_spark_overload() BANKED {
    set_ultgen_tiles(0);
    move_sprite(23, (machines + 1)->x, (machines + 1)->y);
    set_sprite_tile(23, 64);
    se_ultgen_charge(0);
    for(citr = 0; citr != 121; citr++) {    // Energy overload
        if(citr % 8 == 0) {
            set_ultgen_tiles(get_sprite_tile(fsten->oamtilenums[0]) == 30 ? 1 : 0);
            move_sprite(23, (machines + 1)->x, (machines + 1)->y);
            se_ultgen_charge(citr * 100);
        } else {
            scroll_sprite(23, -4, -4);
            set_sprite_tile(23, get_sprite_tile(23) == 64 ? 65 : 64);
        }
        wait_vbl_done();
    }
    citr = 0;
}


void ending_sequence_prep() BANKED {
    move_sprite(23, 180, 9);    // Move spark offscreen
    ultgen_flash_sparks(sparkcoordsair, 3);
    while(pl->x > 60) {    // Back off player if in the way of the falling ultgen
        move_machine(pl, -1, 0);
        wait_vbl_done();
    }
    anim_explode_boss(ultgenexplcrdsair, 4, 0, fsten->x - 4, fsten->y - 4);

    while(fsten->y < 108) { // Ultgen falls to the ground
        move_ultgen(0, 3);
        wait_vbl_done();
    }
    move_ultgen(fsten->x == 98 ? -8 : -12, 0);
    set_ultgen_defeated_tiles();
    se_ultgen_hit_ground();
    custom_delay(90);
}


void ultgen_flash_sparks(INT8 coordsarr[][2], UINT8 arrlen) BANKED {    // Flash sparks in the positions defined in the array
    for(citr = 0; citr != arrlen; citr++) {
        move_sprite(23, fsten->x + coordsarr[citr][0], fsten->y + coordsarr[citr][1]);
        se_spark();
        for(fsten->cyccount = 0; fsten->cyccount != 65; fsten->cyccount++) {
            if(fsten->cyccount % 8 == 0) {
                set_sprite_tile(23, get_sprite_tile(23) == 65 ? 64 : 65);
            }
            wait_vbl_done();
        }
    }
    move_sprite(23, 180, 9);    // Move spark offscreen
}


void manage_explosions() BANKED {   // Animate active explosions
    for(machptr = machines + 1; machptr < machines + enlimit; machptr++) {    // Player and enemies handling
        if(machptr->explcount != 0) {
            explode_machine(machptr);
        }
    }
 }


void shake_stage_bkg_ind() BANKED {
    if(citr % 4 == 0) {
        scroll_bkg(0, shakedir);
    }
}


void anim_airbase_destr(UBYTE moveplflg) BANKED {  // Animate ground shaking and explosions for final scenes
    UINT8 explidx = 0;
    if(moveplflg) {
        add_LCD(shake_stage_bkg_ind);
        place_machine(pl, 248, 114);
    }
    
    for(citr = 0; citr != 255; citr++) {
        if(moveplflg) {
            build_boss_road();
            incr_bkg_x_coords(5);
            
            if(pl->x > 194 && pl->x < 200) {
                break;
            } else {
                move_machine(pl, 1, 0);
            }
        }

        if(citr % 14 == 0) {     // Bring explosions sprites into view
            create_explosion(endingexplcoords[explidx][0], endingexplcoords[explidx][1]);
            explidx = explidx != 7 ? explidx + 1 : 0;
        }
        
        if(citr % 4 == 0) { // Shake background
            if(!moveplflg) {    // Shake bkg manually when no interrupt functions are running
                scroll_bkg(0, shakedir);
                scroll_sprite(4, 0, -shakedir); // Shaking core sprites individually instead of
                scroll_sprite(5, 0, -shakedir); // using a funtion call like move_machine,
                scroll_sprite(6, 0, -shakedir); // which is not executing fast enough
                scroll_sprite(7, 0, -shakedir); // during all the action on screen.
            }
            shakedir = shakedir == 1 ? -1 : 1;
        }

        manage_explosions();
        manage_sound_chnls();
        wait_vbl_done();
    }

    if(moveplflg) {
        remove_LCD(shake_stage_bkg_ind);
    }
    move_bkg(0, 0);
}


void se_spark() BANKED {
    mute_music_pl_chnl(3);
    NR41_REG = 0x00;
    NR42_REG = 0x86;
    NR43_REG = 0x06;
    NR44_REG = 0xC0;
}


void se_ultgen_hit_ground() BANKED {
    mute_music_pl_chnl(3);
    NR41_REG = 0x3F;
    NR42_REG = 0xF2;
    NR43_REG = 0x5E;
    NR44_REG = 0x80;
}


void se_ultgen_dash() BANKED {
    mute_music_pl_chnl(3);
    NR41_REG = 0x28;
    NR42_REG = 0xF3;
    NR43_REG = 0x27;
    NR44_REG = 0x80;
}


void se_ultgen_charge(UINT8 addfreq) BANKED {
    mute_music_pl_chnl(0);
    NR10_REG = 0x16;
    NR11_REG = 0xFF;
    NR12_REG = 0xC8;
    NR13_REG = 127 + addfreq;
    NR14_REG = 0x84;
}
