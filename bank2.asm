;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.0 #12072 (MINGW32)
;--------------------------------------------------------
	.module bank2
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _se_charge_gun
	.globl _build_boss_road
	.globl _incr_bkg_x_coords
	.globl _move_machine
	.globl _incr_oam_sprite_tile_idx
	.globl _init_stage
	.globl _manage_player
	.globl _manage_sound_chnls
	.globl _clear_all_projectiles
	.globl _anim_jump
	.globl _manage_machines
	.globl _manage_projectiles
	.globl _fire_projctl_aimed_horz
	.globl _fire_projctl_aimed_vert
	.globl _fire_projctl
	.globl _cooldown_enemy
	.globl _is_alive
	.globl _init_machine_props
	.globl _set_sprite_data
	.globl _set_bkg_tiles
	.globl _set_bkg_data
	.globl _wait_vbl_done
	.globl _mech
	.globl _chargeidx
	.globl _fronthboffx
	.globl _backhboffx
	.globl _mechprops
	.globl _mechbackwtiles
	.globl _mechforwtiles
	.globl _stage2objs
	.globl _stage2road
	.globl _citymap
	.globl _citytiles
	.globl _scorpbossexpl
	.globl _stage1objs
	.globl _stage1road
	.globl _stingprops
	.globl _scorpgunprops
	.globl _scorpbossmap
	.globl _desertmap
	.globl _scorpbosstiles
	.globl _deserttiles
	.globl _hudmap
	.globl _cloudmap
	.globl _holeendmap
	.globl _holemap
	.globl _holestartmap
	.globl _goodroadmap
	.globl _projectiletiles
	.globl _playerspritetiles
	.globl _cloudtiles
	.globl _enemyspritetiles
	.globl _hudtiles
	.globl _bossspritetiles
	.globl _roadtiles
	.globl b_init_scorpboss_gun
	.globl _init_scorpboss_gun
	.globl b_init_scorpboss
	.globl _init_scorpboss
	.globl b_set_stinger_tiles
	.globl _set_stinger_tiles
	.globl b_set_pincer_tiles
	.globl _set_pincer_tiles
	.globl b_scorpboss_hit_anim
	.globl _scorpboss_hit_anim
	.globl b_scorpboss_loop
	.globl _scorpboss_loop
	.globl b_move_mech
	.globl _move_mech
	.globl b_init_mechboss
	.globl _init_mechboss
	.globl b_flip_mech
	.globl _flip_mech
	.globl b_charge_gun
	.globl _charge_gun
	.globl b_mech_hit_anim
	.globl _mech_hit_anim
	.globl b_mechboss_loop
	.globl _mechboss_loop
	.globl b_mech_clear_sequence
	.globl _mech_clear_sequence
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_chargeidx::
	.ds 1
_mech::
	.ds 2
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
;stages/stage2.c:24: UINT8 chargeidx = 255;    // Charge sprite tile index
	ld	hl, #_chargeidx
	ld	(hl), #0xff
;stages/stage2.c:25: Machine * mech = machines + 1;
	ld	hl, #_mech
	ld	(hl), #<((_machines + 0x0011))
	inc	hl
	ld	(hl), #>((_machines + 0x0011))
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE_2
;stages/stage1.c:53: void init_scorpboss_gun(UINT8 x, UINT8 y) BANKED {
;	---------------------------------
; Function init_scorpboss_gun
; ---------------------------------
	b_init_scorpboss_gun	= 2
_init_scorpboss_gun::
;stages/stage1.c:54: init_machine_props(x, y, scorpgunprops);
	ld	hl, #_scorpgunprops
	push	hl
	ldhl	sp,	#9
	ld	a, (hl)
	push	af
	inc	sp
	dec	hl
	ld	a, (hl)
	push	af
	inc	sp
	call	_init_machine_props
	add	sp, #4
;stages/stage1.c:55: set_pincer_tiles(crntenemy - 1, 0);
	ld	hl, #_crntenemy
	ld	a, (hl)
	add	a, #0xef
	ld	c, a
	inc	hl
	ld	a, (hl)
	adc	a, #0xff
	ld	b, a
	xor	a, a
	push	af
	inc	sp
	push	bc
	ld	e, #b_set_pincer_tiles
	ld	hl, #_set_pincer_tiles
	call	___sdcc_bcall_ehl
	add	sp, #3
;stages/stage1.c:56: }
	ret
_roadtiles:
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
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
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
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x3f	; 63
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
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x3f	; 63
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
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0xf8	; 248
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
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x3f	; 63
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
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0xf8	; 248
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
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x24	; 36
	.db #0xdb	; 219
	.db #0x59	; 89	'Y'
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x05	; 5
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x05	; 5
	.db #0x6a	; 106	'j'
	.db #0xdf	; 223
	.db #0x6d	; 109	'm'
	.db #0xbf	; 191
	.db #0x5f	; 95
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x7f	; 127
	.db #0xbf	; 191
	.db #0x7f	; 127
	.db #0xbf	; 191
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0x0b	; 11
	.db #0x0d	; 13
	.db #0x0e	; 14
	.db #0x0b	; 11
	.db #0x0f	; 15
	.db #0x09	; 9
	.db #0x1b	; 27
	.db #0x17	; 23
	.db #0x15	; 21
	.db #0x1f	; 31
	.db #0x17	; 23
	.db #0x1b	; 27
	.db #0x2f	; 47
	.db #0x37	; 55	'7'
	.db #0x23	; 35
	.db #0x2f	; 47
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x5f	; 95
	.db #0x6f	; 111	'o'
	.db #0x47	; 71	'G'
	.db #0x7f	; 127
	.db #0x6f	; 111	'o'
	.db #0x5f	; 95
	.db #0xbf	; 191
	.db #0xdf	; 223
	.db #0xdf	; 223
	.db #0xbf	; 191
	.db #0xbf	; 191
	.db #0x7f	; 127
	.db #0x5f	; 95
	.db #0xbf	; 191
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x06	; 6
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x05	; 5
	.db #0x06	; 6
	.db #0x0d	; 13
	.db #0x0b	; 11
	.db #0x0e	; 14
	.db #0xfb	; 251
	.db #0x0b	; 11
	.db #0xfd	; 253
	.db #0xff	; 255
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x1b	; 27
	.db #0x17	; 23
	.db #0x15	; 21
	.db #0x1b	; 27
	.db #0x2f	; 47
	.db #0x37	; 55	'7'
	.db #0x3b	; 59
	.db #0x2f	; 47
	.db #0x2f	; 47
	.db #0x37	; 55	'7'
	.db #0x6f	; 111	'o'
	.db #0x5f	; 95
	.db #0x57	; 87	'W'
	.db #0x6f	; 111	'o'
	.db #0xdf	; 223
	.db #0xbf	; 191
	.db #0xbf	; 191
	.db #0xdf	; 223
	.db #0x1f	; 31
	.db #0x3f	; 63
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xb7	; 183
	.db #0xdb	; 219
	.db #0xee	; 238
	.db #0x7e	; 126
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0xf0	; 240
	.db #0xfc	; 252
	.db #0xf0	; 240
	.db #0xf8	; 248
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xff	; 255
	.db #0xf0	; 240
	.db #0xff	; 255
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x59	; 89	'Y'
	.db #0xae	; 174
	.db #0xb6	; 182
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
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
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_bossspritetiles:
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x6f	; 111	'o'
	.db #0x53	; 83	'S'
	.db #0xdb	; 219
	.db #0xa5	; 165
	.db #0xa1	; 161
	.db #0xdf	; 223
	.db #0xdb	; 219
	.db #0xa5	; 165
	.db #0x6e	; 110	'n'
	.db #0x52	; 82	'R'
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x22	; 34
	.db #0x3e	; 62
	.db #0x14	; 20
	.db #0x1c	; 28
	.db #0x1c	; 28
	.db #0x14	; 20
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7c	; 124
	.db #0xfc	; 252
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x08	; 8
	.db #0x1f	; 31
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x7c	; 124
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3e	; 62
	.db #0x00	; 0
	.db #0x6f	; 111	'o'
	.db #0x10	; 16
	.db #0xdb	; 219
	.db #0x24	; 36
	.db #0xa1	; 161
	.db #0x5e	; 94
	.db #0xdb	; 219
	.db #0x24	; 36
	.db #0x6e	; 110	'n'
	.db #0x10	; 16
	.db #0x3e	; 62
	.db #0x00	; 0
	.db #0x3e	; 62
	.db #0x00	; 0
	.db #0x14	; 20
	.db #0x08	; 8
	.db #0x1c	; 28
	.db #0x00	; 0
	.db #0x0c	; 12
	.db #0x00	; 0
	.db #0x08	; 8
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7c	; 124
	.db #0x80	; 128
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x08	; 8
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x7c	; 124
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x1d	; 29
	.db #0x1d	; 29
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0xf7	; 247
	.db #0xee	; 238
	.db #0xe3	; 227
	.db #0xdf	; 223
	.db #0x7e	; 126
	.db #0x79	; 121	'y'
	.db #0x3f	; 63
	.db #0x5e	; 94
	.db #0x0f	; 15
	.db #0xfd	; 253
	.db #0xaf	; 175
	.db #0x56	; 86	'V'
	.db #0x45	; 69	'E'
	.db #0xb7	; 183
	.db #0xac	; 172
	.db #0x4f	; 79	'O'
	.db #0x0f	; 15
	.db #0x0b	; 11
	.db #0x0f	; 15
	.db #0x09	; 9
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x20	; 32
	.db #0xa0	; 160
	.db #0xf0	; 240
	.db #0x10	; 16
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0x90	; 144
	.db #0x70	; 112	'p'
	.db #0xd8	; 216
	.db #0x38	; 56	'8'
	.db #0xf8	; 248
	.db #0xd8	; 216
	.db #0x78	; 120	'x'
	.db #0xf8	; 248
	.db #0x18	; 24
	.db #0xf8	; 248
	.db #0xcc	; 204
	.db #0xfc	; 252
	.db #0xa4	; 164
	.db #0xfc	; 252
	.db #0x7a	; 122	'z'
	.db #0xfe	; 254
	.db #0xed	; 237
	.db #0xab	; 171
	.db #0xe6	; 230
	.db #0x24	; 36
	.db #0x0f	; 15
	.db #0x09	; 9
	.db #0x1f	; 31
	.db #0x12	; 18
	.db #0x1f	; 31
	.db #0x13	; 19
	.db #0x1e	; 30
	.db #0x1b	; 27
	.db #0x17	; 23
	.db #0x1f	; 31
	.db #0x24	; 36
	.db #0x3c	; 60
	.db #0x32	; 50	'2'
	.db #0x3e	; 62
	.db #0x0e	; 14
	.db #0x0e	; 14
	.db #0xe0	; 224
	.db #0x20	; 32
	.db #0xc0	; 192
	.db #0x40	; 64
	.db #0xc0	; 192
	.db #0x40	; 64
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x20	; 32
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x1d	; 29
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0xf7	; 247
	.db #0x08	; 8
	.db #0xe3	; 227
	.db #0x1c	; 28
	.db #0x7e	; 126
	.db #0x01	; 1
	.db #0x3f	; 63
	.db #0x40	; 64
	.db #0x0f	; 15
	.db #0xf0	; 240
	.db #0xaf	; 175
	.db #0x50	; 80	'P'
	.db #0x45	; 69	'E'
	.db #0xb2	; 178
	.db #0xac	; 172
	.db #0x43	; 67	'C'
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x80	; 128
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x90	; 144
	.db #0x60	; 96
	.db #0xd8	; 216
	.db #0x20	; 32
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x78	; 120	'x'
	.db #0x80	; 128
	.db #0x18	; 24
	.db #0xe0	; 224
	.db #0xcc	; 204
	.db #0x30	; 48	'0'
	.db #0xa4	; 164
	.db #0x58	; 88	'X'
	.db #0x7a	; 122	'z'
	.db #0x84	; 132
	.db #0xed	; 237
	.db #0x02	; 2
	.db #0xe6	; 230
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x1e	; 30
	.db #0x01	; 1
	.db #0x17	; 23
	.db #0x08	; 8
	.db #0x24	; 36
	.db #0x18	; 24
	.db #0x32	; 50	'2'
	.db #0x0c	; 12
	.db #0x0e	; 14
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0xc0	; 192
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0xb8	; 184
	.db #0x98	; 152
	.db #0xec	; 236
	.db #0x9c	; 156
	.db #0x50	; 80	'P'
	.db #0x70	; 112	'p'
	.db #0x68	; 104	'h'
	.db #0x68	; 104	'h'
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x9e	; 158
	.db #0x9e	; 158
	.db #0x9c	; 156
	.db #0x84	; 132
	.db #0x66	; 102	'f'
	.db #0x5e	; 94
	.db #0x64	; 100	'd'
	.db #0x5c	; 92
	.db #0x7a	; 122	'z'
	.db #0x7a	; 122	'z'
	.db #0x54	; 84	'T'
	.db #0x54	; 84	'T'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x65	; 101	'e'
	.db #0x65	; 101	'e'
	.db #0x9e	; 158
	.db #0x9a	; 154
	.db #0x8e	; 142
	.db #0x86	; 134
	.db #0x4d	; 77	'M'
	.db #0x43	; 67	'C'
	.db #0x79	; 121	'y'
	.db #0x47	; 71	'G'
	.db #0xf2	; 242
	.db #0xae	; 174
	.db #0x66	; 102	'f'
	.db #0x7e	; 126
	.db #0x99	; 153
	.db #0x99	; 153
