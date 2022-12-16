#include <gb/gb.h>
#include "tiles/misctiles.c"
#include "tiles/titlelogotiles.c"
#include "tiles/fonttiles.c"
#include "tiles/passwscreentiles.c"
#include "maps/titlelogomap.c"
#include "maps/passwscreenmap.c"
#include "hUGEDriver.h"


extern const hUGESong_t titletheme;
extern const hUGESong_t gameovertheme;
extern const unsigned char blanktile[];
extern UINT8 menuidx, gamemode, extrasflg, i, citr, citrstagenum = 0;
const unsigned char stagenames[][14] = {{0x0E, 0x0F, 0x1D, 0x0F, 0x1C, 0x1E, 0x00, 0x12, 0x13, 0x11, 0x12, 0x21, 0x0B, 0x23},
{0x0D, 0x0B, 0x1A, 0x1E, 0x13, 0x20, 0x0F, 0x00, 0x0D, 0x13, 0x1E, 0x23}, {0x17, 0x19, 0x1F, 0x18, 0x1E, 0x0B, 0x13, 0x18, 0x00, 0x1A, 0x0B, 0x1D, 0x1D},
{0x1D, 0x15, 0x23, 0x00, 0x1E, 0x1F, 0x18, 0x18, 0x0F, 0x16}, {0x10, 0x19, 0x1C, 0x1E, 0x00, 0x1D, 0x1E, 0x1C, 0x0B, 0x1E, 0x19, 0x1D},
{0x0F, 0x18, 0x0F, 0x1C, 0x11, 0x23, 0x00, 0x0D, 0x19, 0x1C, 0x0F}};
const UINT8 stnamelengths[] = {14, 12, 13, 10, 12, 11};

// Global scope/menus vars
const UINT8 gameoveroptsy[] = {96, 112, 130};
const UINT8 mainoptsy[] = {88, 104, 120};
const UINT8 passconfoptsx[] = {19, 83};
const UINT8 passconfy = 128, blinkanimdur = 3;
const UINT8 wrongpassind = 99;  // Incorrect password indicator
const UINT8 passwords[][4] = {{11, 12, 13, 14}, {30, 11, 27, 23}, {33, 16, 24, 13}, {15, 25, 28, 21}, 
{28, 32, 13, 36}, {31, 28, 30, 18}};
UINT8 passidx, passentry[4], menuanimcnt;

typedef struct Passcursor {
    UINT8 x, y, row, col;
} Passcursor;

Passcursor crsr;


void custom_delay(UINT8 cycles) NONBANKED;
void anim_reverse_blackout() NONBANKED;
void play_song(const hUGESong_t * song, UINT8 songbank) NONBANKED;
void stop_song() NONBANKED;
void anim_blackout() NONBANKED;
void mute_music_pl_chnl(UINT8 chnum) NONBANKED;
void init_common_menu_props() BANKED;
void main_menu() BANKED;
void get_menu_pl_input(UINT8 * entries, UINT8 numentries) BANKED;
void stage_intro_screen(UINT8 stnum) BANKED;
void game_over_menu(UINT8 stnum) BANKED;
void demo_end_screen() BANKED;
UINT8 password_menu() BANKED;
void init_game() NONBANKED;
void reset_all_sprites() NONBANKED;
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
void se_choose_entry() BANKED;
void se_move_cursor() BANKED;
void se_wrong_password() BANKED;
void se_add_character() BANKED;
void se_drop_character() BANKED;



void init_common_menu_props() BANKED {
    set_bkg_data(0, 1, blanktile);
    set_bkg_data(1, 41, fonttiles);
    fill_bkg_rect(0, 0, 32, 18, 0x00);
    set_sprite_data(1, 3, misctiles);
    set_sprite_tile(0, 1);
}


