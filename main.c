#include <gb/gb.h>
#include "roadtiles.c"
#include "goodroadmap.c"
#include "holestartmap.c"
#include "holemap.c"
#include "holeendmap.c"
#include "deserttiles.c"
#include "desertmap.c"
#include "cloudtiles.c"
#include "cloudmap.c"
#include "machine.c"
#include "playerspritetiles.c"
#include "projectiletiles.c"
#include "projectile.c"
#include "enemyspritetiles.c"
//#include "placement.c"
#include "misctiles.c"
#include "hudtiles.c"
#include "hudmap.c"
#include "stage.c"
#include "scorpbosstiles.c"
#include "scorpbossmap.c"
#include "bossspritetiles.c"
//#include "hUGEDriver.h"

#include <stdio.h>

extern const hUGESong_t road1;

// Global scope/menus vars
UINT8 progresscnt; // Current menu/level reached tracker

// Commmon level processing vars
UINT8 levelidx; // For the level arrays
UBYTE holeflg;  // Flag indicating if currently rendered area is a hole or a road
UINT8 levelclearflg; // Level completed flag
UINT8 lvlobjscnt; // Level placement objects array counter
const Placement * lvlplacptr; // Level placement objects array pointer
const enum asset {enrider = 0, endrone = 1, enmissile = 2, enturret = 3, enbomber = 4, enmine = 5, enboss = 6};
const UINT8 roadlanesy[] = {98, 114, 130};

// Level data
const UINT8 level1road[] = {50, 30, 95, 25, 110, 25, 160, 25, 110, 35, 10, 10, 10, 10, 10, 10, 70};
//const UINT8 level1roadlen = 17; // 17 total in level 1
const Placement level1objs[] = {{2, 50, 167, 114, enrider}
, {4, 20, 167, 98, enrider}, {4, 40, 167, 130, enrider}, {4, 60, 167, 114, enrider}
, {6, 20, 167, 130, enrider}, {6, 40, 167, 55, endrone}, {6, 60, 167, 98, enrider}, {6, 80, 167, 55, endrone}, {6, 100, 167, 114, enrider}
, {8, 30, 167, 130, enrider}, {8, 40, 167, 55, endrone}, {8, 50, 167, 98, enrider}, {8, 60, 167, 114, enrider}, {8, 70, 167, 55, endrone}, {8, 80, 167, 114, enrider}
, {9, 16, 167, 133, enturret} ,{16, 20, 167, 114, enrider}, {16, 30, 167, 55, endrone}
};
//const UINT8 level1objsnum = 19;

const Stage stages[] = {{level1road, 17, level1objs, 19, deserttiles, 39, desertmap, 1, &road1}};
const Stage * crntstage = stages;    // Current stage pointer



UINT8 roadbuildidx; // index for the level road array
UINT8 camtileidx, nextcamtileidx; // current tile index of the right camera border, index of area where 
// the next part of the level should be drawn
UINT8 i, citr; // iterators for whenever
INT8 sitr;  // signed iterator for whenever
UINT8 roadposx, sceneryposx, cloudposx;
const UINT8 roadscrspeed = 5; // Road scrolling speed
UINT8 plspeed;
const UINT8 jumpspeed = 3;
const UINT8 plgroundspeed = 1;  // Player movement speed
const UINT8 roadboundy = 101; // Vertical bound between road and sky
UINT8 oamidx;
unsigned char checktile[1]; // Tile for performing positional checks
const UINT8 lockedoamtiles = 4; // Number of locked tiles in the OAM (currently reserved for player tiles)
const unsigned char blanktile[] = {0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00};
const UINT8 machinedimswh = 16; // Machine width and height
Projectile projectiles[8]; // Array of all the projectiles
Projectile * crntpjct, * pjctptr; // Pointer to current position in projectile array / Pointer for loops
const UINT8 pjctllimit = 7; // Projectile array index limit(max projectiles on screen allowed - 1)
UINT8 prjcnt;  // Projectile counter, index
const UINT8 screenminx = 8, screenminy = 16; // 0 + horizontal offset / 0 + vertical offset
const UINT8 screenmaxx = 168, screenmaxy = 144; // x0 + screen width / y0 + screen height
UINT8 abtncnt; // Counts cycles after A button press
const UINT8 abtncooldown = 24; // Cycles to wait until A button becomes active
Machine machines[6];
Machine * pl; // Pointer to the player element in the machines array
Machine * crntenemy, * machptr; // Pointer for current enemy in the machines array / machine pointer for loops
UINT8 pllives;
const UINT8 enlimit = 5; // Enemy limit, with player makes for max num of machines
const UINT8 pliframeprd = 120; // Iframe duration
const UINT8 expldur = 32; // Explosion duration
UINT8 lockmvmnt; // 0 - no locking, 1 - horizontal, 2 - vertical, 3 - both
UINT8 iframecnt;
UBYTE iframeflg;
UBYTE fallinholeflg;
UBYTE ascendflg; // Ascending or descending state during jump animation
const UINT8 jumplimity = 50; // Jumping vert distance limit
const UINT8 jumphalflimy = 25;
UINT8 jumpstarty;   // Player y position at start of jump
UINT8 holestartx, holeendx;    // Used to indicate start and end x position of road holes
UBYTE isapressed;  // Indicates that A is currently pressed
const UINT8 mutecycnum = 15;
UINT8 chmutedcyccnt[] = {255, 255, 255, 255}; // Used to mute a sound channel for a number of cycles
UINT8 precfctr; // Precision factor for caluculating coordinates
INT16 slope, gradient;  // Used to calculate projectile trajectory when aimed at player
UINT8 plgun, numkills;
const UINT8 genexplcord[5][2] = {{2, 2}, {3, 5}, {5, 4}, {6, 2}, {4, 5}}; // General position of explosions on boss bkg, based on 8 divisions
UINT8 explcord[5][2]; // Used to calculate exact screen coords for explosions based on boss coords /width / height




