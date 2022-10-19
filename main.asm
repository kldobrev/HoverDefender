;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.0 #12072 (MINGW32)
;--------------------------------------------------------
	.module main
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _init_scorpboss_gun
	.globl b_demo_end_screen
	.globl _demo_end_screen
	.globl b_game_over_menu
	.globl _game_over_menu
	.globl b_stage_intro_screen
	.globl _stage_intro_screen
	.globl b_main_menu
	.globl _main_menu
	.globl b_init_stage_road
	.globl _init_stage_road
	.globl _hUGE_mute_channel
	.globl _hUGE_dosound
	.globl _hUGE_init
	.globl _fill_bkg_rect
	.globl _set_sprite_data
	.globl _set_win_tile_xy
	.globl _set_win_tiles
	.globl _set_win_data
	.globl _set_bkg_tiles
	.globl _set_bkg_data
	.globl _wait_vbl_done
	.globl _set_interrupts
	.globl _disable_interrupts
	.globl _enable_interrupts
	.globl _waitpad
	.globl _joypad
	.globl _add_LCD
	.globl _add_VBL
	.globl _remove_LCD
	.globl _remove_VBL
	.globl _menuidx
	.globl _explcord
	.globl _numkills
	.globl _plgun
	.globl _gradient
	.globl _slope
	.globl _precfctr
	.globl _chmutedcyccnt
	.globl _isapressed
	.globl _holeendx
	.globl _holestartx
	.globl _jumpstarty
	.globl _ascendflg
	.globl _fallinholeflg
	.globl _iframeflg
	.globl _iframecnt
	.globl _lockmvmnt
	.globl _pllives
	.globl _machptr
	.globl _crntenemy
	.globl _pl
	.globl _machines
	.globl _abtncnt
	.globl _prjcnt
	.globl _pjctptr
	.globl _crntpjct
	.globl _projectiles
	.globl _checktile
	.globl _oamidx
	.globl _plspeed
	.globl _cloudposx
	.globl _sceneryposx
	.globl _roadposx
	.globl _sitr
	.globl _citr
	.globl _i
	.globl _nextcamtileidx
	.globl _camtileidx
	.globl _roadbuildidx
	.globl _stagenum
	.globl _crntstage
	.globl _lvlplacptr
	.globl _lvlobjscnt
	.globl _bossclearflg
	.globl _stageclearflg
	.globl _holeflg
	.globl _stageidx
	.globl _enprops
	.globl _stingprops
	.globl _scorpgunprops
	.globl _plprops
	.globl _genexplcord
	.globl _mutecycnum
	.globl _jumphalflimy
	.globl _jumplimity
	.globl _expldur
	.globl _pliframeprd
	.globl _enlimit
	.globl _abtncooldown
	.globl _screenmaxy
	.globl _screenmaxx
	.globl _screenminy
	.globl _screenminx
	.globl _pjctllimit
	.globl _machinedimswh
	.globl _blanktile
	.globl _lockedoamtiles
	.globl _roadboundy
	.globl _plgroundspeed
	.globl _jumpspeed
	.globl _roadscrspeed
	.globl _stnamelengths
	.globl _stagenames
	.globl _stages
	.globl _stage1objs
	.globl _stage1road
	.globl _roadlanesy
	.globl _get_OAM_free_tile_idx
	.globl _custom_delay
	.globl _incr_oam_sprite_tile_idx
	.globl _itr_enemies_ptr
	.globl _incr_projectile_counter
	.globl _itr_projectile_ptr
	.globl _found_free_projectile_space
	.globl _get_tile_idx
	.globl _clear_all_sprites
	.globl _init_stage_bgk
	.globl _set_machine_tile
	.globl _set_machine_sprite_tiles
	.globl _place_machine
	.globl _init_player
	.globl _respawn_player
	.globl _init_machine_props
	.globl _init_scorpboss
	.globl _collides_with_sidewalk
	.globl _is_inside_x_bounds
	.globl _move_machine
	.globl _move_player
	.globl _move_enemy
	.globl _incr_bkg_x_coords
	.globl _scroll_stage_bkg
	.globl _place_stage_obj
	.globl _build_stage
	.globl _build_road
	.globl _build_hole
	.globl _manage_hole_props
	.globl _manage_projectiles
	.globl _manage_machines
	.globl _manage_sound_chnls
	.globl _manage_player
	.globl _get_horiz_dist
	.globl _set_projctl_comm_prop
	.globl _fire_bullet
	.globl _fire_bigbullet
	.globl _fire_laser
	.globl _drop_bomb
	.globl _get_prjctl_x_aimed
	.globl _get_prjctl_y_aimed
	.globl _is_obj_inside_screen
	.globl _is_alive
	.globl _destroy_projectile
	.globl _init_explosion
	.globl _move_projectile
	.globl _explode_machine
	.globl _anim_explode_boss
	.globl _destroy_machine
	.globl _take_damage
	.globl _add_to_player_shield
	.globl _check_iframes
	.globl _check_projectile_collsn
	.globl _check_player_machine_collsn
	.globl _anim_jump
	.globl _exec_enemy_pattern
	.globl _exec_rider_pattern
	.globl _exec_drone_pattern
	.globl _exec_missile_pattern
	.globl _exec_turret_pattern
	.globl _exec_bomber_pattern
	.globl _exec_mine_pattern
	.globl _cooldown_enemy
	.globl _hud_init
	.globl _hud_upd_shield
	.globl _hud_upd_lives
	.globl _hud_draw_pause
	.globl _hud_clear_pause
	.globl _hud_draw_gun
	.globl _init_game
	.globl _init_stage
	.globl _stage_loop
	.globl _scorpboss_loop
	.globl _pause_game
	.globl _clear_all_projectiles
	.globl _anim_stage_start
	.globl _anim_stage_end
	.globl _anim_blackout_loop
	.globl _anim_reverse_blackout_loop
	.globl _anim_blackout
	.globl _anim_reverse_blackout
	.globl _mute_music_pl_chnl
	.globl _upd_mute_chnl_cycles
	.globl _se_fall_in_hole
	.globl _se_fire_bullet
	.globl _se_fire_laser
	.globl _se_drop_bomb
	.globl _se_explode
	.globl _se_get_hit
	.globl _se_jump
	.globl _se_pause
	.globl _se_wpn_upgrd
	.globl _play_stage
	.globl _play_boss
	.globl _mute_song
	.globl _unmute_song
	.globl _play_song
	.globl _stop_song
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_stageidx::
	.ds 1
_holeflg::
	.ds 1
_stageclearflg::
	.ds 1
_bossclearflg::
	.ds 1
_lvlobjscnt::
	.ds 1
_lvlplacptr::
	.ds 2
_crntstage::
	.ds 2
_stagenum::
	.ds 1
_roadbuildidx::
	.ds 1
_camtileidx::
	.ds 1
_nextcamtileidx::
	.ds 1
_i::
	.ds 1
_citr::
	.ds 1
_sitr::
	.ds 1
_roadposx::
	.ds 1
_sceneryposx::
	.ds 1
_cloudposx::
	.ds 1
_plspeed::
	.ds 1
_oamidx::
	.ds 1
_checktile::
	.ds 1
_projectiles::
	.ds 64
_crntpjct::
	.ds 2
_pjctptr::
	.ds 2
_prjcnt::
	.ds 1
_abtncnt::
	.ds 1
_machines::
	.ds 102
_pl::
	.ds 2
_crntenemy::
	.ds 2
_machptr::
	.ds 2
_pllives::
	.ds 1
_lockmvmnt::
	.ds 1
_iframecnt::
	.ds 1
_iframeflg::
	.ds 1
_fallinholeflg::
	.ds 1
_ascendflg::
	.ds 1
_jumpstarty::
	.ds 1
_holestartx::
	.ds 1
_holeendx::
	.ds 1
_isapressed::
	.ds 1
_chmutedcyccnt::
	.ds 4
_precfctr::
	.ds 1
_slope::
	.ds 2
_gradient::
	.ds 2
_plgun::
	.ds 1
_numkills::
	.ds 1
_explcord::
	.ds 10
_menuidx::
	.ds 1
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;main.c:76: const Stage * crntstage = stages;    // Current stage pointer
	ld	hl, #_crntstage
	ld	(hl), #<(_stages)
	inc	hl
	ld	(hl), #>(_stages)