_hudtiles:
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
	.db #0x1c	; 28
	.db #0x1c	; 28
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x2a	; 42
	.db #0x2a	; 42
	.db #0x34	; 52	'4'
	.db #0x34	; 52	'4'
	.db #0x64	; 100	'd'
	.db #0x64	; 100	'd'
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0x38	; 56	'8'
	.db #0x38	; 56	'8'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x12	; 18
	.db #0x12	; 18
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x1c	; 28
	.db #0x1c	; 28
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x78	; 120	'x'
	.db #0x78	; 120	'x'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1c	; 28
	.db #0x1c	; 28
	.db #0x22	; 34
	.db #0x22	; 34
	.db #0x22	; 34
	.db #0x22	; 34
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1e	; 30
	.db #0x1e	; 30
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x7c	; 124
	.db #0x7c	; 124
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x22	; 34
	.db #0x22	; 34
	.db #0x32	; 50	'2'
	.db #0x32	; 50	'2'
	.db #0x2a	; 42
	.db #0x2a	; 42
	.db #0x24	; 36
	.db #0x24	; 36
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1c	; 28
	.db #0x1c	; 28
	.db #0x22	; 34
	.db #0x22	; 34
	.db #0x22	; 34
	.db #0x22	; 34
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1e	; 30
	.db #0x1e	; 30
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x1c	; 28
	.db #0x1c	; 28
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x7c	; 124
	.db #0x7c	; 124
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x22	; 34
	.db #0x22	; 34
	.db #0x22	; 34
	.db #0x22	; 34
	.db #0x22	; 34
	.db #0x22	; 34
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0x38	; 56	'8'
	.db #0x38	; 56	'8'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x78	; 120	'x'
	.db #0x78	; 120	'x'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x78	; 120	'x'
	.db #0x78	; 120	'x'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1c	; 28
	.db #0x1c	; 28
	.db #0x26	; 38
	.db #0x3a	; 58
	.db #0x2e	; 46
	.db #0x32	; 50	'2'
	.db #0x74	; 116	't'
	.db #0x4c	; 76	'L'
	.db #0x64	; 100	'd'
	.db #0x5c	; 92
	.db #0x38	; 56	'8'
	.db #0x38	; 56	'8'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1c	; 28
	.db #0x1c	; 28
	.db #0x22	; 34
	.db #0x22	; 34
	.db #0x22	; 34
	.db #0x22	; 34
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0x7c	; 124
	.db #0x44	; 68	'D'
	.db #0x38	; 56	'8'
	.db #0x38	; 56	'8'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x30	; 48	'0'
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x40	; 64
	.db #0x78	; 120	'x'
	.db #0x24	; 36
	.db #0x34	; 52	'4'
	.db #0xbc	; 188
	.db #0x3c	; 60
	.db #0x6e	; 110	'n'
	.db #0xd2	; 210
	.db #0xac	; 172
	.db #0x3c	; 60
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x10	; 16
	.db #0x10	; 16
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
	.db #0x10	; 16
	.db #0x18	; 24
	.db #0x1c	; 28
	.db #0x24	; 36
	.db #0x38	; 56	'8'
	.db #0x24	; 36
	.db #0x08	; 8
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_enemyspritetiles:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x04	; 4
	.db #0x07	; 7
	.db #0x08	; 8
	.db #0x0c	; 12
	.db #0x10	; 16
	.db #0x13	; 19
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0xd4	; 212
	.db #0xeb	; 235
	.db #0x4b	; 75	'K'
	.db #0x77	; 119	'w'
	.db #0x36	; 54	'6'
	.db #0x3b	; 59
	.db #0x0e	; 14
	.db #0x0f	; 15
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x18	; 24
	.db #0x98	; 152
	.db #0x30	; 48	'0'
	.db #0xf0	; 240
	.db #0x30	; 48	'0'
	.db #0xf0	; 240
	.db #0x68	; 104	'h'
	.db #0xe8	; 232
	.db #0xf0	; 240
	.db #0xf2	; 242
	.db #0x0a	; 10
	.db #0xfd	; 253
	.db #0xec	; 236
	.db #0xfa	; 250
	.db #0x2a	; 42
	.db #0xfd	; 253
	.db #0x30	; 48	'0'
	.db #0xf2	; 242
	.db #0xc8	; 200
	.db #0xc8	; 200
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x11	; 17
	.db #0x0b	; 11
	.db #0x0b	; 11
	.db #0x85	; 133
	.db #0x86	; 134
	.db #0x76	; 118	'v'
	.db #0x75	; 117	'u'
	.db #0x8f	; 143
	.db #0xfd	; 253
	.db #0x76	; 118	'v'
	.db #0x75	; 117	'u'
	.db #0x85	; 133
	.db #0x86	; 134
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x04	; 4
	.db #0x05	; 5
	.db #0x08	; 8
	.db #0x08	; 8
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
	.db #0x08	; 8
	.db #0x88	; 136
	.db #0xd0	; 208
	.db #0xd0	; 208
	.db #0xa1	; 161
	.db #0x61	; 97	'a'
	.db #0x6e	; 110	'n'
	.db #0xae	; 174
	.db #0xf1	; 241
	.db #0xbf	; 191
	.db #0x6e	; 110	'n'
	.db #0xae	; 174
	.db #0xa1	; 161
	.db #0x61	; 97	'a'
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x20	; 32
	.db #0xa0	; 160
	.db #0x10	; 16
	.db #0x10	; 16
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
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x09	; 9
	.db #0x09	; 9
	.db #0x3e	; 62
	.db #0x3f	; 63
	.db #0xd4	; 212
	.db #0xeb	; 235
	.db #0xea	; 234
	.db #0xd5	; 213
	.db #0x3e	; 62
	.db #0x3f	; 63
	.db #0x09	; 9
	.db #0x09	; 9
	.db #0x04	; 4
	.db #0x04	; 4
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
	.db #0x70	; 112	'p'
	.db #0x70	; 112	'p'
	.db #0xe0	; 224
	.db #0xa0	; 160
	.db #0xfa	; 250
	.db #0xf9	; 249
	.db #0x15	; 21
	.db #0xf2	; 242
	.db #0x0a	; 10
	.db #0xfd	; 253
	.db #0x0a	; 10
	.db #0xfd	; 253
	.db #0x15	; 21
	.db #0xf2	; 242
	.db #0xfa	; 250
	.db #0xf9	; 249
	.db #0xe0	; 224
	.db #0xa0	; 160
	.db #0x70	; 112	'p'
	.db #0x70	; 112	'p'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x11	; 17
	.db #0x00	; 0
	.db #0x0b	; 11
	.db #0x00	; 0
	.db #0x05	; 5
	.db #0x03	; 3
	.db #0x06	; 6
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x0f	; 15
	.db #0x3d	; 61
	.db #0x1a	; 26
	.db #0x3a	; 58
	.db #0x1d	; 29
	.db #0x7f	; 127
	.db #0x3f	; 63
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0xa0	; 160
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x80	; 128
	.db #0xc0	; 192
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0xf0	; 240
	.db #0x5c	; 92
	.db #0xb8	; 184
	.db #0xbc	; 188
	.db #0x58	; 88	'X'
	.db #0xfe	; 254
	.db #0xfc	; 252
	.db #0xfe	; 254
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
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x0f	; 15
	.db #0x08	; 8
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xaf	; 175
	.db #0xd0	; 208
	.db #0xf4	; 244
	.db #0xef	; 239
	.db #0x1e	; 30
	.db #0x1f	; 31
	.db #0x01	; 1
	.db #0x01	; 1
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
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0xf2	; 242
	.db #0xf1	; 241
	.db #0x9d	; 157
	.db #0xfa	; 250
	.db #0xea	; 234
	.db #0xfd	; 253
	.db #0xea	; 234
	.db #0x1d	; 29
	.db #0xfd	; 253
	.db #0x9a	; 154
	.db #0x72	; 114	'r'
	.db #0xf1	; 241
	.db #0xc8	; 200
	.db #0xc8	; 200
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
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0x09	; 9
	.db #0x09	; 9
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x0f	; 15
	.db #0x0d	; 13
	.db #0x0f	; 15
	.db #0x0a	; 10
	.db #0x3f	; 63
	.db #0x39	; 57	'9'
	.db #0x0f	; 15
	.db #0x0a	; 10
	.db #0x0f	; 15
	.db #0x0d	; 13
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x09	; 9
	.db #0x09	; 9
	.db #0x11	; 17
	.db #0x11	; 17
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
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xe0	; 224
	.db #0x60	; 96
	.db #0xe0	; 224
	.db #0xa0	; 160
	.db #0xf8	; 248
	.db #0x38	; 56	'8'
	.db #0xe0	; 224
	.db #0xa0	; 160
	.db #0xe0	; 224
	.db #0x60	; 96
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_cloudtiles:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x06	; 6
	.db #0x00	; 0
	.db #0x09	; 9
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x2a	; 42
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0xce	; 206
	.db #0x00	; 0
	.db #0x34	; 52	'4'
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0xa0	; 160
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0xb3	; 179
	.db #0x00	; 0
	.db #0x1d	; 29
	.db #0x00	; 0
	.db #0x24	; 36
	.db #0x00	; 0
	.db #0xff	; 255
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
	.db #0x81	; 129
	.db #0x00	; 0
	.db #0x42	; 66	'B'
	.db #0x00	; 0
	.db #0xe7	; 231
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x34	; 52	'4'
	.db #0x00	; 0
	.db #0x50	; 80	'P'
	.db #0x00	; 0
	.db #0x84	; 132
	.db #0x00	; 0
	.db #0x48	; 72	'H'
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x70	; 112	'p'
	.db #0x00	; 0
	.db #0x48	; 72	'H'
	.db #0x00	; 0
	.db #0x24	; 36
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x0c	; 12
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x21	; 33
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe3	; 227
	.db #0x00	; 0
	.db #0x54	; 84	'T'
	.db #0x00	; 0
	.db #0x08	; 8
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x14	; 20
	.db #0x00	; 0
	.db #0x22	; 34
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x08	; 8
	.db #0x00	; 0
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x19	; 25
	.db #0x00	; 0
	.db #0x26	; 38
	.db #0x00	; 0
	.db #0xc2	; 194
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x30	; 48	'0'
	.db #0x00	; 0
	.db #0x08	; 8
	.db #0x00	; 0
	.db #0x48	; 72	'H'
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_playerspritetiles:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x18	; 24
	.db #0x19	; 25
	.db #0x0c	; 12
	.db #0x0f	; 15
	.db #0x0c	; 12
	.db #0x0f	; 15
	.db #0x06	; 6
	.db #0x07	; 7
	.db #0x0f	; 15
	.db #0x4f	; 79	'O'
	.db #0x5f	; 95
	.db #0xb0	; 176
	.db #0x3f	; 63
	.db #0x57	; 87	'W'
	.db #0x5f	; 95
	.db #0xb4	; 180
	.db #0x0c	; 12
	.db #0x4f	; 79	'O'
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0xe0	; 224
	.db #0x10	; 16
	.db #0x30	; 48	'0'
	.db #0x08	; 8
	.db #0xc8	; 200
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xff	; 255
	.db #0x1f	; 31
	.db #0xff	; 255
	.db #0xc1	; 193
	.db #0xff	; 255
	.db #0x47	; 71	'G'
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x41	; 65	'A'
	.db #0x41	; 65	'A'
	.db #0x3b	; 59
	.db #0x3a	; 58
	.db #0x1f	; 31
	.db #0x14	; 20
	.db #0x3a	; 58
	.db #0x24	; 36
	.db #0x19	; 25
	.db #0x12	; 18
	.db #0x76	; 118	'v'
	.db #0x60	; 96
	.db #0x36	; 54	'6'
	.db #0x21	; 33
	.db #0x19	; 25
	.db #0x14	; 20
	.db #0x3a	; 58
	.db #0x38	; 56	'8'
	.db #0x0f	; 15
	.db #0x0a	; 10
	.db #0x1d	; 29
	.db #0x1d	; 29
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x84	; 132
	.db #0x84	; 132
	.db #0xb8	; 184
	.db #0xb8	; 184
	.db #0xf0	; 240
	.db #0x50	; 80	'P'
	.db #0x5c	; 92
	.db #0x1c	; 28
	.db #0x98	; 152
	.db #0x28	; 40
	.db #0x6c	; 108	'l'
	.db #0x84	; 132
	.db #0x6e	; 110	'n'
	.db #0x06	; 6
	.db #0x9c	; 156
	.db #0x44	; 68	'D'
	.db #0x5e	; 94
	.db #0x0e	; 14
	.db #0xf8	; 248
	.db #0x28	; 40
	.db #0xdc	; 220
	.db #0x5c	; 92
	.db #0x82	; 130
	.db #0x82	; 130
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x1f	; 31
	.db #0x12	; 18
	.db #0x1b	; 27
	.db #0x10	; 16
	.db #0x0d	; 13
	.db #0x08	; 8
	.db #0x3a	; 58
	.db #0x30	; 48	'0'
	.db #0xfc	; 252
	.db #0xc0	; 192
	.db #0x7c	; 124
	.db #0x70	; 112	'p'
	.db #0x0a	; 10
	.db #0x08	; 8
	.db #0x0c	; 12
	.db #0x08	; 8
	.db #0x1b	; 27
	.db #0x10	; 16
	.db #0x1f	; 31
	.db #0x14	; 20
	.db #0x3b	; 59
	.db #0x3a	; 58
	.db #0x63	; 99	'c'
	.db #0x63	; 99	'c'
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0xc6	; 198
	.db #0xc6	; 198
	.db #0xdc	; 220
	.db #0x5c	; 92
	.db #0xf8	; 248
	.db #0x28	; 40
	.db #0xd8	; 216
	.db #0x08	; 8
	.db #0x30	; 48	'0'
	.db #0x10	; 16
	.db #0x50	; 80	'P'
	.db #0x10	; 16
	.db #0x3e	; 62
	.db #0x0e	; 14
	.db #0x3f	; 63
	.db #0x03	; 3
	.db #0x5c	; 92
	.db #0x0c	; 12
	.db #0xb0	; 176
	.db #0x10	; 16
	.db #0xd8	; 216
	.db #0x08	; 8
	.db #0xf8	; 248
	.db #0x48	; 72	'H'
	.db #0xbc	; 188
	.db #0xbc	; 188
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0xc0	; 192
	.db #0xa3	; 163
	.db #0xe3	; 227
	.db #0x80	; 128
	.db #0xe5	; 229
	.db #0x00	; 0
	.db #0x1e	; 30
	.db #0x03	; 3
	.db #0x0f	; 15
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x47	; 71	'G'
	.db #0x46	; 70	'F'
	.db #0x0f	; 15
	.db #0x0c	; 12
	.db #0x0f	; 15
	.db #0x09	; 9
	.db #0x1f	; 31
	.db #0x18	; 24
	.db #0x97	; 151
	.db #0x6f	; 111	'o'
	.db #0x6c	; 108	'l'
	.db #0x94	; 148
	.db #0x90	; 144
	.db #0x68	; 104	'h'
	.db #0x50	; 80	'P'
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0xff	; 255
	.db #0xf9	; 249
	.db #0x7e	; 126
	.db #0x72	; 114	'r'
	.db #0xfe	; 254
	.db #0xc2	; 194
	.db #0xfc	; 252
	.db #0x84	; 132
	.db #0xf8	; 248
	.db #0x08	; 8
	.db #0xf8	; 248
	.db #0x68	; 104	'h'
	.db #0xf0	; 240
	.db #0x90	; 144
	.db #0xd0	; 208
	.db #0x30	; 48	'0'
	.db #0xa0	; 160
	.db #0xe0	; 224
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_projectiletiles:
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0xe0	; 224
	.db #0xa0	; 160
	.db #0x40	; 64
	.db #0x40	; 64
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
	.db #0x40	; 64
	.db #0x60	; 96
	.db #0x70	; 112	'p'
	.db #0x90	; 144
	.db #0xe0	; 224
	.db #0x90	; 144
	.db #0x20	; 32
	.db #0x60	; 96
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
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
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0xf7	; 247
	.db #0xef	; 239
	.db #0x6e	; 110	'n'
	.db #0x76	; 118	'v'
	.db #0x34	; 52	'4'
	.db #0x2c	; 44
	.db #0x2c	; 44
	.db #0x34	; 52	'4'
	.db #0x76	; 118	'v'
	.db #0x6e	; 110	'n'
	.db #0x2c	; 44
	.db #0x34	; 52	'4'
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x91	; 145
	.db #0x91	; 145
	.db #0x4a	; 74	'J'
	.db #0x5a	; 90	'Z'
	.db #0x34	; 52	'4'
	.db #0x6e	; 110	'n'
	.db #0x69	; 105	'i'
	.db #0x45	; 69	'E'
	.db #0x96	; 150
	.db #0xa2	; 162
	.db #0x2c	; 44
	.db #0x76	; 118	'v'
	.db #0x52	; 82	'R'
	.db #0x5a	; 90	'Z'
	.db #0x89	; 137
	.db #0x89	; 137
_goodroadmap:
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x25	; 37
	.db #0x26	; 38
	.db #0x00	; 0
	.db #0x23	; 35
	.db #0x24	; 36
	.db #0x00	; 0
	.db #0x27	; 39
	.db #0x28	; 40
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x22	; 34
	.db #0x22	; 34
	.db #0x22	; 34
_holestartmap:
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x29	; 41
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x2a	; 42
	.db #0x2b	; 43
	.db #0x25	; 37
	.db #0x26	; 38
	.db #0x2c	; 44
	.db #0x30	; 48	'0'
	.db #0x23	; 35
	.db #0x2d	; 45
	.db #0x2e	; 46
	.db #0x33	; 51	'3'
	.db #0x27	; 39
	.db #0x2f	; 47
	.db #0x30	; 48	'0'
	.db #0x33	; 51	'3'
	.db #0x00	; 0
	.db #0x31	; 49	'1'
	.db #0x33	; 51	'3'
	.db #0x33	; 51	'3'
	.db #0x22	; 34
	.db #0x32	; 50	'2'
	.db #0x3c	; 60
	.db #0x3c	; 60
_holemap:
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x3a	; 58
	.db #0x3a	; 58
	.db #0x3a	; 58
	.db #0x33	; 51	'3'
	.db #0x33	; 51	'3'
	.db #0x33	; 51	'3'
	.db #0x33	; 51	'3'
	.db #0x33	; 51	'3'
	.db #0x33	; 51	'3'
	.db #0x33	; 51	'3'
	.db #0x33	; 51	'3'
	.db #0x33	; 51	'3'
	.db #0x33	; 51	'3'
	.db #0x33	; 51	'3'
	.db #0x33	; 51	'3'
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x3c	; 60
_holeendmap:
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x21	; 33
	.db #0x3a	; 58
	.db #0x34	; 52	'4'
	.db #0x00	; 0
	.db #0x33	; 51	'3'
	.db #0x35	; 53	'5'
	.db #0x00	; 0
	.db #0x36	; 54	'6'
	.db #0x37	; 55	'7'
	.db #0x00	; 0
	.db #0x38	; 56	'8'
	.db #0x28	; 40
	.db #0x00	; 0
	.db #0x39	; 57	'9'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x22	; 34
	.db #0x22	; 34
	.db #0x22	; 34
_cloudmap:
	.db #0x14	; 20
	.db #0x15	; 21
	.db #0x16	; 22
	.db #0x1c	; 28
	.db #0x1d	; 29
	.db #0x1e	; 30
	.db #0x1f	; 31
	.db #0x20	; 32
	.db #0x14	; 20
	.db #0x18	; 24
	.db #0x19	; 25
	.db #0x15	; 21
	.db #0x16	; 22
	.db #0x1c	; 28
	.db #0x1d	; 29
	.db #0x1e	; 30
	.db #0x1f	; 31
	.db #0x20	; 32
	.db #0x17	; 23
	.db #0x18	; 24
	.db #0x19	; 25
	.db #0x19	; 25
	.db #0x1a	; 26
	.db #0x1b	; 27
	.db #0x1c	; 28
	.db #0x1d	; 29
	.db #0x1e	; 30
	.db #0x1f	; 31
	.db #0x20	; 32
	.db #0x14	; 20
	.db #0x15	; 21
	.db #0x16	; 22
_hudmap:
	.db #0x06	; 6
	.db #0x07	; 7
	.db #0x0b	; 11
	.db #0x0e	; 14
	.db #0x0e	; 14
	.db #0x0e	; 14
	.db #0x0e	; 14
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0c	; 12
	.db #0x11	; 17
	.db #0x0d	; 13
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x0b	; 11
	.db #0x04	; 4
