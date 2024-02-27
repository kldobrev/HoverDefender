#include <gb/gb.h>
#include "tiles/misctiles.c"
#include "tiles/titlelogotiles.c"
#include "tiles/fonttiles.c"
#include "tiles/passwscreentiles.c"
#include "tiles/overworldmaptiles.c"
#include "tiles/mapframetiles.c"
#include "tiles/airbasemaptiles.c"
#include "tiles/medaltiles.c"
#include "maps/titlelogomap.c"
#include "maps/passwscreenmap.c"
#include "maps/overworldmap.c"
#include "maps/airbasemap.c"
#include "hUGEDriver.h"



extern const hUGESong_t titletheme;
extern const hUGESong_t gameovertheme;
extern const unsigned char blanktile[];
extern UINT8 menuidx, i, citr, stagenum, extrasflg, bossrushflg, defaultplgun, stageclearflg, pllives;
const unsigned char stagenames[][18] = {{0x0E, 0x0F, 0x1D, 0x0F, 0x1C, 0x1E, 0x00, 0x12, 0x13, 0x11, 0x12, 0x21, 0x0B, 0x23},
{0x0D, 0x0B, 0x1A, 0x1E, 0x13, 0x20, 0x0F, 0x00, 0x0D, 0x13, 0x1E, 0x23}, 
{0x17, 0x19, 0x1F, 0x18, 0x1E, 0x0B, 0x13, 0x18, 0x00, 0x1A, 0x0B, 0x1D, 0x1D},
{0x1D, 0x15, 0x23, 0x00, 0x1E, 0x1F, 0x18, 0x18, 0x0F, 0x16}, 
{0x10, 0x19, 0x1C, 0x1E, 0x00, 0x1D, 0x1E, 0x1C, 0x0B, 0x1E, 0x19, 0x1D},
{0x1F, 0x18, 0x0E, 0x0F, 0x1C, 0x11, 0x1C, 0x19, 0x1F, 0x18, 0x0E, 0x00, 0x12, 0x0B, 0x16, 0x16, 0x1D}, 
{0x0F, 0x18, 0x0F, 0x1C, 0x11, 0x23, 0x00, 0x0D, 0x19, 0x1C, 0x0F}};
const UINT8 stnamelengths[] = {14, 12, 13, 10, 12, 17, 11};



