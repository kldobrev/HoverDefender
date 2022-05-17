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
#include "placement.c"
#include "misctiles.c"
#include "hudtiles.c"
#include "hudmap.c"
#include "hUGEDriver.h"

extern const hUGESong_t road1;

// Commmon level processing vars
UINT8 levelidx; // For the level arrays
UBYTE holeflg;  // Flag indicating if currently rendered area is a hole or a road
UINT8 levelclearflg; // Level completed flag
UINT8 lvlobjscnt; // Level placement objects array counter
const Placement * lvlplacptr; // Level placement objects array pointer
const enum asset {enrider = 0, endrone = 1, enmissile = 2, enturret = 3, enbomber = 4, enmine = 5};
const UINT8 roadlanesy[] = {98, 114, 130};


// Level data
//const UINT8 level1road[] = {150, 50, 100, 40, 128};  // 20 road, 8 hole, 12 road etc.
const UINT8 level1road[] = {150, 50, 150};  // 20 road, 8 hole, 12 road etc.
const UINT8 level1roadlen = 3;
//const UINT8 level1roadlen = 5;
const Placement level1objs[] = {{0, 20, 167, 55, endrone}, {0, 50, 167, 40, enbomber}, {1, 24, 167, 133, enturret}, {2, 20, 167, 130, enrider}, {2, 35, 167, 130, enrider}};
const UINT8 level1objsnum = 3;


UINT8 roadbuildidx; // index for the level road array
UINT8 camtileidx, nextcamtileidx; // current tile index of the right camera border, index of area where 
// the next part of the level should be drawn
UINT8 i, citr; // iterators for whenever
INT8 sitr;  // signed iterator for whenever
UINT8 roadposx, sceneryposx, cloudposx, speedincr;
const UINT8 roadscrspeed = 5; // Road scrolling speed
UINT8 plspeed;
const UINT8 jumpspeed = 3;
const UINT8 plgroundspeed = 1;  // Player movement speed
const UINT8 roadboundy = 101; // Vertical bound between road and sky
UINT8 oamidx = 0;
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
Machine machines[5];
Machine * pl; // Pointer to the player element in the machines array
Machine * crntenemy, * machptr; // Pointer for current enemy in the machines array / machine pointer for loops
UINT8 pllives;
const UINT8 enlimit = 4; // Enemy limit, with player makes for max num of machines
const UINT8 pliframeprd = 120; // Iframe duration
const UINT8 explodeprd = 32; // Explosion duration
UINT8 lockmvmnt; // 0 - no locking, 1 - horizontal, 2 - vertical, 3 - both
UINT8 iframecnt;
UBYTE iframeflg;
UBYTE fallinholeflg;
UBYTE ascendflg; // Ascending or descending state during jump animation
const UINT8 jumplimity = 50; // Jumping vert distance limit
const UINT8 jumphalflimy = 25;
UINT8 jumpstarty;   // Player y position at start of jump
UINT8 holestartx, holeendx;    // Used to indicate start and end x position of road holes
UBYTE isapressed;  // Indicates that A iscurrently pressed
const UINT8 mutecycnum = 15;
UINT8 chmutedcyccnt[] = {255, 255, 255, 255}; // Used to mute a sound channel for a number of cycles
UINT8 precfctr; // Precision factor for caluculating coordinates



