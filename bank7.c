#include <gb/gb.h>
#include "machine.c"
#include "cutscenesdialogue.c"
#include "tiles/endingcutsctiles.c"
#include "tiles/fortsfiretiles.c"
#include "maps/endingcutscmap.c"


extern UINT8 i, bossclearflg, stagenum, oamidx, cloudposx, sceneryposx, roadposx, camtileidx, nextcamtileidx;
extern Machine * pl;
extern UINT8 goodroadmap[];


const UINT8 epiloguetext[] = {
    0x13, 0x00, 0x0C, 0x0B, 0x1C, 0x0F, 0x16, 0x23, 0x00, 0x17, 0x0B, 0x0E, 0x0F, 0x00, 0x13, 0x1E, 0xFE,
    0x19, 0x1F, 0x1E, 0x00, 0x13, 0x18, 0x00, 0x1E, 0x13, 0x17, 0x0F, 0x27, 0x00, 0x21, 0x0F, 0x16, 0x16, 0x29, 0xFE,
    0x10, 0x19, 0x1C, 0x1E, 0x00, 0x1D, 0x1E, 0x1C, 0x0B, 0x1E, 0x19, 0x1D, 0x00, 0x13, 0x1D, 0x00, 0x18, 0x19, 0xFE,
    0x17, 0x19, 0x1C, 0x0F, 0x26, 0x00, 0x1E, 0x12, 0x0F, 0x00, 0x17, 0x13, 0x16, 0x13, 0x1E, 0x0B, 0x1C, 0x23, 0xFE,
    0x21, 0x13, 0x16, 0x16, 0x00, 0x12, 0x0B, 0x20, 0x0F, 0x00, 0x1E, 0x19, 0xFE,
    0x1C, 0x0F, 0x16, 0x23, 0x00, 0x19, 0x18, 0x00, 0x16, 0x0F, 0x1D, 0x1D, 0xFE,
    0x1A, 0x19, 0x21, 0x0F, 0x1C, 0x10, 0x1F, 0x16, 0x00, 0x21, 0x0F, 0x0B, 0x1A, 0x19, 0x18, 0x1D, 0xFE,
    0x10, 0x19, 0x1C, 0x00, 0x1E, 0x12, 0x0F, 0x00, 0x1E, 0x13, 0x17, 0x0F, 0xFE,
    0x0C, 0x0F, 0x13, 0x18, 0x11, 0x26, 0x00, 0x13, 0x2A, 0x20, 0x0F, 0x00, 0x18, 0x0F, 0x20, 0x0F, 0x1C, 0xFE,
    0x16, 0x13, 0x15, 0x0F, 0x0E, 0x00, 0x1E, 0x12, 0x0B, 0x1E, 0x00, 0x1A, 0x16, 0x0B, 0x0D, 0x0F, 0xFE,
    0x0B, 0x18, 0x23, 0x21, 0x0B, 0x23, 0x26, 0xFE,
    0xFE,
    0x21, 0x12, 0x23, 0x00, 0x21, 0x0B, 0x1D, 0x00, 0x1F, 0x16, 0x1E, 0x11, 0x0F, 0x18, 0xFE,
    0x21, 0x13, 0x16, 0x16, 0x13, 0x18, 0x11, 0x00, 0x1E, 0x19, 0x00, 0x11, 0x19, 0x00, 0x1E, 0x19, 0xFE,
    0x1D, 0x1F, 0x0D, 0x12, 0x00, 0x0F, 0x22, 0x1E, 0x1C, 0x0F, 0x17, 0x0F, 0x1D, 0x00, 0x10, 0x19, 0x1C, 0xFE,
    0x17, 0x19, 0x1C, 0x0F, 0x00, 0x1A, 0x19, 0x21, 0x0F, 0x1C, 0x28, 0xFE,
    0x12, 0x19, 0x21, 0x00, 0x0E, 0x13, 0x0E, 0x00, 0x12, 0x0F, 0x00, 0x11, 0x0F, 0x1E, 0xFE,
    0x1D, 0x19, 0x00, 0x17, 0x0B, 0x18, 0x23, 0x00, 0x1E, 0x19, 0x00, 0x10, 0x19, 0x16, 0x16, 0x19, 0x21, 0xFE,
    0x12, 0x13, 0x17, 0x00, 0x0B, 0x18, 0x0E, 0x00, 0x12, 0x13, 0x1D, 0x00, 0x0D, 0x0B, 0x1F, 0x1D, 0x0F, 0x28, 0xFE,
    0x0B, 0x1E, 0x00, 0x16, 0x0F, 0x0B, 0x1D, 0x1E, 0x00, 0x12, 0x0F, 0x00, 0x21, 0x13, 0x16, 0x16, 0xFE,
    0x18, 0x19, 0x1E, 0x00, 0x1E, 0x12, 0x1C, 0x0F, 0x0B, 0x1E, 0x0F, 0x18, 0xFE, 
    0x0B, 0x18, 0x23, 0x19, 0x18, 0x0F, 0x00, 0x0B, 0x18, 0x23, 0x17, 0x19, 0x1C, 0x0F, 0x26, 0xFE,
    0xFE,
    0x13, 0x00, 0x1A, 0x1C, 0x0F, 0x20, 0x0F, 0x18, 0x1E, 0x0F, 0x0E, 0xFE,
    0x0B, 0x00, 0x11, 0x1C, 0x0F, 0x0B, 0x1E, 0x00, 0x0E, 0x13, 0x1D, 0x0B, 0x1D, 0x1E, 0x0F, 0x1C, 0xFE,
    0x1E, 0x19, 0x0E, 0x0B, 0x23, 0x00, 0x0B, 0x18, 0x0E, 0x00, 0x13, 0x00, 0x0D, 0x19, 0x1F, 0x16, 0x0E, 0xFE,
    0x18, 0x19, 0x1E, 0x00, 0x12, 0x0B, 0x20, 0x0F, 0x00, 0x0E, 0x19, 0x18, 0x0F, 0x00, 0x13, 0x1E, 0xFE,
    0x21, 0x13, 0x1E, 0x12, 0x19, 0x1F, 0x1E, 0x00, 0x23, 0x19, 0x1F, 0x1C, 0x00, 0x12, 0x0F, 0x16, 0x1A, 0x27, 0xFE,
    0x1E, 0x12, 0x0B, 0x18, 0x15, 0x00, 0x23, 0x19, 0x1F, 0x00, 0x10, 0x19, 0x1C, 0xFE,
    0x1D, 0x1E, 0x13, 0x0D, 0x15, 0x13, 0x18, 0x11, 0x00, 0x21, 0x13, 0x1E, 0x12, 0x00, 0x17, 0x0F, 0xFE,
    0x1F, 0x18, 0x1E, 0x13, 0x16, 0x00, 0x1E, 0x12, 0x0F, 0x00, 0x0F, 0x18, 0x0E, 0x27, 0xFE,
    0x13, 0x1E, 0x2A, 0x1D, 0x00, 0x1E, 0x13, 0x17, 0x0F, 0x00, 0x10, 0x19, 0x1C, 0x00, 0x0B, 0xFE,
    0x21, 0x0F, 0x16, 0x16, 0x00, 0x0E, 0x0F, 0x1D, 0x0F, 0x1C, 0x20, 0x0F, 0x0E, 0xFE,
    0x0C, 0x1C, 0x0F, 0x0B, 0x15, 0x26, 0x00, 0x11, 0x19, 0x19, 0x0E, 0x0C, 0x23, 0x0F, 0x27, 0x00, 0x00, 0x00, 0xFE, 0xFF    
};


