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
//#include "hUGEDriver.h"

#include <stdio.h>

//extern const hUGESong_t road1;

// Commmon level processing vars
UINT8 levelidx; // For the level arrays
UBYTE holeflg;  // Flag indicating if currently rendered area is a hole or a road
UINT8 levelclearflg; // Level completed flag
UINT8 lvlobjscnt; // Level placement objects array counter
const Placement * lvlplacptr; // Level placement objects array pointer
const enum asset {enrider = 1, endrone = 2, enmissile = 3, enturret = 4, enbomber = 5, enmine = 6};
const UINT8 roadlanesy[] = {98, 114, 130};



// Level data
//const UINT8 level1road[] = {150, 50, 100, 40, 128};  // 20 road, 8 hole, 12 road etc.
const UINT8 level1road[] = {150, 50, 150};  // 20 road, 8 hole, 12 road etc.
const UINT8 level1roadlen = 3;
//const UINT8 level1roadlen = 5;
const Placement level1objs[] = {{0, 50, 167, 40, enbomber}, {1, 24, 167, 133, enturret}, {2, 20, 167, 130, enrider}};
const UINT8 level1objsnum = 3;


UINT8 roadbuildidx; // index for the level road array
UINT8 camtileidx, nextcamtileidx; // current tile index of the right camera border, index of area where 
// the next part of the level should be drawn
UINT8 i, j, k, citr; // iterators for whenever
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
const UINT8 projectilelimit = 8;
UINT8 prjcnt, prjidx;  // Projectile counter, index
const UINT8 screenminx = 8, screenminy = 16; // 0 + horizontal offset / 0 + vertical offset
const UINT8 screenmaxx = 168, screenmaxy = 160; // x0 + screen width / y0 + screen height
UINT8 abtncnt; // Counts cycles after A button press
const UINT8 abtncooldown = 24; // Cycles to wait until A button becomes active
Machine machines[5];
Machine * pl; // Pointer to the player element in the machines array
UINT8 pllives;
UINT8 enidx, enemycount;
const UINT8 machlimit = 5;
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



UINT8 get_OAM_free_tile_idx();
void performance_delay(UINT8 cycles);
void incr_oam_sprite_tile_idx(INT8 steps);
void itr_enemies_idx();
void incr_projectile_counter();
void incr_projectile_index();
UINT8 get_tile_idx(UINT8 newidxnum);
void init_level_bgk(const unsigned char * lvltiles, const unsigned char * lvlmap);
void init_level_road();
void set_machine_sprite_tiles(Machine * mch, UINT8 fsttile);
void place_machine(Machine * mch, UINT8 x, UINT8 y);
void init_player();
void respawn_player();
void init_common_enemy_props(UINT8 x, UINT8 y, UINT8 fsttile);
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
void set_projctl_comm_prop(Machine * mch, INT8 speedx, INT8 speedy);
void fire_bullet(Machine * mch, INT8 speedx, INT8 speedy);
void fire_bigbullet(Machine * mch, INT8 speedx, INT8 speedy);
void fire_laser(Machine * mch, INT8 speedx, INT8 speedy);
void drop_bomb(Machine * mch);
INT8 get_prjctl_x_aimed();
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
void init_level();
void level_loop();
void animate_level_start();
void animate_level_end();
void animate_blackout(UINT8 indictr);
//void play_song(const hUGESong_t * song);
//void stop_song();





UINT8 get_OAM_free_tile_idx() {
    for(UINT8 oami = 4; oami < 32; oami++) {
        if(shadow_OAM[oami].tile == 0) {
            return oami; // First free tile for usage
        }
    }
    return 180; // No free OAM tile space found
}