UINT8 get_OAM_free_tile_idx();
void custom_delay(UINT8 cycles);
void incr_oam_sprite_tile_idx(INT8 steps);
inline void itr_enemies_ptr();
inline void incr_projectile_counter();
inline void itr_projectile_ptr();
inline UBYTE found_free_projectile_space();
inline UINT8 get_tile_idx(UINT8 newidxnum);
void init_level_bgk();
void init_level_road();
void set_machine_tile(Machine * mch, UINT8 tlnum);
void set_machine_sprite_tiles(Machine * mch, UINT8 fsttile);
void place_machine(Machine * mch, UINT8 x, UINT8 y);
void init_player();
void respawn_player();
void init_comm_en_props(UINT8 x, UINT8 y, UINT8 fsttile);
void init_enemy_rider(UINT8 x, UINT8 y);
void init_enemy_drone(UINT8 x, UINT8 y);
void init_enemy_missile(UINT8 x, UINT8 y);
void init_enemy_turret(UINT8 x, UINT8 y);
void init_enemy_bomber(UINT8 x, UINT8 y);
void init_enemy_mine(UINT8 x, UINT8 y);
void init_scorpboss();
inline UBYTE collides_with_sidewalk(INT8 vspeed);
inline UBYTE is_inside_x_bounds(UINT8 posx);
void move_machine(Machine * mch, INT8 speedx, INT8 speedy);
void move_player(INT8 speedx, INT8 speedy);
void move_enemy(Machine * en, INT8 speedx, INT8 speedy);
void incr_bkg_x_coords(UINT8 roadsp);
void scroll_level_bkg();
void place_level_obj(UINT8 type, UINT8 x, UINT8 y);
void build_level();
void build_road();
void build_hole();
void manage_hole_props();
void manage_projectiles();
void manage_machines();
void manage_sound_chnls();
void manage_player();
inline UINT8 get_horiz_dist(UINT8 fstobjx, UINT8 sndobjx);
void set_projctl_comm_prop(Machine * mch, INT8 speedx, INT8 speedy);
void fire_bullet(Machine * mch, INT8 speedx, INT8 speedy);
void fire_bigbullet(Machine * mch, INT8 speedx, INT8 speedy);
void fire_laser(Machine * mch, INT8 speedx, INT8 speedy);
void drop_bomb(Machine * mch);
inline INT8 get_prjctl_x_aimed(Projectile * prjct);
inline INT8 get_prjctl_y_aimed(Projectile * prjct);
inline UBYTE is_obj_inside_screen(UINT8 x, UINT8 y, UINT8 width, UINT8 height);
inline UBYTE is_alive(Machine * mch);
void destroy_projectile(Projectile * pr);
void move_projectile(Projectile * pr);
void init_explosion(Machine * mch);
void explode_machine(Machine * mch);
void anim_explode_boss(UINT8 x, UINT8 y, UINT8 width, UINT8 height);
void take_damage(Machine * mch, UINT8 dmgamt);
void add_to_player_shield(UINT8 amt);
void check_iframes();
void destroy_machine(Machine * mch);
void check_projectile_collsn(Machine * mch, Projectile * prj);
void check_player_machine_collsn(Machine * mch);
void anim_jump();
void exec_enemy_pattern(Machine * mch);
void exec_rider_pattern(Machine * mch);
void exec_drone_pattern(Machine * mch);
void exec_missile_pattern(Machine * mch);
void exec_turret_pattern(Machine * mch);
void exec_bomber_pattern(Machine * mch);
void exec_mine_pattern(Machine * mch);
UBYTE cooldown_enemy(Machine * mch, UINT8 period);
void hud_init();
void hud_upd_shield(INT8 hpbef, INT8 hpaft);
inline void hud_upd_lives();
void hud_draw_pause();
void hud_clear_pause();
inline void hud_draw_gun();
void init_game();
void init_level(UBYTE hasscenery, UBYTE hasscroll);
void level_loop();
void scorpboss_loop();
void pause_game();
void anim_level_start();
void anim_level_end();
void anim_blackout_loop(UINT8 indictr);
void anim_reverse_blackout_loop(UINT8 indictr);
void anim_blackout();
void anim_reverse_blackout();
void mute_music_pl_chnl(UINT8 chnum);
void upd_mute_chnl_cycles(UINT8 chnum);
void se_fall_in_hole();
void se_fire_bullet();
void se_fire_laser();
void se_drop_bomb();
void se_explode();
void se_get_hit();
void se_jump();
void se_pause();
void se_wpn_upgrd();
void main_menu();
void password_menu();
void play_level();
void play_boss();
void mute_song();
void unmute_song();
void play_song(const hUGESong_t * song);
void stop_song();





UINT8 get_OAM_free_tile_idx() {
    for(UINT8 oami = 4; oami < 40; oami++) {
        if(shadow_OAM[oami].tile == 0) {
            return oami; // First free tile for usage
        }
    }
    return 180; // No free OAM tile space found
}


void custom_delay(UINT8 cycles) {
    for(citr = 0; citr < cycles; citr++) {
        wait_vbl_done();
    }
}


void incr_oam_sprite_tile_idx(INT8 steps) {
    UINT8 nextoamind = oamidx + steps;
    oamidx = nextoamind < 40 ? nextoamind : nextoamind - 40 + lockedoamtiles; // Out of bounds check and reset
    if(shadow_OAM[oamidx].tile != 0) { // If next OAM tile is used, loop to find a free one
        oamidx = get_OAM_free_tile_idx();
    }
}


inline void itr_enemies_ptr() {
    crntenemy = crntenemy == machines + enlimit ? machines + 1 : crntenemy + 1;
}


inline void incr_projectile_counter() {
    prjcnt += prjcnt == pjctllimit + 1 ? 0 : 1;
}


inline void itr_projectile_ptr() {
    crntpjct = crntpjct == projectiles + pjctllimit ? projectiles : crntpjct + 1;
}


inline UBYTE found_free_projectile_space() {   // Checks if there is free space in memory to spawn a projectile
    return prjcnt != pjctllimit + 1 && oamidx != 180;
}


inline UINT8 get_tile_idx(UINT8 newidxnum) {   // Recalculate tile index according to the OAM tile limit
    return newidxnum > 31 ? newidxnum - 32 : newidxnum;
}


void init_level_bgk() {
    if(crntstage->hasclouds) {
        set_bkg_data(20, 13, cloudtiles);
        set_bkg_tiles(0, 0, 32, 1, cloudmap);
        set_bkg_data(33, crntstage->bkgtilesnum, crntstage->bkgtiles);
        set_bkg_tiles(0, 1, 32, 9, crntstage->bkgmap);
    } else {
        set_bkg_data(20, crntstage->bkgtilesnum, crntstage->bkgtiles);
        set_bkg_tiles(0, 0, 32, 10, crntstage->bkgmap);
    }
}



void init_level_road() { // Layount initial road tiles to start the level
    set_bkg_data(72, 28, roadtiles);
    for(roadbuildidx = 0; roadbuildidx < 7; roadbuildidx++) {
        set_bkg_tiles(roadbuildidx * 3, 10, 3, 7, goodroadmap);
    }
    camtileidx = 18;
    nextcamtileidx = camtileidx + 3;
}


void set_machine_tile(Machine * mch, UINT8 tlnum) { // Sets all machine tiles to a specific tile from memory
    set_sprite_tile(mch->oamtilenums[0], tlnum);
    set_sprite_tile(mch->oamtilenums[1], tlnum);
    set_sprite_tile(mch->oamtilenums[2], tlnum);
    set_sprite_tile(mch->oamtilenums[3], tlnum);
}


void set_machine_sprite_tiles(Machine * mch, UINT8 fsttile) {
    set_sprite_tile(mch->oamtilenums[0], fsttile);
    set_sprite_tile(mch->oamtilenums[1], fsttile + 2);
    set_sprite_tile(mch->oamtilenums[2], fsttile + 1);
    set_sprite_tile(mch->oamtilenums[3], fsttile + 3);
}