UINT8 get_OAM_free_tile_idx();
void custom_delay(UINT8 cycles);
void incr_oam_sprite_tile_idx(INT8 steps);
void itr_enemies_ptr();
void incr_projectile_counter();
void itr_projectile_ptr();
UBYTE found_free_projectile_space();
UINT8 get_tile_idx(UINT8 newidxnum);
void init_level_bgk(const unsigned char * lvltiles, const unsigned char * lvlmap);
void init_level_road();
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
UBYTE collides_with_sidewalk(INT8 vspeed);
UBYTE is_inside_x_bounds(UINT8 posx);
void move_machine(Machine * mch, INT8 speedx, INT8 speedy);
void move_player(INT8 speedx, INT8 speedy);
void move_enemy(Machine * en, INT8 speedx, INT8 speedy);
void scroll_level_bkg();
void place_level_obj(UINT8 type, UINT8 x, UINT8 y);
void build_level();
void build_road();
void build_hole();
UINT8 get_horiz_dist(UINT8 fstobjx, UINT8 sndobjx);
void set_projctl_comm_prop(Machine * mch, INT8 speedx, INT8 speedy);
void fire_bullet(Machine * mch, INT8 speedx, INT8 speedy);
void fire_bigbullet(Machine * mch, INT8 speedx, INT8 speedy);
void fire_laser(Machine * mch, INT8 speedx, INT8 speedy);
void drop_bomb(Machine * mch);
INT8 get_prjctl_x_aimed(Projectile * prjct);
INT8 get_prjctl_y_aimed(Projectile * prjct);
UBYTE is_obj_inside_screen(UINT8 x, UINT8 y, UINT8 width, UINT8 height);
void destroy_projectile(Projectile * pr);
void move_projectile(Projectile * pr);
void init_explosion(Machine * mch);
void explode_machine(Machine * mch);
void take_damage(Machine * mch, UINT8 dmgamt);
void add_to_pleyer_shield(UINT8 amt);
void check_iframes();
void destroy_machine(Machine * mch);
void check_projectile_collsn(Machine * mch, Projectile * prj);
void check_player_machine_collsn(Machine * mch);
void animate_hole_fall();
void animate_jump();
void exec_enemy_pattern(Machine * mch);
void exec_rider_pattern(Machine * mch);
void exec_drone_pattern(Machine * mch);
void exec_missile_pattern(Machine * mch);
void exec_turret_pattern(Machine * mch);
void exec_bomber_pattern(Machine * mch);
void exec_mine_pattern(Machine * mch);
void init_hud();
void upd_hud_shield(INT8 hpbef, INT8 hpaft);
void upd_hud_lives();
void hud_draw_pause();
void hud_clear_pause();
void init_level();
void level_loop();
void pause_game();
void animate_level_start();
void animate_level_end();
void animate_blackout(UINT8 indictr);
void reverse_blackout(UINT8 indictr);
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


void itr_enemies_ptr() {
    crntenemy = crntenemy == machines + enlimit ? machines + 1 : crntenemy + 1;
}


void incr_projectile_counter() {
    prjcnt += prjcnt == pjctllimit + 1 ? 0 : 1;
}


void itr_projectile_ptr() {
    crntpjct = crntpjct == projectiles + pjctllimit ? projectiles : crntpjct + 1;
}


UBYTE found_free_projectile_space() {   // Checks if there is free space in memory to spawn a projectile
    return prjcnt != pjctllimit + 1 && oamidx != 180;
}


UINT8 get_tile_idx(UINT8 newidxnum) {   // Recalculate tile index according to the OAM tile limit
    return newidxnum > 31 ? newidxnum - 32 : newidxnum;
}


void init_level_bgk(const unsigned char * lvltiles, const unsigned char * lvlmap) {
    set_bkg_data(50, 13, cloudtiles);
    set_bkg_tiles(0, 0, 32, 1, cloudmap);
    set_bkg_data(63, 40, lvltiles);
    set_bkg_tiles(0, 1, 32, 9, lvlmap);
}



