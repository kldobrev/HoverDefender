;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.0 #12072 (MINGW32)
;--------------------------------------------------------
	.module bank1
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _clear_all_sprites
	.globl _init_game
	.globl _mute_music_pl_chnl
	.globl _anim_blackout
	.globl _stop_song
	.globl _play_song
	.globl _anim_reverse_blackout
	.globl _custom_delay
	.globl _fill_bkg_rect
	.globl _set_sprite_data
	.globl _set_bkg_tile_xy
	.globl _set_bkg_tiles
	.globl _set_bkg_data
	.globl _waitpad
	.globl _joypad
	.globl _gameoveropts
	.globl _titlelogomap
	.globl _fonttiles
	.globl _titlelogotiles
	.globl _misctiles
	.globl b_init_common_menu_props
	.globl _init_common_menu_props
	.globl b_main_menu
	.globl _main_menu
	.globl b_get_menu_pl_input
	.globl _get_menu_pl_input
	.globl b_stage_intro_screen
	.globl _stage_intro_screen
	.globl b_game_over_menu
	.globl _game_over_menu
	.globl b_demo_end_screen
	.globl _demo_end_screen
	.globl b_se_move_cursor
	.globl _se_move_cursor
	.globl b_se_choose_entry
	.globl _se_choose_entry
	.globl b_password_menu
	.globl _password_menu
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
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
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE_1
;menus.c:40: void init_common_menu_props() BANKED {
;	---------------------------------
; Function init_common_menu_props
; ---------------------------------
	b_init_common_menu_props	= 1
_init_common_menu_props::
;menus.c:41: set_bkg_data(0, 1, blanktile);
	ld	hl, #_blanktile
	push	hl
	ld	a, #0x01
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_set_bkg_data
	add	sp, #4
;menus.c:42: set_bkg_data(1, 41, fonttiles);
	ld	hl, #_fonttiles
	push	hl
	ld	de, #0x2901
	push	de
	call	_set_bkg_data
	add	sp, #4
;menus.c:43: fill_bkg_rect(0, 0, 32, 18, 0x00);
	xor	a, a
	ld	d,a
	ld	e,#0x12
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
;menus.c:44: set_sprite_data(0, 1, misctiles);
	ld	hl, #_misctiles
	push	hl
	ld	a, #0x01
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_set_sprite_data
	add	sp, #4
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1145: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 0x0002)
	ld	(hl), #0x00
;menus.c:45: set_sprite_tile(0, 0);
;menus.c:46: }
	ret