void place_machine(Machine * mch, UINT8 x, UINT8 y) {
    mch->x = x;
    mch->y = y;
    move_sprite(mch->oamtilenums[0], x, y);
    move_sprite(mch->oamtilenums[1], x + 8, y);
    move_sprite(mch->oamtilenums[2], x, y + 8);
    move_sprite(mch->oamtilenums[3], x + 8, y + 8);
}


void init_player() {
    pl = machines; // First element of the array is the player
    pl->shield = 4;
    pl->groundflg = 1;
    pl->hboffx = 3;
    pl->hboffy = 1;
    pl->width = 13;
    pl->height = 15;
    pl->gunoffx = 17;
    pl->gunoffy = 12;
    pl->explcount = 0;
    pl->cyccount = 0;
    pl->oamtilenums[0] = 0;
    pl->oamtilenums[1] = 1;
    pl->oamtilenums[2] = 2;
    pl->oamtilenums[3] = 3;

    set_machine_sprite_tiles(pl, 1);
    incr_oam_sprite_tile_idx(4);
    place_machine(pl, 248, roadlanesy[1]);
}


void respawn_player() {
    pl->shield = 4;
    pl->hboffx = 3;
    pl->hboffy = 1;
    ascendflg = 1;
    hud_upd_shield(0, 4);
    if(fallinholeflg) {
        fallinholeflg = 0;
        pl->groundflg = 0;
        set_machine_sprite_tiles(pl, 13);
        place_machine(pl, 16, 64);
        lockmvmnt = 2;
        jumpstarty = roadlanesy[1];
    } else {
        pl->groundflg = 1;
        set_machine_sprite_tiles(pl, 1);
        place_machine(pl, 16, roadlanesy[1]);
        lockmvmnt = 0;
    }
    iframeflg = 1;
}


// ENEMIES INITIALIZATION


void init_comm_en_props(UINT8 x, UINT8 y, UINT8 fsttile) {
    crntenemy->explcount = 0;
    crntenemy->cyccount = 0;
    for(i = 0; i < 4; i++) {
        crntenemy->oamtilenums[i] = oamidx;
        incr_oam_sprite_tile_idx(1);
    }
    set_machine_sprite_tiles(crntenemy, fsttile);
    place_machine(crntenemy, x, y);
    itr_enemies_ptr();
}


void init_enemy_rider(UINT8 x, UINT8 y) {
    crntenemy->groundflg = 1;
    crntenemy->shield = 2;
    crntenemy->hboffx = 0;
    crntenemy->hboffy = 1;
    crntenemy->width = 13;
    crntenemy->height = 15;
    crntenemy->gunoffx = -3;    // Avoiding collision with fired bullet
    crntenemy->gunoffy = 12;
    crntenemy->type = enrider;
    init_comm_en_props(x, y, 0x15);
}


void init_enemy_drone(UINT8 x, UINT8 y) {
    crntenemy->groundflg = 0;
    crntenemy->shield = 1;
    crntenemy->hboffx = 2;
    crntenemy->hboffy = 5;
    crntenemy->width = 14;
    crntenemy->height = 7;
    crntenemy->gunoffx = 7;
    crntenemy->gunoffy = 13;
    crntenemy->type = endrone;
    init_comm_en_props(x, y, 0x19);
}


void init_enemy_missile(UINT8 x, UINT8 y) {
    crntenemy->groundflg = y > 90 ? 1 : 0;
    crntenemy->shield = 9;
    crntenemy->hboffx = 2;
    crntenemy->hboffy = 5;
    crntenemy->width = 13;
    crntenemy->height = 10;
    crntenemy->gunoffx = 1;
    crntenemy->gunoffy = 4;
    crntenemy->type = enmissile;
    init_comm_en_props(x, y, 0x1D);
}


void init_enemy_turret(UINT8 x, UINT8 y) {
    crntenemy->groundflg = 0;
    crntenemy->shield = 100;
    crntenemy->hboffx = 3;
    crntenemy->hboffy = 2;
    crntenemy->width = 14;
    crntenemy->height = 12;
    crntenemy->gunoffx = 7;
    crntenemy->gunoffy = -4;
    crntenemy->type = enturret;
    init_comm_en_props(x, y, 0x21);
}


void init_enemy_bomber(UINT8 x, UINT8 y) {
    crntenemy->groundflg = 0;
    crntenemy->shield = 2;
    crntenemy->hboffx = 0;
    crntenemy->hboffy = 5;
    crntenemy->width = 13;
    crntenemy->height = 7;
    crntenemy->gunoffx = 4;
    crntenemy->gunoffy = 11;
    crntenemy->type = enbomber;
    init_comm_en_props(x, y, 0x25);
}


void init_enemy_mine(UINT8 x, UINT8 y) {
    crntenemy->groundflg = 1;
    crntenemy->shield = 20;
    crntenemy->hboffx = 3;
    crntenemy->hboffy = 2;
    crntenemy->width = 11;
    crntenemy->height = 11;
    crntenemy->gunoffx = 0;
    crntenemy->gunoffy = 0;
    crntenemy->type = enmine;
    init_comm_en_props(x, y, 0x29);
}


// BOSSES


void init_scorpboss_gun(UINT8 x, UINT8 y) {
    crntenemy->groundflg = 1;
    crntenemy->shield = 10;
    crntenemy->hboffx = 1;
    crntenemy->hboffy = 0;
    crntenemy->gunoffx = -3;
    crntenemy->gunoffy = 1;
    crntenemy->width = 8;
    crntenemy->height = 8;
    crntenemy->type = enboss;
    for(i = 0; i < 4; i++) {
        crntenemy->oamtilenums[i] = oamidx;
        incr_oam_sprite_tile_idx(1);
    }
    set_machine_tile(crntenemy, 127);   // Last tile is blank => won't be used for bullets accidently
    set_sprite_tile(crntenemy->oamtilenums[0], 22);
    place_machine(crntenemy, x, y);
    itr_enemies_ptr();
}


void init_scorpboss() {
    set_bkg_data(80, 40, scorpbosstiles);
    set_bkg_tiles(11, 10, 9, 6, scorpbossmap);
    set_sprite_data(20, 8, bossspritetiles);

    // Initialize Stinger
    crntenemy->groundflg = 1;
    crntenemy->shield = 10;
    crntenemy->hboffx = 1;
    crntenemy->hboffy = 0;
    crntenemy->width = 8;
    crntenemy->height = 13;
    crntenemy->type = enboss;
    for(i = 0; i < 4; i++) {
        crntenemy->oamtilenums[i] = oamidx;
        incr_oam_sprite_tile_idx(1);
    }
    set_machine_tile(crntenemy, 127);   // Last tile is blank => won't be used for bullets accidently
    set_sprite_tile(crntenemy->oamtilenums[0], 20);
    set_sprite_tile(crntenemy->oamtilenums[2], 21);
    place_machine(crntenemy, 121, 96);
    itr_enemies_ptr();

    // Initialize Right gun
    init_scorpboss_gun(100, 105);

    // Initialize Left gun
    init_scorpboss_gun(96, 136);
}


