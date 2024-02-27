#include <gb/gb.h>
#include "machine.c"
#include "hUGEDriver.h"


extern const hUGESong_t creditstheme;
extern UINT8 i, cloudposx, sceneryposx, roadposx, camtileidx, nextcamtileidx, animitr;
extern Machine * pl;
extern UINT8 goodroadmap[];

const UINT8 credscreenslength = 15; // Number of screens with credits
const UINT8 credpausedur = 180; // Total time a page stays on the screen during credits
const UINT8 extraspasssign[] =  {0x23, 0x14, 0x26, 0x26, 0x2A, 0x22, 0x25, 0x17, 0x2E, 0x28, 0x25, 0x27, 0x1B};

const UINT8 credentries[] = {
    0x25, 0x1C, 0x17, 0x18, 0x25, // - 5                                                                   
    0x17, 0x25, 0x22, 0x21, 0x18, // - 5                                                                   
    0x25, 0x22, 0x16, 0x1E, 0x18, 0x27, // - 6                                                             
    0x27, 0x28, 0x25, 0x25, 0x18, 0x27, // - 6                                                             
    0x15, 0x22, 0x20, 0x15, 0x18, 0x25, // - 6                                                             
    0x20, 0x1C, 0x21, 0x18, // - 4                                                                         
    0x1F, 0x14, 0x26, 0x18, 0x25, 0x00, 0x27, 0x28, 0x25, 0x25, 0x18, 0x27, // - 12                        
    0x27, 0x25, 0x1C, 0x34, 0x27, 0x28, 0x25, 0x25, 0x18, 0x27, // - 10                                    
    0x26, 0x18, 0x18, 0x1E, 0x18, 0x25, // - 6                                                             
    0x26, 0x16, 0x22, 0x25, 0x23, // - 5                                                                   
    0x19, 0x18, 0x25, 0x1C, 0x28, 0x20, // - 6                                                             
    0x25, 0x14, 0x17, 0x1C, 0x28, 0x20, // - 6                                                             
    0x1D, 0x28, 0x1A, 0x1A, 0x18, 0x25, 0x21, 0x14, 0x28, 0x27, // - 10                                    
    0x28, 0x1F, 0x27, 0x1A, 0x18, 0x21, // - 6                                                             
    0x14, 0x1C, 0x25, 0x15, 0x14, 0x26, 0x18, 0x00, 0x14, 0x1C, // - 10                                                                                                                                          
    0x16, 0x14, 0x26, 0x27, // - 4                                                                         
    0x26, 0x27, 0x14, 0x1A, 0x18, 0x00, 0x00, // - 7
    0x17, 0x18, 0x26, 0x18, 0x25, 0x27, 0x00, 0x1B, 0x1C, 0x1A, 0x1B, 0x2A, 0x14, 0x2C, // - 14            
    0x16, 0x14, 0x23, 0x27, 0x1C, 0x29, 0x18, 0x00, 0x16, 0x1C, 0x27, 0x2C, // - 12                        
    0x20, 0x22, 0x28, 0x21, 0x27, 0x14, 0x1C, 0x21, 0x00, 0x23, 0x14, 0x26, 0x26, // - 13                  
    0x26, 0x1E, 0x2C, 0x00, 0x27, 0x28, 0x21, 0x21, 0x18, 0x1F, // - 10                                    
    0x19, 0x22, 0x25, 0x27, 0x00, 0x26, 0x27, 0x25, 0x14, 0x27, 0x22, 0x26, // - 12                        
    0x28, 0x21, 0x17, 0x18, 0x25, 0x1A, 0x25, 0x22, 0x28, 0x21, 0x17, 0x00, 0x1B, 0x14, 0x1F, 0x1F, 0x26, // - 17
    0x18, 0x21, 0x18, 0x25, 0x1A, 0x2C, 0x00, 0x16, 0x22, 0x25, 0x18, // - 11                              
    0x23, 0x25, 0x22, 0x1A, 0x25, 0x14, 0x20, 0x20, 0x1C, 0x21, 0x1A, // - 11                              
    0x23, 0x1C, 0x2B, 0x18, 0x1F, 0x00, 0x14, 0x25, 0x27, // - 9                                           
    0x22, 0x26, 0x27, 0x00, 0x14, 0x21, 0x17, 0x00, 0x26, 0x18, // - 10                                    
    0x1F, 0x18, 0x29, 0x18, 0x1F, 0x00, 0x17, 0x18, 0x26, 0x1C, 0x1A, 0x21, // - 12                        
    0x26, 0x27, 0x22, 0x25, 0x2C, // - 5                                                                   
    0x15, 0x2C, // - 2                                                                                     
    0x1E, 0x22, 0x21, 0x26, 0x27, 0x14, 0x21, 0x27, 0x1C, 0x21, // - 10                                    
    0x17, 0x22, 0x15, 0x25, 0x18, 0x29, // - 6                                                             
    0x28, 0x26, 0x18, 0x17, 0x00, 0x26, 0x22, 0x19, 0x27, 0x2A, 0x14, 0x25, 0x18, // - 13                  
    0x20, 0x26, 0x00, 0x29, 0x26, 0x00, 0x16, 0x22, 0x17, 0x18, // - 10                                    
    0x1A, 0x15, 0x17, 0x1E, 0x00, 0x0C, 0x0A, 0x0C, 0x0A, // - 9                                           
    0x1A, 0x1C, 0x20, 0x23, // - 4                                                                         
    0x1A, 0x15, 0x27, 0x17, // - 4                                                                         
    0x1A, 0x15, 0x20, 0x15, // - 4                                                                         
    0x1B, 0x28, 0x1A, 0x18, 0x00, 0x27, 0x25, 0x14, 0x16, 0x1E, 0x18, 0x25, // - 12                        
    0x15, 0x1A, 0x15, // - 3                                                                               
    0x18, 0x20, 0x28, 0x1F, 0x1C, 0x16, 0x1C, 0x22, 0x28, 0x26, // - 10                                    
    0x14, 0x1F, 0x1F, 0x00, 0x25, 0x1C, 0x1A, 0x1B, 0x27, 0x26, // - 10                                    
    0x00, 0x25, 0x18, 0x26, 0x18, 0x25, 0x29, 0x18, 0x17, 0x2F, // - 10                                                 
    0x27, 0x1B, 0x14, 0x21, 0x1E, 0x00, 0x2C, 0x22, 0x28, 0x00, 0x19, 0x22, 0x25, // - 13                  
    0x23, 0x1F, 0x14, 0x2C, 0x1C, 0x21, 0x1A, 0x30, // - 8                                                 
    0x26, 0x23, 0x18, 0x16, 0x1C, 0x14, 0x1F, 0x00, 0x27, 0x1B, 0x14, 0x21, 0x1E, 0x26, // - 14            
    0x19, 0x25, 0x1C, 0x18, 0x21, 0x17, 0x26,   // 7                                                       
    0x14, 0x21, 0x17,   // 3                                                                               
    0x19, 0x14, 0x20, 0x1C, 0x1F, 0x2C, // 6                                                               
    0x27, 0x22,  // - 2                                                                                     
    0x98, 0x9A, 0x9C, 0x9E, 0x8A, 0x8B, 0x00, 0x8A, 0x8B, 0x90, 0x91, 0x86, 0x87,    // 13
    0x99, 0x9B, 0x9D, 0x9F, 0x8C, 0x8D, 0x00, 0x8C, 0x8D, 0x92, 0x93, 0x88, 0x89,    // 13
    0x18, 0x2B, 0x27, 0x25, 0x14, 0x26, 0x00, 0x23, 0x14, 0x26, 0x26, 0x2A, 0x22, 0x25, 0x17, 0x2E, // 16
    0x28, 0x25, 0x27, 0x1B  // 4
};

