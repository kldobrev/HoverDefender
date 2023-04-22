#include "machine.c"
#include "placement.c"
#include "tiles/tunneltiles.c"
#include "tiles/fortstiles.c"
#include "tiles/fortsinttiles.c"
#include "maps/tunnelmap.c"
#include "maps/fortsmap.c"
#include "maps/fortsintmap.c"


extern Machine * pl;


// Stage 4 data
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



// Stage 5 data
const UINT8 stage5road[] = {140, 30, 50, 30, 120, 70, 80, 40, 100, 50, 150, 80, 90, 40, 150, 50, 100, 50, 145, 15, 50, 30, 30, 30, 55, 30, 30, 30, 35, 30, 30, 35, 150};
const Placement stage5objs[] = {
{0, 30, 50, 1}, {0, 45, 96, 0}, {0, 50, 30, 4}, {0, 75, 127, 0}, {0, 80, 40, 4}, {0, 105, 114, 0}, {0, 110, 60, 1}, {1, 10, 133, 3},
{2, 20, 50, 8}, {4, 30, 40, 8}, {4, 45, 127, 0}, {4, 60, 20, 8}, {4, 75, 127, 0}, {4, 90, 30, 8}, {5, 10, 133, 3}, {5, 30, 133, 3}, {5, 50, 133, 3},
{6, 20, 50, 8}, {6, 21, 127, 2}, {6, 40, 30, 8}, {6, 41, 100, 2}, {6, 60, 40, 8}, {6, 61, 114, 2}, {7, 20, 16, 6}, 
{8, 20, 40, 8}, {8, 30, 114, 0}, {8, 80, 16, 7}, {9, 15, 133, 3}, {9, 25, 16, 7}, {10, 26, 127, 0}, {10, 40, 16, 7}, {10, 66, 96, 0}, {10, 80, 16, 7}, 
{10, 106, 127, 0}, {10, 120, 16, 7}, {11, 15, 133, 3}, {11, 25, 16, 7}, {11, 35, 133, 3}, {11, 45, 16, 7}, {11, 55, 133, 3}, {11, 65, 16, 7},
{12, 20, 70, 2}, {12, 25, 100, 5}, {12, 30, 70, 2}, {12, 35, 70, 2}, {12, 40, 127, 5}, {12, 45, 70, 2}, {12, 50, 70, 2}, {12, 55, 100, 5}, {12, 60, 70, 2}, 
{12, 65, 70, 2}, {12, 70, 127, 5}, {13, 15, 133, 3}, {13, 20, 16, 6}, {14, 15, 127, 5}, {14, 17, 40, 4}, {14, 32, 114, 5}, {14, 42, 35, 8}, {14, 52, 100, 5}, 
{14, 62, 50, 4}, {14, 72, 114, 5}, {14, 82, 50, 8}, {14, 92, 127, 5}, {14, 102, 30, 4}, {14, 112, 114, 5}, {14, 122, 40, 8}, 
{15, 20, 16, 6}, {15, 25, 133, 3}, {15, 35, 16, 7}, {16, 20, 30, 4}, {16, 35, 16, 7}, {16, 40, 40, 4}, {16, 55, 16, 6}, {16, 60, 30, 4}, {16, 75, 16, 7},
{17, 10, 70, 8}, {17, 20, 133, 3}, {17, 30, 60, 8}, {18, 20, 40, 8}, {18, 30, 127, 5}, {18, 33, 70, 2}, {18, 40, 50, 1}, {18, 50, 114, 5}, {18, 53, 70, 2}, 
{18, 60, 60, 8}, {18, 70, 100, 5}, {18, 73, 70, 2}, {18, 80, 60, 1}, {18, 90, 114, 5}, {18, 93, 70, 2}, {18, 100, 70, 8}, {18, 110, 127, 5}, {18, 113, 70, 2}, {18, 120, 40, 1},
{20, 10, 114, 0}, {20, 15, 40, 8}, {21, 10, 133, 3}, {22, 10, 114, 5}, {22, 12, 40, 8}, {23, 10, 133, 3}, {24, 16, 114, 0}, {24, 30, 16, 7}, 
{25, 10, 133, 3}, {25, 15, 16, 7}, {26, 10, 60, 4}, {26, 18, 100, 2}, {26, 19, 129, 2}, {27, 10, 133, 3}, {28, 10, 16, 6}, {28, 13, 127, 2}, {28, 15, 40, 4},
{29, 10, 16, 6}, {29, 18, 133, 3}, {30, 10, 114, 5}, {30, 12, 50, 8}, {31, 8, 20, 8}, {31, 20, 133, 3}, {31, 25, 16, 6},
{32, 10, 129, 2}, {32, 16, 100, 2}, {32, 22, 116, 2}, {32, 30, 105, 2}, {32, 31, 125, 2}, {32, 33, 60, 2}, {32, 45, 127, 2}, {32, 46, 86, 2}, {32, 48, 50, 2}, 
{32, 60, 110, 2}, {32, 61, 84, 2}, {32, 63, 50, 2}, {32, 75, 105, 2}, {32, 76, 125, 2}, {32, 78, 60, 2}, {32, 90, 110, 2}, {32, 91, 84, 2}, {32, 93, 50, 2}, 
{32, 105, 127, 2}, {32, 106, 86, 2}, {32, 108, 50, 2}
};