inline UBYTE collides_with_sidewalk(INT8 vspeed) {
    return pl->y + vspeed < 96 || pl->y + vspeed > 127;
}


inline UBYTE is_inside_x_bounds(UINT8 posx) {
    return posx > 15 && posx < 141;
}


void move_machine(Machine * mch, INT8 speedx, INT8 speedy) {
    mch->x += speedx;
    mch->y += speedy;
    move_sprite(mch->oamtilenums[0], mch->x, mch->y);
    move_sprite(mch->oamtilenums[1], mch->x + 8, mch->y);
    move_sprite(mch->oamtilenums[2], mch->x, mch->y + 8);
    move_sprite(mch->oamtilenums[3], mch->x + 8, mch->y + 8);
}


void move_player(INT8 speedx, INT8 speedy) {
    if((speedx != 0 && is_inside_x_bounds(pl->x + speedx))
    || (speedy != 0 && !collides_with_sidewalk(speedy)) ) {
        move_machine(pl, speedx, speedy);
    }
}


void move_enemy(Machine * en, INT8 speedx, INT8 speedy) {
    move_machine(en, speedx, speedy);
    if(!is_obj_inside_screen(en->x, en->y, 16, 16)) {
        destroy_machine(en);
    }
}


void incr_bkg_x_coords(UINT8 roadsp) {
    cloudposx += roadsp - 3;
    sceneryposx += roadsp - 1;
    roadposx += roadsp;
}


void scroll_level_bkg() {
    switch(LYC_REG) {
        case 0x00:
            move_bkg(cloudposx, 0);
            LYC_REG = 0x08;
            break;
        case 0x08:
            move_bkg(sceneryposx, 0);
            LYC_REG = 0x50;
            break;
        case 0x50:
            move_bkg(roadposx, 0);
            LYC_REG = 0x00;
            break;
    }
}


void place_level_obj(UINT8 type, UINT8 x, UINT8 y) {
    switch(type) {
        case enrider:
            init_enemy_rider(x, y);
            break;
        case endrone:
            init_enemy_drone(x, y);
            break;
        case enmissile:
            init_enemy_missile(x, y);
            break;
        case enturret:
            init_enemy_turret(x, y);
            break;
        case enbomber:
            init_enemy_bomber(x, y);
            break;
        case enmine:
            init_enemy_mine(x, y);
            break;
    }
}


void build_level() {   // Automatically builds the road ahead while scrolling the stage
    camtileidx = get_tile_idx((SCX_REG + 168) / 8);
    if(camtileidx == nextcamtileidx) {
        if(holeflg) {
            build_hole();
        } else {
            build_road();
        }

        //if(roadbuildidx == level1road[levelidx]) {
        if(roadbuildidx == crntstage->roadlayout[levelidx]) {
            levelidx++; // Moving to next elem in level array
            roadbuildidx = 0;
            holeflg = !holeflg; // Roads and holes alternate
        } else {
            roadbuildidx++;
        }

        // Placing objects inside level
        if(lvlobjscnt != crntstage->ennum && lvlplacptr->arridx == levelidx && lvlplacptr->elemidx == roadbuildidx) {
            place_level_obj(lvlplacptr->type, lvlplacptr->x, lvlplacptr->y);
            lvlplacptr++;
            lvlobjscnt++;
        }
    }

    if(levelidx == crntstage->roadlength) { // End of level reached
        levelclearflg = 1;
    }
}


void build_road() {
    set_bkg_tiles(camtileidx, 10, 3, 7, goodroadmap);
    nextcamtileidx = get_tile_idx(camtileidx + 3);
}


void build_hole() {
    if(roadbuildidx == 0) {
        //holestartx = 208;
        holestartx = 238;
        set_bkg_tiles(camtileidx, 10, 4, 7, holestartmap);
        nextcamtileidx = get_tile_idx(camtileidx + 4);
    } else if(roadbuildidx == level1road[levelidx]) {
        //holeendx = 144;
        holeendx = 174;
        holestartx = 255;   // Resetting hole start value
        set_bkg_tiles(camtileidx, 10, 3, 7, holeendmap);
        nextcamtileidx = get_tile_idx(camtileidx + 3);
    } else {
        set_bkg_tiles(camtileidx, 10, 3, 7, holemap);
        nextcamtileidx = get_tile_idx(camtileidx + 3);
    }
 }


void manage_hole_props() {
    if(holestartx != 255 && holestartx > screenminx) { // Road hole has appeared
        holestartx -= roadscrspeed;
    }
    if (holeendx != 0) {  // Road hole end reached
        holeendx -= roadscrspeed;
    } else if(holeendx < screenminx) {
        holeendx = 0;   // Resetting hole end value
    }
 }


 void manage_projectiles() {
    for(pjctptr = projectiles; pjctptr <= projectiles + pjctllimit; pjctptr++) { // Projectiles handling
        if(pjctptr->oam != NULL) {
            move_projectile(pjctptr);
            for(machptr = machines; machptr <= machines + enlimit; machptr++) {
                if(is_alive(machptr)) {
                    if(pl == machptr && (iframeflg || (!pl->groundflg && pjctptr->oam->y > 95))) {
                        continue;   // Avoid hit during iframes or when player jumps and a bullet is above him on the road
                    }
                    check_projectile_collsn(machptr, pjctptr); // Check collision for all machines on screen
                }
            }
        }
    }
 }

 void manage_machines() {
    for(machptr = machines; machptr <= machines + enlimit; machptr++) {    // Player and enemies handling
        if(machptr != pl && machptr->y != 0) {
            if(!iframeflg && pl->explcount == 0 && pl->groundflg == machptr->groundflg) {    // Player hasn't exploded
                check_player_machine_collsn(machptr);
            }
            exec_enemy_pattern(machptr);
        }
        if(machptr->explcount != 0) {
            explode_machine(machptr);
        }
    }
 }