_misctiles:
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x38	; 56	'8'
	.db #0x38	; 56	'8'
	.db #0x16	; 22
	.db #0x1e	; 30
	.db #0x1f	; 31
	.db #0x11	; 17
	.db #0x26	; 38
	.db #0x3e	; 62
	.db #0x78	; 120	'x'
	.db #0x78	; 120	'x'
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x00	; 0
_titlelogotiles:
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
	.db #0x80	; 128
	.db #0x60	; 96
	.db #0xe0	; 224
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
	.db #0x7c	; 124
	.db #0x0c	; 12
	.db #0x7c	; 124
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x60	; 96
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x80	; 128
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x81	; 129
	.db #0x80	; 128
	.db #0x01	; 1
	.db #0x3c	; 60
	.db #0x7c	; 124
	.db #0x18	; 24
	.db #0xf8	; 248
	.db #0x78	; 120	'x'
	.db #0xf8	; 248
	.db #0x18	; 24
	.db #0xf8	; 248
	.db #0x78	; 120	'x'
	.db #0xf8	; 248
	.db #0x30	; 48	'0'
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0x30	; 48	'0'
	.db #0xf0	; 240
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
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x01	; 1
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x03	; 3
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x07	; 7
	.db #0x1e	; 30
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x06	; 6
	.db #0x3e	; 62
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0x7f	; 127
	.db #0x03	; 3
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x07	; 7
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0x07	; 7
	.db #0x03	; 3
	.db #0x07	; 7
	.db #0x01	; 1
	.db #0x07	; 7
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0x60	; 96
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xc1	; 193
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc1	; 193
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x0c	; 12
	.db #0x3c	; 60
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x0c	; 12
	.db #0x7c	; 124
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0x18	; 24
	.db #0x78	; 120	'x'
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x0f	; 15
	.db #0x03	; 3
	.db #0x0f	; 15
	.db #0x07	; 7
	.db #0x0f	; 15
	.db #0x03	; 3
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x1f	; 31
	.db #0x03	; 3
	.db #0x1f	; 31
	.db #0x0f	; 15
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x83	; 131
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x83	; 131
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
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
	.db #0x86	; 134
	.db #0x7e	; 126
	.db #0xe1	; 225
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x01	; 1
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x83	; 131
	.db #0x7f	; 127
	.db #0xe0	; 224
	.db #0x1f	; 31
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0xe0	; 224
	.db #0x07	; 7
	.db #0x01	; 1
	.db #0xc7	; 199
	.db #0x80	; 128
	.db #0x07	; 7
	.db #0x03	; 3
	.db #0x87	; 135
	.db #0x80	; 128
	.db #0x07	; 7
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc1	; 193
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x7e	; 126
	.db #0x01	; 1
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x03	; 3
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x06	; 6
	.db #0x1e	; 30
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x06	; 6
	.db #0x1e	; 30
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x03	; 3
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x07	; 7
	.db #0x0f	; 15
	.db #0x01	; 1
	.db #0x1f	; 31
	.db #0x07	; 7
	.db #0x1f	; 31
	.db #0x03	; 3
	.db #0x1f	; 31
	.db #0xc1	; 193
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc3	; 195
	.db #0xc0	; 192
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x87	; 135
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x87	; 135
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x06	; 6
	.db #0x1e	; 30
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x07	; 7
	.db #0x1e	; 30
	.db #0x01	; 1
	.db #0xf0	; 240
	.db #0x0f	; 15
	.db #0x0e	; 14
	.db #0x01	; 1
	.db #0xf0	; 240
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0e	; 14
	.db #0x3e	; 62
	.db #0x06	; 6
	.db #0x7e	; 126
	.db #0x1c	; 28
	.db #0xfc	; 252
	.db #0x0c	; 12
	.db #0xfc	; 252
	.db #0x38	; 56	'8'
	.db #0xf8	; 248
	.db #0x60	; 96
	.db #0xe0	; 224
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x1f	; 31
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
	.db #0x7e	; 126
	.db #0x01	; 1
	.db #0x07	; 7
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
	.db #0x81	; 129
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
	.db #0x38	; 56	'8'
	.db #0xf8	; 248
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0x7e	; 126
	.db #0x01	; 1
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x03	; 3
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x03	; 3
	.db #0x1e	; 30
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x06	; 6
	.db #0x1e	; 30
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x01	; 1
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x0f	; 15
	.db #0x03	; 3
	.db #0x1f	; 31
	.db #0x0f	; 15
	.db #0x3f	; 63
	.db #0x06	; 6
	.db #0x3e	; 62
	.db #0x0c	; 12
	.db #0x7c	; 124
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x06	; 6
	.db #0x3c	; 60
	.db #0x01	; 1
	.db #0xf0	; 240
	.db #0x0f	; 15
	.db #0x7c	; 124
	.db #0x03	; 3
	.db #0xe0	; 224
	.db #0x1f	; 31
	.db #0x78	; 120	'x'
	.db #0x07	; 7
	.db #0xe0	; 224
	.db #0x1f	; 31
	.db #0xf0	; 240
	.db #0x0f	; 15
	.db #0x04	; 4
	.db #0xfc	; 252
	.db #0x18	; 24
	.db #0xf8	; 248
	.db #0x10	; 16
	.db #0xf0	; 240
	.db #0x20	; 32
	.db #0xe0	; 224
	.db #0x20	; 32
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x3f	; 63
	.db #0xe0	; 224
	.db #0x1e	; 30
	.db #0xc0	; 192
	.db #0x3c	; 60
	.db #0xe0	; 224
	.db #0x18	; 24
	.db #0x80	; 128
	.db #0x78	; 120	'x'
	.db #0xe0	; 224
	.db #0x10	; 16
	.db #0x80	; 128
	.db #0x60	; 96
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x1f	; 31
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
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0x07	; 7
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
	.db #0xff	; 255
	.db #0xe0	; 224
	.db #0x1f	; 31
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
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0x70	; 112	'p'
	.db #0xf0	; 240
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0x01	; 1
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0x01	; 1
	.db #0x1e	; 30
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x02	; 2
	.db #0x1e	; 30
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0xc0	; 192
	.db #0x3f	; 63
	.db #0x03	; 3
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
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
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
	.db #0x03	; 3
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x07	; 7
	.db #0x7e	; 126
	.db #0x01	; 1
	.db #0xf0	; 240
	.db #0x0f	; 15
	.db #0x78	; 120	'x'
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x08	; 8
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x0f	; 15
	.db #0xff	; 255
	.db #0x03	; 3
	.db #0xff	; 255
	.db #0x1f	; 31
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x81	; 129
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0x10	; 16
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0x1f	; 31
	.db #0xf8	; 248
	.db #0x07	; 7
	.db #0xc0	; 192
	.db #0x3f	; 63
	.db #0xf0	; 240
	.db #0x0f	; 15
	.db #0xc0	; 192
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3e	; 62
	.db #0xfe	; 254
	.db #0x0e	; 14
	.db #0xfe	; 254
	.db #0x7c	; 124
	.db #0xfc	; 252
	.db #0x1c	; 28
	.db #0xfc	; 252
	.db #0x7c	; 124
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0f	; 15
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
	.db #0x3f	; 63
	.db #0x00	; 0
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
	.db #0xff	; 255
	.db #0xe0	; 224
	.db #0x1f	; 31
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
	.db #0x80	; 128
	.db #0x40	; 64
	.db #0xc0	; 192
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x01	; 1
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x01	; 1
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x03	; 3
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xc0	; 192
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x81	; 129
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0x30	; 48	'0'
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0x30	; 48	'0'
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0x60	; 96
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xfc	; 252
	.db #0x03	; 3
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x07	; 7
	.db #0x3e	; 62
	.db #0x01	; 1
	.db #0xf0	; 240
	.db #0x0f	; 15
	.db #0x3c	; 60
	.db #0x03	; 3
	.db #0xf0	; 240
	.db #0x0f	; 15
	.db #0x7c	; 124
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x07	; 7
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x0e	; 14
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x80	; 128
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
	.db #0xe0	; 224
	.db #0x19	; 25
	.db #0x78	; 120	'x'
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0x18	; 24
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x30	; 48	'0'
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x30	; 48	'0'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0xf8	; 248
	.db #0x04	; 4
	.db #0xfc	; 252
	.db #0x1f	; 31
	.db #0x7f	; 127
	.db #0x0f	; 15
	.db #0x3f	; 63
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x07	; 7
	.db #0x0f	; 15
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
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
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x20	; 32
	.db #0x3f	; 63
	.db #0x3b	; 59
	.db #0x0e	; 14
	.db #0x0a	; 10
	.db #0x0e	; 14
	.db #0x0a	; 10
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xf0	; 240
	.db #0x10	; 16
	.db #0xf8	; 248
	.db #0xc8	; 200
	.db #0x38	; 56	'8'
	.db #0x28	; 40
	.db #0x3c	; 60
	.db #0x24	; 36
	.db #0x0e	; 14
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0e	; 14
	.db #0x0a	; 10
	.db #0x0e	; 14
	.db #0x0a	; 10
	.db #0x0e	; 14
	.db #0x0a	; 10
	.db #0x0e	; 14
	.db #0x3b	; 59
	.db #0x3f	; 63
	.db #0x20	; 32
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x1c	; 28
	.db #0x14	; 20
	.db #0x14	; 20
	.db #0x1c	; 28
	.db #0x14	; 20
	.db #0x1c	; 28
	.db #0x24	; 36
	.db #0x3c	; 60
	.db #0x28	; 40
	.db #0x38	; 56	'8'
	.db #0xc8	; 200
	.db #0xf8	; 248
	.db #0x10	; 16
	.db #0xf0	; 240
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x20	; 32
	.db #0x3f	; 63
	.db #0x2f	; 47
	.db #0x38	; 56	'8'
	.db #0x28	; 40
	.db #0x38	; 56	'8'
	.db #0x28	; 40
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0x04	; 4
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x2f	; 47
	.db #0x20	; 32
	.db #0x3f	; 63
	.db #0x2f	; 47
	.db #0x3f	; 63
	.db #0x28	; 40
	.db #0x38	; 56	'8'
	.db #0x28	; 40
	.db #0x38	; 56	'8'
	.db #0x2f	; 47
	.db #0x3f	; 63
	.db #0x20	; 32
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0x04	; 4
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0x04	; 4
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0x3f	; 63
	.db #0x2f	; 47
	.db #0x20	; 32
	.db #0x3f	; 63
	.db #0x2f	; 47
	.db #0x3f	; 63
	.db #0x28	; 40
	.db #0x38	; 56	'8'
	.db #0x28	; 40
	.db #0x38	; 56	'8'
	.db #0x28	; 40
	.db #0x38	; 56	'8'
	.db #0x28	; 40
	.db #0x38	; 56	'8'
	.db #0x38	; 56	'8'
	.db #0x38	; 56	'8'
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0x04	; 4
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
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
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x3e	; 62
	.db #0x22	; 34
	.db #0x3e	; 62
	.db #0x22	; 34
	.db #0x3f	; 63
	.db #0x29	; 41
	.db #0x3f	; 63
	.db #0x2c	; 44
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1c	; 28
	.db #0x1c	; 28
	.db #0x1c	; 28
	.db #0x14	; 20
	.db #0x1c	; 28
	.db #0x14	; 20
	.db #0x1c	; 28
	.db #0x14	; 20
	.db #0x9c	; 156
	.db #0x94	; 148
	.db #0x3f	; 63
	.db #0x2c	; 44
	.db #0x2a	; 42
	.db #0x3b	; 59
	.db #0x29	; 41
	.db #0x39	; 57	'9'
	.db #0x29	; 41
	.db #0x39	; 57	'9'
	.db #0x28	; 40
	.db #0x38	; 56	'8'
	.db #0x28	; 40
	.db #0x38	; 56	'8'
	.db #0x28	; 40
	.db #0x38	; 56	'8'
	.db #0x38	; 56	'8'
	.db #0x38	; 56	'8'
	.db #0x9c	; 156
	.db #0x94	; 148
	.db #0x54	; 84	'T'
	.db #0xdc	; 220
	.db #0x34	; 52	'4'
	.db #0xfc	; 252
	.db #0x34	; 52	'4'
	.db #0xfc	; 252
	.db #0x94	; 148
	.db #0xfc	; 252
	.db #0x44	; 68	'D'
	.db #0x7c	; 124
	.db #0x44	; 68	'D'
	.db #0x7c	; 124
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x20	; 32
	.db #0x3f	; 63
	.db #0x2f	; 47
	.db #0x38	; 56	'8'
	.db #0x28	; 40
	.db #0x38	; 56	'8'
	.db #0x28	; 40
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf8	; 248
	.db #0x08	; 8
	.db #0xfc	; 252
	.db #0xe4	; 228
	.db #0x1c	; 28
	.db #0x14	; 20
	.db #0x1c	; 28
	.db #0x14	; 20
	.db #0x3f	; 63
	.db #0x2f	; 47
	.db #0x20	; 32
	.db #0x3f	; 63
	.db #0x23	; 35
	.db #0x3f	; 63
	.db #0x29	; 41
	.db #0x3f	; 63
	.db #0x2c	; 44
	.db #0x3f	; 63
	.db #0x2b	; 43
	.db #0x3b	; 59
	.db #0x28	; 40
	.db #0x38	; 56	'8'
	.db #0x38	; 56	'8'
	.db #0x38	; 56	'8'
	.db #0xfc	; 252
	.db #0xe4	; 228
	.db #0x08	; 8
	.db #0xf8	; 248
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x60	; 96
	.db #0xe0	; 224
	.db #0x1c	; 28
	.db #0xfc	; 252
	.db #0xc4	; 196
	.db #0xfc	; 252
	.db #0x3c	; 60
	.db #0x3c	; 60
