
#include "machine.c"
#include "placement.c"
#include "tiles/tunneltiles.c"
#include "maps/tunnelmap.c"



extern Machine * pl;


// Stage 4 data
/*const UINT8 stage3road_copy[] = {90, 15, 100, 45, 90, 85, 47, 20, 55, 20, 40, 20, 150, 20, 110, 20, 150, 20, 10, 10, 12, 10, 12, 10, 12, 10, 170};
const Placement stage3objs_copy[] = {{0, 45, 167, 40, 4}, {0, 55, 167, 130, 5},
{2, 20, 167, 130, 5}, {2, 25, 167, 98, 0}, {2, 35, 167, 98, 5}, {2, 40, 167, 130, 0}, {2, 65, 167, 60, 1}, {3, 25, 167, 133, 3},
{4, 20, 167, 50, 1}, {4, 35, 167, 35, 4}, {4, 40, 167, 130, 5}, {4, 55, 167, 35, 4}, {4, 65, 167, 50, 1},
{5, 20, 167, 133, 3}, {5, 42, 167, 133, 3}, {5, 64, 167, 133, 3}, {6, 20, 167, 112, 2},
{8, 20, 167, 130, 2}, {8, 30, 167, 98, 2}, {8, 40, 167, 112, 2},
{10, 15, 167, 130, 2}, {10, 16, 167, 94, 2}, {10, 18, 167, 50, 2},
{12, 30, 167, 98, 0}, {12, 40, 167, 40, 4}, {12, 50, 167, 130, 0}, {12, 60, 167, 60, 4}, 
{12, 70, 167, 98, 0}, {12, 80, 167, 40, 4}, {12, 90, 167, 130, 0}, {12, 100, 167, 60, 4}, {12, 110, 167, 114, 0},
{14, 25, 167, 50, 4}, {14, 40, 167, 130, 2}, {14, 50, 167, 98, 2}, {14, 55, 167, 50, 4},
{14, 65, 167, 130, 2}, {14, 75, 167, 60, 4}, {14, 85, 167, 112, 2},
{16, 20, 167, 114, 0}, {16, 30, 167, 60, 2}, {16, 40, 167, 98, 0}, {16, 50, 167, 60, 2}, 
{16, 60, 167, 130, 0}, {16, 70, 167, 60, 2}, {16, 80, 167, 98, 0}, {16, 90, 167, 60, 2}, 
{16, 100, 167, 114, 0}, {16, 110, 167, 60, 2}, {20, 5, 167, 130, 2}, {22, 5, 167, 98, 2}, {24, 5, 167, 112, 2},
{26, 20, 167, 40, 4}, {26, 30, 167, 60, 4}, {26, 40, 167, 40, 4}, {26, 50, 167, 60, 4}, {26, 60, 167, 40, 4}, {26, 70, 167, 60, 4}, 
{26, 80, 167, 40, 4}, {26, 90, 167, 60, 4}, {26, 100, 167, 40, 4}, {26, 110, 167, 60, 4}
};*/

// Enemies order - 0 - rider, 1 - drone, 2 - rocket, 3 - turret, 4 - bomber, 5 - mine, 6 - explosion, 7 - laser turret, 8 - tri-turret, 9 - seeker
const UINT8 stage4road[] = {100, 30, 20};   // In Progress
const Placement stage4objs[] = {{0, 40, 167, 16, 9}};   // In Progress





void fire_projctl(Machine * mch, UINT8 type, INT8 speedx, INT8 speedy) NONBANKED;
void move_enemy(Machine * en, INT8 speedx, INT8 speedy) NONBANKED;
void exec_laserturret_pattern(Machine * mch) BANKED;
void exec_triturret_pattern(Machine * mch) BANKED;
void exec_seeker_pattern(Machine * mch) BANKED;




void exec_laserturret_pattern(Machine * mch) BANKED {
    move_enemy(mch, -2, 0);
    if(mch->x == 131 || mch->x == 75 || mch->x == 23) {
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