void main_menu() BANKED {
    init_common_menu_props();
    const unsigned char gamestsign[] = {0x1D, 0x1E, 0x0B, 0x1C, 0x1E, 0x00, 0x11, 0x0B, 0x17, 0x0F};
    const unsigned char passwsign[] = {0x1A, 0x0B, 0x1D, 0x1D, 0x21, 0x19, 0x1C, 0x0E};
    const unsigned char creatorsign[] = {0x03, 0x01, 0x03, 0x03, 0x00, 0x15, 0x18, 0x1D, 0x00, 0x0E, 0x19, 0x0C, 0x1C, 0x0F, 0x20};
    set_bkg_data(35, 78, titlelogotiles);
    set_bkg_tiles(2, 1, 16, 6, titlelogomap);
    anim_reverse_blackout();
    play_song(&titletheme, 1);
    set_bkg_tiles(2, 16, 15, 1, creatorsign);
    if(extrasflg == 1) {    //  Extras menu has been unlocked
        set_bkg_tiles(6, 9, 10, 1, gamestsign);
        set_bkg_tiles(6, 11, 8, 1, passwsign);
        const unsigned char extrassign[] = {0x0F, 0x22, 0x1E, 0x1C, 0x0B, 0x1D};
        set_bkg_tiles(6, 13, 6, 1, extrassign);
        move_sprite(0, 44, 88);
        get_menu_pl_input(mainoptsy, 3);
    } else {
        set_bkg_tiles(6, 11, 10, 1, gamestsign);
        set_bkg_tiles(6, 13, 8, 1, passwsign);
        move_sprite(0, 44, 104);
        get_menu_pl_input(mainoptsy + 1, 2);
    }
    stop_song();
    se_choose_entry();
    reset_all_sprites();
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
        manage_sound_chnls();
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


void game_over_menu(UINT8 stnum) BANKED {
    init_common_menu_props();
    const unsigned char gmoversign[] = {0x11, 0x0B, 0x17, 0x0F, 0x00, 0x019, 0x20, 0x0F, 0x1C};
    const unsigned char contsign[] = {0x0D, 0x19, 0x18, 0x1E, 0x13, 0x18, 0x1F, 0x0F};
    const unsigned char quitsign[] = {0x1B, 0x1F, 0x13, 0x1E};
    const unsigned char gopasssign[] = {0x1A, 0x0B, 0x1D, 0x1D, 0x21, 0x19, 0x1C, 0x0E, 0x25};
    const unsigned char dummypass[] = {0x28, 0x28, 0x28, 0x28};
    set_bkg_tiles(5, 4, 9, 1, gmoversign);
    set_bkg_tiles(7, 10, 8, 1, contsign);
    set_bkg_tiles(7, 12, 4, 1, quitsign);
    set_bkg_tiles(3, 16, 9, 1, gopasssign);
    set_bkg_tiles(12, 16, 4, 1, passwords[stnum]);
    move_sprite(0, 52, 96);
    play_song(&gameovertheme, 1);
    anim_reverse_blackout();
    get_menu_pl_input(gameoveroptsy, 2);
    reset_all_sprites();
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
}



void update_pass_field() BANKED {
    for(i = 0; i < 4; i++) {
        set_bkg_tile_xy(6 + i * 2, 3, passentry[i]);
    }
    move_sprite(6, 61 + passidx * 16, 40);
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
        passentry[passidx] = 42;    // Empty tile
        update_pass_field();
        se_drop_character();
    }
}


void reset_password() BANKED {
    for(i = 0; i < 4; i++) {
        passentry[i] = 42;
    }
    passidx = 0;
    update_pass_field();
    se_drop_character();
}


UINT8 get_stage_from_password() BANKED {
    for(i = 0; i < 6; i++) {
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
    set_sprite_tile(5, 1);
    set_sprite_tile(6, 0);
    move_sprite(5, passconfoptsx[1], passconfy);
    while(1) {
        custom_delay(7);
        if(joypad() & (J_LEFT | J_RIGHT | J_SELECT)) {
            move_sprite(5, passconfoptsx[shadow_OAM[5].x == passconfoptsx[0] ? 1 : 0], passconfy);
            se_move_cursor();
        } else if(joypad() & (J_A |  J_START)) {
            set_sprite_tile(5, 0);
            return shadow_OAM[5].x == passconfoptsx[1];
        }
        manage_sound_chnls();
    }
}


void anim_cursor_blink() BANKED {
    if(menuanimcnt == 0) {
        menuanimcnt = blinkanimdur;
        set_sprite_tile(6, shadow_OAM[6].tile == 0 ? 3 : 0);
    } else {
        menuanimcnt--;
    }
}



UINT8 password_menu() {
    menuanimcnt = blinkanimdur;
    UINT8 matchedpassstage = wrongpassind;
    scroll_bkg(-5, 0);
    init_common_menu_props();
    set_bkg_data(42, 10, passwscreentiles);
    set_bkg_tiles(0, 0, 20, 18, passwscreenmap);
    set_sprite_tile(0, 0);
    init_passcursor(&crsr, 17, 76);
    reset_password();
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
                break;
            case J_B:
                drop_character();
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
        custom_delay(7);
        wait_vbl_done();
    }

    se_choose_entry();
    reset_all_sprites();
    anim_blackout();
    move_bkg(0, 0);
    return matchedpassstage;
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
    NR11_REG = 0xCB;
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