const UINT16 credentriesidx[] = {0, 5, 10, 16, 22, 28, 32, 44, 54, 60, 65, 71, 77, 87, 93, 103, 107, 114, 128, 140, 153, 163, 175, 192, 203, 214, 223, 233, 245, 250, 252, 262, 268, 281, 291, 300, 
	304, 308, 312, 324, 327, 337, 347, 357, 370, 378, 392, 399, 402, 408, 410, 423, 436, 452, 456};


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
    {99, 45, 49, 99, 46, 47, 48, 99, 99},
    {99, 99, 41, 42, 99, 43, 44, 99, 99},
    {99, 99, 99, 50, 51, 99, 99, 99, 99}
};



void custom_delay(UINT8 cycles) NONBANKED;
void anim_reverse_blackout() NONBANKED;
void place_machine(Machine * mch, UINT8 x, UINT8 y) NONBANKED;
void build_road() NONBANKED;
void move_machine(Machine * mch, INT8 speedx, INT8 speedy) NONBANKED;
void toggle_mute_music(UINT8 toggleon) NONBANKED;
void build_credits_road() BANKED;
void display_credits_page(UINT8 page, UINT8 halfscreenidx) BANKED;
void play_credits() BANKED;



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
                    set_bkg_tile_xy(12, i + 1, 10 + pl->cyccount);   // Adding stage number
                    pl->cyccount++;
                }
            }
        }   
    }
 }


void play_credits() BANKED {
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
    set_win_tiles(2, 0, 13, 1, extraspasssign);
    hUGE_init(&creditstheme);
    toggle_mute_music(0);
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
        hUGE_dosound();
        wait_vbl_done();
    }
}
