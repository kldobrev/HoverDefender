#pragma bank 0
#include "machine.c"
#include "projectile.c"
#include "stage.c"
#include "maps/goodroadmap.c"
#include "maps/holestartmap.c"
#include "maps/holemap.c"
#include "maps/holeendmap.c"


extern const hUGESong_t deserttheme;
extern const hUGESong_t bosstheme;
extern const hUGESong_t cleartheme;
extern const hUGESong_t citytheme;
extern const hUGESong_t mountaintheme;
extern const hUGESong_t tunneltheme;

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
extern unsigned char mountaintiles[];
extern unsigned char desertmap[];
extern unsigned char cloudmap[];
extern unsigned char scorpbossmap[];
extern unsigned char titlelogomap[];
extern unsigned char hudmap[];
extern unsigned char citymap[];
extern unsigned char mountainmap[];
extern unsigned char tunneltiles[];
extern unsigned char tunnelmap[];
extern unsigned char fortstiles[];
extern unsigned char fortsmap[];
extern unsigned char fortsinttiles[];
extern unsigned char fortsintmap[];



// Commmon stage processing vars
UINT8 stageidx; // For the stage arrays
UBYTE holeflg;  // Flag indicating if currently rendered area is a hole or a road
UINT8 stageclearflg, bossclearflg; // stage/boss completed flags
const Placement * lvlplacptr; // stage placement objects array pointer
const UINT8 lanesy[] = {98, 114, 130};
const UINT8 placmntxpos = 167;  // Initial x position of stage enemies


// Stages data
extern const UINT8 stage1road[], stage2road[], stage3road[], stage4road[], stage5road[], stage6road[];
extern const Placement stage1objs[], stage2objs[], stage3objs[], stage4objs[], stage5objs[], stage6objs[];
extern const UINT8 scorpbossexpl[5][2], jggrbossexpl[7][2], mechbossexpl[4][2], genrlbossexpl[5][2], defsysbossexpl[6][2], ultgenexplcrdsground[4][2], ultgenbossexpl[5][2], emittersexpl[5][2];
extern UINT8 jgrbkgposx, jgrposx;

const UINT8 pausesign[5] = {0x22, 0x13, 0x27, 0x25, 0x17};
const Stage stages[] = {{stage1road, 17, stage1objs, deserttiles, 39, desertmap, 0, 1, 2, &deserttheme},
{stage2road, 25, stage2objs, citytiles, 46, citymap, 1, 1, 2, &citytheme},
{stage3road, 27, stage3objs, mountaintiles, 61, mountainmap, 1, 1, 2, &mountaintheme},
{stage4road, 31, stage4objs, tunneltiles, 64, tunnelmap, 1, 0, 4, &tunneltheme}, // Temporarily using some assets from previous levels
{stage5road, 33, stage5objs, fortstiles, 104, fortsmap, 1, 0, 4, &tunneltheme},
{stage6road, 39, stage6objs, fortsinttiles, 67, fortsintmap, 0, 0, 4, &tunneltheme}
};
    const Stage * crntstage = stages;    // Current stage pointer
UINT8 stagenum;     // Current stage counter

INT8 bullspx = 0, bullspy = 0;

// Enemies order - 0 - rider, 1 - drone, 2 - rocket, 3 - turret, 4 - bomber, 5 - mine, 6 - laser turret, 7 - tri-turret, 8 - seeker, 9 - explosion/boss
const INT8 enprops[10][10] = {{1, 2, 0, 1, 13, 15, -3, 12, 0, 23},
{0, 1, 2, 5, 14, 7, 7, 13, 1, 27},
{1, 9, 2, 5, 13, 10, 1, 4, 2, 31},
{0, 100, 3, 2, 14, 12, 7, -4, 3, 35},
{0, 4, 0, 5, 13, 7, 4, 11, 4, 39},
{1, 20, 3, 2, 11, 11, 0, 0, 5, 43},
{1, 100, 0, 0, 15, 13, 6, 13, 6, 47},
{1, 100, 0, 0, 15, 5, 7, 7, 7, 51},
{1, 2, 0, 4, 15, 9, 0, 0, 8, 55},
{0, 0, 0, 0, 16, 16, 0, 0, 120, 120}
};

// Projectiles order - 0 - bullet, 1 - bigbullet, 2 - horizontal laser, 3 - bomb, 4 - plasma, 5 - vertical laser
const UINT8 projctlprops[6][4] = {{3, 3, 1, 17},
{4, 4, 2, 18},
{8, 3, 3, 19},
{8, 8, 4, 20},
{8, 8, 4, 21},
{3, 8, 3, 22}};

// Represents the screen, divided into 16x16px squares, each containing the slope
// between the player and enemy projectile
const UINT8 slopesidx[8][9] = {{8, 1, 1, 1, 1, 1, 1, 1, 1},
{8, 1, 4, 3, 2, 2, 2, 2, 2},
{8, 2, 1, 6, 4, 4, 3, 3, 3},
{8, 3, 1, 1, 8, 6, 6, 4, 4},
{8, 4, 2, 1, 1, 8, 7, 6, 6},
{8, 4, 2, 2, 1, 1, 8, 7, 7},
{8, 4, 3, 2, 1, 1, 1, 8, 8},
{8, 4, 3, 2, 2, 1, 1, 1, 9}};


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
const UINT8 lockedoamtiles = 4; // Number of locked tiles in the OAM (currently reserved for player tiles)
const unsigned char blanktile[] = {0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00};
Projectile projectiles[10]; // Array of all the projectiles
Projectile * crntpjct, * pjctptr; // Pointer to current position in projectile array / Pointer for loops
const UINT8 pjctllimit = 9; // Projectile array index limit(max projectiles on screen allowed - 1)
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
Machine * hitmchptr;   // Pointer to the enemy who was hit last. Used during boss fights for animations
Machine * fsten; // Pointer to the first enemy in the pool. Used extensively during bosses
UINT8 iframecnt;
UBYTE iframeflg;
UBYTE fallinholeflg;
UBYTE ascendflg; // Ascending or descending state during jump animation
const UINT8 jumplimity = 50; // Jumping vert distance limit
const UINT8 jumphalflimy = 25;
UINT8 jumpstarty;   // Player y position at start of jump
UINT8 holestartx, holeendx;    // Used to indicate start and end x position of road holes
UBYTE isapressed;  // Indicates that A is currently pressed
UINT8 chmutedcyccnt[] = {255, 255, 255, 255}; // Used to mute a sound channel for a number of cycles
INT8 fractdiv; // Precision factor for caluculating coordinates
INT8 slope;  // Used to calculate projectile trajectory when aimed at player
INT16 gradient;  // Used to calculate projectile trajectory when aimed at player
UINT8 hitanimtmr;  // Damage animation timer when boss is hit
UINT8 plgun, numkills;
UINT8 menuidx, gamemode, extrasflg;
UINT8 cycrulecheck; // Keeping track of cyles, used for optimization purposes
const UINT8 numkillsthresh[3] = {10, 20, 20};   // Number of kills required to get a gun upgrade and an extra life