void manage_sound_chnls() {
    for(i = 0; i < 4; i++) {
        if(chmutedcyccnt[i] != 255) {
            upd_mute_chnl_cycles(i);
        }
    }
}


 void manage_player() {
    if(iframeflg) {    // Invincibility period
        check_iframes();
    }

    if(lockmvmnt != 2) {
        if(pl->x + pl->width > holestartx && !fallinholeflg) { // Hole in the road and player is inside
            fallinholeflg = 1;
            lockmvmnt = 3;
            se_fall_in_hole();
        }
    } else {
        anim_jump();
    }

    if(fallinholeflg) {
        move_machine(pl, -1, 2); // Animate fall
        if(pl->y > 144 && pl->explcount == 0) {
            take_damage(pl, pl->shield);
        }
    }

    if(!is_alive(pl) && pllives != 0 && pl->explcount == 0) {
        respawn_player();
    } else if(pllives == 0) {
        anim_blackout_loop(pl->cyccount);  // Game over
        pl->cyccount++;
    }

    if(abtncnt != 0) {
        abtncnt = abtncnt == abtncooldown ? 0 : abtncnt + 1;
    }

    if(lockmvmnt != 1 && lockmvmnt != 3) { // Check horizontal lock
        if(joypad() & J_LEFT) {
            move_player(-plspeed, 0);
        } 
        if(joypad() & J_RIGHT) {
            move_player(plspeed, 0);
        }
    }
    if(lockmvmnt != 2 && lockmvmnt != 3) { // Check vertical lock
        if(joypad() & J_UP) {
            move_player(0, -plspeed);
        }
        if(joypad() & J_DOWN) {
            move_player(0, plspeed);
        }
    }
    if(joypad() & J_B) {
        if(abtncnt == 0) { // Check cooldown period before firing
            switch(plgun) {
                case 0:
                    fire_bullet(pl, 2, 0);
                    break;
                case 1:
                    fire_bigbullet(pl, 2, 0);
                    break;
                case 2:
                    fire_laser(pl, 2, 0);
                    break;
            }
            abtncnt = 1;
        }
    }
    if(joypad() & J_A) { 
        if(lockmvmnt == 0 && !isapressed) {
            lockmvmnt = 2;  // Lock vert movement during jump
            pl->groundflg = 0;
            jumpstarty = pl->y; // Keeping player y position for landing
            set_machine_sprite_tiles(pl, 13);
            se_jump();
        }
        isapressed = 1;
    } else {
        isapressed = 0;
    }
    if(joypad() & J_START) {
        pause_game();
    }
 }


inline UINT8 get_horiz_dist(UINT8 fstobjx, UINT8 sndobjx) { // Returns the distance between 2 objects on x axis
    return fstobjx > sndobjx ? fstobjx - sndobjx : sndobjx - fstobjx;
}


void set_projctl_comm_prop(Machine * mch, INT8 speedx, INT8 speedy) {
    crntpjct->speedx = speedx;
    crntpjct->speedy = speedy;
    crntpjct->oam = (shadow_OAM + oamidx);
    crntpjct->oam->x = mch->x + mch->gunoffx;
    crntpjct->oam->y = mch->y + mch->gunoffy;
    if((mch->type == enturret || mch->type == endrone) && (crntpjct->oam->x < pl->x || crntpjct->oam->x > (pl->x + pl->width))) {
        // Case for enemies that shoot based on player's coordinates
        crntpjct->aimedflg = 1;
        precfctr = pl->x + 46 < mch->x || mch->x + mch->width + 30 < pl->x ? 100 : 10;
        slope = ((crntpjct->oam->y - pl->y) * precfctr) / (crntpjct->oam->x - (pl->x + 8));
        gradient = crntpjct->oam->y - ((slope * crntpjct->oam->x) / precfctr );
    } else {
        crntpjct->aimedflg = 0;
    }
    incr_oam_sprite_tile_idx(1);
    incr_projectile_counter();
    itr_projectile_ptr();
}


void fire_bullet(Machine * mch, INT8 speedx, INT8 speedy) {
    if(found_free_projectile_space()) {  // Set props only if initialization succeeds
        crntpjct->width = 3;
        crntpjct->height = 3;
        crntpjct->damage = 1;
        set_sprite_tile(oamidx, 0x11);
        set_projctl_comm_prop(mch, speedx, speedy);
        se_fire_bullet();
    }
}


void fire_bigbullet(Machine * mch, INT8 speedx, INT8 speedy) {
    if(found_free_projectile_space()) {  // Set props only if initialization succeeds
        crntpjct->width = 4;
        crntpjct->height = 4;
        crntpjct->damage = 2;
        set_sprite_tile(oamidx, 0x12);
        set_projctl_comm_prop(mch, speedx, speedy);
        se_fire_bullet();
    }
}


void fire_laser(Machine * mch, INT8 speedx, INT8 speedy) {
    if(found_free_projectile_space()) {  // Set props only if initialization succeeds
        crntpjct->width = 8;
        crntpjct->height = 3;
        crntpjct->damage = 3;
        set_sprite_tile(oamidx, 0x13);
        set_projctl_comm_prop(mch, speedx, speedy);
        se_fire_laser();
    }
}


void drop_bomb(Machine * mch) {
    if(found_free_projectile_space()) {  // Set props only if initialization succeeds
        crntpjct->width = 8;
        crntpjct->height = 8;
        crntpjct->damage = 4;
        set_sprite_tile(oamidx, 0x14);
        set_projctl_comm_prop(mch, 0, 2);
        se_drop_bomb();
    }
}


inline INT8 get_prjctl_x_aimed(Projectile * prjct) { // Returns projectile's y position based on player's position
    return ((prjct->oam->y - gradient) * precfctr) / slope;
}


inline INT8 get_prjctl_y_aimed(Projectile * prjct) { // Returns projectile's y position based on player's position
    return slope * prjct->oam->x + gradient;
}


inline UBYTE is_obj_inside_screen(UINT8 x, UINT8 y, UINT8 width, UINT8 height) {
    return (x < screenmaxx && screenminx < x + width) &&
    (y < screenmaxy && screenminy < y + height);
}


inline UBYTE is_alive(Machine * mch) {
    return mch->shield > 0;
}


void destroy_projectile(Projectile * pr) {
    pr->oam->x = 0;
    pr->oam->y = 0;
    pr->oam->tile = 0;
    pr->oam = NULL;
    prjcnt--;
}


void init_explosion(Machine * mch) {
    mch->explcount = 1;
    mch->hboffx = -(mch->x + mch->width);   // x + offx + width == 0
    mch->hboffy = -(mch->y + mch->height);   // Avoiding damage dealing to player while exploding
    if(mch->width < 9) {
        move_enemy(mch, -4, 0);
    }
    if(mch->height < 9) {
        move_enemy(mch, 0, -4);
    }
    se_explode();
}


void move_projectile(Projectile * pr) {
    if(pr->oam != NULL && is_obj_inside_screen(pr->oam->x, pr->oam->y, pr->width, pr->height)) {
        pr->oam->y += pr->speedy;
        pr->oam->x = pr->aimedflg == 1 ? get_prjctl_x_aimed(pr) : pr->oam->x + pr->speedx;
    } else {
        destroy_projectile(pr);
    }
}


void explode_machine(Machine * mch) {
    if(mch->explcount % 4 == 0) {
        if(shadow_OAM[mch->oamtilenums[0]].tile != 5) {
            set_machine_sprite_tiles(mch, 5);
        } else {
            set_machine_sprite_tiles(mch, 9);
        }
    }
    mch->explcount++;
    if(mch->explcount == expldur) {
        destroy_machine(mch);
    }
}


