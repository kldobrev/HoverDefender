#include <gb/gb.h>
#include "../tiles/citytiles.c"
#include "../maps/citymap.c"


extern Machine machines[], * crntenemy, * pl;
extern UINT8 pllives, bossclearflg, lockmvmnt;


// Stage 2 data
const UINT8 stage2road[] = {70, 30, 110, 10, 20, 10, 120, 10, 10, 10, 10, 20, 50, 10, 120, 40, 130, 10, 10, 10, 10, 10, 10, 10, 160};
const Placement stage2objs[] = {{0, 40, 167, 114, 0}, {1, 15, 167, 133, 3}, 
{2, 10, 167, 60, 1}, {2, 20, 167, 96, 0}, {2, 40, 167, 133, 0}, {2, 50, 167, 30, 4}, {2, 65, 167, 114, 0},
{4, 5, 167, 30, 1},  {6, 10, 167, 133, 0}, {6, 18, 167, 30, 4}, {6, 35, 167, 96, 0}, {6, 45, 167, 50, 4}, {6, 60, 167, 114, 0}, {6, 80, 167, 40, 4},
{11, 9, 167, 133, 3}, {12, 15, 167, 133, 5}, {14, 20, 167, 96, 0}, {14, 55, 167, 133, 5}, {14, 60, 167, 96, 0}, {14, 95, 167, 133, 5},
{15, 9, 167, 133, 3}, {15, 32, 167, 133, 3}, {16, 9, 167, 96, 5}, {16, 14, 167, 60, 1}, {16, 15, 167, 114, 0}, {16, 50, 167, 96, 5}, {16, 55, 167, 60, 1}, {16, 80, 167, 133, 0},
{20, 3, 167, 114, 5}, {22, 1, 167, 50, 1},
{24, 10, 167, 30, 4}, {24, 20, 167, 96, 0}, {24, 35, 167, 50, 1}, {24, 55, 167, 133, 0}, {24, 65, 167, 40, 4}, 
{24, 80, 167, 50, 1}, {24, 95, 167, 114, 0}, {24, 110, 167, 30, 4}, {24, 120, 167, 50, 1}};



void init_machine_props(UINT8 x, UINT8 y, const INT8 * mchprops) NONBANKED;
void set_machine_tile(Machine * mch, UINT8 tlnum) NONBANKED;
void place_machine(Machine * mch, UINT8 x, UINT8 y) NONBANKED;
inline void itr_enemies_ptr() NONBANKED;
void move_enemy(Machine * en, INT8 speedx, INT8 speedy) NONBANKED;
inline UBYTE is_alive(Machine * mch) NONBANKED;
UBYTE cooldown_enemy(Machine * mch, UINT8 period) NONBANKED;
void fire_bigbullet(Machine * mch, INT8 speedx, INT8 speedy) NONBANKED;
void take_damage(Machine * mch, UINT8 dmgamt) NONBANKED;
void manage_projectiles() NONBANKED;
void manage_machines() NONBANKED;
void anim_jump() NONBANKED;
void clear_all_projectiles() NONBANKED;
void manage_sound_chnls() NONBANKED;
void manage_player() NONBANKED;