const UINT8 fires[][3] = {{88, 28, 1}, {96, 26, 0}, {104, 24, 1}, {112, 25, 0}, {120, 26, 1}, {128, 24, 1}, {140, 27, 0}};

// CREDITS


const UINT8 credentries[] = {
    0x24, 0x1B, 0x16, 0x17, 0x24, // - 5                                                                   
    0x16, 0x24, 0x21, 0x20, 0x17, // - 5                                                                   
    0x24, 0x21, 0x15, 0x1D, 0x17, 0x26, // - 6                                                             
    0x26, 0x27, 0x24, 0x24, 0x17, 0x26, // - 6                                                             
    0x14, 0x21, 0x1F, 0x14, 0x17, 0x24, // - 6                                                             
    0x1F, 0x1B, 0x20, 0x17, // - 4                                                                         
    0x1E, 0x13, 0x25, 0x17, 0x24, 0x00, 0x26, 0x27, 0x24, 0x24, 0x17, 0x26, // - 12                        
    0x26, 0x24, 0x1B, 0x33, 0x26, 0x27, 0x24, 0x24, 0x17, 0x26, // - 10                                    
    0x25, 0x17, 0x17, 0x1D, 0x17, 0x24, // - 6                                                             
    0x25, 0x15, 0x21, 0x24, 0x22, // - 5                                                                   
    0x18, 0x17, 0x24, 0x1B, 0x27, 0x1F, // - 6                                                             
    0x24, 0x13, 0x16, 0x1B, 0x27, 0x1F, // - 6                                                             
    0x1C, 0x27, 0x19, 0x19, 0x17, 0x24, 0x20, 0x13, 0x27, 0x26, // - 10                                    
    0x27, 0x1E, 0x26, 0x19, 0x17, 0x20, // - 6                                                             
    0x13, 0x1B, 0x24, 0x14, 0x13, 0x25, 0x17, 0x00, 0x13, 0x1B, // - 10                                                                                                                                          
    0x15, 0x13, 0x25, 0x26, // - 4                                                                         
    0x25, 0x26, 0x13, 0x19, 0x17, 0x00, 0x00, // - 7
    0x16, 0x17, 0x25, 0x17, 0x24, 0x26, 0x00, 0x1A, 0x1B, 0x19, 0x1A, 0x29, 0x13, 0x2B, // - 14            
    0x15, 0x13, 0x22, 0x26, 0x1B, 0x28, 0x17, 0x00, 0x15, 0x1B, 0x26, 0x2B, // - 12                        
    0x1F, 0x21, 0x27, 0x20, 0x26, 0x13, 0x1B, 0x20, 0x00, 0x22, 0x13, 0x25, 0x25, // - 13                  
    0x25, 0x1D, 0x2B, 0x00, 0x26, 0x27, 0x20, 0x20, 0x17, 0x1E, // - 10                                    
    0x18, 0x21, 0x24, 0x26, 0x00, 0x25, 0x26, 0x24, 0x13, 0x26, 0x21, 0x25, // - 12                        
    0x18, 0x2E, 0x25, 0x2E, 0x00, 0x27, 0x20, 0x16, 0x17, 0x24, 0x19, 0x24, 0x21, 0x27, 0x20, 0x16, // - 16
    0x17, 0x20, 0x17, 0x24, 0x19, 0x2B, 0x00, 0x15, 0x21, 0x24, 0x17, // - 11                              
    0x22, 0x24, 0x21, 0x19, 0x24, 0x13, 0x1F, 0x1F, 0x1B, 0x20, 0x19, // - 11                              
    0x22, 0x1B, 0x2A, 0x17, 0x1E, 0x00, 0x13, 0x24, 0x26, // - 9                                           
    0x21, 0x25, 0x26, 0x00, 0x13, 0x20, 0x16, 0x00, 0x25, 0x17, // - 10                                    
    0x1E, 0x17, 0x28, 0x17, 0x1E, 0x00, 0x16, 0x17, 0x25, 0x1B, 0x19, 0x20, // - 12                        
    0x25, 0x26, 0x21, 0x24, 0x2B, // - 5                                                                   
    0x14, 0x2B, // - 2                                                                                     
    0x1D, 0x21, 0x20, 0x25, 0x26, 0x13, 0x20, 0x26, 0x1B, 0x20, // - 10                                    
    0x16, 0x21, 0x14, 0x24, 0x17, 0x28, // - 6                                                             
    0x27, 0x25, 0x17, 0x16, 0x00, 0x25, 0x21, 0x18, 0x26, 0x29, 0x13, 0x24, 0x17, // - 13                  
    0x1F, 0x25, 0x00, 0x28, 0x25, 0x00, 0x15, 0x21, 0x16, 0x17, // - 10                                    
    0x19, 0x14, 0x16, 0x1D, 0x00, 0x0B, 0x09, 0x0B, 0x09, // - 9                                           
    0x19, 0x1B, 0x1F, 0x22, // - 4                                                                         
    0x19, 0x14, 0x26, 0x16, // - 4                                                                         
    0x19, 0x14, 0x1F, 0x14, // - 4                                                                         
    0x1A, 0x27, 0x19, 0x17, 0x00, 0x26, 0x24, 0x13, 0x15, 0x1D, 0x17, 0x24, // - 12                        
    0x14, 0x19, 0x14, // - 3                                                                               
    0x17, 0x1F, 0x27, 0x1E, 0x1B, 0x15, 0x1B, 0x21, 0x27, 0x25, // - 10                                    
    0x13, 0x1E, 0x1E, 0x00, 0x24, 0x1B, 0x19, 0x1A, 0x26, 0x25, // - 10                                    
    0x00, 0x24, 0x17, 0x25, 0x17, 0x24, 0x28, 0x17, 0x16, 0x2E, // - 10                                                 
    0x26, 0x1A, 0x13, 0x20, 0x1D, 0x00, 0x2B, 0x21, 0x27, 0x00, 0x18, 0x21, 0x24, // - 13                  
    0x22, 0x1E, 0x13, 0x2B, 0x1B, 0x20, 0x19, 0x2F, // - 8                                                 
    0x25, 0x22, 0x17, 0x15, 0x1B, 0x13, 0x1E, 0x00, 0x26, 0x1A, 0x13, 0x20, 0x1D, 0x25, // - 14            
    0x18, 0x24, 0x1B, 0x17, 0x20, 0x16, 0x25,   // 7                                                       
    0x13, 0x20, 0x16,   // 3                                                                               
    0x18, 0x13, 0x1F, 0x1B, 0x1E, 0x2B, // 6                                                               
    0x26, 0x21,  // - 2                                                                                     
    0x97, 0x99, 0x9B, 0x9D, 0x89, 0x8A, 0x00, 0x89, 0x8A, 0x8F, 0x90, 0x85, 0x86,    // 13
    0x98, 0x9A, 0x9C, 0x9E, 0x8B, 0x8C, 0x00, 0x8B, 0x8C, 0x91, 0x92, 0x87, 0x88    // 13
};