UINT8 get_OAM_free_tile_idx() NONBANKED;
void custom_delay(UINT8 cycles) NONBANKED;
inline void incr_cycle_counter() NONBANKED;
void incr_oam_sprite_tile_idx(INT8 steps) NONBANKED;
void itr_enemies_ptr() NONBANKED;
inline void incr_projectile_counter() NONBANKED;
inline void itr_projectile_ptr() NONBANKED;
inline UBYTE found_free_projectile_space() NONBANKED;
inline UINT8 get_tile_idx(UINT8 newidxnum) NONBANKED;
void reset_sprites(UINT8 fstsprite, UINT8 lastsprite) NONBANKED;
void init_stage_bkg(UINT8 stnum) NONBANKED;
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
void incr_boss_bkg_x_coords(UINT8 roadsp, UINT8 jgrspeed) NONBANKED;
void scroll_stage_bkg_outd() NONBANKED;
void scroll_stage_bkg_ind() NONBANKED;
void scroll_boss_bkg() NONBANKED;
void disable_bkg_scroll(UINT8 stageidx) NONBANKED;
void build_stage() NONBANKED;
void build_road() NONBANKED;
void build_hole() NONBANKED;
void build_boss_road() NONBANKED;
void manage_hole_props();
void manage_projectiles() NONBANKED;
void manage_machines(UINT8 limit) NONBANKED;
void manage_sound_chnls() NONBANKED;
void manage_player() NONBANKED;
inline UINT8 get_horiz_dist(UINT8 fstobjx, UINT8 sndobjx) NONBANKED;
void set_projctl_comm_prop(Machine * mch, UINT8 type, INT8 speedx, INT8 speedy) NONBANKED;
void fire_projctl(Machine * mch, UINT8 type, INT8 speedx, INT8 speedy) NONBANKED;
void fire_projctl_aimed(Machine * mch, UINT8 type, INT8 speedxy) NONBANKED;
inline UBYTE is_obj_inside_screen(UINT8 x, UINT8 y, UINT8 width, UINT8 height) NONBANKED;
inline UBYTE is_alive(Machine * mch) NONBANKED;
void destroy_projectile(Projectile * pr) NONBANKED;
void move_projectile(Projectile * pr) NONBANKED;
void init_explosion(Machine * mch) NONBANKED;
void explode_machine(Machine * mch) NONBANKED;
Machine * create_explosion(UINT8 x, UINT8 y) NONBANKED;
void anim_explode_boss(const UINT8 explarr[][2], UINT8 numexpl, UINT8 hasscroll, UINT8 offsx, UINT8 offsy) NONBANKED;
void take_damage(Machine * mch, UINT8 dmgamt) NONBANKED;
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
void exec_laserturret_pattern(Machine * mch) BANKED;
void exec_triturret_pattern(Machine * mch) BANKED;
void exec_seeker_pattern(Machine * mch) BANKED;
UBYTE cooldown_enemy(Machine * mch, UINT8 period) NONBANKED;
void hud_init() NONBANKED;
void hud_upd_shield() NONBANKED;
inline void hud_upd_lives() NONBANKED;
void hud_clear_pause() NONBANKED;
inline void hud_draw_gun() NONBANKED;
void init_game() NONBANKED;
void init_stage(UINT8 stnum, UBYTE hasscroll) NONBANKED;
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
void unmute_all_channels() NONBANKED;
void se_fall_in_hole() NONBANKED;
void se_fire_bullet() NONBANKED;
void se_fire_laser() NONBANKED;
void se_drop_bomb() NONBANKED;
void se_fire_plasma() NONBANKED;
void se_explode() NONBANKED;
void se_get_hit() NONBANKED;
void se_jump() NONBANKED;
void se_pause() NONBANKED;
void se_wpn_upgrd() NONBANKED;
void se_charge_gun(UINT8 addfreq) NONBANKED;
void get_menu_pl_input(UINT8 * entries, UINT8 numentries) BANKED;
void init_common_menu_props() BANKED;
void main_menu() BANKED;
void stage_intro_screen(UINT8 stnum) BANKED;
void game_over_menu(UINT8 stnum) BANKED;
UINT8 password_menu() BANKED;
void play_stage() NONBANKED;
void play_boss() NONBANKED;
void init_boss(UINT8 stnum) NONBANKED;
void boss_loop(UINT8 stnum) NONBANKED;
void update_hit_anim_counter() NONBANKED;
void boss_clear_sequence(UINT8 stnum) NONBANKED;
void mech_clear_sequence() BANKED;
void mute_song() NONBANKED;
void unmute_song() NONBANKED;
void play_song(const hUGESong_t * song) NONBANKED;
void stop_song() NONBANKED;
void init_mechboss(UINT8 x, UINT8 y) BANKED;
void mechboss_loop() BANKED;
void init_jggrrboss() BANKED;
void jggrrboss_loop() BANKED;
void incr_boss_bkg_x_coords(UINT8 roadsp, UINT8 jgrspeed) NONBANKED;
void show_textbox(UINT8 dialidx) NONBANKED;
void disable_boss_bkg_scroll() BANKED;
void init_mechbrosboss() BANKED;
void mechbrosboss_loop() BANKED;
void destroy_mech(Machine * mech) BANKED;
void init_genrlboss() BANKED;
void genrlboss_loop() BANKED;
void genrl_clear_sequence() BANKED;
void init_defsysboss() BANKED;
void defsysboss_loop() BANKED;
void defsys_clear_sequence() BANKED;
void init_emitters_boss() BANKED;
void emitters_boss_loop() BANKED;
void init_ultgen_boss() BANKED;
void ultgen_boss_loop() BANKED;
void play_pre_encore_cutscene() BANKED;
void ending_sequence_prep() BANKED;
void ultgen_flash_sparks(INT8 coordsarr[][2], UINT8 arrlen) BANKED;
void anim_airbase_destr(UBYTE moveplflg) BANKED;
void scroll_textbox(UINT8 dialidx) BANKED;
void display_epilogue() BANKED;