void anim_explode_boss(UINT8 x, UINT8 y, UINT8 width, UINT8 height) {
    UINT8 stepx = width / 8; // Horizontal step
    UINT8 stepy = height / 8; // Vertical step
    UINT8 explcyc = 0, fstexpltile = 5;
    for(i = 0; i < 5; i++) {
        explcord[i][0] = x + (genexplcord[i][0] * stepx);
        explcord[i][1] = y + (genexplcord[i][1] * stepy);
        move_sprite(4, explcord[i][0], explcord[i][1]);
        move_sprite(5, explcord[i][0] + 8, explcord[i][1]);
        move_sprite(6, explcord[i][0], explcord[i][1] + 8);
        move_sprite(7, explcord[i][0] + 8, explcord[i][1] + 8);

        se_explode();
        for(explcyc = 0; explcyc < expldur; explcyc++) {
            if(explcyc % 4 == 0) {  // Change explosion tiles every 4 cycles for animation
                    fstexpltile = shadow_OAM[4].tile == 5 ? 9 : 5;  // Alternating between explosion tiles
                    set_sprite_tile(4, fstexpltile);
                    set_sprite_tile(5, fstexpltile + 2);
                    set_sprite_tile(6, fstexpltile + 1);
                    set_sprite_tile(7, fstexpltile + 3);
            }
            wait_vbl_done();
        }
    }
    set_sprite_tile(4, 0);
    set_sprite_tile(5, 0);
    set_sprite_tile(6, 0);
    set_sprite_tile(7, 0);
    init_level_road();
    anim_level_end();
}


void destroy_machine(Machine * mch) {
    set_machine_tile(mch, 0);
    move_sprite(mch->oamtilenums[0], 0, 0);
    move_sprite(mch->oamtilenums[1], 0, 0);
    move_sprite(mch->oamtilenums[2], 0, 0);
    move_sprite(mch->oamtilenums[3], 0, 0);
    mch->explcount = mch->x = mch->y = 0;
}


void take_damage(Machine * mch, UINT8 dmgamt) {
    mch->shield -= dmgamt;
    if(pl == mch) {
        hud_upd_shield(pl->shield + dmgamt, pl->shield);
        if(is_alive(pl)) {
            iframeflg = 1; // Starting iframe period
            if(plgun == 2) {
                plgun = 1;  // Reverting to second gun when less than full health
                hud_draw_gun();
            }
        } else {    // Lost life
            lockmvmnt = 3;
            pllives--;
            plgun = numkills = 0;  // Back to regular gun on death
            hud_upd_lives();
            hud_draw_gun();
        }
    }
    if(!is_alive(mch)) {
        if(mch != pl) {
            numkills++;
            if(numkills == 10 && plgun == 0) {
                plgun = pl->shield == 4 ? 2 : 1; // On 10 kills upgrade gun depending on health
                hud_draw_gun();
                se_wpn_upgrd();
            }
        }
        init_explosion(mch);
    } else {
        se_get_hit();
    }
}


void add_to_player_shield(UINT8 amt) {  // Used for increasing player shield value
    if(pl->shield + amt > 4) {
        hud_upd_shield(pl->shield, 4);
        pl->shield = 4; // Shield max capacity is always 4
    } else {
        hud_upd_shield(pl->shield, pl->shield + amt);
        pl->shield += amt;
    }
}


void check_iframes() {  // Animate blinking during iframe period
    if(iframecnt == pliframeprd) {
        iframecnt = iframeflg = 0;
        move_sprite(0, pl->x, pl->y);
        move_sprite(1, pl->x + 8, pl->y);
        move_sprite(2, pl->x, pl->y + 8);
        move_sprite(3, pl->x + 8, pl->y + 8);
    } else {
        iframecnt++;
        UINT8 newy = shadow_OAM[0].y == 0 ? pl->y : 0;
        move_sprite(0, pl->x, newy);
        move_sprite(1, pl->x + 8, newy);
        move_sprite(2, pl->x, newy + 8);
        move_sprite(3, pl->x + 8, newy + 8);
    }
}


void check_projectile_collsn(Machine * mch, Projectile * prj) {
    if ((mch->x + mch->hboffx < prj->oam->x + prj->width && mch->y + mch->hboffy < prj->oam->y + prj->height) 
    && (prj->oam->x <  mch->x + mch->hboffx + mch->width && prj->oam->y <  mch->y + mch->hboffy + mch->height)) {
        take_damage(mch, prj->damage);
        destroy_projectile(prj);
    }
}


void check_player_machine_collsn(Machine * mch) {
    if ((mch->x + mch->hboffx < pl->x + pl->hboffx + pl->width && mch->y + mch->hboffy < pl->y + pl->hboffy + pl->height) 
    && (pl->x + pl->hboffx <  mch->x + mch->hboffx + mch->width && pl->y + pl->hboffy <  mch->y + mch->hboffy + mch->height)) {
        take_damage(pl, pl->shield);    // Take all health away
        if(mch->type != enboss) {
            init_explosion(mch);
        }
    }
}


void anim_jump() {
    if(ascendflg) {
        if(pl->y > jumpstarty - jumplimity) {    // Ascending
            move_machine(pl, 0, pl->y > jumpstarty - jumphalflimy ? -jumpspeed : -jumpspeed + 1);
        } else {    // Peak of jump
            if(pl->x < holestartx && pl->x > holeendx) {  // Above solid ground
                ascendflg = 0; // Start of descend
            }
        }
    } else {    // Descending
        move_machine(pl, 0, jumpspeed);
        if(pl->y >= jumpstarty) {    // Back on ground / stop jump animmation
            pl->groundflg = 1;
            ascendflg = 1;  // Reverting flag for next jump
            set_machine_sprite_tiles(pl, 1);
            lockmvmnt = 0;  // Allowing free movement
        }
    }
}


// ENEMY AI


void exec_enemy_pattern(Machine * mch) {
    switch(mch->type) {
        case enrider:
            exec_rider_pattern(mch);
            break;
        case endrone:
            exec_drone_pattern(mch);
            break;
        case enmissile:
            exec_missile_pattern(mch);
            break;
        case enturret:
            exec_turret_pattern(mch);
            break;
        case enbomber:
            exec_bomber_pattern(mch);
            break;
        case enmine:
            exec_mine_pattern(mch);
            break;
    }
}


void exec_rider_pattern(Machine * mch) {
    if(mch->x > 130 && lockmvmnt != 2) {
        move_enemy(mch, -1, pl->y > mch->y ? 1 : -1);
    } else if(mch->cyccount != 100) {
        if(mch->cyccount == 50) {
            fire_bullet(mch, -2, 0);
        }
        mch->cyccount++;
    } else {
        move_enemy(mch, -1, 0);
    }
}


void exec_drone_pattern(Machine * mch) {
    if(mch->x % 16 == 0) {
        mch->cyccount = mch->cyccount == 0 ? 1 : 0;
    }
    move_enemy(mch, -1, mch->cyccount == 0 ? 1 : -1);
    if(mch->x == 90 && pl->groundflg == 1) {
        fire_bullet(mch, 0, 1);
    }
}


void exec_missile_pattern(Machine * mch) {
    move_enemy(mch, -2, 0);
}