const UINT16 credentriesidx[] = {0, 5, 10, 16, 22, 28, 32, 44, 54, 60, 65, 71, 77, 87, 93, 103, 107, 114, 128, 140, 153, 163, 175, 191, 202, 213, 222, 232, 244, 249, 251, 261, 267, 280, 290, 299, 
	303, 307, 311, 323, 326, 336, 346, 356, 369, 377, 391, 398, 401, 407, 409, 422, 435};

const UINT8 credscreens[][9] = {
    {15, 99, 16, 17, 99, 0, 1, 3, 9},
    {16, 18, 99, 0, 1, 3, 4, 5, 10},
    {99, 16, 19, 99, 0, 1, 3, 99, 99},
    {99, 99, 4, 2, 5, 12, 99, 99, 99},
    {99, 16, 20, 99, 0, 1, 3, 99, 99},
    {99, 99, 4, 5, 6, 10, 11, 99, 99},
    {99, 16, 21, 99, 0, 1, 3, 4, 99},
    {99, 2, 5, 6, 7, 8, 13, 14, 99},
    {99, 16, 22, 99, 0, 1, 3, 4, 99},
    {99, 2, 5, 6, 7, 8, 14, 99, 99},
    {99, 16, 23, 99, 99, 14, 13, 99, 99},
    {24, 25, 26, 27, 28, 99, 29, 30, 31},
    {99, 32, 99, 99, 33, 34, 35, 99, 99},
    {99, 99, 36, 37, 38, 39, 40, 99, 99},
    {99, 45, 49, 99, 46, 47, 48, 99, 99},
    {99, 99, 41, 42, 99, 43, 44, 99, 99},
    {99, 99, 99, 50, 51, 99, 99, 99, 99}};

