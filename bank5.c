#include <gb/gb.h>
#include "machine.c"
#include "placement.c"


extern Machine machines[], * crntenemy, * pl, * hitmchptr;
extern UINT8 pllives, bossclearflg, lockmvmnt, oamidx, i, citr, cloudposx, sceneryposx, roadposx, stagenum, hitanimtmr, ascendflg, plgroundspeed, cyccount;
extern UBYTE iframeflg;
extern const UINT8 enlimit;

const INT8 genrlprops[] = {0, 25, 2, 1, 28, 22, 0, 16, 9, 54};
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
const UINT8 setelprtvol[6] = {0x0F, 0x2F, 0x4F, 0x6F, 0x8F, 0xAF};
const UINT8 teleprfrlength = 4;

Machine * frstmch;


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
void genrl_hit_anim() BANKED;
void set_genrl_tiles(UINT8 tileidx) BANKED;
void se_teleport(UINT8 vol) BANKED;
void position_genrl_tiles(UINT8 tileidx) BANKED;
void move_genrl_to_pos(UINT8 x, UINT8 y) BANKED;
UINT8 teleport_genrl(INT8 telanimdir, UINT8 telfridx) BANKED;
void init_genrlboss() BANKED;
void genrl_hit_anim() BANKED;
void set_currnt_genrl_gun(UINT8 gunidx) BANKED;
void genrlboss_loop() BANKED;
void genrl_clear_sequence() BANKED;




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
        move_sprite(9, frstmch->x + 12, frstmch->y + 8);
    } else if(teleprfridx == 4) {
        move_sprite(4, frstmch->x + 8, frstmch->y + 4);
        move_sprite(5, frstmch->x + 16, frstmch->y + 4);
        set_sprite_prop(5, 32);
        move_sprite(9, frstmch->x + 8, frstmch->y + 12);
        set_sprite_prop(9, 64);
        move_sprite(13, frstmch->x + 16, frstmch->y + 12);
        set_sprite_prop(13, 96);
    } else if(teleprfridx == 3) {
        move_sprite(4, frstmch->x + 8, frstmch->y);
        move_sprite(5, frstmch->x + 16, frstmch->y);
        move_sprite(9, frstmch->x + 8, frstmch->y + 16);
        move_sprite(13, frstmch->x + 16, frstmch->y + 16);
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
        move_sprite(14, frstmch->x + 12, frstmch->y + 21);
    }
}


void move_genrl_to_pos(UINT8 x, UINT8 y) BANKED {
    frstmch->x = x;
    frstmch->y = y;
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
    if(frstmch->cyccount == teleprfrlength) {
        position_genrl_tiles(telfridx);
        set_genrl_tiles(telfridx);
        frstmch->cyccount = 0;
        se_teleport(telfridx);
        if(telfridx == 0) {
            if(telanimdir == 1) {  // Granting invincibility during fade out animation
                frstmch->hboffx = -crntenemy->x;
                frstmch->hboffy = -crntenemy->y;
                frstmch->width = crntenemy->height = 0;
            } else {    // Removing invinvibility during fade in animation end
                frstmch->hboffx = genrlprops[2];
                frstmch->hboffy = genrlprops[3];
                frstmch->width = genrlprops[4];
                frstmch->height = genrlprops[5];
            }
        }
        return telfridx + telanimdir;
    } else {
        frstmch->cyccount++;
        return telfridx;
    }
}


void init_genrlboss() BANKED {
    frstmch = machines + 1;
    init_machine_props(32, 32, genrlprops);
    set_machine_tile(frstmch, 0);
    incr_oam_sprite_tile_idx(7);
    for(i = 10; i != 14; i++) {
        set_sprite_prop(i, 32);
    }
}


void genrl_hit_anim() BANKED {
    set_genrl_tiles(hitanimtmr == 10 ? 7 : 0);
}


void set_currnt_genrl_gun(UINT8 gunidx) BANKED {   // 0 - top left, 1 - bottom left, 2 - top right, 3 - bottom right
    frstmch->gunoffx = genrlgunsoffs[gunidx][0];
    frstmch->gunoffy = genrlgunsoffs[gunidx][1];
}


void genrlboss_loop() BANKED {
    UINT8 telpranimidx = 255, pattrn = 0, firecount = 0;
    INT8 teleportdir = 0;
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
            } else if(pattrn == 1 && cooldown_enemy(frstmch, 25)) {
                set_currnt_genrl_gun(1);
                fire_projctl(frstmch, 4, -gunspgenpttrn1[firecount][0], gunspgenpttrn1[firecount][1]);
                set_currnt_genrl_gun(3);
                fire_projctl(frstmch, 4, gunspgenpttrn1[firecount][0], gunspgenpttrn1[firecount][1]);
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
                if(firecount == 0 && cooldown_enemy(frstmch, 35)) {
                    set_currnt_genrl_gun(pl->x < frstmch->x + 32 ? 2 : 3);
                    fire_projctl_aimed(frstmch, 4, 3);
                    firecount = 1;
                } else if(firecount == 1 && cooldown_enemy(frstmch, 35)) {
                    set_currnt_genrl_gun(2);
                    fire_projctl(frstmch, 4, 3, -1);
                    fire_projctl(frstmch, 4, 3, 0);
                    fire_projctl(frstmch, 4, 3, 1);
                    firecount = 2;
                } else if(firecount == 2 && cooldown_enemy(frstmch, 35)) {
                    fire_projctl(frstmch, 4, 3, -2);
                    fire_projctl(frstmch, 4, 3, 2);
                    firecount = 3;
                } else if(firecount == 3 && cooldown_enemy(frstmch, 35)) {
                    firecount = 0;
                    teleportdir = 1;
                    pattrn = 4;
                }
            } else if(pattrn == 4) {
                move_genrl_to_pos(124, 56);
                teleportdir = -1;
                pattrn = 5;
            } else if(pattrn == 5) {
                if((firecount == 0 || firecount == 2) && cooldown_enemy(frstmch, 35)) {
                    set_currnt_genrl_gun(0);
                    fire_projctl_aimed(frstmch, 4, 3);
                    firecount++;
                } else if(firecount == 1 && cooldown_enemy(frstmch, 35)) {
                    fire_projctl(frstmch, 4, -3, -2);
                    fire_projctl(frstmch, 4, -3, 0);
                    fire_projctl(frstmch, 4, -3, 2);
                    firecount = 2;
                } else if(firecount == 3 && cooldown_enemy(frstmch, 35)) {
                    fire_projctl(frstmch, 4, -3, -1);
                    fire_projctl(frstmch, 4, -3, 1);
                    firecount = 4;
                } else if(firecount == 4 && cooldown_enemy(frstmch, 35)) {
                    teleportdir = 1;
                    firecount = 0;
                    pattrn = 0;
                }
            }
        }

        if(frstmch->shield < 6 && is_alive(pl)) { // Boss HP = 20 regular hits
            if(lockmvmnt == 2) {    // Wait until the end of the jumping animation
                anim_jump();
            } else if(pl->explcount == 0) {
                bossclearflg = 1;
                hitanimtmr = 0;
                frstmch->cyccount = 0;
                check_boss_damaged();   // Making sure mech sprite is reset to normal before ending sequence
                clear_all_projectiles();
                return;  // Boss cleared
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
        check_boss_damaged();
        manage_sound_chnls();
        manage_player();
        wait_vbl_done();
    }
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