void exec_turret_pattern(Machine * mch) {
    move_enemy(mch, -2, 0);
    if(mch->x == 87) {
        fire_bigbullet(mch, 0, -1);
    }
}


void exec_bomber_pattern(Machine * mch) {
    move_enemy(mch, -1, 0);
    if(pl->x > mch->x && pl->x < mch->x + 8 && mch->cyccount == 0) {
        drop_bomb(mch);
        mch->cyccount = 1;  // Preventing from continuously dropping bombs
    }
}


void exec_mine_pattern(Machine * mch) {
    if(mch->y == 101 || mch->y == 102) {
        mch->cyccount = 0;
    } else if(mch->y == 132 || mch->y == 133) {
        mch->cyccount = 1;
    }
    move_enemy(mch, -2, mch->cyccount == 0 ? 1 : -1);
}


UBYTE cooldown_enemy(Machine * mch, UINT8 period) { // Coolwon period between actions. Used in loops
    if(mch->cyccount != period) {
        mch->cyccount++;
        return 0;
    }
    mch->cyccount = 0;
    return 1; // End of cooldown
}


// HUD

void hud_init() {
    //set_win_data(29, 21, hudtiles);
    set_win_data(0, 20, hudtiles);
    set_win_tiles(0, 0, 18, 1, hudmap);
    move_win(15, 134);
    SHOW_WIN;
}


void hud_upd_shield(INT8 hpbef, INT8 hpaft) {
    UINT8 hptiletresh = hpaft + 2;
    if(hpbef > hpaft) { // Has taken damage
        hptiletresh = hpaft < 0 ? 2 : hpaft + 2;  // HP bar lower tile boundary
        for(UINT8 hpcnt = hpbef + 2; hpcnt > hptiletresh; hpcnt--) {
            set_win_tile_xy(hpcnt, 0, 0x0F);
        }
    } else {    // Gotten a powerup or respawns after lost life
        hptiletresh = hpaft + 3;
        for(UINT8 hpcnt = hpbef + 3; hpcnt < hptiletresh; hpcnt++) {
            set_win_tile_xy(hpcnt, 0, 0x0E);
        }
    }
}


inline void hud_upd_lives() {
    set_win_tile_xy(17, 0, pllives + 1);  // Tile offset 1
}


void hud_draw_pause() {
    set_win_tile_xy(8, 0, 0x08);
    set_win_tile_xy(9, 0, 0x05);
    set_win_tile_xy(10, 0, 0x0A);
    set_win_tile_xy(11, 0, 0x09);
    set_win_tile_xy(12, 0, 0x06);
}


void hud_clear_pause() {
    set_win_tile_xy(8, 0, 0x00);
    set_win_tile_xy(9, 0, 0x0C);
    set_win_tile_xy(11, 0, 0x0D);
    set_win_tile_xy(12, 0, 0x00);
    hud_draw_gun();
    SHOW_SPRITES;
}

inline void hud_draw_gun() {
    set_win_tile_xy(10, 0, 17 + plgun); // Tile offset 17
}

// LEVEL PROCESSING


void init_game() {
    plspeed = plgroundspeed;
    pllives = 3;
    plgun = 0;
}


void init_level(UBYTE hasscenery, UBYTE hasscroll) {
    roadposx = sceneryposx = cloudposx = iframeflg = 0;
    oamidx = 0;
    prjcnt = abtncnt = 0;
    crntpjct = projectiles;
    crntenemy = machines + 1;
    ascendflg = 1;
    lockmvmnt = 0; // Allowing free movement
    holestartx = 255;
    holeendx = 0;
    isapressed = 0;
    numkills = 0;

    levelidx = holeflg = levelclearflg = fallinholeflg = 0;
    lvlplacptr = crntstage->enlayout;

    roadbuildidx = 0; // Resetting the road index
    if(hasscenery) {
        init_level_bgk();
    } else {
        fill_bkg_rect(0, 0, 20, 10, 0x00);
    }
    init_level_road();

    if(hasscroll) {
        STAT_REG = 0x45;
        LYC_REG = 0x00;
        disable_interrupts();
        add_LCD(scroll_level_bkg);
        enable_interrupts();
        set_interrupts(VBL_IFLAG | LCD_IFLAG);
    }

    set_sprite_data(0, 1, blanktile);
    set_sprite_data(1, 16, playerspritetiles);
    set_sprite_data(17, 4, projectiletiles);
    set_sprite_data(21, 24, enemyspritetiles);
    set_sprite_data(45, 1, misctiles);
    init_player();

    for(pjctptr = projectiles; pjctptr <= projectiles + pjctllimit; pjctptr++) { // Initialization of projectiles
        pjctptr->oam = NULL;
    }

    // Initialization of enemies' important attributes { 
    for(machptr = machines + 1; machptr <= machines + enlimit; machptr++) {
        machptr->shield = machptr->explcount = machptr->cyccount = machptr->type = 0;
        machptr->x = machptr->y = machptr->width = machptr->height = 0;
    }

    hud_init();
    hud_draw_gun();
}


void level_loop() {
    while(1) {

        if(levelclearflg) {
            break;  // Out of game loop
        }

        build_level();
        incr_bkg_x_coords(4);
        manage_hole_props();
        manage_projectiles();
        manage_machines();
        manage_sound_chnls();
        manage_player();
        wait_vbl_done();
    }
}