// Global scope/menus vars
const UINT8 gameoveroptsy[] = {96, 112};
const UINT8 mainoptsy[] = {88, 104, 120};
const UINT8 passconfoptsx[] = {19, 83};
const UINT8 extrasoptsy[] = {48, 64, 112, 128, 144};
const UINT8 passconfy = 128, blinkanimdur = 21;
const UINT8 wrongpassind = 99;  // Incorrect password indicator
const UINT8 introscrdurr = 200;
const UINT8 passwords[][4] = {{11, 12, 13, 14}, {30, 11, 27, 23}, {33, 16, 24, 13}, {15, 25, 21, 28}, 
{28, 32, 13, 36}, {32, 20, 14, 35}, {18, 33, 21, 27}, {0x1F, 0x1C, 0x1E, 0x12}};
const UINT8 mapcrsrcoords[7][2] = {{23, 115}, {76, 76}, {127, 106}, {17, 86}, {54, 84}, {71, 93}, {93, 95}};
const unsigned char gamestsign[] = {0x1D, 0x1E, 0x0B, 0x1C, 0x1E, 0x00, 0x11, 0x0B, 0x17, 0x0F};
const unsigned char passwsign[] = {0x1A, 0x0B, 0x1D, 0x1D, 0x21, 0x19, 0x1C, 0x0E};
const unsigned char creatorsign[] = {0x03, 0x01, 0x03, 0x05, 0x00, 0x15, 0x18, 0x1D, 0x00, 0x0E, 0x19, 0x0C, 0x1C, 0x0F, 0x20};
const unsigned char stagesign[] = {0x1D, 0x1E, 0x0B, 0x11, 0x0F};
const unsigned char gmoversign[] = {0x11, 0x0B, 0x17, 0x0F, 0x00, 0x019, 0x20, 0x0F, 0x1C};
const unsigned char contsign[] = {0x0D, 0x19, 0x18, 0x1E, 0x13, 0x18, 0x1F, 0x0F};
const unsigned char quitsign[] = {0x1B, 0x1F, 0x13, 0x1E};
const unsigned char gopasssign[] = {0x1A, 0x0B, 0x1D, 0x1D, 0x21, 0x19, 0x1C, 0x0E, 0x25};
const unsigned char extrassign[] = {0x0F, 0x22, 0x1E, 0x1C, 0x0B, 0x1D};
const unsigned char extrmenusign[] = {0x0F, 0x22, 0x1E, 0x1C, 0x0B, 0x1D, 0x00, 0x00, 0x17, 0x0F, 0x18, 0x1F};
const unsigned char plasmasign[] = {0x1A, 0x16, 0x0B, 0x1D, 0x17, 0x0B, 0x00, 0x1C, 0x1F, 0x18};
const unsigned char fightbosssign[] = {0x10, 0x13, 0x11, 0x12, 0x1E, 0x00, 0x0C, 0x19, 0x1D, 0x1D};
const unsigned char bossrushsign[] = {0x0C, 0x19, 0x1D, 0x1D, 0x00, 0x00, 0x1C, 0x1F, 0x1D, 0x12, 0x00, 0x00, 0x17, 0x19, 0x0E, 0x0F};
const unsigned char regularsign[] = {0x1C, 0x0F, 0x11, 0x1F, 0x16, 0x0B, 0x1C};
const unsigned char glasscannonsign[] = {0x11, 0x16, 0x0B, 0x1D, 0x1D, 0x00, 0x0D, 0x0B, 0x18, 0x18, 0x19, 0x18};
const unsigned char glassfeathersign[] = {0x11, 0x16, 0x0B, 0x1D, 0x1D, 0x00, 0x10, 0x0F, 0x0B, 0x1E, 0x12, 0x0F, 0x1C};
const unsigned char rushrestitlesign[] = {0x0C, 0x19, 0x1D, 0x1D, 0x00, 0x1C, 0x1F, 0x1D, 0x12};   // 9
const unsigned char rushresmodesign[] = {0x17, 0x19, 0x0E, 0x0F};   // 4
const unsigned char rushresbossesdefsign[] = {0x0C, 0x19, 0x1D, 0x1D, 0x0F, 0x1D, 0x00, 0x0C, 0x0F, 0x0B, 0x1E, 0x0F, 0x18, 0x25};  // 14
const unsigned char allsign[] = {0x0B, 0x16, 0x16};
const unsigned char goodjobsign[] = {0x11, 0x19, 0x19, 0x0E, 0x00, 0x21, 0x19, 0x1C, 0x15, 0x27};   // 10
const unsigned char greatjobsign[] = {0x11, 0x1C, 0x0F, 0x0B, 0x1E, 0x00, 0x21, 0x19, 0x1C, 0x15, 0x27}; // 11
const unsigned char congratssign[] = {0x0D, 0x19, 0x18, 0x11, 0x1C, 0x0B, 0x1E, 0x1F, 0x16, 0x0B, 0x1E, 0x13, 0x19, 0x18, 0x1D, 0x27};  // 16
const unsigned char awardedsign[] = {0x23, 0x19, 0x1F, 0x00, 0x21, 0x13, 0x18, 0x00, 0x1E, 0x12, 0x0F, 0x00, 0x17, 0x0F, 0x0E, 0x0B, 0x16}; // 17
const unsigned char medaltypessign[][15] = {{0x00, 0x19, 0x10, 0x00, 0x0E, 0x0F, 0x0E, 0x13, 0x0D, 0x0B, 0x1E, 0x13, 0x19, 0x18, 0x00},
{0x19, 0x10, 0x00, 0x1A, 0x0F, 0x1C, 0x1D, 0x0F, 0x20, 0x0F, 0x1C, 0x0B, 0x18, 0x0D, 0x0F},
{0x00, 0x00, 0x00, 0x19, 0x10, 0x00, 0x20, 0x0B, 0x16, 0x19, 0x1C, 0x00, 0x00, 0x00, 0x00}};
const unsigned char pushstartsign[] = {0x1A, 0x1F, 0x1D, 0x12, 0x00, 0x1D, 0x1E, 0x0B, 0x1C, 0x1E}; // 10
const unsigned char medalssigns[][4] = {{0x35, 0x37, 0x36, 0x38}, {0x35, 0x37, 0x39, 0x3A}, {0x35, 0x37, 0x3B, 0x3C}};
const UINT8 bossrushconfigs[][2] = {{0, 3}, {3, 1}, {0, 1}};
const UINT8 medaltypeoffsx[] = {4, 3, 7};

UINT8 passidx, passentry[4], menuanimcnt;