UINT8 get_OAM_free_tile_idx() NONBANKED {
    for(UINT8 oami = 4; oami < 40; oami++) {
        if(shadow_OAM[oami].y == 0) {
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


inline void incr_cycle_counter() NONBANKED {
    cycrulecheck = cycrulecheck == 3 ? 0 : cycrulecheck + 1;
}


void incr_oam_sprite_tile_idx(INT8 steps) NONBANKED {
    UINT8 nextoamind = oamidx + steps;
    oamidx = nextoamind < 40 ? nextoamind : nextoamind - 40 + lockedoamtiles; // Out of bounds check and reset
    if(shadow_OAM[oamidx].y != 0) { // If next OAM struct used, loop to find a free one
        oamidx = get_OAM_free_tile_idx();
    }
}


void itr_enemies_ptr() NONBANKED {
    crntenemy = crntenemy == machines + enlimit ? machines + 1 : crntenemy + 1;
    if(crntenemy->y != 0) { // If next element is used, loop to find a free one
        for(i = 1; i != enlimit + 1; i++) {
            if((machines + i)->y == 0) {
                crntenemy = machines + i;
                break;
            }
        }
    }
}


inline void incr_projectile_counter() NONBANKED {
    prjcnt += prjcnt == pjctllimit + 1 ? 0 : 1;
}


inline void itr_projectile_ptr() NONBANKED {
    crntpjct = crntpjct == projectiles + pjctllimit ? projectiles : crntpjct + 1;
}


inline UBYTE found_free_projectile_space() NONBANKED {   // Checks if there is free space in memory to spawn a projectile
    return prjcnt != pjctllimit + 1 && oamidx != 180;
}


inline UINT8 get_tile_idx(UINT8 newidxnum) NONBANKED {   // Recalculate tile index according to the OAM tile limit
    return newidxnum > 31 ? newidxnum - 32 : newidxnum;
}


void reset_sprites(UINT8 fstsprite, UINT8 lastsprite) NONBANKED {
    for(i = fstsprite; i != lastsprite; i++) {
        set_sprite_tile(i, 0);
        set_sprite_prop(i, 0);
        move_sprite(i, 0, 0);
    }
    wait_vbl_done();
}


void init_stage_bkg(UINT8 stnum) NONBANKED {
    const Stage * stg = stages + stnum;
    SWITCH_ROM_MBC1(stg->stagebank);
    set_bkg_data(93, stg->bkgtilesnum, stg->bkgtiles);
    set_bkg_tiles(0, stnum == 2 && stageclearflg == 1 ? 4 : stg->hasclouds, 32, 10 - stg->hasclouds, stg->bkgmap);
    if(stg->hasclouds) {
        SWITCH_ROM_MBC1(2);
        set_bkg_data(52, 13, cloudtiles);
        set_bkg_tiles(0, 0, 32, 1, cloudmap);
        SWITCH_ROM_MBC1(stg->stagebank);
    }
}


void init_stage_road() NONBANKED { // Layout initial road tiles to start the stage
    prevbank = _current_bank;
    SWITCH_ROM_MBC1(2);
    set_bkg_data(65, 28, roadtiles);
    SWITCH_ROM_MBC1(prevbank);
    for(roadbuildidx = 0; roadbuildidx != 7; roadbuildidx++) {
        set_bkg_tiles(roadbuildidx * 3, 10, 3, 7, goodroadmap);
    }
    camtileidx = 18;
    nextcamtileidx = camtileidx + 3;
}


void set_machine_tile(Machine * mch, UINT8 tlnum) NONBANKED { // Sets all machine tiles to a specific tile from memory
    set_sprite_tile(mch->oamtilenums[0], tlnum);
    set_sprite_tile(mch->oamtilenums[1], tlnum);
    set_sprite_tile(mch->oamtilenums[2], tlnum);
    set_sprite_tile(mch->oamtilenums[3], tlnum);
}


void set_machine_sprite_tiles(Machine * mch, UINT8 fsttile) NONBANKED {
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


void init_player() NONBANKED {
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
    place_machine(pl, 248, lanesy[1]);
}


void respawn_player() {
    pl->shield = 4;
    pl->hboffx = 3;
    pl->hboffy = 1;
    ascendflg = 1;
    hud_upd_shield();
    if(fallinholeflg) {
        fallinholeflg = 0;
        pl->groundflg = 0;
        set_machine_sprite_tiles(pl, 13);
        place_machine(pl, 16, 64);
        lockmvmnt = 2;
        jumpstarty = lanesy[1];
    } else {
        pl->groundflg = 1;
        set_machine_sprite_tiles(pl, 1);
        place_machine(pl, 16, lanesy[1]);
        lockmvmnt = 0;
    }
    iframeflg = 1;
}


// ENEMIES INITIALIZATION


void init_machine_props(UINT8 x, UINT8 y, const INT8 * mchprops) NONBANKED {
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


inline UBYTE collides_with_sidewalk(INT8 vspeed) NONBANKED {
    return pl->y + vspeed < 96 || pl->y + vspeed > 127;
}


inline UBYTE is_inside_x_bounds(UINT8 posx) NONBANKED {
    return posx > 15 && posx < 141;
}


void move_machine(Machine * mch, INT8 speedx, INT8 speedy) NONBANKED {
    mch->x += speedx;
    mch->y += speedy;
    move_sprite(mch->oamtilenums[0], mch->x, mch->y);
    move_sprite(mch->oamtilenums[1], mch->x + 8, mch->y);
    move_sprite(mch->oamtilenums[2], mch->x, mch->y + 8);
    move_sprite(mch->oamtilenums[3], mch->x + 8, mch->y + 8);
}


void move_player(INT8 speedx, INT8 speedy) NONBANKED {
    if((speedx != 0 && is_inside_x_bounds(pl->x + speedx))
    || (speedy != 0 && !collides_with_sidewalk(speedy)) ) {
        move_machine(pl, speedx, speedy);
    }
}


void move_enemy(Machine * en, INT8 speedx, INT8 speedy) NONBANKED {
    move_machine(en, speedx, speedy);
    if(!is_obj_inside_screen(en->x, en->y, 16, 16)) {
        destroy_machine(en);
    }
}


void incr_bkg_x_coords(UINT8 roadsp) NONBANKED {
    __critical {
        cloudposx += roadsp - 3;
        sceneryposx += roadsp - 1;
        roadposx += roadsp;
    }
}


void incr_boss_bkg_x_coords(UINT8 roadsp, UINT8 jgrspeed) NONBANKED {
    __critical {
        cloudposx += roadsp - 3;
        jgrbkgposx += roadsp - 4 + jgrspeed;
        sceneryposx += roadsp - 1;
        roadposx += roadsp;
    }
}


void scroll_stage_bkg_outd() NONBANKED {
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


void scroll_stage_bkg_ind() NONBANKED {
    switch(LYC_REG) {
        case 0x00:
            move_bkg(sceneryposx, 0);
            LYC_REG = 0x50;
            break;
        case 0x50:
            move_bkg(roadposx, 0);
            LYC_REG = 0x00;
            break;
    }
}



void scroll_boss_bkg() NONBANKED {
    switch(LYC_REG) {
        case 0x00:
            move_bkg(cloudposx, 0);
            LYC_REG = 0x07;
            break;
        case 0x07:
            move_bkg(jgrbkgposx, 0);
            LYC_REG = 0x2F;
            break;
        case 0x2F:
            move_bkg(sceneryposx, 0);
            LYC_REG = 0x50;
            break;
        case 0x50:
            move_bkg(roadposx, 0);
            LYC_REG = 0x00;
            break;
    }
}


void disable_bkg_scroll(UINT8 stageidx) NONBANKED {
    __critical {
        cloudposx = sceneryposx = roadposx = 0;
        if(stages[stageidx].hasclouds) {
            scroll_stage_bkg_outd();
            remove_LCD(scroll_stage_bkg_outd);
        } else {
            scroll_stage_bkg_ind();
            remove_LCD(scroll_stage_bkg_ind);
        }
        disable_interrupts();
    }
}


void build_stage() NONBANKED {   // Automatically builds the road ahead while scrolling the stage
    camtileidx = get_tile_idx((SCX_REG + 168) / 8);
    if(camtileidx == nextcamtileidx) {
        if(holeflg) {
            build_hole();
        } else {
            build_road();
        }

        if(roadbuildidx == crntstage->roadlayout[stageidx]) {
            stageidx++; // Moving to next elem in stage array
            roadbuildidx = 0;
            holeflg = !holeflg; // Roads and holes alternate
        } else {
            roadbuildidx++;
        }

        // Placing objects inside stage
        if(lvlplacptr->arridx == stageidx && lvlplacptr->elemidx == roadbuildidx) {
            init_machine_props(placmntxpos, lvlplacptr->y, *(enprops + lvlplacptr->type));
            lvlplacptr++;
        }
    }

    if(stageidx == crntstage->roadlength) { // End of stage reached
        stageclearflg = 1;
    }
}


void build_road() NONBANKED {
    set_bkg_tiles(camtileidx, 10, 3, 7, goodroadmap);
    nextcamtileidx = get_tile_idx(camtileidx + 3);
}


void build_hole() NONBANKED {
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
 }


void build_boss_road() NONBANKED {
    camtileidx = get_tile_idx((SCX_REG + 168) / 8);
    if(camtileidx == nextcamtileidx) {
        build_road();
    }
 }


void manage_hole_props() NONBANKED {
    if(holestartx != 255 && holestartx > screenminx) { // Road hole has appeared
        holestartx -= roadscrspeed;
    }
    if (holeendx != 0) {  // Road hole end reached
        holeendx -= roadscrspeed;
    } else if(holeendx < screenminx) {
        holeendx = 0;   // Resetting hole end value
    }
 }


 void manage_projectiles() NONBANKED {
    for(pjctptr = projectiles; pjctptr <= projectiles + pjctllimit; pjctptr++) { // Projectiles handling
        if(pjctptr->oam != NULL) {
            move_projectile(pjctptr);
            if ((cycrulecheck == 3)) {  // Check for collision every othe cycle
                for(machptr = machines; machptr <= machines + enlimit; machptr++) {
                    if(is_alive(machptr)) {
                        if(pl == machptr && iframeflg) {
                            continue;   // Avoid hit during iframes
                        }
                        check_projectile_collsn(machptr, pjctptr); // Check collision for all machines on screen
                    }
                }
            }
        }
    }
 }


 void manage_machines(UINT8 limit) NONBANKED {
    for(machptr = machines; machptr <= machines + limit; machptr++) {    // Player and enemies handling
        if(machptr != pl && machptr->shield != 0) {
            if(!iframeflg && cycrulecheck == 1 && pl->explcount == 0 && pl->groundflg == machptr->groundflg) {    // Player hasn't exploded
                check_player_machine_collsn(machptr);
            }
            if(machptr->explcount == 0) {
                exec_enemy_pattern(machptr);
            }
        }
        if(machptr->explcount != 0) {
            explode_machine(machptr);
        }
    }
 }


void manage_sound_chnls() NONBANKED {
    for(i = 0; i < 4; i++) {
        if(chmutedcyccnt[i] != 255) {
            upd_mute_chnl_cycles(i);
        }
    }
}


 void manage_player() NONBANKED {
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
        if(abtncnt == 0 && lockmvmnt != 3) { // Check cooldown period before firing
            fire_projctl(pl, plgun, 2, 0);
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


inline UINT8 get_horiz_dist(UINT8 fstobjx, UINT8 sndobjx) NONBANKED { // Returns the distance between 2 objects on x axis
    return fstobjx > sndobjx ? fstobjx - sndobjx : sndobjx - fstobjx;
}


void set_projctl_comm_prop(Machine * mch, UINT8 type, INT8 speedx, INT8 speedy) NONBANKED {
    crntpjct->speedx = speedx;
    crntpjct->speedy = speedy;
    crntpjct->oam = (shadow_OAM + oamidx);
    crntpjct->oam->x = mch->x + mch->gunoffx;
    crntpjct->oam->y = mch->y + mch->gunoffy;
    crntpjct->width = projctlprops[type][0];
    crntpjct->height = projctlprops[type][1];
    crntpjct->damage = projctlprops[type][2];
    set_sprite_tile(oamidx, projctlprops[type][3]);
    if(crntpjct->aimedflg == 1) {   // Case for projectiles that should be aimed at the player
        fractdiv = 1;   // Default starting value
        if(crntpjct->oam->x > pl->x && crntpjct->oam->x < pl->x + pl->width) {  // Firing straight up/down
            crntpjct->aimedflg = 0; // The projectile's coordinates do not have to be calculated using the slope equation
        } else if(crntpjct->oam->y > pl->y && crntpjct->oam->y < pl->y + pl->height) { // Firing left/right
            crntpjct->aimedflg = 0;
            fractdiv = 10;  // Using value to indicate horizontal trajectory
        } else {
            INT8 hdistidx = (crntpjct->oam->x - pl->x) >> 4;    // Distance between projectile and player in 16x16px suares
            INT8 vdistidx = (crntpjct->oam->y - pl->y) >> 4;
            hdistidx = hdistidx < 0 ? -hdistidx : hdistidx;
            vdistidx = vdistidx < 0 ? -vdistidx : vdistidx;
            slope = slopesidx[vdistidx][hdistidx];  // Assign a slope using the square distances as indexes
            if(vdistidx < hdistidx) {   // Slopes in the array that match the condition are fractions between 0 - 1
                fractdiv = 10;  // Multiplying/Dividing by set amount to simulate fractions calculations without actually implementing them
            }
            if((pl->x < crntpjct->oam->x && pl->y > crntpjct->oam->y) || (pl->x > crntpjct->oam->x && pl->y < crntpjct->oam->y)) {
                slope = -slope; // Setting projectile direction based on it's location, compared to the player's
            }
            gradient = crntpjct->oam->y - ((slope * crntpjct->oam->x) / fractdiv );
        }
        if(fractdiv == 10) {    // Deciding wether x or y should be calculated or change at a constant rate
                crntpjct->speedx = pl->x > crntpjct->oam->x ? speedx : -speedx; // X will change at the rate of speedx on each cycle
                crntpjct->speedy = 0;   // Y coordinates will be calculated using the slope equation(See definition of move_projectile for more details)
            } else {
                crntpjct->speedy = pl->y > crntpjct->oam->y ? speedy : -speedy;
                crntpjct->speedx = 0;
        }
    }
    incr_oam_sprite_tile_idx(1);
    incr_projectile_counter();
    itr_projectile_ptr();
    switch(type) {
        case 0:
            se_fire_bullet();
            break;
        case 1:
            se_fire_bullet();
            break;
        case 2:
            se_fire_laser();
            break;
        case 3:
            se_drop_bomb();
            break;
        case 4:
            se_fire_plasma();
            break;
        case 5:
            se_fire_laser();
            break;
    }
}


void fire_projctl(Machine * mch, UINT8 type, INT8 speedx, INT8 speedy) NONBANKED {
    crntpjct->aimedflg = 0;
    set_projctl_comm_prop(mch, type, speedx, speedy);
}


void fire_projctl_aimed(Machine * mch, UINT8 type, INT8 speedxy) NONBANKED {
    crntpjct->aimedflg = 1;
    set_projctl_comm_prop(mch, type, speedxy, speedxy);
}


inline UBYTE is_obj_inside_screen(UINT8 x, UINT8 y, UINT8 width, UINT8 height) NONBANKED {
    return (x < screenmaxx && screenminx < x + width) &&
    (y < screenmaxy && screenminy < y + height);
}


inline UBYTE is_alive(Machine * mch) NONBANKED {
    return mch->shield > 0;
}


void destroy_projectile(Projectile * pr) NONBANKED {
    pr->oam->x = 0;
    pr->oam->y = 0;
    pr->oam->tile = 0;
    pr->oam = NULL;
    prjcnt--;
}


void init_explosion(Machine * mch) NONBANKED {
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


void move_projectile(Projectile * pr) NONBANKED {
    if(pr->oam != NULL && is_obj_inside_screen(pr->oam->x, pr->oam->y, pr->width, pr->height)) {
        if(pr->aimedflg == 0) {
            pr->oam->x += pr->speedx;
            pr->oam->y += pr->speedy;
        } else {
            pr->oam->x = pr->speedx == 0 ? (((pr->oam->y - gradient) * fractdiv) / slope) : pr->oam->x + pr->speedx;
            pr->oam->y = pr->speedy == 0 ? (((slope * pr->oam->x) / fractdiv) + gradient) : pr->oam->y + pr->speedy;
        }
    } else if(pr->oam != NULL) {
        destroy_projectile(pr);
    }
}


void explode_machine(Machine * mch) NONBANKED {
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


Machine * create_explosion(UINT8 x, UINT8 y) NONBANKED { // Used for animations
    Machine * explptr = crntenemy;
    init_machine_props(x, y, enprops[9]);
    init_explosion(explptr);
    return explptr;
}


void anim_explode_boss(const UINT8 explarr[][2], UINT8 numexpl, UINT8 hasscroll, UINT8 offsx, UINT8 offsy) NONBANKED {
    Machine * crntexpl;
    for(citr = 0; citr < numexpl; citr++) {
        crntexpl = create_explosion(offsx + explarr[citr][0], offsy + explarr[citr][1]);
        while(1) {
            if(hasscroll) {
                build_boss_road();
                incr_boss_bkg_x_coords(4, 0);
            }

            manage_machines(enlimit);
            wait_vbl_done();
            if(crntexpl->explcount == 0) {
                break;
            }
        }
    }
}


void destroy_machine(Machine * mch) NONBANKED {
    set_machine_tile(mch, 0);
    move_sprite(mch->oamtilenums[0], 0, 0);
    move_sprite(mch->oamtilenums[1], 0, 0);
    move_sprite(mch->oamtilenums[2], 0, 0);
    move_sprite(mch->oamtilenums[3], 0, 0);
    mch->explcount = mch->shield = mch->x = mch->y = 0;
}


void take_damage(Machine * mch, UINT8 dmgamt) NONBANKED {
    mch->shield -= dmgamt;
    if(pl == mch) {
        if(is_alive(pl)) {
            iframeflg = 1; // Starting iframe period
            if(plgun == 2) {
                plgun = 1;  // Reverting to second gun when less than full health
            }
        } else {    // Lost life
            lockmvmnt = 3;
            pllives--;
            pl->shield = plgun = numkills = 0;  // Back to regular gun on death
            hud_upd_lives();
        }
        hud_upd_shield();
        hud_draw_gun();
    }
    if(!is_alive(mch)) {
        if(mch != pl) {
            numkills++;
            if(numkills == numkillsthresh[plgun]) {
                plgun = pl->shield == 4 ? 2 : 1; // On 10 kills upgrade gun depending on health
                numkills = 0;
                hud_draw_gun();
                if(pllives != 9) {
                    pllives++;
                }
                hud_upd_lives();
                se_wpn_upgrd();
            }
        }
        init_explosion(mch);
    } else {
        if(mch->type == 9 && hitmchptr == NULL) {   // Initiate boss hit animation
            hitmchptr = mch;
        }
        se_get_hit();
    }
}


void check_iframes() NONBANKED {  // Animate blinking during iframe period
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


void check_projectile_collsn(Machine * mch, Projectile * prj) NONBANKED {
    if ((mch->x + mch->hboffx < prj->oam->x + prj->width && mch->y + mch->hboffy < prj->oam->y + prj->height) 
    && (prj->oam->x <  mch->x + mch->hboffx + mch->width && prj->oam->y <  mch->y + mch->hboffy + mch->height)) {
        take_damage(mch, prj->damage);
        destroy_projectile(prj);
    }
}


void check_player_machine_collsn(Machine * mch) NONBANKED {
    if ((mch->x + mch->hboffx < pl->x + pl->hboffx + pl->width && mch->y + mch->hboffy < pl->y + pl->hboffy + pl->height) 
    && (pl->x + pl->hboffx <  mch->x + mch->hboffx + mch->width && pl->y + pl->hboffy <  mch->y + mch->hboffy + mch->height)) {
        take_damage(pl, pl->shield);    // Take all health away
        if(mch->type != 9) {
            init_explosion(mch);
        }
    }
}


void anim_jump() NONBANKED {
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


void exec_enemy_pattern(Machine * mch) NONBANKED {
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
        case 6:
            exec_laserturret_pattern(mch);
            break;
        case 7:
            exec_triturret_pattern(mch);
            break;
        case 8:
            exec_seeker_pattern(mch);
            break;
    }
}


void exec_rider_pattern(Machine * mch) NONBANKED {
    if(mch->x > 130 && lockmvmnt != 2 && pl->y > 95) {
        move_enemy(mch, -1, pl->y > mch->y ? 1 : -1);
    } else if(mch->cyccount != 100) {
        if(mch->cyccount == 50) {
            fire_projctl(mch, 0, -2, 0);
        }
        mch->cyccount++;
    } else {
        move_enemy(mch, -1, 0);
    }
}


void exec_drone_pattern(Machine * mch) NONBANKED {
    if(mch->x % 16 == 0) {
        mch->cyccount = !mch->cyccount;
    }
    move_enemy(mch, -1, mch->cyccount == 0 ? 1 : -1);
    if(mch->x == 90 && mch->y < pl->y) {
        fire_projctl_aimed(mch, 0, 1);
    }
}


void exec_missile_pattern(Machine * mch) NONBANKED {
    if(mch->groundflg != pl->groundflg) {
        mch->groundflg = pl->groundflg;
    }
    move_enemy(mch, -2, 0);
}


void exec_turret_pattern(Machine * mch) NONBANKED {
    move_enemy(mch, -2, 0);
    if(mch->x == 87) {
        fire_projctl_aimed(mch, 1, 1);
    }
}


void exec_bomber_pattern(Machine * mch) NONBANKED {
    move_enemy(mch, -1, 0);
    if(pl->x > mch->x && pl->x < mch->x + 8 && mch->cyccount == 0) {
        fire_projctl(mch, 3, 0, 2);
        mch->cyccount = 1;  // Preventing from continuously dropping bombs
    }
}


void exec_mine_pattern(Machine * mch) NONBANKED {
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
    SWITCH_ROM_MBC1(1);
    set_bkg_data(9, 43, fonttiles);
    SWITCH_ROM_MBC1(2);
    set_win_data(0, 9, hudtiles);
    set_win_tiles(0, 0, 18, 1, hudmap);
    hud_upd_shield();
    hud_upd_lives();
    hud_draw_gun();
    SWITCH_ROM_MBC1(prevbank);
    move_win(15, 134);
    SHOW_WIN;
}


void hud_upd_shield() NONBANKED {
    if(pl->shield != 0) {
        fill_win_rect(3, 0, pl->shield, 1, 0x03);
    }
    if(pl->shield != 4) {
        fill_win_rect(3 + pl->shield, 0, 4 - pl->shield, 1, 0x04);
    }
}


inline void hud_upd_lives() {
    set_win_tile_xy(17, 0, pllives + 9);  // Tile offset 9
}


void hud_clear_pause() NONBANKED {
    set_win_tile_xy(8, 0, 0x00);
    set_win_tile_xy(9, 0, 0x01);
    set_win_tile_xy(11, 0, 0x02);
    set_win_tile_xy(12, 0, 0x00);
    hud_draw_gun();
    SHOW_SPRITES;
}

inline void hud_draw_gun() NONBANKED {
    set_win_tile_xy(10, 0, 6 + plgun); // Tile offset 6
}

// STAGE PROCESSING


void init_game() NONBANKED {
    plspeed = plgroundspeed;
    pllives = 3;
    pl = machines; // First element of the array is the player
    pl->shield = 4;
    plgun = 0;
    numkills = 0;
}


void init_stage(UINT8 stnum, UBYTE hasscroll) NONBANKED {
    roadposx = sceneryposx = cloudposx = iframeflg = 0;
    iframecnt = iframeflg = 0;
    oamidx = 0;
    prjcnt = abtncnt = 0;
    crntpjct = projectiles;
    crntenemy = machines + 1;
    ascendflg = 1;
    lockmvmnt = 0; // Allowing free movement
    holestartx = 255;
    holeendx = 0;
    isapressed = 0;
    cycrulecheck = 0;

    stageidx = holeflg = fallinholeflg = 0;
    lvlplacptr = (stages + stnum)->enlayout;

    roadbuildidx = 0; // Resetting the road index
    init_stage_bkg(stagenum);
    init_stage_road();

    if(hasscroll) {
        STAT_REG = 0x45;
        LYC_REG = 0x00;
        if(stagenum == 2 && stageclearflg == 1) {// Case for stage 3 boss
            add_LCD(scroll_boss_bkg);
        } else {
            if((stages + stnum)->hasclouds) {
                add_LCD(scroll_stage_bkg_outd);
            } else {
                add_LCD(scroll_stage_bkg_ind);
            }
        }
        enable_interrupts();
        set_interrupts(VBL_IFLAG | LCD_IFLAG);
    }

    set_sprite_data(0, 1, blanktile);
    SWITCH_ROM_MBC1(2);
    set_sprite_data(1, 16, playerspritetiles);
    set_sprite_data(17, 6, projectiletiles);
    set_sprite_data(23, 36, enemyspritetiles);
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
    SWITCH_ROM_MBC1((stages + stnum)->stagebank);
}


void stage_loop() NONBANKED {
    while(1) {

        if(stageclearflg || pllives == 0) {
            if(pl->explcount == 0) {    // Waiting for explosion to finish
                break;  // Out of game loop
            }
        }

        build_stage();
        incr_bkg_x_coords(4);
        incr_cycle_counter();
        manage_hole_props();
        manage_projectiles();
        manage_machines(enlimit);
        manage_sound_chnls();
        manage_player();
        wait_vbl_done();
    }
}


void pause_game() NONBANKED {
    if(stageclearflg == 0 || (stagenum != 0 && stagenum != 5 && stagenum != 6)) {
        HIDE_SPRITES;
    }
    stop_song();
    set_win_tiles(8, 0, 5, 1, pausesign);   // Drawing PAUSE
    se_pause();
    waitpadup();
    custom_delay(10);
    waitpad(J_START);
    custom_delay(10);
    waitpadup();
    hud_clear_pause();
    if(stageclearflg == 0) {
        play_song(crntstage->theme);
    } else if(stagenum < 4) {
        play_song(&bosstheme);
    } else {    // Add case for later bosses after tracks are done
        wait_vbl_done();
    }
}


// ANIMATIONS AND EFFECTS


void clear_all_projectiles() NONBANKED {
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


void anim_stage_end() NONBANKED {
    clear_all_projectiles();
    pl->cyccount = 0;
    while(1) {
        build_boss_road();
        incr_bkg_x_coords(5);
        if(lockmvmnt == 2) {    // Wait until the end of the jumping animation
            anim_jump();
        } else if(pl->x > 167 && pl->x < 200) {
            break;  // Animation has finished
        } else {
            move_machine(pl, 1, 0);
        }
        wait_vbl_done();
    }
}


void anim_blackout() NONBANKED {  // Used as a standalone call
    for(UINT8 blkstep = 0; blkstep != 21; blkstep++) {
        switch(blkstep) {
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
        wait_vbl_done();
    }
}


void anim_reverse_blackout() NONBANKED {  // Used as a standalone call
    for(UINT8 blkstep = 0; blkstep != 21; blkstep++) {
        switch(blkstep) {
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
        wait_vbl_done();
    }
}


// SOUND EFFECTS


void mute_music_pl_chnl(UINT8 chnum) NONBANKED {     // Mutes a music player channel during effects
    hUGE_mute_channel(chnum, HT_CH_MUTE);
    chmutedcyccnt[chnum] = _current_bank == 1 ? 1 : 15;  // Initiates countdown for mute period
}


void upd_mute_chnl_cycles(UINT8 chnum) NONBANKED {    // Checks if a muted channel needs to be unmuted
    if(chmutedcyccnt[chnum] != 0) {
        chmutedcyccnt[chnum]--;     // Countdown untul unmute
    } else {
        hUGE_mute_channel(chnum, HT_CH_PLAY);
        chmutedcyccnt[chnum] = 255;
    }
}


void unmute_all_channels() NONBANKED {
    for(i = 0; i < 4; i++) {
        hUGE_mute_channel(i, HT_CH_PLAY);
        chmutedcyccnt[i] = 255;
    }
    NR52_REG = 0x80; // Sound on
    NR51_REG = 0xFF; // All channels
    NR50_REG = 0x77; // Max level, left and right
}


void se_fall_in_hole() NONBANKED {
    mute_music_pl_chnl(0);
    NR10_REG = 0x1F;
    NR11_REG = 0x81;
    NR12_REG = 0xF7;
    NR13_REG = 0xF7;
    NR14_REG = 0x85;
}


void se_fire_bullet() NONBANKED {
    mute_music_pl_chnl(3);
    NR41_REG = 0x00;
    NR42_REG = 0xF4;
    NR43_REG = 0x52;
    NR44_REG = 0xC0;
}


void se_fire_laser() NONBANKED {
    mute_music_pl_chnl(0);
    NR10_REG = 0x2E;
    NR11_REG = 0xC1;
    NR12_REG = 0xF2;
    NR13_REG = 0x54;
    NR14_REG = 0x87;
}


void se_drop_bomb() NONBANKED {
    mute_music_pl_chnl(0);
    NR10_REG = 0x7F;
    NR11_REG = 0x81;
    NR12_REG = 0xF7;
    NR13_REG = 0x55;
    NR14_REG = 0x87;
}


void se_fire_plasma() NONBANKED {
    mute_music_pl_chnl(3);
    NR41_REG = 0x04;
    NR42_REG = 0xF5;
    NR43_REG = 0x4D;
    NR44_REG = 0x80;
}


void se_explode() NONBANKED {
    mute_music_pl_chnl(3);
    NR41_REG = 0x04;
    NR42_REG = 0xF5;
    NR43_REG = 0x55;
    NR44_REG = 0x80;
}


void se_get_hit() NONBANKED {
    mute_music_pl_chnl(1);
    NR21_REG = 0x40;
    NR22_REG = 0xF1;
    NR23_REG = 0xCD;
    NR24_REG = 0xC7;
}


void se_jump() NONBANKED {
    mute_music_pl_chnl(0);
    NR10_REG = 0x75;
    NR11_REG = 0x80;
    NR12_REG = 0xF2;
    NR13_REG = 0x46;
    NR14_REG = 0x85;
}


void se_pause() NONBANKED {
    NR10_REG = 0x74;
    NR11_REG = 0x80;
    NR12_REG = 0xF7;
    NR13_REG = 0x0E;
    NR14_REG = 0x86;
}


void se_wpn_upgrd() NONBANKED {
    mute_music_pl_chnl(0);
    NR10_REG = 0x17;
    NR11_REG = 0x7A;
    NR12_REG = 0xFF;
    NR13_REG = 0x75;
    NR14_REG = 0x85;
}


void se_charge_gun(UINT8 addfreq) NONBANKED {
    mute_music_pl_chnl(0);
    NR10_REG = 0x37;
    NR11_REG = 0x16;
    NR12_REG = 0xF7;
    NR13_REG = 50 + addfreq;
    NR14_REG = 0x84;
}


// STAGE/MENU LOADING



void play_stage() NONBANKED {
    init_stage(stagenum, 1);
    anim_stage_start();
    play_song(crntstage->theme);
    stage_loop();
    if(stageclearflg == 1) {
        anim_stage_end();
    }
    stop_song();    // Stop current stage music
    anim_blackout();
    HIDE_WIN;
    reset_sprites(0, 40);
    disable_bkg_scroll(stagenum);
}


// BOSSES


void init_boss(UINT8 stnum) NONBANKED {
    hitmchptr = NULL;
    fsten = machines + 1;
    hitanimtmr = 11;
    SWITCH_ROM_MBC1(3);
    set_sprite_data(23, 52, bossspritetiles);
    SWITCH_ROM_MBC1(0);
    switch(stnum) {
        case 0:
            init_scorpboss();
            break;
        case 1:
            init_mechboss(167, 64);
            break;
        case 2:
            init_jggrrboss();
            break;
        case 3:
            init_mechbrosboss();
            break;
        case 4:
            init_genrlboss();
            break;
        case 5:
            init_defsysboss();
            break;
        case 6:
            init_emitters_boss();
            break;
    }
}


void boss_loop(UINT8 stnum) NONBANKED {
    switch(stnum) {
        case 0:
            scorpboss_loop();
            break;
        case 1:
            mechboss_loop();
            break;
        case 2:
            jggrrboss_loop();
            break;
        case 3:
            mechbrosboss_loop();
            break;
        case 4:
            genrlboss_loop();
            break;
        case 5:
            defsysboss_loop();
            break;
        case 6:
            emitters_boss_loop();
            if(bossclearflg == 1) {
                bossclearflg = 0; // Resetting for phase 2
                SWITCH_ROM_MBC1(6);
                anim_explode_boss(emittersexpl, 5, 0, 0, 0);
                init_ultgen_boss();
                show_textbox(18);
                ultgen_boss_loop();
            }
            break;
    }
}


void update_hit_anim_counter() NONBANKED {
    if(hitanimtmr == 0) {
        hitmchptr = NULL;
        hitanimtmr = 11;
    }
    hitanimtmr--;
}


void boss_clear_sequence(UINT8 stnum) NONBANKED {
    if(stagenum < 3) {
        show_textbox((stagenum * 2) + bossclearflg);
    }
    switch(stnum) { // Unique boss clear animations
        case 0:
            SWITCH_ROM_MBC1(3);
            anim_explode_boss(scorpbossexpl, 5, 0, 0, 0);
            init_stage_road();
            break;
        case 1:
            mech_clear_sequence();
            break;
        case 2:
            SWITCH_ROM_MBC1(3);
            jgrposx -= jgrposx != 15 ? 40 : 0;  // Readjustment for explosion
            anim_explode_boss(jggrbossexpl, 7, 1, jgrposx, 24);
            fill_bkg_rect(20, 1, 17, 5, 0);
            break;
        case 3:
            show_textbox(fsten->oamtilenums[0] == 4 ? 13 : 14); // Show text depending on last standing mech
            SWITCH_ROM_MBC1(3);
            anim_explode_boss(mechbossexpl, 4, 1, hitmchptr->x, hitmchptr->y);
            destroy_mech(hitmchptr);
            break;
        case 4:
            SWITCH_ROM_MBC1(5);
            anim_explode_boss(genrlbossexpl, 5, 1, 124, 56);
            show_textbox(15);
            genrl_clear_sequence();
            show_textbox(16);
            break;
        case 5:
            SWITCH_ROM_MBC1(5);
            anim_explode_boss(defsysbossexpl, 6, 0, 0, 0);
            defsys_clear_sequence();
            show_textbox(17);
            break;
        case 6:
            show_textbox(19);
            ending_sequence_prep();
            show_textbox(20);
            SWITCH_ROM_MBC1(6);
            ultgen_flash_sparks(ultgenexplcrdsground, 4);
            anim_explode_boss(ultgenbossexpl, 5, 0, fsten->x, fsten->y);
            reset_sprites(8, 24);
            show_textbox(21);
            anim_airbase_destr(0);
    }
    
    if(stagenum != 6) {
        prevbank = _current_bank;
        SWITCH_ROM_MBC1(2);
        play_song(&cleartheme);
        for(citr = 0;  citr < 255; citr++) {    // Waiting for fanfare to finish playing
            if(crntstage->bossbkgscrolls) {
                build_boss_road();
                incr_bkg_x_coords(4);
            } else if(stagenum == 2) {
                build_boss_road();
                incr_boss_bkg_x_coords(4, 0);
            }
            manage_sound_chnls();
            wait_vbl_done();
        }
        SWITCH_ROM_MBC1(prevbank);
    }
}


void play_boss() NONBANKED {
    init_stage(stagenum, crntstage->bossbkgscrolls);
    init_boss(stagenum);
    SWITCH_ROM_MBC1(1);
    set_win_data(253, 3, misctiles);
    anim_stage_start();
    show_textbox((stagenum * 2) + bossclearflg);
    if(stagenum < 3) {
        SWITCH_ROM_MBC1(3);
        play_song(&bosstheme);
    } else {    // Add case for later bosses after tracks are done
        SWITCH_ROM_MBC1(5);
    }
    boss_loop(stagenum);
    if(bossclearflg == 1) {
        stop_song();
        unmute_all_channels();
        set_machine_sprite_tiles(pl, 1);    // Resetting player sprite in case of blinking during iframes
        boss_clear_sequence(stagenum);
    }
    anim_blackout();
    stop_song();
    HIDE_WIN;
    if(crntstage->bossbkgscrolls) { 
        if(stagenum == 2) {
            disable_boss_bkg_scroll();
        } else {
            disable_bkg_scroll(stagenum);
        }
    }
    reset_sprites(0, 40);
    move_bkg(0, 0);
}


void mute_song() NONBANKED {
    hUGE_mute_channel(HT_CH1, HT_CH_MUTE);
    hUGE_mute_channel(HT_CH2, HT_CH_MUTE);
    hUGE_mute_channel(HT_CH3, HT_CH_MUTE);
    hUGE_mute_channel(HT_CH4, HT_CH_MUTE);
}

void unmute_song() NONBANKED {
    hUGE_mute_channel(HT_CH1, HT_CH_PLAY);
    hUGE_mute_channel(HT_CH2, HT_CH_PLAY);
    hUGE_mute_channel(HT_CH3, HT_CH_PLAY);
    hUGE_mute_channel(HT_CH4, HT_CH_PLAY);
}


void play_song(const hUGESong_t * song) NONBANKED {
    __critical {
        hUGE_init(song);
        add_VBL(hUGE_dosound);
    }
}


void stop_song() NONBANKED {
    mute_song();
    remove_VBL(hUGE_dosound);
}


void show_textbox(UINT8 dialidx) NONBANKED {
    scroll_textbox(dialidx);
    hud_init();
}


void main() NONBANKED {

    DISPLAY_ON;
    SHOW_BKG;
    SHOW_SPRITES;
    unmute_all_channels();
    anim_blackout();
    gamemode = extrasflg = 0;
    stagenum = 0;
    while(1) {
        main_menu();
        if(menuidx == 1) {
            stagenum = password_menu();
            if(stagenum == 6) {
                wait_vbl_done();    // TODO: Menu to choose route (bad/good endings)
            }
            if(stagenum == 7) { // Unlock extras menu
                extrasflg = 1;
                stagenum = 0;
                continue;
            }
        } /*else if(extrasflg && menuidx == 2) { // Under construction
            extras_menu();
        }*/
        crntstage = stages + stagenum;
        init_game();
        stageclearflg = bossclearflg = 0;

        while(1) {  // Game loop
            unmute_all_channels();
            if(pllives == 0) {
                game_over_menu(stagenum);
                if(menuidx == 0) {  // Chosen continue
                    init_game();
                } else {    // Chosen quit
                    stagenum = 0;
                    crntstage = stages;
                    break;
                }
            } else if(stageclearflg == 0) {
                stage_intro_screen(stagenum);
                if(stagenum != 6) {
                    play_stage();
                } else {
                    init_stage(5, 1);
                    play_pre_encore_cutscene();
                    stageclearflg = 1;
                }
            } else if(bossclearflg == 0) {
                play_boss();
            } else {    // Current stage and boss both cleared
                stagenum++;
                crntstage++;    // Next stage data
                stageclearflg = bossclearflg = 0;
                if(stagenum == 7) { // Has passed currently available levels
                    for(UINT8 areaidx = 5; areaidx != 2; areaidx--) {   // Ending sequence
                        reset_sprites(0, 40);
                        init_stage(5, 1);
                        init_stage_bkg(areaidx);
                        HIDE_WIN;
                        anim_reverse_blackout();
                        anim_airbase_destr(1);
                        disable_bkg_scroll(areaidx);
                        anim_blackout();
                    }
                    SWITCH_ROM_MBC1(1);
                    set_bkg_data(1, 43, fonttiles);
                    display_epilogue();
                }
            }
        }
    }
}