const UINT8 credscreenslength = 17; // Number of screens with credits
const UINT8 credpausedur = 180; // Total time a page stays on the screen
UINT8 animitr = 0;


void custom_delay(UINT8 cycles) NONBANKED;
void incr_oam_sprite_tile_idx(INT8 steps) NONBANKED;
void reset_sprites(UINT8 fstsprite, UINT8 lastsprite) NONBANKED;
void anim_blackout() NONBANKED;
void anim_reverse_blackout() NONBANKED;
void place_machine(Machine * mch, UINT8 x, UINT8 y) NONBANKED;
void build_boss_road() NONBANKED;
void disable_bkg_scroll(UINT8 stageidx) NONBANKED;
inline UINT8 get_tile_idx(UINT8 newidxnum) NONBANKED;
void build_road() NONBANKED;
void move_machine(Machine * mch, INT8 speedx, INT8 speedy) NONBANKED;
void scroll_textbox(UINT8 dialidx) BANKED;
UINT8 wait_player_input(UINT8 crsridx) BANKED;
void se_move_cursor2() BANKED;
void build_credits_road() BANKED;
void display_credits_page(UINT8 page, UINT8 halfscreenidx) BANKED;
void hide_win_layer() BANKED;
void display_epilogue() BANKED;
void anim_inverted_bw_to_blackout() BANKED;
void anim_blackout_to_inverted_bw() BANKED;
void display_credits() BANKED;