;main.c:123: UINT8 chmutedcyccnt[] = {255, 255, 255, 255}; // Used to mute a sound channel for a number of cycles
	ld	hl, #_chmutedcyccnt
	ld	(hl), #0xff
	ld	hl, #(_chmutedcyccnt + 0x0001)
	ld	(hl), #0xff
	ld	hl, #(_chmutedcyccnt + 0x0002)
	ld	(hl), #0xff
	ld	hl, #(_chmutedcyccnt + 0x0003)
	ld	(hl), #0xff
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
;main.c:266: void custom_delay(UINT8 cycles) NONBANKED {
;	---------------------------------
; Function custom_delay
; ---------------------------------
_custom_delay::
;main.c:267: for(citr = 0; citr < cycles; citr++) {
	ld	hl, #_citr
	ld	(hl), #0x00
00103$:
	ld	a, (#_citr)
	ldhl	sp,	#2
	sub	a, (hl)
	ret	NC
;main.c:268: wait_vbl_done();
	call	_wait_vbl_done
;main.c:267: for(citr = 0; citr < cycles; citr++) {
	ld	hl, #_citr
	inc	(hl)
;main.c:270: }
	jr	00103$
;main.c:307: void clear_all_sprites() NONBANKED {
;	---------------------------------
; Function clear_all_sprites
; ---------------------------------
_clear_all_sprites::
;main.c:308: for(i = 0; i != 40; i++) {
	ld	hl, #_i
	ld	(hl), #0x00
00104$:
;main.c:309: set_sprite_tile(i, 0);
	ld	hl, #_i
	ld	c, (hl)
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1145: shadow_OAM[nb].tile=tile;
	ld	h, #0x00
	ld	l, c
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
	inc	hl
	inc	hl
	ld	(hl), #0x00
;main.c:310: move_sprite(i, 0, 0);
	ld	hl, #_i
	ld	c, (hl)
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1218: OAM_item_t * itm = &shadow_OAM[nb];
	ld	h, #0x00
	ld	l, c
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1219: itm->y=y, itm->x=x;
	ld	a, #0x00
	ld	(hl+), a
	ld	(hl), #0x00
;main.c:308: for(i = 0; i != 40; i++) {
	ld	hl, #_i
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x28
	jr	NZ, 00104$
;main.c:312: wait_vbl_done();
;main.c:313: }
	jp  _wait_vbl_done
;main.c:316: void init_stage_bgk() NONBANKED {
;	---------------------------------
; Function init_stage_bgk
; ---------------------------------
_init_stage_bgk::
;main.c:317: if(crntstage->hasclouds) {
	ld	hl, #_crntstage + 1
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000b
	add	hl, de
	ld	a, (hl)
	or	a, a
	jp	Z, 00102$
;main.c:318: SWITCH_ROM_MBC1(2);
	ld	a, #0x02
	ldh	(__current_bank+0),a
	ld	hl, #0x2000
	ld	(hl), #0x02
;main.c:319: set_bkg_data(20, 13, cloudtiles);
	ld	hl, #_cloudtiles
	push	hl
	ld	de, #0x0d14
	push	de
	call	_set_bkg_data
	add	sp, #4
;main.c:320: set_bkg_tiles(0, 0, 32, 1, cloudmap);
	ld	hl, #_cloudmap
	push	hl
	ld	de, #0x0120
	push	de
	xor	a, a
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_set_bkg_tiles
	add	sp, #6
;main.c:317: if(crntstage->hasclouds) {
	ld	hl, #_crntstage
	ld	a, (hl+)
	ld	c, a
	ld	d, (hl)
;main.c:321: SWITCH_ROM_MBC1(crntstage->stagebank);
	ld	a, c
	add	a, #0x0c
	ld	e, a
	jr	NC, 00111$
	inc	d
00111$:
	ld	a, (de)
	ldh	(__current_bank+0),a
	ld	a, (de)
	ld	(#0x2000),a
;main.c:317: if(crntstage->hasclouds) {
	ld	hl, #_crntstage + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
;main.c:322: set_bkg_data(61, crntstage->bkgtilesnum, crntstage->bkgtiles);
	ld	hl, #0x0006
	add	hl, bc
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	add	a, #0x08
	ld	c, a
	jr	NC, 00112$
	inc	b
00112$:
	ld	a, (bc)
	push	hl
	ld	d,a
	ld	e,#0x3d
	push	de
	call	_set_bkg_data
	add	sp, #4
;main.c:323: set_bkg_tiles(0, 1, 32, 9, crntstage->bkgmap);
	ld	hl, #_crntstage + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0009
	add	hl, bc
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	push	bc
	ld	de, #0x0920
	push	de
	ld	a, #0x01
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_set_bkg_tiles
	add	sp, #6
	ret
00102$:
;main.c:321: SWITCH_ROM_MBC1(crntstage->stagebank);
	ld	hl, #0x000c
	add	hl, de
	ld	c, l
	ld	b, h
;main.c:325: SWITCH_ROM_MBC1(crntstage->stagebank);
	ld	a, (bc)
	ldh	(__current_bank+0),a
	ld	a, (bc)
	ld	(#0x2000),a
;main.c:317: if(crntstage->hasclouds) {
	ld	hl, #_crntstage + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
;main.c:326: set_bkg_data(20, crntstage->bkgtilesnum, crntstage->bkgtiles);
	ld	hl, #0x0006
	add	hl, bc
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	add	a, #0x08
	ld	c, a
	jr	NC, 00113$
	inc	b
00113$:
	ld	a, (bc)
	push	hl
	ld	d,a
	ld	e,#0x14
	push	de
	call	_set_bkg_data
	add	sp, #4
;main.c:327: set_bkg_tiles(0, 0, 32, 10, crntstage->bkgmap);
	ld	hl, #_crntstage + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0009
	add	hl, bc
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	push	bc
	ld	de, #0x0a20
	push	de
	xor	a, a
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_set_bkg_tiles
	add	sp, #6
;main.c:329: }
	ret
;main.c:528: void scroll_stage_bkg() NONBANKED {
;	---------------------------------
; Function scroll_stage_bkg
; ---------------------------------
_scroll_stage_bkg::
;main.c:529: switch(LYC_REG) {
	ldh	a, (_LYC_REG+0)
	or	a, a
	jr	Z, 00101$
	cp	a, #0x08
	jr	Z, 00102$
	sub	a, #0x50
	jr	Z, 00103$
	ret
;main.c:530: case 0x00:
00101$:
;main.c:531: move_bkg(cloudposx, 0);
	ld	a, (#_cloudposx)
	ldh	(_SCX_REG+0),a
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:826: SCX_REG=x, SCY_REG=y;
	ld	a, #0x00
	ldh	(_SCY_REG+0),a
;main.c:532: LYC_REG = 0x08;
	ld	a, #0x08
	ldh	(_LYC_REG+0),a
;main.c:533: break;
	ret
;main.c:534: case 0x08:
00102$:
;main.c:535: move_bkg(sceneryposx, 0);
	ld	a, (#_sceneryposx)
	ldh	(_SCX_REG+0),a
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:826: SCX_REG=x, SCY_REG=y;
	ld	a, #0x00
	ldh	(_SCY_REG+0),a
;main.c:536: LYC_REG = 0x50;
	ld	a, #0x50
	ldh	(_LYC_REG+0),a
;main.c:537: break;
	ret
;main.c:538: case 0x50:
00103$:
;main.c:539: move_bkg(roadposx, 0);
	ld	a, (#_roadposx)
	ldh	(_SCX_REG+0),a
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:826: SCX_REG=x, SCY_REG=y;
	ld	a, #0x00
	ldh	(_SCY_REG+0),a
;main.c:540: LYC_REG = 0x00;
	ld	a, #0x00
	ldh	(_LYC_REG+0),a
;main.c:542: }
;main.c:543: }
	ret
;main.c:1176: void init_game() NONBANKED {
;	---------------------------------
; Function init_game
; ---------------------------------
_init_game::
;main.c:1177: plspeed = plgroundspeed;
	ld	a, (#_plgroundspeed)
	ld	(#_plspeed),a
;main.c:1178: pllives = 3;
	ld	hl, #_pllives
	ld	(hl), #0x03
;main.c:1179: plgun = 0;
	ld	hl, #_plgun
	ld	(hl), #0x00
;main.c:1180: iframecnt = 0;
	ld	hl, #_iframecnt
	ld	(hl), #0x00
;main.c:1181: }
	ret
;main.c:1184: void init_stage(UBYTE hasscenery, UBYTE hasscroll) NONBANKED {
;	---------------------------------
; Function init_stage
; ---------------------------------
_init_stage::
	add	sp, #-4
;main.c:1185: roadposx = sceneryposx = cloudposx = iframeflg = 0;
	ld	hl, #_iframeflg
	ld	(hl), #0x00
	ld	hl, #_cloudposx
	ld	(hl), #0x00
	ld	hl, #_sceneryposx
	ld	(hl), #0x00
	ld	hl, #_roadposx
	ld	(hl), #0x00
;main.c:1186: oamidx = 0;
	ld	hl, #_oamidx
	ld	(hl), #0x00
;main.c:1187: prjcnt = abtncnt = 0;
	ld	hl, #_abtncnt
	ld	(hl), #0x00
	ld	hl, #_prjcnt
	ld	(hl), #0x00
;main.c:1188: crntpjct = projectiles;
	ld	hl, #_crntpjct
	ld	(hl), #<(_projectiles)
	inc	hl
	ld	(hl), #>(_projectiles)
;main.c:1189: crntenemy = machines + 1;
	ld	hl, #_crntenemy
	ld	(hl), #<((_machines + 0x0011))
	inc	hl
	ld	(hl), #>((_machines + 0x0011))
;main.c:1190: ascendflg = 1;
	ld	hl, #_ascendflg
	ld	(hl), #0x01
;main.c:1191: lockmvmnt = 0; // Allowing free movement
	ld	hl, #_lockmvmnt
	ld	(hl), #0x00
;main.c:1192: holestartx = 255;
	ld	hl, #_holestartx
	ld	(hl), #0xff
;main.c:1193: holeendx = 0;
	ld	hl, #_holeendx
	ld	(hl), #0x00
;main.c:1194: isapressed = 0;
	ld	hl, #_isapressed
	ld	(hl), #0x00
;main.c:1195: numkills = 0;
	ld	hl, #_numkills
	ld	(hl), #0x00
;main.c:1197: stageidx = holeflg = fallinholeflg = 0;
	ld	hl, #_fallinholeflg
	ld	(hl), #0x00
	ld	hl, #_holeflg
	ld	(hl), #0x00
	ld	hl, #_stageidx
	ld	(hl), #0x00
;main.c:1198: lvlplacptr = crntstage->enlayout;
	ld	hl, #_crntstage + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	inc	bc
	inc	bc
	ld	l, b
	ld	e, c
	ld	d, l
	ld	a, (de)
	ld	hl, #_lvlplacptr
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;main.c:1200: roadbuildidx = 0; // Resetting the road index
	ld	hl, #_roadbuildidx
	ld	(hl), #0x00
;main.c:1201: if(hasscenery) {
	ldhl	sp,	#6
	ld	a, (hl)
	or	a, a
	jr	Z, 00102$
;main.c:1202: init_stage_bgk();
	call	_init_stage_bgk
	jr	00103$
00102$:
;main.c:1204: fill_bkg_rect(0, 0, 32, 10, 0x00);
	xor	a, a
	ld	d,a
	ld	e,#0x0a
	push	de
	ld	a, #0x20
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_fill_bkg_rect
	add	sp, #5
00103$:
;main.c:1206: init_stage_road();
	ld	e, #b_init_stage_road
	ld	hl, #_init_stage_road
	call	___sdcc_bcall_ehl
;main.c:1208: if(hasscroll) {
	ldhl	sp,	#7
	ld	a, (hl)
	or	a, a
	jr	Z, 00105$
;main.c:1209: STAT_REG = 0x45;
	ld	a, #0x45
	ldh	(_STAT_REG+0),a
;main.c:1210: LYC_REG = 0x00;
	ld	a, #0x00
	ldh	(_LYC_REG+0),a
;main.c:1211: remove_LCD(scroll_stage_bkg);
	ld	hl, #_scroll_stage_bkg
	push	hl
	call	_remove_LCD
	add	sp, #2
;main.c:1212: disable_interrupts();
	call	_disable_interrupts
;main.c:1213: add_LCD(scroll_stage_bkg);
	ld	hl, #_scroll_stage_bkg
	push	hl
	call	_add_LCD
	add	sp, #2
;main.c:1214: enable_interrupts();
	call	_enable_interrupts
;main.c:1215: set_interrupts(VBL_IFLAG | LCD_IFLAG);
	ld	a, #0x03
	push	af
	inc	sp
	call	_set_interrupts
	inc	sp
00105$:
;main.c:1218: SWITCH_ROM_MBC1(2);
	ld	a, #0x02
	ldh	(__current_bank+0),a
	ld	hl, #0x2000
	ld	(hl), #0x02
;main.c:1219: set_sprite_data(0, 1, blanktile);
	ld	hl, #_blanktile
	push	hl
	ld	a, #0x01
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_set_sprite_data
	add	sp, #4
;main.c:1220: set_sprite_data(1, 16, playerspritetiles);
	ld	hl, #_playerspritetiles
	push	hl
	ld	de, #0x1001
	push	de
	call	_set_sprite_data
	add	sp, #4
;main.c:1221: set_sprite_data(17, 4, projectiletiles);
	ld	hl, #_projectiletiles
	push	hl
	ld	de, #0x0411
	push	de
	call	_set_sprite_data
	add	sp, #4
;main.c:1222: set_sprite_data(21, 24, enemyspritetiles);
	ld	hl, #_enemyspritetiles
	push	hl
	ld	de, #0x1815
	push	de
	call	_set_sprite_data
	add	sp, #4
;main.c:1223: set_sprite_data(45, 1, misctiles);
	ld	hl, #_misctiles
	push	hl
	ld	de, #0x012d
	push	de
	call	_set_sprite_data
	add	sp, #4
;main.c:1224: SWITCH_ROM_MBC1(1);
	ld	a, #0x01
	ldh	(__current_bank+0),a
	ld	hl, #0x2000
	ld	(hl), #0x01
;main.c:1225: init_player();
	call	_init_player
;main.c:1227: for(pjctptr = projectiles; pjctptr <= projectiles + pjctllimit; pjctptr++) { // Initialization of projectiles
	ld	hl, #_pjctptr
	ld	a, #<(_projectiles)
	ld	(hl+), a
	ld	(hl), #>(_projectiles)
00111$:
	ld	hl, #_pjctllimit
	ld	l, (hl)
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	de, #_projectiles
	add	hl, de
	ld	c, l
	ld	b, h
	ld	hl, #_pjctptr
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	jr	C, 00106$
;main.c:1228: pjctptr->oam = NULL;
	ld	hl, #_pjctptr + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0006
	add	hl, bc
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;main.c:1227: for(pjctptr = projectiles; pjctptr <= projectiles + pjctllimit; pjctptr++) { // Initialization of projectiles
	ld	hl, #_pjctptr
	ld	a, (hl)
	add	a, #0x08
	ld	(hl+), a
	ld	a, (hl)
	adc	a, #0x00
	ld	(hl), a
	jr	00111$
00106$:
;main.c:1232: for(machptr = machines + 1; machptr <= machines + enlimit; machptr++) {
	ld	hl, #_machptr
	ld	(hl), #<((_machines + 0x0011))
	inc	hl
	ld	(hl), #>((_machines + 0x0011))
00114$:
	ld	hl, #_enlimit
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
	ld	de, #_machines
	add	hl, de
	ld	c, l
	ld	b, h
	ld	hl, #_machptr
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	jr	C, 00107$
;main.c:1233: machptr->shield = machptr->explcount = machptr->cyccount = machptr->type = 0;
	ld	hl, #_machptr + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x000b
	add	hl, bc
	inc	sp
	inc	sp
	push	hl
	ld	hl, #0x0007
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl), a
	ld	hl, #0x0008
	add	hl, bc
	ld	e, l
	ld	d, h
	ld	hl, #0x000c
	add	hl, bc
	ld	(hl), #0x00
	xor	a, a
	ld	(de), a
	pop	bc
	pop	hl
	push	hl
	push	bc
	ld	(hl), #0x00
	pop	hl
	push	hl
	ld	(hl), #0x00
	ld	hl, #_machptr + 1
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
;main.c:1234: machptr->x = machptr->y = machptr->width = machptr->height = 0;
	ld	c, e
	ld	b, d
	inc	bc
	push	de
;c
	ld	hl, #0x0002
	add	hl, de
	pop	de
	inc	sp
	inc	sp
	push	hl
	push	de
;c
	ld	hl, #0x0005
	add	hl, de
	pop	de
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl), a
	ld	hl, #0x0006
	add	hl, de
	ld	(hl), #0x00
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
	pop	hl
	push	hl
	ld	(hl), #0x00
	xor	a, a
	ld	(bc), a
;main.c:1232: for(machptr = machines + 1; machptr <= machines + enlimit; machptr++) {
	ld	hl, #_machptr
	ld	a, (hl)
	add	a, #0x11
	ld	(hl+), a
	ld	a, (hl)
	adc	a, #0x00
	ld	(hl), a
	jp	00114$
00107$:
;main.c:1237: hud_init();
	call	_hud_init
;main.c:1147: set_win_tile_xy(17, 0, pllives + 1);  // Tile offset 1
	ld	a, (#_pllives)
	inc	a
	push	af
	inc	sp
	xor	a, a
	ld	d,a
	ld	e,#0x11
	push	de
	call	_set_win_tile_xy
	add	sp, #3
;main.c:1170: set_win_tile_xy(10, 0, 17 + plgun); // Tile offset 17
	ld	a, (#_plgun)
	add	a, #0x11
	push	af
	inc	sp
	xor	a, a
	ld	d,a
	ld	e,#0x0a
	push	de
	call	_set_win_tile_xy
	add	sp, #3
;main.c:1239: hud_draw_gun();
;main.c:1240: }
	add	sp, #4
	ret
;main.c:1404: void anim_blackout_loop(UINT8 indictr) NONBANKED {   // To be used in loops
;	---------------------------------
; Function anim_blackout_loop
; ---------------------------------
_anim_blackout_loop::
;main.c:1405: switch(indictr) {
	ldhl	sp,	#2
	ld	a, (hl)
	dec	a
	jr	Z, 00101$
	ldhl	sp,	#2
	ld	a, (hl)
	sub	a, #0x0a
	jr	Z, 00102$
	ldhl	sp,	#2
	ld	a, (hl)
	sub	a, #0x14
	jr	Z, 00103$
	ret
;main.c:1406: case 1:
00101$:
;main.c:1407: BGP_REG = 0xF9;
	ld	a, #0xf9
	ldh	(_BGP_REG+0),a
;main.c:1408: break;
	ret
;main.c:1409: case 10:
00102$:
;main.c:1410: BGP_REG = 0xFE;
	ld	a, #0xfe
	ldh	(_BGP_REG+0),a
;main.c:1411: break;
	ret
;main.c:1412: case 20:
00103$:
;main.c:1413: BGP_REG = 0xFF;
	ld	a, #0xff
	ldh	(_BGP_REG+0),a
;main.c:1415: }
;main.c:1416: }
	ret
;main.c:1419: void anim_reverse_blackout_loop(UINT8 indictr) NONBANKED {   // To be used in loops
;	---------------------------------
; Function anim_reverse_blackout_loop
; ---------------------------------
_anim_reverse_blackout_loop::
;main.c:1420: switch(indictr) {
	ldhl	sp,	#2
	ld	a, (hl)
	dec	a
	jr	Z, 00101$
	ldhl	sp,	#2
	ld	a, (hl)
	sub	a, #0x0a
	jr	Z, 00102$
	ldhl	sp,	#2
	ld	a, (hl)
	sub	a, #0x14
	jr	Z, 00103$
	ret
;main.c:1421: case 1:
00101$:
;main.c:1422: BGP_REG = 0xFE;
	ld	a, #0xfe
	ldh	(_BGP_REG+0),a
;main.c:1423: break;
	ret
;main.c:1424: case 10:
00102$:
;main.c:1425: BGP_REG = 0xF9;
	ld	a, #0xf9
	ldh	(_BGP_REG+0),a
;main.c:1426: break;
	ret
;main.c:1427: case 20:
00103$:
;main.c:1428: BGP_REG = 0xE4;
	ld	a, #0xe4
	ldh	(_BGP_REG+0),a
;main.c:1430: }
;main.c:1431: }
	ret
;main.c:1434: void anim_blackout() NONBANKED {  // Used as a standalone call
;	---------------------------------
; Function anim_blackout
; ---------------------------------
_anim_blackout::
;main.c:1435: for(UINT8 blkstep = 0; blkstep != 21; blkstep++) {
	ld	b, #0x00
00103$:
	ld	a, b
	sub	a, #0x15
	ret	Z
;main.c:1436: anim_blackout_loop(blkstep);
	push	bc
	push	bc
	inc	sp
	call	_anim_blackout_loop
	inc	sp
	pop	bc
;main.c:1437: wait_vbl_done();
	call	_wait_vbl_done
;main.c:1435: for(UINT8 blkstep = 0; blkstep != 21; blkstep++) {
	inc	b
;main.c:1439: }
	jr	00103$
;main.c:1442: void anim_reverse_blackout() NONBANKED {  // Used as a standalone call
;	---------------------------------
; Function anim_reverse_blackout
; ---------------------------------
_anim_reverse_blackout::
;main.c:1443: for(UINT8 blkstep = 0; blkstep != 21; blkstep++) {
	ld	b, #0x00
00103$:
	ld	a, b
	sub	a, #0x15
	ret	Z
;main.c:1444: anim_reverse_blackout_loop(blkstep);
	push	bc
	push	bc
	inc	sp
	call	_anim_reverse_blackout_loop
	inc	sp
	pop	bc
;main.c:1445: wait_vbl_done();
	call	_wait_vbl_done
;main.c:1443: for(UINT8 blkstep = 0; blkstep != 21; blkstep++) {
	inc	b
;main.c:1447: }
	jr	00103$
;main.c:1453: void mute_music_pl_chnl(UINT8 chnum) NONBANKED {     // Mutes a music player channel during effects
;	---------------------------------
; Function mute_music_pl_chnl
; ---------------------------------
_mute_music_pl_chnl::
;main.c:1454: hUGE_mute_channel(chnum, HT_CH_MUTE);
	ld	a, #0x01
	push	af
	inc	sp
	ldhl	sp,	#3
	ld	a, (hl)
	push	af
	inc	sp
	call	_hUGE_mute_channel
	add	sp, #2
;main.c:1455: chmutedcyccnt[chnum] = mutecycnum;  // Initiates countdown for mute period
	ld	bc, #_chmutedcyccnt+0
	ldhl	sp,	#2
	ld	l, (hl)
	ld	h, #0x00
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (#_mutecycnum)
	ld	(bc), a
;main.c:1456: }
	ret
;main.c:1559: void play_stage() NONBANKED {
;	---------------------------------
; Function play_stage
; ---------------------------------
_play_stage::
;main.c:1560: init_stage(1, 1);
	ld	de, #0x0101
	push	de
	call	_init_stage
	add	sp, #2
;main.c:1561: anim_stage_start();
	call	_anim_stage_start
;main.c:1562: play_song(crntstage->theme);
	ld	hl, #_crntstage + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x000d
	add	hl, bc
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	push	bc
	call	_play_song
	add	sp, #2
;main.c:1563: stage_loop();
	call	_stage_loop
;main.c:1564: if(stageclearflg == 1) {
	ld	a, (#_stageclearflg)
	dec	a
	jr	NZ, 00102$
;main.c:1565: anim_stage_end();
	call	_anim_stage_end
00102$:
;main.c:1567: stop_song();    // Stop current stage music
	call	_stop_song
;main.c:1568: anim_blackout();
	call	_anim_blackout
;main.c:1569: HIDE_WIN;
	ldh	a, (_LCDC_REG+0)
	and	a, #0xdf
	ldh	(_LCDC_REG+0),a
;main.c:1570: clear_all_sprites();
	call	_clear_all_sprites
;main.c:1574: }
	di
;main.c:1572: cloudposx = sceneryposx = roadposx = 0;
	ld	hl, #_roadposx
	ld	(hl), #0x00
	ld	hl, #_sceneryposx
	ld	(hl), #0x00
	ld	hl, #_cloudposx
	ld	(hl), #0x00
;main.c:1573: scroll_stage_bkg();
	call	_scroll_stage_bkg
	ei
;main.c:1575: }
	ret
;main.c:1577: void play_boss() NONBANKED {
;	---------------------------------
; Function play_boss
; ---------------------------------
_play_boss::
;main.c:1578: init_stage(1, 0);
	xor	a, a
	ld	d,a
	ld	e,#0x01
	push	de
	call	_init_stage
	add	sp, #2
;main.c:1579: init_scorpboss();
	call	_init_scorpboss
;main.c:1580: anim_stage_start();
	call	_anim_stage_start
;main.c:1581: play_song(&bosstheme);
	ld	hl, #_bosstheme
	push	hl
	call	_play_song
	add	sp, #2
;main.c:1582: scorpboss_loop();
	call	_scorpboss_loop
;main.c:1583: if(bossclearflg == 1) {
	ld	a, (#_bossclearflg)
	dec	a
	jr	NZ, 00102$
;main.c:1584: stop_song();
	call	_stop_song
;main.c:1585: anim_explode_boss(80, 106, 72, 30);
	ld	de, #0x1e48
	push	de
	ld	de, #0x6a50
	push	de
	call	_anim_explode_boss
	add	sp, #4
;main.c:1586: play_song(&cleartheme);
	ld	hl, #_cleartheme
	push	hl
	call	_play_song
	add	sp, #2
;main.c:1587: custom_delay(255);
	ld	a, #0xff
	push	af
	inc	sp
	call	_custom_delay
	inc	sp
;main.c:1588: stop_song();
	call	_stop_song
00102$:
;main.c:1590: anim_blackout();
	call	_anim_blackout
;main.c:1591: stop_song();    // Stop current stage music
	call	_stop_song
;main.c:1592: HIDE_WIN;
	ldh	a, (_LCDC_REG+0)
	and	a, #0xdf
	ldh	(_LCDC_REG+0),a
;main.c:1593: clear_all_sprites();
	call	_clear_all_sprites
;main.c:1597: }
	di
;main.c:1595: cloudposx = sceneryposx = roadposx = 0;
	ld	hl, #_roadposx
	ld	(hl), #0x00
	ld	hl, #_sceneryposx
	ld	(hl), #0x00
	ld	hl, #_cloudposx
	ld	(hl), #0x00
;main.c:1596: scroll_stage_bkg();
	call	_scroll_stage_bkg
	ei
;main.c:1598: }
	ret
;main.c:1616: void play_song(const hUGESong_t * song) NONBANKED {
;	---------------------------------
; Function play_song
; ---------------------------------
_play_song::
;main.c:1620: }
	di
;main.c:1618: hUGE_init(song);
	pop	bc
	pop	hl
	push	hl
	push	bc
	push	hl
	call	_hUGE_init
	add	sp, #2
;main.c:1619: add_VBL(hUGE_dosound);
	ld	hl, #_hUGE_dosound
	push	hl
	call	_add_VBL
	add	sp, #2
	ei
;main.c:1621: }
	ret
;main.c:1624: void stop_song() NONBANKED {
;	---------------------------------
; Function stop_song
; ---------------------------------
_stop_song::
;main.c:1625: mute_song();
	call	_mute_song
;main.c:1626: remove_VBL(hUGE_dosound);
	ld	hl, #_hUGE_dosound
	push	hl
	call	_remove_VBL
	add	sp, #2
;main.c:1627: }
	ret
;main.c:1630: void main() NONBANKED {
;	---------------------------------
; Function main
; ---------------------------------
_main::
;main.c:1632: DISPLAY_ON;
	ldh	a, (_LCDC_REG+0)
	or	a, #0x80
	ldh	(_LCDC_REG+0),a
;main.c:1633: SHOW_BKG;
	ldh	a, (_LCDC_REG+0)
	or	a, #0x01
	ldh	(_LCDC_REG+0),a
;main.c:1634: SHOW_SPRITES;
	ldh	a, (_LCDC_REG+0)
	or	a, #0x02
	ldh	(_LCDC_REG+0),a
;main.c:1636: NR52_REG = 0x80; // Sound on
	ld	a, #0x80
	ldh	(_NR52_REG+0),a
;main.c:1637: NR51_REG = 0xFF; // All channels
	ld	a, #0xff
	ldh	(_NR51_REG+0),a
;main.c:1638: NR50_REG = 0x77; // Max level, left and right
	ld	a, #0x77
	ldh	(_NR50_REG+0),a
;main.c:1640: anim_blackout();    // DEMO CODE
	call	_anim_blackout
;main.c:1641: while(1) {
00116$:
;main.c:1642: main_menu();
	ld	e, #b_main_menu
	ld	hl, #_main_menu
	call	___sdcc_bcall_ehl
;main.c:1643: init_game();
	call	_init_game
;main.c:1644: stageclearflg = bossclearflg = 0;
	ld	hl, #_bossclearflg
	ld	(hl), #0x00
	ld	hl, #_stageclearflg
	ld	(hl), #0x00
;main.c:1645: stagenum = 0;
	ld	hl, #_stagenum
	ld	(hl), #0x00
;main.c:1646: while(1) {
00113$:
;main.c:1647: if(pllives == 0) {
	ld	a, (#_pllives)
	or	a, a
	jr	NZ, 00110$
;main.c:1648: game_over_menu();
	ld	e, #b_game_over_menu
	ld	hl, #_game_over_menu
	call	___sdcc_bcall_ehl
;main.c:1649: if(menuidx == 1) {
	ld	a, (#_menuidx)
	dec	a
	jr	Z, 00116$
;main.c:1650: break;  // Player has chosen to quit the stage/boss
	jr	00113$
00110$:
;main.c:1652: } else if(stageclearflg == 0) {
	ld	a, (#_stageclearflg)
	or	a, a
	jr	NZ, 00107$
;main.c:1653: stage_intro_screen(stagenum);
	ld	a, (#_stagenum)
	push	af
	inc	sp
	ld	e, #b_stage_intro_screen
	ld	hl, #_stage_intro_screen
	call	___sdcc_bcall_ehl
	inc	sp
;main.c:1654: play_stage();
	call	_play_stage
	jr	00113$
00107$:
;main.c:1655: } else if(bossclearflg == 0) {
	ld	a, (#_bossclearflg)
	or	a, a
	jr	NZ, 00104$
;main.c:1656: play_boss();
	call	_play_boss
	jr	00113$
00104$:
;main.c:1658: demo_end_screen();  // DEMO CODE
	ld	e, #b_demo_end_screen
	ld	hl, #_demo_end_screen
	call	___sdcc_bcall_ehl
;main.c:1659: init_game(); // DEMO CODE
	call	_init_game
;main.c:1660: stageclearflg = bossclearflg = 0;
	ld	hl, #_bossclearflg
	ld	(hl), #0x00
	ld	hl, #_stageclearflg
	ld	(hl), #0x00
;main.c:1661: break;  // DEMO CODE
;main.c:1670: }
	jr	00116$
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE_0
;main.c:256: UINT8 get_OAM_free_tile_idx() {
;	---------------------------------
; Function get_OAM_free_tile_idx
; ---------------------------------
_get_OAM_free_tile_idx::
;main.c:257: for(UINT8 oami = 4; oami < 40; oami++) {
	ld	de, #0x0404
00105$:
	ld	a, d
	sub	a, #0x28
	jr	NC, 00103$
;main.c:258: if(shadow_OAM[oami].tile == 0) {
	ld	bc, #_shadow_OAM+0
	ld	a, d
	ld	h, #0x00
	ld	l, a
	add	hl, hl
	add	hl, hl
	add	hl, bc
	inc	hl
	inc	hl
	ld	a, (hl)
	or	a, a
;main.c:259: return oami; // First free tile for usage
	ret	Z
;main.c:257: for(UINT8 oami = 4; oami < 40; oami++) {
	inc	d
	ld	e, d
	jr	00105$
00103$:
;main.c:262: return 180; // No free OAM tile space found
	ld	e, #0xb4
;main.c:263: }
	ret
_roadlanesy:
	.db #0x62	; 98	'b'
	.db #0x72	; 114	'r'
	.db #0x82	; 130
_stage1road:
	.db #0x32	; 50	'2'
	.db #0x1e	; 30
	.db #0x5f	; 95
	.db #0x19	; 25
	.db #0x6e	; 110	'n'
	.db #0x19	; 25
	.db #0xa0	; 160
	.db #0x19	; 25
	.db #0x6e	; 110	'n'
	.db #0x23	; 35
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x46	; 70	'F'
_stage1objs:
	.db #0x02	; 2
	.db #0x32	; 50	'2'
	.db #0xa7	; 167
	.db #0x72	; 114	'r'
	.db #0x00	; 0
	.db #0x04	; 4
	.db #0x14	; 20
	.db #0xa7	; 167
	.db #0x62	; 98	'b'
	.db #0x00	; 0
	.db #0x04	; 4
	.db #0x28	; 40
	.db #0xa7	; 167
	.db #0x82	; 130
	.db #0x00	; 0
	.db #0x04	; 4
	.db #0x3c	; 60
	.db #0xa7	; 167
	.db #0x72	; 114	'r'
	.db #0x00	; 0
	.db #0x06	; 6
	.db #0x14	; 20
	.db #0xa7	; 167
	.db #0x82	; 130
	.db #0x00	; 0
	.db #0x06	; 6
	.db #0x28	; 40
	.db #0xa7	; 167
	.db #0x37	; 55	'7'
	.db #0x01	; 1
	.db #0x06	; 6
	.db #0x3c	; 60
	.db #0xa7	; 167
	.db #0x62	; 98	'b'
	.db #0x00	; 0
	.db #0x06	; 6
	.db #0x50	; 80	'P'
	.db #0xa7	; 167
	.db #0x37	; 55	'7'
	.db #0x01	; 1
	.db #0x06	; 6
	.db #0x64	; 100	'd'
	.db #0xa7	; 167
	.db #0x72	; 114	'r'
	.db #0x00	; 0
	.db #0x08	; 8
	.db #0x1e	; 30
	.db #0xa7	; 167
	.db #0x82	; 130
	.db #0x00	; 0
	.db #0x08	; 8
	.db #0x28	; 40
	.db #0xa7	; 167
	.db #0x37	; 55	'7'
	.db #0x01	; 1
	.db #0x08	; 8
	.db #0x32	; 50	'2'
	.db #0xa7	; 167
	.db #0x62	; 98	'b'
	.db #0x00	; 0
	.db #0x08	; 8
	.db #0x3c	; 60
	.db #0xa7	; 167
	.db #0x72	; 114	'r'
	.db #0x00	; 0
	.db #0x08	; 8
	.db #0x46	; 70	'F'
	.db #0xa7	; 167
	.db #0x37	; 55	'7'
	.db #0x01	; 1
	.db #0x08	; 8
	.db #0x50	; 80	'P'
	.db #0xa7	; 167
	.db #0x72	; 114	'r'
	.db #0x00	; 0
	.db #0x09	; 9
	.db #0x10	; 16
	.db #0xa7	; 167
	.db #0x85	; 133
	.db #0x03	; 3
	.db #0x10	; 16
	.db #0x14	; 20
	.db #0xa7	; 167
	.db #0x72	; 114	'r'
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x1e	; 30
	.db #0xa7	; 167
	.db #0x37	; 55	'7'
	.db #0x01	; 1
_stages:
	.dw _stage1road
	.db #0x11	; 17
	.dw _stage1objs
	.db #0x13	; 19
	.dw _deserttiles
	.db #0x27	; 39
	.dw _desertmap
	.db #0x01	; 1
	.db #0x02	; 2
	.dw _deserttheme
_stagenames:
	.db #0x0e	; 14
	.db #0x0f	; 15
	.db #0x1d	; 29
	.db #0x0f	; 15
	.db #0x1c	; 28
	.db #0x1e	; 30
	.db #0x00	; 0
	.db #0x12	; 18
	.db #0x13	; 19
	.db #0x11	; 17
	.db #0x12	; 18
	.db #0x21	; 33
	.db #0x0b	; 11
	.db #0x23	; 35
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
_stnamelengths:
	.db #0x0e	; 14
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
_roadscrspeed:
	.db #0x05	; 5
_jumpspeed:
	.db #0x03	; 3
_plgroundspeed:
	.db #0x01	; 1
_roadboundy:
	.db #0x65	; 101	'e'
_lockedoamtiles:
	.db #0x04	; 4
_blanktile:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_machinedimswh:
	.db #0x10	; 16
_pjctllimit:
	.db #0x07	; 7
_screenminx:
	.db #0x08	; 8
_screenminy:
	.db #0x10	; 16
_screenmaxx:
	.db #0xa8	; 168
_screenmaxy:
	.db #0x90	; 144
_abtncooldown:
	.db #0x18	; 24
_enlimit:
	.db #0x05	; 5
_pliframeprd:
	.db #0x78	; 120	'x'
_expldur:
	.db #0x20	; 32
_jumplimity:
	.db #0x32	; 50	'2'
_jumphalflimy:
	.db #0x19	; 25
_mutecycnum:
	.db #0x0f	; 15
_genexplcord:
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x04	; 4
	.db #0x06	; 6
	.db #0x02	; 2
	.db #0x04	; 4
	.db #0x05	; 5
_plprops:
	.db #0x01	;  1
	.db #0x04	;  4
	.db #0x03	;  3
	.db #0x01	;  1
	.db #0x11	;  17
	.db #0x0c	;  12
	.db #0x0d	;  13
	.db #0x0f	;  15
	.db #0x64	;  100	'd'
	.db #0x01	;  1
_scorpgunprops:
	.db #0x01	;  1
	.db #0x0a	;  10
	.db #0x01	;  1
	.db #0x00	;  0
	.db #0xfd	; -3
	.db #0x01	;  1
	.db #0x08	;  8
	.db #0x08	;  8
	.db #0x06	;  6
	.db #0x64	;  100	'd'
_stingprops:
	.db #0x01	;  1
	.db #0x0a	;  10
	.db #0x01	;  1
	.db #0x00	;  0
	.db #0x00	;  0
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x0d	;  13
	.db #0x06	;  6
	.db #0x64	;  100	'd'
_enprops:
	.db #0x01	;  1
	.db #0x02	;  2
	.db #0x00	;  0
	.db #0x01	;  1
	.db #0x0d	;  13
	.db #0x0f	;  15
	.db #0xfd	; -3
	.db #0x0c	;  12
	.db #0x00	;  0
	.db #0x15	;  21
	.db #0x00	;  0
	.db #0x01	;  1
	.db #0x02	;  2
	.db #0x05	;  5
	.db #0x0e	;  14
	.db #0x07	;  7
	.db #0x07	;  7
	.db #0x0d	;  13
	.db #0x01	;  1
	.db #0x19	;  25
	.db #0x01	;  1
	.db #0x09	;  9
	.db #0x02	;  2
	.db #0x05	;  5
	.db #0x0d	;  13
	.db #0x0a	;  10
	.db #0x01	;  1
	.db #0x04	;  4
	.db #0x02	;  2
	.db #0x1d	;  29
	.db #0x00	;  0
	.db #0x64	;  100	'd'
	.db #0x03	;  3
	.db #0x02	;  2
	.db #0x0e	;  14
	.db #0x0c	;  12
	.db #0x07	;  7
	.db #0xfc	; -4
	.db #0x03	;  3
	.db #0x21	;  33
	.db #0x00	;  0
	.db #0x02	;  2
	.db #0x00	;  0
	.db #0x05	;  5
	.db #0x0d	;  13
	.db #0x07	;  7
	.db #0x04	;  4
	.db #0x0b	;  11
	.db #0x04	;  4
	.db #0x25	;  37
	.db #0x01	;  1
	.db #0x14	;  20
	.db #0x03	;  3
	.db #0x02	;  2
	.db #0x0b	;  11
	.db #0x0b	;  11
	.db #0x00	;  0
	.db #0x00	;  0
	.db #0x05	;  5
	.db #0x29	;  41
;main.c:273: void incr_oam_sprite_tile_idx(INT8 steps) {
;	---------------------------------
; Function incr_oam_sprite_tile_idx
; ---------------------------------
_incr_oam_sprite_tile_idx::
;main.c:274: UINT8 nextoamind = oamidx + steps;
	ld	a, (#_oamidx)
	ldhl	sp,	#2
	add	a, (hl)
;main.c:275: oamidx = nextoamind < 40 ? nextoamind : nextoamind - 40 + lockedoamtiles; // Out of bounds check and reset
	cp	a, #0x28
	jr	C, 00106$
	add	a, #0xd8
	ld	c, a
	ld	a, (#_lockedoamtiles)
	add	a, c
00106$:
	ld	hl, #_oamidx
	ld	(hl), a
;main.c:276: if(shadow_OAM[oamidx].tile != 0) { // If next OAM tile is used, loop to find a free one
	ld	l, (hl)
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
	inc	hl
	inc	hl
	ld	a, (hl)
	or	a, a
	ret	Z
;main.c:277: oamidx = get_OAM_free_tile_idx();
	call	_get_OAM_free_tile_idx
	ld	hl, #_oamidx
	ld	(hl), e
;main.c:279: }
	ret
;main.c:282: inline void itr_enemies_ptr() {
;	---------------------------------
; Function itr_enemies_ptr
; ---------------------------------
_itr_enemies_ptr::
;main.c:283: crntenemy = crntenemy == machines + enlimit ? machines + 1 : crntenemy + 1;
	ld	hl, #_enlimit
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
	ld	de, #_machines
	add	hl, de
	ld	c, l
	ld	b, h
	ld	hl, #_crntenemy
	ld	a, (hl)
	sub	a, c
	jr	NZ, 00103$
	inc	hl
	ld	a, (hl)
	sub	a, b
	jr	NZ, 00103$
	ld	bc, #_machines + 17
	jr	00104$
00103$:
	ld	hl, #_crntenemy
	ld	a, (hl)
	add	a, #0x11
	ld	c, a
	inc	hl
	ld	a, (hl)
	adc	a, #0x00
	ld	b, a
00104$:
	ld	hl, #_crntenemy
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;main.c:284: }
	ret
;main.c:287: inline void incr_projectile_counter() {
;	---------------------------------
; Function incr_projectile_counter
; ---------------------------------
_incr_projectile_counter::
;main.c:288: prjcnt += prjcnt == pjctllimit + 1 ? 0 : 1;
	ld	hl, #_pjctllimit
	ld	c, (hl)
	ld	b, #0x00
	inc	bc
	ld	hl, #_prjcnt
	ld	e, (hl)
	ld	d, #0x00
	ld	a, e
	sub	a, c
	jr	NZ, 00103$
	ld	a, d
	sub	a, b
	jr	NZ, 00103$
	ld	bc, #0x0000
	jr	00104$
00103$:
	ld	bc, #0x0001
00104$:
	ld	hl, #_prjcnt
	ld	a, (hl)
	add	a, c
	ld	(hl), a
;main.c:289: }
	ret
;main.c:292: inline void itr_projectile_ptr() {
;	---------------------------------
; Function itr_projectile_ptr
; ---------------------------------
_itr_projectile_ptr::
;main.c:293: crntpjct = crntpjct == projectiles + pjctllimit ? projectiles : crntpjct + 1;
	ld	bc, #_projectiles+0
	ld	a, (#_pjctllimit)
	ld	h, #0x00
	ld	l, a
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
	ld	e, l
	ld	d, h
	ld	hl, #_crntpjct
	ld	a, (hl)
	sub	a, e
	jr	NZ, 00103$
	inc	hl
	ld	a, (hl)
	sub	a, d
	jr	Z, 00104$
	jr	00103$
00103$:
	ld	hl, #_crntpjct
	ld	a, (hl)
	add	a, #0x08
	ld	c, a
	inc	hl
	ld	a, (hl)
	adc	a, #0x00
	ld	b, a
00104$:
	ld	hl, #_crntpjct
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;main.c:294: }
	ret
;main.c:297: inline UBYTE found_free_projectile_space() {   // Checks if there is free space in memory to spawn a projectile
;	---------------------------------
; Function found_free_projectile_space
; ---------------------------------
_found_free_projectile_space::
;main.c:298: return prjcnt != pjctllimit + 1 && oamidx != 180;
	ld	hl, #_pjctllimit
	ld	c, (hl)
	ld	b, #0x00
	inc	bc
	ld	hl, #_prjcnt
	ld	e, (hl)
	ld	d, #0x00
	ld	a, e
	sub	a, c
	jr	NZ, 00111$
	ld	a, d
	sub	a, b
	jr	Z, 00103$
00111$:
	ld	a, (#_oamidx)
	sub	a, #0xb4
	jr	NZ, 00104$
00103$:
	ld	e, #0x00
	ret
00104$:
	ld	e, #0x01
;main.c:299: }
	ret
;main.c:302: inline UINT8 get_tile_idx(UINT8 newidxnum) {   // Recalculate tile index according to the OAM tile limit
;	---------------------------------
; Function get_tile_idx
; ---------------------------------
_get_tile_idx::
;main.c:303: return newidxnum > 31 ? newidxnum - 32 : newidxnum;
	ld	a, #0x1f
	ldhl	sp,	#2
	sub	a, (hl)
	jr	NC, 00103$
	ld	a, (hl)
	add	a, #0xe0
	jr	00104$
00103$:
	ldhl	sp,	#2
	ld	a, (hl)
00104$:
	ld	e, a
;main.c:304: }
	ret
;main.c:332: void set_machine_tile(Machine * mch, UINT8 tlnum) { // Sets all machine tiles to a specific tile from memory
;	---------------------------------
; Function set_machine_tile
; ---------------------------------
_set_machine_tile::
;main.c:333: set_sprite_tile(mch->oamtilenums[0], tlnum);
	ldhl	sp,	#4
	ld	a, (hl-)
	ld	c, a
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000d
	add	hl, de
	ld	b, (hl)
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1145: shadow_OAM[nb].tile=tile;
	xor	a, a
	ld	l, b
	ld	h, a
	add	hl, hl
	add	hl, hl
	push	de
	ld	de, #_shadow_OAM
	add	hl, de
	pop	de
	inc	hl
	inc	hl
	ld	(hl), c
;main.c:334: set_sprite_tile(mch->oamtilenums[1], tlnum);
	ld	hl, #0x000e
	add	hl, de
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1145: shadow_OAM[nb].tile=tile;
	ld	a, (hl)
	ld	h, #0x00
	ld	l, a
	add	hl, hl
	add	hl, hl
	push	de
	ld	de, #_shadow_OAM
	add	hl, de
	pop	de
	inc	hl
	inc	hl
	ld	(hl), c
;main.c:335: set_sprite_tile(mch->oamtilenums[2], tlnum);
	ld	hl, #0x000f
	add	hl, de
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1145: shadow_OAM[nb].tile=tile;
	ld	a, (hl)
	ld	h, #0x00
	ld	l, a
	add	hl, hl
	add	hl, hl
	push	de
	ld	de, #_shadow_OAM
	add	hl, de
	pop	de
	inc	hl
	inc	hl
	ld	(hl), c
;main.c:336: set_sprite_tile(mch->oamtilenums[3], tlnum);
	ld	hl, #0x0010
	add	hl, de
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1145: shadow_OAM[nb].tile=tile;
	ld	l, (hl)
	ld	de, #_shadow_OAM+0
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	add	hl, de
	inc	hl
	inc	hl
	ld	(hl), c
;main.c:336: set_sprite_tile(mch->oamtilenums[3], tlnum);
;main.c:337: }
	ret
;main.c:340: void set_machine_sprite_tiles(Machine * mch, UINT8 fsttile) {
;	---------------------------------
; Function set_machine_sprite_tiles
; ---------------------------------
_set_machine_sprite_tiles::
	dec	sp
;main.c:341: set_sprite_tile(mch->oamtilenums[0], fsttile);
	ldhl	sp,	#5
	ld	a, (hl-)
	ld	c, a
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000d
	add	hl, de
	ld	b, (hl)
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1145: shadow_OAM[nb].tile=tile;
	xor	a, a
	ld	l, b
	ld	h, a
	add	hl, hl
	add	hl, hl
	push	de
	ld	de, #_shadow_OAM
	add	hl, de
	pop	de
	inc	hl
	inc	hl
	ld	(hl), c
;main.c:342: set_sprite_tile(mch->oamtilenums[1], fsttile + 2);
	ldhl	sp,	#0
	ld	(hl), c
	ld	c, (hl)
	inc	c
	inc	c
	ld	hl, #0x000e
	add	hl, de
	ld	b, (hl)
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1145: shadow_OAM[nb].tile=tile;
	xor	a, a
	ld	l, b
	ld	h, a
	add	hl, hl
	add	hl, hl
	push	de
	ld	de, #_shadow_OAM
	add	hl, de
	pop	de
	inc	hl
	inc	hl
	ld	(hl), c
;main.c:343: set_sprite_tile(mch->oamtilenums[2], fsttile + 1);
	ldhl	sp,	#0
	ld	c, (hl)
	inc	c
	ld	hl, #0x000f
	add	hl, de
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1145: shadow_OAM[nb].tile=tile;
	ld	a, (hl)
	ld	h, #0x00
	ld	l, a
	add	hl, hl
	add	hl, hl
	push	de
	ld	de, #_shadow_OAM
	add	hl, de
	pop	de
	inc	hl
	inc	hl
	ld	(hl), c
;main.c:344: set_sprite_tile(mch->oamtilenums[3], fsttile + 3);
	ldhl	sp,	#0
	ld	c, (hl)
	inc	c
	inc	c
	inc	c
	ld	hl, #0x0010
	add	hl, de
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1145: shadow_OAM[nb].tile=tile;
	ld	l, (hl)
	ld	de, #_shadow_OAM+0
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	add	hl, de
	inc	hl
	inc	hl
	ld	(hl), c
;main.c:344: set_sprite_tile(mch->oamtilenums[3], fsttile + 3);
;main.c:345: }
	inc	sp
	ret
;main.c:348: void place_machine(Machine * mch, UINT8 x, UINT8 y) {
;	---------------------------------
; Function place_machine
; ---------------------------------
_place_machine::
	add	sp, #-4
;main.c:349: mch->x = x;
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	c, e
	ld	b, d
	inc	bc
	inc	hl
	ld	a, (hl)
	ld	(bc), a
;main.c:350: mch->y = y;
	ld	c, e
	ld	b, d
	inc	bc
	inc	bc
	inc	hl
	ld	a, (hl)
	ld	(bc), a
;main.c:351: move_sprite(mch->oamtilenums[0], x, y);
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl), a
	ldhl	sp,	#8
	ld	a, (hl)
	ldhl	sp,	#1
	ld	(hl), a
	ld	hl, #0x000d
	add	hl, de
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1218: OAM_item_t * itm = &shadow_OAM[nb];
	ld	a, (hl)
	ld	h, #0x00
	ld	l, a
	add	hl, hl
	add	hl, hl
	ld	bc, #_shadow_OAM
	add	hl, bc
	ld	c, l
	ld	b, h
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1219: itm->y=y, itm->x=x;
	ldhl	sp,	#0
	ld	a, (hl+)
	ld	(bc), a
	inc	bc
	ld	a, (hl)
	ld	(bc), a
;main.c:352: move_sprite(mch->oamtilenums[1], x + 8, y);
	ld	a, (hl)
	add	a, #0x08
	inc	hl
	ld	(hl), a
	ld	a, (hl+)
	ld	(hl), a
	ld	hl, #0x000e
	add	hl, de
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1218: OAM_item_t * itm = &shadow_OAM[nb];
	ld	a, (hl)
	ld	h, #0x00
	ld	l, a
	add	hl, hl
	add	hl, hl
	ld	bc, #_shadow_OAM
	add	hl, bc
	ld	c, l
	ld	b, h
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1219: itm->y=y, itm->x=x;
	ldhl	sp,	#0
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ldhl	sp,	#3
	ld	a, (hl)
	ld	(bc), a
;main.c:353: move_sprite(mch->oamtilenums[2], x, y + 8);
	ldhl	sp,	#0
	ld	a, (hl)
	add	a, #0x08
	ldhl	sp,	#3
	ld	(hl), a
	ld	c, (hl)
	ld	hl, #0x000f
	add	hl, de
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1218: OAM_item_t * itm = &shadow_OAM[nb];
	ld	l, (hl)
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	ld	a, l
	add	a, #<(_shadow_OAM)
	ld	b, a
	ld	a, h
	adc	a, #>(_shadow_OAM)
	ld	l, b
	ld	h, a
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1219: itm->y=y, itm->x=x;
	ld	a, c
	ld	(hl+), a
	ld	c, l
	ld	b, h
	ldhl	sp,	#1
	ld	a, (hl)
	ld	(bc), a
;main.c:354: move_sprite(mch->oamtilenums[3], x + 8, y + 8);
	ld	hl, #0x0010
	add	hl, de
	ld	e, (hl)
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1218: OAM_item_t * itm = &shadow_OAM[nb];
	ld	bc, #_shadow_OAM+0
	xor	a, a
	ld	l, e
	ld	h, a
	add	hl, hl
	add	hl, hl
	add	hl, bc
	ld	c, l
	ld	b, h
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1219: itm->y=y, itm->x=x;
	ldhl	sp,	#3
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	dec	hl
	ld	a, (hl)
	ld	(bc), a
;main.c:354: move_sprite(mch->oamtilenums[3], x + 8, y + 8);
;main.c:355: }
	add	sp, #4
	ret
;main.c:358: void init_player() {
;	---------------------------------
; Function init_player
; ---------------------------------
_init_player::
;main.c:359: pl = machines; // First element of the array is the player
	ld	hl, #_pl
	ld	a, #<(_machines)
	ld	(hl+), a
;main.c:360: pl->shield = 4;
	ld	a, #>(_machines)
	ld	(hl-), a
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x000b
	add	hl, bc
	ld	(hl), #0x04
;main.c:361: pl->groundflg = 1;
	ld	hl, #_pl + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, #0x01
	ld	(bc), a
;main.c:362: pl->hboffx = 3;
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	inc	bc
	inc	bc
	ld	a, b
	ld	l, c
	ld	h, a
	ld	(hl), #0x03
;main.c:363: pl->hboffy = 1;
	ld	hl, #_pl + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0004
	add	hl, bc
	ld	(hl), #0x01
;main.c:364: pl->width = 13;
	ld	hl, #_pl + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0005
	add	hl, bc
	ld	(hl), #0x0d
;main.c:365: pl->height = 15;
	ld	hl, #_pl + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0006
	add	hl, bc
	ld	(hl), #0x0f
;main.c:366: pl->gunoffx = 17;
	ld	hl, #_pl + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0009
	add	hl, bc
	ld	(hl), #0x11
;main.c:367: pl->gunoffy = 12;
	ld	hl, #_pl + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x000a
	add	hl, bc
	ld	(hl), #0x0c
;main.c:368: pl->explcount = 0;
	ld	hl, #_pl + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0007
	add	hl, bc
	ld	(hl), #0x00
;main.c:369: pl->cyccount = 0;
	ld	hl, #_pl + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0008
	add	hl, bc
	ld	(hl), #0x00
;main.c:370: pl->oamtilenums[0] = 0;
	ld	hl, #_pl + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x000d
	add	hl, bc
	ld	(hl), #0x00
;main.c:371: pl->oamtilenums[1] = 1;
	ld	hl, #_pl + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x000e
	add	hl, bc
	ld	(hl), #0x01
;main.c:372: pl->oamtilenums[2] = 2;
	ld	hl, #_pl + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x000f
	add	hl, bc
	ld	(hl), #0x02
;main.c:373: pl->oamtilenums[3] = 3;
	ld	hl, #_pl + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0010
	add	hl, bc
	ld	(hl), #0x03
;main.c:375: set_machine_sprite_tiles(pl, 1);
	ld	a, #0x01
	push	af
	inc	sp
	ld	hl, #_pl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_set_machine_sprite_tiles
	add	sp, #3
;main.c:376: incr_oam_sprite_tile_idx(4);
	ld	a, #0x04
	push	af
	inc	sp
	call	_incr_oam_sprite_tile_idx
	inc	sp
;main.c:377: place_machine(pl, 248, roadlanesy[1]);
	ld	a, (#(_roadlanesy + 0x0001) + 0)
	ld	d,a
	ld	e,#0xf8
	push	de
	ld	hl, #_pl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_place_machine
	add	sp, #4
;main.c:378: }
	ret
;main.c:381: void respawn_player() {
;	---------------------------------
; Function respawn_player
; ---------------------------------
_respawn_player::
;main.c:382: pl->shield = 4;
	ld	hl, #_pl + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x000b
	add	hl, bc
	ld	(hl), #0x04
;main.c:383: pl->hboffx = 3;
	ld	hl, #_pl + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	inc	bc
	inc	bc
	ld	a, b
	ld	l, c
	ld	h, a
	ld	(hl), #0x03
;main.c:384: pl->hboffy = 1;
	ld	hl, #_pl + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0004
	add	hl, bc
	ld	(hl), #0x01
;main.c:385: ascendflg = 1;
	ld	hl, #_ascendflg
	ld	(hl), #0x01
;main.c:386: hud_upd_shield(0, 4);
	ld	a, #0x04
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_hud_upd_shield
	add	sp, #2
;main.c:382: pl->shield = 4;
	ld	hl, #_pl + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
;main.c:387: if(fallinholeflg) {
	ld	hl, #_fallinholeflg
	ld	a, (hl)
	or	a, a
	jr	Z, 00102$
;main.c:388: fallinholeflg = 0;
	ld	(hl), #0x00
;main.c:389: pl->groundflg = 0;
	xor	a, a
	ld	(bc), a
;main.c:390: set_machine_sprite_tiles(pl, 13);
	ld	a, #0x0d
	push	af
	inc	sp
	ld	hl, #_pl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_set_machine_sprite_tiles
	add	sp, #3
;main.c:391: place_machine(pl, 16, 64);
	ld	de, #0x4010
	push	de
	ld	hl, #_pl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_place_machine
	add	sp, #4
;main.c:392: lockmvmnt = 2;
	ld	hl, #_lockmvmnt
	ld	(hl), #0x02
;main.c:393: jumpstarty = roadlanesy[1];
	ld	a, (#(_roadlanesy + 0x0001) + 0)
	ld	(#_jumpstarty),a
	jr	00103$
00102$:
;main.c:395: pl->groundflg = 1;
;main.c:396: set_machine_sprite_tiles(pl, 1);
	ld	a,#0x01
	ld	(bc),a
	push	af
	inc	sp
	ld	hl, #_pl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_set_machine_sprite_tiles
	add	sp, #3
;main.c:397: place_machine(pl, 16, roadlanesy[1]);
	ld	a, (#(_roadlanesy + 0x0001) + 0)
	ld	d,a
	ld	e,#0x10
	push	de
	ld	hl, #_pl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_place_machine
	add	sp, #4
;main.c:398: lockmvmnt = 0;
	ld	hl, #_lockmvmnt
	ld	(hl), #0x00
00103$:
;main.c:400: iframeflg = 1;
	ld	hl, #_iframeflg
	ld	(hl), #0x01
;main.c:401: }
	ret
;main.c:407: void init_machine_props(UINT8 x, UINT8 y, const INT8 * mchprops) {
;	---------------------------------
; Function init_machine_props
; ---------------------------------
_init_machine_props::
;main.c:408: crntenemy->explcount = 0;
	ld	hl, #_crntenemy + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0007
	add	hl, bc
	ld	(hl), #0x00
;main.c:409: crntenemy->cyccount = 0;
	ld	hl, #_crntenemy + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0008
	add	hl, bc
	ld	(hl), #0x00
;main.c:410: crntenemy->groundflg = mchprops[0];
	ld	hl, #_crntenemy + 1
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,#4
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, (bc)
	ld	(de), a
;main.c:411: crntenemy->shield = mchprops[1];
	ld	hl, #_crntenemy + 1
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000b
	add	hl, de
	ld	e, c
	ld	d, b
	inc	de
	ld	a, (de)
	ld	(hl), a
;main.c:412: crntenemy->hboffx = mchprops[2];
	ld	hl, #_crntenemy + 1
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	inc	de
	inc	de
	inc	de
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	ld	a, (hl)
	ld	(de), a
;main.c:413: crntenemy->hboffy = mchprops[3];
	ld	hl, #_crntenemy + 1
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	inc	de
	inc	de
	inc	de
	inc	de
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	ld	(de), a
;main.c:414: crntenemy->width = mchprops[4];
	ld	hl, #_crntenemy + 1
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	inc	de
	inc	de
	inc	de
	inc	de
	inc	de
	ld	hl, #0x0004
	add	hl, bc
	ld	a, (hl)
	ld	(de), a
;main.c:415: crntenemy->height = mchprops[5];
	ld	hl, #_crntenemy + 1
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0006
	add	hl, de
	ld	e, l
	ld	d, h
	ld	hl, #0x0005
	add	hl, bc
	ld	a, (hl)
	ld	(de), a
;main.c:416: crntenemy->gunoffx = mchprops[6];
	ld	hl, #_crntenemy + 1
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0009
	add	hl, de
	ld	e, l
	ld	d, h
	ld	hl, #0x0006
	add	hl, bc
	ld	a, (hl)
	ld	(de), a
;main.c:417: crntenemy->gunoffy = mchprops[7];
	ld	hl, #_crntenemy + 1
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000a
	add	hl, de
	ld	e, l
	ld	d, h
	ld	hl, #0x0007
	add	hl, bc
	ld	a, (hl)
	ld	(de), a
;main.c:418: crntenemy->type = mchprops[8];
	ld	hl, #_crntenemy + 1
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000c
	add	hl, de
	ld	e, l
	ld	d, h
	ld	hl, #0x0008
	add	hl, bc
	ld	a, (hl)
	ld	(de), a
;main.c:419: for(i = 0; i < 4; i++) {
	ld	hl, #_i
	ld	(hl), #0x00
00103$:
;main.c:420: crntenemy->oamtilenums[i] = oamidx;
	ld	hl, #_crntenemy + 1
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000d
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (#_i)
	add	a, e
	ld	e, a
	ld	a, #0x00
	adc	a, d
	ld	d, a
	ld	a, (#_oamidx)
	ld	(de), a
;main.c:421: incr_oam_sprite_tile_idx(1);
	push	bc
	ld	a, #0x01
	push	af
	inc	sp
	call	_incr_oam_sprite_tile_idx
	inc	sp
	pop	bc
;main.c:419: for(i = 0; i < 4; i++) {
	ld	hl, #_i
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x04
	jr	C, 00103$
;main.c:423: set_machine_sprite_tiles(crntenemy, mchprops[9]);
	ld	hl, #0x0009
	add	hl, bc
	ld	a, (hl)
	push	af
	inc	sp
	ld	hl, #_crntenemy
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_set_machine_sprite_tiles
	add	sp, #3
;main.c:424: place_machine(crntenemy, x, y);
	ldhl	sp,	#3
	ld	a, (hl)
	push	af
	inc	sp
	dec	hl
	ld	a, (hl)
	push	af
	inc	sp
	ld	hl, #_crntenemy
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_place_machine
	add	sp, #4
;main.c:283: crntenemy = crntenemy == machines + enlimit ? machines + 1 : crntenemy + 1;
	ld	hl, #_enlimit
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
	ld	de, #_machines
	add	hl, de
	ld	c, l
	ld	b, h
	ld	hl, #_crntenemy
	ld	a, (hl)
	sub	a, c
	jr	NZ, 00107$
	inc	hl
	ld	a, (hl)
	sub	a, b
	jr	NZ, 00107$
	ld	bc, #_machines + 17
	jr	00108$
00107$:
	ld	hl, #_crntenemy
	ld	a, (hl)
	add	a, #0x11
	ld	c, a
	inc	hl
	ld	a, (hl)
	adc	a, #0x00
	ld	b, a
00108$:
	ld	hl, #_crntenemy
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;main.c:425: itr_enemies_ptr();
;main.c:426: }
	ret
;main.c:431: void init_scorpboss_gun(UINT8 x, UINT8 y) {
;	---------------------------------
; Function init_scorpboss_gun
; ---------------------------------
_init_scorpboss_gun::
;main.c:432: crntenemy->groundflg = 1;
	ld	hl, #_crntenemy + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, #0x01
	ld	(bc), a
;main.c:433: crntenemy->shield = 10;
	dec	hl
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ld	hl, #0x000b
	add	hl, bc
	ld	(hl), #0x0a
;main.c:434: crntenemy->hboffx = 1;
	ld	hl, #_crntenemy + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	inc	bc
	inc	bc
	ld	a, b
	ld	l, c
	ld	h, a
	ld	(hl), #0x01
;main.c:435: crntenemy->hboffy = 0;
	ld	hl, #_crntenemy + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	inc	bc
	inc	bc
	inc	bc
	xor	a, a
	ld	(bc), a
;main.c:436: crntenemy->gunoffx = -3;
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0009
	add	hl, bc
	ld	(hl), #0xfd
;main.c:437: crntenemy->gunoffy = 1;
	ld	hl, #_crntenemy + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x000a
	add	hl, bc
	ld	(hl), #0x01
;main.c:438: crntenemy->width = 8;
	ld	hl, #_crntenemy + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0005
	add	hl, bc
	ld	(hl), #0x08
;main.c:439: crntenemy->height = 8;
	ld	hl, #_crntenemy + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0006
	add	hl, bc
	ld	(hl), #0x08
;main.c:440: crntenemy->type = 6;
	ld	hl, #_crntenemy + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x000c
	add	hl, bc
	ld	(hl), #0x06
;main.c:441: for(i = 0; i < 4; i++) {
	ld	hl, #_i
	ld	(hl), #0x00
00104$:
;main.c:442: crntenemy->oamtilenums[i] = oamidx;
	ld	hl, #_crntenemy
	ld	a, (hl+)
	ld	e, a
	ld	b, (hl)
	ld	a, e
	add	a, #0x0d
	ld	c, a
	jr	NC, 00125$
	inc	b
00125$:
	ld	a, (#_i)
	add	a, c
	ld	c, a
	ld	a, #0x00
	adc	a, b
	ld	b, a
	ld	a, (#_oamidx)
	ld	(bc), a
;main.c:443: incr_oam_sprite_tile_idx(1);
	ld	a, #0x01
	push	af
	inc	sp
	call	_incr_oam_sprite_tile_idx
	inc	sp
;main.c:441: for(i = 0; i < 4; i++) {
	ld	hl, #_i
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x04
	jr	C, 00104$
;main.c:445: set_machine_tile(crntenemy, 127);   // Last tile is blank => won't be used for bullets accidently
	ld	a, #0x7f
	push	af
	inc	sp
	ld	hl, #_crntenemy
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_set_machine_tile
	add	sp, #3
;main.c:446: set_sprite_tile(crntenemy->oamtilenums[0], 22);
	ld	hl, #_crntenemy + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x000d
	add	hl, bc
	ld	e, (hl)
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1145: shadow_OAM[nb].tile=tile;
	ld	bc, #_shadow_OAM+0
	xor	a, a
	ld	l, e
	ld	h, a
	add	hl, hl
	add	hl, hl
	add	hl, bc
	inc	hl
	inc	hl
	ld	(hl), #0x16
;main.c:447: place_machine(crntenemy, x, y);
	ldhl	sp,	#3
	ld	a, (hl)
	push	af
	inc	sp
	dec	hl
	ld	a, (hl)
	push	af
	inc	sp
	ld	hl, #_crntenemy
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_place_machine
	add	sp, #4
;main.c:283: crntenemy = crntenemy == machines + enlimit ? machines + 1 : crntenemy + 1;
	ld	hl, #_enlimit
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
	ld	de, #_machines
	add	hl, de
	ld	c, l
	ld	b, h
	ld	hl, #_crntenemy
	ld	a, (hl)
	sub	a, c
	jr	NZ, 00108$
	inc	hl
	ld	a, (hl)
	sub	a, b
	jr	NZ, 00108$
	ld	bc, #_machines + 17
	jr	00109$
00108$:
	ld	hl, #_crntenemy
	ld	a, (hl)
	add	a, #0x11
	ld	c, a
	inc	hl
	ld	a, (hl)
	adc	a, #0x00
	ld	b, a
00109$:
	ld	hl, #_crntenemy
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;main.c:448: itr_enemies_ptr();
;main.c:449: }
	ret
;main.c:452: void init_scorpboss() {
;	---------------------------------
; Function init_scorpboss
; ---------------------------------
_init_scorpboss::
;main.c:453: set_bkg_data(100, 40, scorpbosstiles);
	ld	hl, #_scorpbosstiles
	push	hl
	ld	de, #0x2864
	push	de
	call	_set_bkg_data
	add	sp, #4
;main.c:454: set_bkg_tiles(11, 10, 9, 6, scorpbossmap);
	ld	hl, #_scorpbossmap
	push	hl
	ld	de, #0x0609
	push	de
	ld	de, #0x0a0b
	push	de
	call	_set_bkg_tiles
	add	sp, #6
;main.c:455: set_sprite_data(20, 8, bossspritetiles);
	ld	hl, #_bossspritetiles
	push	hl
	ld	de, #0x0814
	push	de
	call	_set_sprite_data
	add	sp, #4
;main.c:458: crntenemy->groundflg = 1;
	ld	hl, #_crntenemy + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, #0x01
	ld	(bc), a
;main.c:459: crntenemy->shield = 10;
	dec	hl
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ld	hl, #0x000b
	add	hl, bc
	ld	(hl), #0x0a
;main.c:460: crntenemy->hboffx = 1;
	ld	hl, #_crntenemy + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	inc	bc
	inc	bc
	ld	a, b
	ld	l, c
	ld	h, a
	ld	(hl), #0x01
;main.c:461: crntenemy->hboffy = 0;
	ld	hl, #_crntenemy + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	inc	bc
	inc	bc
	inc	bc
	xor	a, a
	ld	(bc), a
;main.c:462: crntenemy->width = 8;
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0005
	add	hl, bc
	ld	(hl), #0x08
;main.c:463: crntenemy->height = 13;
	ld	hl, #_crntenemy + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0006
	add	hl, bc
	ld	(hl), #0x0d
;main.c:464: crntenemy->type = 6;
	ld	hl, #_crntenemy + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x000c
	add	hl, bc
	ld	(hl), #0x06
;main.c:465: for(i = 0; i < 4; i++) {
	ld	hl, #_i
	ld	(hl), #0x00
00105$:
;main.c:466: crntenemy->oamtilenums[i] = oamidx;
	ld	hl, #_crntenemy
	ld	a, (hl+)
	ld	e, a
	ld	b, (hl)
	ld	a, e
	add	a, #0x0d
	ld	c, a
	jr	NC, 00126$
	inc	b
00126$:
	ld	a, (#_i)
	add	a, c
	ld	c, a
	ld	a, #0x00
	adc	a, b
	ld	b, a
	ld	a, (#_oamidx)
	ld	(bc), a
;main.c:467: incr_oam_sprite_tile_idx(1);
	ld	a, #0x01
	push	af
	inc	sp
	call	_incr_oam_sprite_tile_idx
	inc	sp
;main.c:465: for(i = 0; i < 4; i++) {
	ld	hl, #_i
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x04
	jr	C, 00105$
;main.c:469: set_machine_tile(crntenemy, 127);   // Last tile is blank => won't be used for bullets accidently
	ld	a, #0x7f
	push	af
	inc	sp
	ld	hl, #_crntenemy
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_set_machine_tile
	add	sp, #3
;main.c:470: set_sprite_tile(crntenemy->oamtilenums[0], 20);
	ld	hl, #_crntenemy + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x000d
	add	hl, bc
	ld	e, (hl)
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1145: shadow_OAM[nb].tile=tile;
	ld	bc, #_shadow_OAM+0
	xor	a, a
	ld	l, e
	ld	h, a
	add	hl, hl
	add	hl, hl
	add	hl, bc
	inc	hl
	inc	hl
	ld	(hl), #0x14
;main.c:471: set_sprite_tile(crntenemy->oamtilenums[2], 21);
	ld	hl, #_crntenemy + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x000f
	add	hl, bc
	ld	e, (hl)
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1145: shadow_OAM[nb].tile=tile;
	ld	bc, #_shadow_OAM+0
	xor	a, a
	ld	l, e
	ld	h, a
	add	hl, hl
	add	hl, hl
	add	hl, bc
	inc	hl
	inc	hl
	ld	(hl), #0x15
;main.c:472: place_machine(crntenemy, 121, 96);
	ld	de, #0x6079
	push	de
	ld	hl, #_crntenemy
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_place_machine
	add	sp, #4
;main.c:283: crntenemy = crntenemy == machines + enlimit ? machines + 1 : crntenemy + 1;
	ld	hl, #_enlimit
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
	ld	de, #_machines
	add	hl, de
	ld	c, l
	ld	b, h
	ld	hl, #_crntenemy
	ld	a, (hl)
	sub	a, c
	jr	NZ, 00109$
	inc	hl
	ld	a, (hl)
	sub	a, b
	jr	NZ, 00109$
	ld	bc, #_machines + 17
	jr	00110$
00109$:
	ld	hl, #_crntenemy
	ld	a, (hl)
	add	a, #0x11
	ld	c, a
	inc	hl
	ld	a, (hl)
	adc	a, #0x00
	ld	b, a
00110$:
	ld	hl, #_crntenemy
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;main.c:476: init_scorpboss_gun(100, 105);
	ld	de, #0x6964
	push	de
	call	_init_scorpboss_gun
	add	sp, #2
;main.c:479: init_scorpboss_gun(96, 136);
	ld	de, #0x8860
	push	de
	call	_init_scorpboss_gun
	add	sp, #2
;main.c:480: }
	ret
;main.c:483: inline UBYTE collides_with_sidewalk(INT8 vspeed) {
;	---------------------------------
; Function collides_with_sidewalk
; ---------------------------------
_collides_with_sidewalk::
;main.c:484: return pl->y + vspeed < 96 || pl->y + vspeed > 127;
	ld	hl, #_pl + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	inc	bc
	ld	a, b
	ld	l, c
	ld	h, a
	ld	c, (hl)
	ld	b, #0x00
	ldhl	sp,	#2
	ld	a, (hl)
	ld	e, a
	rla
	sbc	a, a
	ld	d, a
	ld	l, e
	ld	h, d
	add	hl, bc
	ld	a, l
	sub	a, #0x60
	ld	a, h
	rla
	ccf
	rra
	sbc	a, #0x80
	jr	C, 00104$
	ld	e, h
	ld	d, #0x00
	ld	a, #0x7f
	cp	a, l
	ld	a, #0x00
	sbc	a, h
	bit	7, e
	jr	Z, 00116$
	bit	7, d
	jr	NZ, 00117$
	cp	a, a
	jr	00117$
00116$:
	bit	7, d
	jr	Z, 00117$
	scf
00117$:
	jr	C, 00104$
	ld	e, #0x00
	ret
00104$:
	ld	e, #0x01
;main.c:485: }
	ret
;main.c:488: inline UBYTE is_inside_x_bounds(UINT8 posx) {
;	---------------------------------
; Function is_inside_x_bounds
; ---------------------------------
_is_inside_x_bounds::
;main.c:489: return posx > 15 && posx < 141;
	ld	a, #0x0f
	ldhl	sp,	#2
	sub	a, (hl)
	jr	NC, 00103$
	ld	a, (hl)
	sub	a, #0x8d
	jr	C, 00104$
00103$:
	ld	e, #0x00
	ret
00104$:
	ld	e, #0x01
;main.c:490: }
	ret
;main.c:493: void move_machine(Machine * mch, INT8 speedx, INT8 speedy) {
;	---------------------------------
; Function move_machine
; ---------------------------------
_move_machine::
	add	sp, #-6
;main.c:494: mch->x += speedx;
	ldhl	sp,#8
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	l, c
	ld	h, b
	inc	hl
	inc	sp
	inc	sp
	ld	e, l
	ld	d, h
	push	de
	ld	a, (de)
	ldhl	sp,	#10
	add	a, (hl)
	pop	hl
	push	hl
	ld	(hl), a
;main.c:495: mch->y += speedy;
	ld	hl, #0x0002
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#11
	add	a, (hl)
	ldhl	sp,	#2
	push	af
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	pop	af
	ld	(hl), a
;main.c:496: move_sprite(mch->oamtilenums[0], mch->x, mch->y);
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	inc	hl
	ld	(hl), a
	pop	de
	push	de
	ld	a, (de)
	inc	hl
	ld	(hl), a
	ld	hl, #0x000d
	add	hl, bc
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1218: OAM_item_t * itm = &shadow_OAM[nb];
	ld	a, (hl)
	ld	h, #0x00
	ld	l, a
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
	ld	e, l
	ld	d, h
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1219: itm->y=y, itm->x=x;
	ldhl	sp,	#4
	ld	a, (hl)
	ld	(de), a
	inc	de
	inc	hl
	ld	a, (hl)
	ld	(de), a
;main.c:497: move_sprite(mch->oamtilenums[1], mch->x + 8, mch->y);
	dec	hl
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	inc	hl
	ld	(hl), a
	pop	de
	push	de
	ld	a, (de)
	add	a, #0x08
	inc	hl
	ld	(hl), a
	ld	hl, #0x000e
	add	hl, bc
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1218: OAM_item_t * itm = &shadow_OAM[nb];
	ld	a, (hl)
	ld	h, #0x00
	ld	l, a
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
	ld	e, l
	ld	d, h
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1219: itm->y=y, itm->x=x;
	ldhl	sp,	#4
	ld	a, (hl)
	ld	(de), a
	inc	de
	inc	hl
	ld	a, (hl)
	ld	(de), a
;main.c:498: move_sprite(mch->oamtilenums[2], mch->x, mch->y + 8);
	dec	hl
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	add	a, #0x08
	inc	hl
	ld	(hl), a
	pop	de
	push	de
	ld	a, (de)
	inc	hl
	ld	(hl), a
	ld	hl, #0x000f
	add	hl, bc
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1218: OAM_item_t * itm = &shadow_OAM[nb];
	ld	a, (hl)
	ld	h, #0x00
	ld	l, a
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
	ld	e, l
	ld	d, h
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1219: itm->y=y, itm->x=x;
	ldhl	sp,	#4
	ld	a, (hl)
	ld	(de), a
	inc	de
	inc	hl
	ld	a, (hl)
	ld	(de), a
;main.c:499: move_sprite(mch->oamtilenums[3], mch->x + 8, mch->y + 8);
	dec	hl
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	add	a, #0x08
	inc	hl
	inc	hl
	ld	(hl), a
	pop	de
	push	de
	ld	a, (de)
	add	a, #0x08
	ld	e, a
	ld	hl, #0x0010
	add	hl, bc
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1218: OAM_item_t * itm = &shadow_OAM[nb];
	ld	l, (hl)
	ld	bc, #_shadow_OAM+0
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	add	hl, bc
	ld	c, l
	ld	b, h
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1219: itm->y=y, itm->x=x;
	ldhl	sp,	#5
	ld	a, (hl)
	ld	(bc), a
	inc	bc
	ld	a, e
	ld	(bc), a
;main.c:499: move_sprite(mch->oamtilenums[3], mch->x + 8, mch->y + 8);
;main.c:500: }
	add	sp, #6
	ret
;main.c:503: void move_player(INT8 speedx, INT8 speedy) {
;	---------------------------------
; Function move_player
; ---------------------------------
_move_player::
;main.c:504: if((speedx != 0 && is_inside_x_bounds(pl->x + speedx))
	ld	hl, #_pl + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#2
	ld	a, (hl)
	or	a, a
	jr	Z, 00105$
	ld	e, c
	ld	d, b
	inc	de
	ld	a, (de)
	add	a, (hl)
	ld	e, a
;main.c:489: return posx > 15 && posx < 141;
	ld	a, #0x0f
	sub	a, e
	jr	NC, 00110$
	ld	a, e
	sub	a, #0x8d
	jr	C, 00111$
00110$:
	xor	a, a
	jr	00112$
00111$:
	ld	a, #0x01
00112$:
;main.c:504: if((speedx != 0 && is_inside_x_bounds(pl->x + speedx))
	or	a, a
	jr	NZ, 00101$
00105$:
;main.c:505: || (speedy != 0 && !collides_with_sidewalk(speedy)) ) {
	ldhl	sp,	#3
	ld	a, (hl)
	or	a, a
	ret	Z
	ld	e, (hl)
;main.c:484: return pl->y + vspeed < 96 || pl->y + vspeed > 127;
	inc	bc
	inc	bc
	ld	a, (bc)
	ld	l, a
	ld	h, #0x00
	ld	a, e
	rla
	sbc	a, a
	ld	d, a
	add	hl, de
	ld	a, l
	sub	a, #0x60
	ld	a, h
	rla
	ccf
	rra
	sbc	a, #0x80
	jr	C, 00114$
	ld	e, h
	ld	d, #0x00
	ld	a, #0x7f
	cp	a, l
	ld	a, #0x00
	sbc	a, h
	bit	7, e
	jr	Z, 00141$
	bit	7, d
	jr	NZ, 00142$
	cp	a, a
	jr	00142$
00141$:
	bit	7, d
	jr	Z, 00142$
	scf
00142$:
	jr	C, 00114$
	xor	a, a
	jr	00115$
00114$:
	ld	a, #0x01
00115$:
;main.c:505: || (speedy != 0 && !collides_with_sidewalk(speedy)) ) {
	or	a, a
	ret	NZ
00101$:
;main.c:506: move_machine(pl, speedx, speedy);
	ldhl	sp,	#3
	ld	a, (hl)
	push	af
	inc	sp
	dec	hl
	ld	a, (hl)
	push	af
	inc	sp
	ld	hl, #_pl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_move_machine
	add	sp, #4
;main.c:508: }
	ret
;main.c:511: void move_enemy(Machine * en, INT8 speedx, INT8 speedy) {
;	---------------------------------
; Function move_enemy
; ---------------------------------
_move_enemy::
;main.c:512: move_machine(en, speedx, speedy);
	ldhl	sp,	#5
	ld	a, (hl)
	push	af
	inc	sp
	dec	hl
	ld	a, (hl)
	push	af
	inc	sp
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_move_machine
	add	sp, #4
;main.c:513: if(!is_obj_inside_screen(en->x, en->y, 16, 16)) {
	pop	bc
	pop	de
	push	de
	push	bc
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	ld	b, (hl)
	ld	l, e
	ld	h, d
	inc	hl
	ld	a, (hl)
	push	de
	ld	h, #0x10
	push	hl
	inc	sp
	ld	h, #0x10
	ld	l, b
	push	hl
	push	af
	inc	sp
	call	_is_obj_inside_screen
	add	sp, #4
	ld	a, e
	pop	de
	or	a, a
	ret	NZ
;main.c:514: destroy_machine(en);
	push	de
	call	_destroy_machine
	add	sp, #2
;main.c:516: }
	ret
;main.c:519: void incr_bkg_x_coords(UINT8 roadsp) {
;	---------------------------------
; Function incr_bkg_x_coords
; ---------------------------------
_incr_bkg_x_coords::
;main.c:524: }
	di
;main.c:521: cloudposx += roadsp - 3;
	ldhl	sp,	#2
	ld	c, (hl)
	ld	a, c
	add	a, #0xfd
	ld	hl, #_cloudposx
	ld	b, (hl)
	add	a, b
	ld	(hl), a
;main.c:522: sceneryposx += roadsp - 1;
	dec	c
	ld	hl, #_sceneryposx
	ld	a, (hl)
	add	a, c
	ld	(hl), a
;main.c:523: roadposx += roadsp;
	ld	a, (#_roadposx)
	ldhl	sp,	#2
	add	a, (hl)
	ld	(#_roadposx),a
	ei
;main.c:525: }
	ret
;main.c:546: void place_stage_obj(UINT8 type, UINT8 x, UINT8 y) {
;	---------------------------------
; Function place_stage_obj
; ---------------------------------
_place_stage_obj::
;main.c:547: init_machine_props(x, y, *(enprops + type));
	ldhl	sp,	#2
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, bc
	add	hl, hl
	ld	bc,#_enprops
	add	hl,bc
	push	hl
	ldhl	sp,	#6
	ld	a, (hl)
	push	af
	inc	sp
	dec	hl
	ld	a, (hl)
	push	af
	inc	sp
	call	_init_machine_props
	add	sp, #4
;main.c:548: }
	ret
;main.c:551: void build_stage() {   // Automatically builds the road ahead while scrolling the stage
;	---------------------------------
; Function build_stage
; ---------------------------------
_build_stage::
	add	sp, #-2
;main.c:552: camtileidx = get_tile_idx((SCX_REG + 168) / 8);
	ldh	a, (_SCX_REG+0)
	ld	b, #0x00
	add	a, #0xa8
	ld	c, a
	jr	NC, 00166$
	inc	b
00166$:
	ld	l, c
	ld	h, b
	bit	7, b
	jr	Z, 00118$
	ld	hl, #0x0007
	add	hl, bc
00118$:
	sra	h
	rr	l
	sra	h
	rr	l
	sra	h
	rr	l
;main.c:303: return newidxnum > 31 ? newidxnum - 32 : newidxnum;
	ld	a, #0x1f
	sub	a, l
	jr	NC, 00119$
	ld	a, l
	add	a, #0xe0
	jr	00120$
00119$:
	ld	a, l
00120$:
	ld	hl, #_camtileidx
	ld	(hl), a
;main.c:553: if(camtileidx == nextcamtileidx) {
	ld	a, (hl)
	ld	hl, #_nextcamtileidx
	sub	a, (hl)
	jp	NZ,00112$
;main.c:554: if(holeflg) {
	ld	a, (#_holeflg)
	or	a, a
	jr	Z, 00102$
;main.c:555: build_hole();
	call	_build_hole
	jr	00103$
00102$:
;main.c:557: build_road();
	call	_build_road
00103$:
;main.c:561: if(roadbuildidx == crntstage->roadlayout[stageidx]) {
	ld	hl, #_crntstage + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	e, c
	ld	d, b
	ld	a, (de)
	ldhl	sp,	#0
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;c
	pop	de
	push	de
	ld	hl, #_stageidx
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ld	e, a
	ld	a, (#_roadbuildidx)
	sub	a, e
	jr	NZ, 00105$
;main.c:562: stageidx++; // Moving to next elem in stage array
	ld	hl, #_stageidx
	inc	(hl)
;main.c:563: roadbuildidx = 0;
	ld	hl, #_roadbuildidx
	ld	(hl), #0x00
;main.c:564: holeflg = !holeflg; // Roads and holes alternate
	ld	hl, #_holeflg
	ld	a, (hl)
	sub	a,#0x01
	ld	a, #0x00
	rla
	ld	(hl), a
	jr	00106$
00105$:
;main.c:566: roadbuildidx++;
	ld	hl, #_roadbuildidx
	inc	(hl)
00106$:
;main.c:570: if(lvlobjscnt != crntstage->ennum && lvlplacptr->arridx == stageidx && lvlplacptr->elemidx == roadbuildidx) {
	ld	hl, #0x0005
	add	hl, bc
	ld	c, (hl)
	ld	a, (#_lvlobjscnt)
	sub	a, c
	jr	Z, 00112$
	ld	hl, #_lvlplacptr + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, (bc)
	ld	e, a
	ld	a, (#_stageidx)
	sub	a, e
	jr	NZ, 00112$
	ld	l, c
	ld	h, b
	inc	hl
	ld	e, (hl)
	ld	a, (#_roadbuildidx)
	sub	a, e
	jr	NZ, 00112$
;main.c:571: place_stage_obj(lvlplacptr->type, lvlplacptr->x, lvlplacptr->y);
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	inc	hl
	ld	e, (hl)
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	ld	d, (hl)
	inc	bc
	inc	bc
	inc	bc
	inc	bc
	ld	a, (bc)
	ld	h, e
	ld	l, d
	push	hl
	push	af
	inc	sp
	call	_place_stage_obj
	add	sp, #3
;main.c:572: lvlplacptr++;
	ld	hl, #_lvlplacptr
	ld	a, (hl)
	add	a, #0x05
	ld	(hl+), a
	ld	a, (hl)
	adc	a, #0x00
	ld	(hl), a
;main.c:573: lvlobjscnt++;
	ld	hl, #_lvlobjscnt
	inc	(hl)
00112$:
;main.c:577: if(stageidx == crntstage->roadlength) { // End of stage reached
	ld	hl, #_crntstage + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	inc	bc
	ld	a, b
	ld	l, c
	ld	h, a
	ld	c, (hl)
	ld	a, (#_stageidx)
	sub	a, c
	jr	NZ, 00116$
;main.c:578: stageclearflg = 1;
	ld	hl, #_stageclearflg
	ld	(hl), #0x01
00116$:
;main.c:580: }
	add	sp, #2
	ret
;main.c:583: void build_road() {
;	---------------------------------
; Function build_road
; ---------------------------------
_build_road::
;main.c:584: set_bkg_tiles(camtileidx, 10, 3, 7, goodroadmap);
	ld	hl, #_goodroadmap
	push	hl
	ld	de, #0x0703
	push	de
	ld	a, #0x0a
	push	af
	inc	sp
	ld	a, (#_camtileidx)
	push	af
	inc	sp
	call	_set_bkg_tiles
	add	sp, #6
;main.c:585: nextcamtileidx = get_tile_idx(camtileidx + 3);
	ld	a, (#_camtileidx)
	add	a, #0x03
	ld	c, a
;main.c:303: return newidxnum > 31 ? newidxnum - 32 : newidxnum;
	ld	a, #0x1f
	sub	a, c
	jr	NC, 00104$
	ld	a, c
	add	a, #0xe0
	jr	00105$
00104$:
	ld	a, c
00105$:
	ld	(#_nextcamtileidx),a
;main.c:585: nextcamtileidx = get_tile_idx(camtileidx + 3);
;main.c:586: }
	ret
;main.c:589: void build_hole() {
;	---------------------------------
; Function build_hole
; ---------------------------------
_build_hole::
;main.c:590: if(roadbuildidx == 0) {
	ld	a, (#_roadbuildidx)
	or	a, a
	jr	NZ, 00105$
;main.c:592: holestartx = 238;
	ld	hl, #_holestartx
	ld	(hl), #0xee
;main.c:593: set_bkg_tiles(camtileidx, 10, 4, 7, holestartmap);
	ld	hl, #_holestartmap
	push	hl
	ld	de, #0x0704
	push	de
	ld	a, #0x0a
	push	af
	inc	sp
	ld	a, (#_camtileidx)
	push	af
	inc	sp
	call	_set_bkg_tiles
	add	sp, #6
;main.c:594: nextcamtileidx = get_tile_idx(camtileidx + 4);
	ld	a, (#_camtileidx)
	add	a, #0x04
	ld	c, a
;main.c:303: return newidxnum > 31 ? newidxnum - 32 : newidxnum;
	ld	a, #0x1f
	sub	a, c
	jr	NC, 00112$
	ld	a, c
	add	a, #0xe0
	jr	00113$
00112$:
	ld	a, c
00113$:
	ld	(#_nextcamtileidx),a
;main.c:594: nextcamtileidx = get_tile_idx(camtileidx + 4);
	ret
00105$:
;main.c:595: } else if(roadbuildidx == stage1road[stageidx]) {
	ld	bc, #_stage1road+0
	ld	a, c
	ld	hl, #_stageidx
	add	a, (hl)
	ld	c, a
	jr	NC, 00143$
	inc	b
00143$:
	ld	a, (bc)
	ld	c, a
	ld	a, (#_roadbuildidx)
	sub	a, c
	jr	NZ, 00102$
;main.c:597: holeendx = 174;
	ld	hl, #_holeendx
	ld	(hl), #0xae
;main.c:598: holestartx = 255;   // Resetting hole start value
	ld	hl, #_holestartx
	ld	(hl), #0xff
;main.c:599: set_bkg_tiles(camtileidx, 10, 3, 7, holeendmap);
	ld	hl, #_holeendmap
	push	hl
	ld	de, #0x0703
	push	de
	ld	a, #0x0a
	push	af
	inc	sp
	ld	a, (#_camtileidx)
	push	af
	inc	sp
	call	_set_bkg_tiles
	add	sp, #6
;main.c:600: nextcamtileidx = get_tile_idx(camtileidx + 3);
	ld	a, (#_camtileidx)
	add	a, #0x03
	ld	c, a
;main.c:303: return newidxnum > 31 ? newidxnum - 32 : newidxnum;
	ld	a, #0x1f
	sub	a, c
	jr	NC, 00114$
	ld	a, c
	add	a, #0xe0
	jr	00115$
00114$:
	ld	a, c
00115$:
	ld	(#_nextcamtileidx),a
;main.c:600: nextcamtileidx = get_tile_idx(camtileidx + 3);
	ret
00102$:
;main.c:602: set_bkg_tiles(camtileidx, 10, 3, 7, holemap);
	ld	hl, #_holemap
	push	hl
	ld	de, #0x0703
	push	de
	ld	a, #0x0a
	push	af
	inc	sp
	ld	a, (#_camtileidx)
	push	af
	inc	sp
	call	_set_bkg_tiles
	add	sp, #6
;main.c:603: nextcamtileidx = get_tile_idx(camtileidx + 3);
	ld	a, (#_camtileidx)
	add	a, #0x03
	ld	c, a
;main.c:303: return newidxnum > 31 ? newidxnum - 32 : newidxnum;
	ld	a, #0x1f
	sub	a, c
	jr	NC, 00116$
	ld	a, c
	add	a, #0xe0
	jr	00117$
00116$:
	ld	a, c
00117$:
	ld	(#_nextcamtileidx),a
;main.c:603: nextcamtileidx = get_tile_idx(camtileidx + 3);
;main.c:605: }
	ret
;main.c:608: void manage_hole_props() {
;	---------------------------------
; Function manage_hole_props
; ---------------------------------
_manage_hole_props::
;main.c:609: if(holestartx != 255 && holestartx > screenminx) { // Road hole has appeared
	ld	hl, #_screenminx
	ld	c, (hl)
;main.c:610: holestartx -= roadscrspeed;
	ld	hl, #_roadscrspeed
	ld	b, (hl)
;main.c:609: if(holestartx != 255 && holestartx > screenminx) { // Road hole has appeared
	ld	a, (#_holestartx)
	inc	a
	jr	Z, 00102$
	ld	a, c
	ld	hl, #_holestartx
	sub	a, (hl)
	jr	NC, 00102$
;main.c:610: holestartx -= roadscrspeed;
	ld	a, (hl)
	sub	a, b
	ld	(hl), a
00102$:
;main.c:612: if (holeendx != 0) {  // Road hole end reached
	ld	hl, #_holeendx
	ld	a, (hl)
	or	a, a
	jr	Z, 00107$
;main.c:613: holeendx -= roadscrspeed;
	ld	a, (hl)
	sub	a, b
	ld	(hl), a
	ret
00107$:
;main.c:614: } else if(holeendx < screenminx) {
	ld	hl, #_holeendx
	ld	a, (hl)
	sub	a, c
	ret	NC
;main.c:615: holeendx = 0;   // Resetting hole end value
	ld	(hl), #0x00
;main.c:617: }
	ret
;main.c:620: void manage_projectiles() {
;	---------------------------------
; Function manage_projectiles
; ---------------------------------
_manage_projectiles::
;main.c:621: for(pjctptr = projectiles; pjctptr <= projectiles + pjctllimit; pjctptr++) { // Projectiles handling
	ld	hl, #_pjctptr
	ld	a, #<(_projectiles)
	ld	(hl+), a
	ld	(hl), #>(_projectiles)
00116$:
	ld	a, (#_pjctllimit)
	ld	h, #0x00
	ld	l, a
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	de, #_projectiles
	add	hl, de
	ld	c, l
	ld	b, h
	ld	hl, #_pjctptr
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	ret	C
;main.c:622: if(pjctptr->oam != NULL) {
	ld	hl, #_pjctptr + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0006
	add	hl, bc
	ld	a, (hl+)
	or	a,(hl)
	jp	Z, 00117$
;main.c:623: move_projectile(pjctptr);
	ld	hl, #_pjctptr
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_move_projectile
	add	sp, #2
;main.c:624: for(machptr = machines; machptr <= machines + enlimit; machptr++) {
	ld	hl, #_machptr
	ld	(hl), #<(_machines)
	inc	hl
	ld	(hl), #>(_machines)
00114$:
	ld	hl, #_enlimit
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
	ld	de, #_machines
	add	hl, de
	ld	c, l
	ld	b, h
	ld	hl, #_machptr
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	jr	C, 00117$
;main.c:625: if(is_alive(machptr)) {
	ld	hl, #_machptr
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_is_alive
	add	sp, #2
	ld	a, e
	or	a, a
	jr	Z, 00108$
;main.c:626: if(pl == machptr && (iframeflg || (!pl->groundflg && pjctptr->oam->y > 95))) {
	ld	a, (#_pl)
	ld	hl, #_machptr
	sub	a, (hl)
	jr	NZ, 00102$
	ld	a, (#_pl + 1)
	ld	hl, #_machptr + 1
	sub	a, (hl)
	jr	NZ, 00102$
	ld	a, (#_iframeflg)
	or	a, a
	jr	NZ, 00108$
	ld	hl, #_pl + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, (bc)
	or	a, a
	jr	NZ, 00102$
	ld	hl, #_pjctptr + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0006
	add	hl, bc
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	c, (hl)
	ld	a, #0x5f
	sub	a, c
	jr	C, 00108$
;main.c:627: continue;   // Avoid hit during iframes or when player jumps and a bullet is above him on the road
00102$:
;main.c:629: check_projectile_collsn(machptr, pjctptr); // Check collision for all machines on screen
	ld	hl, #_pjctptr
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ld	hl, #_machptr
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_check_projectile_collsn
	add	sp, #4
00108$:
;main.c:624: for(machptr = machines; machptr <= machines + enlimit; machptr++) {
	ld	hl, #_machptr
	ld	a, (hl)
	add	a, #0x11
	ld	(hl+), a
	ld	a, (hl)
	adc	a, #0x00
	ld	(hl), a
	jp	00114$
00117$:
;main.c:621: for(pjctptr = projectiles; pjctptr <= projectiles + pjctllimit; pjctptr++) { // Projectiles handling
	ld	hl, #_pjctptr
	ld	a, (hl)
	add	a, #0x08
	ld	(hl+), a
	ld	a, (hl)
	adc	a, #0x00
	ld	(hl), a
;main.c:634: }
	jp	00116$
;main.c:636: void manage_machines() {
;	---------------------------------
; Function manage_machines
; ---------------------------------
_manage_machines::
;main.c:637: for(machptr = machines; machptr <= machines + enlimit; machptr++) {    // Player and enemies handling
	ld	hl, #_machptr
	ld	(hl), #<(_machines)
	inc	hl
	ld	(hl), #>(_machines)
00112$:
	ld	hl, #_enlimit
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
	ld	de, #_machines
	add	hl, de
	ld	c, l
	ld	b, h
	ld	hl, #_machptr
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	ret	C
;main.c:638: if(machptr != pl && machptr->y != 0) {
	ld	a, (#_machptr)
	ld	hl, #_pl
	sub	a, (hl)
	jr	NZ, 00156$
	ld	a, (#_machptr + 1)
	ld	hl, #_pl + 1
	sub	a, (hl)
	jr	Z, 00106$
00156$:
	ld	hl, #_machptr + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	ld	a, (de)
	or	a, a
	jr	Z, 00106$
;main.c:639: if(!iframeflg && pl->explcount == 0 && pl->groundflg == machptr->groundflg) {    // Player hasn't exploded
	ld	a, (#_iframeflg)
	or	a, a
	jr	NZ, 00102$
	ld	hl, #_pl + 1
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0007
	add	hl, de
	ld	a, (hl)
	or	a, a
	jr	NZ, 00102$
	ld	a, (de)
	push	af
	ld	a, (bc)
	ld	c, a
	pop	af
	sub	a, c
	jr	NZ, 00102$
;main.c:640: check_player_machine_collsn(machptr);
	ld	hl, #_machptr
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_check_player_machine_collsn
	add	sp, #2
00102$:
;main.c:642: exec_enemy_pattern(machptr);
	ld	hl, #_machptr
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_exec_enemy_pattern
	add	sp, #2
00106$:
;main.c:644: if(machptr->explcount != 0) {
	ld	hl, #_machptr + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0007
	add	hl, bc
	ld	a, (hl)
	or	a, a
	jr	Z, 00113$
;main.c:645: explode_machine(machptr);
	ld	hl, #_machptr
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_explode_machine
	add	sp, #2
00113$:
;main.c:637: for(machptr = machines; machptr <= machines + enlimit; machptr++) {    // Player and enemies handling
	ld	hl, #_machptr
	ld	a, (hl)
	add	a, #0x11
	ld	(hl+), a
	ld	a, (hl)
	adc	a, #0x00
	ld	(hl), a
;main.c:648: }
	jp	00112$
;main.c:651: void manage_sound_chnls() {
;	---------------------------------
; Function manage_sound_chnls
; ---------------------------------
_manage_sound_chnls::
;main.c:652: for(i = 0; i < 4; i++) {
	ld	hl, #_i
	ld	(hl), #0x00
00104$:
;main.c:653: if(chmutedcyccnt[i] != 255) {
	ld	a, #<(_chmutedcyccnt)
	ld	hl, #_i
	add	a, (hl)
	ld	c, a
	ld	a, #>(_chmutedcyccnt)
	adc	a, #0x00
	ld	b, a
	ld	a, (bc)
	inc	a
	jr	Z, 00105$
;main.c:654: upd_mute_chnl_cycles(i);
	ld	a, (hl)
	push	af
	inc	sp
	call	_upd_mute_chnl_cycles
	inc	sp
00105$:
;main.c:652: for(i = 0; i < 4; i++) {
	ld	hl, #_i
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x04
	jr	C, 00104$
;main.c:657: }
	ret
;main.c:660: void manage_player() {
;	---------------------------------
; Function manage_player
; ---------------------------------
_manage_player::
	add	sp, #-2
;main.c:661: if(iframeflg) {    // Invincibility period
	ld	a, (#_iframeflg)
	or	a, a
	jr	Z, 00102$
;main.c:662: check_iframes();
	call	_check_iframes
00102$:
;main.c:665: if(lockmvmnt != 2) {
	ld	a, (#_lockmvmnt)
	sub	a, #0x02
	jr	Z, 00107$
;main.c:666: if(pl->x + pl->width > holestartx && !fallinholeflg) { // Hole in the road and player is inside
	ld	hl, #_pl + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	l, c
	ld	h, b
	inc	hl
	ld	e, (hl)
	ld	d, #0x00
	ld	hl, #0x0005
	add	hl, bc
	ld	a, (hl)
	ld	b, #0x00
	add	a, e
	ld	c, a
	ld	a, b
	adc	a, d
	ld	b, a
	ld	a, (#_holestartx)
	ldhl	sp,	#0
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl-), a
	ld	a, (hl)
	sub	a, c
	inc	hl
	ld	a, (hl)
	sbc	a, b
	ld	d, (hl)
	ld	a, b
	bit	7,a
	jr	Z, 00300$
	bit	7, d
	jr	NZ, 00301$
	cp	a, a
	jr	00301$
00300$:
	bit	7, d
	jr	Z, 00301$
	scf
00301$:
	jr	NC, 00108$
	ld	hl, #_fallinholeflg
	ld	a, (hl)
	or	a, a
	jr	NZ, 00108$
;main.c:667: fallinholeflg = 1;
	ld	(hl), #0x01
;main.c:668: lockmvmnt = 3;
	ld	hl, #_lockmvmnt
	ld	(hl), #0x03
;main.c:669: se_fall_in_hole();
	call	_se_fall_in_hole
	jr	00108$
00107$:
;main.c:672: anim_jump();
	call	_anim_jump
00108$:
;main.c:675: if(fallinholeflg) {
	ld	a, (#_fallinholeflg)
	or	a, a
	jr	Z, 00113$
;main.c:676: move_machine(pl, -1, 2); // Animate fall
	ld	de, #0x02ff
	push	de
	ld	hl, #_pl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_move_machine
	add	sp, #4
;main.c:666: if(pl->x + pl->width > holestartx && !fallinholeflg) { // Hole in the road and player is inside
	ld	hl, #_pl + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
;main.c:677: if(pl->y > 144 && pl->explcount == 0) {
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	ld	e, (hl)
	ld	a, #0x90
	sub	a, e
	jr	NC, 00113$
	ld	hl, #0x0007
	add	hl, bc
	ld	a, (hl)
	or	a, a
	jr	NZ, 00113$
;main.c:678: take_damage(pl, pl->shield);
	ld	hl, #0x000b
	add	hl, bc
	ld	a, (hl)
	push	af
	inc	sp
	ld	hl, #_pl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_take_damage
	add	sp, #3
00113$:
;main.c:682: if(!is_alive(pl) && pllives != 0 && pl->explcount == 0) {
	ld	hl, #_pl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_is_alive
	add	sp, #2
	ld	a, e
	or	a, a
	jr	NZ, 00115$
	ld	a, (#_pllives)
	or	a, a
	jr	Z, 00115$
	ld	hl, #_pl + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0007
	add	hl, bc
	ld	a, (hl)
	or	a, a
	jr	NZ, 00115$
;main.c:683: respawn_player();
	call	_respawn_player
00115$:
;main.c:686: if(abtncnt != 0) {
	ld	a, (#_abtncnt)
	or	a, a
	jr	Z, 00119$
;main.c:687: abtncnt = abtncnt == abtncooldown ? 0 : abtncnt + 1;
	ld	hl, #_abtncooldown
	ld	c, (hl)
	ld	a, (#_abtncnt)
	sub	a, c
	jr	NZ, 00152$
	ld	bc, #0x0000
	jr	00153$
00152$:
	ld	a, (#_abtncnt)
	inc	a
	ld	c, a
	rla
00153$:
	ld	hl, #_abtncnt
	ld	(hl), c
00119$:
;main.c:690: if(lockmvmnt != 1 && lockmvmnt != 3) { // Check horizontal lock
	ld	a, (#_lockmvmnt)
	dec	a
	jr	Z, 00125$
	ld	a, (#_lockmvmnt)
	sub	a, #0x03
	jr	Z, 00125$
;main.c:691: if(joypad() & J_LEFT) {
	call	_joypad
	bit	1, e
	jr	Z, 00121$
;main.c:692: move_player(-plspeed, 0);
	xor	a, a
	ld	hl, #_plspeed
	sub	a, (hl)
	ld	b, a
	xor	a, a
	push	af
	inc	sp
	push	bc
	inc	sp
	call	_move_player
	add	sp, #2
00121$:
;main.c:694: if(joypad() & J_RIGHT) {
	call	_joypad
	ld	a, e
	rrca
	jr	NC, 00125$
;main.c:695: move_player(plspeed, 0);
	xor	a, a
	push	af
	inc	sp
	ld	a, (#_plspeed)
	push	af
	inc	sp
	call	_move_player
	add	sp, #2
00125$:
;main.c:698: if(lockmvmnt != 2 && lockmvmnt != 3) { // Check vertical lock
	ld	a,(#_lockmvmnt)
	cp	a,#0x02
	jr	Z, 00132$
	sub	a, #0x03
	jr	Z, 00132$
;main.c:699: if(joypad() & J_UP) {
	call	_joypad
	bit	2, e
	jr	Z, 00128$
;main.c:700: move_player(0, -plspeed);
	xor	a, a
	ld	hl, #_plspeed
	sub	a, (hl)
	ld	b, a
	push	bc
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_move_player
	add	sp, #2
00128$:
;main.c:702: if(joypad() & J_DOWN) {
	call	_joypad
	bit	3, e
	jr	Z, 00132$
;main.c:703: move_player(0, plspeed);
	ld	a, (#_plspeed)
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_move_player
	add	sp, #2
00132$:
;main.c:706: if(joypad() & J_B) {
	call	_joypad
	bit	5, e
	jr	Z, 00141$
;main.c:707: if(abtncnt == 0) { // Check cooldown period before firing
	ld	a, (#_abtncnt)
	or	a, a
	jr	NZ, 00141$
;main.c:708: switch(plgun) {
	ld	a, (#_plgun)
	or	a, a
	jr	Z, 00134$
	ld	a, (#_plgun)
	dec	a
	jr	Z, 00135$
	ld	a, (#_plgun)
	sub	a, #0x02
	jr	Z, 00136$
	jr	00137$
;main.c:709: case 0:
00134$:
;main.c:710: fire_bullet(pl, 2, 0);
	xor	a, a
	ld	d,a
	ld	e,#0x02
	push	de
	ld	hl, #_pl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_fire_bullet
	add	sp, #4
;main.c:711: break;
	jr	00137$
;main.c:712: case 1:
00135$:
;main.c:713: fire_bigbullet(pl, 2, 0);
	xor	a, a
	ld	d,a
	ld	e,#0x02
	push	de
	ld	hl, #_pl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_fire_bigbullet
	add	sp, #4
;main.c:714: break;
	jr	00137$
;main.c:715: case 2:
00136$:
;main.c:716: fire_laser(pl, 2, 0);
	xor	a, a
	ld	d,a
	ld	e,#0x02
	push	de
	ld	hl, #_pl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_fire_laser
	add	sp, #4
;main.c:718: }
00137$:
;main.c:719: abtncnt = 1;
	ld	hl, #_abtncnt
	ld	(hl), #0x01
00141$:
;main.c:722: if(joypad() & J_A) { 
	call	_joypad
	bit	4, e
	jr	Z, 00146$
;main.c:723: if(lockmvmnt == 0 && !isapressed) {
	ld	a, (#_lockmvmnt)
	or	a, a
	jr	NZ, 00143$
	ld	a, (#_isapressed)
	or	a, a
	jr	NZ, 00143$
;main.c:724: lockmvmnt = 2;  // Lock vert movement during jump
	ld	hl, #_lockmvmnt
	ld	(hl), #0x02
;main.c:725: pl->groundflg = 0;
	ld	hl, #_pl + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	xor	a, a
	ld	(bc), a
;main.c:726: jumpstarty = pl->y; // Keeping player y position for landing
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	inc	bc
	ld	a, (bc)
	ld	(#_jumpstarty),a
;main.c:727: set_machine_sprite_tiles(pl, 13);
	ld	a, #0x0d
	push	af
	inc	sp
	ld	hl, #_pl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_set_machine_sprite_tiles
	add	sp, #3
;main.c:728: se_jump();
	call	_se_jump
00143$:
;main.c:730: isapressed = 1;
	ld	hl, #_isapressed
	ld	(hl), #0x01
	jr	00147$
00146$:
;main.c:732: isapressed = 0;
	ld	hl, #_isapressed
	ld	(hl), #0x00
00147$:
;main.c:734: if(joypad() & J_START) {
	call	_joypad
	ld	a, e
	rlca
	jr	NC, 00150$
;main.c:735: pause_game();
	call	_pause_game
00150$:
;main.c:737: }
	add	sp, #2
	ret
;main.c:740: inline UINT8 get_horiz_dist(UINT8 fstobjx, UINT8 sndobjx) { // Returns the distance between 2 objects on x axis
;	---------------------------------
; Function get_horiz_dist
; ---------------------------------
_get_horiz_dist::
;main.c:741: return fstobjx > sndobjx ? fstobjx - sndobjx : sndobjx - fstobjx;
	ldhl	sp,	#3
	ld	a, (hl-)
	sub	a, (hl)
	jr	NC, 00103$
	ld	a, (hl+)
	sub	a, (hl)
	jr	00104$
00103$:
	ldhl	sp,	#3
	ld	a, (hl-)
	sub	a, (hl)
00104$:
	ld	e, a
;main.c:742: }
	ret
;main.c:745: void set_projctl_comm_prop(Machine * mch, INT8 speedx, INT8 speedy) {
;	---------------------------------
; Function set_projctl_comm_prop
; ---------------------------------
_set_projctl_comm_prop::
	add	sp, #-12
;main.c:746: crntpjct->speedx = speedx;
	ld	hl, #_crntpjct + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#16
	ld	a, (hl)
	ld	(bc), a
;main.c:747: crntpjct->speedy = speedy;
	ld	hl, #_crntpjct + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	ldhl	sp,	#17
	ld	a, (hl)
	ld	(bc), a
;main.c:748: crntpjct->oam = (shadow_OAM + oamidx);
	ld	hl, #_crntpjct
	ld	a, (hl+)
	ld	e, a
	ld	b, (hl)
	ld	a, e
	add	a, #0x06
	ld	c, a
	jr	NC, 00146$
	inc	b
00146$:
	ld	hl, #_oamidx
	ld	l, (hl)
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, e
	ld	(bc), a
	inc	bc
	ld	a, d
	ld	(bc), a
;main.c:749: crntpjct->oam->x = mch->x + mch->gunoffx;
	ld	hl, #_crntpjct + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0006
	add	hl, bc
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	e, (hl)
	ldhl	sp,	#0
	ld	(hl+), a
	ld	(hl), e
;c
	pop	de
	push	de
	ld	l, e
	ld	h, d
	inc	hl
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#11
	ld	(hl), a
;c
	pop	de
	push	de
	ld	hl, #0x0009
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ldhl	sp,	#11
	ld	e, (hl)
	add	a, e
	ld	(bc), a
;main.c:750: crntpjct->oam->y = mch->y + mch->gunoffy;
	ld	hl, #_crntpjct + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0006
	add	hl, bc
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	pop	hl
	push	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#11
	ld	(hl), a
;c
	pop	de
	push	de
	ld	hl, #0x000a
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ldhl	sp,	#11
	ld	e, (hl)
	add	a, e
	ld	(bc), a
;main.c:751: if((mch->type == 3 || mch->type == 1) && (crntpjct->oam->x < pl->x || crntpjct->oam->x > (pl->x + pl->width))) {
;c
	pop	de
	push	de
	ld	hl, #0x000c
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ldhl	sp,	#7
	ld	(hl), a
;main.c:746: crntpjct->speedx = speedx;
	ld	hl, #_crntpjct
	ld	a, (hl+)
	ld	e, (hl)
	ldhl	sp,	#8
	ld	(hl+), a
;main.c:753: crntpjct->aimedflg = 1;
;c
	ld	a, e
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0005
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#12
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#11
	ld	(hl), a
;main.c:751: if((mch->type == 3 || mch->type == 1) && (crntpjct->oam->x < pl->x || crntpjct->oam->x > (pl->x + pl->width))) {
	ldhl	sp,	#7
	ld	a, (hl)
	sub	a, #0x03
	jr	Z, 00106$
	ldhl	sp,	#7
	ld	a, (hl)
	dec	a
	jp	NZ,00102$
00106$:
;c
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0006
	add	hl, de
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	ld	a, (bc)
	ld	c, a
	ld	hl, #_pl + 1
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	l, e
	ld	h, d
	inc	hl
	ld	b, (hl)
	ld	a, c
	sub	a, b
	jr	C, 00101$
	ld	l, b
	ld	h, #0x00
	inc	de
	inc	de
	inc	de
	inc	de
	inc	de
	ld	a, (de)
	ld	d, #0x00
	ld	e, a
	add	hl, de
	ld	b, #0x00
	ld	e, b
	ld	d, h
	ld	a, l
	sub	a, c
	ld	a, h
	sbc	a, b
	bit	7, e
	jr	Z, 00150$
	bit	7, d
	jr	NZ, 00151$
	cp	a, a
	jr	00151$
00150$:
	bit	7, d
	jr	Z, 00151$
	scf
00151$:
	jp	NC, 00102$
00101$:
;main.c:753: crntpjct->aimedflg = 1;
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;main.c:751: if((mch->type == 3 || mch->type == 1) && (crntpjct->oam->x < pl->x || crntpjct->oam->x > (pl->x + pl->width))) {
	ld	hl, #_pl
	ld	a, (hl+)
	ld	e, (hl)
	ldhl	sp,	#8
	ld	(hl+), a
;c
	ld	a, e
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	l, e
	ld	h, d
	inc	hl
	push	hl
	ld	a, l
	ldhl	sp,	#12
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#11
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#4
	ld	(hl), a
	xor	a, a
	inc	hl
;main.c:754: precfctr = pl->x + 46 < mch->x || mch->x + mch->width + 30 < pl->x ? 100 : 10;
;c
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x002e
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#8
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#7
	ld	(hl), a
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	ld	b, #0x00
	ldhl	sp,	#6
	ld	a, (hl)
	sub	a, c
	inc	hl
	ld	a, (hl)
	sbc	a, b
	ld	d, (hl)
	ld	a, b
	bit	7,a
	jr	Z, 00152$
	bit	7, d
	jr	NZ, 00153$
	cp	a, a
	jr	00153$
00152$:
	bit	7, d
	jr	Z, 00153$
	scf
00153$:
	jr	C, 00114$
;c
	pop	de
	push	de
	ld	hl, #0x0005
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ld	h, #0x00
	ld	l, a
	add	hl, bc
	ld	bc, #0x001e
	add	hl,bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#4
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	ld	a, b
	ld	d, a
	bit	7, (hl)
	jr	Z, 00154$
	bit	7, d
	jr	NZ, 00155$
	cp	a, a
	jr	00155$
00154$:
	bit	7, d
	jr	Z, 00155$
	scf
00155$:
	jr	NC, 00111$
00114$:
	ld	bc, #0x0064
	jr	00112$
00111$:
	ld	bc, #0x000a
00112$:
	ld	hl, #_precfctr
	ld	(hl), c
;main.c:746: crntpjct->speedx = speedx;
	ld	hl, #_crntpjct + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
;main.c:751: if((mch->type == 3 || mch->type == 1) && (crntpjct->oam->x < pl->x || crntpjct->oam->x > (pl->x + pl->width))) {
	ld	hl, #0x0006
	add	hl, bc
	inc	sp
	inc	sp
	ld	e, l
	ld	d, h
	push	de
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
;main.c:755: slope = ((crntpjct->oam->y - pl->y) * precfctr) / (crntpjct->oam->x - (pl->x + 8));
	ld	a, (bc)
	ld	e, a
	ld	d, #0x00
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	ld	l, (hl)
	ld	h, #0x00
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ld	d, a
	ld	a, (#_precfctr)
	ldhl	sp,	#2
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl), a
	push	bc
	dec	hl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	push	de
	call	__mulint
	add	sp, #4
	push	hl
	ldhl	sp,	#8
	ld	(hl), e
	ldhl	sp,	#9
	ld	(hl), d
	pop	hl
	pop	bc
	inc	bc
	ld	a, (bc)
	ldhl	sp,	#6
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl), a
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	d, #0x00
;c
	ld	e, a
	ld	hl, #0x0008
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#10
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#9
	ld	(hl-), a
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#11
	ld	(hl-), a
	ld	(hl), e
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	__divsint
	add	sp, #4
	push	hl
	ldhl	sp,	#12
	ld	(hl), e
	ldhl	sp,	#13
	ld	(hl), d
	pop	hl
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	e, (hl)
	ld	hl, #_slope
	ld	(hl+), a
	ld	(hl), e
;main.c:751: if((mch->type == 3 || mch->type == 1) && (crntpjct->oam->x < pl->x || crntpjct->oam->x > (pl->x + pl->width))) {
	pop	de
	push	de
	ld	a, (de)
	ldhl	sp,	#10
	ld	(hl+), a
	inc	de
	ld	a, (de)
;main.c:756: gradient = crntpjct->oam->y - ((slope * crntpjct->oam->x) / precfctr );
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	dec	hl
	dec	hl
	ld	(hl), a
	ld	a, (hl)
	ldhl	sp,	#6
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl), a
;c
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	l, e
	ld	h, d
	inc	hl
	push	hl
	ld	a, l
	ldhl	sp,	#10
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#9
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	inc	hl
	inc	hl
	ld	(hl), a
	ld	a, (hl-)
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ld	hl, #_slope
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	__mulint
	add	sp, #4
	push	hl
	ldhl	sp,	#12
	ld	(hl), e
	ldhl	sp,	#13
	ld	(hl), d
	pop	hl
	pop	bc
	pop	hl
	push	hl
	push	bc
	push	hl
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	__divsint
	add	sp, #4
	push	hl
	ldhl	sp,	#12
	ld	(hl), e
	ldhl	sp,	#13
	ld	(hl), d
	pop	hl
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ld	hl, #_gradient + 1
	ld	(hl-), a
	ld	(hl), e
	jr	00103$
00102$:
;main.c:758: crntpjct->aimedflg = 0;
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
00103$:
;main.c:760: incr_oam_sprite_tile_idx(1);
	ld	a, #0x01
	push	af
	inc	sp
	call	_incr_oam_sprite_tile_idx
	inc	sp
;main.c:288: prjcnt += prjcnt == pjctllimit + 1 ? 0 : 1;
	ld	hl, #_pjctllimit
	ld	c, (hl)
	ld	b, #0x00
	ld	e, c
	ld	d, b
	inc	de
	ld	a, (#_prjcnt)
	ldhl	sp,	#10
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl-), a
	ld	a, (hl)
	sub	a, e
	jr	NZ, 00116$
	inc	hl
	ld	a, (hl)
	sub	a, d
	jr	NZ, 00116$
	ld	de, #0x0000
	jr	00117$
00116$:
	ld	de, #0x0001
00117$:
	ld	hl, #_prjcnt
	ld	a, (hl)
	add	a, e
	ld	(hl), a
;main.c:293: crntpjct = crntpjct == projectiles + pjctllimit ? projectiles : crntpjct + 1;
	ld	de, #_projectiles+0
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, de
	ld	c, l
	ld	b, h
	ld	hl, #_crntpjct
	ld	a, (hl)
	sub	a, c
	jr	NZ, 00118$
	inc	hl
	ld	a, (hl)
	sub	a, b
	jr	Z, 00119$
	jr	00118$
00118$:
	ld	hl, #_crntpjct
	ld	a, (hl)
	add	a, #0x08
	ld	e, a
	inc	hl
	ld	a, (hl)
	adc	a, #0x00
	ld	d, a
00119$:
	ld	hl, #_crntpjct
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;main.c:762: itr_projectile_ptr();
;main.c:763: }
	add	sp, #12
	ret
;main.c:766: void fire_bullet(Machine * mch, INT8 speedx, INT8 speedy) {
;	---------------------------------
; Function fire_bullet
; ---------------------------------
_fire_bullet::
;main.c:298: return prjcnt != pjctllimit + 1 && oamidx != 180;
	ld	hl, #_pjctllimit
	ld	c, (hl)
	ld	b, #0x00
	inc	bc
	ld	hl, #_prjcnt
	ld	e, (hl)
	ld	d, #0x00
	ld	a, e
	sub	a, c
	jr	NZ, 00120$
	ld	a, d
	sub	a, b
	jr	Z, 00107$
00120$:
	ld	a, (#_oamidx)
	sub	a, #0xb4
	jr	NZ, 00108$
00107$:
	xor	a, a
	jr	00109$
00108$:
	ld	a, #0x01
00109$:
;main.c:767: if(found_free_projectile_space()) {  // Set props only if initialization succeeds
	or	a, a
	ret	Z
;main.c:768: crntpjct->width = 3;
	ld	hl, #_crntpjct + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	inc	bc
	inc	bc
	ld	a, b
	ld	l, c
	ld	h, a
	ld	(hl), #0x03
;main.c:769: crntpjct->height = 3;
	ld	hl, #_crntpjct + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	inc	bc
	ld	a, b
	ld	l, c
	ld	h, a
	ld	(hl), #0x03
;main.c:770: crntpjct->damage = 1;
	ld	hl, #_crntpjct + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0004
	add	hl, bc
	ld	(hl), #0x01
;main.c:771: set_sprite_tile(oamidx, 0x11);
	ld	hl, #_oamidx
	ld	e, (hl)
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1145: shadow_OAM[nb].tile=tile;
	ld	bc, #_shadow_OAM+0
	ld	d, #0x00
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	add	hl, bc
	inc	hl
	inc	hl
	ld	(hl), #0x11
;main.c:772: set_projctl_comm_prop(mch, speedx, speedy);
	ldhl	sp,	#5
	ld	a, (hl)
	push	af
	inc	sp
	dec	hl
	ld	a, (hl)
	push	af
	inc	sp
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_set_projctl_comm_prop
	add	sp, #4
;main.c:773: se_fire_bullet();
;main.c:775: }
	jp  _se_fire_bullet
;main.c:778: void fire_bigbullet(Machine * mch, INT8 speedx, INT8 speedy) {
;	---------------------------------
; Function fire_bigbullet
; ---------------------------------
_fire_bigbullet::
;main.c:298: return prjcnt != pjctllimit + 1 && oamidx != 180;
	ld	hl, #_pjctllimit
	ld	c, (hl)
	ld	b, #0x00
	inc	bc
	ld	hl, #_prjcnt
	ld	e, (hl)
	ld	d, #0x00
	ld	a, e
	sub	a, c
	jr	NZ, 00120$
	ld	a, d
	sub	a, b
	jr	Z, 00107$
00120$:
	ld	a, (#_oamidx)
	sub	a, #0xb4
	jr	NZ, 00108$
00107$:
	xor	a, a
	jr	00109$
00108$:
	ld	a, #0x01
00109$:
;main.c:779: if(found_free_projectile_space()) {  // Set props only if initialization succeeds
	or	a, a
	ret	Z
;main.c:780: crntpjct->width = 4;
	ld	hl, #_crntpjct + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	inc	bc
	inc	bc
	ld	a, b
	ld	l, c
	ld	h, a
	ld	(hl), #0x04
;main.c:781: crntpjct->height = 4;
	ld	hl, #_crntpjct + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	inc	bc
	ld	a, b
	ld	l, c
	ld	h, a
	ld	(hl), #0x04
;main.c:782: crntpjct->damage = 2;
	ld	hl, #_crntpjct + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0004
	add	hl, bc
	ld	(hl), #0x02
;main.c:783: set_sprite_tile(oamidx, 0x12);
	ld	hl, #_oamidx
	ld	e, (hl)
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1145: shadow_OAM[nb].tile=tile;
	ld	bc, #_shadow_OAM+0
	ld	d, #0x00
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	add	hl, bc
	inc	hl
	inc	hl
	ld	(hl), #0x12
;main.c:784: set_projctl_comm_prop(mch, speedx, speedy);
	ldhl	sp,	#5
	ld	a, (hl)
	push	af
	inc	sp
	dec	hl
	ld	a, (hl)
	push	af
	inc	sp
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_set_projctl_comm_prop
	add	sp, #4
;main.c:785: se_fire_bullet();
;main.c:787: }
	jp  _se_fire_bullet
;main.c:790: void fire_laser(Machine * mch, INT8 speedx, INT8 speedy) {
;	---------------------------------
; Function fire_laser
; ---------------------------------
_fire_laser::
;main.c:298: return prjcnt != pjctllimit + 1 && oamidx != 180;
	ld	hl, #_pjctllimit
	ld	c, (hl)
	ld	b, #0x00
	inc	bc
	ld	hl, #_prjcnt
	ld	e, (hl)
	ld	d, #0x00
	ld	a, e
	sub	a, c
	jr	NZ, 00120$
	ld	a, d
	sub	a, b
	jr	Z, 00107$
00120$:
	ld	a, (#_oamidx)
	sub	a, #0xb4
	jr	NZ, 00108$
00107$:
	xor	a, a
	jr	00109$
00108$:
	ld	a, #0x01
00109$:
;main.c:791: if(found_free_projectile_space()) {  // Set props only if initialization succeeds
	or	a, a
	ret	Z
;main.c:792: crntpjct->width = 8;
	ld	hl, #_crntpjct + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	inc	bc
	inc	bc
	ld	a, b
	ld	l, c
	ld	h, a
	ld	(hl), #0x08
;main.c:793: crntpjct->height = 3;
	ld	hl, #_crntpjct + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	inc	bc
	ld	a, b
	ld	l, c
	ld	h, a
	ld	(hl), #0x03
;main.c:794: crntpjct->damage = 3;
	ld	hl, #_crntpjct + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0004
	add	hl, bc
	ld	(hl), #0x03
;main.c:795: set_sprite_tile(oamidx, 0x13);
	ld	hl, #_oamidx
	ld	e, (hl)
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1145: shadow_OAM[nb].tile=tile;
	ld	bc, #_shadow_OAM+0
	ld	d, #0x00
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	add	hl, bc
	inc	hl
	inc	hl
	ld	(hl), #0x13
;main.c:796: set_projctl_comm_prop(mch, speedx, speedy);
	ldhl	sp,	#5
	ld	a, (hl)
	push	af
	inc	sp
	dec	hl
	ld	a, (hl)
	push	af
	inc	sp
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_set_projctl_comm_prop
	add	sp, #4
;main.c:797: se_fire_laser();
;main.c:799: }
	jp  _se_fire_laser
;main.c:802: void drop_bomb(Machine * mch) {
;	---------------------------------
; Function drop_bomb
; ---------------------------------
_drop_bomb::
;main.c:298: return prjcnt != pjctllimit + 1 && oamidx != 180;
	ld	hl, #_pjctllimit
	ld	c, (hl)
	ld	b, #0x00
	inc	bc
	ld	hl, #_prjcnt
	ld	e, (hl)
	ld	d, #0x00
	ld	a, e
	sub	a, c
	jr	NZ, 00120$
	ld	a, d
	sub	a, b
	jr	Z, 00107$
00120$:
	ld	a, (#_oamidx)
	sub	a, #0xb4
	jr	NZ, 00108$
00107$:
	xor	a, a
	jr	00109$
00108$:
	ld	a, #0x01
00109$:
;main.c:803: if(found_free_projectile_space()) {  // Set props only if initialization succeeds
	or	a, a
	ret	Z
;main.c:804: crntpjct->width = 8;
	ld	hl, #_crntpjct + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	inc	bc
	inc	bc
	ld	a, b
	ld	l, c
	ld	h, a
	ld	(hl), #0x08
;main.c:805: crntpjct->height = 8;
	ld	hl, #_crntpjct + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	inc	bc
	ld	a, b
	ld	l, c
	ld	h, a
	ld	(hl), #0x08
;main.c:806: crntpjct->damage = 4;
	ld	hl, #_crntpjct + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0004
	add	hl, bc
	ld	(hl), #0x04
;main.c:807: set_sprite_tile(oamidx, 0x14);
	ld	hl, #_oamidx
	ld	e, (hl)
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1145: shadow_OAM[nb].tile=tile;
	ld	bc, #_shadow_OAM+0
	ld	d, #0x00
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	add	hl, bc
	inc	hl
	inc	hl
	ld	(hl), #0x14
;main.c:808: set_projctl_comm_prop(mch, 0, 2);
	ld	a, #0x02
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_set_projctl_comm_prop
	add	sp, #4
;main.c:809: se_drop_bomb();
;main.c:811: }
	jp  _se_drop_bomb
;main.c:814: inline INT8 get_prjctl_x_aimed(Projectile * prjct) { // Returns projectile's y position based on player's position
;	---------------------------------
; Function get_prjctl_x_aimed
; ---------------------------------
_get_prjctl_x_aimed::
;main.c:815: return ((prjct->oam->y - gradient) * precfctr) / slope;
	pop	bc
	pop	de
	push	de
	push	bc
	ld	hl, #0x0006
	add	hl, de
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	c, (hl)
	ld	b, #0x00
	ld	a, c
	ld	hl, #_gradient
	sub	a, (hl)
	ld	c, a
	ld	a, b
	inc	hl
	sbc	a, (hl)
	ld	b, a
	ld	hl, #_precfctr
	ld	e, (hl)
	ld	d, #0x00
	push	de
	push	bc
	call	__mulint
	add	sp, #4
	ld	hl, #_slope
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	push	de
	call	__divsint
	add	sp, #4
;main.c:816: }
	ret
;main.c:819: inline INT8 get_prjctl_y_aimed(Projectile * prjct) { // Returns projectile's y position based on player's position
;	---------------------------------
; Function get_prjctl_y_aimed
; ---------------------------------
_get_prjctl_y_aimed::
;main.c:820: return slope * prjct->oam->x + gradient;
	pop	bc
	pop	de
	push	de
	push	bc
	ld	hl, #0x0006
	add	hl, de
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	ld	a, (bc)
	ld	hl, #_slope
	ld	b, (hl)
	push	af
	inc	sp
	push	bc
	inc	sp
	call	__mulschar
	add	sp, #2
	ld	a, (#_gradient)
	add	a, e
	ld	e, a
;main.c:821: }
	ret
;main.c:824: inline UBYTE is_obj_inside_screen(UINT8 x, UINT8 y, UINT8 width, UINT8 height) {
;	---------------------------------
; Function is_obj_inside_screen
; ---------------------------------
_is_obj_inside_screen::
;main.c:825: return (x < screenmaxx && screenminx < x + width) &&
	ld	hl, #_screenmaxx
	ld	c, (hl)
	ldhl	sp,	#2
	ld	a,(hl)
	cp	a,c
	jr	NC, 00103$
	ld	b, #0x00
	inc	hl
	inc	hl
	ld	e, (hl)
	ld	d, #0x00
	add	a, e
	ld	c, a
	ld	a, b
	adc	a, d
	ld	b, a
	ld	hl, #_screenminx
	ld	l, (hl)
	ld	h, #0x00
	ld	e, b
	ld	d, h
	ld	a, l
	sub	a, c
	ld	a, h
	sbc	a, b
	bit	7, e
	jr	Z, 00126$
	bit	7, d
	jr	NZ, 00127$
	cp	a, a
	jr	00127$
00126$:
	bit	7, d
	jr	Z, 00127$
	scf
00127$:
	jr	NC, 00103$
;main.c:826: (y < screenmaxy && screenminy < y + height);
	ld	hl, #_screenmaxy
	ld	c, (hl)
	ldhl	sp,	#3
	ld	a,(hl)
	cp	a,c
	jr	NC, 00103$
	ld	b, #0x00
	inc	hl
	inc	hl
	ld	e, (hl)
	ld	d, #0x00
	add	a, e
	ld	c, a
	ld	a, b
	adc	a, d
	ld	b, a
	ld	hl, #_screenminy
	ld	l, (hl)
	ld	h, #0x00
	ld	e, b
	ld	d, h
	ld	a, l
	sub	a, c
	ld	a, h
	sbc	a, b
	bit	7, e
	jr	Z, 00128$
	bit	7, d
	jr	NZ, 00129$
	cp	a, a
	jr	00129$
00128$:
	bit	7, d
	jr	Z, 00129$
	scf
00129$:
	jr	C, 00104$
00103$:
	ld	e, #0x00
	ret
00104$:
	ld	e, #0x01
;main.c:827: }
	ret
;main.c:830: inline UBYTE is_alive(Machine * mch) {
;	---------------------------------
; Function is_alive
; ---------------------------------
_is_alive::
;main.c:831: return mch->shield > 0;
	pop	bc
	pop	de
	push	de
	push	bc
	ld	hl, #0x000b
	add	hl, de
	ld	c, (hl)
	ld	e, c
	ld	d, #0x00
	xor	a, a
	sub	a, c
	bit	7, e
	jr	Z, 00103$
	bit	7, d
	jr	NZ, 00104$
	cp	a, a
	jr	00104$
00103$:
	bit	7, d
	jr	Z, 00104$
	scf
00104$:
	ld	a, #0x00
	rla
	ld	e, a
;main.c:832: }
	ret
;main.c:835: void destroy_projectile(Projectile * pr) {
;	---------------------------------
; Function destroy_projectile
; ---------------------------------
_destroy_projectile::
;main.c:836: pr->oam->x = 0;
	pop	bc
	pop	de
	push	de
	push	bc
	ld	hl, #0x0006
	add	hl, de
	ld	c,l
	ld	b,h
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	ld	(hl), #0x00
;main.c:837: pr->oam->y = 0;
	ld	l, c
	ld	h, b
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;main.c:838: pr->oam->tile = 0;
	ld	l, c
	ld	h, b
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	ld	(hl), #0x00
;main.c:839: pr->oam = NULL;
	xor	a, a
	ld	(bc), a
	inc	bc
	ld	(bc), a
;main.c:840: prjcnt--;
	ld	hl, #_prjcnt
	dec	(hl)
;main.c:841: }
	ret
;main.c:844: void init_explosion(Machine * mch) {
;	---------------------------------
; Function init_explosion
; ---------------------------------
_init_explosion::
	add	sp, #-7
;main.c:845: mch->explcount = 1;
	ldhl	sp,#9
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0007
	add	hl, bc
	ld	(hl), #0x01
;main.c:846: mch->hboffx = -(mch->x + mch->width);   // x + offx + width == 0
	ld	hl, #0x0003
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#6
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#5
	ld	(hl), a
	ld	e, c
	ld	d, b
	inc	de
	ld	a, (de)
	inc	hl
	ld	(hl), a
	ld	hl, #0x0005
	add	hl, bc
	inc	sp
	inc	sp
	ld	e, l
	ld	d, h
	push	de
	ld	a, (de)
	ldhl	sp,	#6
	add	a, (hl)
	ld	e, a
	xor	a, a
	sub	a, e
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (hl)
	ld	(de), a
;main.c:847: mch->hboffy = -(mch->y + mch->height);   // Avoiding damage dealing to player while exploding
	ld	hl, #0x0004
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl), a
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	ld	a, (de)
	ldhl	sp,	#6
	ld	(hl), a
	ld	hl, #0x0006
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#6
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#5
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	inc	hl
	add	a, (hl)
	ld	e, a
	xor	a, a
	sub	a, e
	ld	(hl), a
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#6
	ld	a, (hl)
	ld	(de), a
;main.c:848: if(mch->width < 9) {
	pop	de
	push	de
	ld	a, (de)
	sub	a, #0x09
	jr	NC, 00102$
;main.c:849: move_enemy(mch, -4, 0);
	xor	a, a
	ld	d,a
	ld	e,#0xfc
	push	de
	push	bc
	call	_move_enemy
	add	sp, #4
00102$:
;main.c:851: if(mch->height < 9) {
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	sub	a, #0x09
	jr	NC, 00104$
;main.c:852: move_enemy(mch, 0, -4);
	ld	a, #0xfc
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	ldhl	sp,	#11
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_move_enemy
	add	sp, #4
00104$:
;main.c:854: se_explode();
	call	_se_explode
;main.c:855: }
	add	sp, #7
	ret
;main.c:858: void move_projectile(Projectile * pr) {
;	---------------------------------
; Function move_projectile
; ---------------------------------
_move_projectile::
	add	sp, #-11
;main.c:859: if(pr->oam != NULL && is_obj_inside_screen(pr->oam->x, pr->oam->y, pr->width, pr->height)) {
	ldhl	sp,	#13
	ld	a, (hl+)
	ld	e, (hl)
	ldhl	sp,	#0
	ld	(hl+), a
	ld	(hl), e
;c
	pop	de
	push	de
	ld	hl, #0x0006
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	or	a, c
	jp	Z, 00102$
	pop	hl
	push	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	push	hl
	inc	hl
	inc	hl
	inc	hl
	ld	e, (hl)
	ld	a, (bc)
	ldhl	sp,	#5
	ld	(hl), a
	ld	a, (hl+)
	ld	(hl), a
	ld	l, c
	ld	h, b
	inc	hl
	ld	d, (hl)
;main.c:825: return (x < screenmaxx && screenminx < x + width) &&
	ld	a, (#_screenmaxx)
	ldhl	sp,	#10
	ld	(hl), a
	ld	a, d
	sub	a, (hl)
	jp	NC, 00109$
	dec	hl
	ld	(hl), d
	xor	a, a
	inc	hl
	ld	(hl), a
	ld	d, #0x00
;c
	dec	hl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#9
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#8
	ld	(hl), a
	ld	a, (#_screenminx)
	ldhl	sp,	#9
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl), a
	ldhl	sp,	#9
	ld	e, l
	ld	d, h
	ldhl	sp,	#7
	ld	a, (de)
	sub	a, (hl)
	inc	hl
	inc	de
	ld	a, (de)
	sbc	a, (hl)
	ld	a, (de)
	ld	d, a
	bit	7, (hl)
	jr	Z, 00149$
	bit	7, d
	jr	NZ, 00150$
	cp	a, a
	jr	00150$
00149$:
	bit	7, d
	jr	Z, 00150$
	scf
00150$:
	jr	NC, 00109$
;main.c:826: (y < screenmaxy && screenminy < y + height);
	ld	hl, #_screenmaxy
	ld	e, (hl)
	ldhl	sp,	#6
	ld	a,(hl)
	cp	a,e
	jr	NC, 00109$
	ldhl	sp,	#9
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl), a
	ldhl	sp,	#4
	ld	e, (hl)
	ld	d, #0x00
;c
	ldhl	sp,	#9
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#9
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#8
	ld	(hl), a
	ld	a, (#_screenminy)
	ldhl	sp,	#9
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl), a
	ldhl	sp,	#9
	ld	e, l
	ld	d, h
	ldhl	sp,	#7
	ld	a, (de)
	sub	a, (hl)
	inc	hl
	inc	de
	ld	a, (de)
	sbc	a, (hl)
	ld	a, (de)
	ld	d, a
	bit	7, (hl)
	jr	Z, 00151$
	bit	7, d
	jr	NZ, 00152$
	cp	a, a
	jr	00152$
00151$:
	bit	7, d
	jr	Z, 00152$
	scf
00152$:
	jr	C, 00110$
00109$:
	xor	a, a
	jr	00111$
00110$:
	ld	a, #0x01
00111$:
;main.c:859: if(pr->oam != NULL && is_obj_inside_screen(pr->oam->x, pr->oam->y, pr->width, pr->height)) {
	or	a, a
	jp	Z, 00102$
;main.c:860: pr->oam->y += pr->speedy;
	pop	hl
	push	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#5
	add	a, (hl)
	ld	(bc), a
;main.c:861: pr->oam->x = pr->aimedflg == 1 ? get_prjctl_x_aimed(pr) : pr->oam->x + pr->speedx;
	dec	hl
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	inc	bc
	ldhl	sp,	#7
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;c
	pop	de
	push	de
	ld	hl, #0x0005
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	dec	a
	jr	NZ, 00118$
	ldhl	sp,	#0
	ld	a, (hl+)
	ld	e, (hl)
	ldhl	sp,	#9
	ld	(hl+), a
;main.c:815: return ((prjct->oam->y - gradient) * precfctr) / slope;
;c
	ld	a, e
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0006
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#7
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#6
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#9
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	ld	b, #0x00
	ld	a, c
	ld	hl, #_gradient
	sub	a, (hl)
	ld	c, a
	ld	a, b
	inc	hl
	sbc	a, (hl)
	ld	b, a
	ld	hl, #_precfctr
	ld	e, (hl)
	ld	d, #0x00
	push	de
	push	bc
	call	__mulint
	add	sp, #4
	ld	hl, #_slope
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	push	de
	call	__divsint
	add	sp, #4
	ld	a, e
;main.c:861: pr->oam->x = pr->aimedflg == 1 ? get_prjctl_x_aimed(pr) : pr->oam->x + pr->speedx;
	jr	00119$
00118$:
	ldhl	sp,#7
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	pop	de
	push	de
	ld	a, (de)
	add	a, c
00119$:
	ldhl	sp,	#7
	push	af
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	pop	af
	ld	(hl), a
	jr	00107$
00102$:
;main.c:863: destroy_projectile(pr);
	pop	hl
	push	hl
	push	hl
	call	_destroy_projectile
	add	sp, #2
00107$:
;main.c:865: }
	add	sp, #11
	ret
;main.c:868: void explode_machine(Machine * mch) {
;	---------------------------------
; Function explode_machine
; ---------------------------------
_explode_machine::
;main.c:869: if(mch->explcount % 4 == 0) {
	pop	bc
	pop	de
	push	de
	push	bc
	ld	hl, #0x0007
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	and	a, #0x03
	jr	NZ, 00105$
;main.c:870: if(shadow_OAM[mch->oamtilenums[0]].tile != 5) {
	ld	hl, #0x000d
	add	hl, de
	ld	a, (hl)
	ld	h, #0x00
	ld	l, a
	add	hl, hl
	add	hl, hl
	push	de
	ld	de, #_shadow_OAM
	add	hl, de
	pop	de
	inc	hl
	inc	hl
	ld	a, (hl)
	sub	a, #0x05
	jr	Z, 00102$
;main.c:871: set_machine_sprite_tiles(mch, 5);
	push	bc
	ld	a, #0x05
	push	af
	inc	sp
	push	de
	call	_set_machine_sprite_tiles
	add	sp, #3
	pop	bc
	jr	00105$
00102$:
;main.c:873: set_machine_sprite_tiles(mch, 9);
	push	bc
	ld	a, #0x09
	push	af
	inc	sp
	push	de
	call	_set_machine_sprite_tiles
	add	sp, #3
	pop	bc
00105$:
;main.c:876: mch->explcount++;
	ld	a, (bc)
	ld	e, a
	inc	e
	ld	a, e
	ld	(bc), a
;main.c:877: if(mch->explcount == expldur) {
	ld	a, (#_expldur)
	sub	a, e
	ret	NZ
;main.c:878: destroy_machine(mch);
	pop	bc
	pop	hl
	push	hl
	push	bc
	push	hl
	call	_destroy_machine
	add	sp, #2
;main.c:880: }
	ret
;main.c:883: void anim_explode_boss(UINT8 x, UINT8 y, UINT8 width, UINT8 height) {
;	---------------------------------
; Function anim_explode_boss
; ---------------------------------
_anim_explode_boss::
	add	sp, #-5
;main.c:884: UINT8 stepx = width / 8; // Horizontal step
	ldhl	sp,	#9
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	bit	7, b
	jr	Z, 00124$
	ld	hl, #0x0007
	add	hl, bc
00124$:
	ld	c, l
	ld	b, h
	sra	b
	rr	c
	sra	b
	rr	c
	sra	b
	rr	c
	ldhl	sp,	#0
	ld	(hl), c
;main.c:885: UINT8 stepy = height / 8; // Vertical step
	ldhl	sp,	#10
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	bit	7, b
	jr	Z, 00125$
	ld	hl, #0x0007
	add	hl, bc
00125$:
	ld	c, l
	ld	b, h
	sra	b
	rr	c
	sra	b
	rr	c
	sra	b
	rr	c
	ldhl	sp,	#1
	ld	(hl), c
;main.c:887: for(i = 0; i < 5; i++) {
	ld	hl, #_i
	ld	(hl), #0x00
00120$:
;main.c:888: explcord[i][0] = x + (genexplcord[i][0] * stepx);
	ld	hl, #_i
	ld	l, (hl)
	ld	h, #0x00
	add	hl, hl
	ld	a, l
	add	a, #<(_explcord)
	ld	c, a
	ld	a, h
	adc	a, #>(_explcord)
	ld	b, a
	ld	de, #_genexplcord
	add	hl, de
	ld	a, (hl)
	push	bc
	ldhl	sp,	#2
	ld	h, (hl)
	push	hl
	inc	sp
	push	af
	inc	sp
	call	__muluchar
	add	sp, #2
	ld	a, e
	pop	bc
	ldhl	sp,	#7
	add	a, (hl)
	ld	(bc), a
;main.c:889: explcord[i][1] = y + (genexplcord[i][1] * stepy);
	ld	hl, #_i
	ld	e, (hl)
	ld	d, #0x00
	sla	e
	rl	d
	ld	hl,#_explcord+1
	add	hl,de
	ld	c, l
	ld	b, h
	ld	hl,#_genexplcord+1
	add	hl,de
	ld	a, (hl)
	push	bc
	ldhl	sp,	#3
	ld	h, (hl)
	push	hl
	inc	sp
	push	af
	inc	sp
	call	__muluchar
	add	sp, #2
	ld	a, e
	pop	bc
	ldhl	sp,	#8
	add	a, (hl)
	ld	(bc), a
;main.c:890: move_sprite(4, explcord[i][0], explcord[i][1]);
	ld	hl, #_i
	ld	l, (hl)
	ld	h, #0x00
	add	hl, hl
	ld	de, #_explcord
	add	hl, de
	ld	c, l
	ld	b, h
	inc	bc
	ld	a, (bc)
	ld	b, a
	ld	c, (hl)
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1218: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 0x0010)
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1219: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;main.c:891: move_sprite(5, explcord[i][0] + 8, explcord[i][1]);
	ld	hl, #_i
	ld	l, (hl)
	ld	h, #0x00
	add	hl, hl
	ld	de, #_explcord
	add	hl, de
	ld	c, l
	ld	b, h
	inc	bc
	ld	a, (bc)
	ld	b, a
	ld	a, (hl)
	add	a, #0x08
	ld	c, a
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1218: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 0x0014)
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1219: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;main.c:892: move_sprite(6, explcord[i][0], explcord[i][1] + 8);
	ld	hl, #_i
	ld	l, (hl)
	ld	h, #0x00
	add	hl, hl
	ld	de, #_explcord
	add	hl, de
	ld	c, l
	ld	b, h
	inc	bc
	ld	a, (bc)
	add	a, #0x08
	ld	b, a
	ld	c, (hl)
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1218: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 0x0018)
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1219: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;main.c:893: move_sprite(7, explcord[i][0] + 8, explcord[i][1] + 8);
	ld	hl, #_i
	ld	l, (hl)
	ld	h, #0x00
	add	hl, hl
	ld	de, #_explcord
	add	hl, de
	ld	c, l
	ld	b, h
	inc	bc
	ld	a, (bc)
	add	a, #0x08
	ld	b, a
	ld	a, (hl)
	add	a, #0x08
	ld	c, a
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1218: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 0x001c)
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1219: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;main.c:895: se_explode();
	call	_se_explode
;main.c:896: for(explcyc = 0; explcyc < expldur; explcyc++) {
	xor	a, a
	ldhl	sp,	#4
	ld	(hl), a
00118$:
	ld	hl, #_expldur
	ld	c, (hl)
	ldhl	sp,	#4
	ld	a, (hl)
	sub	a, c
	jr	NC, 00121$
;main.c:897: if(explcyc % 4 == 0) {  // Change explosion tiles every 4 cycles for animation
	ld	a, (hl)
	and	a, #0x03
	jr	NZ, 00102$
;main.c:898: fstexpltile = shadow_OAM[4].tile == 5 ? 9 : 5;  // Alternating between explosion tiles
	ld	a, (#(_shadow_OAM + 0x0012) + 0)
	sub	a, #0x05
	jr	NZ, 00126$
	ldhl	sp,	#2
	ld	(hl), #0x09
	xor	a, a
	inc	hl
	ld	(hl), a
	jr	00127$
00126$:
	ldhl	sp,	#2
	ld	(hl), #0x05
	xor	a, a
	inc	hl
	ld	(hl), a
00127$:
	ldhl	sp,	#2
	ld	c, (hl)
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1145: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 0x0012)
	ld	(hl), c
;main.c:900: set_sprite_tile(5, fstexpltile + 2);
	ld	b, c
	inc	b
	inc	b
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1145: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 0x0016)
	ld	(hl), b
;main.c:901: set_sprite_tile(6, fstexpltile + 1);
	ld	b, c
	inc	b
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1145: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 0x001a)
	ld	(hl), b
;main.c:902: set_sprite_tile(7, fstexpltile + 3);
	inc	c
	inc	c
	inc	c
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1145: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 0x001e)
	ld	(hl), c
;main.c:902: set_sprite_tile(7, fstexpltile + 3);
00102$:
;main.c:904: wait_vbl_done();
	call	_wait_vbl_done
;main.c:896: for(explcyc = 0; explcyc < expldur; explcyc++) {
	ldhl	sp,	#4
	inc	(hl)
	jr	00118$
00121$:
;main.c:887: for(i = 0; i < 5; i++) {
	ld	hl, #_i
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x05
	jp	C, 00120$
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1145: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 0x0012)
	ld	(hl), #0x00
	ld	hl, #(_shadow_OAM + 0x0016)
	ld	(hl), #0x00
	ld	hl, #(_shadow_OAM + 0x001a)
	ld	(hl), #0x00
	ld	hl, #(_shadow_OAM + 0x001e)
	ld	(hl), #0x00
;main.c:910: set_sprite_tile(7, 0);
;main.c:911: }
	add	sp, #5
	ret
;main.c:914: void destroy_machine(Machine * mch) {
;	---------------------------------
; Function destroy_machine
; ---------------------------------
_destroy_machine::
	add	sp, #-2
;main.c:915: set_machine_tile(mch, 0);
	xor	a, a
	push	af
	inc	sp
	ldhl	sp,	#5
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_set_machine_tile
	add	sp, #3
;main.c:916: move_sprite(mch->oamtilenums[0], 0, 0);
	ldhl	sp,#4
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x000d
	add	hl, bc
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1218: OAM_item_t * itm = &shadow_OAM[nb];
	ld	a, (hl)
	ld	h, #0x00
	ld	l, a
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1219: itm->y=y, itm->x=x;
	ld	a, #0x00
	ld	(hl+), a
	ld	(hl), #0x00
;main.c:917: move_sprite(mch->oamtilenums[1], 0, 0);
	ld	hl, #0x000e
	add	hl, bc
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1218: OAM_item_t * itm = &shadow_OAM[nb];
	ld	a, (hl)
	ld	h, #0x00
	ld	l, a
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1219: itm->y=y, itm->x=x;
	ld	a, #0x00
	ld	(hl+), a
	ld	(hl), #0x00
;main.c:918: move_sprite(mch->oamtilenums[2], 0, 0);
	ld	hl, #0x000f
	add	hl, bc
	ld	e, (hl)
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1218: OAM_item_t * itm = &shadow_OAM[nb];
	ld	h, #0x00
	ld	l, e
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1219: itm->y=y, itm->x=x;
	ld	a, #0x00
	ld	(hl+), a
	ld	(hl), #0x00
;main.c:919: move_sprite(mch->oamtilenums[3], 0, 0);
	ld	hl, #0x0010
	add	hl, bc
	ld	e, (hl)
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1218: OAM_item_t * itm = &shadow_OAM[nb];
	ld	h, #0x00
	ld	l, e
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1219: itm->y=y, itm->x=x;
	ld	a, #0x00
	ld	(hl+), a
	ld	(hl), #0x00
;main.c:920: mch->explcount = mch->x = mch->y = 0;
	ld	hl, #0x0007
	add	hl, bc
	inc	sp
	inc	sp
	push	hl
	ld	e, c
	ld	d, b
	inc	de
	inc	bc
	inc	bc
	xor	a, a
	ld	(bc), a
	xor	a, a
	ld	(de), a
	pop	hl
	push	hl
	ld	(hl), #0x00
;main.c:921: }
	add	sp, #2
	ret
;main.c:924: void take_damage(Machine * mch, UINT8 dmgamt) {
;	---------------------------------
; Function take_damage
; ---------------------------------
_take_damage::
	dec	sp
;main.c:925: mch->shield -= dmgamt;
	ldhl	sp,#3
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x000b
	add	hl, bc
	ld	e, l
	ld	d, h
	ld	a, (de)
	push	af
	ldhl	sp,	#7
	ld	a, (hl)
	ldhl	sp,	#2
	ld	(hl), a
	pop	af
	sub	a, (hl)
	ld	(de), a
;main.c:926: if(pl == mch) {
	ld	hl, #_pl
	ld	a, (hl)
	sub	a, c
	jr	NZ, 00107$
	inc	hl
	ld	a, (hl)
	sub	a, b
	jr	NZ, 00107$
;main.c:927: hud_upd_shield(pl->shield + dmgamt, pl->shield);
	ld	hl, #_pl + 1
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000b
	add	hl, de
	ld	d, (hl)
	ld	a, d
	ldhl	sp,	#0
	add	a, (hl)
	push	bc
	push	de
	inc	sp
	push	af
	inc	sp
	call	_hud_upd_shield
	add	sp, #2
	pop	bc
;main.c:928: if(is_alive(pl)) {
	ld	hl, #_pl + 1
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
;main.c:831: return mch->shield > 0;
	ld	hl, #0x000b
	add	hl, de
	ld	l, (hl)
	ld	e, l
	ld	d, #0x00
	xor	a, a
	sub	a, l
	bit	7, e
	jr	Z, 00164$
	bit	7, d
	jr	NZ, 00165$
	cp	a, a
	jr	00165$
00164$:
	bit	7, d
	jr	Z, 00165$
	scf
00165$:
	jr	NC, 00104$
;main.c:928: if(is_alive(pl)) {
;main.c:929: iframeflg = 1; // Starting iframe period
	ld	hl, #_iframeflg
	ld	(hl), #0x01
;main.c:930: if(plgun == 2) {
	ld	a, (#_plgun)
	sub	a, #0x02
	jr	NZ, 00107$
;main.c:931: plgun = 1;  // Reverting to second gun when less than full health
	ld	hl, #_plgun
	ld	(hl), #0x01
;main.c:932: hud_draw_gun();
	push	bc
	call	_hud_draw_gun
	pop	bc
	jr	00107$
00104$:
;main.c:935: lockmvmnt = 3;
	ld	hl, #_lockmvmnt
	ld	(hl), #0x03
;main.c:936: pllives--;
	ld	hl, #_pllives
	dec	(hl)
;main.c:937: plgun = numkills = 0;  // Back to regular gun on death
	ld	hl, #_numkills
	ld	(hl), #0x00
	ld	hl, #_plgun
	ld	(hl), #0x00
;main.c:938: hud_upd_lives();
	push	bc
	call	_hud_upd_lives
	call	_hud_draw_gun
	pop	bc
00107$:
;main.c:942: if(!is_alive(mch)) {
	ld	e, c
	ld	d, b
;main.c:831: return mch->shield > 0;
	ld	hl, #0x000b
	add	hl, de
	ld	l, (hl)
	ld	e, l
	ld	d, #0x00
	xor	a, a
	sub	a, l
	bit	7, e
	jr	Z, 00168$
	bit	7, d
	jr	NZ, 00169$
	cp	a, a
	jr	00169$
00168$:
	bit	7, d
	jr	Z, 00169$
	scf
00169$:
	jr	C, 00114$
;main.c:942: if(!is_alive(mch)) {
;main.c:943: if(mch != pl) {
	ld	hl, #_pl
	ld	a, (hl)
	sub	a, c
	jr	NZ, 00170$
	inc	hl
	ld	a, (hl)
	sub	a, b
	jr	Z, 00112$
00170$:
;main.c:944: numkills++;
	ld	hl, #_numkills
	inc	(hl)
;main.c:945: if(numkills == 10 && plgun == 0) {
	ld	a, (hl)
	sub	a, #0x0a
	jr	NZ, 00112$
	ld	a, (#_plgun)
	or	a, a
	jr	NZ, 00112$
;main.c:946: plgun = pl->shield == 4 ? 2 : 1; // On 10 kills upgrade gun depending on health
	ld	hl, #_pl + 1
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000b
	add	hl, de
	ld	a, (hl)
	sub	a, #0x04
	jr	NZ, 00120$
	ld	de, #0x0002
	jr	00121$
00120$:
	ld	de, #0x0001
00121$:
	ld	hl, #_plgun
	ld	(hl), e
;main.c:947: hud_draw_gun();
	push	bc
	call	_hud_draw_gun
	call	_se_wpn_upgrd
	pop	bc
00112$:
;main.c:951: init_explosion(mch);
	push	bc
	call	_init_explosion
	add	sp, #2
	jr	00118$
00114$:
;main.c:953: se_get_hit();
	call	_se_get_hit
00118$:
;main.c:955: }
	inc	sp
	ret
;main.c:958: void add_to_player_shield(UINT8 amt) {  // Used for increasing player shield value
;	---------------------------------
; Function add_to_player_shield
; ---------------------------------
_add_to_player_shield::
;main.c:959: if(pl->shield + amt > 4) {
	ld	hl, #_pl + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x000b
	add	hl, bc
	ld	c, (hl)
	ld	a, c
	ld	e, a
	rla
	sbc	a, a
	ld	d, a
	ldhl	sp,	#2
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	e, h
	ld	d, #0x00
	ld	a, #0x04
	cp	a, l
	ld	a, #0x00
	sbc	a, h
	bit	7, e
	jr	Z, 00111$
	bit	7, d
	jr	NZ, 00112$
	cp	a, a
	jr	00112$
00111$:
	bit	7, d
	jr	Z, 00112$
	scf
00112$:
	jr	NC, 00102$
;main.c:960: hud_upd_shield(pl->shield, 4);
	ld	b, #0x04
	push	bc
	call	_hud_upd_shield
	add	sp, #2
;main.c:961: pl->shield = 4; // Shield max capacity is always 4
	ld	hl, #_pl + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x000b
	add	hl, bc
	ld	(hl), #0x04
	ret
00102$:
;main.c:963: hud_upd_shield(pl->shield, pl->shield + amt);
	ldhl	sp,	#2
	ld	e, (hl)
	ld	a, c
	add	a, e
	push	de
	ld	b, a
	push	bc
	call	_hud_upd_shield
	add	sp, #2
	pop	de
;main.c:959: if(pl->shield + amt > 4) {
	ld	hl, #_pl + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x000b
	add	hl, bc
;main.c:964: pl->shield += amt;
	ld	a, (hl)
	add	a, e
	ld	(hl), a
;main.c:966: }
	ret
;main.c:969: void check_iframes() {  // Animate blinking during iframe period
;	---------------------------------
; Function check_iframes
; ---------------------------------
_check_iframes::
;main.c:970: if(iframecnt == pliframeprd) {  // Iframe period has ended
	ld	hl, #_pliframeprd
	ld	c, (hl)
	ld	a, (#_iframecnt)
	sub	a, c
	jr	NZ, 00105$
;main.c:971: iframecnt = iframeflg = 0;
	ld	hl, #_iframeflg
	ld	(hl), #0x00
	ld	hl, #_iframecnt
	ld	(hl), #0x00
;main.c:972: set_machine_sprite_tiles(pl, pl->groundflg == 1 ? 1 : 13);
	ld	hl, #_pl + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, (bc)
	dec	a
	jr	NZ, 00109$
	ld	bc, #0x0001
	jr	00110$
00109$:
	ld	bc, #0x000d
00110$:
	ld	a, c
	push	af
	inc	sp
	ld	hl, #_pl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_set_machine_sprite_tiles
	add	sp, #3
	ret
00105$:
;main.c:974: iframecnt++;
	ld	hl, #_iframecnt
	inc	(hl)
;main.c:975: if(shadow_OAM[0].tile == 0) {   // Swap player sprite and empty tiles
	ld	a, (#(_shadow_OAM + 0x0002) + 0)
	or	a, a
	jr	NZ, 00102$
;main.c:976: set_machine_sprite_tiles(pl, pl->groundflg == 1 ? 1 : 13);
	ld	hl, #_pl + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, (bc)
	dec	a
	jr	NZ, 00111$
	ld	bc, #0x0001
	jr	00112$
00111$:
	ld	bc, #0x000d
00112$:
	ld	a, c
	push	af
	inc	sp
	ld	hl, #_pl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_set_machine_sprite_tiles
	add	sp, #3
	ret
00102$:
;main.c:978: set_machine_tile(pl, 0);
	xor	a, a
	push	af
	inc	sp
	ld	hl, #_pl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_set_machine_tile
	add	sp, #3
;main.c:981: }
	ret
;main.c:984: void check_projectile_collsn(Machine * mch, Projectile * prj) {
;	---------------------------------
; Function check_projectile_collsn
; ---------------------------------
_check_projectile_collsn::
	add	sp, #-12
;main.c:985: if ((mch->x + mch->hboffx < prj->oam->x + prj->width && mch->y + mch->hboffy < prj->oam->y + prj->height) 
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	e, (hl)
	ldhl	sp,	#0
	ld	(hl+), a
	ld	(hl), e
	pop	hl
	push	hl
	inc	hl
	ld	c, (hl)
	ld	b, #0x00
	pop	hl
	push	hl
	inc	hl
	inc	hl
	inc	hl
	ld	e, (hl)
	ld	d, #0x00
	ld	l, e
	ld	h, d
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl), a
	ldhl	sp,	#16
	ld	a, (hl+)
	ld	e, (hl)
	ldhl	sp,	#4
	ld	(hl+), a
;c
	ld	a, e
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0006
	add	hl, de
	ld	c, l
	ld	b, h
	ld	e, c
	ld	d, b
	ld	a, (de)
	ldhl	sp,	#10
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl-), a
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#6
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl), a
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	inc	hl
	ld	c, (hl)
	ld	b, #0x00
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#2
	ld	a, (hl)
	sub	a, c
	inc	hl
	ld	a, (hl)
	sbc	a, b
	ld	d, (hl)
	ld	a, b
	ld	e, a
	bit	7, e
	jr	Z, 00128$
	bit	7, d
	jr	NZ, 00129$
	cp	a, a
	jr	00129$
00128$:
	bit	7, d
	jr	Z, 00129$
	scf
00129$:
	jp	NC, 00106$
	pop	hl
	push	hl
	inc	hl
	inc	hl
	ld	c, (hl)
	ld	b, #0x00
;c
	pop	de
	push	de
	ld	hl, #0x0004
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ld	e, #0x00
	ld	l, a
	ld	h, e
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#10
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#9
	ld	(hl+), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	dec	hl
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl), a
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	ld	c, (hl)
	ld	b, #0x00
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#8
	ld	a, (hl)
	sub	a, c
	inc	hl
	ld	a, (hl)
	sbc	a, b
	ld	d, (hl)
	ld	a, b
	ld	e, a
	bit	7, e
	jr	Z, 00130$
	bit	7, d
	jr	NZ, 00131$
	cp	a, a
	jr	00131$
00130$:
	bit	7, d
	jr	Z, 00131$
	scf
00131$:
	jp	NC, 00106$
;main.c:986: && (prj->oam->x <  mch->x + mch->hboffx + mch->width && prj->oam->y <  mch->y + mch->hboffy + mch->height)) {
;c
	pop	de
	push	de
	ld	hl, #0x0005
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	d, #0x00
;c
	ld	e, a
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#6
	ld	a, (hl)
	sub	a, c
	inc	hl
	ld	a, (hl)
	sbc	a, b
	ld	d, (hl)
	ld	a, b
	ld	e, a
	bit	7, e
	jr	Z, 00132$
	bit	7, d
	jr	NZ, 00133$
	cp	a, a
	jr	00133$
00132$:
	bit	7, d
	jr	Z, 00133$
	scf
00133$:
	jr	NC, 00106$
;c
	pop	de
	push	de
	ld	hl, #0x0006
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	d, #0x00
;c
	ld	e, a
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#10
	ld	a, (hl)
	sub	a, c
	inc	hl
	ld	a, (hl)
	sbc	a, b
	ld	d, (hl)
	ld	a, b
	ld	e, a
	bit	7, e
	jr	Z, 00134$
	bit	7, d
	jr	NZ, 00135$
	cp	a, a
	jr	00135$
00134$:
	bit	7, d
	jr	Z, 00135$
	scf
00135$:
	jr	NC, 00106$
;main.c:987: take_damage(mch, prj->damage);
;c
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	push	af
	inc	sp
	ldhl	sp,	#1
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_take_damage
	add	sp, #3
;main.c:988: destroy_projectile(prj);
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_destroy_projectile
	add	sp, #2
00106$:
;main.c:990: }
	add	sp, #12
	ret
;main.c:993: void check_player_machine_collsn(Machine * mch) {
;	---------------------------------
; Function check_player_machine_collsn
; ---------------------------------
_check_player_machine_collsn::
	add	sp, #-12
;main.c:994: if ((mch->x + mch->hboffx < pl->x + pl->hboffx + pl->width && mch->y + mch->hboffy < pl->y + pl->hboffy + pl->height) 
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	e, (hl)
	ldhl	sp,	#0
	ld	(hl+), a
	ld	(hl), e
	pop	hl
	push	hl
	inc	hl
	ld	c, (hl)
	ld	b, #0x00
	pop	hl
	push	hl
	inc	hl
	inc	hl
	inc	hl
	ld	e, (hl)
	ld	d, #0x00
	ld	l, e
	ld	h, d
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl), a
	ld	hl, #_pl
	ld	a, (hl+)
	ld	e, (hl)
	ldhl	sp,	#4
	ld	(hl+), a
	ld	a, e
	ld	(hl-), a
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	ld	c, (hl)
	ld	b, #0x00
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	inc	hl
	ld	e, (hl)
	ld	d, #0x00
	ld	l, e
	ld	h, d
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#8
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#7
;c
	ld	(hl-), a
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0005
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	c, a
	ld	b, #0x00
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#2
	ld	a, (hl)
	sub	a, c
	inc	hl
	ld	a, (hl)
	sbc	a, b
	ld	d, (hl)
	ld	a, b
	ld	e, a
	bit	7, e
	jr	Z, 00135$
	bit	7, d
	jr	NZ, 00136$
	cp	a, a
	jr	00136$
00135$:
	bit	7, d
	jr	Z, 00136$
	scf
00136$:
	jp	NC, 00108$
	pop	hl
	push	hl
	inc	hl
	inc	hl
	ld	c, (hl)
	ld	b, #0x00
;c
	pop	de
	push	de
	ld	hl, #0x0004
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ld	e, #0x00
	ld	l, a
	ld	h, e
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#10
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#9
	ld	(hl), a
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	ld	c, (hl)
	ld	b, #0x00
;c
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ld	e, #0x00
	ld	l, a
	ld	h, e
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#12
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#11
	ld	(hl), a
;c
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0006
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	c, a
	ld	b, #0x00
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#8
	ld	a, (hl)
	sub	a, c
	inc	hl
	ld	a, (hl)
	sbc	a, b
	ld	d, (hl)
	ld	a, b
	ld	e, a
	bit	7, e
	jr	Z, 00137$
	bit	7, d
	jr	NZ, 00138$
	cp	a, a
	jr	00138$
00137$:
	bit	7, d
	jr	Z, 00138$
	scf
00138$:
	jp	NC, 00108$
;main.c:995: && (pl->x + pl->hboffx <  mch->x + mch->hboffx + mch->width && pl->y + pl->hboffy <  mch->y + mch->hboffy + mch->height)) {
;c
	pop	de
	push	de
	ld	hl, #0x0005
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	d, #0x00
;c
	ld	e, a
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#6
	ld	a, (hl)
	sub	a, c
	inc	hl
	ld	a, (hl)
	sbc	a, b
	ld	d, (hl)
	ld	a, b
	ld	e, a
	bit	7, e
	jr	Z, 00139$
	bit	7, d
	jr	NZ, 00140$
	cp	a, a
	jr	00140$
00139$:
	bit	7, d
	jr	Z, 00140$
	scf
00140$:
	jr	NC, 00108$
;c
	pop	de
	push	de
	ld	hl, #0x0006
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	d, #0x00
;c
	ld	e, a
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#10
	ld	a, (hl)
	sub	a, c
	inc	hl
	ld	a, (hl)
	sbc	a, b
	ld	d, (hl)
	ld	a, b
	ld	e, a
	bit	7, e
	jr	Z, 00141$
	bit	7, d
	jr	NZ, 00142$
	cp	a, a
	jr	00142$
00141$:
	bit	7, d
	jr	Z, 00142$
	scf
00142$:
	jr	NC, 00108$
;main.c:996: take_damage(pl, pl->shield);    // Take all health away
;c
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000b
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	push	af
	inc	sp
	ld	hl, #_pl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_take_damage
	add	sp, #3
;main.c:997: if(mch->type != 6) {
;c
	pop	de
	push	de
	ld	hl, #0x000c
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	sub	a, #0x06
	jr	Z, 00108$
;main.c:998: init_explosion(mch);
	pop	hl
	push	hl
	push	hl
	call	_init_explosion
	add	sp, #2
00108$:
;main.c:1001: }
	add	sp, #12
	ret
;main.c:1004: void anim_jump() {
;	---------------------------------
; Function anim_jump
; ---------------------------------
_anim_jump::
	add	sp, #-10
;main.c:1007: move_machine(pl, 0, pl->y > jumpstarty - jumphalflimy ? -jumpspeed : -jumpspeed + 1);
	ld	a, (#_jumpspeed)
	ldhl	sp,	#0
	ld	(hl), a
;main.c:1005: if(ascendflg) {
	ld	a, (#_ascendflg)
	or	a, a
	jp	Z, 00110$
;main.c:1006: if(pl->y > jumpstarty - jumplimity) {    // Ascending
	ld	hl, #_pl
	ld	a, (hl+)
	ld	e, (hl)
	ldhl	sp,	#1
	ld	(hl+), a
;c
	ld	a, e
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0002
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#10
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#9
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#3
	ld	(hl), a
	ld	a, (#_jumpstarty)
	ldhl	sp,	#4
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl), a
	ld	a, (#_jumplimity)
	ldhl	sp,	#9
	ld	(hl), a
	ldhl	sp,	#6
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl-), a
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#9
	ld	(hl-), a
	ld	(hl), e
	ldhl	sp,	#3
	ld	c, (hl)
	ld	b, #0x00
	ldhl	sp,	#8
	ld	a, (hl)
	sub	a, c
	inc	hl
	ld	a, (hl)
	sbc	a, b
	ld	d, (hl)
	ld	a, b
	ld	e, a
	bit	7, e
	jr	Z, 00146$
	bit	7, d
	jr	NZ, 00147$
	cp	a, a
	jr	00147$
00146$:
	bit	7, d
	jr	Z, 00147$
	scf
00147$:
	jr	NC, 00105$
;main.c:1007: move_machine(pl, 0, pl->y > jumpstarty - jumphalflimy ? -jumpspeed : -jumpspeed + 1);
	ld	a, (#_jumphalflimy)
	ldhl	sp,	#6
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl-), a
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#9
	ld	(hl-), a
	ld	(hl), e
	xor	a, a
	ldhl	sp,	#0
	sub	a, (hl)
	ldhl	sp,	#7
	ld	(hl+), a
	ld	a, (hl)
	sub	a, c
	inc	hl
	ld	a, (hl)
	sbc	a, b
	ld	d, (hl)
	ld	a, b
	bit	7,a
	jr	Z, 00148$
	bit	7, d
	jr	NZ, 00149$
	cp	a, a
	jr	00149$
00148$:
	bit	7, d
	jr	Z, 00149$
	scf
00149$:
	jr	NC, 00114$
	ldhl	sp,	#7
	ld	a, (hl)
	jr	00115$
00114$:
	ldhl	sp,	#7
	ld	a, (hl)
	inc	a
00115$:
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	ld	hl, #_pl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_move_machine
	add	sp, #4
	jr	00112$
00105$:
;main.c:1009: if(pl->x < holestartx && pl->x > holeendx) {  // Above solid ground
	ldhl	sp,	#1
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	ld	c, (hl)
	ld	a, c
	ld	hl, #_holestartx
	sub	a, (hl)
	jr	NC, 00112$
	ld	a, (#_holeendx)
	sub	a, c
	jr	NC, 00112$
;main.c:1010: ascendflg = 0; // Start of descend
	ld	hl, #_ascendflg
	ld	(hl), #0x00
	jr	00112$
00110$:
;main.c:1014: move_machine(pl, 0, jumpspeed);
	ldhl	sp,	#0
	ld	a, (hl)
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	ld	hl, #_pl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_move_machine
	add	sp, #4
;main.c:1006: if(pl->y > jumpstarty - jumplimity) {    // Ascending
	ld	hl, #_pl + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
;main.c:1015: if(pl->y >= jumpstarty) {    // Back on ground / stop jump animmation
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	ld	e, (hl)
	ld	a, e
	ld	hl, #_jumpstarty
	sub	a, (hl)
	jr	C, 00112$
;main.c:1016: pl->groundflg = 1;
	ld	a, #0x01
	ld	(bc), a
;main.c:1017: ascendflg = 1;  // Reverting flag for next jump
	ld	hl, #_ascendflg
;main.c:1018: set_machine_sprite_tiles(pl, 1);
	ld	a,#0x01
	ld	(hl),a
	push	af
	inc	sp
	ld	hl, #_pl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_set_machine_sprite_tiles
	add	sp, #3
;main.c:1019: lockmvmnt = 0;  // Allowing free movement
	ld	hl, #_lockmvmnt
	ld	(hl), #0x00
00112$:
;main.c:1022: }
	add	sp, #10
	ret
;main.c:1028: void exec_enemy_pattern(Machine * mch) {
;	---------------------------------
; Function exec_enemy_pattern
; ---------------------------------
_exec_enemy_pattern::
;main.c:1029: switch(mch->type) {
	pop	bc
	pop	de
	push	de
	push	bc
	ld	hl, #0x000c
	add	hl, de
	ld	a, (hl)
	or	a, a
	jr	Z, 00101$
	cp	a, #0x01
	jr	Z, 00102$
	cp	a, #0x02
	jr	Z, 00103$
	cp	a, #0x03
	jr	Z, 00104$
	cp	a, #0x04
	jr	Z, 00105$
	sub	a, #0x05
	jr	Z, 00106$
	ret
;main.c:1030: case 0:
00101$:
;main.c:1031: exec_rider_pattern(mch);
	push	de
	call	_exec_rider_pattern
	add	sp, #2
;main.c:1032: break;
	ret
;main.c:1033: case 1:
00102$:
;main.c:1034: exec_drone_pattern(mch);
	push	de
	call	_exec_drone_pattern
	add	sp, #2
;main.c:1035: break;
	ret
;main.c:1036: case 2:
00103$:
;main.c:1037: exec_missile_pattern(mch);
	push	de
	call	_exec_missile_pattern
	add	sp, #2
;main.c:1038: break;
	ret
;main.c:1039: case 3:
00104$:
;main.c:1040: exec_turret_pattern(mch);
	push	de
	call	_exec_turret_pattern
	add	sp, #2
;main.c:1041: break;
	ret
;main.c:1042: case 4:
00105$:
;main.c:1043: exec_bomber_pattern(mch);
	push	de
	call	_exec_bomber_pattern
	add	sp, #2
;main.c:1044: break;
	ret
;main.c:1045: case 5:
00106$:
;main.c:1046: exec_mine_pattern(mch);
	push	de
	call	_exec_mine_pattern
	add	sp, #2
;main.c:1048: }
;main.c:1049: }
	ret
;main.c:1052: void exec_rider_pattern(Machine * mch) {
;	---------------------------------
; Function exec_rider_pattern
; ---------------------------------
_exec_rider_pattern::
;main.c:1053: if(mch->x > 130 && lockmvmnt != 2) {
	pop	bc
	pop	de
	push	de
	push	bc
	ld	l, e
	ld	h, d
	inc	hl
	ld	c, (hl)
	ld	a, #0x82
	sub	a, c
	jr	NC, 00107$
	ld	a, (#_lockmvmnt)
	sub	a, #0x02
	jr	Z, 00107$
;main.c:1054: move_enemy(mch, -1, pl->y > mch->y ? 1 : -1);
	ld	hl, #_pl + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	inc	bc
	ld	a, (bc)
	ld	c, a
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	ld	a, (hl)
	sub	a, c
	jr	NC, 00112$
	ld	bc, #0x0001
	jr	00113$
00112$:
	ld	bc, #0xffff
00113$:
	ld	h, c
	ld	l, #0xff
	push	hl
	push	de
	call	_move_enemy
	add	sp, #4
	ret
00107$:
;main.c:1055: } else if(mch->cyccount != 100) {
	ld	hl, #0x0008
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	cp	a, #0x64
	jr	Z, 00104$
;main.c:1056: if(mch->cyccount == 50) {
	sub	a, #0x32
	jr	NZ, 00102$
;main.c:1057: fire_bullet(mch, -2, 0);
	push	bc
	xor	a, a
	ld	h, a
	ld	l, #0xfe
	push	hl
	push	de
	call	_fire_bullet
	add	sp, #4
	pop	bc
00102$:
;main.c:1059: mch->cyccount++;
	ld	a, (bc)
	inc	a
	ld	(bc), a
	ret
00104$:
;main.c:1061: move_enemy(mch, -1, 0);
	xor	a, a
	ld	h, a
	ld	l, #0xff
	push	hl
	push	de
	call	_move_enemy
	add	sp, #4
;main.c:1063: }
	ret
;main.c:1066: void exec_drone_pattern(Machine * mch) {
;	---------------------------------
; Function exec_drone_pattern
; ---------------------------------
_exec_drone_pattern::
	add	sp, #-4
;main.c:1067: if(mch->x % 16 == 0) {
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	e, (hl)
	ldhl	sp,	#0
	ld	(hl+), a
	ld	(hl), e
;c
	pop	de
	push	de
	ld	l, e
	ld	h, d
	inc	hl
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	and	a, #0x0f
	ld	c, a
	ld	b, #0x00
;main.c:1068: mch->cyccount = mch->cyccount == 0 ? 1 : 0;
;c
	pop	de
	push	de
	ld	hl, #0x0008
	add	hl, de
	ld	e, l
	ld	d, h
;main.c:1067: if(mch->x % 16 == 0) {
	ld	a, b
	or	a, c
	jr	NZ, 00102$
;main.c:1068: mch->cyccount = mch->cyccount == 0 ? 1 : 0;
	ld	a, (de)
	or	a, a
	jr	NZ, 00108$
	ld	bc, #0x0001
	jr	00109$
00108$:
	ld	bc, #0x0000
00109$:
	ld	a, c
	ld	(de), a
00102$:
;main.c:1070: move_enemy(mch, -1, mch->cyccount == 0 ? 1 : -1);
	ld	a, (de)
	or	a, a
	jr	NZ, 00110$
	ld	bc, #0x0001
	jr	00111$
00110$:
	ld	bc, #0xffff
00111$:
	ld	d, c
	ld	c, #0xff
	ld	b, d
	pop	hl
	push	hl
	push	bc
	push	hl
	call	_move_enemy
	add	sp, #4
;main.c:1071: if(mch->x == 90 && pl->groundflg == 1) {
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	sub	a, #0x5a
	jr	NZ, 00106$
	ld	hl, #_pl + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, (bc)
	dec	a
	jr	NZ, 00106$
;main.c:1072: fire_bullet(mch, 0, 1);
	ld	a, #0x01
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	pop	bc
	pop	hl
	push	hl
	push	bc
	push	hl
	call	_fire_bullet
	add	sp, #4
00106$:
;main.c:1074: }
	add	sp, #4
	ret
;main.c:1077: void exec_missile_pattern(Machine * mch) {
;	---------------------------------
; Function exec_missile_pattern
; ---------------------------------
_exec_missile_pattern::
;main.c:1078: move_enemy(mch, -2, 0);
	xor	a, a
	ld	d,a
	ld	e,#0xfe
	push	de
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_move_enemy
	add	sp, #4
;main.c:1079: }
	ret
;main.c:1082: void exec_turret_pattern(Machine * mch) {
;	---------------------------------
; Function exec_turret_pattern
; ---------------------------------
_exec_turret_pattern::
;main.c:1083: move_enemy(mch, -2, 0);
	xor	a, a
	ld	d,a
	ld	e,#0xfe
	push	de
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_move_enemy
	add	sp, #4
;main.c:1084: if(mch->x == 87) {
	pop	bc
	pop	de
	push	de
	push	bc
	ld	c, e
	ld	b, d
	inc	bc
	ld	a, (bc)
	sub	a, #0x57
	ret	NZ
;main.c:1085: fire_bigbullet(mch, 0, -1);
	ld	a, #0xff
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	push	de
	call	_fire_bigbullet
	add	sp, #4
;main.c:1087: }
	ret
;main.c:1090: void exec_bomber_pattern(Machine * mch) {
;	---------------------------------
; Function exec_bomber_pattern
; ---------------------------------
_exec_bomber_pattern::
	add	sp, #-2
;main.c:1091: move_enemy(mch, -1, 0);
	xor	a, a
	ld	d,a
	ld	e,#0xff
	push	de
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_move_enemy
	add	sp, #4
;main.c:1092: if(pl->x > mch->x && pl->x < mch->x + 8 && mch->cyccount == 0) {
	ld	hl, #_pl + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	ld	a, (bc)
	ld	c, a
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	e, (hl)
	ldhl	sp,	#0
	ld	(hl+), a
	ld	(hl), e
	pop	hl
	push	hl
	inc	hl
	ld	e, (hl)
	ld	a, e
	sub	a, c
	jr	NC, 00105$
	ld	d, #0x00
	ld	hl, #0x0008
	add	hl, de
	ld	b, #0x00
	ld	e, h
	ld	d, b
	ld	a, c
	sub	a, l
	ld	a, b
	sbc	a, h
	bit	7, e
	jr	Z, 00122$
	bit	7, d
	jr	NZ, 00123$
	cp	a, a
	jr	00123$
00122$:
	bit	7, d
	jr	Z, 00123$
	scf
00123$:
	jr	NC, 00105$
;c
	pop	de
	push	de
	ld	hl, #0x0008
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	or	a, a
	jr	NZ, 00105$
;main.c:1093: drop_bomb(mch);
	push	bc
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_drop_bomb
	add	sp, #2
	pop	bc
;main.c:1094: mch->cyccount = 1;  // Preventing from continuously dropping bombs
	ld	a, #0x01
	ld	(bc), a
00105$:
;main.c:1096: }
	add	sp, #2
	ret
;main.c:1099: void exec_mine_pattern(Machine * mch) {
;	---------------------------------
; Function exec_mine_pattern
; ---------------------------------
_exec_mine_pattern::
;main.c:1100: if(mch->y == 101 || mch->y == 102) {
	pop	bc
	pop	de
	push	de
	push	bc
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	ld	c, (hl)
;main.c:1101: mch->cyccount = 0;
	ld	hl, #0x0008
	add	hl, de
;main.c:1100: if(mch->y == 101 || mch->y == 102) {
	ld	a,c
	cp	a,#0x65
	jr	Z, 00104$
	sub	a, #0x66
	jr	NZ, 00105$
00104$:
;main.c:1101: mch->cyccount = 0;
	ld	(hl), #0x00
	jr	00106$
00105$:
;main.c:1102: } else if(mch->y == 132 || mch->y == 133) {
	ld	a,c
	cp	a,#0x84
	jr	Z, 00101$
	sub	a, #0x85
	jr	NZ, 00106$
00101$:
;main.c:1103: mch->cyccount = 1;
	ld	(hl), #0x01
00106$:
;main.c:1105: move_enemy(mch, -2, mch->cyccount == 0 ? 1 : -1);
	ld	a, (hl)
	or	a, a
	jr	NZ, 00110$
	ld	bc, #0x0001
	jr	00111$
00110$:
	ld	bc, #0xffff
00111$:
	ld	h, c
	ld	l, #0xfe
	push	hl
	push	de
	call	_move_enemy
	add	sp, #4
;main.c:1106: }
	ret
;main.c:1109: UBYTE cooldown_enemy(Machine * mch, UINT8 period) { // Coolwon period between actions. Used in loops
;	---------------------------------
; Function cooldown_enemy
; ---------------------------------
_cooldown_enemy::
;main.c:1110: if(mch->cyccount != period) {
	pop	bc
	pop	de
	push	de
	push	bc
	ld	hl, #0x0008
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	e, a
	ldhl	sp,	#4
	ld	a, (hl)
	sub	a, e
	jr	Z, 00102$
;main.c:1111: mch->cyccount++;
	ld	a, e
	inc	a
	ld	(bc), a
;main.c:1112: return 0;
	ld	e, #0x00
	ret
00102$:
;main.c:1114: mch->cyccount = 0;
	xor	a, a
	ld	(bc), a
;main.c:1115: return 1; // End of cooldown
	ld	e, #0x01
;main.c:1116: }
	ret
;main.c:1121: void hud_init() {
;	---------------------------------
; Function hud_init
; ---------------------------------
_hud_init::
;main.c:1123: set_win_data(0, 20, hudtiles);
	ld	hl, #_hudtiles
	push	hl
	ld	a, #0x14
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_set_win_data
	add	sp, #4
;main.c:1124: set_win_tiles(0, 0, 18, 1, hudmap);
	ld	hl, #_hudmap
	push	hl
	ld	de, #0x0112
	push	de
	xor	a, a
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_set_win_tiles
	add	sp, #6
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1015: WX_REG=x, WY_REG=y;
	ld	a, #0x0f
	ldh	(_WX_REG+0),a
	ld	a, #0x86
	ldh	(_WY_REG+0),a
;main.c:1126: SHOW_WIN;
	ldh	a, (_LCDC_REG+0)
	or	a, #0x20
	ldh	(_LCDC_REG+0),a
;main.c:1127: }
	ret
;main.c:1130: void hud_upd_shield(INT8 hpbef, INT8 hpaft) {
;	---------------------------------
; Function hud_upd_shield
; ---------------------------------
_hud_upd_shield::
;main.c:1132: if(hpbef > hpaft) { // Has taken damage
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (hl-)
	sub	a, (hl)
	bit	7, e
	jr	Z, 00148$
	bit	7, d
	jr	NZ, 00149$
	cp	a, a
	jr	00149$
00148$:
	bit	7, d
	jr	Z, 00149$
	scf
00149$:
	jr	NC, 00104$
;main.c:1133: hptiletresh = hpaft < 0 ? 2 : hpaft + 2;  // HP bar lower tile boundary
	ldhl	sp,	#3
	bit	7, (hl)
	jr	Z, 00114$
	ld	bc, #0x0002
	jr	00115$
00114$:
	ldhl	sp,	#3
	ld	a, (hl)
	inc	a
	inc	a
	ld	c, a
	rla
00115$:
;main.c:1134: for(UINT8 hpcnt = hpbef + 2; hpcnt > hptiletresh; hpcnt--) {
	ldhl	sp,	#2
	ld	b, (hl)
	inc	b
	inc	b
00107$:
	ld	a, c
	sub	a, b
	ret	NC
;main.c:1135: set_win_tile_xy(hpcnt, 0, 0x0F);
	ld	a, #0x0f
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	push	bc
	inc	sp
	call	_set_win_tile_xy
	add	sp, #3
;main.c:1134: for(UINT8 hpcnt = hpbef + 2; hpcnt > hptiletresh; hpcnt--) {
	dec	b
	jr	00107$
00104$:
;main.c:1138: hptiletresh = hpaft + 3;
	ldhl	sp,	#3
	ld	c, (hl)
	inc	c
	inc	c
	inc	c
;main.c:1139: for(UINT8 hpcnt = hpbef + 3; hpcnt < hptiletresh; hpcnt++) {
	dec	hl
	ld	b, (hl)
	inc	b
	inc	b
	inc	b
00110$:
	ld	a, b
	sub	a, c
	ret	NC
;main.c:1140: set_win_tile_xy(hpcnt, 0, 0x0E);
	ld	a, #0x0e
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	push	bc
	inc	sp
	call	_set_win_tile_xy
	add	sp, #3
;main.c:1139: for(UINT8 hpcnt = hpbef + 3; hpcnt < hptiletresh; hpcnt++) {
	inc	b
;main.c:1143: }
	jr	00110$
;main.c:1146: inline void hud_upd_lives() {
;	---------------------------------
; Function hud_upd_lives
; ---------------------------------
_hud_upd_lives::
;main.c:1147: set_win_tile_xy(17, 0, pllives + 1);  // Tile offset 1
	ld	a, (#_pllives)
	inc	a
	push	af
	inc	sp
	xor	a, a
	ld	d,a
	ld	e,#0x11
	push	de
	call	_set_win_tile_xy
	add	sp, #3
;main.c:1148: }
	ret
;main.c:1151: void hud_draw_pause() {
;	---------------------------------
; Function hud_draw_pause
; ---------------------------------
_hud_draw_pause::
;main.c:1152: set_win_tile_xy(8, 0, 0x08);
	ld	a, #0x08
	push	af
	inc	sp
	xor	a, a
	ld	d,a
	ld	e,#0x08
	push	de
	call	_set_win_tile_xy
	add	sp, #3
;main.c:1153: set_win_tile_xy(9, 0, 0x05);
	ld	a, #0x05
	push	af
	inc	sp
	xor	a, a
	ld	d,a
	ld	e,#0x09
	push	de
	call	_set_win_tile_xy
	add	sp, #3
;main.c:1154: set_win_tile_xy(10, 0, 0x0A);
	ld	a, #0x0a
	push	af
	inc	sp
	xor	a, a
	ld	d,a
	ld	e,#0x0a
	push	de
	call	_set_win_tile_xy
	add	sp, #3
;main.c:1155: set_win_tile_xy(11, 0, 0x09);
	ld	a, #0x09
	push	af
	inc	sp
	xor	a, a
	ld	d,a
	ld	e,#0x0b
	push	de
	call	_set_win_tile_xy
	add	sp, #3
;main.c:1156: set_win_tile_xy(12, 0, 0x06);
	ld	a, #0x06
	push	af
	inc	sp
	xor	a, a
	ld	d,a
	ld	e,#0x0c
	push	de
	call	_set_win_tile_xy
	add	sp, #3
;main.c:1157: }
	ret
;main.c:1160: void hud_clear_pause() {
;	---------------------------------
; Function hud_clear_pause
; ---------------------------------
_hud_clear_pause::
;main.c:1161: set_win_tile_xy(8, 0, 0x00);
	xor	a, a
	push	af
	inc	sp
	xor	a, a
	ld	d,a
	ld	e,#0x08
	push	de
	call	_set_win_tile_xy
	add	sp, #3
;main.c:1162: set_win_tile_xy(9, 0, 0x0C);
	ld	a, #0x0c
	push	af
	inc	sp
	xor	a, a
	ld	d,a
	ld	e,#0x09
	push	de
	call	_set_win_tile_xy
	add	sp, #3
;main.c:1163: set_win_tile_xy(11, 0, 0x0D);
	ld	a, #0x0d
	push	af
	inc	sp
	xor	a, a
	ld	d,a
	ld	e,#0x0b
	push	de
	call	_set_win_tile_xy
	add	sp, #3
;main.c:1164: set_win_tile_xy(12, 0, 0x00);
	xor	a, a
	push	af
	inc	sp
	xor	a, a
	ld	d,a
	ld	e,#0x0c
	push	de
	call	_set_win_tile_xy
	add	sp, #3
;main.c:1165: hud_draw_gun();
	call	_hud_draw_gun
;main.c:1166: SHOW_SPRITES;
	ldh	a, (_LCDC_REG+0)
	or	a, #0x02
	ldh	(_LCDC_REG+0),a
;main.c:1167: }
	ret
;main.c:1169: inline void hud_draw_gun() {
;	---------------------------------
; Function hud_draw_gun
; ---------------------------------
_hud_draw_gun::
;main.c:1170: set_win_tile_xy(10, 0, 17 + plgun); // Tile offset 17
	ld	a, (#_plgun)
	add	a, #0x11
	push	af
	inc	sp
	xor	a, a
	ld	d,a
	ld	e,#0x0a
	push	de
	call	_set_win_tile_xy
	add	sp, #3
;main.c:1171: }
	ret
;main.c:1243: void stage_loop() {
;	---------------------------------
; Function stage_loop
; ---------------------------------
_stage_loop::
;main.c:1244: while(1) {
00107$:
;main.c:1246: if(stageclearflg || pllives == 0) {
	ld	a, (#_stageclearflg)
	or	a, a
	jr	NZ, 00103$
	ld	a, (#_pllives)
	or	a, a
	jr	NZ, 00104$
00103$:
;main.c:1247: if(pl->explcount == 0) {    // Waiting for explosion to finish
	ld	hl, #_pl + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0007
	add	hl, bc
	ld	a, (hl)
	or	a, a
	ret	Z
;main.c:1248: break;  // Out of game loop
00104$:
;main.c:1252: build_stage();
	call	_build_stage
;main.c:1253: incr_bkg_x_coords(4);
	ld	a, #0x04
	push	af
	inc	sp
	call	_incr_bkg_x_coords
	inc	sp
;main.c:1254: manage_hole_props();
	call	_manage_hole_props
;main.c:1255: manage_projectiles();
	call	_manage_projectiles
;main.c:1256: manage_machines();
	call	_manage_machines
;main.c:1257: manage_sound_chnls();
	call	_manage_sound_chnls
;main.c:1258: manage_player();
	call	_manage_player
;main.c:1259: wait_vbl_done();
	call	_wait_vbl_done
;main.c:1261: }
	jr	00107$
;main.c:1264: void scorpboss_loop() {
;	---------------------------------
; Function scorpboss_loop
; ---------------------------------
_scorpboss_loop::
	add	sp, #-8
;main.c:1265: UINT8 pattrn = 0, firedbull = 0, explidx = 0, gunidx;
	xor	a, a
	ldhl	sp,	#6
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl), a
;main.c:1266: while(1) {
00163$:
;main.c:1268: if(pllives == 0 && pl->explcount == 0) {
	ld	hl, #_pl
	ld	a, (hl+)
	ld	e, (hl)
	ldhl	sp,	#2
	ld	(hl+), a
;c
	ld	a, e
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0007
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#6
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#5
	ld	(hl), a
	ld	a, (#_pllives)
	or	a, a
	jr	NZ, 00102$
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jp	Z, 00170$
;main.c:1269: break;  // Game over
00102$:
;main.c:1272: if(pl->x + pl->width > 98 && pl->y + pl->height > 95 && pl->explcount == 0 && bossclearflg == 0) {
	pop	bc
	pop	hl
	push	hl
	push	bc
	inc	hl
	ld	c, (hl)
	ld	b, #0x00
;c
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0005
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ld	l, a
	ld	h, #0x00
	add	hl, bc
	ld	e, h
	ld	d, #0x00
	ld	a, #0x62
	cp	a, l
	ld	a, #0x00
	sbc	a, h
	bit	7, e
	jr	Z, 00339$
	bit	7, d
	jr	NZ, 00340$
	cp	a, a
	jr	00340$
00339$:
	bit	7, d
	jr	Z, 00340$
	scf
00340$:
	jr	NC, 00105$
	pop	bc
	pop	hl
	push	hl
	push	bc
	inc	hl
	inc	hl
	ld	c, (hl)
	ld	b, #0x00
;c
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0006
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ld	h, #0x00
	ld	l, a
	add	hl, bc
	ld	e, h
	ld	d, #0x00
	ld	a, #0x5f
	cp	a, l
	ld	a, #0x00
	sbc	a, h
	bit	7, e
	jr	Z, 00341$
	bit	7, d
	jr	NZ, 00342$
	cp	a, a
	jr	00342$
00341$:
	bit	7, d
	jr	Z, 00342$
	scf
00342$:
	jr	NC, 00105$
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	NZ, 00105$
	ld	a, (#_bossclearflg)
	or	a, a
	jr	NZ, 00105$
;main.c:1273: take_damage(pl, pl->shield);    // Collision with boss bkg
;c
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000b
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	push	af
	inc	sp
	ld	hl, #_pl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_take_damage
	add	sp, #3
00105$:
;main.c:1276: if(pattrn == 0) {  // Initial time for the player to adjust before boss attacks
	ldhl	sp,	#6
	ld	a, (hl)
	or	a, a
	jr	NZ, 00112$
;main.c:1277: if(cooldown_enemy(machines + 1, 45)) {
	ld	a, #0x2d
	push	af
	inc	sp
	ld	hl, #(_machines + 0x0011)
	push	hl
	call	_cooldown_enemy
	add	sp, #3
	ld	a, e
	or	a, a
	jr	Z, 00112$
;main.c:1278: pattrn = 1;
	ldhl	sp,	#6
	ld	(hl), #0x01
00112$:
;main.c:1282: gunidx = pattrn == 1 ? 2 : 3; // Set gun to be fired depending on pattern num
	ldhl	sp,	#6
	ld	a, (hl)
	dec	a
	ld	a, #0x01
	jr	Z, 00344$
	xor	a, a
00344$:
	ldhl	sp,	#3
	ld	(hl), a
	or	a, a
	jr	Z, 00172$
	inc	hl
	ld	(hl), #0x02
	xor	a, a
	inc	hl
	ld	(hl), a
	jr	00173$
00172$:
	ldhl	sp,	#4
	ld	(hl), #0x03
	xor	a, a
	inc	hl
	ld	(hl), a
00173$:
	ldhl	sp,	#4
	ld	a, (hl+)
;main.c:1283: if(pattrn == 1 || pattrn == 2) {  // Fire top or bottom gun
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	or	a, a
	jr	NZ, 00143$
	ldhl	sp,	#6
	ld	a, (hl)
	sub	a, #0x02
	jp	NZ,00144$
00143$:
;main.c:1284: if(is_alive(machines + gunidx) && firedbull != 3) {
	ldhl	sp,	#5
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#6
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#5
;c
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_machines
	add	hl, de
	inc	sp
	inc	sp
	push	hl
	ldhl	sp,	#0
	ld	a, (hl+)
	ld	e, (hl)
	inc	hl
	ld	(hl+), a
;main.c:831: return mch->shield > 0;
;c
	ld	a, e
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000b
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#6
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#5
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	ld	e, c
	ld	d, #0x00
	xor	a, a
	sub	a, c
	bit	7, e
	jr	Z, 00347$
	bit	7, d
	jr	NZ, 00348$
	cp	a, a
	jr	00348$
00347$:
	bit	7, d
	jr	Z, 00348$
	scf
00348$:
	jr	NC, 00118$
;main.c:1284: if(is_alive(machines + gunidx) && firedbull != 3) {
	ldhl	sp,	#7
	ld	a, (hl)
	sub	a, #0x03
	jr	Z, 00118$
;main.c:1285: if(cooldown_enemy(machines + gunidx, 20)) {
	pop	bc
	push	bc
	ld	a, #0x14
	push	af
	inc	sp
	push	bc
	call	_cooldown_enemy
	add	sp, #3
	ld	a, e
	or	a, a
	jp	Z, 00145$
;main.c:1286: fire_bigbullet(machines + gunidx, -2, 0);
	ldhl	sp,	#0
	ld	a, (hl+)
	ld	e, (hl)
	ldhl	sp,	#4
	ld	(hl+), a
	ld	(hl), e
	xor	a, a
	ld	d,a
	ld	e,#0xfe
	push	de
	dec	hl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_fire_bigbullet
	add	sp, #4
;main.c:1287: firedbull++;
	ldhl	sp,	#7
	inc	(hl)
	jp	00145$
00118$:
;main.c:1289: } else if(cooldown_enemy(machines + gunidx, 30)) {  // Cooldown until next attack
	ldhl	sp,	#0
	ld	a, (hl+)
	ld	e, (hl)
	ldhl	sp,	#4
	ld	(hl+), a
	ld	(hl), e
	ld	a, #0x1e
	push	af
	inc	sp
	dec	hl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_cooldown_enemy
	add	sp, #3
	ld	a, e
	or	a, a
	jp	Z, 00145$
;main.c:1290: firedbull = 0;
	xor	a, a
	ldhl	sp,	#7
;main.c:1291: pattrn++;
	ld	(hl-), a
	inc	(hl)
	jp	00145$
00144$:
;main.c:1293: } else if(pattrn == 3) {  // Stinger pattern
	ldhl	sp,	#6
	ld	a, (hl)
	sub	a, #0x03
	jp	NZ,00145$
;main.c:1294: if(is_alive(machines + 1)) {
;main.c:831: return mch->shield > 0;
	ld	hl, #(_machines + 0x001c)
	ld	c, (hl)
	ld	e, c
	ld	d, #0x00
	xor	a, a
	sub	a, c
	bit	7, e
	jr	Z, 00352$
	bit	7, d
	jr	NZ, 00353$
	cp	a, a
	jr	00353$
00352$:
	bit	7, d
	jr	Z, 00353$
	scf
00353$:
	jp	NC, 00139$
;main.c:1294: if(is_alive(machines + 1)) {
;main.c:1295: machines[1].groundflg = pl->groundflg;
	ld	hl, #_pl + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, (bc)
	ld	(#(_machines + 0x0011)),a
;main.c:1296: if(machines[1].cyccount == 0) {
	ld	a, (#(_machines + 0x0019) + 0)
	ldhl	sp,	#5
	ld	(hl), a
	ldhl	sp,	#5
	ld	a, (hl)
	or	a, a
	jr	NZ, 00136$
;main.c:1297: move_enemy(machines + 1, -2, 2);
	ld	de, #0x02fe
	push	de
	ld	hl, #(_machines + 0x0011)
	push	hl
	call	_move_enemy
	add	sp, #4
;main.c:1298: if(machines[1].y == 114) { // Rewrite
	ld	a, (#(_machines + 0x0013) + 0)
	sub	a, #0x72
	jr	NZ, 00145$
;main.c:1299: machines[1].cyccount++;
	ld	a, (#(_machines + 0x0019) + 0)
	inc	a
	ld	(#(_machines + 0x0019)),a
	jr	00145$
00136$:
;main.c:1301: } else if(machines[1].cyccount == 1) {
	ldhl	sp,	#5
	ld	a, (hl)
	dec	a
	jr	NZ, 00133$
;main.c:1302: move_enemy(machines + 1, -4, 0);
	xor	a, a
	ld	d,a
	ld	e,#0xfc
	push	de
	ld	hl, #(_machines + 0x0011)
	push	hl
	call	_move_enemy
	add	sp, #4
;main.c:1303: if(machines[1].x < 16) {
	ld	a, (#(_machines + 0x0012) + 0)
	sub	a, #0x10
	jr	NC, 00145$
;main.c:1304: machines[1].cyccount++;
	ld	a, (#(_machines + 0x0019) + 0)
	inc	a
	ld	(#(_machines + 0x0019)),a
	jr	00145$
00133$:
;main.c:1306: } else if(machines[1].cyccount == 2) {
	ldhl	sp,	#5
	ld	a, (hl)
	sub	a, #0x02
	jr	NZ, 00130$
;main.c:1307: move_enemy(machines + 1, 2, -2);
	ld	de, #0xfe02
	push	de
	ld	hl, #(_machines + 0x0011)
	push	hl
	call	_move_enemy
	add	sp, #4
;main.c:1308: if(machines[1].y == 96) {
	ld	a, (#(_machines + 0x0013) + 0)
	sub	a, #0x60
	jr	NZ, 00145$
;main.c:1309: machines[1].cyccount++;
	ld	a, (#(_machines + 0x0019) + 0)
	inc	a
	ld	(#(_machines + 0x0019)),a
	jr	00145$
00130$:
;main.c:1312: move_enemy(machines + 1, 4, 0);
	xor	a, a
	ld	d,a
	ld	e,#0x04
	push	de
	ld	hl, #(_machines + 0x0011)
	push	hl
	call	_move_enemy
	add	sp, #4
;main.c:1313: if(machines[1].x == 121) {
	ld	a, (#(_machines + 0x0012) + 0)
	sub	a, #0x79
	jr	NZ, 00145$
;main.c:1314: machines[1].cyccount = 0;
	ld	hl, #(_machines + 0x0019)
	ld	(hl), #0x00
;main.c:1315: pattrn = 1;  // Reset boss pattern
	ldhl	sp,	#6
	ld	(hl), #0x01
	jr	00145$
00139$:
;main.c:1319: pattrn = 1;
	ldhl	sp,	#6
	ld	(hl), #0x01
00145$:
;main.c:1323: manage_projectiles();
	call	_manage_projectiles
;main.c:1324: manage_machines();
	call	_manage_machines
;main.c:1326: if(bossclearflg == 0 && (!(is_alive(machines + 1) || is_alive(machines + 2) || is_alive(machines + 3))) ) {
	ld	a, (#_bossclearflg)
	or	a, a
	jr	NZ, 00148$
;main.c:831: return mch->shield > 0;
	ld	hl, #(_machines + 0x0011) + 11
	ld	c, (hl)
	ld	e, c
	ld	d, #0x00
	xor	a, a
	sub	a, c
	bit	7, e
	jr	Z, 00364$
	bit	7, d
	jr	NZ, 00365$
	cp	a, a
	jr	00365$
00364$:
	bit	7, d
	jr	Z, 00365$
	scf
00365$:
	jr	C, 00148$
;main.c:1326: if(bossclearflg == 0 && (!(is_alive(machines + 1) || is_alive(machines + 2) || is_alive(machines + 3))) ) {
;main.c:831: return mch->shield > 0;
	ld	hl, #(_machines + 0x0022) + 11
	ld	c, (hl)
	ld	e, c
	ld	d, #0x00
	xor	a, a
	sub	a, c
	bit	7, e
	jr	Z, 00366$
	bit	7, d
	jr	NZ, 00367$
	cp	a, a
	jr	00367$
00366$:
	bit	7, d
	jr	Z, 00367$
	scf
00367$:
	jr	C, 00148$
;main.c:1326: if(bossclearflg == 0 && (!(is_alive(machines + 1) || is_alive(machines + 2) || is_alive(machines + 3))) ) {
;main.c:831: return mch->shield > 0;
	ld	hl, #(_machines + 0x0033) + 11
	ld	c, (hl)
	ld	e, c
	ld	d, #0x00
	xor	a, a
	sub	a, c
	bit	7, e
	jr	Z, 00368$
	bit	7, d
	jr	NZ, 00369$
	cp	a, a
	jr	00369$
00368$:
	bit	7, d
	jr	Z, 00369$
	scf
00369$:
	jr	C, 00148$
;main.c:1326: if(bossclearflg == 0 && (!(is_alive(machines + 1) || is_alive(machines + 2) || is_alive(machines + 3))) ) {
;main.c:1327: bossclearflg = 1;
	ld	hl, #_bossclearflg
	ld	(hl), #0x01
00148$:
;main.c:1330: if(bossclearflg == 1 && machines[1].explcount == 0 && machines[2].explcount == 0 && machines[3].explcount == 0 ) {
	ld	a, (#_bossclearflg)
	dec	a
	jr	NZ, 00158$
	ld	a, (#(_machines + 0x0018) + 0)
	or	a, a
	jr	NZ, 00158$
	ld	a, (#(_machines + 0x0029) + 0)
	or	a, a
	jr	NZ, 00158$
	ld	a, (#(_machines + 0x003a) + 0)
	or	a, a
	jr	NZ, 00158$
;main.c:1331: if(lockmvmnt == 2) {    // Wait until the end of the jumping animation
	ld	a, (#_lockmvmnt)
	sub	a, #0x02
	jr	NZ, 00155$
;main.c:1332: anim_jump();
	call	_anim_jump
	jr	00158$
00155$:
;main.c:1333: } else if(pl->explcount == 0) {
	ld	hl, #_pl + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0007
	add	hl, bc
	ld	a, (hl)
	or	a, a
	jr	NZ, 00158$
;main.c:1334: clear_all_projectiles();
	call	_clear_all_projectiles
;main.c:1335: break;  // Boss cleared
	jr	00170$
00158$:
;main.c:1339: manage_sound_chnls();
	call	_manage_sound_chnls
;main.c:1340: manage_player();
	call	_manage_player
;main.c:1341: wait_vbl_done();
	call	_wait_vbl_done
	jp	00163$
00170$:
;main.c:1343: }
	add	sp, #8
	ret
;main.c:1346: void pause_game() {
;	---------------------------------
; Function pause_game
; ---------------------------------
_pause_game::
;main.c:1347: if(machines[1].type != 6) {  // Hide sprites only during stages
	ld	a, (#(_machines + 0x001d) + 0)
	sub	a, #0x06
	jr	Z, 00102$
;main.c:1348: HIDE_SPRITES;
	ldh	a, (_LCDC_REG+0)
	and	a, #0xfd
	ldh	(_LCDC_REG+0),a
00102$:
;main.c:1350: stop_song();
	call	_stop_song
;main.c:1351: hud_draw_pause();
	call	_hud_draw_pause
;main.c:1352: se_pause();
	call	_se_pause
;main.c:1353: custom_delay(10);
	ld	a, #0x0a
	push	af
	inc	sp
	call	_custom_delay
	inc	sp
;main.c:1354: waitpad(J_START);
	ld	a, #0x80
	push	af
	inc	sp
	call	_waitpad
	inc	sp
;main.c:1355: custom_delay(10);
	ld	a, #0x0a
	push	af
	inc	sp
	call	_custom_delay
	inc	sp
;main.c:1356: hud_clear_pause();
	call	_hud_clear_pause
;main.c:1357: if(stageclearflg == 0) {
	ld	a, (#_stageclearflg)
	or	a, a
	jr	NZ, 00104$
;main.c:1358: play_song(crntstage->theme);
	ld	hl, #_crntstage + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x000d
	add	hl, bc
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	push	bc
	call	_play_song
	add	sp, #2
	ret
00104$:
;main.c:1360: play_song(&bosstheme);
	ld	hl, #_bosstheme
	push	hl
	call	_play_song
	add	sp, #2
;main.c:1362: }
	ret
;main.c:1368: void clear_all_projectiles() {
;	---------------------------------
; Function clear_all_projectiles
; ---------------------------------
_clear_all_projectiles::
;main.c:1369: for(pjctptr = projectiles; pjctptr <= projectiles + pjctllimit; pjctptr++) {
	ld	hl, #_pjctptr
	ld	a, #<(_projectiles)
	ld	(hl+), a
	ld	(hl), #>(_projectiles)
00105$:
	ld	hl, #_pjctllimit
	ld	l, (hl)
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	de, #_projectiles
	add	hl, de
	ld	c, l
	ld	b, h
	ld	hl, #_pjctptr
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	ret	C
;main.c:1370: if(pjctptr->oam != NULL) {
	ld	hl, #_pjctptr + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0006
	add	hl, bc
	ld	a, (hl+)
	ld	c, (hl)
	or	a, c
	jr	Z, 00106$
;main.c:1371: destroy_projectile(pjctptr);
	ld	hl, #_pjctptr
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_destroy_projectile
	add	sp, #2
00106$:
;main.c:1369: for(pjctptr = projectiles; pjctptr <= projectiles + pjctllimit; pjctptr++) {
	ld	hl, #_pjctptr
	ld	a, (hl)
	add	a, #0x08
	ld	(hl+), a
	ld	a, (hl)
	adc	a, #0x00
	ld	(hl), a
;main.c:1374: }
	jr	00105$
;main.c:1377: void anim_stage_start() {
;	---------------------------------
; Function anim_stage_start
; ---------------------------------
_anim_stage_start::
;main.c:1378: anim_reverse_blackout();
	call	_anim_reverse_blackout
;main.c:1379: do {
00101$:
;main.c:1380: move_machine(pl, 1, 0);
	xor	a, a
	ld	d,a
	ld	e,#0x01
	push	de
	ld	hl, #_pl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_move_machine
	add	sp, #4
;main.c:1381: wait_vbl_done();
	call	_wait_vbl_done
;main.c:1382: } while(pl->x != 16);
	ld	hl, #_pl + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	ld	a, (bc)
	sub	a, #0x10
	jr	NZ, 00101$
;main.c:1383: }
	ret
;main.c:1386: void anim_stage_end() {
;	---------------------------------
; Function anim_stage_end
; ---------------------------------
_anim_stage_end::
;main.c:1387: clear_all_projectiles();
	call	_clear_all_projectiles
;main.c:1388: pl->cyccount = 0;
	ld	hl, #_pl + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0008
	add	hl, bc
	ld	(hl), #0x00
;main.c:1389: while(1) {
00108$:
;main.c:1390: build_road();
	call	_build_road
;main.c:1391: incr_bkg_x_coords(5);
	ld	a, #0x05
	push	af
	inc	sp
	call	_incr_bkg_x_coords
	inc	sp
;main.c:1392: if(lockmvmnt == 2) {    // Wait until the end of the jumping animation
	ld	a, (#_lockmvmnt)
	sub	a, #0x02
	jr	NZ, 00105$
;main.c:1393: anim_jump();
	call	_anim_jump
	jr	00106$
00105$:
;main.c:1394: } else if(pl->x < 168) {
	ld	hl, #_pl + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	ld	a, (bc)
	sub	a, #0xa8
	ret	NC
;main.c:1395: move_machine(pl, 1, 0);
	xor	a, a
	ld	d,a
	ld	e,#0x01
	push	de
	dec	hl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_move_machine
	add	sp, #4
;main.c:1397: break;  // Animation has finished
00106$:
;main.c:1399: wait_vbl_done();
	call	_wait_vbl_done
;main.c:1401: }
	jr	00108$
;main.c:1459: void upd_mute_chnl_cycles(UINT8 chnum) {    // Checks if a muted channel needs to be unmuted
;	---------------------------------
; Function upd_mute_chnl_cycles
; ---------------------------------
_upd_mute_chnl_cycles::
;main.c:1460: if(chmutedcyccnt[chnum] != 0) {
	ld	bc, #_chmutedcyccnt+0
	ldhl	sp,	#2
	ld	l, (hl)
	ld	h, #0x00
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
	or	a, a
	jr	Z, 00102$
;main.c:1461: chmutedcyccnt[chnum]--;     // Countdown untul unmute
	dec	a
	ld	(bc), a
	ret
00102$:
;main.c:1463: hUGE_mute_channel(chnum, HT_CH_PLAY);
	push	bc
	xor	a, a
	push	af
	inc	sp
	ldhl	sp,	#5
	ld	a, (hl)
	push	af
	inc	sp
	call	_hUGE_mute_channel
	add	sp, #2
	pop	bc
;main.c:1464: chmutedcyccnt[chnum] = 255;
	ld	a, #0xff
	ld	(bc), a
;main.c:1466: }
	ret
;main.c:1469: void se_fall_in_hole() {
;	---------------------------------
; Function se_fall_in_hole
; ---------------------------------
_se_fall_in_hole::
;main.c:1470: mute_music_pl_chnl(0);
	xor	a, a
	push	af
	inc	sp
	call	_mute_music_pl_chnl
	inc	sp
;main.c:1471: NR10_REG = 0x1F;
	ld	a, #0x1f
	ldh	(_NR10_REG+0),a
;main.c:1472: NR11_REG = 0x81;
	ld	a, #0x81
	ldh	(_NR11_REG+0),a
;main.c:1473: NR12_REG = 0x97;
	ld	a, #0x97
	ldh	(_NR12_REG+0),a
;main.c:1474: NR13_REG = 0xF7;
	ld	a, #0xf7
	ldh	(_NR13_REG+0),a
;main.c:1475: NR14_REG = 0x85;
	ld	a, #0x85
	ldh	(_NR14_REG+0),a
;main.c:1476: }
	ret
;main.c:1479: void se_fire_bullet() {
;	---------------------------------
; Function se_fire_bullet
; ---------------------------------
_se_fire_bullet::
;main.c:1480: mute_music_pl_chnl(3);
	ld	a, #0x03
	push	af
	inc	sp
	call	_mute_music_pl_chnl
	inc	sp
;main.c:1481: NR41_REG = 0x00;
	ld	a, #0x00
	ldh	(_NR41_REG+0),a
;main.c:1482: NR42_REG = 0xD4;
	ld	a, #0xd4
	ldh	(_NR42_REG+0),a
;main.c:1483: NR43_REG = 0x52;
	ld	a, #0x52
	ldh	(_NR43_REG+0),a
;main.c:1484: NR44_REG = 0xC0;
	ld	a, #0xc0
	ldh	(_NR44_REG+0),a
;main.c:1485: }
	ret
;main.c:1488: void se_fire_laser() {
;	---------------------------------
; Function se_fire_laser
; ---------------------------------
_se_fire_laser::
;main.c:1489: mute_music_pl_chnl(0);
	xor	a, a
	push	af
	inc	sp
	call	_mute_music_pl_chnl
	inc	sp
;main.c:1490: NR10_REG = 0x2E;
	ld	a, #0x2e
	ldh	(_NR10_REG+0),a
;main.c:1491: NR11_REG = 0xC1;
	ld	a, #0xc1
	ldh	(_NR11_REG+0),a
;main.c:1492: NR12_REG = 0xD2;
	ld	a, #0xd2
	ldh	(_NR12_REG+0),a
;main.c:1493: NR13_REG = 0x54;
	ld	a, #0x54
	ldh	(_NR13_REG+0),a
;main.c:1494: NR14_REG = 0x87;
	ld	a, #0x87
	ldh	(_NR14_REG+0),a
;main.c:1495: }
	ret
;main.c:1498: void se_drop_bomb() {
;	---------------------------------
; Function se_drop_bomb
; ---------------------------------
_se_drop_bomb::
;main.c:1499: mute_music_pl_chnl(0);
	xor	a, a
	push	af
	inc	sp
	call	_mute_music_pl_chnl
	inc	sp
;main.c:1500: NR10_REG = 0x7F;
	ld	a, #0x7f
	ldh	(_NR10_REG+0),a
;main.c:1501: NR11_REG = 0x81;
	ld	a, #0x81
	ldh	(_NR11_REG+0),a
;main.c:1502: NR12_REG = 0xD7;
	ld	a, #0xd7
	ldh	(_NR12_REG+0),a
;main.c:1503: NR13_REG = 0x55;
	ld	a, #0x55
	ldh	(_NR13_REG+0),a
;main.c:1504: NR14_REG = 0x87;
	ld	a, #0x87
	ldh	(_NR14_REG+0),a
;main.c:1505: }
	ret
;main.c:1508: void se_explode() {
;	---------------------------------
; Function se_explode
; ---------------------------------
_se_explode::
;main.c:1509: mute_music_pl_chnl(3);
	ld	a, #0x03
	push	af
	inc	sp
	call	_mute_music_pl_chnl
	inc	sp
;main.c:1510: NR41_REG = 0x04;
	ld	a, #0x04
	ldh	(_NR41_REG+0),a
;main.c:1511: NR42_REG = 0xD5;
	ld	a, #0xd5
	ldh	(_NR42_REG+0),a
;main.c:1512: NR43_REG = 0x55;
	ld	a, #0x55
	ldh	(_NR43_REG+0),a
;main.c:1513: NR44_REG = 0x80;
	ld	a, #0x80
	ldh	(_NR44_REG+0),a
;main.c:1514: }
	ret
;main.c:1517: void se_get_hit() {
;	---------------------------------
; Function se_get_hit
; ---------------------------------
_se_get_hit::
;main.c:1518: mute_music_pl_chnl(1);
	ld	a, #0x01
	push	af
	inc	sp
	call	_mute_music_pl_chnl
	inc	sp
;main.c:1519: NR21_REG = 0x40;
	ld	a, #0x40
	ldh	(_NR21_REG+0),a
;main.c:1520: NR22_REG = 0xD1;
	ld	a, #0xd1
	ldh	(_NR22_REG+0),a
;main.c:1521: NR23_REG = 0xCD;
	ld	a, #0xcd
	ldh	(_NR23_REG+0),a
;main.c:1522: NR24_REG = 0xC7;
	ld	a, #0xc7
	ldh	(_NR24_REG+0),a
;main.c:1523: }
	ret
;main.c:1526: void se_jump() {
;	---------------------------------
; Function se_jump
; ---------------------------------
_se_jump::
;main.c:1527: mute_music_pl_chnl(0);
	xor	a, a
	push	af
	inc	sp
	call	_mute_music_pl_chnl
	inc	sp
;main.c:1528: NR10_REG = 0x75;
	ld	a, #0x75
	ldh	(_NR10_REG+0),a
;main.c:1529: NR11_REG = 0x80;
	ld	a, #0x80
	ldh	(_NR11_REG+0),a
;main.c:1530: NR12_REG = 0xD2;
	ld	a, #0xd2
	ldh	(_NR12_REG+0),a
;main.c:1531: NR13_REG = 0x46;
	ld	a, #0x46
	ldh	(_NR13_REG+0),a
;main.c:1532: NR14_REG = 0x85;
	ld	a, #0x85
	ldh	(_NR14_REG+0),a
;main.c:1533: }
	ret
;main.c:1536: void se_pause() {
;	---------------------------------
; Function se_pause
; ---------------------------------
_se_pause::
;main.c:1537: NR10_REG = 0x74;
	ld	a, #0x74
	ldh	(_NR10_REG+0),a
;main.c:1538: NR11_REG = 0x80;
	ld	a, #0x80
	ldh	(_NR11_REG+0),a
;main.c:1539: NR12_REG = 0xD7;
	ld	a, #0xd7
	ldh	(_NR12_REG+0),a
;main.c:1540: NR13_REG = 0x0E;
	ld	a, #0x0e
	ldh	(_NR13_REG+0),a
;main.c:1541: NR14_REG = 0x86;
	ld	a, #0x86
	ldh	(_NR14_REG+0),a
;main.c:1542: }
	ret
;main.c:1545: void se_wpn_upgrd() {
;	---------------------------------
; Function se_wpn_upgrd
; ---------------------------------
_se_wpn_upgrd::
;main.c:1546: mute_music_pl_chnl(0);
	xor	a, a
	push	af
	inc	sp
	call	_mute_music_pl_chnl
	inc	sp
;main.c:1547: NR10_REG = 0x17;
	ld	a, #0x17
	ldh	(_NR10_REG+0),a
;main.c:1548: NR11_REG = 0x7A;
	ld	a, #0x7a
	ldh	(_NR11_REG+0),a
;main.c:1549: NR12_REG = 0xFF;
	ld	a, #0xff
	ldh	(_NR12_REG+0),a
;main.c:1550: NR13_REG = 0x75;
	ld	a, #0x75
	ldh	(_NR13_REG+0),a
;main.c:1551: NR14_REG = 0x85;
	ld	a, #0x85
	ldh	(_NR14_REG+0),a
;main.c:1552: }
	ret
;main.c:1601: void mute_song() {
;	---------------------------------
; Function mute_song
; ---------------------------------
_mute_song::
;main.c:1602: hUGE_mute_channel(HT_CH1, HT_CH_MUTE);
	ld	a, #0x01
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_hUGE_mute_channel
	add	sp, #2
;main.c:1603: hUGE_mute_channel(HT_CH2, HT_CH_MUTE);
	ld	de, #0x0101
	push	de
	call	_hUGE_mute_channel
	add	sp, #2
;main.c:1604: hUGE_mute_channel(HT_CH3, HT_CH_MUTE);
	ld	de, #0x0102
	push	de
	call	_hUGE_mute_channel
	add	sp, #2
;main.c:1605: hUGE_mute_channel(HT_CH4, HT_CH_MUTE);
	ld	de, #0x0103
	push	de
	call	_hUGE_mute_channel
	add	sp, #2
;main.c:1606: }
	ret
;main.c:1608: void unmute_song() {
;	---------------------------------
; Function unmute_song
; ---------------------------------
_unmute_song::
;main.c:1609: hUGE_mute_channel(HT_CH1, HT_CH_PLAY);
	xor	a, a
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_hUGE_mute_channel
	add	sp, #2
;main.c:1610: hUGE_mute_channel(HT_CH2, HT_CH_PLAY);
	xor	a, a
	ld	d,a
	ld	e,#0x01
	push	de
	call	_hUGE_mute_channel
	add	sp, #2
;main.c:1611: hUGE_mute_channel(HT_CH3, HT_CH_PLAY);
	xor	a, a
	ld	d,a
	ld	e,#0x02
	push	de
	call	_hUGE_mute_channel
	add	sp, #2
;main.c:1612: hUGE_mute_channel(HT_CH4, HT_CH_PLAY);
	xor	a, a
	ld	d,a
	ld	e,#0x03
	push	de
	call	_hUGE_mute_channel
	add	sp, #2
;main.c:1613: }
	ret
	.area _CODE_0
	.area _CABS (ABS)