typedef struct Passcursor {
    UINT8 x, y, row, col;
} Passcursor;

Passcursor crsr;


void custom_delay(UINT8 cycles) NONBANKED;
void anim_reverse_blackout() NONBANKED;
void anim_blackout() NONBANKED;
void mute_music_pl_chnl(UINT8 chnum) NONBANKED;
void init_game() NONBANKED;
void reset_sprites(UINT8 fstsprite, UINT8 lastsprite) NONBANKED;
void toggle_mute_music(UINT8 toggleon) NONBANKED;
void init_common_menu_props() BANKED;
void main_menu() BANKED;
void get_menu_pl_input(UINT8 * entries, UINT8 numentries) BANKED;
void stage_intro_screen(UINT8 stnum) BANKED;
void game_over_menu() BANKED;
void password_menu() BANKED;
void extras_menu() BANKED;
void init_passcursor(Passcursor * cr, UINT8 x, UINT8 y) BANKED;
void move_passcursor(Passcursor * cr, INT8 dirctx, INT8 dircty) BANKED;
void update_pass_field() BANKED;
void add_character() BANKED;
void drop_character() BANKED;
void reset_password() BANKED;
UBYTE confirm_password() BANKED;
UINT8 get_stage_from_password() BANKED;
UBYTE compare_password(UINT8 * pass) BANKED;
void manage_sound_chnls() NONBANKED;
void anim_cursor_blink() BANKED;
UINT8 choose_boss() BANKED;
void boss_rush_results_screen() BANKED;
void play_song(const hUGESong_t * song) BANKED;
void se_choose_entry() BANKED;
void se_move_cursor() BANKED;
void se_wrong_password() BANKED;
void se_add_character() BANKED;
void se_drop_character() BANKED;


void init_common_menu_props() BANKED {
    set_bkg_data(0, 1, blanktile);
    set_bkg_data(1, 41, fonttiles);
    fill_bkg_rect(0, 0, 32, 18, 0x00);
    set_sprite_data(1, 5, misctiles);
    set_sprite_tile(0, 1);
}


void main_menu() BANKED {
    reset_sprites(0, 3);
    init_common_menu_props();
    set_bkg_data(35, 78, titlelogotiles);
    set_bkg_tiles(2, 1, 16, 6, titlelogomap);
    anim_reverse_blackout();
    set_bkg_tiles(2, 16, 15, 1, creatorsign);
    play_song(&titletheme);
    toggle_mute_music(0);
    if(extrasflg == 1) {    //  Extras menu has been unlocked
        set_bkg_tiles(6, 9, 10, 1, gamestsign);
        set_bkg_tiles(6, 11, 8, 1, passwsign);
        set_bkg_tiles(6, 13, 6, 1, extrassign);
        move_sprite(0, 44, mainoptsy[0]);
        get_menu_pl_input(mainoptsy, 3);
    } else {
        set_bkg_tiles(6, 11, 10, 1, gamestsign);
        set_bkg_tiles(6, 13, 8, 1, passwsign);
        move_sprite(0, 44, mainoptsy[1]);
        get_menu_pl_input(mainoptsy + 1, 2);
    }
    remove_VBL(hUGE_dosound);
    reset_sprites(0, 0);
    anim_blackout();

    switch(menuidx) {
        case 1:
            password_menu();
            break;
        case 2:
            extras_menu();
            break;
    }
}


void get_menu_pl_input(UINT8 * entries, UINT8 numentries) BANKED {
    menuidx = 0; // First option set by default
    while(1) {
        if(joypad() & (J_DOWN | J_SELECT)) {
            menuidx = menuidx + 1 == numentries ? 0 : menuidx + 1;
            move_sprite(0, shadow_OAM[0].x, entries[menuidx]);
            se_move_cursor();
            waitpadup();
        } else if(joypad() & J_UP) {
            menuidx = menuidx == 0 ? numentries - 1 : menuidx - 1;
            move_sprite(0, shadow_OAM[0].x, entries[menuidx]);
            se_move_cursor();
            waitpadup();
        } else if(joypad() & (J_START | J_A)) {
            break;  // Player has made a choice
        }
        manage_sound_chnls();
        wait_vbl_done();
    }
    toggle_mute_music(1);
    se_choose_entry();
}


