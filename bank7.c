#include <gb/gb.h>
#include "cutscenesdialogue.c"

extern UINT8 i, bossclearflg, stagenum;

UINT8 animitr = 0;


void custom_delay(UINT8 cycles) NONBANKED;
void scroll_textbox(UINT8 dialidx) BANKED;
UINT8 wait_player_input(UINT8 crsridx) BANKED;
void se_move_cursor2() BANKED;


void scroll_textbox(UINT8 dialidx) BANKED {
    const UINT8 textoffsx = 1;
    const UINT8 exampletext[] = {0x19, 0x17, 0x26, 0x00, 0x26, 0x21, 0x00, 0x26, 0x1A, 0x17, 0x00, 0x15, 0x1A, 0x21, 0x22, 0x22, 0x13, 0x2F};
    // Character limit per line - 18
    fill_win_rect(0, 0, 20, 1, 0x00);
    UINT8 textboxposy = 134;
    move_win(11, 134);
    set_sprite_tile(39, 75);
    set_win_tile_xy(0, 0, 255);

    const UINT8 * textpos = dialoguearr[dialidx];
    if(textpos == NULL) {
        return;
    }
    for(i = 0; *textpos != 0xFF; textpos++, i++) {  // Using 0xFF to indicate text end
        if(*textpos == 0xFE) {  // Using 0xFE to indicate end of line
            fill_win_rect(i + 1, 0, 21 - i, 1, 0x00);
            if(wait_player_input(i) == J_A) {   // Print next line
                i = 255;    // Will be reset to 0 before next iteration
                fill_win_rect(0, 0, 20, 1, 0x00);
                continue;
            } else {    // Stop printing
                break;
            }
        } else if(*textpos > 0xF6) {    // Line with character name
            fill_win_rect(0, 0, 20, 1, 0x00);
            i = *textpos - 0xF7;   // Character name array index
            set_win_tiles(0, 0, nameslengths[i], 1, names[i]);
            i = nameslengths[i] - 1;    // Setting iterator for blinking animation
            continue;
        }
        set_win_tile_xy(i, 0, *textpos);
        set_win_tile_xy(i + 1, 0, 255);
        se_move_cursor2();
        custom_delay(3);
    }
    move_win(15, 134);
}


UINT8 wait_player_input(UINT8 crsridx) BANKED {
    animitr = 0;
    while(1) {
        if(animitr % 32 == 0) {
            set_win_tile_xy(crsridx, 0, 0);
        } else if(animitr % 16 == 0) {
            set_win_tile_xy(crsridx, 0, 255);
        }
        animitr++;
        wait_vbl_done();
        if(joypad() & J_A) {
            waitpadup();
            return J_A;
        } else if(joypad() & J_START) {
            waitpadup();
            return J_START;
        }
    }
}


void se_move_cursor2() BANKED {
    NR10_REG = 0x00;
    NR11_REG = 0xCB;
    NR12_REG = 0xF2;
    NR13_REG = 0x9F;
    NR14_REG = 0x86;
}