_deserttiles:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x08	; 8
	.db #0x01	; 1
	.db #0x20	; 32
	.db #0x05	; 5
	.db #0x04	; 4
	.db #0x13	; 19
	.db #0x56	; 86	'V'
	.db #0x09	; 9
	.db #0x00	; 0
	.db #0x25	; 37
	.db #0x4c	; 76	'L'
	.db #0x13	; 19
	.db #0x02	; 2
	.db #0x49	; 73	'I'
	.db #0x08	; 8
	.db #0x25	; 37
	.db #0x00	; 0
	.db #0x13	; 19
	.db #0x36	; 54	'6'
	.db #0x49	; 73	'I'
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x80	; 128
	.db #0x04	; 4
	.db #0xa0	; 160
	.db #0x20	; 32
	.db #0xc8	; 200
	.db #0x6a	; 106	'j'
	.db #0x90	; 144
	.db #0x00	; 0
	.db #0xa4	; 164
	.db #0x32	; 50	'2'
	.db #0xc8	; 200
	.db #0x40	; 64
	.db #0x92	; 146
	.db #0x10	; 16
	.db #0xa4	; 164
	.db #0x00	; 0
	.db #0xc8	; 200
	.db #0x6c	; 108	'l'
	.db #0x92	; 146
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5a	; 90	'Z'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xbd	; 189
	.db #0x34	; 52	'4'
	.db #0x89	; 137
	.db #0xa5	; 165
	.db #0x5a	; 90	'Z'
	.db #0x08	; 8
	.db #0x52	; 82	'R'
	.db #0xf7	; 247
	.db #0x08	; 8
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x08	; 8
	.db #0x4a	; 74	'J'
	.db #0x10	; 16
	.db #0x24	; 36
	.db #0x5a	; 90	'Z'
	.db #0x10	; 16
	.db #0x2c	; 44
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x03	; 3
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7c	; 124
	.db #0x1c	; 28
	.db #0xe2	; 226
	.db #0x1c	; 28
	.db #0xe3	; 227
	.db #0x6e	; 110	'n'
	.db #0x91	; 145
	.db #0x87	; 135
	.db #0x78	; 120	'x'
	.db #0x87	; 135
	.db #0x78	; 120	'x'
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
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x80	; 128
	.db #0x60	; 96
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x06	; 6
	.db #0x19	; 25
	.db #0x04	; 4
	.db #0x3b	; 59
	.db #0x0c	; 12
	.db #0x33	; 51	'3'
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0xfd	; 253
	.db #0x06	; 6
	.db #0xf9	; 249
	.db #0x0c	; 12
	.db #0xf3	; 243
	.db #0x18	; 24
	.db #0xe7	; 231
	.db #0x30	; 48	'0'
	.db #0xcf	; 207
	.db #0x60	; 96
	.db #0x9f	; 159
	.db #0x40	; 64
	.db #0xbf	; 191
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0xfc	; 252
	.db #0x03	; 3
	.db #0xfc	; 252
	.db #0x03	; 3
	.db #0xfc	; 252
	.db #0x07	; 7
	.db #0xf8	; 248
	.db #0x01	; 1
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0x10	; 16
	.db #0xe0	; 224
	.db #0x18	; 24
	.db #0xf0	; 240
	.db #0x0c	; 12
	.db #0xfc	; 252
	.db #0x03	; 3
	.db #0xfe	; 254
	.db #0x01	; 1
	.db #0x1f	; 31
	.db #0xe0	; 224
	.db #0x07	; 7
	.db #0xf8	; 248
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
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0x10	; 16
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
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x01	; 1
	.db #0x0e	; 14
	.db #0x01	; 1
	.db #0x0e	; 14
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x80	; 128
	.db #0x7f	; 127
	.db #0xe0	; 224
	.db #0x1f	; 31
	.db #0x7c	; 124
	.db #0x83	; 131
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
	.db #0x70	; 112	'p'
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0xff	; 255
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
	.db #0x80	; 128
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x38	; 56	'8'
	.db #0xc7	; 199
	.db #0x7c	; 124
	.db #0x83	; 131
	.db #0x7e	; 126
	.db #0x81	; 129
	.db #0x3f	; 63
	.db #0xc0	; 192
	.db #0x3f	; 63
	.db #0xc0	; 192
	.db #0x3f	; 63
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x20	; 32
	.db #0xde	; 222
	.db #0x38	; 56	'8'
	.db #0xc7	; 199
	.db #0x0e	; 14
	.db #0xf1	; 241
	.db #0x07	; 7
	.db #0xf8	; 248
	.db #0x01	; 1
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0x80	; 128
	.db #0x78	; 120	'x'
	.db #0xc0	; 192
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xfe	; 254
	.db #0x07	; 7
	.db #0xf8	; 248
	.db #0x0f	; 15
	.db #0xf0	; 240
	.db #0x3f	; 63
	.db #0xc0	; 192
	.db #0x7f	; 127
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0x7f	; 127
	.db #0xe0	; 224
	.db #0x1f	; 31
	.db #0xf0	; 240
	.db #0x0f	; 15
	.db #0xf8	; 248
	.db #0x07	; 7
	.db #0xfc	; 252
	.db #0x03	; 3
	.db #0xfc	; 252
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x03	; 3
	.db #0x3e	; 62
	.db #0xc1	; 193
	.db #0x03	; 3
	.db #0xfc	; 252
	.db #0x01	; 1
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xc0	; 192
	.db #0x3f	; 63
	.db #0xc0	; 192
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0xc0	; 192
	.db #0x1f	; 31
	.db #0xe0	; 224
	.db #0x0f	; 15
	.db #0xf0	; 240
	.db #0x0f	; 15
	.db #0xf0	; 240
	.db #0x07	; 7
	.db #0xf8	; 248
	.db #0x07	; 7
	.db #0xf8	; 248
	.db #0x03	; 3
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x3f	; 63
	.db #0xe0	; 224
	.db #0x1f	; 31
	.db #0xf8	; 248
	.db #0x07	; 7
	.db #0xfe	; 254
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x06	; 6
	.db #0xf9	; 249
	.db #0x03	; 3
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0x7f	; 127
	.db #0x80	; 128
	.db #0x7f	; 127
	.db #0xc0	; 192
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0xe0	; 224
	.db #0x1c	; 28
	.db #0x38	; 56	'8'
	.db #0xc7	; 199
	.db #0x0c	; 12
	.db #0xf3	; 243
	.db #0x04	; 4
	.db #0xfb	; 251
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0xf8	; 248
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
	.db #0x00	; 0
	.db #0x70	; 112	'p'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x01	; 1
	.db #0x06	; 6
	.db #0x03	; 3
	.db #0x0c	; 12
	.db #0x03	; 3
	.db #0x1c	; 28
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x60	; 96
	.db #0x98	; 152
	.db #0x70	; 112	'p'
	.db #0x8c	; 140
	.db #0xc0	; 192
	.db #0x3f	; 63
	.db #0xe1	; 225
	.db #0x1e	; 30
	.db #0xc1	; 193
	.db #0x3e	; 62
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x80	; 128
	.db #0x60	; 96
	.db #0xc0	; 192
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x00	; 0
_scorpbosstiles:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x7f	; 127
	.db #0x40	; 64
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0xfe	; 254
	.db #0x04	; 4
	.db #0x03	; 3
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xe0	; 224
	.db #0x60	; 96
	.db #0x78	; 120	'x'
	.db #0x38	; 56	'8'
	.db #0x36	; 54	'6'
	.db #0x96	; 150
	.db #0x71	; 113	'q'
	.db #0x21	; 33
	.db #0xcc	; 204
	.db #0x70	; 112	'p'
	.db #0xb3	; 179
	.db #0xbc	; 188
	.db #0xfc	; 252
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0xc6	; 198
	.db #0x06	; 6
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x0f	; 15
	.db #0x08	; 8
	.db #0x07	; 7
	.db #0x0f	; 15
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xf9	; 249
	.db #0xfb	; 251
	.db #0x09	; 9
	.db #0x0b	; 11
	.db #0x04	; 4
	.db #0x05	; 5
	.db #0x03	; 3
	.db #0x03	; 3
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
	.db #0x31	; 49	'1'
	.db #0xc1	; 193
	.db #0xcf	; 207
	.db #0xf0	; 240
	.db #0x31	; 49	'1'
	.db #0x3f	; 63
	.db #0x0f	; 15
	.db #0x0e	; 14
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xe0	; 224
	.db #0xa0	; 160
	.db #0xb0	; 176
	.db #0x10	; 16
	.db #0x18	; 24
	.db #0x48	; 72	'H'
	.db #0xb0	; 176
	.db #0x10	; 16
	.db #0xf0	; 240
	.db #0xb0	; 176
	.db #0x50	; 80	'P'
	.db #0xd0	; 208
	.db #0x10	; 16
	.db #0x90	; 144
	.db #0x04	; 4
	.db #0xfd	; 253
	.db #0x04	; 4
	.db #0xfd	; 253
	.db #0x04	; 4
	.db #0x05	; 5
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x87	; 135
	.db #0x87	; 135
	.db #0x84	; 132
	.db #0x84	; 132
	.db #0x49	; 73	'I'
	.db #0xc8	; 200
	.db #0x4a	; 74	'J'
	.db #0xc9	; 201
	.db #0x55	; 85	'U'
	.db #0xd3	; 211
	.db #0x55	; 85	'U'
	.db #0xd3	; 211
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x20	; 32
	.db #0x1f	; 31
	.db #0xd0	; 208
	.db #0xaf	; 175
	.db #0x28	; 40
	.db #0x50	; 80	'P'
	.db #0x98	; 152
	.db #0x60	; 96
	.db #0x28	; 40
	.db #0xd0	; 208
	.db #0xd1	; 209
	.db #0xa1	; 161
	.db #0x21	; 33
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x02	; 2
	.db #0xfc	; 252
	.db #0x7d	; 125
	.db #0xfa	; 250
	.db #0x42	; 66	'B'
	.db #0x45	; 69	'E'
	.db #0x99	; 153
	.db #0x86	; 134
	.db #0xa2	; 162
	.db #0x9d	; 157
	.db #0x5d	; 93
	.db #0x3a	; 58
	.db #0x52	; 82	'R'
	.db #0x30	; 48	'0'
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x89	; 137
	.db #0x08	; 8
	.db #0x8a	; 138
	.db #0x09	; 9
	.db #0x15	; 21
	.db #0x13	; 19
	.db #0x15	; 21
	.db #0x13	; 19
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x20	; 32
	.db #0x1f	; 31
	.db #0xd0	; 208
	.db #0xaf	; 175
	.db #0x28	; 40
	.db #0x50	; 80	'P'
	.db #0x98	; 152
	.db #0x60	; 96
	.db #0x28	; 40
	.db #0xd0	; 208
	.db #0xd0	; 208
	.db #0xa0	; 160
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xa8	; 168
	.db #0xcc	; 204
	.db #0xa8	; 168
	.db #0xc8	; 200
	.db #0xa8	; 168
	.db #0xc8	; 200
	.db #0xa8	; 168
	.db #0xc8	; 200
	.db #0x54	; 84	'T'
	.db #0x64	; 100	'd'
	.db #0x54	; 84	'T'
	.db #0x64	; 100	'd'
	.db #0x54	; 84	'T'
	.db #0x64	; 100	'd'
	.db #0x5c	; 92
	.db #0x6c	; 108	'l'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x14	; 20
	.db #0x18	; 24
	.db #0x12	; 18
	.db #0x1c	; 28
	.db #0x0d	; 13
	.db #0x0e	; 14
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x07	; 7
	.db #0x1c	; 28
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0x80	; 128
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0xf9	; 249
	.db #0x00	; 0
	.db #0xf3	; 243
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0xf9	; 249
	.db #0x00	; 0
	.db #0xf3	; 243
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x02	; 2
	.db #0xfc	; 252
	.db #0x04	; 4
	.db #0xf8	; 248
	.db #0x08	; 8
	.db #0xf0	; 240
	.db #0x10	; 16
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0a	; 10
	.db #0x0c	; 12
	.db #0x05	; 5
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x04	; 4
	.db #0x0c	; 12
	.db #0x08	; 8
	.db #0x0c	; 12
	.db #0x08	; 8
	.db #0x18	; 24
	.db #0x10	; 16
	.db #0x1c	; 28
	.db #0x14	; 20
	.db #0x31	; 49	'1'
	.db #0x21	; 33
	.db #0xb1	; 177
	.db #0xa1	; 161
	.db #0x71	; 113	'q'
	.db #0x61	; 97	'a'
	.db #0x30	; 48	'0'
	.db #0x20	; 32
	.db #0x60	; 96
	.db #0x44	; 68	'D'
	.db #0x61	; 97	'a'
	.db #0x42	; 66	'B'
	.db #0xc4	; 196
	.db #0x88	; 136
	.db #0xc0	; 192
	.db #0x84	; 132
	.db #0x81	; 129
	.db #0x02	; 2
	.db #0xa8	; 168
	.db #0xcc	; 204
	.db #0x54	; 84	'T'
	.db #0x64	; 100	'd'
	.db #0x1e	; 30
	.db #0x1e	; 30
	.db #0x01	; 1
	.db #0x91	; 145
	.db #0xc0	; 192
	.db #0x20	; 32
	.db #0x90	; 144
	.db #0x88	; 136
	.db #0x80	; 128
	.db #0x90	; 144
	.db #0xc3	; 195
	.db #0x20	; 32
	.db #0x0c	; 12
	.db #0x93	; 147
	.db #0x73	; 115	's'
	.db #0x0f	; 15
	.db #0x3c	; 60
	.db #0x34	; 52	'4'
	.db #0xd6	; 214
	.db #0xe2	; 226
	.db #0xa3	; 163
	.db #0xc9	; 201
	.db #0x56	; 86	'V'
	.db #0x62	; 98	'b'
	.db #0x2c	; 44
	.db #0x34	; 52	'4'
	.db #0x38	; 56	'8'
	.db #0xf8	; 248
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x01	; 1
	.db #0x01	; 1
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
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0xf3	; 243
	.db #0x16	; 22
	.db #0x24	; 36
	.db #0xef	; 239
	.db #0xe7	; 231
	.db #0xef	; 239
	.db #0x24	; 36
	.db #0x2c	; 44
	.db #0x24	; 36
	.db #0x2c	; 44
	.db #0x48	; 72	'H'
	.db #0x58	; 88	'X'
	.db #0x48	; 72	'H'
	.db #0xdc	; 220
	.db #0x48	; 72	'H'
	.db #0xd8	; 216
	.db #0xd4	; 212
	.db #0x64	; 100	'd'
	.db #0x2a	; 42
	.db #0xf2	; 242
	.db #0xeb	; 235
	.db #0xf3	; 243
	.db #0x15	; 21
	.db #0x19	; 25
	.db #0x15	; 21
	.db #0x19	; 25
	.db #0x0a	; 10
	.db #0x0c	; 12
	.db #0x0a	; 10
	.db #0x0c	; 12
	.db #0x05	; 5
	.db #0x06	; 6
	.db #0xfd	; 253
	.db #0x06	; 6
	.db #0x02	; 2
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x90	; 144
	.db #0x80	; 128
	.db #0xe8	; 232
	.db #0xd7	; 215
	.db #0x14	; 20
	.db #0x2b	; 43
	.db #0x61	; 97	'a'
	.db #0x61	; 97	'a'
	.db #0xa0	; 160
	.db #0x3f	; 63
	.db #0xbf	; 191
	.db #0x3f	; 63
	.db #0x50	; 80	'P'
	.db #0x90	; 144
	.db #0x50	; 80	'P'
	.db #0x90	; 144
	.db #0xa9	; 169
	.db #0xc8	; 200
	.db #0xae	; 174
	.db #0xcd	; 205
	.db #0x51	; 81	'Q'
	.db #0xe2	; 226
	.db #0xd7	; 215
	.db #0x64	; 100	'd'
	.db #0x2a	; 42
	.db #0xf3	; 243
	.db #0xeb	; 235
	.db #0xf3	; 243
	.db #0x15	; 21
	.db #0x19	; 25
	.db #0x15	; 21
	.db #0x19	; 25
	.db #0x0a	; 10
	.db #0x0c	; 12
	.db #0x8a	; 138
	.db #0x0c	; 12
	.db #0x45	; 69	'E'
	.db #0x86	; 134
	.db #0x8c	; 140
	.db #0x7c	; 124
	.db #0x70	; 112	'p'
	.db #0xf0	; 240
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x90	; 144
	.db #0x80	; 128
	.db #0xe8	; 232
	.db #0xd7	; 215
	.db #0x14	; 20
	.db #0x2b	; 43
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x48	; 72	'H'
	.db #0x58	; 88	'X'
	.db #0x90	; 144
	.db #0xb0	; 176
	.db #0x90	; 144
	.db #0xb0	; 176
	.db #0xf0	; 240
	.db #0x10	; 16
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x05	; 5
	.db #0x06	; 6
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
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
	.db #0xcc	; 204
	.db #0x30	; 48	'0'
	.db #0x14	; 20
	.db #0xe8	; 232
	.db #0xe8	; 232
	.db #0xd0	; 208
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5c	; 92
	.db #0x63	; 99	'c'
	.db #0x21	; 33
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3d	; 61
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc5	; 197
	.db #0x06	; 6
	.db #0x42	; 66	'B'
	.db #0x83	; 131
	.db #0x83	; 131
	.db #0x03	; 3
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
	.db #0xcc	; 204
	.db #0x30	; 48	'0'
	.db #0x14	; 20
	.db #0xe8	; 232
	.db #0xe8	; 232
	.db #0xd0	; 208
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_desertmap:
	.db #0x00	; 0
	.db #0x44	; 68	'D'
	.db #0x45	; 69	'E'
	.db #0x46	; 70	'F'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x4e	; 78	'N'
	.db #0x4f	; 79	'O'
	.db #0x50	; 80	'P'
	.db #0x51	; 81	'Q'
	.db #0x52	; 82	'R'
	.db #0x53	; 83	'S'
	.db #0x54	; 84	'T'
	.db #0x55	; 85	'U'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x60	; 96
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x4e	; 78	'N'
	.db #0x4f	; 79	'O'
	.db #0x50	; 80	'P'
	.db #0x51	; 81	'Q'
	.db #0x52	; 82	'R'
	.db #0x53	; 83	'S'
	.db #0x54	; 84	'T'
	.db #0x55	; 85	'U'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x47	; 71	'G'
	.db #0x48	; 72	'H'
	.db #0x49	; 73	'I'
	.db #0x4a	; 74	'J'
	.db #0x4b	; 75	'K'
	.db #0x4c	; 76	'L'
	.db #0x4d	; 77	'M'
	.db #0x56	; 86	'V'
	.db #0x57	; 87	'W'
	.db #0x58	; 88	'X'
	.db #0x59	; 89	'Y'
	.db #0x5a	; 90	'Z'
	.db #0x5b	; 91
	.db #0x5c	; 92
	.db #0x5d	; 93
	.db #0x5e	; 94
	.db #0x5f	; 95
	.db #0x00	; 0
	.db #0x61	; 97	'a'
	.db #0x62	; 98	'b'
	.db #0x63	; 99	'c'
	.db #0x4d	; 77	'M'
	.db #0x56	; 86	'V'
	.db #0x57	; 87	'W'
	.db #0x58	; 88	'X'
	.db #0x59	; 89	'Y'
	.db #0x5a	; 90	'Z'
	.db #0x5b	; 91
	.db #0x5c	; 92
	.db #0x5d	; 93
	.db #0x5e	; 94
	.db #0x5f	; 95
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x43	; 67	'C'
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x43	; 67	'C'
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x43	; 67	'C'
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x43	; 67	'C'
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x43	; 67	'C'
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x43	; 67	'C'
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x42	; 66	'B'
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x42	; 66	'B'
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x42	; 66	'B'
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x42	; 66	'B'
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x42	; 66	'B'
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x42	; 66	'B'
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3e	; 62
	.db #0x40	; 64
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3e	; 62
	.db #0x40	; 64
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3e	; 62
	.db #0x40	; 64
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3e	; 62
	.db #0x40	; 64
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3e	; 62
	.db #0x40	; 64
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3e	; 62
	.db #0x40	; 64
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3f	; 63
	.db #0x41	; 65	'A'
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3f	; 63
	.db #0x41	; 65	'A'
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3f	; 63
	.db #0x41	; 65	'A'
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3f	; 63
	.db #0x41	; 65	'A'
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3f	; 63
	.db #0x41	; 65	'A'
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3f	; 63
	.db #0x41	; 65	'A'
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
_scorpbossmap:
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x64	; 100	'd'
	.db #0x65	; 101	'e'
	.db #0x66	; 102	'f'
	.db #0x67	; 103	'g'
	.db #0x21	; 33
	.db #0x00	; 0
	.db #0x68	; 104	'h'
	.db #0x69	; 105	'i'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x6a	; 106	'j'
	.db #0x6b	; 107	'k'
	.db #0x6c	; 108	'l'
	.db #0x00	; 0
	.db #0x25	; 37
	.db #0x6d	; 109	'm'
	.db #0x6e	; 110	'n'
	.db #0x6f	; 111	'o'
	.db #0x70	; 112	'p'
	.db #0x71	; 113	'q'
	.db #0x72	; 114	'r'
	.db #0x73	; 115	's'
	.db #0x74	; 116	't'
	.db #0x75	; 117	'u'
	.db #0x76	; 118	'v'
	.db #0x77	; 119	'w'
	.db #0x78	; 120	'x'
	.db #0x79	; 121	'y'
	.db #0x7a	; 122	'z'
	.db #0x7b	; 123
	.db #0x7c	; 124
	.db #0x7d	; 125
	.db #0x7e	; 126
	.db #0x7f	; 127
	.db #0x80	; 128
	.db #0x81	; 129
	.db #0x82	; 130
	.db #0x83	; 131
	.db #0x84	; 132
	.db #0x28	; 40
	.db #0x00	; 0
	.db #0x85	; 133
	.db #0x86	; 134
	.db #0x87	; 135
	.db #0x88	; 136
	.db #0x89	; 137
	.db #0x8a	; 138
	.db #0x8b	; 139
	.db #0x00	; 0