void stage_intro_screen(UINT8 stnum) BANKED {
    init_common_menu_props();
    set_sprite_tile(0, 4);
    set_bkg_data(43, 2, mapframetiles);
    if(stnum < 3) {
        set_bkg_data(45, 98, overworldmaptiles);
        set_bkg_tiles(0, 3, 20, 11, overworldmap);
    } else {
        set_bkg_data(45, 116, airbasemaptiles);
        set_bkg_tiles(0, 3, 20, 11, airbasemap);
    }
    set_bkg_tiles(6, 1, 5, 1, stagesign);
    set_bkg_tile_xy(12, 1, stnum + 2);
    set_bkg_tiles((20 - stnamelengths[stnum]) / 2, 15, stnamelengths[stnum], 1, *(stagenames + stnum));
    fill_bkg_rect(0, 2, 20, 1, 44);
    fill_bkg_rect(0, 14, 20, 1, 43);
    move_sprite(0, mapcrsrcoords[stnum][0], mapcrsrcoords[stnum][1]);
    anim_reverse_blackout();
    for(i =  0; i != introscrdurr; i++) {
        if(i % 16 == 0) {
            set_sprite_tile(0, get_sprite_tile(0) == 4 ? 5 : 4);
        }
        if(joypad() & J_START) {
            break;
        }
        wait_vbl_done();
    }
    anim_blackout();
}


void game_over_menu() BANKED {
    init_common_menu_props();
    if(bossrushflg != 0) {  // Do not display game over screen in boss rush mode or when fighting a single boss
        if(bossrushflg == 1) {  // Do not display boss rush results for a single boss fight
            boss_rush_results_screen();
        }
        menuidx = 1;
        stageclearflg = bossrushflg = 0;
        return;
    }
    set_bkg_tiles(5, 4, 9, 1, gmoversign);
    set_bkg_tiles(7, 10, 8, 1, contsign);
    set_bkg_tiles(7, 12, 4, 1, quitsign);
    set_bkg_tiles(3, 16, 9, 1, gopasssign);
    set_bkg_tiles(12, 16, 4, 1, passwords[stagenum]);
    move_sprite(0, 52, gameoveroptsy[0]);
    play_song(&gameovertheme);
    anim_reverse_blackout();
    get_menu_pl_input(gameoveroptsy, 2);
    remove_VBL(hUGE_dosound);
    reset_sprites(0, 0);
    anim_blackout();
}


void init_passcursor(Passcursor * cr, UINT8 x, UINT8 y) BANKED {
    for(i = 1; i < 6; i++) {
        set_sprite_tile(i, 2);
    }
    cr->x = x;
    cr->y = y;
    cr->row = cr->col = 0;
    move_sprite(1, x, y);
    move_sprite(2, x + 8, y);
    set_sprite_prop(2, 32);
    move_sprite(3, x, y + 8);
    set_sprite_prop(3, 64);
    move_sprite(4, x + 8, y + 8);
    set_sprite_prop(4, 96);
}


void move_passcursor(Passcursor * cr, INT8 dirctx, INT8 dircty) BANKED {
    INT8 nextcol = cr->col + dirctx;
    INT8 nextrow = cr->row + dircty;
    if(nextcol >= 0 && nextcol < 9 && nextrow >= 0 && nextrow < 3) {
        cr->x += (dirctx * 16);
        cr->y += (dircty * 16);
        cr->col = nextcol;
        cr->row = nextrow;
        move_sprite(1, cr->x, cr->y);
        move_sprite(2, cr->x + 8, cr->y);
        move_sprite(3, cr->x, cr->y + 8);
        move_sprite(4, cr->x + 8, cr->y + 8);
    }
    se_move_cursor();
    custom_delay(7);
}


void update_pass_field() BANKED {
    for(i = 0; i < 4; i++) {
        set_bkg_tile_xy(6 + i * 2, 3, passentry[i]);
    }
    if(passidx != 4) {
        move_sprite(5, 61 + passidx * 16, 40);
    }
}


void add_character() BANKED {
    passentry[passidx] = crsr.row * 9 + crsr.col + 11;
    passidx++;
    update_pass_field();
    se_add_character();
}


void drop_character() BANKED {
    if(passidx > 0) {
        passidx--;
        passentry[passidx] = 51;    // Empty tile
        update_pass_field();
        se_drop_character();
    }
}


void reset_password() BANKED {
    for(i = 0; i < 4; i++) {
        passentry[i] = 51;
    }
    passidx = 0;
    update_pass_field();
    se_drop_character();
}