void performance_delay(UINT8 cycles) {
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


void itr_enemies_idx() {
    enidx = enidx + 1 == machlimit ? 1 : enidx + 1; // Resetting index to 1, since 0 is reserved for player
}


void incr_projectile_counter() {
    prjcnt += prjcnt == projectilelimit ? 0 : 1;
}


void incr_projectile_index() {
    prjidx = prjidx + 1 == projectilelimit ? 0 : prjidx + 1;
}


UINT8 get_tile_idx(UINT8 newidxnum) {   // Recalculate tile index according to the OAM tile limit
    return newidxnum > 31 ? newidxnum - 32 : newidxnum;
}


void init_level_bgk(const unsigned char * lvltiles, const unsigned char * lvlmap) {
    set_bkg_data(47, 13, cloudtiles);
    set_bkg_tiles(0, 0, 32, 1, cloudmap);
    set_bkg_data(60, 40, lvltiles);
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


void init_common_enemy_props(UINT8 x, UINT8 y, UINT8 fsttile) {
    machines[enidx].explcount = 0;
    machines[enidx].cyccount = 0;
    for(k = 0; k < 4; k++) {
        machines[enidx].oamtilenums[k] = oamidx;
        incr_oam_sprite_tile_idx(1);
    }
    set_machine_sprite_tiles(machines + enidx, fsttile);
    place_machine(machines + enidx, x, y);
    itr_enemies_idx();
}


void init_enemy_rider(UINT8 x, UINT8 y) {
    machines[enidx].groundflg = 1;
    machines[enidx].shield = 2;
    machines[enidx].hboffx = 0;
    machines[enidx].hboffy = 1;
    machines[enidx].width = 13;
    machines[enidx].height = 15;
    machines[enidx].gunoffx = -3;    // Avoiding collision with fired bullet
    machines[enidx].gunoffy = 12;
    machines[enidx].type = enrider;
    init_common_enemy_props(x, y, 0x15);
}


void init_enemy_drone(UINT8 x, UINT8 y) {
    machines[enidx].groundflg = 0;
    machines[enidx].shield = 1;
    machines[enidx].hboffx = 2;
    machines[enidx].hboffy = 5;
    machines[enidx].width = 14;
    machines[enidx].height = 7;
    machines[enidx].gunoffx = 7;
    machines[enidx].gunoffy = 13;
    machines[enidx].type = endrone;
    init_common_enemy_props(x, y, 0x19);
}


void init_enemy_missile(UINT8 x, UINT8 y) {
    machines[enidx].groundflg = y > 90 ? 1 : 0;
    machines[enidx].shield = 9;
    machines[enidx].hboffx = 2;
    machines[enidx].hboffy = 5;
    machines[enidx].width = 13;
    machines[enidx].height = 10;
    machines[enidx].gunoffx = 1;
    machines[enidx].gunoffy = 4;
    machines[enidx].type = enmissile;
    init_common_enemy_props(x, y, 0x1D);
}


void init_enemy_turret(UINT8 x, UINT8 y) {
    machines[enidx].groundflg = 0;
    machines[enidx].shield = 100;
    machines[enidx].hboffx = 3;
    machines[enidx].hboffy = 2;
    machines[enidx].width = 14;
    machines[enidx].height = 12;
    machines[enidx].gunoffx = 7;
    machines[enidx].gunoffy = -4;
    machines[enidx].type = enturret;
    init_common_enemy_props(x, y, 0x21);
}


void init_enemy_bomber(UINT8 x, UINT8 y) {
    machines[enidx].groundflg = 0;
    machines[enidx].shield = 2;
    machines[enidx].hboffx = 0;
    machines[enidx].hboffy = 5;
    machines[enidx].width = 13;
    machines[enidx].height = 7;
    machines[enidx].gunoffx = 4;
    machines[enidx].gunoffy = 11;
    machines[enidx].type = enbomber;
    init_common_enemy_props(x, y, 0x25);
}


void init_enemy_mine(UINT8 x, UINT8 y) {
    machines[enidx].groundflg = 1;
    machines[enidx].shield = 20;
    machines[enidx].hboffx = 3;
    machines[enidx].hboffy = 2;
    machines[enidx].width = 11;
    machines[enidx].height = 11;
    machines[enidx].gunoffx = 0;
    machines[enidx].gunoffy = 0;
    machines[enidx].type = enmine;
    init_common_enemy_props(x, y, 0x29);
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


void set_projctl_comm_prop(Machine * mch, INT8 speedx, INT8 speedy) {
    projectiles[prjidx].speedx = speedx;
    projectiles[prjidx].speedy = speedy;
    projectiles[prjidx].oam = (shadow_OAM + oamidx);
    shadow_OAM[oamidx].x = mch->x + mch->gunoffx;
    shadow_OAM[oamidx].y = mch->y + mch->gunoffy;
    incr_oam_sprite_tile_idx(1);
    incr_projectile_counter();
    incr_projectile_index();
}


void fire_bullet(Machine * mch, INT8 speedx, INT8 speedy) {
    if(prjcnt != projectilelimit && oamidx != 180) {  // Set props only if initialization succeeds
        projectiles[prjidx].width = 3;
        projectiles[prjidx].height = 3;
        projectiles[prjidx].damage = 1;
        shadow_OAM[oamidx].tile = 0x11;
        set_projctl_comm_prop(mch, speedx, speedy);
    }
}


void fire_bigbullet(Machine * mch, INT8 speedx, INT8 speedy) {
    if(prjcnt != projectilelimit && oamidx != 180) {  // Set props only if initialization succeeds
        projectiles[prjidx].width = 4;
        projectiles[prjidx].height = 4;
        projectiles[prjidx].damage = 2;
        shadow_OAM[oamidx].tile = 0x12;
        set_projctl_comm_prop(mch, speedx, speedy);
    }
}


void fire_laser(Machine * mch, INT8 speedx, INT8 speedy) {
    if(prjcnt != projectilelimit && oamidx != 180) {  // Set props only if initialization succeeds
        projectiles[prjidx].width = 8;
        projectiles[prjidx].height = 3;
        projectiles[prjidx].damage = 3;
        shadow_OAM[oamidx].tile = 0x13;
        set_projctl_comm_prop(mch, speedx, speedy);
    }
}


void drop_bomb(Machine * mch) {
    if(prjcnt != projectilelimit && oamidx != 180) {  // Set props only if initialization succeeds
        projectiles[prjidx].width = 8;
        projectiles[prjidx].height = 8;
        projectiles[prjidx].damage = 4;
        shadow_OAM[oamidx].tile = 0x14;
        set_projctl_comm_prop(mch, 0, 2);
    }
}


INT8 get_prjctl_x_aimed() { // Returns projectile's x movement direction based on player's position
    if(pl->x < 40) {
        return -2;
    } else if(pl->x < 80) {
        return -1;
    } else if(pl->x < 89) {
        return -0;
    } else if(pl->x < 120) {
        return 1;
    } else {
        return 2;
    }
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
}


void move_projectile(Projectile * pr) {
    if(pr->oam != NULL && is_obj_inside_screen(pr->oam->x, pr->oam->y, pr->width, pr->height)) {
        pr->oam->x += pr->speedx;
        pr->oam->y += pr->speedy;
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
        } else {
            lockmvmnt = 3;
            pllives--;
            upd_hud_lives();
        }
    }
    if(mch->shield < 1) {
        init_explosion(mch);
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
    if(mch->x == 90) {
        fire_bullet(mch, get_prjctl_x_aimed(), 1);
    }
}


void exec_missile_pattern(Machine * mch) {
    move_enemy(mch, -2, 0);
}


void exec_turret_pattern(Machine * mch) {
    move_enemy(mch, -2, 0);
    if(mch->x == 91) {
        fire_bigbullet(mch, get_prjctl_x_aimed(), -1);
    }
}


void exec_bomber_pattern(Machine * mch) {
    move_enemy(mch, -1, 0);
    if(mch->x == pl->x) {
        drop_bomb(mch);
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
    set_win_data(29, 17, hudtiles);
    set_win_tiles(0, 0, 18, 1, hudmap);
    move_win(15, 134);
    SHOW_WIN;
}


void upd_hud_shield(INT8 hpbef, INT8 hpaft) {
    UINT8 hptiletresh = hpaft + 2;
    if(hpbef > hpaft) { // Has taken damage
        hptiletresh = hpaft < 0 ? 2 : hpaft + 2;  // HP bar lower tile boundary
        for(UINT8 hpcnt = hpbef + 2; hpcnt > hptiletresh; hpcnt--) {
            set_win_tile_xy(hpcnt, 0, 0x2C);
        }
    } else {    // Gotten a powerup or respawns after lost live
        hptiletresh = hpaft + 3;
        for(UINT8 hpcnt = hpbef + 3; hpcnt < hptiletresh; hpcnt++) {
            set_win_tile_xy(hpcnt, 0, 0x2D);
        }
    }
}


void upd_hud_lives() {
    set_win_tile_xy(17, 0, pllives + 30);       // tile offset
}


// LEVEL PROCESSING


void init_level() {
    roadposx = sceneryposx = cloudposx = iframeflg = 0;
    speedincr = 3;
    plspeed = plgroundspeed;
    pllives = 3;
    prjcnt = prjidx = abtncnt = enemycount = 0;
    enidx = 1;
    ascendflg = 1;
    lockmvmnt = 0; // Allowing free movement
    holestartx = 255;
    holeendx = 0;

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

    for(i = 0; i < projectilelimit; i++) { // Initialization of projectiles
        projectiles[i].oam = NULL;
    }

    for(i = 1; i < machlimit; i++) { // Initialization of enemies' important attributes
        machines[i].shield = machines[i].explcount = 0;
        machines[i].x = machines[i].y = machines[i].width = machines[i].height = 0;
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

        for(i = 0; i < projectilelimit; i++) {  // Projectiles handling
            if(projectiles[i].oam != NULL) {
                move_projectile(projectiles + i);
                for(j = 0; j < machlimit; j++) {
                    if(machines[j].shield > 0) {
                        if(pl == (machines + j) && (iframeflg || (!pl->groundflg && projectiles[i].oam->y > 95))) {
                            continue;   // Avoid hit during iframes or when player jumps and a bullet is above him on the road
                        }
                        check_projectile_collsn(machines + j, projectiles + i); // Check collision for all machines on screen
                    }
                }
            }
        }
        
        for(i = 0; i < machlimit; i++) {    // Player and enemies handling
            if(i > 0 && machines[i].y != 0) {
                if(!iframeflg && pl->explcount == 0 && pl->groundflg == machines[i].groundflg) {    // Player hasn't exploded
                    check_player_machine_collsn(machines + i);
                }
                exec_enemy_pattern(machines + i);
            }
            if(machines[i].explcount != 0) {
                explode_machine(machines + i);
            }
        }

        // Player checks

        if(iframeflg) {    // Invincibility period
            check_iframes();
        }

        if(lockmvmnt != 2) {
            if(pl->x + pl->width > holestartx) { // Hole in the road and player is inside
                fallinholeflg = 1;
                lockmvmnt = 3;
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
        }

        if(pllives == 0) {
            fill_bkg_rect(0, 0, 40, 36, 0);
            HIDE_SPRITES;
            break;  // Game over
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
            if(lockmvmnt == 0) {
                lockmvmnt = 2;  // Lock vert movement during jump
                pl->groundflg = 0;
                jumpstarty = pl->y; // Keeping player y position for landing
                set_machine_sprite_tiles(pl, 13);
            }
        }

        wait_vbl_done();
    }
}


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
}


void animate_level_end() {
    for(pl->cyccount = 0; pl->cyccount < projectilelimit; pl->cyccount++) {
        if(projectiles[pl->cyccount].oam != NULL) {
            destroy_projectile(projectiles + pl->cyccount);
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


/*void play_song(const hUGESong_t * song) {
    __critical {
        hUGE_init(song);
        add_VBL(hUGE_dosound);
    }
}


void stop_song() {
    hUGE_mute_channel(HT_CH1, HT_CH_MUTE);
    hUGE_mute_channel(HT_CH2, HT_CH_MUTE);
    hUGE_mute_channel(HT_CH3, HT_CH_MUTE);
    hUGE_mute_channel(HT_CH4, HT_CH_MUTE);
    remove_VBL(hUGE_dosound);
}*/


void main() {

    DISPLAY_ON;
    SHOW_BKG;
    SHOW_SPRITES;

    NR52_REG = 0x80; // Sound on
    NR51_REG = 0xFF; // All channels
    NR50_REG = 0x77; // Max level, left and right

    init_level();
    animate_level_start();
    level_loop();
    animate_level_end();

    //play_song(&road1);

}