_scorpgunprops:
	.db #0x01	;  1
	.db #0x0a	;  10
	.db #0x01	;  1
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x08	;  8
	.db #0xfd	; -3
	.db #0x01	;  1
	.db #0x06	;  6
	.db #0x00	;  0
_stingprops:
	.db #0x01	;  1
	.db #0x0a	;  10
	.db #0x01	;  1
	.db #0x00	;  0
	.db #0x08	;  8
	.db #0x0d	;  13
	.db #0x01	;  1
	.db #0x00	;  0
	.db #0x06	;  6
	.db #0x00	;  0
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
_scorpbossexpl:
	.db #0x62	; 98	'b'
	.db #0x70	; 112	'p'
	.db #0x6b	; 107	'k'
	.db #0x79	; 121	'y'
	.db #0x7d	; 125
	.db #0x76	; 118	'v'
	.db #0x86	; 134
	.db #0x70	; 112	'p'
	.db #0x74	; 116	't'
	.db #0x79	; 121	'y'
;stages/stage1.c:59: void init_scorpboss() BANKED {
;	---------------------------------
; Function init_scorpboss
; ---------------------------------
	b_init_scorpboss	= 2
_init_scorpboss::
;stages/stage1.c:60: init_stage(1, 0);
	xor	a, a
	ld	d,a
	ld	e,#0x01
	push	de
	call	_init_stage
	add	sp, #2
;stages/stage1.c:61: set_bkg_data(100, 40, scorpbosstiles);
	ld	hl, #_scorpbosstiles
	push	hl
	ld	de, #0x2864
	push	de
	call	_set_bkg_data
	add	sp, #4
;stages/stage1.c:62: set_bkg_tiles(11, 10, 9, 6, scorpbossmap);
	ld	hl, #_scorpbossmap
	push	hl
	ld	de, #0x0609
	push	de
	ld	de, #0x0a0b
	push	de
	call	_set_bkg_tiles
	add	sp, #6
;stages/stage1.c:63: set_sprite_data(20, 6, bossspritetiles);
	ld	hl, #_bossspritetiles
	push	hl
	ld	de, #0x0614
	push	de
	call	_set_sprite_data
	add	sp, #4
;stages/stage1.c:66: init_machine_props(121, 96, stingprops);
	ld	hl, #_stingprops
	push	hl
	ld	de, #0x6079
	push	de
	call	_init_machine_props
	add	sp, #4
;stages/stage1.c:67: set_stinger_tiles(0);
	xor	a, a
	push	af
	inc	sp
	ld	e, #b_set_stinger_tiles
	ld	hl, #_set_stinger_tiles
	call	___sdcc_bcall_ehl
	inc	sp
;stages/stage1.c:68: place_machine(crntenemy - 1, 121, 96);
	ld	hl, #_crntenemy
	ld	a, (hl)
	add	a, #0xef
	ld	c, a
	inc	hl
	ld	a, (hl)
	adc	a, #0xff
	ld	b, a
	ld	de, #0x6079
	push	de
	push	bc
	call	_place_machine
	add	sp, #4
;stages/stage1.c:71: init_scorpboss_gun(100, 105);
	ld	de, #0x6964
	push	de
	ld	e, #b_init_scorpboss_gun
	ld	hl, #_init_scorpboss_gun
	call	___sdcc_bcall_ehl
	add	sp, #2
;stages/stage1.c:74: init_scorpboss_gun(96, 136);
	ld	de, #0x8860
	push	de
	ld	e, #b_init_scorpboss_gun
	ld	hl, #_init_scorpboss_gun
	call	___sdcc_bcall_ehl
	add	sp, #2
;stages/stage1.c:75: }
	ret
