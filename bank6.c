#include <gb/gb.h>
#include "machine.c"
#include "tiles/encoretiles1.c"
#include "tiles/encoretiles2.c"
#include "tiles/finalbossspritetiles.c"
#include "maps/encorebossbkgmap.c"
#include "maps/encorebossmap.c"
#include "maps/encorebossnobarriermap.c"
#include "maps/encorepremap.c"


extern Machine machines[], * crntenemy, * pl, * hitmchptr;
extern UINT8 pllives, bossclearflg, lockmvmnt, oamidx, i, citr, cloudposx, sceneryposx, roadposx, stagenum, hitanimtmr, ascendflg, plgroundspeed, cyccount;
extern UBYTE iframeflg;
extern const UINT8 enlimit;
extern const unsigned char goodroadmap[];


const INT8 encoreemitterprops[] = {0, 10, -3, 0, 20, 9, 0, 0, 9, 23};
const INT8 encoreprops[] =   {0, 40, -5, -28, 40, 72, -64, -35, 9, 25};  // HP = 30
const INT8 arcptrnshotspeeds[8][2] = {{-3, 1}, {-3, 2}, {-2, 3}, {-1, 3}, {0, 3}, {1, 3}, {3, 3}, {4, 3}};


void check_boss_damaged() NONBANKED;
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
void incr_oam_sprite_tile_idx(INT8 steps) NONBANKED;
void move_machine(Machine * mch, INT8 speedx, INT8 speedy) NONBANKED;
void incr_bkg_x_coords(UINT8 roadsp) NONBANKED;
void build_boss_road() NONBANKED;
void se_charge_gun(UINT8 addfreq) NONBANKED;
void se_explode() NONBANKED;
void incr_boss_bkg_x_coords(UINT8 roadsp, UINT8 jgrspeed) NONBANKED;
void scroll_boss_bkg() NONBANKED;
Machine * create_explosion(UINT8 x, UINT8 y) NONBANKED;
void mute_music_pl_chnl(UINT8 chnum) NONBANKED;
void init_stage_road() NONBANKED;
void anim_reverse_blackout() NONBANKED;
void anim_blackout() NONBANKED;
void anim_stage_end() NONBANKED;
void scroll_stage_bkg_ind() NONBANKED;
void disable_bkg_scroll() NONBANKED;
void play_pre_encore_cutscene() BANKED;
void final_boss_hit_anim() BANKED;
void emitter_hit_anim() BANKED;
void final_boss_loops() BANKED;
void encore_boss_loop() BANKED;


// COMMON BOSS FUNCTIONS

void preserve_boss_health(Machine * boss) {
    if(boss->shield < 10) {
        boss->shield = 100; // Simulate invincibility by resetting health
    }
}


void check_encore_boss_bkg_collision() {
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
    STAT_REG = 0x45;
    LYC_REG = 0x00;
    add_LCD(scroll_stage_bkg_ind);    
    enable_interrupts();
    set_interrupts(VBL_IFLAG | LCD_IFLAG);
    set_bkg_data(41, 64, encoretiles1);
    for(i = 0; i != 32; i += 8) {
        set_bkg_tiles(i, 0, 8, 10, encorepremap);
    }
    anim_reverse_blackout();
    anim_stage_end();
    anim_blackout();
    cloudposx = sceneryposx = roadposx = 0;
    scroll_stage_bkg_ind();
    remove_LCD(scroll_stage_bkg_ind);
    move_machine(pl, 80, 0);
}


void final_boss_hit_anim() BANKED {
    if(hitmchptr->oamtilenums[0] == 8 || hitmchptr->oamtilenums[0] == 12) {
        emitter_hit_anim();
    }
}

void init_encore_boss() BANKED {
    set_bkg_data(41, 64, encoretiles1);
    set_bkg_data(105, 98, encoretiles2);
    set_bkg_tiles(0, 0, 14, 17, encorebossbkgmap);
    set_bkg_tiles(14, 0, 6, 17, encorebossmap);
    //set_bkg_tiles(14, 6, 6, 7, encorebossnobarriermap); //Phase 2
    set_sprite_data(23, 42, finalbossspritetiles);
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
    set_sprite_tile(hitmchptr->oamtilenums[0], hitanimtmr == 10 ? 24 : 23);
}


void final_boss_loops() {   // In progress
    encore_boss_loop();
}


void encore_boss_loop() BANKED {
    UINT8 pattrn = 0, pattrnrep = 0, nextgun = 0;
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
                check_boss_damaged();
                clear_all_projectiles();
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
        preserve_boss_health(machines + 1);
        manage_projectiles();
        manage_machines(3);
        check_boss_damaged();
        manage_sound_chnls();
        manage_player();
        wait_vbl_done();
    }
}


