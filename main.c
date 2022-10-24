#pragma bank 0
#include "machine.c"
#include "projectile.c"
#include "stage.c"


extern const hUGESong_t deserttheme;
extern const hUGESong_t bosstheme;
extern const hUGESong_t cleartheme;

extern unsigned char roadtiles[];
extern unsigned char deserttiles[];
extern unsigned char cloudtiles[];
extern unsigned char playerspritetiles[];
extern unsigned char projectiletiles[];
extern unsigned char enemyspritetiles[];
extern unsigned char hudtiles[];
extern unsigned char scorpbosstiles[];
extern unsigned char bossspritetiles[];
extern unsigned char fonttiles[];
extern unsigned char misctiles[];
extern unsigned char titlelogotiles[];
extern unsigned char citytiles[];
extern unsigned char goodroadmap[];
extern unsigned char holestartmap[];
extern unsigned char holemap[];
extern unsigned char holeendmap[];
extern unsigned char desertmap[];
extern unsigned char cloudmap[];
extern unsigned char scorpbossmap[];
extern unsigned char titlelogomap[];
extern unsigned char hudmap[];
extern unsigned char citymap[];


// Commmon stage processing vars
UINT8 stageidx; // For the stage arrays
UBYTE holeflg;  // Flag indicating if currently rendered area is a hole or a road
UINT8 stageclearflg, bossclearflg; // stage/boss completed flags
UINT8 lvlobjscnt; // stage placement objects array counter
const Placement * lvlplacptr; // stage placement objects array pointer
//const enum asset {0 = 0, 1 = 1, 2 = 2, 3 = 3, 4 = 4, 5 = 5, 6 = 6};
const UINT8 roadlanesy[] = {98, 114, 130};

// Stages data
extern const UINT8 stage1road[], stage2road[];
extern const Placement stage1objs[], stage2objs[];


const Stage stages[] = {{stage1road, 17, stage1objs, 19, deserttiles, 39, desertmap, 1, 2, &deserttheme, 2},
{stage2road, 25, stage2objs, 39, citytiles, 46, citymap, 1, 2, &deserttheme, 2}};
const Stage * crntstage = stages;    // Current stage pointer
UINT8 stagenum;     // Current stage counter
const unsigned char stagenames[][18] = {{0x0E, 0x0F, 0x1D, 0x0F, 0x1C, 0x1E, 0x00, 0x12, 0x13, 0x11, 0x12, 0x21, 0x0B, 0x23},
{0x0D, 0x0B, 0x1A, 0x1E, 0x13, 0x20, 0x0F, 0x00, 0x0D, 0x13, 0x1E, 0x23}};
const UINT8 stnamelengths[] = {14, 12};


extern const INT8 scorpgunprops[];
extern const INT8 stingprops[];
const INT8 enprops[6][10] = {{1, 2, 0, 1, 13, 15, -3, 12, 0, 21},
{0, 1, 2, 5, 14, 7, 7, 13, 1, 25},
{1, 9, 2, 5, 13, 10, 1, 4, 2, 29},
{0, 100, 3, 2, 14, 12, 7, -4, 3, 33},
{0, 2, 0, 5, 13, 7, 4, 11, 4, 37},
{1, 20, 3, 2, 11, 11, 0, 0, 5, 41}};


UINT8 prevbank; // Used to switch back to the previously used bank
UINT8 roadbuildidx; // index for the stage road array
UINT8 camtileidx, nextcamtileidx; // current tile index of the right camera border, index of area where 
// the next part of the stage should be drawn
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
UINT8 menuidx;