void init_level_road() { // Layount initial road tiles to start the level
    set_bkg_data(0, 29, roadtiles);
    for(roadbuildidx = 0; roadbuildidx < 7; roadbuildidx++) {
        set_bkg_tiles(roadbuildidx * 3, 10, 3, 7, goodroadmap);
    }
    camtileidx = 18;
    nextcamtileidx = camtileidx + 3;
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
    pl->groundflg = 0;
    ascendflg = 1;
    upd_hud_shield(0, 4);
    if(fallinholeflg) {
        fallinholeflg = 0;
        set_machine_sprite_tiles(pl, 13);
        place_machine(pl, 16, 64);
        lockmvmnt = 2;
        jumpstarty = roadlanesy[1];
    } else {
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


UBYTE collides_with_sidewalk(INT8 vspeed) {
    return pl->y + vspeed < 96 || pl->y + vspeed > 127;
}


UBYTE is_inside_x_bounds(UINT8 posx) {
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

        if(roadbuildidx == level1road[levelidx]) {
            levelidx++; // Moving to next elem in level array
            roadbuildidx = 0;
            holeflg = !holeflg; // Roads and holes alternate
        } else {
            roadbuildidx++;
        }

        // Placing objects inside level
        if(lvlobjscnt != level1objsnum && lvlplacptr->arridx == levelidx && lvlplacptr->elemidx == roadbuildidx) {
            place_level_obj(lvlplacptr->type, lvlplacptr->x, lvlplacptr->y);
            lvlplacptr++;
            lvlobjscnt++;
        }
    }

    if(levelidx == level1roadlen) { // End of level reached
        levelclearflg = 1;
    }
}


void build_road() {
    set_bkg_tiles(camtileidx, 10, 3, 7, goodroadmap);
    nextcamtileidx = get_tile_idx(camtileidx + 3);
}


void build_hole() {
    if(roadbuildidx == 0) {
        holestartx = 208;
        set_bkg_tiles(camtileidx, 10, 4, 7, holestartmap);
        nextcamtileidx = get_tile_idx(camtileidx + 4);
    } else if(roadbuildidx == level1road[levelidx]) {
        holeendx = 144;
        holestartx = 255;   // Resetting hole start value
        set_bkg_tiles(camtileidx, 10, 3, 7, holeendmap);
        nextcamtileidx = get_tile_idx(camtileidx + 3);
    } else {
        set_bkg_tiles(camtileidx, 10, 3, 7, holemap);
        nextcamtileidx = get_tile_idx(camtileidx + 3);
    }
 }


UINT8 get_horiz_dist(UINT8 fstobjx, UINT8 sndobjx) { // Returns the distance between 2 objects on x axis
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
        precfctr = pl->x + 46 < mch->x || mch->x + mch->width + 30 < pl->x ? 100 : 10;
        crntpjct->slope = ((crntpjct->oam->y - pl->y) * precfctr) / (crntpjct->oam->x - (pl->x + 8));
        crntpjct->gradient = crntpjct->oam->y - ((crntpjct->slope * crntpjct->oam->x) / precfctr );
    } else {
        crntpjct->slope = crntpjct->gradient = 0;
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


INT8 get_prjctl_x_aimed(Projectile * prjct) { // Returns projectile's y position based on player's position
    return ((prjct->oam->y - prjct->gradient) * precfctr) / prjct->slope;
}


INT8 get_prjctl_y_aimed(Projectile * prjct) { // Returns projectile's y position based on player's position
    return prjct->slope * prjct->oam->x + prjct->gradient;
}


UBYTE is_obj_inside_screen(UINT8 x, UINT8 y, UINT8 width, UINT8 height) {
    return (x < screenmaxx && screenminx < x + width) &&
    (y < screenmaxy && screenminy < y + height);
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
    se_explode();
}


void move_projectile(Projectile * pr) {
    if(pr->oam != NULL && is_obj_inside_screen(pr->oam->x, pr->oam->y, pr->width, pr->height)) {
        pr->oam->y += pr->speedy;
        pr->oam->x = pr->slope != 0 ? get_prjctl_x_aimed(pr) : pr->oam->x + pr->speedx;
    } else {
        destroy_projectile(pr);
    }
}


void explode_machine(Machine * mch) {
    if(mch->explcount % 8 != 0) {
        if(shadow_OAM[mch->oamtilenums[0]].tile != 5) {
            set_machine_sprite_tiles(mch, 5);
        } else {
            set_machine_sprite_tiles(mch, 9);
        }
    }
    mch->explcount++;
    if(mch->explcount == explodeprd) {
        destroy_machine(mch);
    }
}


void destroy_machine(Machine * mch) {
    set_sprite_tile(mch->oamtilenums[0], 0);
    set_sprite_tile(mch->oamtilenums[1], 0);
    set_sprite_tile(mch->oamtilenums[2], 0);
    set_sprite_tile(mch->oamtilenums[3], 0);
    move_sprite(mch->oamtilenums[0], 0, 0);
    move_sprite(mch->oamtilenums[1], 0, 0);
    move_sprite(mch->oamtilenums[2], 0, 0);
    move_sprite(mch->oamtilenums[3], 0, 0);
    mch->explcount = mch->x = mch->y = 0;
}


void take_damage(Machine * mch, UINT8 dmgamt) {
    mch->shield -= dmgamt;
    if(pl == mch) {
        upd_hud_shield(pl->shield + dmgamt, pl->shield);
        if(pl->shield > 0) {
            iframeflg = 1; // Starting iframe period
        } else {    // Lost life
            lockmvmnt = 3;
            pllives--;
            upd_hud_lives();
        }
    }
    if(mch->shield < 1) {
        init_explosion(mch);
    } else {
        se_get_hit();
    }
}


void add_to_pleyer_shield(UINT8 amt) {  // Used for increasing player shield value
    if(pl->shield + amt > 4) {
        upd_hud_shield(pl->shield, 4);
        pl->shield = 4; // Shield max capacity is always 4
    } else {
        upd_hud_shield(pl->shield, pl->shield + amt);
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
        init_explosion(mch);
    }
}


void animate_hole_fall() {
    move_machine(pl, -1, 2);
}


void animate_jump() {
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
    if(mch->x == 90 && pl->y > mch->y) {
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


// HUD

void init_hud() {
    set_win_data(29, 21, hudtiles);
    set_win_tiles(0, 0, 18, 1, hudmap);
    move_win(15, 134);
    SHOW_WIN;
}


void upd_hud_shield(INT8 hpbef, INT8 hpaft) {
    UINT8 hptiletresh = hpaft + 2;
    if(hpbef > hpaft) { // Has taken damage
        hptiletresh = hpaft < 0 ? 2 : hpaft + 2;  // HP bar lower tile boundary
        for(UINT8 hpcnt = hpbef + 2; hpcnt > hptiletresh; hpcnt--) {
            set_win_tile_xy(hpcnt, 0, 0x30);
        }
    } else {    // Gotten a powerup or respawns after lost life
        hptiletresh = hpaft + 3;
        for(UINT8 hpcnt = hpbef + 3; hpcnt < hptiletresh; hpcnt++) {
            set_win_tile_xy(hpcnt, 0, 0x31);
        }
    }
}


void upd_hud_lives() {
    set_win_tile_xy(17, 0, pllives + 30);       // tile offset
}


void hud_draw_pause() {
    HIDE_SPRITES;
    set_win_tile_xy(8, 0, 0x2B);
    set_win_tile_xy(9, 0, 0x28);
    set_win_tile_xy(10, 0, 0x2D);
    set_win_tile_xy(11, 0, 0x2C);
    set_win_tile_xy(12, 0, 0x29);
}


void hud_clear_pause() {
    for(i = 8; i < 13; i++) {
        set_win_tile_xy(i, 0, 0x00);
    }
    SHOW_SPRITES;
}

// LEVEL PROCESSING


void init_level() {
    roadposx = sceneryposx = cloudposx = iframeflg = 0;
    speedincr = 3;
    plspeed = plgroundspeed;
    pllives = 3;
    prjcnt = abtncnt = 0;
    crntpjct = projectiles;
    crntenemy = machines + 1;
    ascendflg = 1;
    lockmvmnt = 0; // Allowing free movement
    holestartx = 255;
    holeendx = 0;
    isapressed = 0;

    levelidx = holeflg = levelclearflg = fallinholeflg = 0;
    lvlplacptr = level1objs;

    init_level_road();
    roadbuildidx = 0; // Resetting the road index
    init_level_bgk(deserttiles, desertmap);

    STAT_REG = 0x45;
    LYC_REG = 0x00;

    disable_interrupts();
    add_LCD(scroll_level_bkg);
    enable_interrupts();

    set_interrupts(VBL_IFLAG | LCD_IFLAG);

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
        machptr->shield = machptr->explcount = 0;
        machptr->x = machptr->y = machptr->width = machptr->height = 0;
    }

    init_hud();
}


void level_loop() {
    while(1) {

        if(levelclearflg) {
            break;  // Out of game loop
        }

        build_level();
        cloudposx += speedincr - 1;
        sceneryposx += speedincr + 1;
        roadposx += speedincr + 2;
        if(holestartx != 255 && holestartx > screenminx) { // Road hole has appeared
            holestartx -= roadscrspeed;
        }
        if (holeendx != 0) {  // Road hole end reached
            holeendx -= roadscrspeed;
        } else if(holeendx < screenminx) {
            holeendx = 0;   // Resetting hole end value
        }

        if(abtncnt != 0) {
            abtncnt = abtncnt == abtncooldown ? 0 : abtncnt + 1;
        }

        for(pjctptr = projectiles; pjctptr <= projectiles + pjctllimit; pjctptr++) { // Projectiles handling
            if(pjctptr->oam != NULL) {
                move_projectile(pjctptr);
                for(machptr = machines; machptr <= machines + enlimit; machptr++) {
                    if(machptr->shield > 0) {
                        if(pl == machptr && (iframeflg || (!pl->groundflg && pjctptr->oam->y > 95))) {
                            continue;   // Avoid hit during iframes or when player jumps and a bullet is above him on the road
                        }
                        check_projectile_collsn(machptr, pjctptr); // Check collision for all machines on screen
                    }
                }
            }
        }

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

        // Check sound channels
        for(i = 0; i < 4; i++) {
            if(chmutedcyccnt[i] != 255) {
                upd_mute_chnl_cycles(i);
            }
        }

        // Player checks

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
            animate_jump();
        }

        if(fallinholeflg) {
            animate_hole_fall();
            if(pl->y > 144 && pl->explcount == 0) {
                take_damage(pl, pl->shield);
            }
        }

        if(pl->shield < 1 && pllives != 0 && pl->explcount == 0) {
            respawn_player();
        } else if(pllives == 0) {
            animate_blackout(pl->cyccount);  // Game over
            pl->cyccount++;
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
                fire_bullet(pl, 2, 0);
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
        wait_vbl_done();
    }
}


void pause_game() {
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


void animate_level_start() {
    do {
        move_machine(pl, 1, 0);
        wait_vbl_done();
    } while(pl->x != 16);

    for(sitr = -1; sitr != ((INT8) roadscrspeed); sitr++) {
        for(pl->cyccount = 0; pl->cyccount != 5; pl->cyccount++) {  
            build_level();
            cloudposx += speedincr - 1;
            sceneryposx += speedincr + 1;
            roadposx += speedincr + 2;
            wait_vbl_done();
        }
    }
    pl->cyccount = 0;   // Resetting value
}


void animate_level_end() {
    for(pjctptr = projectiles; pjctptr <= projectiles + pjctllimit; pjctptr++) {
        if(pjctptr->oam != NULL) {
            destroy_projectile(pjctptr);
        }
    }
    pl->cyccount = 0;
    while(pl->cyccount != 21) {
        build_road();
        cloudposx += speedincr - 1;
        sceneryposx += speedincr + 1;
        roadposx += speedincr + 2;
        if(lockmvmnt == 2) {    // Wait until the end of the jumping animation before ending animation
            animate_jump();
        } else if(pl->x != 168) {
            move_machine(pl, 1, 0);
        } else {
            animate_blackout(pl->cyccount);
            pl->cyccount++;
        }
        wait_vbl_done();
    }
}


void animate_blackout(UINT8 indictr) {   // To be used in loops
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


void reverse_blackout(UINT8 indictr) {   // To be used in loops
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

    NR52_REG = 0x80; // Sound on
    NR51_REG = 0xFF; // All channels
    NR50_REG = 0x77; // Max level, left and right

    init_level();
    animate_level_start();
    play_song(&road1);
    level_loop();
    animate_level_end();

}