UINT8 get_stage_from_password() BANKED {
    for(i = 0; i != 8; i++) {
        if(compare_password(passwords[i])) {
            return i;   // Password array index matches stage number
        }
    }
    return wrongpassind;  // Could not find entered password
}


UBYTE compare_password(UINT8 * pass) BANKED {
    for(citr = 0; citr < 4; citr++) {
        if(passentry[citr] != pass[citr]) {
            return 0;   // Letter mismatch
        }
    }
    return 1;
}


UBYTE confirm_password() BANKED {
    set_sprite_tile(0, 1);
    set_sprite_tile(5, 0);
    move_sprite(0, passconfoptsx[1], passconfy);
    while(1) {
        wait_vbl_done();
        if(joypad() & (J_LEFT | J_RIGHT | J_SELECT)) {
            move_sprite(0, passconfoptsx[shadow_OAM[0].x == passconfoptsx[0] ? 1 : 0], passconfy);
            se_move_cursor();
            waitpadup();
        } else if(joypad() & (J_A |  J_START)) {
            waitpadup();
            set_sprite_tile(0, 0);
            return shadow_OAM[0].x == passconfoptsx[1];
        }
        manage_sound_chnls();
    }
}


void anim_cursor_blink() BANKED {
    if(menuanimcnt == 0) {
        menuanimcnt = blinkanimdur;
        set_sprite_tile(5, shadow_OAM[5].tile == 0 ? 3 : 0);
    } else {
        menuanimcnt--;
    }
}


void password_menu() {
    menuanimcnt = blinkanimdur;
    UINT8 matchedpassstage = wrongpassind;
    scroll_bkg(-5, 0);
    init_common_menu_props();
    set_bkg_data(42, 10, passwscreentiles);
    set_bkg_tiles(0, 0, 20, 18, passwscreenmap);
    set_sprite_tile(0, 1);
    init_passcursor(&crsr, 17, 76);
    reset_password();
    set_sprite_tile(5, 0);
    anim_reverse_blackout();

    while(matchedpassstage == wrongpassind) {
        switch(joypad()) {
            case J_LEFT:
                move_passcursor(&crsr, -1, 0);
                break;
            case J_RIGHT:
                move_passcursor(&crsr, 1, 0);
                break;
            case J_UP:
                move_passcursor(&crsr, 0, -1);
                break;
            case J_DOWN:
                move_passcursor(&crsr, 0, 1);
                break;
            case J_A:
                if(crsr.row == 2 && crsr.col == 8) {
                    drop_character();
                } else {
                    add_character();
                }
                waitpadup();
                break;
            case J_B:
                drop_character();
                waitpadup();
                break;
        }
        if(passidx == 4) {   // Full password entered
            if(confirm_password()) {
                matchedpassstage = get_stage_from_password();
                if(matchedpassstage == wrongpassind) {
                    reset_password();
                    se_wrong_password();
                }
            } else {
                reset_password();
            }
        }
        anim_cursor_blink();
        manage_sound_chnls();
        wait_vbl_done();
    }

    se_choose_entry();
    reset_sprites(0, 5);
    anim_blackout();
    move_bkg(0, 0);
    if(matchedpassstage == 7)   {   // Entered extras password
        extrasflg = 1;
        extras_menu();
    } else {    // Entered regular stage password
        stagenum = matchedpassstage;
    }
}


void extras_menu() BANKED {
    init_common_menu_props();
    set_bkg_tiles(4, 1, 12, 1, extrmenusign);
    set_bkg_tiles(5, 4, 10, 1, plasmasign);
    set_bkg_tiles(5, 6, 10, 1, fightbosssign);
    set_bkg_tiles(2, 9, 16, 1, bossrushsign);
    set_bkg_tiles(5, 12, 7, 1, regularsign);
    set_bkg_tiles(5, 14, 12, 1, glasscannonsign);
    set_bkg_tiles(5, 16, 13, 1, glassfeathersign);
    move_sprite(0, 36, extrasoptsy[0]);
    anim_reverse_blackout();
    get_menu_pl_input(extrasoptsy, 5);
    waitpadup();

    if(menuidx == 0) { // Plasma run
        defaultplgun = 3;
    } else if(menuidx == 1) {    // Single boss fight
        stagenum = choose_boss();
        se_choose_entry();
        bossrushflg = 2;
        defaultplgun = bossrushconfigs[0][0];
        pllives = bossrushconfigs[0][1];
    } else {    // Boss rush modes
        bossrushflg = 1;
        defaultplgun = bossrushconfigs[menuidx - 2][0];
        pllives = bossrushconfigs[menuidx - 2][1];
    }
    anim_blackout();
}