UINT8 get_OAM_free_tile_idx() NONBANKED;
void custom_delay(UINT8 cycles) NONBANKED;
void incr_oam_sprite_tile_idx(INT8 steps) NONBANKED;
inline void itr_enemies_ptr() NONBANKED;
inline void incr_projectile_counter() NONBANKED;
inline void itr_projectile_ptr() NONBANKED;
inline UBYTE found_free_projectile_space() NONBANKED;
inline UINT8 get_tile_idx(UINT8 newidxnum) NONBANKED;
void clear_all_sprites() NONBANKED;
void init_stage_bgk() NONBANKED;
void init_stage_road() NONBANKED;
void set_machine_tile(Machine * mch, UINT8 tlnum) NONBANKED;
void set_machine_sprite_tiles(Machine * mch, UINT8 fsttile) NONBANKED;
void place_machine(Machine * mch, UINT8 x, UINT8 y) NONBANKED;
void init_player() NONBANKED;
void respawn_player() NONBANKED;
void init_machine_props(UINT8 x, UINT8 y, const INT8 * mchprops) NONBANKED;
void init_scorpboss() BANKED;
inline UBYTE collides_with_sidewalk(INT8 vspeed) NONBANKED;
inline UBYTE is_inside_x_bounds(UINT8 posx) NONBANKED;
void move_machine(Machine * mch, INT8 speedx, INT8 speedy) NONBANKED;
void move_player(INT8 speedx, INT8 speedy) NONBANKED;
void move_enemy(Machine * en, INT8 speedx, INT8 speedy) NONBANKED;
void incr_bkg_x_coords(UINT8 roadsp) NONBANKED;
void scroll_stage_bkg() NONBANKED;
void place_stage_obj(UINT8 type, UINT8 x, UINT8 y) NONBANKED;
void build_stage() NONBANKED;
void build_road() NONBANKED;
void build_hole() NONBANKED;
void manage_hole_props();
void manage_projectiles() NONBANKED;
void manage_machines() NONBANKED;
void manage_sound_chnls() NONBANKED;
void manage_player() NONBANKED;
inline UINT8 get_horiz_dist(UINT8 fstobjx, UINT8 sndobjx) NONBANKED;
void set_projctl_comm_prop(Machine * mch, INT8 speedx, INT8 speedy) NONBANKED;
void fire_bullet(Machine * mch, INT8 speedx, INT8 speedy) NONBANKED;
void fire_bigbullet(Machine * mch, INT8 speedx, INT8 speedy) NONBANKED;
void fire_laser(Machine * mch, INT8 speedx, INT8 speedy) NONBANKED;
void drop_bomb(Machine * mch) NONBANKED;
inline INT8 get_prjctl_x_aimed(Projectile * prjct) NONBANKED;
inline INT8 get_prjctl_y_aimed(Projectile * prjct) NONBANKED;
inline UBYTE is_obj_inside_screen(UINT8 x, UINT8 y, UINT8 width, UINT8 height) NONBANKED;
inline UBYTE is_alive(Machine * mch) NONBANKED;
void destroy_projectile(Projectile * pr) NONBANKED;
void move_projectile(Projectile * pr) NONBANKED;
void init_explosion(Machine * mch) NONBANKED;
void explode_machine(Machine * mch) NONBANKED;
void anim_explode_boss(UINT8 x, UINT8 y, UINT8 width, UINT8 height) NONBANKED;
void take_damage(Machine * mch, UINT8 dmgamt) NONBANKED;
void add_to_player_shield(UINT8 amt) NONBANKED;
void check_iframes() NONBANKED;
void destroy_machine(Machine * mch) NONBANKED;
void check_projectile_collsn(Machine * mch, Projectile * prj) NONBANKED;
void check_player_machine_collsn(Machine * mch) NONBANKED;
void anim_jump() NONBANKED;
void exec_enemy_pattern(Machine * mch) NONBANKED;
void exec_rider_pattern(Machine * mch) NONBANKED;
void exec_drone_pattern(Machine * mch) NONBANKED;
void exec_missile_pattern(Machine * mch) NONBANKED;
void exec_turret_pattern(Machine * mch) NONBANKED;
void exec_bomber_pattern(Machine * mch) NONBANKED;
void exec_mine_pattern(Machine * mch) NONBANKED;
UBYTE cooldown_enemy(Machine * mch, UINT8 period) NONBANKED;
void hud_init() NONBANKED;
void hud_upd_shield(INT8 hpbef, INT8 hpaft) NONBANKED;
inline void hud_upd_lives() NONBANKED;
void hud_draw_pause() NONBANKED;
void hud_clear_pause() NONBANKED;
inline void hud_draw_gun() NONBANKED;
void init_game() NONBANKED;
void init_stage(UBYTE hasscenery, UBYTE hasscroll) NONBANKED;
void stage_loop() NONBANKED;
void scorpboss_loop() BANKED;
void pause_game() NONBANKED;
void clear_all_projectiles() NONBANKED;
void anim_stage_start() NONBANKED;
void anim_stage_end() NONBANKED;
void anim_blackout_loop(UINT8 indictr) NONBANKED;
void anim_reverse_blackout_loop(UINT8 indictr) NONBANKED;
void anim_blackout() NONBANKED;
void anim_reverse_blackout() NONBANKED;
void mute_music_pl_chnl(UINT8 chnum) NONBANKED;
void upd_mute_chnl_cycles(UINT8 chnum) NONBANKED;
void se_fall_in_hole() NONBANKED;
void se_fire_bullet() NONBANKED;
void se_fire_laser() NONBANKED;
void se_drop_bomb() NONBANKED;
void se_explode() NONBANKED;
void se_get_hit() NONBANKED;
void se_jump() NONBANKED;
void se_pause() NONBANKED;
void se_wpn_upgrd() NONBANKED;
void se_move_cursor() BANKED;
void se_choose_entry() BANKED;
void get_menu_pl_input(UINT8 * entries, UINT8 numentries) BANKED;
void init_common_menu_props() BANKED;
void main_menu() BANKED;
void stage_intro_screen(UINT8 stnum) BANKED;
void game_over_menu() BANKED;
void demo_end_screen() BANKED;     // DEMO CODE
void password_menu() BANKED;
void play_stage() NONBANKED;
void play_boss() NONBANKED;
void init_boss(UINT8 stnum) NONBANKED;
void boss_loop(UINT8 stnum) NONBANKED;
void boss_clear_sequence(UINT8 stnum) NONBANKED;
void mute_song() NONBANKED;
void unmute_song() NONBANKED;
void play_song(const hUGESong_t * song, UINT8 songbank) NONBANKED;
void stop_song() NONBANKED;





