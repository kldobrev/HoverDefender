#include <gb/gb.h>
#include "machine.c"
#include "tiles/defsysbosstiles.c"
#include "maps/defsysbossmap.c"
#include "maps/defsysbossdoorholemap.c"
#include "maps/defsysbossceilgunmap.c"
#include "hUGEDriver.h"


extern const hUGESong_t bossairbtheme;
extern Machine machines[], * crntenemy, * pl, * hitmchptr, * fsten;
extern UINT8 pllives, bossclearflg, lockmvmnt, oamidx, i, citr, cloudposx, sceneryposx, roadposx, stagenum, hitanimtmr, ascendflg, plgroundspeed, cyccount;
extern UBYTE iframeflg;
extern const UINT8 enlimit;
extern const unsigned char goodroadmap[];

const UINT8 mechforwtiles[] = {29, 31, 30, 32, 33, 34};
const UINT8 mechbackwtiles[] = {31, 29, 32, 30, 34, 33};
const INT8 backhboffx = -10, fronthboffx = 16;
const INT8 mechbossexpl[4][2] = {{-2, -1}, {4, 12}, {-2, 10}, {6, -2}};
UINT8 chargeindx = 255;    // Charge sprite tile index

const INT8 genrlprops[] = {0, 26, 2, 1, 28, 22, 0, 16, 9, 54};
const INT8 defsysprops[] = {1, 24, 0, 0, 16, 8, 0, 0, 9, 71};
const UINT8 genrltilemaps[8][11] = {
    {54, 55, 56, 57, 58, 59, 56, 57, 58, 59, 60},
    {54, 55, 69, 0, 58, 59, 69, 0, 58, 59, 0},
    {68, 68, 69, 0, 58, 68, 69, 0, 58, 68, 0},
    {68, 68, 69, 0, 70, 68, 69, 0, 70, 68, 0},
    {68, 68, 0, 0, 0, 68, 0, 0, 0, 68, 0},
    {0, 0, 0, 0, 0, 70, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {62, 63, 64, 65, 66, 67, 64, 65, 66, 67, 61}
};
const INT8 genrlgunsoffs[4][2] = {{-8, 19}, {-1, 23}, {34, 19}, {29, 23}};
const UINT8 gunspgenpttrn1[6][2] = {{3, 1}, {2, 1}, {2, 2}, {2, 3}, {1, 3}, {0, 3}};
const UINT8 genrlbossexpl[5][2] = {{0, 8}, {4, 16}, {16, 12}, {24, 8}, {12, 4}};
const UINT8 defsysbossexpl[6][2] = {{142, 86}, {152, 115}, {144, 96}, {137, 102}, {150, 95}, {147, 108}};
const UINT8 setelprtvol[6] = {0x0F, 0x2F, 0x4F, 0x6F, 0x8F, 0xAF};
const UINT8 teleprfrlength = 4;
const INT8 defsysgunoffs[4][2] = {{-66, -25}, {-8, 1}, {-26, 29}, {-10, 46}};


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
void init_stage(UBYTE hasscenery, UBYTE hasscroll) NONBANKED;
void incr_oam_sprite_tile_idx(INT8 steps) NONBANKED;
void move_machine(Machine * mch, INT8 speedx, INT8 speedy) NONBANKED;
void incr_bkg_x_coords(UINT8 roadsp) NONBANKED;
void build_boss_road() NONBANKED;
void se_explode() NONBANKED;
void incr_boss_bkg_x_coords(UINT8 roadsp, UINT8 jgrspeed) NONBANKED;
void scroll_boss_bkg() NONBANKED;
Machine * create_explosion(UINT8 x, UINT8 y) NONBANKED;
void mute_music_pl_chnl(UINT8 chnum) NONBANKED;
void init_stage_road() NONBANKED;
void set_machine_sprite_tiles(Machine * mch, UINT8 fsttile) NONBANKED;
void anim_reverse_blackout() NONBANKED;
void mute_music_pl_chnl(UINT8 chnum) NONBANKED;
void toggle_mute_music(UINT8 toggleon) NONBANKED;
void destroy_mech(Machine * mech) BANKED;
UINT8 explode_mech(Machine * mch, Machine ** prevexpl, UINT8 explleft) BANKED;
void move_active_mech(Machine * mech, INT8 x, INT8 y) BANKED;
UINT8 fire_charged_aimed_shot(Machine * mech, UINT8 initnum, UINT8 crntpatnum) BANKED;
void stop_charging() BANKED;
UINT8 exec_limited_pattern(UINT8 crntptrn) BANKED;
UINT8 exec_mechbros_pattern(Machine * mech1, Machine * mech2, UINT8 ptrnnum) BANKED;
void readjust_position(Machine * mech) BANKED;
void mechbrosboss_loop() BANKED;
void se_charge_mech_gun(UINT8 addfreq) BANKED;
void set_currnt_gun(UINT8 gunidx, const INT8 gunsoffs[][2]) BANKED;
void set_genrl_tiles(UINT8 tileidx) BANKED;
void se_teleport(UINT8 vol) BANKED;
void position_genrl_tiles(UINT8 tileidx) BANKED;
void move_genrl_to_pos(UINT8 x, UINT8 y) BANKED;
UINT8 teleport_genrl(INT8 telanimdir, UINT8 telfridx) BANKED;
void init_genrlboss() BANKED;
void genrl_hit_anim() BANKED;
void genrlboss_loop() BANKED;
void genrl_clear_sequence() BANKED;
void init_defsysboss() BANKED;
void defsys_hit_anim() BANKED;
void defsys_fire_gun(UINT8 gunnum, UINT8 prjctltype, INT8 spx) BANKED;
void defsysboss_loop() BANKED;
void defsys_clear_sequence() BANKED;
void init_boss_airbase_theme() BANKED;



// COMMON BOSS FUNCTIONS

void set_currnt_gun(UINT8 gunidx, const INT8 gunsoffs[][2]) BANKED {   // Simulating multiple guns for a single boss
    fsten->gunoffx = gunsoffs[gunidx][0];
    fsten->gunoffy = gunsoffs[gunidx][1];
}


void init_boss_airbase_theme() BANKED {
    hUGE_init(&bossairbtheme);
}


// BOSS 4 FUNCTIONS


void move_mech(Machine * mech, INT8 x, INT8 y) BANKED {
    move_machine(mech, x, y);
    move_sprite(mech->oamtilenums[3] + 1, mech->x, mech->y + 16);
    move_sprite(mech->oamtilenums[3] + 2, mech->x + 8, mech->y + 16);
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
        chargeindx = oamidx;
        set_sprite_tile(oamidx, 41 + phase);
        set_sprite_prop(oamidx, get_sprite_prop(mch->oamtilenums[0]));
        move_sprite(oamidx, mch->x + mch->gunoffx, mch->y + mch->gunoffy);
        se_charge_mech_gun(0);
        incr_oam_sprite_tile_idx(1);
    } else if(phase < 3) {
        set_sprite_tile(chargeindx, 41 + phase);
        se_charge_mech_gun(phase * 100);
    } else {
        set_sprite_tile(chargeindx, 0);
        set_sprite_prop(chargeindx, 0);
        move_sprite(chargeindx, 0, 0);
    }
}