void scorpboss_loop() {
    UINT8 pattrn = 0, firedbull = 0, explidx = 0, gunidx;
    while(1) {

        if(pl->x + pl->width > 98 && pl->y + pl->height > 95 && pl->explcount == 0) {
            take_damage(pl, pl->shield);    // Collision with boss bkg
        }

        if(pattrn == 0) {  // Initial time for the player to adjust before boss attacks
            if(cooldown_enemy(machines + 1, 45)) {
                pattrn = 1;
            }
        }
        
        gunidx = pattrn == 1 ? 2 : 3; // Set gun to be fired depending on pattern num
        if(pattrn == 1 || pattrn == 2) {  // Fire top or bottom gun
            if(is_alive(machines + gunidx) && firedbull != 3) {
                if(cooldown_enemy(machines + gunidx, 20)) {
                    fire_bigbullet(machines + gunidx, -2, 0);
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

        if( (!(is_alive(machines + 1) || is_alive(machines + 2) || is_alive(machines + 3)))
           && machines[1].explcount == 0 && machines[2].explcount == 0 && machines[3].explcount == 0 ) {
            if(lockmvmnt == 2) {    // Wait until the end of the jumping animation
                anim_jump();
            } else {
                break;
            }
        }

        manage_sound_chnls();
        manage_player();
        wait_vbl_done();
    }
}


void pause_game() {
    if(machines[1].type != enboss) {  // Hide sprites only during levels
        HIDE_SPRITES;
    }
    stop_song();
    hud_draw_pause();
    se_pause();
    custom_delay(10);
    waitpad(J_START);
    custom_delay(10);
    hud_clear_pause();
    play_song(&road1);
}


// ANIMATIONS AND EFFECTS


void anim_level_start() {
    anim_reverse_blackout();
    do {
        move_machine(pl, 1, 0);
        wait_vbl_done();
    } while(pl->x != 16);
}


void anim_level_end() {
    for(pjctptr = projectiles; pjctptr <= projectiles + pjctllimit; pjctptr++) {
        if(pjctptr->oam != NULL) {
            destroy_projectile(pjctptr);
        }
    }
    pl->cyccount = 0;
    while(pl->cyccount != 21) {
        build_road();
        incr_bkg_x_coords(5);
        if(lockmvmnt == 2) {    // Wait until the end of the jumping animation before ending animation
            anim_jump();
        } else if(pl->x < 168) {
            move_machine(pl, 1, 0);
        } else {
            anim_blackout_loop(pl->cyccount);
            pl->cyccount++;
        }
        wait_vbl_done();
    }
}


void anim_blackout_loop(UINT8 indictr) {   // To be used in loops
        switch(indictr) {
            case 1:
                BGP_REG = 0xF9;
                break;
            case 10:
                BGP_REG = 0xFE;
                break;
            case 20:
                BGP_REG = 0xFF;
                break;
        }
}


void anim_reverse_blackout_loop(UINT8 indictr) {   // To be used in loops
        switch(indictr) {
            case 1:
                BGP_REG = 0xFE;
                break;
            case 10:
                BGP_REG = 0xF9;
                break;
            case 20:
                BGP_REG = 0xE4;
                break;
        }
}


void anim_blackout() {  // Used as a standalone call
    for(UINT8 blkstep = 0; blkstep != 21; blkstep++) {
        anim_blackout_loop(blkstep);
        wait_vbl_done();
    }
}


void anim_reverse_blackout() {  // Used as a standalone call
    for(UINT8 blkstep = 0; blkstep != 21; blkstep++) {
        anim_reverse_blackout_loop(blkstep);
        wait_vbl_done();
    }
}


// SOUND EFFECTS


void mute_music_pl_chnl(UINT8 chnum) {     // Mutes a music player channel during effects
    hUGE_mute_channel(chnum, HT_CH_MUTE);
    chmutedcyccnt[chnum] = mutecycnum;  // Initiates countdown for mute period
}


void upd_mute_chnl_cycles(UINT8 chnum) {    // Checks if a muted channel needs to be unmuted
    if(chmutedcyccnt[chnum] != 0) {
        chmutedcyccnt[chnum]--;     // Countdown untul unmute
    } else {
        hUGE_mute_channel(chnum, HT_CH_PLAY);
        chmutedcyccnt[chnum] = 255;
    }
}


void se_fall_in_hole() {
    mute_music_pl_chnl(0);
    NR10_REG = 0x1F;
    NR11_REG = 0x81;
    NR12_REG = 0x97;
    NR13_REG = 0xF7;
    NR14_REG = 0x85;
}


void se_fire_bullet() {
    mute_music_pl_chnl(3);
    NR41_REG = 0x00;
    NR42_REG = 0xD4;
    NR43_REG = 0x52;
    NR44_REG = 0xC0;
}


void se_fire_laser() {
    mute_music_pl_chnl(0);
    NR10_REG = 0x2E;
    NR11_REG = 0xC1;
    NR12_REG = 0xD2;
    NR13_REG = 0x54;
    NR14_REG = 0x87;
}


void se_drop_bomb() {
    mute_music_pl_chnl(0);
    NR10_REG = 0x7F;
    NR11_REG = 0x81;
    NR12_REG = 0xD7;
    NR13_REG = 0x55;
    NR14_REG = 0x87;
}


void se_explode() {
    mute_music_pl_chnl(3);
    NR41_REG = 0x04;
    NR42_REG = 0xD5;
    NR43_REG = 0x55;
    NR44_REG = 0x80;
}


void se_get_hit() {
    mute_music_pl_chnl(1);
    NR21_REG = 0x40;
    NR22_REG = 0xD1;
    NR23_REG = 0xCD;
    NR24_REG = 0xC7;
}


void se_jump() {
    mute_music_pl_chnl(0);
    NR10_REG = 0x75;
    NR11_REG = 0x80;
    NR12_REG = 0xD2;
    NR13_REG = 0x46;
    NR14_REG = 0x85;
}


void se_pause() {
    NR10_REG = 0x74;
    NR11_REG = 0x80;
    NR12_REG = 0xD7;
    NR13_REG = 0x0E;
    NR14_REG = 0x86;
}


void se_wpn_upgrd() {
    mute_music_pl_chnl(0);
    NR10_REG = 0x17;
    NR11_REG = 0x7A;
    NR12_REG = 0xFF;
    NR13_REG = 0x75;
    NR14_REG = 0x85;
}


// LEVEL/MENU LOADING


void main_menu() {
    remove_LCD(scroll_level_bkg);
    disable_interrupts();
    anim_reverse_blackout();
    fill_bkg_rect(0, 0, 20, 18, 0);

    waitpad(J_START);
}

void password_menu() {
    // UNDER CONSTRUCTION
}

void play_level() {
    init_level(1, 1);
    anim_level_start();
    play_song(crntstage->theme);
    level_loop();

    /*if(pllives == 0) {
        draw_game_over_screen(); // Game over + password + continue / end options
        if(chosen_continue) {
            continue;
        } else {
            break;
        }
    }*/

    anim_level_end();
}

void play_boss() {
    init_level(1, 0);
    init_scorpboss();
    anim_level_start();
    //play_song(&bosstheme);
    scorpboss_loop();
    anim_explode_boss(80, 106, 72, 30);
    while(1) {
        wait_vbl_done();
    }

    /*if(pllives == 0) {
        draw_game_over_screen(); // Game over + password + continue / end options
        // Work in progress
    }*/

}


void mute_song() {
    hUGE_mute_channel(HT_CH1, HT_CH_MUTE);
    hUGE_mute_channel(HT_CH2, HT_CH_MUTE);
    hUGE_mute_channel(HT_CH3, HT_CH_MUTE);
    hUGE_mute_channel(HT_CH4, HT_CH_MUTE);
}

void unmute_song() {
    hUGE_mute_channel(HT_CH1, HT_CH_PLAY);
    hUGE_mute_channel(HT_CH2, HT_CH_PLAY);
    hUGE_mute_channel(HT_CH3, HT_CH_PLAY);
    hUGE_mute_channel(HT_CH4, HT_CH_PLAY);
}


void play_song(const hUGESong_t * song) {
    __critical {
        hUGE_init(song);
        add_VBL(hUGE_dosound);
    }
}


void stop_song() {
    mute_song();
    remove_VBL(hUGE_dosound);
}


void main() {

    DISPLAY_ON;
    SHOW_BKG;
    SHOW_SPRITES;

    //NR52_REG = 0x80; // Sound on
    NR51_REG = 0xFF; // All channels
    NR50_REG = 0x77; // Max level, left and right

    init_game();
    while(1) {
        play_level();
        play_boss();
    }

}