UINT8 get_OAM_free_tile_idx() {
    for(UINT8 oami = 4; oami < 40; oami++) {
        if(shadow_OAM[oami].tile == 0) {
            return oami; // First free tile for usage
        }
    }
    return 180; // No free OAM tile space found
}


void custom_delay(UINT8 cycles) NONBANKED {
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


inline void itr_enemies_ptr() NONBANKED {
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


void clear_all_sprites() NONBANKED {
    for(i = 0; i != 40; i++) {
        set_sprite_tile(i, 0);
        move_sprite(i, 0, 0);
    }
    wait_vbl_done();
}


void init_stage_bgk() NONBANKED {
    if(crntstage->hasclouds) {
        SWITCH_ROM_MBC1(2);
        set_bkg_data(20, 13, cloudtiles);
        set_bkg_tiles(0, 0, 32, 1, cloudmap);
        SWITCH_ROM_MBC1(crntstage->stagebank);
        set_bkg_data(61, crntstage->bkgtilesnum, crntstage->bkgtiles);
        set_bkg_tiles(0, 1, 32, 9, crntstage->bkgmap);
    } else {
        SWITCH_ROM_MBC1(crntstage->stagebank);
        set_bkg_data(20, crntstage->bkgtilesnum, crntstage->bkgtiles);
        set_bkg_tiles(0, 0, 32, 10, crntstage->bkgmap);
    }
}


void init_stage_road() NONBANKED { // Layout initial road tiles to start the stage
    prevbank = _current_bank;
    SWITCH_ROM_MBC1(2);
    set_bkg_data(33, 28, roadtiles);
    for(roadbuildidx = 0; roadbuildidx < 7; roadbuildidx++) {
        set_bkg_tiles(roadbuildidx * 3, 10, 3, 7, goodroadmap);
    }
    SWITCH_ROM_MBC1(prevbank);
    camtileidx = 18;
    nextcamtileidx = camtileidx + 3;
}


void set_machine_tile(Machine * mch, UINT8 tlnum) NONBANKED { // Sets all machine tiles to a specific tile from memory
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


void place_machine(Machine * mch, UINT8 x, UINT8 y) NONBANKED {
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


void init_machine_props(UINT8 x, UINT8 y, const INT8 * mchprops) NONBANKED{
    crntenemy->explcount = 0;
    crntenemy->cyccount = 0;
    crntenemy->groundflg = mchprops[0];
    crntenemy->shield = mchprops[1];
    crntenemy->hboffx = mchprops[2];
    crntenemy->hboffy = mchprops[3];
    crntenemy->width = mchprops[4];
    crntenemy->height = mchprops[5];
    crntenemy->gunoffx = mchprops[6];
    crntenemy->gunoffy = mchprops[7];
    crntenemy->type = mchprops[8];
    for(i = 0; i < 4; i++) {
        crntenemy->oamtilenums[i] = oamidx;
        incr_oam_sprite_tile_idx(1);
    }
    set_machine_sprite_tiles(crntenemy, mchprops[9]);
    place_machine(crntenemy, x, y);
    itr_enemies_ptr();
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
    __critical {
        cloudposx += roadsp - 3;
        sceneryposx += roadsp - 1;
        roadposx += roadsp;
    }
}


void scroll_stage_bkg() NONBANKED {
    switch(LYC_REG) {
        case 0x00:
            move_bkg(cloudposx, 0);
            LYC_REG = 0x07;
            break;
        case 0x07:
            move_bkg(sceneryposx, 0);
            LYC_REG = 0x50;
            break;
        case 0x50:
            move_bkg(roadposx, 0);
            LYC_REG = 0x00;
            break;
    }
}


void place_stage_obj(UINT8 type, UINT8 x, UINT8 y) {
    init_machine_props(x, y, *(enprops + type));
}


void build_stage() NONBANKED {   // Automatically builds the road ahead while scrolling the stage
    camtileidx = get_tile_idx((SCX_REG + 168) / 8);
    if(camtileidx == nextcamtileidx) {
        if(holeflg) {
            build_hole();
        } else {
            build_road();
        }

        //if(roadbuildidx == stage1road[stageidx]) {
        if(roadbuildidx == crntstage->roadlayout[stageidx]) {
            stageidx++; // Moving to next elem in stage array
            roadbuildidx = 0;
            holeflg = !holeflg; // Roads and holes alternate
        } else {
            roadbuildidx++;
        }

        // Placing objects inside stage
        if(lvlobjscnt != crntstage->ennum && lvlplacptr->arridx == stageidx && lvlplacptr->elemidx == roadbuildidx) {
            place_stage_obj(lvlplacptr->type, lvlplacptr->x, lvlplacptr->y);
            lvlplacptr++;
            lvlobjscnt++;
        }
    }

    if(stageidx == crntstage->roadlength) { // End of stage reached
        stageclearflg = 1;
    }
}


void build_road() NONBANKED {
    prevbank = _current_bank;
    SWITCH_ROM_MBC1(2);
    set_bkg_tiles(camtileidx, 10, 3, 7, goodroadmap);
    SWITCH_ROM_MBC1(prevbank);
    nextcamtileidx = get_tile_idx(camtileidx + 3);
}


void build_hole() NONBANKED {
    prevbank = _current_bank;
    SWITCH_ROM_MBC1(2);
    if(roadbuildidx == 0) {
        //holestartx = 208;
        holestartx = 238;
        set_bkg_tiles(camtileidx, 10, 4, 7, holestartmap);
        nextcamtileidx = get_tile_idx(camtileidx + 4);
    } else if(roadbuildidx == crntstage->roadlayout[stageidx]) {
        //holeendx = 144;
        holeendx = 174;
        holestartx = 255;   // Resetting hole start value
        set_bkg_tiles(camtileidx, 10, 3, 7, holeendmap);
        nextcamtileidx = get_tile_idx(camtileidx + 3);
    } else {
        set_bkg_tiles(camtileidx, 10, 3, 7, holemap);
        nextcamtileidx = get_tile_idx(camtileidx + 3);
    }
    SWITCH_ROM_MBC1(prevbank);
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
    if((mch->type == 3 || mch->type == 1) && (crntpjct->oam->x < pl->x || crntpjct->oam->x > (pl->x + pl->width))) {
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
    if(iframecnt == pliframeprd) {  // Iframe period has ended
        iframecnt = iframeflg = 0;
        set_machine_sprite_tiles(pl, pl->groundflg == 1 ? 1 : 13);
    } else {
        iframecnt++;
        if(shadow_OAM[0].tile == 0) {   // Swap player sprite and empty tiles
            set_machine_sprite_tiles(pl, pl->groundflg == 1 ? 1 : 13);
        } else {
            set_machine_tile(pl, 0);
        }
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
        if(mch->type != 6) {
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
        case 0:
            exec_rider_pattern(mch);
            break;
        case 1:
            exec_drone_pattern(mch);
            break;
        case 2:
            exec_missile_pattern(mch);
            break;
        case 3:
            exec_turret_pattern(mch);
            break;
        case 4:
            exec_bomber_pattern(mch);
            break;
        case 5:
            exec_mine_pattern(mch);
            break;
    }
}


void exec_rider_pattern(Machine * mch) {
    if(mch->x > 130 && lockmvmnt != 2 && pl->y > 95) {
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
    if(mch->groundflg != pl->groundflg) {
        mch->groundflg = pl->groundflg;
    }
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


UBYTE cooldown_enemy(Machine * mch, UINT8 period) NONBANKED { // Coolwon period between actions. Used in loops
    if(mch->cyccount != period) {
        mch->cyccount++;
        return 0;
    }
    mch->cyccount = 0;
    return 1; // End of cooldown
}


// HUD


void hud_init() NONBANKED {
    prevbank = _current_bank;
    SWITCH_ROM_MBC1(2);
    //set_win_data(29, 21, hudtiles);
    set_win_data(0, 20, hudtiles);
    set_win_tiles(0, 0, 18, 1, hudmap);
    SWITCH_ROM_MBC1(prevbank);
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

// STAGE PROCESSING


void init_game() NONBANKED {
    plspeed = plgroundspeed;
    pllives = 3;
    plgun = 0;
    iframecnt = 0;
}


void init_stage(UBYTE hasscenery, UBYTE hasscroll) NONBANKED {
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

    stageidx = holeflg = fallinholeflg = 0;
    lvlplacptr = crntstage->enlayout;

    roadbuildidx = 0; // Resetting the road index
    if(hasscenery) {
        init_stage_bgk();
    } else {
        fill_bkg_rect(0, 0, 32, 10, 0x00);
    }
    init_stage_road();

    if(hasscroll) {
        STAT_REG = 0x45;
        LYC_REG = 0x00;
        remove_LCD(scroll_stage_bkg);
        disable_interrupts();
        add_LCD(scroll_stage_bkg);
        enable_interrupts();
        set_interrupts(VBL_IFLAG | LCD_IFLAG);
    }

    set_sprite_data(0, 1, blanktile);
    prevbank = _current_bank;
    SWITCH_ROM_MBC1(2);
    set_sprite_data(1, 16, playerspritetiles);
    set_sprite_data(17, 4, projectiletiles);
    set_sprite_data(21, 24, enemyspritetiles);
    set_sprite_data(45, 1, misctiles);
    SWITCH_ROM_MBC1(prevbank);
    init_player();

    for(pjctptr = projectiles; pjctptr <= projectiles + pjctllimit; pjctptr++) { // Initialization of projectiles
        pjctptr->oam = NULL;
    }

    // Initialization of enemies' important attributes { 
    for(machptr = machines + 1; machptr <= machines + enlimit; machptr++) {
        machptr->shield = machptr->explcount = machptr->cyccount = machptr->type = 0;
        machptr->x = machptr->y = machptr->width = machptr->height = 0;
    }

    SWITCH_ROM_MBC1(2);
    hud_init();
    SWITCH_ROM_MBC1(prevbank);
    hud_upd_lives();
    hud_draw_gun();
}


void stage_loop() {
    while(1) {

        if(stageclearflg || pllives == 0) {
            if(pl->explcount == 0) {    // Waiting for explosion to finish
                break;  // Out of game loop
            }
        }

        build_stage();
        incr_bkg_x_coords(4);
        manage_hole_props();
        manage_projectiles();
        manage_machines();
        manage_sound_chnls();
        manage_player();
        wait_vbl_done();
    }
}


void pause_game() {
    if(machines[1].type != 6) {  // Hide sprites only during stages
        HIDE_SPRITES;
    }
    stop_song();
    hud_draw_pause();
    se_pause();
    custom_delay(10);
    waitpad(J_START);
    custom_delay(10);
    hud_clear_pause();
    if(stageclearflg == 0) {
        play_song(crntstage->theme, crntstage->themebank);
    } else {
        play_song(&bosstheme, 2);
    }
}


// ANIMATIONS AND EFFECTS


void clear_all_projectiles() {
    for(pjctptr = projectiles; pjctptr <= projectiles + pjctllimit; pjctptr++) {
        if(pjctptr->oam != NULL) {
            destroy_projectile(pjctptr);
        }
    }
}


void anim_stage_start() NONBANKED {
    anim_reverse_blackout();
    do {
        move_machine(pl, 1, 0);
        wait_vbl_done();
    } while(pl->x != 16);
}


void anim_stage_end() {
    clear_all_projectiles();
    pl->cyccount = 0;
    while(1) {
        build_road();
        incr_bkg_x_coords(5);
        if(lockmvmnt == 2) {    // Wait until the end of the jumping animation
            anim_jump();
        } else if(pl->x < 168) {
            move_machine(pl, 1, 0);
        } else {
            break;  // Animation has finished
        }
        wait_vbl_done();
    }
}


void anim_blackout_loop(UINT8 indictr) NONBANKED {   // To be used in loops
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


void anim_reverse_blackout_loop(UINT8 indictr) NONBANKED {   // To be used in loops
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


void anim_blackout() NONBANKED {  // Used as a standalone call
    for(UINT8 blkstep = 0; blkstep != 21; blkstep++) {
        anim_blackout_loop(blkstep);
        wait_vbl_done();
    }
}


void anim_reverse_blackout() NONBANKED {  // Used as a standalone call
    for(UINT8 blkstep = 0; blkstep != 21; blkstep++) {
        anim_reverse_blackout_loop(blkstep);
        wait_vbl_done();
    }
}


// SOUND EFFECTS


void mute_music_pl_chnl(UINT8 chnum) NONBANKED {     // Mutes a music player channel during effects
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


// STAGE/MENU LOADING



void play_stage() NONBANKED {
    init_stage(1, 1);
    anim_stage_start();
    play_song(crntstage->theme, crntstage->themebank);
    stage_loop();
    if(stageclearflg == 1) {
        anim_stage_end();
    }
    stop_song();    // Stop current stage music
    anim_blackout();
    HIDE_WIN;
    clear_all_sprites();
    __critical {
        cloudposx = sceneryposx = roadposx = 0;
        scroll_stage_bkg();
    }
}


// BOSSES


void init_boss(UINT8 stnum) NONBANKED {
    switch(stnum) {
        case 0:
            init_scorpboss();
            break;
        case 1: // To be replaced with actual level 2 code
            init_scorpboss();
            break;
    }
}


void boss_loop(UINT8 stnum) NONBANKED {
    switch(stnum) {
        case 0:
            scorpboss_loop();
            break;
        case 1: // To be replaced with actual level 2 code
            scorpboss_loop();
            break;
    }
}


void boss_clear_sequence(UINT8 stnum) NONBANKED {
    switch(stnum) {
        case 0:
            anim_explode_boss(80, 106, 72, 30);
            break;
        case 1: // To be replaced with actual level 2 code
            anim_explode_boss(80, 106, 72, 30);
            break;
    }
}


void play_boss() NONBANKED {
    init_stage(1, 0);
    init_boss(stagenum);
    anim_stage_start();
    play_song(&bosstheme, 2);
    boss_loop(stagenum);
    if(bossclearflg == 1) {
        stop_song();
        boss_clear_sequence(stagenum);
        play_song(&cleartheme, 2);
        custom_delay(255);
        stop_song();
    }
    anim_blackout();
    stop_song();    // Stop current stage music
    HIDE_WIN;
    clear_all_sprites();
    __critical {
        cloudposx = sceneryposx = roadposx = 0;
        scroll_stage_bkg();
    }
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


void play_song(const hUGESong_t * song, UINT8 songbank) NONBANKED {
    __critical {
        prevbank = _current_bank;
        SWITCH_ROM_MBC1(songbank);
        hUGE_init(song);
        add_VBL(hUGE_dosound);
        SWITCH_ROM_MBC1(prevbank);
    }
}


void stop_song() NONBANKED {
    mute_song();
    remove_VBL(hUGE_dosound);
}


void main() NONBANKED {

    DISPLAY_ON;
    SHOW_BKG;
    SHOW_SPRITES;

    NR52_REG = 0x80; // Sound on
    NR51_REG = 0xFF; // All channels
    NR50_REG = 0x77; // Max level, left and right

    anim_blackout();    // DEMO CODE
    while(1) {
        main_menu();
        init_game();
        stageclearflg = bossclearflg = 0;
        stagenum = 0;
        while(1) {
            if(pllives == 0) {
                game_over_menu();
                if(menuidx == 1) {
                    break;  // Player has chosen to quit the stage/boss
                }
            } else if(stageclearflg == 0) {
                stage_intro_screen(stagenum);
                play_stage();
            } else if(bossclearflg == 0) {
                play_boss();
            } else {    // Current stage and boss both cleared
                stageclearflg = bossclearflg = 0;
                stagenum++;
                crntstage++;    // Next stage data
                if(stagenum == 2) { // Has passed currently available levels
                    demo_end_screen();  // DEMO CODE
                    init_game(); // DEMO CODE
                    break;  // DEMO CODE
                }
            }
        }

    }


}