;stages/stage1.c:79: void set_stinger_tiles(UINT8 animcyc) BANKED {
;	---------------------------------
; Function set_stinger_tiles
; ---------------------------------
	b_set_stinger_tiles	= 2
_set_stinger_tiles::
;stages/stage1.c:80: set_machine_tile(machines + 1, 127);
	ld	a, #0x7f
	push	af
	inc	sp
	ld	hl, #(_machines + 0x0011)
	push	hl
	call	_set_machine_tile
	add	sp, #3
;stages/stage1.c:81: set_sprite_tile((machines + 1)->oamtilenums[0], animcyc == 10 ? 23 : 20);
	ldhl	sp,	#6
	ld	a, (hl)
	sub	a, #0x0a
	ld	a, #0x01
	jr	Z, 00120$
	xor	a, a
00120$:
	ld	c, a
	or	a, a
	jr	Z, 00105$
	ld	de, #0x0017
	jr	00106$
00105$:
	ld	de, #0x0014
00106$:
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1145: shadow_OAM[nb].tile=tile;
	ld	a, (#_machines + 30)
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
	ld	(hl), e
;stages/stage1.c:82: set_sprite_tile((machines + 1)->oamtilenums[2], animcyc == 10 ? 24 : 21);
	ld	a, c
	or	a, a
	jr	Z, 00107$
	ld	de, #0x0018
	jr	00108$
00107$:
	ld	de, #0x0015
00108$:
	ld	hl, #_machines + 32
	ld	c, (hl)
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1145: shadow_OAM[nb].tile=tile;
	ld	h, #0x00
	ld	l, c
	add	hl, hl
	add	hl, hl
	ld	bc, #_shadow_OAM
	add	hl, bc
	inc	hl
	inc	hl
	ld	(hl), e
;stages/stage1.c:82: set_sprite_tile((machines + 1)->oamtilenums[2], animcyc == 10 ? 24 : 21);
;stages/stage1.c:83: }
	ret
;stages/stage1.c:86: void set_pincer_tiles(Machine * mch, UINT8 animcyc) BANKED {
;	---------------------------------
; Function set_pincer_tiles
; ---------------------------------
	b_set_pincer_tiles	= 2
_set_pincer_tiles::
;stages/stage1.c:87: set_machine_tile(mch, 127);
	ld	a, #0x7f
	push	af
	inc	sp
	ldhl	sp,	#7
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_set_machine_tile
	add	sp, #3
;stages/stage1.c:88: set_sprite_tile(mch->oamtilenums[0], animcyc == 10 ? 25 : 22);
	ldhl	sp,	#8
	ld	a, (hl)
	sub	a, #0x0a
	jr	NZ, 00104$
	ld	bc, #0x0019
	jr	00105$
00104$:
	ld	bc, #0x0016
00105$:
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000d
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
;stages/stage1.c:88: set_sprite_tile(mch->oamtilenums[0], animcyc == 10 ? 25 : 22);
;stages/stage1.c:89: }
	ret
;stages/stage1.c:92: void scorpboss_hit_anim(UINT8 animcyc) BANKED {
;	---------------------------------
; Function scorpboss_hit_anim
; ---------------------------------
	b_scorpboss_hit_anim	= 2
_scorpboss_hit_anim::
;stages/stage1.c:93: if(hitmchptr == machines + 1) {
	ld	hl, #_hitmchptr
	ld	a, (hl)
	sub	a, #<((_machines + 0x0011))
	jr	NZ, 00102$
	inc	hl
	ld	a, (hl)
	sub	a, #>((_machines + 0x0011))
	jr	NZ, 00102$
;stages/stage1.c:94: set_stinger_tiles(animcyc);
	ldhl	sp,	#6
	ld	a, (hl)
	push	af
	inc	sp
	ld	e, #b_set_stinger_tiles
	ld	hl, #_set_stinger_tiles
	call	___sdcc_bcall_ehl
	inc	sp
	ret
00102$:
;stages/stage1.c:96: set_pincer_tiles(hitmchptr, animcyc);
	ldhl	sp,	#6
	ld	a, (hl)
	push	af
	inc	sp
	ld	hl, #_hitmchptr
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ld	e, #b_set_pincer_tiles
	ld	hl, #_set_pincer_tiles
	call	___sdcc_bcall_ehl
	add	sp, #3
;stages/stage1.c:98: }
	ret
;stages/stage1.c:101: void scorpboss_loop() BANKED {
;	---------------------------------
; Function scorpboss_loop
; ---------------------------------
	b_scorpboss_loop	= 2
_scorpboss_loop::
	add	sp, #-7
;stages/stage1.c:102: UINT8 pattrn = 0, firedbull = 0, explidx = 0, gunidx, hitanimtmr = 10;
	xor	a, a
	ldhl	sp,	#4
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl+), a
	ld	(hl), #0x0a
;stages/stage1.c:103: while(1) {
00170$:
;stages/stage1.c:105: if(pllives == 0 && pl->explcount == 0) {
	ld	hl, #_pl
	ld	a, (hl+)
	ld	e, (hl)
	ldhl	sp,	#0
	ld	(hl+), a
	ld	(hl), e
;c
	pop	de
	push	de
	ld	hl, #0x0007
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl), a
	ld	a, (#_pllives)
	or	a, a
	jr	NZ, 00102$
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jp	Z, 00172$
;stages/stage1.c:106: break;  // Game over
00102$:
;stages/stage1.c:109: if(pl->x + pl->width > 98 && pl->y + pl->height > 95 && pl->explcount == 0 && bossclearflg == 0) {
	pop	hl
	push	hl
	inc	hl
	ld	c, (hl)
	ld	b, #0x00
;c
	pop	de
	push	de
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
	jr	Z, 00356$
	bit	7, d
	jr	NZ, 00357$
	cp	a, a
	jr	00357$
00356$:
	bit	7, d
	jr	Z, 00357$
	scf
00357$:
	jr	NC, 00105$
	pop	hl
	push	hl
	inc	hl
	inc	hl
	ld	c, (hl)
	ld	b, #0x00
;c
	pop	de
	push	de
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
	jr	Z, 00358$
	bit	7, d
	jr	NZ, 00359$
	cp	a, a
	jr	00359$
00358$:
	bit	7, d
	jr	Z, 00359$
	scf
00359$:
	jr	NC, 00105$
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	NZ, 00105$
	ld	a, (#_bossclearflg)
	or	a, a
	jr	NZ, 00105$
;stages/stage1.c:110: take_damage(pl, pl->shield);    // Collision with boss bkg
;c
	pop	de
	push	de
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
;stages/stage1.c:113: if(pattrn == 0) {  // Initial time for the player to adjust before boss attacks
	ldhl	sp,	#4
	ld	a, (hl)
	or	a, a
	jr	NZ, 00112$
;stages/stage1.c:114: if(cooldown_enemy(machines + 1, 0)) {
	xor	a, a
	push	af
	inc	sp
	ld	hl, #(_machines + 0x0011)
	push	hl
	call	_cooldown_enemy
	add	sp, #3
	ld	a, e
	or	a, a
	jr	Z, 00112$
;stages/stage1.c:115: pattrn = 1;
	ldhl	sp,	#4
	ld	(hl), #0x01
00112$:
;stages/stage1.c:119: gunidx = pattrn == 1 ? 2 : 3; // Set gun to be fired depending on pattern num
	ldhl	sp,	#4
	ld	a, (hl)
	dec	a
	ld	a, #0x01
	jr	Z, 00361$
	xor	a, a
00361$:
	ld	c, a
	or	a, a
	jr	Z, 00174$
	ld	de, #0x0002
	jr	00175$
00174$:
	ld	de, #0x0003
00175$:
	ldhl	sp,	#3
	ld	(hl), e
;stages/stage1.c:120: if(pattrn == 1 || pattrn == 2) {  // Fire top or bottom gun
	ld	a, c
	or	a, a
	jr	NZ, 00143$
	inc	hl
	ld	a, (hl)
	sub	a, #0x02
	jr	NZ, 00144$
00143$:
;stages/stage1.c:121: if(is_alive(machines + gunidx) && firedbull != 3) {
	ldhl	sp,	#3
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
	ld	a, l
	add	a, #<(_machines)
	ld	c, a
	ld	a, h
	adc	a, #>(_machines)
	ld	b, a
	ld	e, c
	ld	d, b
	push	bc
	push	de
	call	_is_alive
	add	sp, #2
	ld	a, e
	pop	bc
	or	a, a
	jr	Z, 00118$
	ldhl	sp,	#5
	ld	a, (hl)
	sub	a, #0x03
	jr	Z, 00118$
;stages/stage1.c:122: if(cooldown_enemy(machines + gunidx, 20)) {
	ld	e, c
	ld	d, b
	push	bc
	ld	a, #0x14
	push	af
	inc	sp
	push	de
	call	_cooldown_enemy
	add	sp, #3
	ld	a, e
	pop	bc
	or	a, a
	jp	Z, 00145$
;stages/stage1.c:123: fire_projctl(machines + gunidx, 1, -2, 0);
	xor	a, a
	ld	d,a
	ld	e,#0xfe
	push	de
	ld	a, #0x01
	push	af
	inc	sp
	push	bc
	call	_fire_projctl
	add	sp, #5
;stages/stage1.c:124: firedbull++;
	ldhl	sp,	#5
	inc	(hl)
	jp	00145$
00118$:
;stages/stage1.c:126: } else if(cooldown_enemy(machines + gunidx, 30)) {  // Cooldown until next attack
	ld	a, #0x1e
	push	af
	inc	sp
	push	bc
	call	_cooldown_enemy
	add	sp, #3
	ld	a, e
	or	a, a
	jp	Z, 00145$
;stages/stage1.c:127: firedbull = 0;
	xor	a, a
	ldhl	sp,	#5
;stages/stage1.c:128: pattrn++;
	ld	(hl-), a
	inc	(hl)
	jp	00145$
00144$:
;stages/stage1.c:130: } else if(pattrn == 3) {  // Stinger pattern
	ldhl	sp,	#4
	ld	a, (hl)
	sub	a, #0x03
	jp	NZ,00145$
;stages/stage1.c:131: if(is_alive(machines + 1)) {
	ld	de, #_machines + 17
	ld	c, e
	ld	b, d
	push	de
	push	bc
	call	_is_alive
	add	sp, #2
	ld	a, e
	pop	de
	or	a, a
	jp	Z, 00139$
;stages/stage1.c:132: machines[1].groundflg = pl->groundflg;
	ld	hl, #_pl + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, (bc)
	ld	(de), a
;stages/stage1.c:133: if(machines[1].cyccount == 0) {
	ld	bc, #_machines + 25
	ld	a, (bc)
	or	a, a
	jr	NZ, 00136$
;stages/stage1.c:134: move_enemy(machines + 1, -2, 2);
	push	bc
	ld	hl, #0x02fe
	push	hl
	push	de
	call	_move_enemy
	add	sp, #4
	pop	bc
;stages/stage1.c:135: if(machines[1].y == 114) { // Rewrite
	ld	a, (#(_machines + 0x0013) + 0)
	sub	a, #0x72
	jr	NZ, 00145$
;stages/stage1.c:136: machines[1].cyccount++;
	ld	a, (bc)
	inc	a
	ld	(bc), a
	jr	00145$
00136$:
;stages/stage1.c:138: } else if(machines[1].cyccount == 1) {
	cp	a, #0x01
	jr	NZ, 00133$
;stages/stage1.c:139: move_enemy(machines + 1, -4, 0);
	push	bc
	xor	a, a
	ld	h, a
	ld	l, #0xfc
	push	hl
	push	de
	call	_move_enemy
	add	sp, #4
	pop	bc
;stages/stage1.c:140: if(machines[1].x < 16) {
	ld	a, (#(_machines + 0x0012) + 0)
	sub	a, #0x10
	jr	NC, 00145$
;stages/stage1.c:141: machines[1].cyccount++;
	ld	a, (bc)
	inc	a
	ld	(bc), a
	jr	00145$
00133$:
;stages/stage1.c:143: } else if(machines[1].cyccount == 2) {
	sub	a, #0x02
	jr	NZ, 00130$
;stages/stage1.c:144: move_enemy(machines + 1, 2, -2);
	push	bc
	ld	hl, #0xfe02
	push	hl
	push	de
	call	_move_enemy
	add	sp, #4
	pop	bc
;stages/stage1.c:145: if(machines[1].y == 96) {
	ld	a, (#(_machines + 0x0013) + 0)
	sub	a, #0x60
	jr	NZ, 00145$
;stages/stage1.c:146: machines[1].cyccount++;
	ld	a, (bc)
	inc	a
	ld	(bc), a
	jr	00145$
00130$:
;stages/stage1.c:149: move_enemy(machines + 1, 4, 0);
	push	bc
	xor	a, a
	ld	h, a
	ld	l, #0x04
	push	hl
	push	de
	call	_move_enemy
	add	sp, #4
	pop	bc
;stages/stage1.c:150: if(machines[1].x == 121) {
	ld	a, (#(_machines + 0x0012) + 0)
	sub	a, #0x79
	jr	NZ, 00145$
;stages/stage1.c:151: machines[1].cyccount = 0;
	xor	a, a
	ld	(bc), a
;stages/stage1.c:152: pattrn = 1;  // Reset boss pattern
	ldhl	sp,	#4
	ld	(hl), #0x01
	jr	00145$
00139$:
;stages/stage1.c:156: pattrn = 1;
	ldhl	sp,	#4
	ld	(hl), #0x01
00145$:
;stages/stage1.c:160: manage_projectiles();
	call	_manage_projectiles
;stages/stage1.c:161: manage_machines();
	call	_manage_machines
;stages/stage1.c:163: if(hitmchptr != NULL) {
	ld	hl, #_hitmchptr + 1
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00153$
;stages/stage1.c:164: if(hitanimtmr == 10) {
	ldhl	sp,	#6
	ld	a, (hl)
	sub	a, #0x0a
	jr	NZ, 00150$
;stages/stage1.c:165: scorpboss_hit_anim(hitanimtmr);
	ldhl	sp,	#6
	ld	a, (hl)
	push	af
	inc	sp
	ld	e, #b_scorpboss_hit_anim
	ld	hl, #_scorpboss_hit_anim
	call	___sdcc_bcall_ehl
	inc	sp
	jr	00151$
00150$:
;stages/stage1.c:166: } else if(hitanimtmr == 0) {
	ldhl	sp,	#6
	ld	a, (hl)
	or	a, a
	jr	NZ, 00151$
;stages/stage1.c:167: scorpboss_hit_anim(hitanimtmr);
	ld	a, (hl)
	push	af
	inc	sp
	ld	e, #b_scorpboss_hit_anim
	ld	hl, #_scorpboss_hit_anim
	call	___sdcc_bcall_ehl
	inc	sp
;stages/stage1.c:168: hitmchptr = NULL;
	ld	hl, #_hitmchptr
	ld	a, #0x00
	ld	(hl+), a
	ld	(hl), #0x00
;stages/stage1.c:169: hitanimtmr = 11;
	ldhl	sp,	#6
	ld	(hl), #0x0b
00151$:
;stages/stage1.c:171: hitanimtmr--;
	ldhl	sp,	#6
	dec	(hl)
00153$:
;stages/stage1.c:174: if(bossclearflg == 0 && (!(is_alive(machines + 1) || is_alive(machines + 2) || is_alive(machines + 3))) ) {
	ld	a, (#_bossclearflg)
	or	a, a
	jr	NZ, 00155$
	ld	hl, #(_machines + 0x0011)
	push	hl
	call	_is_alive
	add	sp, #2
	ld	a, e
	or	a, a
	jr	NZ, 00155$
	ld	hl, #(_machines + 0x0022)
	push	hl
	call	_is_alive
	add	sp, #2
	ld	a, e
	or	a, a
	jr	NZ, 00155$
	ld	hl, #(_machines + 0x0033)
	push	hl
	call	_is_alive
	add	sp, #2
	ld	a, e
	or	a, a
	jr	NZ, 00155$
;stages/stage1.c:175: bossclearflg = 1;
	ld	hl, #_bossclearflg
	ld	(hl), #0x01
00155$:
;stages/stage1.c:178: if(bossclearflg == 1 && machines[1].explcount == 0 && machines[2].explcount == 0 && machines[3].explcount == 0 ) {
	ld	a, (#_bossclearflg)
	dec	a
	jr	NZ, 00165$
	ld	a, (#(_machines + 0x0018) + 0)
	or	a, a
	jr	NZ, 00165$
	ld	a, (#(_machines + 0x0029) + 0)
	or	a, a
	jr	NZ, 00165$
	ld	a, (#(_machines + 0x003a) + 0)
	or	a, a
	jr	NZ, 00165$
;stages/stage1.c:179: if(lockmvmnt == 2) {    // Wait until the end of the jumping animation
	ld	a, (#_lockmvmnt)
	sub	a, #0x02
	jr	NZ, 00162$
;stages/stage1.c:180: anim_jump();
	call	_anim_jump
	jr	00165$
00162$:
;stages/stage1.c:181: } else if(pl->explcount == 0) {
	ld	hl, #_pl + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0007
	add	hl, bc
	ld	a, (hl)
	or	a, a
	jr	NZ, 00165$
;stages/stage1.c:182: clear_all_projectiles();
	call	_clear_all_projectiles
;stages/stage1.c:183: break;  // Boss cleared
	jr	00172$
00165$:
;stages/stage1.c:187: manage_sound_chnls();
	call	_manage_sound_chnls
;stages/stage1.c:188: manage_player();
	call	_manage_player
;stages/stage1.c:189: wait_vbl_done();
	call	_wait_vbl_done
	jp	00170$
00172$:
;stages/stage1.c:191: }
	add	sp, #7
	ret
;stages/stage2.c:62: void move_mech(Machine * mech, INT8 x, INT8 y) BANKED {
;	---------------------------------
; Function move_mech
; ---------------------------------
	b_move_mech	= 2
_move_mech::
	add	sp, #-6
;stages/stage2.c:63: move_machine(mech, x, y);
	ldhl	sp,	#15
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
;stages/stage2.c:64: move_sprite(mech->oamtilenums[3] + 1, mech->x, mech->y + 16);
	ldhl	sp,#12
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0002
	add	hl, bc
	inc	sp
	inc	sp
	ld	e, l
	ld	d, h
	push	de
	ld	a, (de)
	add	a, #0x10
	ldhl	sp,	#2
	ld	(hl), a
	ld	l, c
	ld	h, b
	inc	hl
	push	hl
	ld	a, l
	ldhl	sp,	#5
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#4
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	inc	hl
	ld	(hl), a
	ld	hl, #0x0010
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	e, a
	inc	e
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1218: OAM_item_t * itm = &shadow_OAM[nb];
	ld	a, e
	ld	h, #0x00
	ld	l, a
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
	ld	e, l
	ld	d, h
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1219: itm->y=y, itm->x=x;
	ldhl	sp,	#2
	ld	a, (hl)
	ld	(de), a
	inc	de
	ldhl	sp,	#5
	ld	a, (hl)
	ld	(de), a
;stages/stage2.c:65: move_sprite(mech->oamtilenums[3] + 2, mech->x + 8, mech->y + 16);
	pop	de
	push	de
	ld	a, (de)
	add	a, #0x10
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	add	a, #0x08
	ld	e, a
	ld	a, (bc)
	add	a, #0x02
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1218: OAM_item_t * itm = &shadow_OAM[nb];
	ld	l, a
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
;stages/stage2.c:65: move_sprite(mech->oamtilenums[3] + 2, mech->x + 8, mech->y + 16);
;stages/stage2.c:66: }
	add	sp, #6
	ret
_citytiles:
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x41	; 65	'A'
	.db #0xbe	; 190
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xc7	; 199
	.db #0x38	; 56	'8'
	.db #0x19	; 25
	.db #0xe6	; 230
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xf3	; 243
	.db #0x0c	; 12
	.db #0x9f	; 159
	.db #0x60	; 96
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x39	; 57	'9'
	.db #0xc6	; 198
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x83	; 131
	.db #0x7c	; 124
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xed	; 237
	.db #0x12	; 18
	.db #0x96	; 150
	.db #0x6d	; 109	'm'
	.db #0xc9	; 201
	.db #0xbe	; 190
	.db #0xdd	; 221
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xf7	; 247
	.db #0x08	; 8
	.db #0xdd	; 221
	.db #0x22	; 34
	.db #0x07	; 7
	.db #0x08	; 8
	.db #0x04	; 4
	.db #0x0b	; 11
	.db #0x04	; 4
	.db #0x0b	; 11
	.db #0x07	; 7
	.db #0x08	; 8
	.db #0x07	; 7
	.db #0x08	; 8
	.db #0x04	; 4
	.db #0x0b	; 11
	.db #0x04	; 4
	.db #0x0b	; 11
	.db #0x07	; 7
	.db #0x08	; 8
	.db #0xf0	; 240
	.db #0x08	; 8
	.db #0x90	; 144
	.db #0x68	; 104	'h'
	.db #0x90	; 144
	.db #0x68	; 104	'h'
	.db #0xf0	; 240
	.db #0x08	; 8
	.db #0xf0	; 240
	.db #0x08	; 8
	.db #0x90	; 144
	.db #0x68	; 104	'h'
	.db #0x90	; 144
	.db #0x68	; 104	'h'
	.db #0xf0	; 240
	.db #0x08	; 8
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
	.db #0x0f	; 15
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
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x77	; 119	'w'
	.db #0x88	; 136
	.db #0x77	; 119	'w'
	.db #0x88	; 136
	.db #0x77	; 119	'w'
	.db #0x88	; 136
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x77	; 119	'w'
	.db #0x88	; 136
	.db #0x77	; 119	'w'
	.db #0x88	; 136
	.db #0x77	; 119	'w'
	.db #0x88	; 136
	.db #0x07	; 7
	.db #0x88	; 136
	.db #0x04	; 4
	.db #0x8b	; 139
	.db #0x04	; 4
	.db #0x8b	; 139
	.db #0x07	; 7
	.db #0x88	; 136
	.db #0x07	; 7
	.db #0x88	; 136
	.db #0x04	; 4
	.db #0x8b	; 139
	.db #0x04	; 4
	.db #0x8b	; 139
	.db #0x07	; 7
	.db #0x88	; 136
	.db #0xf0	; 240
	.db #0x08	; 8
	.db #0x90	; 144
	.db #0x68	; 104	'h'
	.db #0x90	; 144
	.db #0x68	; 104	'h'
	.db #0xf0	; 240
	.db #0x08	; 8
	.db #0xf0	; 240
	.db #0x08	; 8
	.db #0x90	; 144
	.db #0x68	; 104	'h'
	.db #0x90	; 144
	.db #0x68	; 104	'h'
	.db #0xf0	; 240
	.db #0x08	; 8
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x8f	; 143
	.db #0x07	; 7
	.db #0x88	; 136
	.db #0x04	; 4
	.db #0x8b	; 139
	.db #0x04	; 4
	.db #0x8b	; 139
	.db #0x07	; 7
	.db #0x88	; 136
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0xf0	; 240
	.db #0x08	; 8
	.db #0x90	; 144
	.db #0x68	; 104	'h'
	.db #0x90	; 144
	.db #0x68	; 104	'h'
	.db #0xf0	; 240
	.db #0x08	; 8
	.db #0x38	; 56	'8'
	.db #0x47	; 71	'G'
	.db #0x2f	; 47
	.db #0x50	; 80	'P'
	.db #0x28	; 40
	.db #0x57	; 87	'W'
	.db #0x38	; 56	'8'
	.db #0x47	; 71	'G'
	.db #0x2f	; 47
	.db #0x50	; 80	'P'
	.db #0x28	; 40
	.db #0x57	; 87	'W'
	.db #0x38	; 56	'8'
	.db #0x47	; 71	'G'
	.db #0x3f	; 63
	.db #0x40	; 64
	.db #0xe0	; 224
	.db #0x10	; 16
	.db #0xa0	; 160
	.db #0x50	; 80	'P'
	.db #0xa0	; 160
	.db #0x50	; 80	'P'
	.db #0xe0	; 224
	.db #0x10	; 16
	.db #0xa0	; 160
	.db #0x50	; 80	'P'
	.db #0xa0	; 160
	.db #0x50	; 80	'P'
	.db #0xe0	; 224
	.db #0x10	; 16
	.db #0xe0	; 224
	.db #0x10	; 16
	.db #0x2f	; 47
	.db #0x50	; 80	'P'
	.db #0x28	; 40
	.db #0x57	; 87	'W'
	.db #0x38	; 56	'8'
	.db #0x47	; 71	'G'
	.db #0x2f	; 47
	.db #0x50	; 80	'P'
	.db #0x28	; 40
	.db #0x57	; 87	'W'
	.db #0x38	; 56	'8'
	.db #0x47	; 71	'G'
	.db #0x2f	; 47
	.db #0x50	; 80	'P'
	.db #0x28	; 40
	.db #0x57	; 87	'W'
	.db #0xa0	; 160
	.db #0x50	; 80	'P'
	.db #0xa0	; 160
	.db #0x50	; 80	'P'
	.db #0xe0	; 224
	.db #0x10	; 16
	.db #0xa0	; 160
	.db #0x50	; 80	'P'
	.db #0xa0	; 160
	.db #0x50	; 80	'P'
	.db #0xe0	; 224
	.db #0x10	; 16
	.db #0xa0	; 160
	.db #0x50	; 80	'P'
	.db #0xa0	; 160
	.db #0x50	; 80	'P'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x3f	; 63
	.db #0x40	; 64
	.db #0x2f	; 47
	.db #0x50	; 80	'P'
	.db #0x28	; 40
	.db #0x57	; 87	'W'
	.db #0x38	; 56	'8'
	.db #0x47	; 71	'G'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0xe0	; 224
	.db #0x10	; 16
	.db #0xa0	; 160
	.db #0x50	; 80	'P'
	.db #0xa0	; 160
	.db #0x50	; 80	'P'
	.db #0xe0	; 224
	.db #0x10	; 16
	.db #0x03	; 3
	.db #0xbc	; 188
	.db #0x14	; 20
	.db #0xa3	; 163
	.db #0x0a	; 10
	.db #0xb0	; 176
	.db #0x01	; 1
	.db #0xbc	; 188
	.db #0x1c	; 28
	.db #0xa3	; 163
	.db #0x0f	; 15
	.db #0xb0	; 176
	.db #0x03	; 3
	.db #0xbc	; 188
	.db #0x14	; 20
	.db #0xa3	; 163
	.db #0xe0	; 224
	.db #0x1e	; 30
	.db #0x14	; 20
	.db #0xe2	; 226
	.db #0xa8	; 168
	.db #0x06	; 6
	.db #0x40	; 64
	.db #0x1e	; 30
	.db #0x1c	; 28
	.db #0xe2	; 226
	.db #0xf8	; 248
	.db #0x06	; 6
	.db #0xe0	; 224
	.db #0x1e	; 30
	.db #0x14	; 20
	.db #0xe2	; 226
	.db #0x1c	; 28
	.db #0xa3	; 163
	.db #0x0f	; 15
	.db #0xb0	; 176
	.db #0x03	; 3
	.db #0xbc	; 188
	.db #0x14	; 20
	.db #0xa3	; 163
	.db #0x0a	; 10
	.db #0xb0	; 176
	.db #0x01	; 1
	.db #0xbc	; 188
	.db #0x1c	; 28
	.db #0xa3	; 163
	.db #0x0f	; 15
	.db #0xb0	; 176
	.db #0x1c	; 28
	.db #0xe2	; 226
	.db #0xf8	; 248
	.db #0x06	; 6
	.db #0xe0	; 224
	.db #0x1e	; 30
	.db #0x14	; 20
	.db #0xe2	; 226
	.db #0xa8	; 168
	.db #0x06	; 6
	.db #0x40	; 64
	.db #0x1e	; 30
	.db #0x1c	; 28
	.db #0xe2	; 226
	.db #0xf8	; 248
	.db #0x06	; 6
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0xbf	; 191
	.db #0x0a	; 10
	.db #0xb0	; 176
	.db #0x01	; 1
	.db #0xbc	; 188
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
	.db #0xfe	; 254
	.db #0xa8	; 168
	.db #0x06	; 6
	.db #0x40	; 64
	.db #0x1e	; 30
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x8f	; 143
	.db #0x00	; 0
	.db #0x08	; 8
	.db #0x00	; 0
	.db #0x1c	; 28
	.db #0x00	; 0
	.db #0x1c	; 28
	.db #0x14	; 20
	.db #0x2a	; 42
	.db #0x14	; 20
	.db #0x2a	; 42
	.db #0x14	; 20
	.db #0x2a	; 42
	.db #0x36	; 54	'6'
	.db #0x49	; 73	'I'
	.db #0x00	; 0
	.db #0x7f	; 127
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
	.db #0x08	; 8
	.db #0x00	; 0
	.db #0x08	; 8
	.db #0x00	; 0
	.db #0x08	; 8
	.db #0x7f	; 127
	.db #0x80	; 128
	.db #0x49	; 73	'I'
	.db #0xb6	; 182
	.db #0x49	; 73	'I'
	.db #0xb6	; 182
	.db #0x7f	; 127
	.db #0x80	; 128
	.db #0x7f	; 127
	.db #0x80	; 128
	.db #0x49	; 73	'I'
	.db #0xb6	; 182
	.db #0x49	; 73	'I'
	.db #0xb6	; 182
	.db #0x7f	; 127
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x1c	; 28
	.db #0x00	; 0
	.db #0x3e	; 62
	.db #0x1c	; 28
	.db #0x22	; 34
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x3e	; 62
	.db #0x41	; 65	'A'
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x7f	; 127
	.db #0x80	; 128
	.db #0x7f	; 127
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x8f	; 143
	.db #0x07	; 7
	.db #0x88	; 136
	.db #0x07	; 7
	.db #0x88	; 136
	.db #0x00	; 0
	.db #0x8f	; 143
	.db #0x07	; 7
	.db #0x88	; 136
	.db #0x07	; 7
	.db #0x88	; 136
	.db #0x00	; 0
	.db #0x8f	; 143
	.db #0x07	; 7
	.db #0x88	; 136
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x83	; 131
	.db #0x00	; 0
	.db #0x8f	; 143
	.db #0x07	; 7
	.db #0x88	; 136
	.db #0x07	; 7
	.db #0x88	; 136
	.db #0x00	; 0
	.db #0x8f	; 143
	.db #0x07	; 7
	.db #0x88	; 136
	.db #0x07	; 7
	.db #0x88	; 136
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x80	; 128
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
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x9f	; 159
	.db #0x0e	; 14
	.db #0x91	; 145
	.db #0x0e	; 14
	.db #0x91	; 145
	.db #0x0e	; 14
	.db #0x91	; 145
	.db #0x00	; 0
	.db #0x9f	; 159
	.db #0x0e	; 14
	.db #0x91	; 145
	.db #0x0e	; 14
	.db #0x91	; 145
	.db #0x0e	; 14
	.db #0x91	; 145
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x0e	; 14
	.db #0x11	; 17
	.db #0x0e	; 14
	.db #0x91	; 145
	.db #0x0e	; 14
	.db #0x91	; 145
	.db #0x00	; 0
	.db #0x9f	; 159
	.db #0x0e	; 14
	.db #0x91	; 145
	.db #0x0e	; 14
	.db #0x91	; 145
	.db #0x0e	; 14
	.db #0x91	; 145
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x0e	; 14
	.db #0x11	; 17
	.db #0x0e	; 14
	.db #0x11	; 17
	.db #0x0e	; 14
	.db #0x11	; 17
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x0e	; 14
	.db #0x11	; 17
	.db #0x0e	; 14
	.db #0x11	; 17
	.db #0x0e	; 14
	.db #0x11	; 17
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0xe0	; 224
	.db #0x10	; 16
	.db #0xe0	; 224
	.db #0x10	; 16
	.db #0xe0	; 224
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0xe0	; 224
	.db #0x10	; 16
	.db #0xe0	; 224
	.db #0x10	; 16
	.db #0xe0	; 224
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x0e	; 14
	.db #0x11	; 17
	.db #0x0e	; 14
	.db #0x11	; 17
	.db #0x0e	; 14
	.db #0x11	; 17
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0xe0	; 224
	.db #0x10	; 16
	.db #0xe0	; 224
	.db #0x10	; 16
	.db #0xe0	; 224
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x6d	; 109	'm'
	.db #0x92	; 146
	.db #0x6d	; 109	'm'
	.db #0x92	; 146
	.db #0x6d	; 109	'm'
	.db #0x92	; 146
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x6d	; 109	'm'
	.db #0x92	; 146
	.db #0x6d	; 109	'm'
	.db #0x92	; 146
	.db #0x6d	; 109	'm'
	.db #0x92	; 146
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0xb0	; 176
	.db #0x48	; 72	'H'
	.db #0xb0	; 176
	.db #0x48	; 72	'H'
	.db #0xb0	; 176
	.db #0x48	; 72	'H'
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0xb0	; 176
	.db #0x48	; 72	'H'
	.db #0xb0	; 176
	.db #0x48	; 72	'H'
	.db #0xb0	; 176
	.db #0x48	; 72	'H'
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x07	; 7
	.db #0x08	; 8
	.db #0x07	; 7
	.db #0x18	; 24
	.db #0x0f	; 15
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x1f	; 31
	.db #0x20	; 32
	.db #0x1f	; 31
	.db #0x60	; 96
	.db #0x3f	; 63
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x80	; 128
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0xc0	; 192
	.db #0x20	; 32
	.db #0xc0	; 192
	.db #0x30	; 48	'0'
	.db #0xe0	; 224
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x02	; 2
	.db #0x05	; 5
	.db #0x02	; 2
	.db #0x05	; 5
_citymap:
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
	.db #0x57	; 87	'W'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x6a	; 106	'j'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x57	; 87	'W'
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
	.db #0x56	; 86	'V'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x68	; 104	'h'
	.db #0x69	; 105	'i'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x56	; 86	'V'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x6a	; 106	'j'
	.db #0x00	; 0
	.db #0x42	; 66	'B'
	.db #0x43	; 67	'C'
	.db #0x44	; 68	'D'
	.db #0x47	; 71	'G'
	.db #0x48	; 72	'H'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x44	; 68	'D'
	.db #0x55	; 85	'U'
	.db #0x43	; 67	'C'
	.db #0x59	; 89	'Y'
	.db #0x5f	; 95
	.db #0x00	; 0
	.db #0x64	; 100	'd'
	.db #0x65	; 101	'e'
	.db #0x66	; 102	'f'
	.db #0x67	; 103	'g'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x44	; 68	'D'
	.db #0x55	; 85	'U'
	.db #0x43	; 67	'C'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x68	; 104	'h'
	.db #0x69	; 105	'i'
	.db #0x40	; 64
	.db #0x41	; 65	'A'
	.db #0x44	; 68	'D'
	.db #0x45	; 69	'E'
	.db #0x46	; 70	'F'
	.db #0x4d	; 77	'M'
	.db #0x4e	; 78	'N'
	.db #0x44	; 68	'D'
	.db #0x53	; 83	'S'
	.db #0x54	; 84	'T'
	.db #0x44	; 68	'D'
	.db #0x45	; 69	'E'
	.db #0x46	; 70	'F'
	.db #0x58	; 88	'X'
	.db #0x5e	; 94
	.db #0x00	; 0
	.db #0x62	; 98	'b'
	.db #0x63	; 99	'c'
	.db #0x66	; 102	'f'
	.db #0x67	; 103	'g'
	.db #0x44	; 68	'D'
	.db #0x53	; 83	'S'
	.db #0x54	; 84	'T'
	.db #0x4d	; 77	'M'
	.db #0x4e	; 78	'N'
	.db #0x44	; 68	'D'
	.db #0x45	; 69	'E'
	.db #0x46	; 70	'F'
	.db #0x4d	; 77	'M'
	.db #0x4e	; 78	'N'
	.db #0x66	; 102	'f'
	.db #0x67	; 103	'g'
	.db #0x40	; 64
	.db #0x41	; 65	'A'
	.db #0x44	; 68	'D'
	.db #0x45	; 69	'E'
	.db #0x46	; 70	'F'
	.db #0x4b	; 75	'K'
	.db #0x4c	; 76	'L'
	.db #0x44	; 68	'D'
	.db #0x51	; 81	'Q'
	.db #0x52	; 82	'R'
	.db #0x44	; 68	'D'
	.db #0x45	; 69	'E'
	.db #0x46	; 70	'F'
	.db #0x58	; 88	'X'
	.db #0x5c	; 92
	.db #0x5d	; 93
	.db #0x61	; 97	'a'
	.db #0x63	; 99	'c'
	.db #0x66	; 102	'f'
	.db #0x67	; 103	'g'
	.db #0x44	; 68	'D'
	.db #0x51	; 81	'Q'
	.db #0x52	; 82	'R'
	.db #0x4b	; 75	'K'
	.db #0x4c	; 76	'L'
	.db #0x44	; 68	'D'
	.db #0x45	; 69	'E'
	.db #0x46	; 70	'F'
	.db #0x4b	; 75	'K'
	.db #0x4c	; 76	'L'
	.db #0x66	; 102	'f'
	.db #0x67	; 103	'g'
	.db #0x40	; 64
	.db #0x41	; 65	'A'
	.db #0x44	; 68	'D'
	.db #0x45	; 69	'E'
	.db #0x46	; 70	'F'
	.db #0x49	; 73	'I'
	.db #0x4a	; 74	'J'
	.db #0x44	; 68	'D'
	.db #0x4f	; 79	'O'
	.db #0x50	; 80	'P'
	.db #0x44	; 68	'D'
	.db #0x45	; 69	'E'
	.db #0x46	; 70	'F'
	.db #0x58	; 88	'X'
	.db #0x5a	; 90	'Z'
	.db #0x5b	; 91
	.db #0x60	; 96
	.db #0x63	; 99	'c'
	.db #0x66	; 102	'f'
	.db #0x67	; 103	'g'
	.db #0x44	; 68	'D'
	.db #0x4f	; 79	'O'
	.db #0x50	; 80	'P'
	.db #0x49	; 73	'I'
	.db #0x4a	; 74	'J'
	.db #0x44	; 68	'D'
	.db #0x45	; 69	'E'
	.db #0x46	; 70	'F'
	.db #0x49	; 73	'I'
	.db #0x4a	; 74	'J'
	.db #0x66	; 102	'f'
	.db #0x67	; 103	'g'
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
	.db #0x3d	; 61
_stage2road:
	.db #0x46	; 70	'F'
	.db #0x1e	; 30
	.db #0x6e	; 110	'n'
	.db #0x0a	; 10
	.db #0x14	; 20
	.db #0x0a	; 10
	.db #0x78	; 120	'x'
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x14	; 20
	.db #0x32	; 50	'2'
	.db #0x0a	; 10
	.db #0x78	; 120	'x'
	.db #0x28	; 40
	.db #0x82	; 130
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0xa0	; 160
_stage2objs:
	.db #0x00	; 0
	.db #0x28	; 40
	.db #0xa7	; 167
	.db #0x72	; 114	'r'
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x0f	; 15
	.db #0xa7	; 167
	.db #0x85	; 133
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x0a	; 10
	.db #0xa7	; 167
	.db #0x3c	; 60
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x14	; 20
	.db #0xa7	; 167
	.db #0x60	; 96
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x28	; 40
	.db #0xa7	; 167
	.db #0x85	; 133
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x32	; 50	'2'
	.db #0xa7	; 167
	.db #0x1e	; 30
	.db #0x04	; 4
	.db #0x02	; 2
	.db #0x41	; 65	'A'
	.db #0xa7	; 167
	.db #0x72	; 114	'r'
	.db #0x00	; 0
	.db #0x04	; 4
	.db #0x05	; 5
	.db #0xa7	; 167
	.db #0x1e	; 30
	.db #0x01	; 1
	.db #0x06	; 6
	.db #0x0a	; 10
	.db #0xa7	; 167
	.db #0x85	; 133
	.db #0x00	; 0
	.db #0x06	; 6
	.db #0x12	; 18
	.db #0xa7	; 167
	.db #0x1e	; 30
	.db #0x04	; 4
	.db #0x06	; 6
	.db #0x23	; 35
	.db #0xa7	; 167
	.db #0x60	; 96
	.db #0x00	; 0
	.db #0x06	; 6
	.db #0x2d	; 45
	.db #0xa7	; 167
	.db #0x32	; 50	'2'
	.db #0x04	; 4
	.db #0x06	; 6
	.db #0x3c	; 60
	.db #0xa7	; 167
	.db #0x72	; 114	'r'
	.db #0x00	; 0
	.db #0x06	; 6
	.db #0x50	; 80	'P'
	.db #0xa7	; 167
	.db #0x28	; 40
	.db #0x04	; 4
	.db #0x0b	; 11
	.db #0x09	; 9
	.db #0xa7	; 167
	.db #0x85	; 133
	.db #0x03	; 3
	.db #0x0c	; 12
	.db #0x0f	; 15
	.db #0xa7	; 167
	.db #0x85	; 133
	.db #0x05	; 5
	.db #0x0e	; 14
	.db #0x14	; 20
	.db #0xa7	; 167
	.db #0x60	; 96
	.db #0x00	; 0
	.db #0x0e	; 14
	.db #0x37	; 55	'7'
	.db #0xa7	; 167
	.db #0x85	; 133
	.db #0x05	; 5
	.db #0x0e	; 14
	.db #0x3c	; 60
	.db #0xa7	; 167
	.db #0x60	; 96
	.db #0x00	; 0
	.db #0x0e	; 14
	.db #0x5f	; 95
	.db #0xa7	; 167
	.db #0x85	; 133
	.db #0x05	; 5
	.db #0x0f	; 15
	.db #0x09	; 9
	.db #0xa7	; 167
	.db #0x85	; 133
	.db #0x03	; 3
	.db #0x0f	; 15
	.db #0x20	; 32
	.db #0xa7	; 167
	.db #0x85	; 133
	.db #0x03	; 3
	.db #0x10	; 16
	.db #0x09	; 9
	.db #0xa7	; 167
	.db #0x60	; 96
	.db #0x05	; 5
	.db #0x10	; 16
	.db #0x0e	; 14
	.db #0xa7	; 167
	.db #0x3c	; 60
	.db #0x01	; 1
	.db #0x10	; 16
	.db #0x0f	; 15
	.db #0xa7	; 167
	.db #0x72	; 114	'r'
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x32	; 50	'2'
	.db #0xa7	; 167
	.db #0x60	; 96
	.db #0x05	; 5
	.db #0x10	; 16
	.db #0x37	; 55	'7'
	.db #0xa7	; 167
	.db #0x3c	; 60
	.db #0x01	; 1
	.db #0x10	; 16
	.db #0x50	; 80	'P'
	.db #0xa7	; 167
	.db #0x85	; 133
	.db #0x00	; 0
	.db #0x16	; 22
	.db #0x01	; 1
	.db #0xa7	; 167
	.db #0x32	; 50	'2'
	.db #0x01	; 1
	.db #0x18	; 24
	.db #0x0a	; 10
	.db #0xa7	; 167
	.db #0x1e	; 30
	.db #0x04	; 4
	.db #0x18	; 24
	.db #0x14	; 20
	.db #0xa7	; 167
	.db #0x60	; 96
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x23	; 35
	.db #0xa7	; 167
	.db #0x32	; 50	'2'
	.db #0x01	; 1
	.db #0x18	; 24
	.db #0x37	; 55	'7'
	.db #0xa7	; 167
	.db #0x85	; 133
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x41	; 65	'A'
	.db #0xa7	; 167
	.db #0x28	; 40
	.db #0x04	; 4
	.db #0x18	; 24
	.db #0x50	; 80	'P'
	.db #0xa7	; 167
	.db #0x32	; 50	'2'
	.db #0x01	; 1
	.db #0x18	; 24
	.db #0x5f	; 95
	.db #0xa7	; 167
	.db #0x72	; 114	'r'
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x6e	; 110	'n'
	.db #0xa7	; 167
	.db #0x1e	; 30
	.db #0x04	; 4
	.db #0x18	; 24
	.db #0x78	; 120	'x'
	.db #0xa7	; 167
	.db #0x32	; 50	'2'
	.db #0x01	; 1
_mechforwtiles:
	.db #0x1c	; 28
	.db #0x1e	; 30
	.db #0x1d	; 29
	.db #0x1f	; 31
	.db #0x20	; 32
	.db #0x21	; 33
_mechbackwtiles:
	.db #0x1e	; 30
	.db #0x1c	; 28
	.db #0x1f	; 31
	.db #0x1d	; 29
	.db #0x21	; 33
	.db #0x20	; 32
_mechprops:
	.db #0x00	; 0
	.db #0x14	; 20
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x0e	; 14
	.db #0x16	; 22
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x06	; 6
	.db #0x1c	; 28
_backhboffx:
	.db #0xf6	; -10
_fronthboffx:
	.db #0x10	;  16
;stages/stage2.c:69: void init_mechboss() BANKED {
;	---------------------------------
; Function init_mechboss
; ---------------------------------
	b_init_mechboss	= 2
_init_mechboss::
;stages/stage2.c:70: init_stage(1, 1);
	ld	de, #0x0101
	push	de
	call	_init_stage
	add	sp, #2
;stages/stage2.c:71: set_sprite_data(22, 21, bossspritetiles);
	ld	hl, #_bossspritetiles
	push	hl
	ld	de, #0x1516
	push	de
	call	_set_sprite_data
	add	sp, #4
;stages/stage2.c:72: for(i = 0; i < 6; i++) {    // Resetting sprite properties
	ld	hl, #_i
	ld	(hl), #0x00
00107$:
;stages/stage2.c:73: set_sprite_prop((crntenemy - 1)->oamtilenums[0] + i, 0);
	ld	hl, #_crntenemy
	ld	a, (hl)
	add	a, #0xef
	ld	c, a
	inc	hl
	ld	a, (hl)
	adc	a, #0xff
	ld	b, a
	ld	hl, #0x000d
	add	hl, bc
	ld	a, (hl)
	ld	hl, #_i
	add	a, (hl)
	ld	e, a
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1191: shadow_OAM[nb].prop=prop;
	ld	bc, #_shadow_OAM+0
	xor	a, a
	ld	l, e
	ld	h, a
	add	hl, hl
	add	hl, hl
	add	hl, bc
	inc	hl
	inc	hl
	inc	hl
	ld	(hl), #0x00
;stages/stage2.c:72: for(i = 0; i < 6; i++) {    // Resetting sprite properties
	ld	hl, #_i
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x06
	jr	C, 00107$
;stages/stage2.c:75: init_machine_props(167, 64, mechprops);
	ld	hl, #_mechprops
	push	hl
	ld	de, #0x40a7
	push	de
	call	_init_machine_props
	add	sp, #4
;stages/stage2.c:76: set_sprite_tile(oamidx, mechforwtiles[4]);
	ld	hl, #_mechforwtiles + 4
	ld	c, (hl)
	ld	hl, #_oamidx
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
;stages/stage2.c:77: move_sprite(oamidx, (crntenemy - 1)->x, (crntenemy - 1)->y + 16);
	ld	hl, #_crntenemy
	ld	a, (hl)
	add	a, #0xef
	ld	e, a
	inc	hl
	ld	a, (hl)
	adc	a, #0xff
	ld	d, a
	ld	c, e
	ld	b, d
	inc	bc
	inc	bc
	ld	a, (bc)
	add	a, #0x10
	ld	b, a
	inc	de
	ld	a, (de)
	ld	c, a
	ld	hl, #_oamidx
	ld	e, (hl)
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1218: OAM_item_t * itm = &shadow_OAM[nb];
	ld	d, #0x00
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1219: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;stages/stage2.c:78: set_sprite_tile(oamidx + 1, mechforwtiles[5]);
	ld	hl, #_mechforwtiles + 5
	ld	c, (hl)
	ld	hl, #_oamidx
	ld	e, (hl)
	inc	e
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1145: shadow_OAM[nb].tile=tile;
	xor	a, a
	ld	l, e
	ld	h, a
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
	inc	hl
	inc	hl
	ld	(hl), c
;stages/stage2.c:79: move_sprite(oamidx + 1, (crntenemy - 1)->x + 8, (crntenemy - 1)->y + 16);
	ld	hl, #_crntenemy
	ld	a, (hl)
	add	a, #0xef
	ld	e, a
	inc	hl
	ld	a, (hl)
	adc	a, #0xff
	ld	d, a
	ld	c, e
	ld	b, d
	inc	bc
	inc	bc
	ld	a, (bc)
	add	a, #0x10
	ld	b, a
	inc	de
	ld	a, (de)
	add	a, #0x08
	ld	c, a
	ld	hl, #_oamidx
	ld	e, (hl)
	inc	e
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1218: OAM_item_t * itm = &shadow_OAM[nb];
	ld	d, #0x00
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1219: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;stages/stage2.c:80: incr_oam_sprite_tile_idx(2);
	ld	a, #0x02
	push	af
	inc	sp
	call	_incr_oam_sprite_tile_idx
	inc	sp
;stages/stage2.c:81: flip_mech(crntenemy - 1);
	ld	hl, #_crntenemy
	ld	a, (hl)
	add	a, #0xef
	ld	c, a
	inc	hl
	ld	a, (hl)
	adc	a, #0xff
	ld	b, a
	push	bc
	ld	e, #b_flip_mech
	ld	hl, #_flip_mech
	call	___sdcc_bcall_ehl
	add	sp, #2
;stages/stage2.c:82: }
	ret
;stages/stage2.c:86: void flip_mech(Machine * mch) BANKED {
;	---------------------------------
; Function flip_mech
; ---------------------------------
	b_flip_mech	= 2
_flip_mech::
	add	sp, #-4
;stages/stage2.c:87: UINT8 sprdir = get_sprite_prop(mch->oamtilenums[0]) == 32 ? 0 : 32; // Assign opposite sprite direction
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	e, a
	ld	b, (hl)
	ld	a, e
	add	a, #0x0d
	ld	c, a
	jr	NC, 00135$
	inc	b
00135$:
	ld	a, (bc)
	ld	e, a
	ld	h, #0x00
	ld	l, e
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	sub	a, #0x20
	jr	NZ, 00109$
	ld	de, #0x0000
	jr	00110$
00109$:
	ld	de, #0x0020
00110$:
	ldhl	sp,	#0
	ld	(hl), e
;stages/stage2.c:88: const UINT8 * mechtiles = sprdir == 32 ? mechbackwtiles : mechforwtiles;
	ld	a, (hl)
	sub	a, #0x20
	ld	a, #0x01
	jr	Z, 00139$
	xor	a, a
00139$:
	ldhl	sp,	#1
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jr	Z, 00111$
	ld	de, #_mechbackwtiles+0
	jr	00112$
00111$:
	ld	de, #_mechforwtiles+0
00112$:
	ldhl	sp,	#2
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;stages/stage2.c:89: (machines + 1)->gunoffx = sprdir == 32 ? backhboffx : fronthboffx;
	ld	de, #_machines+26
	dec	hl
	dec	hl
	ld	a, (hl)
	or	a, a
	jr	Z, 00113$
	ld	a, (#_backhboffx)
	jr	00114$
00113$:
	ld	a, (#_fronthboffx)
00114$:
	ld	(de), a
;stages/stage2.c:90: for(i = 0; i < 6; i++) {
	ld	hl, #_i
	ld	(hl), #0x00
00105$:
;stages/stage2.c:91: set_sprite_prop(mch->oamtilenums[0] + i, sprdir);
	ld	a, (bc)
	ld	hl, #_i
	add	a, (hl)
	ld	e, a
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1191: shadow_OAM[nb].prop=prop;
	ld	h, #0x00
	ld	l, e
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
	inc	hl
	inc	hl
	inc	hl
	ld	e, l
	ld	d, h
	ldhl	sp,	#0
	ld	a, (hl)
	ld	(de), a
;stages/stage2.c:92: set_sprite_tile(mch->oamtilenums[0] + i, mechtiles[i]);
;c
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_i
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ld	e, a
	ld	a, (bc)
	ld	hl, #_i
	add	a, (hl)
	ld	d, a
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1145: shadow_OAM[nb].tile=tile;
	ld	h, #0x00
	ld	l, d
	add	hl, hl
	add	hl, hl
	push	de
	ld	de, #_shadow_OAM
	add	hl, de
	pop	de
	inc	hl
	inc	hl
	ld	(hl), e
;stages/stage2.c:90: for(i = 0; i < 6; i++) {
	ld	hl, #_i
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x06
	jr	C, 00105$
;stages/stage2.c:94: }
	add	sp, #4
	ret
;stages/stage2.c:98: void charge_gun(Machine * mch, UINT8 phase) BANKED {
;	---------------------------------
; Function charge_gun
; ---------------------------------
	b_charge_gun	= 2
_charge_gun::
;stages/stage2.c:101: set_sprite_tile(oamidx, 40 + phase);
	ldhl	sp,	#8
	ld	a, (hl)
	add	a, #0x28
	ld	c, a
;stages/stage2.c:99: if(phase == 0) {
	ld	a, (hl)
	or	a, a
	jr	NZ, 00105$
;stages/stage2.c:100: chargeidx = oamidx;
	ld	hl, #_oamidx
	ld	b, (hl)
	ld	hl, #_chargeidx
	ld	(hl), b
;stages/stage2.c:101: set_sprite_tile(oamidx, 40 + phase);
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1145: shadow_OAM[nb].tile=tile;
	ld	de, #_shadow_OAM+0
	ld	l, b
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	add	hl, de
	inc	hl
	inc	hl
	ld	(hl), c
;stages/stage2.c:102: set_sprite_prop(oamidx, 32);
	ld	hl, #_oamidx
	ld	e, (hl)
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1191: shadow_OAM[nb].prop=prop;
	ld	bc, #_shadow_OAM+0
	ld	d, #0x00
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	add	hl, bc
	inc	hl
	inc	hl
	inc	hl
	ld	(hl), #0x20
;stages/stage2.c:103: move_sprite(oamidx, mch->x - 6, mch->y + 15);
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	c, e
	ld	b, d
	inc	bc
	inc	bc
	ld	a, (bc)
	add	a, #0x0f
	ld	b, a
	inc	de
	ld	a, (de)
	add	a, #0xfa
	ld	c, a
	ld	hl, #_oamidx
	ld	e, (hl)
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1218: OAM_item_t * itm = &shadow_OAM[nb];
	ld	d, #0x00
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1219: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;stages/stage2.c:104: se_charge_gun(0);
	xor	a, a
	push	af
	inc	sp
	call	_se_charge_gun
	inc	sp
;stages/stage2.c:105: incr_oam_sprite_tile_idx(1);
	ld	a, #0x01
	push	af
	inc	sp
	call	_incr_oam_sprite_tile_idx
	inc	sp
	ret
00105$:
;stages/stage2.c:107: set_sprite_tile(chargeidx, 40 + phase);
	ld	hl, #_chargeidx
	ld	e, (hl)
;stages/stage2.c:106: } else if(phase < 3) {
	ldhl	sp,	#8
	ld	a, (hl)
	sub	a, #0x03
	jr	NC, 00102$
;stages/stage2.c:107: set_sprite_tile(chargeidx, 40 + phase);
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1145: shadow_OAM[nb].tile=tile;
	ld	h, #0x00
	ld	l, e
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
	inc	hl
	inc	hl
	ld	(hl), c
;stages/stage2.c:108: se_charge_gun(phase * 100);
	ldhl	sp,	#8
	ld	a, (hl)
	ld	c, a
	add	a, a
	add	a, c
	add	a, a
	add	a, a
	add	a, a
	add	a, c
	add	a, a
	add	a, a
	push	af
	inc	sp
	call	_se_charge_gun
	inc	sp
	ret
00102$:
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1145: shadow_OAM[nb].tile=tile;
	ld	h, #0x00
	ld	l, e
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
	inc	hl
	inc	hl
	ld	(hl), #0x00
;stages/stage2.c:111: set_sprite_prop(chargeidx, 0);
	ld	hl, #_chargeidx
	ld	c, (hl)
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1191: shadow_OAM[nb].prop=prop;
	ld	h, #0x00
	ld	l, c
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
	inc	hl
	inc	hl
	inc	hl
	ld	(hl), #0x00
;stages/stage2.c:112: move_sprite(chargeidx, 0, 0);
	ld	hl, #_chargeidx
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
;stages/stage2.c:112: move_sprite(chargeidx, 0, 0);
;stages/stage2.c:114: }
	ret
;stages/stage2.c:117: void mech_hit_anim(Machine * mch, UINT8 animcyc) BANKED {
;	---------------------------------
; Function mech_hit_anim
; ---------------------------------
	b_mech_hit_anim	= 2
_mech_hit_anim::
	add	sp, #-3
;stages/stage2.c:118: UINT8 sprdir = get_sprite_prop(mch->oamtilenums[0]);
	ldhl	sp,	#9
	ld	a, (hl+)
	ld	e, a
	ld	b, (hl)
	ld	a, e
	add	a, #0x0d
	ld	c, a
	jr	NC, 00127$
	inc	b
00127$:
	ld	a, (bc)
	ld	e, a
	ld	h, #0x00
	ld	l, e
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
;stages/stage2.c:119: const UINT8 * mechtiles = sprdir == 32 ? mechbackwtiles : mechforwtiles;
	sub	a, #0x20
	jr	NZ, 00108$
	ld	de, #_mechbackwtiles+0
	jr	00109$
00108$:
	ld	de, #_mechforwtiles+0
00109$:
	inc	sp
	inc	sp
	push	de
;stages/stage2.c:120: for(i = 0; i < 6; i++) {
	ld	hl, #_i
	ld	(hl), #0x00
	ldhl	sp,	#11
	ld	a, (hl)
	sub	a, #0x0a
	ld	a, #0x01
	jr	Z, 00131$
	xor	a, a
00131$:
	ldhl	sp,	#2
	ld	(hl), a
00104$:
;stages/stage2.c:121: set_sprite_tile(mch->oamtilenums[0] + i, animcyc == 10 ? mechtiles[i] + 6 : mechtiles[i]);
;c
	pop	de
	push	de
	ld	hl, #_i
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ld	e, a
	ldhl	sp,	#2
	ld	a, (hl)
	or	a, a
	jr	Z, 00110$
	ld	a, e
	add	a, #0x06
	ld	e, a
00110$:
	ld	a, (bc)
	ld	hl, #_i
	add	a, (hl)
	ld	d, a
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1145: shadow_OAM[nb].tile=tile;
	ld	h, #0x00
	ld	l, d
	add	hl, hl
	add	hl, hl
	push	de
	ld	de, #_shadow_OAM
	add	hl, de
	pop	de
	inc	hl
	inc	hl
	ld	(hl), e
;stages/stage2.c:120: for(i = 0; i < 6; i++) {
	ld	hl, #_i
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x06
	jr	C, 00104$
;stages/stage2.c:123: }
	add	sp, #3
	ret
;stages/stage2.c:126: void mechboss_loop() BANKED {
;	---------------------------------
; Function mechboss_loop
; ---------------------------------
	b_mechboss_loop	= 2
_mechboss_loop::
	add	sp, #-14
;stages/stage2.c:127: do {    // Intro
00101$:
;stages/stage2.c:128: move_mech(mech, -1, 0);
	xor	a, a
	ld	d,a
	ld	e,#0xff
	push	de
	ld	hl, #_mech
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ld	e, #b_move_mech
	ld	hl, #_move_mech
	call	___sdcc_bcall_ehl
	add	sp, #4
;stages/stage2.c:129: wait_vbl_done();
	call	_wait_vbl_done
;stages/stage2.c:130: } while(mech->x != 143);
	ld	hl, #_mech + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	ld	a, (bc)
	sub	a, #0x8f
	jr	NZ, 00101$
;stages/stage2.c:132: UINT8 ptrn = 0, mechdir = 1;  // mechdir: 0 - left, 1 - right
	xor	a, a
	ldhl	sp,	#2
	ld	(hl+), a
	ld	(hl), #0x01
;stages/stage2.c:133: INT8 mechspx = 0, mechspy = 0, hitanimtmr = 10;
	xor	a, a
	inc	hl
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl), a
	ldhl	sp,	#13
	ld	(hl), #0x0a
;stages/stage2.c:134: while(1) {
00199$:
;stages/stage2.c:136: if((!is_alive(pl)) && pl->explcount == 0) {
	ld	hl, #_pl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_is_alive
	add	sp, #2
	push	hl
	ldhl	sp,	#14
	ld	(hl), e
	pop	hl
	ldhl	sp,	#12
	ld	a, (hl)
	or	a, a
	jr	NZ, 00105$
	ld	hl, #_pl
	ld	a, (hl+)
	ld	e, (hl)
	ldhl	sp,	#9
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
	ldhl	sp,	#13
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#12
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jp	Z, 00201$
;stages/stage2.c:137: break;  // Game over
00105$:
;stages/stage2.c:140: if(mech->shield < 6 && is_alive(pl)) { // Boss HP = 15 regular hits
	ld	hl, #_mech
	ld	a, (hl+)
	ld	e, (hl)
	ldhl	sp,	#9
	ld	(hl+), a
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
	ldhl	sp,	#13
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#12
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	xor	a, #0x80
	sub	a, #0x86
	jr	NC, 00113$
	ld	hl, #_pl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_is_alive
	add	sp, #2
	ld	a, e
	or	a, a
	jr	Z, 00113$
;stages/stage2.c:141: if(lockmvmnt == 2) {    // Wait until the end of the jumping animation
	ld	a, (#_lockmvmnt)
	sub	a, #0x02
	jr	NZ, 00110$
;stages/stage2.c:142: anim_jump();
	call	_anim_jump
	jr	00113$
00110$:
;stages/stage2.c:143: } else if(pl->explcount == 0) {
	ld	hl, #_pl
	ld	a, (hl+)
	ld	e, (hl)
	ldhl	sp,	#9
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
	ldhl	sp,	#13
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#12
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	NZ, 00113$
;stages/stage2.c:144: bossclearflg = 1;
	ld	hl, #_bossclearflg
	ld	(hl), #0x01
;stages/stage2.c:145: clear_all_projectiles();
	call	_clear_all_projectiles
;stages/stage2.c:146: return;  // Boss cleared
	jp	00201$
00113$:
;stages/stage2.c:150: build_boss_road();
	call	_build_boss_road
;stages/stage2.c:151: incr_bkg_x_coords(4);
	ld	a, #0x04
	push	af
	inc	sp
	call	_incr_bkg_x_coords
	inc	sp
;stages/stage2.c:130: } while(mech->x != 143);
	ld	hl, #_mech
	ld	a, (hl+)
	ld	e, (hl)
	ldhl	sp,	#0
	ld	(hl+), a
	ld	(hl), e
;stages/stage2.c:153: if(mech->x == 143 && mech->y == 64) {
;c
	pop	de
	push	de
	ld	l, e
	ld	h, d
	inc	hl
	push	hl
	ld	a, l
	ldhl	sp,	#13
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#12
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	(hl), a
;c
	pop	de
	push	de
	ld	hl, #0x0002
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#8
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#7
	ld	(hl), a
	ldhl	sp,	#12
	ld	a, (hl)
	sub	a, #0x8f
	ld	a, #0x01
	jr	Z, 00507$
	xor	a, a
00507$:
	ldhl	sp,	#11
	ld	(hl), a
	or	a, a
	jp	Z, 00186$
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	sub	a, #0x40
	jp	NZ,00186$
;stages/stage2.c:154: if(ptrn == 0) {
	ldhl	sp,	#2
	ld	a, (hl)
	or	a, a
	jr	NZ, 00116$
;stages/stage2.c:155: charge_gun(mech, 0);
	xor	a, a
	push	af
	inc	sp
	ld	hl, #_mech
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ld	e, #b_charge_gun
	ld	hl, #_charge_gun
	call	___sdcc_bcall_ehl
	add	sp, #3
;stages/stage2.c:156: ptrn = 1;
	ldhl	sp,	#2
	ld	(hl), #0x01
00116$:
;stages/stage2.c:158: if(ptrn == 1 && cooldown_enemy(mech, 20)) {
	ldhl	sp,	#2
	ld	a, (hl)
	dec	a
	jr	NZ, 00132$
	ld	a, #0x14
	push	af
	inc	sp
	ld	hl, #_mech
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_cooldown_enemy
	add	sp, #3
	ld	a, e
	or	a, a
	jr	Z, 00132$
;stages/stage2.c:159: charge_gun(mech, 1);
	ld	a, #0x01
	push	af
	inc	sp
	ld	hl, #_mech
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ld	e, #b_charge_gun
	ld	hl, #_charge_gun
	call	___sdcc_bcall_ehl
	add	sp, #3
;stages/stage2.c:160: ptrn = 2;
	ldhl	sp,	#2
	ld	(hl), #0x02
	jp	00187$
00132$:
;stages/stage2.c:161: } else if(ptrn == 2 && cooldown_enemy(mech, 20)) {
	ldhl	sp,	#2
	ld	a, (hl)
	sub	a, #0x02
	jr	NZ, 00128$
	ld	a, #0x14
	push	af
	inc	sp
	ld	hl, #_mech
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_cooldown_enemy
	add	sp, #3
	ld	a, e
	or	a, a
	jr	Z, 00128$
;stages/stage2.c:162: charge_gun(mech, 2);
	ld	a, #0x02
	push	af
	inc	sp
	ld	hl, #_mech
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ld	e, #b_charge_gun
	ld	hl, #_charge_gun
	call	___sdcc_bcall_ehl
	add	sp, #3
;stages/stage2.c:163: ptrn = 3;
	ldhl	sp,	#2
	ld	(hl), #0x03
	jp	00187$
00128$:
;stages/stage2.c:164: } else if(ptrn == 3 && cooldown_enemy(mech, 20)) {
	ldhl	sp,	#2
	ld	a, (hl)
	sub	a, #0x03
	jr	NZ, 00124$
	ld	a, #0x14
	push	af
	inc	sp
	ld	hl, #_mech
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_cooldown_enemy
	add	sp, #3
	ld	a, e
	or	a, a
	jr	Z, 00124$
;stages/stage2.c:165: charge_gun(mech, 3);
	ld	a, #0x03
	push	af
	inc	sp
	ld	hl, #_mech
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ld	e, #b_charge_gun
	ld	hl, #_charge_gun
	call	___sdcc_bcall_ehl
	add	sp, #3
;stages/stage2.c:166: if(pl->x < 120) {
	ld	hl, #_pl + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	ld	a, (bc)
	sub	a, #0x78
	jr	NC, 00118$
;stages/stage2.c:167: fire_projctl_aimed_horz(mech, 4, -4);
	ld	de, #0xfc04
	push	de
	ld	hl, #_mech
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_fire_projctl_aimed_horz
	add	sp, #4
	jr	00119$
00118$:
;stages/stage2.c:169: fire_projctl_aimed_vert(mech, 4, 3);
	ld	de, #0x0304
	push	de
	ld	hl, #_mech
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_fire_projctl_aimed_vert
	add	sp, #4
00119$:
;stages/stage2.c:171: ptrn = 4;
	ldhl	sp,	#2
	ld	(hl), #0x04
	jp	00187$
00124$:
;stages/stage2.c:172: } else if(ptrn == 4 && cooldown_enemy(mech, 50)) {
	ldhl	sp,	#2
	ld	a, (hl)
	sub	a, #0x04
	jp	NZ,00187$
	ld	a, #0x32
	push	af
	inc	sp
	ld	hl, #_mech
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_cooldown_enemy
	add	sp, #3
	ld	a, e
	or	a, a
	jp	Z, 00187$
;stages/stage2.c:173: mechspy = -3;
	ldhl	sp,	#5
	ld	(hl), #0xfd
;stages/stage2.c:174: mechdir = 0;
	xor	a, a
	dec	hl
	dec	hl
	ld	(hl), a
;stages/stage2.c:175: ptrn = 0;
	xor	a, a
	dec	hl
	ld	(hl), a
	jp	00187$
00186$:
;stages/stage2.c:180: if(mech->gunoffx == fronthboffx) {
;c
	pop	de
	push	de
	ld	hl, #0x0009
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#10
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#9
;stages/stage2.c:177: } else if(mech->x == 143 && mech->y == 46) {
	ld	(hl+), a
	inc	hl
	ld	a, (hl)
	or	a, a
	jr	Z, 00182$
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	sub	a, #0x2e
	jr	NZ, 00182$
;stages/stage2.c:178: mechspx = mechdir == 0 ? -3 : 0;
	ldhl	sp,	#3
	ld	a, (hl)
	or	a, a
	jr	NZ, 00203$
	ld	bc, #0xfffd
	jr	00204$
00203$:
	ld	bc, #0x0000
00204$:
	ldhl	sp,	#4
;stages/stage2.c:179: mechspy = mechdir == 0 ? -1 : 3;
	ld	a, c
	ld	(hl-), a
	ld	a, (hl)
	or	a, a
	jr	NZ, 00205$
	ld	bc, #0xffff
	jr	00206$
00205$:
	ld	bc, #0x0003
00206$:
	ldhl	sp,	#5
	ld	(hl), c
;stages/stage2.c:180: if(mech->gunoffx == fronthboffx) {
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	ld	hl, #_fronthboffx
	ld	b, (hl)
	ld	a, c
	sub	a, b
	jp	NZ,00187$
;stages/stage2.c:181: flip_mech(mech);
	ld	hl, #_mech
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ld	e, #b_flip_mech
	ld	hl, #_flip_mech
	call	___sdcc_bcall_ehl
	add	sp, #2
	jp	00187$
00182$:
;stages/stage2.c:184: ptrn = ptrn == 0 ? 1 : ptrn;
	ldhl	sp,	#2
	ld	a, (hl)
	ldhl	sp,	#10
	ld	(hl), a
	xor	a, a
	inc	hl
;stages/stage2.c:183: } else if(mech->x == 80 && mech->y == 25) {
	ld	(hl+), a
	ld	a, (hl)
	sub	a, #0x50
	jp	NZ,00178$
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	sub	a, #0x19
	jp	NZ,00178$
;stages/stage2.c:184: ptrn = ptrn == 0 ? 1 : ptrn;
	ldhl	sp,	#2
	ld	a, (hl)
	or	a, a
	jr	NZ, 00207$
	ld	bc, #0x0001
	jr	00208$
00207$:
	ldhl	sp,#10
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
00208$:
	ldhl	sp,	#2
	ld	(hl), c
;stages/stage2.c:185: if(ptrn == 1 && cooldown_enemy(mech, 25)) {
	ld	a, (hl)
	dec	a
	jp	NZ,00146$
	ld	a, #0x19
	push	af
	inc	sp
	ld	hl, #_mech
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_cooldown_enemy
	add	sp, #3
	ld	a, e
	or	a, a
	jr	Z, 00146$
;stages/stage2.c:136: if((!is_alive(pl)) && pl->explcount == 0) {
	ld	hl, #_pl + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
;stages/stage2.c:186: if((pl->x > mech->x && mech->gunoffx == backhboffx) || (pl->x < mech->x && mech->gunoffx == fronthboffx)) {
	inc	bc
	ld	a, (bc)
	ldhl	sp,	#10
	ld	(hl), a
;stages/stage2.c:130: } while(mech->x != 143);
	ld	hl, #_mech + 1
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
;stages/stage2.c:153: if(mech->x == 143 && mech->y == 64) {
	ld	l, e
	ld	h, d
	inc	hl
	ld	c, (hl)
;stages/stage2.c:180: if(mech->gunoffx == fronthboffx) {
;c
	ld	hl, #0x0009
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#13
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#12
	ld	(hl), a
;stages/stage2.c:186: if((pl->x > mech->x && mech->gunoffx == backhboffx) || (pl->x < mech->x && mech->gunoffx == fronthboffx)) {
	ld	a, c
	dec	hl
	dec	hl
	sub	a, (hl)
	jr	NC, 00141$
	inc	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	b, a
	ld	a, (#_backhboffx)
	sub	a, b
	jr	Z, 00137$
00141$:
	ldhl	sp,	#10
	ld	a, (hl)
	sub	a, c
	jr	NC, 00138$
	inc	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	ld	a, (#_fronthboffx)
	sub	a, c
	jr	NZ, 00138$
00137$:
;stages/stage2.c:187: flip_mech(mech);  // Face towards the player
	ld	hl, #_mech
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ld	e, #b_flip_mech
	ld	hl, #_flip_mech
	call	___sdcc_bcall_ehl
	add	sp, #2
00138$:
;stages/stage2.c:189: fire_projctl_aimed_vert(mech, 1, 1);
	ld	de, #0x0101
	push	de
	ld	hl, #_mech
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_fire_projctl_aimed_vert
	add	sp, #4
;stages/stage2.c:190: ptrn = 2;
	ldhl	sp,	#2
	ld	(hl), #0x02
	jp	00187$
00146$:
;stages/stage2.c:191: } else if(ptrn == 2 && cooldown_enemy(mech, 25)) {
	ldhl	sp,	#2
	ld	a, (hl)
	sub	a, #0x02
	jp	NZ,00187$
	ld	a, #0x19
	push	af
	inc	sp
	ld	hl, #_mech
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_cooldown_enemy
	add	sp, #3
	ld	a, e
	or	a, a
	jp	Z, 00187$
;stages/stage2.c:192: mechspx = mechdir == 0 ? -3 : 3;
	ldhl	sp,	#3
	ld	a, (hl)
	or	a, a
	jr	NZ, 00209$
	ld	bc, #0xfffd
	jr	00210$
00209$:
	ld	bc, #0x0003
00210$:
	ldhl	sp,	#4
;stages/stage2.c:193: mechspy = 1;
	ld	a, c
	ld	(hl+), a
	ld	(hl), #0x01
;stages/stage2.c:194: ptrn = 0;
	xor	a, a
	ldhl	sp,	#2
	ld	(hl), a
	jp	00187$
00178$:
;stages/stage2.c:196: } else if(mech->x == 17 && mech->y == 46) {
	ldhl	sp,	#12
	ld	a, (hl)
	sub	a, #0x11
	ld	a, #0x01
	jr	Z, 00534$
	xor	a, a
00534$:
	ldhl	sp,	#12
	ld	(hl), a
	or	a, a
	jr	Z, 00174$
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	sub	a, #0x2e
	jr	NZ, 00174$
;stages/stage2.c:197: mechspx = mechdir == 0 ? 0 : 3;
	ldhl	sp,	#3
	ld	a, (hl)
	or	a, a
	jr	NZ, 00211$
	ld	bc, #0x0000
	jr	00212$
00211$:
	ld	bc, #0x0003
00212$:
	ldhl	sp,	#4
;stages/stage2.c:198: mechspy = mechdir == 0 ? 3 : -1;
	ld	a, c
	ld	(hl-), a
	ld	a, (hl)
	or	a, a
	jr	NZ, 00213$
	ldhl	sp,	#11
	ld	(hl), #0x03
	xor	a, a
	inc	hl
	ld	(hl), a
	jr	00214$
00213$:
	ldhl	sp,	#11
	ld	a, #0xff
	ld	(hl+), a
	ld	(hl), #0xff
00214$:
	ldhl	sp,	#11
	ld	a, (hl)
	ldhl	sp,	#5
	ld	(hl), a
;stages/stage2.c:199: if(mech->gunoffx == backhboffx) {
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#12
	ld	(hl), a
	ld	a, (#_backhboffx)
	ldhl	sp,	#11
	ld	(hl+), a
	ld	a, (hl-)
	sub	a, (hl)
	jp	NZ,00187$
;stages/stage2.c:200: flip_mech(mech);
	ld	hl, #_mech
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ld	e, #b_flip_mech
	ld	hl, #_flip_mech
	call	___sdcc_bcall_ehl
	add	sp, #2
	jp	00187$
00174$:
;stages/stage2.c:202: } else if(mech->x == 17 && mech->y == 64) {
	ldhl	sp,	#12
	ld	a, (hl)
	or	a, a
	jp	Z, 00187$
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	sub	a, #0x40
	jp	NZ,00187$
;stages/stage2.c:203: ptrn = ptrn == 0 ? 1 : ptrn;
	ldhl	sp,	#2
	ld	a, (hl)
	or	a, a
	jr	NZ, 00215$
	ldhl	sp,	#7
	ld	(hl), #0x01
	xor	a, a
	inc	hl
	ld	(hl), a
	jr	00216$
00215$:
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	e, (hl)
	ldhl	sp,	#7
	ld	(hl+), a
	ld	(hl), e
00216$:
	ldhl	sp,	#7
	ld	a, (hl)
	ldhl	sp,	#2
;stages/stage2.c:204: if(ptrn == 1 && cooldown_enemy(mech, 10)) {
	ld	(hl), a
	dec	a
	jr	NZ, 00167$
	ld	a, #0x0a
	push	af
	inc	sp
	ld	hl, #_mech
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_cooldown_enemy
	add	sp, #3
	ld	a, e
	or	a, a
	jr	Z, 00167$
;stages/stage2.c:205: fire_projctl(mech, 1, 2, 0);
	xor	a, a
	ld	d,a
	ld	e,#0x02
	push	de
	ld	a, #0x01
	push	af
	inc	sp
	ld	hl, #_mech
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_fire_projctl
	add	sp, #5
;stages/stage2.c:206: ptrn = 2;
	ldhl	sp,	#2
	ld	(hl), #0x02
	jp	00187$
00167$:
;stages/stage2.c:207: } else if(ptrn == 2 && cooldown_enemy(mech, 10)) {
	ldhl	sp,	#2
	ld	a, (hl)
	sub	a, #0x02
	jr	NZ, 00163$
	ld	a, #0x0a
	push	af
	inc	sp
	ld	hl, #_mech
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_cooldown_enemy
	add	sp, #3
	ld	a, e
	or	a, a
	jr	Z, 00163$
;stages/stage2.c:208: fire_projctl(mech, 1, 2, 1);
	ld	de, #0x0102
	push	de
	ld	a, #0x01
	push	af
	inc	sp
	ld	hl, #_mech
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_fire_projctl
	add	sp, #5
;stages/stage2.c:209: ptrn = 3;
	ldhl	sp,	#2
	ld	(hl), #0x03
	jp	00187$
00163$:
;stages/stage2.c:210: } else if(ptrn == 3 && cooldown_enemy(mech, 10)) {
	ldhl	sp,	#2
	ld	a, (hl)
	sub	a, #0x03
	jr	NZ, 00159$
	ld	a, #0x0a
	push	af
	inc	sp
	ld	hl, #_mech
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_cooldown_enemy
	add	sp, #3
	ld	a, e
	or	a, a
	jr	Z, 00159$
;stages/stage2.c:211: fire_projctl(mech, 1, 1, 2);
	ld	de, #0x0201
	push	de
	ld	a, #0x01
	push	af
	inc	sp
	ld	hl, #_mech
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_fire_projctl
	add	sp, #5
;stages/stage2.c:212: ptrn = 4;
	ldhl	sp,	#2
	ld	(hl), #0x04
	jr	00187$
00159$:
;stages/stage2.c:213: } else if(ptrn == 4 && cooldown_enemy(mech, 10)) {
	ldhl	sp,	#2
	ld	a, (hl)
	sub	a, #0x04
	jr	NZ, 00155$
	ld	a, #0x0a
	push	af
	inc	sp
	ld	hl, #_mech
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_cooldown_enemy
	add	sp, #3
	ld	a, e
	or	a, a
	jr	Z, 00155$
;stages/stage2.c:214: fire_projctl(mech, 1, 0, 2);
	ld	a, #0x02
	push	af
	inc	sp
	xor	a, a
	ld	d,a
	ld	e,#0x01
	push	de
	ld	hl, #_mech
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_fire_projctl
	add	sp, #5
;stages/stage2.c:215: ptrn = 5;
	ldhl	sp,	#2
	ld	(hl), #0x05
	jr	00187$
00155$:
;stages/stage2.c:216: } else if(ptrn == 5 && cooldown_enemy(mech, 20)) {
	ldhl	sp,	#2
	ld	a, (hl)
	sub	a, #0x05
	jr	NZ, 00187$
	ld	a, #0x14
	push	af
	inc	sp
	ld	hl, #_mech
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_cooldown_enemy
	add	sp, #3
	ld	a, e
	or	a, a
	jr	Z, 00187$
;stages/stage2.c:217: mechspy = -3;
	ldhl	sp,	#5
;stages/stage2.c:218: mechdir = 1;
	ld	a, #0xfd
	ld	(hl-), a
	dec	hl
	ld	(hl), #0x01
;stages/stage2.c:219: ptrn = 0;
	xor	a, a
	dec	hl
	ld	(hl), a
00187$:
;stages/stage2.c:222: if(ptrn == 0) {
	ldhl	sp,	#2
	ld	a, (hl)
	or	a, a
	jr	NZ, 00190$
;stages/stage2.c:223: move_mech(mech, mechspx, mechspy);
	ldhl	sp,	#5
	ld	a, (hl)
	push	af
	inc	sp
	dec	hl
	ld	a, (hl)
	push	af
	inc	sp
	ld	hl, #_mech
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ld	e, #b_move_mech
	ld	hl, #_move_mech
	call	___sdcc_bcall_ehl
	add	sp, #4
00190$:
;stages/stage2.c:226: if(hitmchptr != NULL) {
	ld	hl, #_hitmchptr + 1
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00197$
;stages/stage2.c:227: if(hitanimtmr == 10) {
	ldhl	sp,	#13
	ld	a, (hl)
	sub	a, #0x0a
	jr	NZ, 00194$
;stages/stage2.c:228: mech_hit_anim(mech, hitanimtmr);
	ldhl	sp,	#13
	ld	a, (hl)
	push	af
	inc	sp
	ld	hl, #_mech
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ld	e, #b_mech_hit_anim
	ld	hl, #_mech_hit_anim
	call	___sdcc_bcall_ehl
	add	sp, #3
	jr	00195$
00194$:
;stages/stage2.c:229: } else if(hitanimtmr == 0) {
	ldhl	sp,	#13
	ld	a, (hl)
	or	a, a
	jr	NZ, 00195$
;stages/stage2.c:230: mech_hit_anim(mech, hitanimtmr);
	ld	a, (hl)
	push	af
	inc	sp
	ld	hl, #_mech
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ld	e, #b_mech_hit_anim
	ld	hl, #_mech_hit_anim
	call	___sdcc_bcall_ehl
	add	sp, #3
;stages/stage2.c:231: hitmchptr = NULL;
	ld	hl, #_hitmchptr
	ld	a, #0x00
	ld	(hl+), a
	ld	(hl), #0x00
;stages/stage2.c:232: hitanimtmr = 11;
	ldhl	sp,	#13
	ld	(hl), #0x0b
00195$:
;stages/stage2.c:234: hitanimtmr--;
	ldhl	sp,	#13
	dec	(hl)
00197$:
;stages/stage2.c:238: manage_projectiles();
	call	_manage_projectiles
;stages/stage2.c:239: manage_machines();
	call	_manage_machines
;stages/stage2.c:240: manage_sound_chnls();
	call	_manage_sound_chnls
;stages/stage2.c:241: manage_player();
	call	_manage_player
;stages/stage2.c:242: wait_vbl_done();
	call	_wait_vbl_done
	jp	00199$
00201$:
;stages/stage2.c:244: }
	add	sp, #14
	ret
;stages/stage2.c:248: void mech_clear_sequence() BANKED {
;	---------------------------------
; Function mech_clear_sequence
; ---------------------------------
	b_mech_clear_sequence	= 2
_mech_clear_sequence::
;stages/stage2.c:249: set_sprite_tile(chargeidx, 0);
	ld	hl, #_chargeidx
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
;stages/stage2.c:250: while(1) {
00104$:
;stages/stage2.c:252: build_boss_road();
	call	_build_boss_road
;stages/stage2.c:253: incr_bkg_x_coords(4);
	ld	a, #0x04
	push	af
	inc	sp
	call	_incr_bkg_x_coords
	inc	sp
;stages/stage2.c:255: move_mech(mech, 1, 0);
	xor	a, a
	ld	d,a
	ld	e,#0x01
	push	de
	ld	hl, #_mech
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ld	e, #b_move_mech
	ld	hl, #_move_mech
	call	___sdcc_bcall_ehl
	add	sp, #4
;stages/stage2.c:256: if(mech->x > 168) {
	ld	hl, #_mech + 1
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	ld	a, (bc)
	ld	c, a
	ld	a, #0xa8
	sub	a, c
	ret	C
;stages/stage2.c:260: manage_machines();
	call	_manage_machines
;stages/stage2.c:261: manage_sound_chnls();
	call	_manage_sound_chnls
;stages/stage2.c:262: wait_vbl_done();
	call	_wait_vbl_done
;stages/stage2.c:264: }
	jr	00104$
	.area _CODE_2
	.area _CABS (ABS)