// Stage 6 data
const UINT8 stage6road[] = {60, 15, 193, 20, 135, 15, 145, 60, 110, 20, 175, 70, 100, 20, 160, 75, 155, 20, 245, 85, 120, 80, 15, 15, 45, 20, 18, 20, 18, 30, 25, 23, 45, 30, 30, 25, 30, 35, 50};
const Placement stage6objs[] = {
{0, 20, 114, 0}, {2, 20, 127, 0}, {2, 45, 96, 0}, {2, 70, 127, 0}, {2, 79, 30, 1}, {2, 95, 96, 0}, {2, 104, 50, 1}, {2, 120, 127, 0}, {2, 129, 30, 1}, {2, 145, 114, 0}, 
{2, 154, 50, 1}, {3, 5, 133, 3}, {4, 15, 127, 0}, {4, 47, 96, 5}, {4, 50, 114, 0}, {4, 82, 96, 5}, {4, 87, 96, 0}, {4, 122, 127, 5}, {6, 20, 30, 4}, {6, 30, 96, 0}, 
{6, 35, 40, 1}, {6, 60, 127, 0}, {6, 75, 30, 4}, {6, 85, 50, 1}, {6, 95, 114, 0}, {6, 110, 30, 4}, {6, 120, 40, 1}, {7, 15, 133, 3}, {7, 35, 133, 3}, 
{8, 15, 35, 4}, {8, 35, 127, 2}, {8, 36, 45, 4}, {8, 55, 96, 2}, {8, 56, 45, 4}, {8, 75, 127, 2}, {8, 76, 55, 4}, {8, 95, 114, 2},
{10, 20, 127, 5}, {10, 21, 35, 4}, {10, 40, 96, 5}, {10, 45, 50, 1},  {10, 60, 114, 5}, {10, 61, 35, 4}, {10, 80, 127, 5}, {10, 85, 40, 1}, {10, 100, 96, 5}, 
{10, 105, 35, 4}, {10, 125, 114, 5}, {10, 130, 50, 1}, {10, 145, 127, 5}, {10, 150, 35, 4}, {11, 10, 133, 3}, {11, 30, 133, 3}, {11, 50, 133, 3}, 
{12, 22, 70, 2}, {12, 25, 96, 5}, {12, 32, 70, 2}, {12, 35, 114, 5}, {12, 42, 70, 2}, {12, 45, 127, 5},  {12, 52, 70, 2}, {12, 55, 114, 5}, {12, 62, 70, 2}, 
{12, 65, 96, 5}, {12, 72, 70, 2}, {12, 75, 114, 5}, {12, 82, 70, 2}, {14, 20, 16, 6}, {14, 23, 114, 0}, {14, 30, 45, 4}, {14, 40, 16, 6}, {14, 48, 96, 0}, 
{14, 60, 30, 4}, {14, 70, 16, 6}, {14, 78, 127, 0}, {14, 85, 40, 4}, {14, 90, 16, 6}, {14, 98, 96, 0}, {14, 110, 30, 4}, {14, 123, 114, 0}, {14, 128, 16, 6},
{15, 8, 16, 6}, {15, 15, 133, 3}, {15, 28, 16, 6}, {15, 35, 133, 3}, {15, 48, 16, 6}, {15, 55, 133, 3}, {16, 20, 16, 7}, {16, 30, 30, 4}, {16, 40, 16, 6}, 
{16, 55, 45, 4}, {16, 70, 16, 7}, {16, 75, 45, 4}, {16, 90, 16, 6}, {16, 95, 55, 4}, {16, 115, 16, 7}, {16, 130, 50, 4}, {16, 135, 16, 6},
{18, 20, 114, 0}, {18, 30, 40, 8}, {18, 50, 96, 0}, {18, 52, 30, 4}, {18, 80, 127, 0}, {18, 90, 40, 8}, {18, 110, 96, 0}, {18, 112, 50, 4}, {18, 140, 114, 0}, 
{18, 150, 50, 8}, {18, 170, 127, 0}, {18, 172, 30, 4}, {18, 200, 96, 0}, {18, 220, 40, 8}, {19, 10, 133, 3}, {19, 20, 55, 8}, {19, 30, 133, 3}, {19, 40, 80, 8}, 
{19, 50, 133, 3}, {19, 60, 50, 8}, {20, 20, 127, 2}, {20, 21, 86, 2}, {20, 24, 50, 2}, {20, 35, 110, 2}, {20, 36, 84, 2}, {20, 38, 50, 2}, {20, 50, 105, 2}, {20, 51, 125, 2}, 
{20, 53, 60, 2}, {20, 65, 127, 2}, {20, 66, 86, 2}, {20, 68, 50, 2}, {20, 80, 105, 2}, {20, 81, 125, 2}, {20, 83, 60, 2}, {20, 95, 110, 2}, {20, 96, 84, 2}, 
{20, 98, 50, 2}, {21, 10, 133, 3}, {21, 20, 16, 7}, {21, 30, 133, 3}, {21, 40, 16, 7}, {21, 50, 133, 3}, {21, 60, 16, 7}, {24, 5, 127, 0}, {25, 5, 133, 3}, {26, 5, 127, 5},
{27, 5, 133, 3}, {28, 5, 114, 2}, {29, 5, 133, 3}, {29, 15, 16, 6}, {30, 5, 96, 5}, {30, 8, 50, 1}, {31, 5, 133, 3}, {32, 5, 16, 6}, {32, 8, 127, 0}, 
{33, 5, 133, 3}, {33, 15, 16, 7}, {34, 3, 50, 4}, {34, 15, 16, 7}, {35, 3, 30, 8}, {35, 10, 133, 3}, {36, 5, 114, 5}, {36, 15, 40, 8}, 
{37, 5, 70, 8}, {37, 10, 133, 3}, {37, 20, 16, 7}
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
    if(mch->x == 55) {
        fire_projctl(mch, 1, -1, 2);
        fire_projctl(mch, 1, 0, 2);
        fire_projctl(mch, 1, 1, 2);
    }
}


void exec_seeker_pattern(Machine * mch) BANKED {
    if(pl->y == mch->y) {
        move_enemy(mch, -1, 0);
    } else if(pl->y > mch->y) {
        move_enemy(mch, -1, 1);
    } else {
        move_enemy(mch, -1, -1);
    }
    if(mch->groundflg != pl->groundflg) {
        mch->groundflg = pl->groundflg;
    }
}