UINT8 choose_boss() BANKED {
    i = 0;
    set_bkg_data(42, 7, misctiles);
    set_bkg_tile_xy(16, 6, 47);
    set_bkg_tile_xy(17, 6, 2);
    set_bkg_tile_xy(18, 6, 48);
    while(1) {
        if(joypad() & J_LEFT) {
            i = i == 0 ? 0 : i - 1;
            set_bkg_tile_xy(17, 6, i + 2);
            se_add_character();
            custom_delay(7);
        } else if(joypad() & J_RIGHT) {
            i = i == 6 ? 6 : i + 1;
            set_bkg_tile_xy(17, 6, i + 2);
            se_add_character();
            custom_delay(7);
        } else if(joypad() & (J_A | J_START)) {
            return i;
        }
    }
}


void boss_rush_results_screen() BANKED {
    init_common_menu_props();
    fill_bkg_rect(0, 0, 20, 18, 0);
    set_bkg_tiles(5, 1, 9, 1, rushrestitlesign);

    if(menuidx == 2) {
        set_bkg_tiles(3, 3, 7, 1, regularsign);
        set_bkg_tiles(12, 3, 4, 1, rushresmodesign);
    } else if(menuidx == 3) {
        set_bkg_tiles(1, 3, 12, 1, glasscannonsign);
        set_bkg_tiles(14, 3, 4, 1, rushresmodesign);
    } else {
        set_bkg_tiles(1, 3, 13, 1, glassfeathersign);
        set_bkg_tiles(15, 3, 4, 1, rushresmodesign);
    }

    if(stagenum == 7) {    // Beaten all bosses
        set_bkg_data(53, 8, medaltiles);
        set_bkg_tiles(1, 5, 14, 1, rushresbossesdefsign);
        set_bkg_tiles(15, 5, 3, 1, allsign);
        set_bkg_tiles(2, 7, 16, 1, congratssign);
        set_bkg_tiles(1, 9, 17, 1, awardedsign);
        set_bkg_tiles(2, 11, 15, 1, medaltypessign[menuidx - 2]);
        set_bkg_tiles(9, 13, 2, 2, medalssigns[menuidx - 2]);
        set_bkg_tiles(5, 16, 10, 1, pushstartsign);
    } else {
        set_bkg_tile_xy(17, 8, 1 + stagenum);
        set_bkg_tiles(3, 8, 14, 1, rushresbossesdefsign);
        set_bkg_tiles(5, 14, 10, 1, pushstartsign);
        if(stagenum > 3) {
            set_bkg_tiles(5, 10, 11, 1, greatjobsign);
        } else if(stagenum > 0) {
            set_bkg_tiles(5, 10, 10, 1, goodjobsign);
        }
    }

    anim_reverse_blackout();
    waitpad(J_START);
    stagenum = defaultplgun = bossrushflg = 0;
    se_choose_entry();
    anim_blackout();
}


void play_song(const hUGESong_t * song) BANKED {
    __critical {
        hUGE_init(song);
        add_VBL(hUGE_dosound);
    }
}


void se_choose_entry() BANKED {
    mute_music_pl_chnl(0);
    NR10_REG = 0x64;
    NR11_REG = 0x88;
    NR12_REG = 0xF3;
    NR13_REG = 0x3E;
    NR14_REG = 0x86;
}


void se_move_cursor() BANKED {
    mute_music_pl_chnl(0);
    NR10_REG = 0x00;
    NR11_REG = 0xC9;
    NR12_REG = 0xF2;
    NR13_REG = 0x9F;
    NR14_REG = 0x86;
}


void se_wrong_password() BANKED {
    mute_music_pl_chnl(0);
    NR10_REG = 0x0F;
    NR11_REG = 0xFF;
    NR12_REG = 0xF2;
    NR13_REG = 0x53;
    NR14_REG = 0x83;
}


void se_add_character() BANKED {
    mute_music_pl_chnl(1);
    NR21_REG = 0x41;
    NR22_REG = 0xF2;
    NR23_REG = 0x36;
    NR24_REG = 0x87;
}


void se_drop_character() BANKED {
    mute_music_pl_chnl(3);
    NR41_REG = 0x3A;
    NR42_REG = 0xF3;
    NR43_REG = 0x11;
    NR44_REG = 0xC0;
}