_fonttiles:
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
	.db #0x22	; 34
	.db #0x22	; 34
	.db #0x22	; 34
	.db #0x22	; 34
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0x7c	; 124
	.db #0x7c	; 124
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1e	; 30
	.db #0x1e	; 30
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x78	; 120	'x'
	.db #0x78	; 120	'x'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0e	; 14
	.db #0x0e	; 14
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x1c	; 28
	.db #0x1c	; 28
	.db #0x22	; 34
	.db #0x22	; 34
	.db #0x22	; 34
	.db #0x22	; 34
	.db #0x1c	; 28
	.db #0x1c	; 28
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
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
	.db #0x38	; 56	'8'
	.db #0x38	; 56	'8'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1c	; 28
	.db #0x1c	; 28
	.db #0x22	; 34
	.db #0x22	; 34
	.db #0x22	; 34
	.db #0x22	; 34
	.db #0x1c	; 28
	.db #0x1c	; 28
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x38	; 56	'8'
	.db #0x38	; 56	'8'
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
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x12	; 18
	.db #0x12	; 18
	.db #0x12	; 18
	.db #0x12	; 18
	.db #0x1c	; 28
	.db #0x1c	; 28
	.db #0x24	; 36
	.db #0x24	; 36
	.db #0x24	; 36
	.db #0x24	; 36
	.db #0x78	; 120	'x'
	.db #0x78	; 120	'x'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1c	; 28
	.db #0x1c	; 28
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x38	; 56	'8'
	.db #0x38	; 56	'8'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x12	; 18
	.db #0x12	; 18
	.db #0x12	; 18
	.db #0x12	; 18
	.db #0x24	; 36
	.db #0x24	; 36
	.db #0x24	; 36
	.db #0x24	; 36
	.db #0x24	; 36
	.db #0x24	; 36
	.db #0x78	; 120	'x'
	.db #0x78	; 120	'x'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1e	; 30
	.db #0x1e	; 30
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x7c	; 124
	.db #0x7c	; 124
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1e	; 30
	.db #0x1e	; 30
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
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
	.db #0x4c	; 76	'L'
	.db #0x4c	; 76	'L'
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x24	; 36
	.db #0x24	; 36
	.db #0x24	; 36
	.db #0x24	; 36
	.db #0x24	; 36
	.db #0x24	; 36
	.db #0x38	; 56	'8'
	.db #0x38	; 56	'8'
	.db #0x48	; 72	'H'
	.db #0x48	; 72	'H'
	.db #0x48	; 72	'H'
	.db #0x48	; 72	'H'
	.db #0x48	; 72	'H'
	.db #0x48	; 72	'H'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x38	; 56	'8'
	.db #0x38	; 56	'8'
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x70	; 112	'p'
	.db #0x70	; 112	'p'
	.db #0x00	; 0
	.db #0x00	; 0
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
	.db #0x48	; 72	'H'
	.db #0x48	; 72	'H'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x24	; 36
	.db #0x24	; 36
	.db #0x24	; 36
	.db #0x24	; 36
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x48	; 72	'H'
	.db #0x48	; 72	'H'
	.db #0x48	; 72	'H'
	.db #0x48	; 72	'H'
	.db #0x48	; 72	'H'
	.db #0x48	; 72	'H'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x1c	; 28
	.db #0x1c	; 28
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x22	; 34
	.db #0x22	; 34
	.db #0x36	; 54	'6'
	.db #0x36	; 54	'6'
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
	.db #0x1c	; 28
	.db #0x1c	; 28
	.db #0x22	; 34
	.db #0x22	; 34
	.db #0x22	; 34
	.db #0x22	; 34
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0x54	; 84	'T'
	.db #0x54	; 84	'T'
	.db #0x24	; 36
	.db #0x24	; 36
	.db #0x58	; 88	'X'
	.db #0x58	; 88	'X'
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
	.db #0x50	; 80	'P'
	.db #0x50	; 80	'P'
	.db #0x48	; 72	'H'
	.db #0x48	; 72	'H'
	.db #0x48	; 72	'H'
	.db #0x48	; 72	'H'
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
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
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
	.db #0x12	; 18
	.db #0x12	; 18
	.db #0x12	; 18
	.db #0x12	; 18
	.db #0x12	; 18
	.db #0x12	; 18
	.db #0x24	; 36
	.db #0x24	; 36
	.db #0x24	; 36
	.db #0x24	; 36
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x22	; 34
	.db #0x22	; 34
	.db #0x22	; 34
	.db #0x22	; 34
	.db #0x22	; 34
	.db #0x22	; 34
	.db #0x24	; 36
	.db #0x24	; 36
	.db #0x54	; 84	'T'
	.db #0x54	; 84	'T'
	.db #0x6c	; 108	'l'
	.db #0x6c	; 108	'l'
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x24	; 36
	.db #0x24	; 36
	.db #0x24	; 36
	.db #0x24	; 36
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x48	; 72	'H'
	.db #0x48	; 72	'H'
	.db #0x48	; 72	'H'
	.db #0x48	; 72	'H'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x24	; 36
	.db #0x24	; 36
	.db #0x24	; 36
	.db #0x24	; 36
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x7c	; 124
	.db #0x7c	; 124
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
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
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x48	; 72	'H'
	.db #0x48	; 72	'H'
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x20	; 32
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
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x80	; 128
	.db #0x80	; 128
