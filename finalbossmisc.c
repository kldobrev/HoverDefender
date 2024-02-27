#include <gb/gb.h>
#include "machine.c"
#include "tiles/encoretiles1.c"
#include "tiles/encoretiles2.c"
#include "tiles/finalbossspritetiles.c"
#include "maps/encorebossbkgmap.c"
#include "maps/encorebossmap.c"
#include "maps/encorepremap.c"


const INT8 encoreemitterprops[] = {0, 9, -3, 0, 20, 9, 0, 0, 9, 23};
const INT8 encoreprops[] = {0, 120, -5, -20, 40, 50, -64, -35, 9, 25};  // HP = 30

extern UINT8 cloudposx, sceneryposx, roadposx, i;
extern Machine machines[], * pl;


void init_machine_props(UINT8 x, UINT8 y, const INT8 * mchprops) NONBANKED;
void set_machine_tile(Machine * mch, UINT8 tlnum) NONBANKED;
void incr_oam_sprite_tile_idx(INT8 steps) NONBANKED;
void anim_reverse_blackout() NONBANKED;
void anim_stage_end() NONBANKED;
void anim_blackout() NONBANKED;
void scroll_stage_bkg_ind() NONBANKED;
void move_machine(Machine * mch, INT8 speedx, INT8 speedy) NONBANKED;
void toggle_mute_music(UINT8 toggleon) NONBANKED;



void play_pre_encore_cutscene() BANKED {
    toggle_mute_music(1);
    set_bkg_data(74, 64, encoretiles1);
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
    set_bkg_data(74, 64, encoretiles1);
    set_bkg_data(138, 100, encoretiles2);
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
    anim_reverse_blackout();
}
