
#include "machine.c"
#include "placement.c"
#include "tiles/tunneltiles.c"
#include "maps/tunnelmap.c"


extern Machine * pl;


const UINT8 stage4road[] = {210, 20, 110, 30, 100, 10, 115, 40, 180, 70, 115, 20, 90, 40, 100, 20, 145, 95, 20, 10, 50, 10, 35, 20, 50, 30, 25, 30, 25, 30, 120};
const Placement stage4objs[] = {{0, 40, 114, 0}, {0, 60, 96, 0}, {0, 80, 114, 0}, {0, 100, 127, 0}, {0, 120, 96, 0},
 {0, 140, 114, 0}, {0, 160, 127, 0}, {2, 25, 16, 6}, {2, 60, 114, 5}, {2, 75, 96, 5}, {2, 90, 127, 5}, {3, 15, 133, 3}, 
 {4, 20, 114, 0}, {4, 30, 16, 6}, {4, 40, 114, 0}, {4, 50, 16, 6}, {4, 60, 114, 0}, 
 {6, 20, 40, 1}, {6, 35, 133, 5}, {6, 45, 30, 1}, {6, 60, 133, 5}, {6, 70, 50, 1}, {6, 85, 133, 5}, {6, 95, 60, 1},
 {7, 15, 133, 3}, {7, 20, 16, 6}, {8, 20, 50, 4}, {8, 40, 96, 0}, {8, 60, 127, 0}, {8, 70, 30, 1}, {8, 75, 96, 0}, 
 {8, 90, 40, 4}, {8, 105, 127, 0}, {8, 127, 50, 1}, {8, 140, 96, 0}, {9, 10, 133, 3}, {9, 30, 133, 3}, {9, 50, 133, 3},
 {10, 20, 50, 1}, {10, 40, 127, 5}, {10, 45, 16, 6}, {10, 55, 30, 1}, {10, 60, 96, 5}, {10, 70, 30, 1}, {10, 85, 127, 5}, {10, 100, 16, 6}, 
 {12, 10, 127, 0}, {12, 15, 40, 4}, {12, 30, 127, 0}, {12, 35, 50, 4}, {12, 50, 127, 0}, {12, 55, 30, 4}, {13, 20, 16, 6}, 
 {14, 20, 50, 4}, {14, 35, 16, 6}, {14, 45, 30, 4}, {14, 60, 16, 6}, {14, 70, 40, 4}, 
 {16, 20, 127, 0}, {16, 30, 16, 6}, {16, 45, 40, 1}, {16, 55, 96, 0}, {16, 65, 16, 6}, {16, 80, 40, 1}, {16, 90, 114, 0}, {16, 95, 40, 1},
 {17, 10, 133, 3}, {17, 25, 16, 6}, {17, 35, 133, 3}, {17, 50, 16, 6}, {17, 60, 133, 3}, {17, 75, 16, 6}, {20, 10, 96, 0},
 {22, 15, 16, 6}, {24, 10, 114, 0}, {24, 15, 16, 6}, {25, 15, 133, 3}, {25, 20, 16, 6}, {26, 10, 96, 5}, {27, 15, 133, 3}, 
 {28, 10, 96, 5}, {28, 15, 16, 6}, {29, 15, 133, 3}, {29, 20, 16, 6}, {30, 10, 127, 5}, {30, 20, 114, 5}, {30, 30, 96, 5}, 
 {30, 40, 114, 5}, {30, 50, 127, 5}, {30, 60, 114, 5}, {30, 70, 96, 5}, {30, 80, 114, 5}
 };



void fire_projctl(Machine * mch, UINT8 type, INT8 speedx, INT8 speedy) NONBANKED;
void move_enemy(Machine * en, INT8 speedx, INT8 speedy) NONBANKED;
void exec_laserturret_pattern(Machine * mch) BANKED;
void exec_triturret_pattern(Machine * mch) BANKED;
void exec_seeker_pattern(Machine * mch) BANKED;



void exec_laserturret_pattern(Machine * mch) BANKED {
    move_enemy(mch, -2, 0);
    if(mch->x == 117 || mch->x == 75 || mch->x == 23) {
        fire_projctl(mch, 5, 0, 3);
    }
}


void exec_triturret_pattern(Machine * mch) BANKED {
    move_enemy(mch, -2, 0);
    if(mch->x == 71) {
        fire_projctl(mch, 0, -1, 2);
        fire_projctl(mch, 0, 0, 2);
        fire_projctl(mch, 0, 1, 2);
    }
}


void exec_seeker_pattern(Machine * mch) BANKED {
    move_enemy(mch, -1, 0);
    if(pl->y > mch->y) {
        move_enemy(mch, 0, 1);
    } else if(pl->y != mch->y) {
        move_enemy(mch, 0, -1);
    }
    if(mch->groundflg != pl->groundflg) {
        mch->groundflg = pl->groundflg;
    }
}