_titlelogomap:
	.db #0x00	; 0
	.db #0x21	; 33
	.db #0x22	; 34
	.db #0x23	; 35
	.db #0x2f	; 47
	.db #0x30	; 48	'0'
	.db #0x00	; 0
	.db #0x3a	; 58
	.db #0x3b	; 59
	.db #0x3c	; 60
	.db #0x45	; 69	'E'
	.db #0x46	; 70	'F'
	.db #0x47	; 71	'G'
	.db #0x51	; 81	'Q'
	.db #0x52	; 82	'R'
	.db #0x53	; 83	'S'
	.db #0x00	; 0
	.db #0x24	; 36
	.db #0x25	; 37
	.db #0x26	; 38
	.db #0x31	; 49	'1'
	.db #0x32	; 50	'2'
	.db #0x33	; 51	'3'
	.db #0x3d	; 61
	.db #0x3e	; 62
	.db #0x3f	; 63
	.db #0x48	; 72	'H'
	.db #0x49	; 73	'I'
	.db #0x4a	; 74	'J'
	.db #0x54	; 84	'T'
	.db #0x55	; 85	'U'
	.db #0x56	; 86	'V'
	.db #0x27	; 39
	.db #0x28	; 40
	.db #0x29	; 41
	.db #0x2a	; 42
	.db #0x34	; 52	'4'
	.db #0x35	; 53	'5'
	.db #0x36	; 54	'6'
	.db #0x40	; 64
	.db #0x41	; 65	'A'
	.db #0x42	; 66	'B'
	.db #0x4b	; 75	'K'
	.db #0x4c	; 76	'L'
	.db #0x4d	; 77	'M'
	.db #0x57	; 87	'W'
	.db #0x58	; 88	'X'
	.db #0x59	; 89	'Y'
	.db #0x2b	; 43
	.db #0x2c	; 44
	.db #0x2d	; 45
	.db #0x2e	; 46
	.db #0x37	; 55	'7'
	.db #0x38	; 56	'8'
	.db #0x39	; 57	'9'
	.db #0x43	; 67	'C'
	.db #0x00	; 0
	.db #0x44	; 68	'D'
	.db #0x4e	; 78	'N'
	.db #0x4f	; 79	'O'
	.db #0x50	; 80	'P'
	.db #0x5a	; 90	'Z'
	.db #0x5b	; 91
	.db #0x5c	; 92
	.db #0x5d	; 93
	.db #0x5e	; 94
	.db #0x61	; 97	'a'
	.db #0x62	; 98	'b'
	.db #0x61	; 97	'a'
	.db #0x62	; 98	'b'
	.db #0x61	; 97	'a'
	.db #0x62	; 98	'b'
	.db #0x67	; 103	'g'
	.db #0x68	; 104	'h'
	.db #0x5d	; 93
	.db #0x5e	; 94
	.db #0x61	; 97	'a'
	.db #0x62	; 98	'b'
	.db #0x6b	; 107	'k'
	.db #0x6c	; 108	'l'
	.db #0x5f	; 95
	.db #0x60	; 96
	.db #0x63	; 99	'c'
	.db #0x64	; 100	'd'
	.db #0x65	; 101	'e'
	.db #0x66	; 102	'f'
	.db #0x63	; 99	'c'
	.db #0x64	; 100	'd'
	.db #0x69	; 105	'i'
	.db #0x6a	; 106	'j'
	.db #0x5f	; 95
	.db #0x60	; 96
	.db #0x63	; 99	'c'
	.db #0x64	; 100	'd'
	.db #0x6d	; 109	'm'
	.db #0x6e	; 110	'n'