void scroll_textbox(UINT8 dialidx) BANKED {
    const UINT8 textoffsx = 1;
    // Character limit per line - 18
    fill_win_rect(0, 0, 20, 1, 0x00);
    move_win(11, 134);
    set_sprite_tile(39, 75);
    set_win_tile_xy(0, 0, 255);

    if(dialstartidx[dialidx] == 99) {
        return;
    }
    const UINT8 * textpos = dialoguearr + dialstartidx[dialidx];
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


void hide_win_layer() BANKED {
    HIDE_WIN;
}


void display_epilogue() BANKED {
    reset_sprites(0, 40);
    fill_win_rect(0, 0, 20, 1, 0);
    set_sprite_data(0, 3, fortsfiretiles);
    set_bkg_data(44, 92, endingcutsctiles);
    fill_bkg_rect(0, 0, 20, 18, 0);
    oamidx = 0;
    UINT8 cyclecnt = 1, textx = 1, texty = 20;
    const UINT8 * letter = epiloguetext;
    set_win_tiles(1, 1, 18, 8, endingcutscmap);
    move_bkg(0, 0);
    move_win(7, 0);
    SHOW_WIN;
    anim_blackout_to_inverted_bw();
    for(i = 0; i != 7; i++) {   // Initiating fire sprites
        move_sprite(oamidx, fires[i][0], fires[i][1]);
        set_sprite_tile(oamidx, fires[i][2]);
        incr_oam_sprite_tile_idx(1);
    }

    STAT_REG = 0x45;
    LYC_REG = 0x4F;
    add_LCD(hide_win_layer);
    enable_interrupts();
    set_interrupts(VBL_IFLAG | LCD_IFLAG);

    while(1) {
        SHOW_WIN;
        if(cyclecnt % 8 == 0) {
            scroll_bkg(0, 1);
            texty = SCY_REG;
            if(texty % 8 == 0) {   // Time to display a line of text
                texty = SCY_REG >> 3;   // Getting bkg tile
                texty = texty + 18 > 32 ? (texty - 32) + 18 : texty + 18;   // Writing text 18 tiles after the current scroll position index
                if(*letter != 0xFF && (texty == 0 || texty % 2 == 0)) {   // There is text to be displayed
                    for(textx = 1; *letter != 0xFE; textx++, letter++) {    // Display a line of text
                        set_bkg_tile_xy(textx, texty, *letter);
                    }
                    fill_bkg_rect(1, texty + 2, 18, 1, 0);  // Erasing the previously written memory before writing
                    letter++;   // Get past the 0xFE
                } else if(*letter == 0xFF) {
                    fill_bkg_rect(1, texty, 18, 1, 0);  // Erasing old text after no more text to display
                    if(SCY_REG > 0xB4) {    // When no more text to display, wait until the scroll gets to y > 180 and break out of loop
                        break;
                    }
                }
            }
        }
        
        if(cyclecnt == 16) {
            for(i = 0; i != 7; i++) {
                set_sprite_tile(i, get_sprite_tile(i) == 0 ? 1 : 0);    // Animate airbase flames
            }
            cyclecnt = 1;
        } else {
            cyclecnt++;
        }
        
        wait_vbl_done();
    }

    SHOW_WIN;
    reset_sprites(0, 7);
    anim_inverted_bw_to_blackout();
    LYC_REG = 0x00;
    __critical {
        remove_LCD(hide_win_layer);
    }
    move_bkg(0, 0);
    HIDE_WIN;
}


void anim_inverted_bw_to_blackout() BANKED {
    for(UINT8 blkstep = 0; blkstep != 21; blkstep++) {
        switch(blkstep) {
            case 1:
                BGP_REG = 0x67;
                break;
            case 10:
                BGP_REG = 0xAB;
                break;
            case 20:
                BGP_REG = 0xFF;
                break;
        }
        wait_vbl_done();
    }
}


void anim_blackout_to_inverted_bw() BANKED {
    for(UINT8 blkstep = 0; blkstep != 21; blkstep++) {
        switch(blkstep) {
            case 1:
                BGP_REG = 0xBF;
                break;
            case 10:
                BGP_REG = 0x7B;
                break;
            case 20:
                BGP_REG = 0x27;
                break;
        }
        wait_vbl_done();
    }
}


void se_move_cursor2() BANKED {
    NR10_REG = 0x00;
    NR11_REG = 0xCB;
    NR12_REG = 0xF2;
    NR13_REG = 0x9F;
    NR14_REG = 0x86;
}


void build_credits_road() BANKED {
    camtileidx = SCX_REG - 24;
    camtileidx >>= 3;
    if(camtileidx == nextcamtileidx) {
        set_bkg_tiles(camtileidx, 10, 3, 7, goodroadmap);
        nextcamtileidx = camtileidx - 3;
        nextcamtileidx = nextcamtileidx > 250 ? (camtileidx - 227) : nextcamtileidx;
    }
 }


 void display_credits_page(UINT8 page, UINT8 halfscreenidx) BANKED {
    if(page == 255) {  // Fake page index, indicates empty screen
        fill_bkg_rect(10 * halfscreenidx, 1, 10, 9, 0);
    } else {
        UINT8 lnlength, entrylength;
        for(i = 0; i != 9; i++) {
            if(credscreens[page][i] == 99) {
                continue;   // Fake index, indicates empty line
            }
            entrylength = credentriesidx[credscreens[page][i] + 1] - credentriesidx[credscreens[page][i]];
            if(halfscreenidx == 0) {
                lnlength = entrylength - (entrylength >> 1);
                set_bkg_tiles(10 - lnlength, i + 1, lnlength, 1, credentries + credentriesidx[credscreens[page][i]]);
            } else {
                lnlength = entrylength >> 1;
                set_bkg_tiles(10, i + 1, lnlength, 1, credentries + (entrylength - lnlength) + credentriesidx[credscreens[page][i]]);
                if(credscreens[page][i] == 16) {    // Stage sign
                    set_bkg_tile_xy(12, i + 1, 9 + pl->cyccount);   // Adding stage number
                    pl->cyccount++;
                }
            }
        }   
    }
 }


void display_credits() BANKED {
    INT8 creditsspeedx = 4;
    UINT8 pageidx = 0;
    UBYTE displaycred = 1;  // Display or remove credits from screen indicator
    nextcamtileidx = 26;
    animitr = 0;
    for(i = 20; i != 32; i +=3) {
        set_bkg_tiles(i, 10, 3, 7, goodroadmap);
    }
    place_machine(pl, 136, 114);
    fill_win_rect(0, 0, 20, 2, 0);
    fill_bkg_rect(0, 1, 32, 9, 0);
    for(i = 0; i != 4; i++) {   // Flip player sprite
        set_sprite_prop(i, 32);
    }
    set_sprite_tile(0, 3);
    set_sprite_tile(1, 1);
    set_sprite_tile(2, 4);
    set_sprite_tile(3, 2);

    custom_delay(7);
    anim_reverse_blackout();

    pl->cyccount = 1;   // Used for stage counter in credits
    while(1) {
        __critical {
            cloudposx -= 1;
            sceneryposx -= creditsspeedx;
            roadposx -= 4;
        }
        build_credits_road();

        if(pageidx != 255) {
            if(sceneryposx == 176) {
                display_credits_page(displaycred ? pageidx : 255, 1);   // Display or clear second half of page
            } else if(sceneryposx == 96) {
                if(displaycred) {
                    display_credits_page(pageidx, 0);   // Display first half of page
                    pageidx++;
                    creditsspeedx = 4;
                } else {
                    display_credits_page(255, 0);   // Clear first page from screen
                }
                displaycred = !displaycred;
            } else if(sceneryposx == 0 && !displaycred) {
                if(animitr == 0) {
                    creditsspeedx = 0;  // Pause credits scroll
                    animitr = 1;
                } else if(animitr == credpausedur) {
                    if(pageidx == credscreenslength) {  // All pages displayed
                        pageidx = 255;
                        continue;
                    }
                    animitr = 0;
                    creditsspeedx = 8;  // Resume credits scroll
                } else {
                    animitr++;
                }
            }
        }
        
        if((pageidx == credscreenslength - 1) && pl->x != 245) {
            move_machine(pl, -1, 0);
        }
        wait_vbl_done();
    }
}