void mech_hit_anim() BANKED {
    UINT8 sprdir = get_sprite_prop(hitmchptr->oamtilenums[0]);
    const UINT8 * mechtiles = sprdir == 32 ? mechbackwtiles : mechforwtiles;
    for(i = 0; i < 6; i++) {
        set_sprite_tile(hitmchptr->oamtilenums[0] + i, hitanimtmr == 0 ? (hitmchptr->oamtilenums[0] == 4 ? mechtiles[i] : mechtiles[i] + 19) : mechtiles[i] + 6);
    }
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
        fire_projctl_aimed(mech, 3, 4);
        return crntpatnum + 1;
    }
    return crntpatnum;
}


void stop_charging() BANKED {
    if(shadow_OAM[chargeindx].y != 0) {
        move_sprite(chargeindx, 0, 0);
    }
}


UINT8 exec_limited_pattern(UINT8 crntptrn) BANKED {
    if(crntptrn > 39 && crntptrn < 45) {
        return fire_charged_aimed_shot(fsten, 40, crntptrn);
    } else if(crntptrn == 45) {    // Start of patterns for 1 mech standing
        move_active_mech(fsten, 4, -4);
        if(fsten->x == 56 && fsten->y == 24) {
            return 46;
        }
    } else if(crntptrn == 46) {
        move_active_mech(fsten, 4, 0);
        if(fsten->x == 84) {
            flip_mech(fsten);
            return 47;
        }
    } else if(crntptrn == 47 && cooldown_enemy(fsten, 10)) {
        fire_projctl(fsten, 1, -2, 3);
        return 48;
    } else if(crntptrn == 48 && cooldown_enemy(fsten, 10)) {
        fire_projctl(fsten, 1, -1, 3);
        flip_mech(fsten);
        return 49;
    } else if(crntptrn == 49 && cooldown_enemy(fsten, 10)) {
        fire_projctl(fsten, 1, 1, 3);
        return 50;
    } else if(crntptrn == 50 && cooldown_enemy(fsten, 10)) {
        fire_projctl(fsten, 1, 2, 3);
        flip_mech(fsten);
        return 51;
    } else if(crntptrn == 51) {
        move_active_mech(fsten, 4, 0);
        if(fsten->x == 104) {
            return 52;
        }
    } else if(crntptrn == 52) {
        move_active_mech(fsten, 4, 4);
        if(fsten->x == 144 && fsten->y == 64) {
            return 53;
        }
    } else if(crntptrn > 52 && crntptrn < 58) {
        return fire_charged_aimed_shot(fsten, 53, crntptrn);
    } else if(crntptrn == 58) {
        move_active_mech(fsten, -4, -4);
        if(fsten->x == 104 && fsten->y == 24) {
            return 59;
        }
    } else if(crntptrn == 59) {
        move_active_mech(fsten, -4, 0);
        if(fsten->x == 84) {
            flip_mech(fsten);
            return 60;
        }
    } else if(crntptrn == 60 && cooldown_enemy(fsten, 10)) {
        fire_projctl(fsten, 1, 2, 3);
        flip_mech(fsten);
        return 61;
    } else if(crntptrn == 61 && cooldown_enemy(fsten, 10)) {
        fire_projctl(fsten, 1, 0, 3);
        return 62;
    } else if(crntptrn == 62 && cooldown_enemy(fsten, 10)) {
        fire_projctl(fsten, 1, -2, 3);
        return 63;
    } else if(crntptrn == 63) {
        move_active_mech(fsten, -4, 0);
        if(fsten->x == 56) {
            flip_mech(fsten);
            return 64;
        }
    } else if(crntptrn == 64) {
        move_active_mech(fsten, -4, 4);
        if(fsten->x == 16 && fsten->y == 64) {
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

    Machine * fstprevexpl = fsten, * sndprevexpl = sndmch;
    init_boss_airbase_theme();
    toggle_mute_music(0);
    while(1) {

        build_boss_road();
        incr_bkg_x_coords(4);
        incr_cycle_counter();

        if((!is_alive(pl)) && pl->explcount == 0) {
            break;  // Game over
        }

        if(fstexplcnt == 255 || sndexplcnt == 255) {    // At least 1 mech is destroyed
            if(pattrn == 35) {
                if(fsten->shield < 36) {
                    fsten = sndmch;    // Mech 1 has been destroyed
                }
                fsten->cyccount = 0;   // Resetting cycle if mech is stuck in  a cooldown period
                pattrn = 63;  // Switching patterns for 1 active mech
            }
            
            if(fsten->shield < 36) {
                if(lockmvmnt == 2) {    // Wait until the end of the jumping animation
                    anim_jump();
                } else if(pl->explcount == 0) {
                    stop_charging();
                    bossclearflg = 1;
                    hitanimtmr = 0;
                    if(hitmchptr != NULL) {
                        mech_hit_anim();
                        update_hit_anim_counter();   // Making sure mech sprite is reset to normal before ending sequence
                    }
                    hitmchptr = fsten; // Used to refer to the correct mech during explosion
                    clear_all_projectiles();
                    set_machine_sprite_tiles(pl, 1);
                    break;
                }
            }
        }

        if(fsten->shield < 36 && fstexplcnt != 255) {    // Explode mech 1
            fstexplcnt = explode_mech(fsten, &fstprevexpl, fstexplcnt);
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
                if(get_sprite_prop(fsten->oamtilenums[0]) == 0) {
                    flip_mech(fsten);
                }
                pattrn = 35;
            }
            if(pattrn == 35) {
                readjust_position(fsten);
            }
        }

        if(pattrn < 35) {   // Patterns for both mechs active
            if(sndmch->x == 16) {
                swappattrns = 1;
            } else if(fsten->x == 16) {
                swappattrns = 0;
            }

            if(swappattrns == 0) {
                pattrn = exec_mechbros_pattern(fsten, sndmch, pattrn);
            } else {
                pattrn = exec_mechbros_pattern(sndmch, fsten, pattrn);
            }
        } else {
            pattrn = exec_limited_pattern(pattrn);
        }

        manage_projectiles();
        manage_machines(enlimit);
        if(hitmchptr != NULL) {
            mech_hit_anim();
            update_hit_anim_counter();
        }
        hUGE_dosound();
        manage_sound_chnls();
        manage_player();
        wait_vbl_done();
    }
    toggle_mute_music(1);
}


void se_charge_mech_gun(UINT8 addfreq) BANKED {
    mute_music_pl_chnl(0);
    NR10_REG = 0x37;
    NR11_REG = 0x16;
    NR12_REG = 0xF7;
    NR13_REG = 50 + addfreq;
    NR14_REG = 0x84;
}


// BOSS 5 FUNCTIONS

void set_genrl_tiles(UINT8 tileidx) BANKED {
    for(i = 0; i != 11; i++) {
        set_sprite_tile(4 + i, genrltilemaps[tileidx][i]);
    }
}


void se_teleport(UINT8 vol) BANKED {
    mute_music_pl_chnl(3);
    NR41_REG = 0x30;
    NR42_REG = setelprtvol[vol];
    NR43_REG = 0x10;
    NR44_REG = 0xC0;
}


void position_genrl_tiles(UINT8 teleprfridx) BANKED {
    if(teleprfridx == 5) {
        move_sprite(9, fsten->x + 12, fsten->y + 8);
    } else if(teleprfridx == 4) {
        move_sprite(4, fsten->x + 8, fsten->y + 4);
        move_sprite(5, fsten->x + 16, fsten->y + 4);
        set_sprite_prop(5, 32);
        move_sprite(9, fsten->x + 8, fsten->y + 12);
        set_sprite_prop(9, 64);
        move_sprite(13, fsten->x + 16, fsten->y + 12);
        set_sprite_prop(13, 96);
    } else if(teleprfridx == 3) {
        move_sprite(4, fsten->x + 8, fsten->y);
        move_sprite(5, fsten->x + 16, fsten->y);
        move_sprite(9, fsten->x + 8, fsten->y + 16);
        move_sprite(13, fsten->x + 16, fsten->y + 16);
        set_sprite_prop(10, 32);
        set_sprite_prop(12, 32);
    } else if(teleprfridx == 2) {
        set_sprite_prop(5, 32);
        set_sprite_prop(9, 64);
        set_sprite_prop(13, 96);
    } else if(teleprfridx == 1) {
        set_sprite_prop(5, 0);
        set_sprite_prop(9, 0);
        set_sprite_prop(13, 32);
    } else if(teleprfridx == 0) {
        move_sprite(14, fsten->x + 12, fsten->y + 21);
    }
}


void move_genrl_to_pos(UINT8 x, UINT8 y) BANKED {
    fsten->x = x;
    fsten->y = y;
    move_sprite(4, x + 8, y);
    move_sprite(5, x + 16, y);
    move_sprite(6, x, y + 8);
    move_sprite(7, x, y + 16);
    move_sprite(8, x + 8, y + 8);
    move_sprite(9, x + 8, y + 16);
    move_sprite(10, x + 24, y + 8);
    move_sprite(11, x + 24, y + 16);
    move_sprite(12, x + 16, y + 8);
    move_sprite(13, x + 16, y + 16);
    move_sprite(14, x + 12, y + 21);
}


UINT8 teleport_genrl(INT8 telanimdir, UINT8 telfridx) BANKED {   // telanimdir is 1 for fading out and -1 for fading in
    if(telfridx > 6) {
        return 255;     // Indicating the end of the teleportation animation
    }
    if(fsten->cyccount == teleprfrlength) {
        position_genrl_tiles(telfridx);
        set_genrl_tiles(telfridx);
        fsten->cyccount = 0;
        se_teleport(telfridx);
        if(telfridx == 0) {
            if(telanimdir == 1) {  // Granting invincibility during fade out animation
                fsten->hboffx = -crntenemy->x;
                fsten->hboffy = -crntenemy->y;
                fsten->width = crntenemy->height = 0;
            } else {    // Removing invinvibility during fade in animation end
                fsten->hboffx = genrlprops[2];
                fsten->hboffy = genrlprops[3];
                fsten->width = genrlprops[4];
                fsten->height = genrlprops[5];
            }
        }
        return telfridx + telanimdir;
    } else {
        fsten->cyccount++;
        return telfridx;
    }
}


void init_genrlboss() BANKED {
    init_machine_props(32, 32, genrlprops);
    set_machine_tile(fsten, 0);
    incr_oam_sprite_tile_idx(7);
    for(i = 10; i != 14; i++) {
        set_sprite_prop(i, 32);
    }

    UINT8 telpranimidx = 6;
    move_genrl_to_pos(72, 32);
    anim_reverse_blackout();
    while(telpranimidx != 255) {    // Intro
        telpranimidx = teleport_genrl(-1, telpranimidx);
        manage_machines(1);
        manage_sound_chnls();
        wait_vbl_done();
    }
}


void genrl_hit_anim() BANKED {
    set_genrl_tiles(hitanimtmr == 0 ? 0 : 7);
}


void genrlboss_loop() BANKED {
    UINT8 telpranimidx = 255, pattrn = 1, firecount = 0;
    INT8 teleportdir = 0;
    init_boss_airbase_theme();
    toggle_mute_music(0);
    while(1) {

        build_boss_road();
        incr_bkg_x_coords(4);
        incr_cycle_counter();

        if((!is_alive(pl)) && pl->explcount == 0) {
            break;  // Game over
        }

        if(telpranimidx == 255) {   // No teleportation is happening
            if(pattrn == 0) {
                move_genrl_to_pos(72, 32);
                teleportdir = -1;   // Fade in
                pattrn = 1;
            } else if(pattrn == 1 && cooldown_enemy(fsten, 25)) {
                set_currnt_gun(1, genrlgunsoffs);
                fire_projctl(fsten, 3, -gunspgenpttrn1[firecount][0], gunspgenpttrn1[firecount][1]);
                set_currnt_gun(3, genrlgunsoffs);
                fire_projctl(fsten, 3, gunspgenpttrn1[firecount][0], gunspgenpttrn1[firecount][1]);
                firecount++;
                if(firecount == 6) {
                    firecount = 0;
                    teleportdir = 1;    // Fade out
                    pattrn = 2;
                }
            } else if(pattrn == 2) {
                move_genrl_to_pos(20, 56);
                teleportdir = -1;
                pattrn = 3;
            } else if(pattrn ==  3) {
                if(firecount == 0 && cooldown_enemy(fsten, 35)) {
                    set_currnt_gun(pl->x < fsten->x + 32 ? 2 : 3, genrlgunsoffs);
                    fire_projctl_aimed(fsten, 3, 3);
                    firecount = 1;
                } else if(firecount == 1 && cooldown_enemy(fsten, 35)) {
                    set_currnt_gun(2, genrlgunsoffs);
                    fire_projctl(fsten, 3, 3, -1);
                    fire_projctl(fsten, 3, 3, 0);
                    fire_projctl(fsten, 3, 3, 1);
                    firecount = 2;
                } else if(firecount == 2 && cooldown_enemy(fsten, 35)) {
                    fire_projctl(fsten, 3, 3, -2);
                    fire_projctl(fsten, 3, 3, 2);
                    firecount = 3;
                } else if(firecount == 3 && cooldown_enemy(fsten, 35)) {
                    firecount = 0;
                    teleportdir = 1;
                    pattrn = 4;
                }
            } else if(pattrn == 4) {
                move_genrl_to_pos(124, 56);
                teleportdir = -1;
                pattrn = 5;
            } else if(pattrn == 5) {
                if((firecount == 0 || firecount == 2) && cooldown_enemy(fsten, 35)) {
                    set_currnt_gun(0, genrlgunsoffs);
                    fire_projctl_aimed(fsten, 3, 3);
                    firecount++;
                } else if(firecount == 1 && cooldown_enemy(fsten, 35)) {
                    fire_projctl(fsten, 3, -3, -2);
                    fire_projctl(fsten, 3, -3, 0);
                    fire_projctl(fsten, 3, -3, 2);
                    firecount = 2;
                } else if(firecount == 3 && cooldown_enemy(fsten, 35)) {
                    fire_projctl(fsten, 3, -3, -1);
                    fire_projctl(fsten, 3, -3, 1);
                    firecount = 4;
                } else if(firecount == 4 && cooldown_enemy(fsten, 35)) {
                    teleportdir = 1;
                    firecount = 0;
                    pattrn = 0;
                }
            }
        }

        if(fsten->shield < 6 && is_alive(pl)) { // Boss HP = 20 regular hits
            if(lockmvmnt == 2) {    // Wait until the end of the jumping animation
                anim_jump();
            } else if(pl->explcount == 0) {
                bossclearflg = 1;
                hitanimtmr = 0;
                fsten->cyccount = 0;
                if(hitmchptr != NULL) {
                    genrl_hit_anim();
                    update_hit_anim_counter();   // Making sure mech sprite is reset to normal before ending sequence
                }
                clear_all_projectiles();
                set_machine_sprite_tiles(pl, 1);
                break;  // Boss cleared
            }
        }

        if(teleportdir != 0 && telpranimidx == 255) {
            if(teleportdir == 1) {
                telpranimidx = 0;
            } else {
                telpranimidx = 6;
            }
        } else if(telpranimidx != 255) {
            telpranimidx = teleport_genrl(teleportdir, telpranimidx);
            if(telpranimidx == 255) {    // Ending teleport animation
                teleportdir = 0;
            }
        }

        manage_projectiles();
        manage_machines(1);
        if(hitmchptr != NULL) {
            genrl_hit_anim();
            update_hit_anim_counter();
        }
        hUGE_dosound();
        manage_sound_chnls();
        manage_player();
        wait_vbl_done();
    }
    toggle_mute_music(1);
}


void genrl_clear_sequence() BANKED {
    UINT8 telpranimidx = 0;
    while(telpranimidx != 255) {
        build_boss_road();
        incr_bkg_x_coords(4);
        telpranimidx = teleport_genrl(1, telpranimidx);
        manage_machines(1);
        manage_sound_chnls();
        wait_vbl_done();
    }
}


// BOSS 6 FUNCTIONS

void init_defsysboss() BANKED {
    set_bkg_data(161, 55, defsysbosstiles);
    move_bkg(128, 0);
    fill_bkg_rect(21, 0, 9, 1, 95);
    fill_bkg_rect(21, 1, 9, 1, 96);
    fill_bkg_rect(25, 2, 8, 8, 94);
    set_bkg_tile_xy(25, 2, 115);
    set_bkg_tile_xy(26, 2, 116);
    set_bkg_tile_xy(27, 2, 117);
    for(i = 16; i != 34; i +=3) {
        set_bkg_tiles(i, 10, 3, 7, goodroadmap);
    }
    set_bkg_tiles(0, 0, 4, 16, defsysbossmap);
    set_bkg_tiles(25, 3, 3, 2, defsysbossceilgunmap);
    fill_bkg_rect(16, 10, 16, 1, 215);
    init_machine_props(154, 80, defsysprops);
    set_machine_tile(fsten, 0);
    set_sprite_tile(4, defsysprops[9]);
    anim_reverse_blackout();
}


void defsys_hit_anim() BANKED {
    set_sprite_tile(4, hitanimtmr == 0 ? 71 : 72);
}


void defsys_fire_gun(UINT8 gunnum, UINT8 prjctltype, INT8 spx) BANKED {
    set_currnt_gun(gunnum, defsysgunoffs);
    fire_projctl(fsten, prjctltype, spx, 0);
}


void defsysboss_loop() BANKED {
    
    UINT8 pattrn = 0, pattrnrep = 0, nextgun = 0;
    init_boss_airbase_theme();
    toggle_mute_music(0);
    while(1) {

        if((!is_alive(pl)) && pl->explcount == 0) {
            break;  // Game over
        }

        if(pl->explcount == 0 && !iframeflg && ((pl->x + pl->width + pl->hboffx > 136 && pl->y < 114) ||
            pl->x + pl->width + pl->hboffx > 154)) {
                take_damage(pl, pl->shield);    // Collision with boss bkg
        }

        if(fsten->shield < 1 && is_alive(pl) && fsten->explcount == 0) {
            if(lockmvmnt == 2) {    // Wait until the end of the jumping animation
                anim_jump();
            } else if(pl->explcount == 0) {
                bossclearflg = 1;
                hitanimtmr = 0;
                if(hitmchptr != NULL) {
                    defsys_hit_anim();
                    update_hit_anim_counter();
                }
                clear_all_projectiles();
                set_machine_sprite_tiles(pl, 1);
                break;  // Boss cleared
            }
        }

        if(pattrn == 0 && cooldown_enemy(fsten, 40)) {
            pattrn++;
        } else if(pattrn == 1) {
            if(cooldown_enemy(fsten, 18)) {
                defsys_fire_gun(1, 1, -4);
                set_currnt_gun(3, defsysgunoffs);
            }
            if(cooldown_enemy(fsten + 1, 25)) {
                nextgun = nextgun != 2 ? 2 : 3;
                defsys_fire_gun(nextgun, 2, -3);
                pattrnrep++;
                if(pattrnrep == 12) {
                    pattrnrep = nextgun = 0;
                    pattrn++;
                }
            }
        } else if(pattrn == 2 && cooldown_enemy(fsten, 65)) {
            set_currnt_gun(0, defsysgunoffs);
            fire_projctl(fsten, 3, -3, 2);
            fire_projctl(fsten, 3, -1, 3);
            fire_projctl(fsten, 3, 2, 3);
            pattrn++;
        } else if(pattrn == 3 && cooldown_enemy(fsten, 40)) {
            pattrn++;
        } else if(pattrn == 4) {
            if(fsten->cyccount == 36) {
                defsys_fire_gun(2, 2, -3);
                defsys_fire_gun(3, 2, -3);
            }
            if(cooldown_enemy(fsten, 50)) {
                defsys_fire_gun(1, 1, -3);
                pattrnrep++;
            }
            if(pattrnrep == 4) {
                pattrnrep = 0;
                pattrn++;
            }
        } else if(pattrn == 5 && cooldown_enemy(fsten, 40)) {
            set_currnt_gun(0, defsysgunoffs);
            fire_projctl(fsten, 3, -3, 3);
            fire_projctl(fsten, 3, 0, 3);
            fire_projctl(fsten, 3, 2, 3);
            pattrn = 0;
        }

        incr_cycle_counter();
        manage_projectiles();
        manage_machines(1);
        if(hitmchptr != NULL) {
            defsys_hit_anim();
            update_hit_anim_counter();
        }
        hUGE_dosound();
        manage_sound_chnls();
        manage_player();
        wait_vbl_done();
    }
    toggle_mute_music(1);
}


void defsys_clear_sequence() BANKED {
    set_bkg_tiles(0, 10, 4, 5, defsysbossdoorholemap);
}