_gameoveropts:
	.db #0x60	; 96
	.db #0x70	; 112	'p'
;menus.c:49: void main_menu() BANKED {
;	---------------------------------
; Function main_menu
; ---------------------------------
	b_main_menu	= 1
_main_menu::
	add	sp, #-12
;menus.c:50: init_common_menu_props();
	ld	e, #b_init_common_menu_props
	ld	hl, #_init_common_menu_props
	call	___sdcc_bcall_ehl
;menus.c:51: const unsigned char pressstartsign[] = {0x1A, 0x1C, 0x0F, 0x1D, 0x1D, 0x00, 0x00, 0x1D, 0x1E, 0x0B, 0x1C, 0x1E};   // DEMO CODE
	ldhl	sp,	#0
	ld	c, l
	ld	b, h
	ld	(hl), #0x1a
	ld	l, c
	ld	h, b
	inc	hl
	ld	(hl), #0x1c
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	ld	(hl), #0x0f
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	inc	hl
	ld	(hl), #0x1d
	ld	hl, #0x0004
	add	hl, bc
	ld	(hl), #0x1d
	ld	hl, #0x0005
	add	hl, bc
	ld	(hl), #0x00
	ld	hl, #0x0006
	add	hl, bc
	ld	(hl), #0x00
	ld	hl, #0x0007
	add	hl, bc
	ld	(hl), #0x1d
	ld	hl, #0x0008
	add	hl, bc
	ld	(hl), #0x1e
	ld	hl, #0x0009
	add	hl, bc
	ld	(hl), #0x0b
	ld	hl, #0x000a
	add	hl, bc
	ld	(hl), #0x1c
	ld	hl, #0x000b
	add	hl, bc
	ld	(hl), #0x1e
;menus.c:52: set_bkg_data(33, 78, titlelogotiles);
	ld	hl, #_titlelogotiles
	push	hl
	ld	de, #0x4e21
	push	de
	call	_set_bkg_data
	add	sp, #4
;menus.c:53: set_bkg_tiles(2, 1,  16, 6, titlelogomap);
	ld	hl, #_titlelogomap
	push	hl
	ld	de, #0x0610
	push	de
	ld	de, #0x0102
	push	de
	call	_set_bkg_tiles
	add	sp, #6
;menus.c:54: anim_reverse_blackout();
	push	bc
	call	_anim_reverse_blackout
	ld	a, #0x01
	push	af
	inc	sp
	ld	hl, #_titletheme
	push	hl
	call	_play_song
	add	sp, #3
	ld	de, #0x010c
	push	de
	ld	de, #0x0b04
	push	de
	call	_set_bkg_tiles
	add	sp, #6
;menus.c:57: waitpad(J_START);   // DEMO CODE
	ld	a, #0x80
	push	af
	inc	sp
	call	_waitpad
	inc	sp
;menus.c:58: stop_song();   // DEMO CODE
	call	_stop_song
;menus.c:59: se_choose_entry();   // DEMO CODE
	ld	e, #b_se_choose_entry
	ld	hl, #_se_choose_entry
	call	___sdcc_bcall_ehl
;menus.c:60: anim_blackout();
	call	_anim_blackout
;menus.c:61: }
	add	sp, #12
	ret
