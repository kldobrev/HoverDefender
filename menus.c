#include <gb/gb.h>
#include "tiles/misctiles.c"
#include "tiles/titlelogotiles.c"
#include "tiles/fonttiles.c"
#include "maps/titlelogomap.c"
#include "hUGEDriver.h"


extern const hUGESong_t titletheme;
extern const hUGESong_t gameovertheme;
extern const unsigned char blanktile[];
extern UINT8 menuidx;
extern const UINT8 stnamelengths[];
extern const unsigned char stagenames[][18];

// Global scope/menus vars
const UINT8 gameoveropts[] = {96, 112};


void custom_delay(UINT8 cycles) NONBANKED;
void anim_reverse_blackout() NONBANKED;
void play_song(const hUGESong_t * song, UINT8 songbank) NONBANKED;
void stop_song() NONBANKED;
void anim_blackout() NONBANKED;
void se_choose_entry() BANKED;
void se_move_cursor() BANKED;
void mute_music_pl_chnl(UINT8 chnum) NONBANKED;
void init_common_menu_props() BANKED;
void main_menu() BANKED;
void get_menu_pl_input(UINT8 * entries, UINT8 numentries) BANKED;
void stage_intro_screen(UINT8 stnum) BANKED;
void game_over_menu() BANKED;
void demo_end_screen() BANKED;
void password_menu() BANKED;
void init_game() NONBANKED;
void clear_all_sprites() NONBANKED;



void init_common_menu_props() BANKED {
    set_bkg_data(0, 1, blanktile);
    set_bkg_data(1, 41, fonttiles);
    fill_bkg_rect(0, 0, 32, 18, 0x00);
    set_sprite_data(0, 1, misctiles);
    set_sprite_tile(0, 0);
}


void main_menu() BANKED {
    init_common_menu_props();
    const unsigned char pressstartsign[] = {0x1A, 0x1C, 0x0F, 0x1D, 0x1D, 0x00, 0x00, 0x1D, 0x1E, 0x0B, 0x1C, 0x1E};   // DEMO CODE
    set_bkg_data(33, 78, titlelogotiles);
    set_bkg_tiles(2, 1,  16, 6, titlelogomap);
    anim_reverse_blackout();
    play_song(&titletheme, 1);
    set_bkg_tiles(4, 11, 12, 1, pressstartsign);
    waitpad(J_START);   // DEMO CODE
    stop_song();   // DEMO CODE
    se_choose_entry();   // DEMO CODE
    anim_blackout();
}


void get_menu_pl_input(UINT8 * entries, UINT8 numentries) BANKED {
    menuidx = 0; // First option set be default
    while(1) {
        if(joypad() & (J_DOWN | J_SELECT)) {
            menuidx = menuidx + 1 == numentries ? 0 : menuidx + 1;
            move_sprite(0, shadow_OAM[0].x, entries[menuidx]);
            se_move_cursor();
        } else if(joypad() & J_UP) {
            menuidx = menuidx == 0 ? numentries - 1 : menuidx - 1;
            move_sprite(0, shadow_OAM[0].x, entries[menuidx]);
            se_move_cursor();
        } else if(joypad() & (J_START | J_A)) {
            stop_song();
            se_choose_entry();
            break;  // Player has made a choice
        }
        custom_delay(7);
    }
}


void stage_intro_screen(UINT8 stnum) BANKED {
    init_common_menu_props();
    const unsigned char stagesign[] = {0x1D, 0x1E, 0x0B, 0x11, 0x0F};
    set_bkg_tiles(6, 4, 5, 1, stagesign);
    set_bkg_tile_xy(12, 4, stnum + 2);
    set_bkg_tiles((20 - stnamelengths[stnum]) / 2, 7, stnamelengths[stnum], 1, *(stagenames + stnum));
    anim_reverse_blackout();
    custom_delay(70);
    anim_blackout();
}


void game_over_menu() BANKED {
    init_common_menu_props();
    const unsigned char gmoversign[] = {0x11, 0x0B, 0x17, 0x0F, 0x00, 0x019, 0x20, 0x0F, 0x1C};
    const unsigned char contsign[] = {0x0D, 0x19, 0x18, 0x1E, 0x13, 0x18, 0x1F, 0x0F};
    const unsigned char quitsign[] = {0x1B, 0x1F, 0x13, 0x1E};
    const unsigned char gopasssign[] = {0x1A, 0x0B, 0x1D, 0x1D, 0x21, 0x19, 0x1C, 0x0E, 0x25};
    const unsigned char dummypass[] = {0x28, 0x28, 0x28, 0x28};
    set_bkg_tiles(5, 4, 9, 1, gmoversign);
    set_bkg_tiles(7, 10, 8, 1, contsign);
    set_bkg_tiles(7, 12, 4, 1, quitsign);
    //set_bkg_tiles(3, 16, 9, 1, gopasssign);
    //set_bkg_tiles(13, 16, 4, 1, dummypass);
    move_sprite(0, 52, 96);
    play_song(&gameovertheme, 1);
    anim_reverse_blackout();
    get_menu_pl_input(gameoveropts, 2);
    if(menuidx == 0) {
        init_game();
    }
    clear_all_sprites();
    anim_blackout();
}


void demo_end_screen() BANKED {    // DEMO CODE
    init_common_menu_props();
    unsigned char tnx1sign[] = {0x1E, 0x12, 0x0B, 0x18, 0x15, 0x00, 0x23, 0x19, 0x1F, 0x00, 0x10, 0x19, 0x1C};
    unsigned char tnx2sign[] =  {0x1A, 0x16, 0x0B, 0x23, 0x13, 0x18, 0x11, 0x27};
    unsigned char tnx3sign[] = {0x17, 0x19, 0x1C, 0x0F, 0x00, 0x1C, 0x19, 0x0B, 0x0E, 0x00, 0x0B, 0x0D, 0x1E, 0x13, 0x19, 0x18};
    unsigned char tnx4sign[] = {0x0D, 0x19, 0x17, 0x13, 0x18, 0x11, 0x00, 0x1D, 0x19, 0x19, 0x18, 0x27};
    set_bkg_tiles(3, 3, 13, 1, tnx1sign);
    set_bkg_tiles(6, 5, 8, 1, tnx2sign);
    set_bkg_tiles(2, 11, 16, 1, tnx3sign);
    set_bkg_tiles(4, 13, 12, 1, tnx4sign);
    anim_reverse_blackout();
    waitpad(J_START);
    anim_blackout();
}


void se_move_cursor() BANKED {
    mute_music_pl_chnl(0);
    NR10_REG = 0x00;
    NR11_REG = 0xCB;
    NR12_REG = 0x63;
    NR13_REG = 0x9F;
    NR14_REG = 0x86;
}


void se_choose_entry() BANKED {
    mute_music_pl_chnl(0);
    NR10_REG = 0x64;
    NR11_REG = 0x88;
    NR12_REG = 0xF3;
    NR13_REG = 0x3E;
    NR14_REG = 0x86;
}

void password_menu() {
    // UNDER CONSTRUCTION
}