;menus.c:64: void get_menu_pl_input(UINT8 * entries, UINT8 numentries) BANKED {
;	---------------------------------
; Function get_menu_pl_input
; ---------------------------------
	b_get_menu_pl_input	= 1
_get_menu_pl_input::
;menus.c:65: menuidx = 0; // First option set be default
	ld	hl, #_menuidx
	ld	(hl), #0x00
;menus.c:66: while(1) {
00110$:
;menus.c:67: if(joypad() & (J_DOWN | J_SELECT)) {
	call	_joypad
	ld	a, e
	and	a, #0x48
	jr	Z, 00107$
;menus.c:68: menuidx = menuidx + 1 == numentries ? 0 : menuidx + 1;
	ld	hl, #_menuidx
	ld	c, (hl)
	ld	b, #0x00
	inc	bc
	ldhl	sp,	#8
	ld	e, (hl)
	ld	d, #0x00
	ld	a, e
	sub	a, c
	jr	NZ, 00116$
	ld	a, d
	sub	a, b
	jr	NZ, 00116$
	ld	bc, #0x0000
	jr	00117$
00116$:
	ld	a, (#_menuidx)
	inc	a
	ld	c, a
	rla
00117$:
	ld	hl, #_menuidx
	ld	(hl), c
;menus.c:69: move_sprite(0, shadow_OAM[0].x, entries[menuidx]);
;c
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_menuidx
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	c, a
	ld	hl, #(_shadow_OAM + 0x0001)
	ld	b, (hl)
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1218: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #_shadow_OAM
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1219: itm->y=y, itm->x=x;
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;menus.c:70: se_move_cursor();
	ld	e, #b_se_move_cursor
	ld	hl, #_se_move_cursor
	call	___sdcc_bcall_ehl
	jr	00108$
00107$:
;menus.c:71: } else if(joypad() & J_UP) {
	call	_joypad
	bit	2, e
	jr	Z, 00104$
;menus.c:72: menuidx = menuidx == 0 ? numentries - 1 : menuidx - 1;
	ld	a, (#_menuidx)
	or	a, a
	jr	NZ, 00118$
	ldhl	sp,	#8
	ld	a, (hl)
	dec	a
	jr	00119$
00118$:
	ld	a, (#_menuidx)
	dec	a
00119$:
	ld	(#_menuidx),a
;menus.c:73: move_sprite(0, shadow_OAM[0].x, entries[menuidx]);
;c
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_menuidx
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	b, a
	ld	hl, #(_shadow_OAM + 0x0001)
	ld	c, (hl)
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1218: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #_shadow_OAM
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1219: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;menus.c:74: se_move_cursor();
	ld	e, #b_se_move_cursor
	ld	hl, #_se_move_cursor
	call	___sdcc_bcall_ehl
	jr	00108$
00104$:
;menus.c:75: } else if(joypad() & (J_START | J_A)) {
	call	_joypad
	ld	a, e
	and	a, #0x90
	jr	Z, 00108$
;menus.c:76: stop_song();
	call	_stop_song
;menus.c:77: se_choose_entry();
	ld	e, #b_se_choose_entry
	ld	hl, #_se_choose_entry
;menus.c:78: break;  // Player has made a choice
	jp  ___sdcc_bcall_ehl
00108$:
;menus.c:80: custom_delay(7);
	ld	a, #0x07
	push	af
	inc	sp
	call	_custom_delay
	inc	sp
;menus.c:82: }
	jp	00110$
;menus.c:85: void stage_intro_screen(UINT8 stnum) BANKED {
;	---------------------------------
; Function stage_intro_screen
; ---------------------------------
	b_stage_intro_screen	= 1
_stage_intro_screen::
	add	sp, #-8
;menus.c:86: init_common_menu_props();
	ld	e, #b_init_common_menu_props
	ld	hl, #_init_common_menu_props
	call	___sdcc_bcall_ehl
;menus.c:87: const unsigned char stagesign[] = {0x1D, 0x1E, 0x0B, 0x11, 0x0F};
	ldhl	sp,	#0
	ld	c, l
	ld	b, h
	ld	(hl), #0x1d
	ld	l, c
	ld	h, b
	inc	hl
	ld	(hl), #0x1e
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	ld	(hl), #0x0b
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	inc	hl
	ld	(hl), #0x11
	ld	hl, #0x0004
	add	hl, bc
	ld	(hl), #0x0f
;menus.c:88: set_bkg_tiles(6, 4, 5, 1, stagesign);
	push	bc
	ld	de, #0x0105
	push	de
	ld	de, #0x0406
	push	de
	call	_set_bkg_tiles
	add	sp, #6
;menus.c:89: set_bkg_tile_xy(12, 4, stnum + 2);
	ldhl	sp,	#14
	ld	a, (hl)
	add	a, #0x02
	ld	d,a
	ld	e,#0x04
	push	de
	ld	a, #0x0c
	push	af
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
;menus.c:90: set_bkg_tiles((20 - stnamelengths[stnum]) / 2, 7, stnamelengths[stnum], 1, *(stagenames + stnum));
	ldhl	sp,	#14
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
	add	hl, hl
	ld	bc,#_stagenames
	add	hl,bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#5
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;c
	ld	de, #_stnamelengths
	ldhl	sp,	#14
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ldhl	sp,	#7
	ld	(hl), a
	ld	c, (hl)
	ld	b, #0x00
	ld	a, #0x14
	sub	a, c
	ld	l, a
	ld	a, #0x00
	sbc	a, b
	ld	h, a
	ld	c, l
	ld	b, h
	bit	7, h
	jr	Z, 00103$
	inc	hl
	ld	c, l
	ld	b, h
00103$:
	sra	b
	rr	c
	ldhl	sp,	#5
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ld	a, #0x01
	push	af
	inc	sp
	ldhl	sp,	#10
	ld	d, (hl)
	ld	e,#0x07
	push	de
	ld	a, c
	push	af
	inc	sp
	call	_set_bkg_tiles
	add	sp, #6
;menus.c:91: anim_reverse_blackout();
	call	_anim_reverse_blackout
;menus.c:92: custom_delay(70);
	ld	a, #0x46
	push	af
	inc	sp
	call	_custom_delay
	inc	sp
;menus.c:93: anim_blackout();
	call	_anim_blackout
;menus.c:94: }
	add	sp, #8
	ret
;menus.c:97: void game_over_menu() BANKED {
;	---------------------------------
; Function game_over_menu
; ---------------------------------
	b_game_over_menu	= 1
_game_over_menu::
	add	sp, #-38
;menus.c:98: init_common_menu_props();
	ld	e, #b_init_common_menu_props
	ld	hl, #_init_common_menu_props
	call	___sdcc_bcall_ehl
;menus.c:99: const unsigned char gmoversign[] = {0x11, 0x0B, 0x17, 0x0F, 0x00, 0x019, 0x20, 0x0F, 0x1C};
	ldhl	sp,	#0
	ld	c, l
	ld	b, h
	ld	(hl), #0x11
	ld	l, c
	ld	h, b
	inc	hl
	ld	(hl), #0x0b
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	ld	(hl), #0x17
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	inc	hl
	ld	(hl), #0x0f
	ld	hl, #0x0004
	add	hl, bc
	ld	(hl), #0x00
	ld	hl, #0x0005
	add	hl, bc
	ld	(hl), #0x19
	ld	hl, #0x0006
	add	hl, bc
	ld	(hl), #0x20
	ld	hl, #0x0007
	add	hl, bc
	ld	(hl), #0x0f
	ld	hl, #0x0008
	add	hl, bc
	ld	(hl), #0x1c
;menus.c:100: const unsigned char contsign[] = {0x0D, 0x19, 0x18, 0x1E, 0x13, 0x18, 0x1F, 0x0F};
	ldhl	sp,	#9
	ld	a, l
	ld	d, h
	ldhl	sp,	#34
	ld	(hl+), a
	ld	a, d
	ld	(hl-), a
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x0d
	ldhl	sp,	#34
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	ld	(hl), #0x19
	ldhl	sp,	#34
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	ld	(hl), #0x18
	ldhl	sp,	#34
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	inc	hl
	ld	(hl), #0x1e
;c
	ldhl	sp,#34
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	ld	(hl), #0x13
;c
	ldhl	sp,#34
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0005
	add	hl, de
	ld	(hl), #0x18
;c
	ldhl	sp,#34
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0006
	add	hl, de
	ld	(hl), #0x1f
;c
	ldhl	sp,#34
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0007
	add	hl, de
	ld	e, l
	ld	(hl), #0x0f
;menus.c:101: const unsigned char quitsign[] = {0x1B, 0x1F, 0x13, 0x1E};
	ldhl	sp,	#17
	ld	a, l
	ld	d, h
	ldhl	sp,	#36
	ld	(hl+), a
	ld	a, d
	ld	(hl-), a
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x1b
	ldhl	sp,	#36
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	ld	(hl), #0x1f
	ldhl	sp,	#36
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	ld	(hl), #0x13
	ldhl	sp,	#36
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	inc	hl
	ld	(hl), #0x1e
;menus.c:102: const unsigned char gopasssign[] = {0x1A, 0x0B, 0x1D, 0x1D, 0x21, 0x19, 0x1C, 0x0E, 0x25};
	ldhl	sp,	#21
	ld	e, l
	ld	d, h
	ld	(hl), #0x1a
	ld	l, e
	ld	h, d
	inc	hl
	ld	(hl), #0x0b
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	ld	(hl), #0x1d
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	inc	hl
	ld	(hl), #0x1d
	ld	hl, #0x0004
	add	hl, de
	ld	(hl), #0x21
	ld	hl, #0x0005
	add	hl, de
	ld	(hl), #0x19
	ld	hl, #0x0006
	add	hl, de
	ld	(hl), #0x1c
	ld	hl, #0x0007
	add	hl, de
	ld	(hl), #0x0e
	ld	hl, #0x0008
	add	hl, de
	ld	(hl), #0x25
;menus.c:103: const unsigned char dummypass[] = {0x28, 0x28, 0x28, 0x28};
	ldhl	sp,	#30
	ld	e, l
	ld	d, h
	ld	(hl), #0x28
	ld	l, e
	ld	h, d
	inc	hl
	ld	(hl), #0x28
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	ld	(hl), #0x28
	inc	de
	inc	de
	inc	de
	ld	a, #0x28
	ld	(de), a
;menus.c:104: set_bkg_tiles(5, 4, 9, 1, gmoversign);
	push	bc
	ld	de, #0x0109
	push	de
	ld	de, #0x0405
	push	de
	call	_set_bkg_tiles
	add	sp, #6
;menus.c:105: set_bkg_tiles(7, 10, 8, 1, contsign);
	ldhl	sp,#34
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	push	bc
	ld	de, #0x0108
	push	de
	ld	de, #0x0a07
	push	de
	call	_set_bkg_tiles
	add	sp, #6
;menus.c:106: set_bkg_tiles(7, 12, 4, 1, quitsign);
	ldhl	sp,#36
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	push	bc
	ld	de, #0x0104
	push	de
	ld	de, #0x0c07
	push	de
	call	_set_bkg_tiles
	add	sp, #6
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1218: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #_shadow_OAM
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1219: itm->y=y, itm->x=x;
	ld	a, #0x60
	ld	(hl+), a
	ld	(hl), #0x34
;menus.c:110: play_song(&gameovertheme, 1);
	ld	a, #0x01
	push	af
	inc	sp
	ld	hl, #_gameovertheme
	push	hl
	call	_play_song
	add	sp, #3
;menus.c:111: anim_reverse_blackout();
	call	_anim_reverse_blackout
;menus.c:112: get_menu_pl_input(gameoveropts, 2);
	ld	a, #0x02
	push	af
	inc	sp
	ld	hl, #_gameoveropts
	push	hl
	ld	e, #b_get_menu_pl_input
	ld	hl, #_get_menu_pl_input
	call	___sdcc_bcall_ehl
	add	sp, #3
;menus.c:113: if(menuidx == 0) {
	ld	a, (#_menuidx)
	or	a, a
	jr	NZ, 00102$
;menus.c:114: init_game();
	call	_init_game
00102$:
;menus.c:116: clear_all_sprites();
	call	_clear_all_sprites
;menus.c:117: anim_blackout();
	call	_anim_blackout
;menus.c:118: }
	add	sp, #38
	ret
;menus.c:121: void demo_end_screen() BANKED {    // DEMO CODE
;	---------------------------------
; Function demo_end_screen
; ---------------------------------
	b_demo_end_screen	= 1
_demo_end_screen::
	add	sp, #-53
;menus.c:122: init_common_menu_props();
	ld	e, #b_init_common_menu_props
	ld	hl, #_init_common_menu_props
	call	___sdcc_bcall_ehl
;menus.c:123: unsigned char tnx1sign[] = {0x1E, 0x12, 0x0B, 0x18, 0x15, 0x00, 0x23, 0x19, 0x1F, 0x00, 0x10, 0x19, 0x1C};
	ldhl	sp,	#0
	ld	c, l
	ld	b, h
	ld	(hl), #0x1e
	ld	l, c
	ld	h, b
	inc	hl
	ld	(hl), #0x12
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	ld	(hl), #0x0b
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	inc	hl
	ld	(hl), #0x18
	ld	hl, #0x0004
	add	hl, bc
	ld	(hl), #0x15
	ld	hl, #0x0005
	add	hl, bc
	ld	(hl), #0x00
	ld	hl, #0x0006
	add	hl, bc
	ld	(hl), #0x23
	ld	hl, #0x0007
	add	hl, bc
	ld	(hl), #0x19
	ld	hl, #0x0008
	add	hl, bc
	ld	(hl), #0x1f
	ld	hl, #0x0009
	add	hl, bc
	ld	(hl), #0x00
	ld	hl, #0x000a
	add	hl, bc
	ld	(hl), #0x10
	ld	hl, #0x000b
	add	hl, bc
	ld	(hl), #0x19
	ld	hl, #0x000c
	add	hl, bc
	ld	(hl), #0x1c
;menus.c:124: unsigned char tnx2sign[] =  {0x1A, 0x16, 0x0B, 0x23, 0x13, 0x18, 0x11, 0x27};
	ldhl	sp,	#13
	ld	a, l
	ld	d, h
	ldhl	sp,	#49
	ld	(hl+), a
	ld	a, d
	ld	(hl-), a
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x1a
	ldhl	sp,	#49
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	ld	(hl), #0x16
	ldhl	sp,	#49
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	ld	(hl), #0x0b
	ldhl	sp,	#49
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	inc	hl
	ld	(hl), #0x23
;c
	ldhl	sp,#49
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	ld	(hl), #0x13
;c
	ldhl	sp,#49
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0005
	add	hl, de
	ld	(hl), #0x18
;c
	ldhl	sp,#49
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0006
	add	hl, de
	ld	(hl), #0x11
;c
	ldhl	sp,#49
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0007
	add	hl, de
	ld	(hl), #0x27
;menus.c:125: unsigned char tnx3sign[] = {0x17, 0x19, 0x1C, 0x0F, 0x00, 0x1C, 0x19, 0x0B, 0x0E, 0x00, 0x0B, 0x0D, 0x1E, 0x13, 0x19, 0x18};
	ldhl	sp,	#21
	ld	a, l
	ld	d, h
	ldhl	sp,	#51
	ld	(hl+), a
	ld	a, d
	ld	(hl-), a
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x17
	ldhl	sp,	#51
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	ld	(hl), #0x19
	ldhl	sp,	#51
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	ld	(hl), #0x1c
	ldhl	sp,	#51
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	inc	hl
	ld	(hl), #0x0f
;c
	ldhl	sp,#51
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	ld	e, l
	ld	d, h
	xor	a, a
	ld	(de), a
;c
	ldhl	sp,#51
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0005
	add	hl, de
	ld	(hl), #0x1c
;c
	ldhl	sp,#51
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0006
	add	hl, de
	ld	(hl), #0x19
;c
	ldhl	sp,#51
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0007
	add	hl, de
	ld	(hl), #0x0b
;c
	ldhl	sp,#51
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0008
	add	hl, de
	ld	e, l
	ld	(hl), #0x0e
;c
	ldhl	sp,#51
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0009
	add	hl, de
	ld	e, l
	ld	d, h
	xor	a, a
	ld	(de), a
;c
	ldhl	sp,#51
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000a
	add	hl, de
	ld	(hl), #0x0b
;c
	ldhl	sp,#51
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000b
	add	hl, de
	ld	d, h
	ld	(hl), #0x0d
;c
	ldhl	sp,#51
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000c
	add	hl, de
	ld	e, l
	ld	(hl), #0x1e
;c
	ldhl	sp,#51
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000d
	add	hl, de
	ld	(hl), #0x13
;c
	ldhl	sp,#51
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000e
	add	hl, de
	ld	(hl), #0x19
;c
	ldhl	sp,#51
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000f
	add	hl, de
	ld	(hl), #0x18
;menus.c:126: unsigned char tnx4sign[] = {0x0D, 0x19, 0x17, 0x13, 0x18, 0x11, 0x00, 0x1D, 0x19, 0x19, 0x18, 0x27};
	ldhl	sp,	#37
	ld	e, l
	ld	d, h
	ld	(hl), #0x0d
	ld	l, e
	ld	h, d
	inc	hl
	ld	(hl), #0x19
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	ld	(hl), #0x17
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	inc	hl
	ld	(hl), #0x13
	ld	hl, #0x0004
	add	hl, de
	ld	(hl), #0x18
	ld	hl, #0x0005
	add	hl, de
	ld	(hl), #0x11
	ld	hl, #0x0006
	add	hl, de
	ld	(hl), #0x00
	ld	hl, #0x0007
	add	hl, de
	ld	(hl), #0x1d
	ld	hl, #0x0008
	add	hl, de
	ld	(hl), #0x19
	ld	hl, #0x0009
	add	hl, de
	ld	(hl), #0x19
	ld	hl, #0x000a
	add	hl, de
	ld	(hl), #0x18
	ld	hl, #0x000b
	add	hl, de
	ld	(hl), #0x27
;menus.c:127: set_bkg_tiles(3, 3, 13, 1, tnx1sign);
	push	de
	push	bc
	ld	de, #0x010d
	push	de
	ld	de, #0x0303
	push	de
	call	_set_bkg_tiles
	add	sp, #6
	pop	de
;menus.c:128: set_bkg_tiles(6, 5, 8, 1, tnx2sign);
	ldhl	sp,#49
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	push	de
	push	bc
	ld	de, #0x0108
	push	de
	ld	de, #0x0506
	push	de
	call	_set_bkg_tiles
	add	sp, #6
	pop	de
;menus.c:129: set_bkg_tiles(2, 11, 16, 1, tnx3sign);
	ldhl	sp,#51
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	push	de
	push	bc
	ld	de, #0x0110
	push	de
	ld	de, #0x0b02
	push	de
	call	_set_bkg_tiles
	add	sp, #6
	ld	de, #0x010c
	push	de
	ld	de, #0x0d04
	push	de
	call	_set_bkg_tiles
	add	sp, #6
;menus.c:131: anim_reverse_blackout();
	call	_anim_reverse_blackout
;menus.c:132: waitpad(J_START);
	ld	a, #0x80
	push	af
	inc	sp
	call	_waitpad
	inc	sp
;menus.c:133: anim_blackout();
	call	_anim_blackout
;menus.c:134: }
	add	sp, #53
	ret
;menus.c:137: void se_move_cursor() BANKED {
;	---------------------------------
; Function se_move_cursor
; ---------------------------------
	b_se_move_cursor	= 1
_se_move_cursor::
;menus.c:138: mute_music_pl_chnl(0);
	xor	a, a
	push	af
	inc	sp
	call	_mute_music_pl_chnl
	inc	sp
;menus.c:139: NR10_REG = 0x00;
	ld	a, #0x00
	ldh	(_NR10_REG+0),a
;menus.c:140: NR11_REG = 0xCB;
	ld	a, #0xcb
	ldh	(_NR11_REG+0),a
;menus.c:141: NR12_REG = 0x63;
	ld	a, #0x63
	ldh	(_NR12_REG+0),a
;menus.c:142: NR13_REG = 0x9F;
	ld	a, #0x9f
	ldh	(_NR13_REG+0),a
;menus.c:143: NR14_REG = 0x86;
	ld	a, #0x86
	ldh	(_NR14_REG+0),a
;menus.c:144: }
	ret
;menus.c:147: void se_choose_entry() BANKED {
;	---------------------------------
; Function se_choose_entry
; ---------------------------------
	b_se_choose_entry	= 1
_se_choose_entry::
;menus.c:148: mute_music_pl_chnl(0);
	xor	a, a
	push	af
	inc	sp
	call	_mute_music_pl_chnl
	inc	sp
;menus.c:149: NR10_REG = 0x64;
	ld	a, #0x64
	ldh	(_NR10_REG+0),a
;menus.c:150: NR11_REG = 0x88;
	ld	a, #0x88
	ldh	(_NR11_REG+0),a
;menus.c:151: NR12_REG = 0xF3;
	ld	a, #0xf3
	ldh	(_NR12_REG+0),a
;menus.c:152: NR13_REG = 0x3E;
	ld	a, #0x3e
	ldh	(_NR13_REG+0),a
;menus.c:153: NR14_REG = 0x86;
	ld	a, #0x86
	ldh	(_NR14_REG+0),a
;menus.c:154: }
	ret
;menus.c:156: void password_menu() {
;	---------------------------------
; Function password_menu
; ---------------------------------
	b_password_menu	= 1
_password_menu::
;menus.c:158: }
	ret
	.area _CODE_1
	.area _CABS (ABS)
