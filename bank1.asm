;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.0 #12072 (MINGW32)
;--------------------------------------------------------
	.module menus
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _manage_sound_chnls
	.globl _toggle_mute_music
	.globl _reset_sprites
	.globl _mute_music_pl_chnl
	.globl _anim_blackout
	.globl _anim_reverse_blackout
	.globl _custom_delay
	.globl _hUGE_dosound
	.globl _hUGE_init
	.globl _fill_bkg_rect
	.globl _set_sprite_data
	.globl _set_bkg_tile_xy
	.globl _set_bkg_tiles
	.globl _set_bkg_data
	.globl _wait_vbl_done
	.globl _waitpadup
	.globl _waitpad
	.globl _joypad
	.globl _add_VBL
	.globl _remove_VBL
	.globl _crsr
	.globl _menuanimcnt
	.globl _passentry
	.globl _passidx
	.globl _medaltypeoffsx
	.globl _bossrushconfigs
	.globl _medalssigns
	.globl _pushstartsign
	.globl _medaltypessign
	.globl _awardedsign
	.globl _congratssign
	.globl _greatjobsign
	.globl _goodjobsign
	.globl _allsign
	.globl _rushresbossesdefsign
	.globl _rushresmodesign
	.globl _rushrestitlesign
	.globl _glassfeathersign
	.globl _glasscannonsign
	.globl _regularsign
	.globl _bossrushsign
	.globl _fightbosssign
	.globl _plasmasign
	.globl _extrmenusign
	.globl _extrassign
	.globl _gopasssign
	.globl _quitsign
	.globl _contsign
	.globl _gmoversign
	.globl _stagesign
	.globl _creatorsign
	.globl _passwsign
	.globl _gamestsign
	.globl _mapcrsrcoords
	.globl _passwords
	.globl _introscrdurr
	.globl _wrongpassind
	.globl _blinkanimdur
	.globl _passconfy
	.globl _extrasoptsy
	.globl _passconfoptsx
	.globl _mainoptsy
	.globl _gameoveroptsy
	.globl _stnamelengths
	.globl _stagenames
	.globl _airbasemap
	.globl _overworldmap
	.globl _passwscreenmap
	.globl _titlelogomap
	.globl _medaltiles
	.globl _airbasemaptiles
	.globl _mapframetiles
	.globl _overworldmaptiles
	.globl _passwscreentiles
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
	.globl b_init_passcursor
	.globl _init_passcursor
	.globl b_move_passcursor
	.globl _move_passcursor
	.globl b_update_pass_field
	.globl _update_pass_field
	.globl b_add_character
	.globl _add_character
	.globl b_drop_character
	.globl _drop_character
	.globl b_reset_password
	.globl _reset_password
	.globl b_get_stage_from_password
	.globl _get_stage_from_password
	.globl b_compare_password
	.globl _compare_password
	.globl b_confirm_password
	.globl _confirm_password
	.globl b_anim_cursor_blink
	.globl _anim_cursor_blink
	.globl b_password_menu
	.globl _password_menu
	.globl b_extras_menu
	.globl _extras_menu
	.globl b_choose_boss
	.globl _choose_boss
	.globl b_boss_rush_results_screen
	.globl _boss_rush_results_screen
	.globl b_play_song
	.globl _play_song
	.globl b_se_choose_entry
	.globl _se_choose_entry
	.globl b_se_move_cursor
	.globl _se_move_cursor
	.globl b_se_wrong_password
	.globl _se_wrong_password
	.globl b_se_add_character
	.globl _se_add_character
	.globl b_se_drop_character
	.globl _se_drop_character
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_passidx::
	.ds 1
_passentry::
	.ds 4
_menuanimcnt::
	.ds 1
_crsr::
	.ds 4
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
;menus.c:120: void init_common_menu_props() BANKED {
;	---------------------------------
; Function init_common_menu_props
; ---------------------------------
	b_init_common_menu_props	= 1
_init_common_menu_props::
;menus.c:121: set_bkg_data(0, 1, blanktile);
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
;menus.c:122: set_bkg_data(1, 41, fonttiles);
	ld	hl, #_fonttiles
	push	hl
	ld	de, #0x2901
	push	de
	call	_set_bkg_data
	add	sp, #4
;menus.c:123: fill_bkg_rect(0, 0, 32, 18, 0x00);
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
;menus.c:124: set_sprite_data(1, 5, misctiles);
	ld	hl, #_misctiles
	push	hl
	ld	de, #0x0501
	push	de
	call	_set_sprite_data
	add	sp, #4
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1145: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 0x0002)
	ld	(hl), #0x01
;menus.c:125: set_sprite_tile(0, 1);
;menus.c:126: }
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
	.db #0x36	; 54	'6'
	.db #0x2e	; 46
	.db #0x78	; 120	'x'
	.db #0x78	; 120	'x'
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x10	; 16
	.db #0x30	; 48	'0'
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x7c	; 124
	.db #0x7c	; 124
	.db #0x7c	; 124
	.db #0x7c	; 124
	.db #0x7c	; 124
	.db #0x7c	; 124
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x7e	; 126
	.db #0x66	; 102	'f'
	.db #0x7e	; 126
	.db #0x42	; 66	'B'
	.db #0xff	; 255
	.db #0x99	; 153
	.db #0xff	; 255
	.db #0x99	; 153
	.db #0x7e	; 126
	.db #0x42	; 66	'B'
	.db #0x7e	; 126
	.db #0x66	; 102	'f'
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x18	; 24
	.db #0x7e	; 126
	.db #0x3c	; 60
	.db #0xff	; 255
	.db #0x66	; 102	'f'
	.db #0xff	; 255
	.db #0x66	; 102	'f'
	.db #0x7e	; 126
	.db #0x3c	; 60
	.db #0x7e	; 126
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
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
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x40	; 64
	.db #0x7f	; 127
	.db #0x7e	; 126
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x03	; 3
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
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0x04	; 4
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
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
	.db #0x38	; 56	'8'
	.db #0x38	; 56	'8'
	.db #0x38	; 56	'8'
	.db #0x28	; 40
	.db #0x38	; 56	'8'
	.db #0x28	; 40
	.db #0x38	; 56	'8'
	.db #0x28	; 40
	.db #0x38	; 56	'8'
	.db #0x28	; 40
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
	.db #0x1c	; 28
	.db #0x14	; 20
	.db #0xfc	; 252
	.db #0xf4	; 244
	.db #0x04	; 4
	.db #0xfc	; 252
	.db #0xf4	; 244
	.db #0xfc	; 252
	.db #0x14	; 20
	.db #0x1c	; 28
	.db #0x14	; 20
	.db #0x1c	; 28
	.db #0x14	; 20
	.db #0x1c	; 28
	.db #0x14	; 20
	.db #0x1c	; 28
	.db #0x1c	; 28
	.db #0x1c	; 28
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
	.db #0x38	; 56	'8'
	.db #0x38	; 56	'8'
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
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x38	; 56	'8'
	.db #0x38	; 56	'8'
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0x44	; 68	'D'
	.db #0x38	; 56	'8'
	.db #0x38	; 56	'8'
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
_passwscreentiles:
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
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x3f	; 63
	.db #0x20	; 32
	.db #0x30	; 48	'0'
	.db #0x20	; 32
	.db #0x30	; 48	'0'
	.db #0x20	; 32
	.db #0x30	; 48	'0'
	.db #0x20	; 32
	.db #0x30	; 48	'0'
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0xfc	; 252
	.db #0x04	; 4
	.db #0x0c	; 12
	.db #0x04	; 4
	.db #0x0c	; 12
	.db #0x04	; 4
	.db #0x0c	; 12
	.db #0x04	; 4
	.db #0x0c	; 12
	.db #0x04	; 4
	.db #0x30	; 48	'0'
	.db #0x20	; 32
	.db #0x30	; 48	'0'
	.db #0x20	; 32
	.db #0x30	; 48	'0'
	.db #0x20	; 32
	.db #0x30	; 48	'0'
	.db #0x20	; 32
	.db #0x3f	; 63
	.db #0x20	; 32
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0c	; 12
	.db #0x04	; 4
	.db #0x0c	; 12
	.db #0x04	; 4
	.db #0x0c	; 12
	.db #0x04	; 4
	.db #0x0c	; 12
	.db #0x04	; 4
	.db #0xfc	; 252
	.db #0x04	; 4
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x30	; 48	'0'
	.db #0x20	; 32
	.db #0x30	; 48	'0'
	.db #0x20	; 32
	.db #0x30	; 48	'0'
	.db #0x20	; 32
	.db #0x30	; 48	'0'
	.db #0x20	; 32
	.db #0x30	; 48	'0'
	.db #0x20	; 32
	.db #0x30	; 48	'0'
	.db #0x20	; 32
	.db #0x30	; 48	'0'
	.db #0x20	; 32
	.db #0x30	; 48	'0'
	.db #0x20	; 32
	.db #0x0c	; 12
	.db #0x04	; 4
	.db #0x0c	; 12
	.db #0x04	; 4
	.db #0x0c	; 12
	.db #0x04	; 4
	.db #0x0c	; 12
	.db #0x04	; 4
	.db #0x0c	; 12
	.db #0x04	; 4
	.db #0x0c	; 12
	.db #0x04	; 4
	.db #0x0c	; 12
	.db #0x04	; 4
	.db #0x0c	; 12
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x7e	; 126
	.db #0x7e	; 126
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
	.db #0x7c	; 124
	.db #0x7c	; 124
	.db #0x00	; 0
	.db #0x00	; 0
_overworldmaptiles:
	.db #0xdc	; 220
	.db #0x23	; 35
	.db #0xe0	; 224
	.db #0x1f	; 31
	.db #0xfb	; 251
	.db #0x04	; 4
	.db #0xe7	; 231
	.db #0x18	; 24
	.db #0x8f	; 143
	.db #0x70	; 112	'p'
	.db #0x3f	; 63
	.db #0xc0	; 192
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xf6	; 246
	.db #0x09	; 9
	.db #0xcf	; 207
	.db #0x30	; 48	'0'
	.db #0x3f	; 63
	.db #0xc0	; 192
	.db #0xbf	; 191
	.db #0x40	; 64
	.db #0xcc	; 204
	.db #0x33	; 51	'3'
	.db #0xe1	; 225
	.db #0x1e	; 30
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xe7	; 231
	.db #0x18	; 24
	.db #0x06	; 6
	.db #0xf9	; 249
	.db #0xd9	; 217
	.db #0x26	; 38
	.db #0x3d	; 61
	.db #0xc2	; 194
	.db #0x7e	; 126
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xb7	; 183
	.db #0x48	; 72	'H'
	.db #0x78	; 120	'x'
	.db #0x87	; 135
	.db #0xfd	; 253
	.db #0x02	; 2
	.db #0xf3	; 243
	.db #0x0c	; 12
	.db #0x47	; 71	'G'
	.db #0xb8	; 184
	.db #0x1f	; 31
	.db #0xe0	; 224
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x37	; 55	'7'
	.db #0xc8	; 200
	.db #0x2b	; 43
	.db #0xd4	; 212
	.db #0x9d	; 157
	.db #0x62	; 98	'b'
	.db #0xde	; 222
	.db #0x21	; 33
	.db #0xe7	; 231
	.db #0x18	; 24
	.db #0xf3	; 243
	.db #0x0c	; 12
	.db #0xfd	; 253
	.db #0x02	; 2
	.db #0xfe	; 254
	.db #0x01	; 1
	.db #0x40	; 64
	.db #0xa0	; 160
	.db #0x80	; 128
	.db #0x60	; 96
	.db #0xc0	; 192
	.db #0x30	; 48	'0'
	.db #0xc0	; 192
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0xd8	; 216
	.db #0x20	; 32
	.db #0xa6	; 166
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0xf4	; 244
	.db #0x0b	; 11
	.db #0xcf	; 207
	.db #0x30	; 48	'0'
	.db #0x8c	; 140
	.db #0x73	; 115	's'
	.db #0x21	; 33
	.db #0xde	; 222
	.db #0x70	; 112	'p'
	.db #0x8f	; 143
	.db #0xf8	; 248
	.db #0x07	; 7
	.db #0xf3	; 243
	.db #0x0c	; 12
	.db #0x27	; 39
	.db #0xd8	; 216
	.db #0x03	; 3
	.db #0xfc	; 252
	.db #0x27	; 39
	.db #0xd8	; 216
	.db #0x73	; 115	's'
	.db #0x8c	; 140
	.db #0xf8	; 248
	.db #0x07	; 7
	.db #0xfc	; 252
	.db #0x03	; 3
	.db #0x7f	; 127
	.db #0x80	; 128
	.db #0x8d	; 141
	.db #0x72	; 114	'r'
	.db #0xe9	; 233
	.db #0x16	; 22
	.db #0x1e	; 30
	.db #0xe1	; 225
	.db #0x84	; 132
	.db #0x7b	; 123
	.db #0x33	; 51	'3'
	.db #0xcc	; 204
	.db #0x7d	; 125
	.db #0x82	; 130
	.db #0xfa	; 250
	.db #0x05	; 5
	.db #0xe3	; 227
	.db #0x1c	; 28
	.db #0xdc	; 220
	.db #0x23	; 35
	.db #0x3f	; 63
	.db #0xc0	; 192
	.db #0x8c	; 140
	.db #0x73	; 115	's'
	.db #0x60	; 96
	.db #0x9f	; 159
	.db #0xfd	; 253
	.db #0x02	; 2
	.db #0xcb	; 203
	.db #0x34	; 52	'4'
	.db #0xb7	; 183
	.db #0x48	; 72	'H'
	.db #0x7b	; 123
	.db #0x84	; 132
	.db #0xfc	; 252
	.db #0x03	; 3
	.db #0x4f	; 79	'O'
	.db #0xb0	; 176
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x80	; 128
	.db #0xb0	; 176
	.db #0x40	; 64
	.db #0xc0	; 192
	.db #0x23	; 35
	.db #0xe1	; 225
	.db #0x1e	; 30
	.db #0xf3	; 243
	.db #0x0c	; 12
	.db #0xfd	; 253
	.db #0x02	; 2
	.db #0xfe	; 254
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0xb0	; 176
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x98	; 152
	.db #0x40	; 64
	.db #0x86	; 134
	.db #0x60	; 96
	.db #0x80	; 128
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0xb0	; 176
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x21	; 33
	.db #0x00	; 0
	.db #0x75	; 117	'u'
	.db #0x30	; 48	'0'
	.db #0xcf	; 207
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x02	; 2
	.db #0xb0	; 176
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x04	; 4
	.db #0x07	; 7
	.db #0xd8	; 216
	.db #0x0c	; 12
	.db #0xf3	; 243
	.db #0xc0	; 192
	.db #0x3f	; 63
	.db #0xfa	; 250
	.db #0x05	; 5
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x41	; 65	'A'
	.db #0x06	; 6
	.db #0xb6	; 182
	.db #0x09	; 9
	.db #0x0d	; 13
	.db #0xd2	; 210
	.db #0x83	; 131
	.db #0x7c	; 124
	.db #0xe4	; 228
	.db #0x1b	; 27
	.db #0xcc	; 204
	.db #0x33	; 51	'3'
	.db #0x3e	; 62
	.db #0xc1	; 193
	.db #0xc0	; 192
	.db #0x30	; 48	'0'
	.db #0x00	; 0
	.db #0xd0	; 208
	.db #0x30	; 48	'0'
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0xb0	; 176
	.db #0x80	; 128
	.db #0x78	; 120	'x'
	.db #0x70	; 112	'p'
	.db #0x88	; 136
	.db #0xf8	; 248
	.db #0x04	; 4
	.db #0xdc	; 220
	.db #0x22	; 34
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0xb0	; 176
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x04	; 4
	.db #0x06	; 6
	.db #0x09	; 9
	.db #0x08	; 8
	.db #0x36	; 54	'6'
	.db #0x30	; 48	'0'
	.db #0x4a	; 74	'J'
	.db #0x60	; 96
	.db #0x92	; 146
	.db #0x30	; 48	'0'
	.db #0x49	; 73	'I'
	.db #0x60	; 96
	.db #0x98	; 152
	.db #0x80	; 128
	.db #0x68	; 104	'h'
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x26	; 38
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x40	; 64
	.db #0x02	; 2
	.db #0xb0	; 176
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x1b	; 27
	.db #0x04	; 4
	.db #0x24	; 36
	.db #0x1b	; 27
	.db #0x18	; 24
	.db #0x25	; 37
	.db #0x24	; 36
	.db #0xd3	; 211
	.db #0x10	; 16
	.db #0x6e	; 110	'n'
	.db #0x60	; 96
	.db #0x9c	; 156
	.db #0xc0	; 192
	.db #0x27	; 39
	.db #0x80	; 128
	.db #0x60	; 96
	.db #0x18	; 24
	.db #0xa0	; 160
	.db #0x26	; 38
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xda	; 218
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x48	; 72	'H'
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x26	; 38
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0x11	; 17
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x26	; 38
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0xb0	; 176
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x26	; 38
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x66	; 102	'f'
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x90	; 144
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x26	; 38
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x58	; 88	'X'
	.db #0x03	; 3
	.db #0x06	; 6
	.db #0xf9	; 249
	.db #0x03	; 3
	.db #0x84	; 132
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x26	; 38
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x11	; 17
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xb0	; 176
	.db #0x40	; 64
	.db #0xc0	; 192
	.db #0x20	; 32
	.db #0x60	; 96
	.db #0x90	; 144
	.db #0x36	; 54	'6'
	.db #0xc8	; 200
	.db #0x58	; 88	'X'
	.db #0xa4	; 164
	.db #0x00	; 0
	.db #0xf3	; 243
	.db #0x00	; 0
	.db #0x3e	; 62
	.db #0x10	; 16
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x26	; 38
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x0f	; 15
	.db #0x10	; 16
	.db #0x0b	; 11
	.db #0x14	; 20
	.db #0x0f	; 15
	.db #0x10	; 16
	.db #0x0b	; 11
	.db #0x34	; 52	'4'
	.db #0x0f	; 15
	.db #0x30	; 48	'0'
	.db #0x0f	; 15
	.db #0x50	; 80	'P'
	.db #0x2a	; 42
	.db #0x80	; 128
	.db #0x14	; 20
	.db #0xea	; 234
	.db #0xdc	; 220
	.db #0x22	; 34
	.db #0x54	; 84	'T'
	.db #0xaa	; 170
	.db #0xdd	; 221
	.db #0x22	; 34
	.db #0x54	; 84	'T'
	.db #0xaa	; 170
	.db #0xdc	; 220
	.db #0x22	; 34
	.db #0xc9	; 201
	.db #0x20	; 32
	.db #0xa5	; 165
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf7	; 247
	.db #0x6b	; 107	'k'
	.db #0x94	; 148
	.db #0x00	; 0
	.db #0xf7	; 247
	.db #0x63	; 99	'c'
	.db #0x94	; 148
	.db #0x0b	; 11
	.db #0xf4	; 244
	.db #0x65	; 101	'e'
	.db #0x90	; 144
	.db #0x4a	; 74	'J'
	.db #0x00	; 0
	.db #0x30	; 48	'0'
	.db #0x03	; 3
	.db #0x30	; 48	'0'
	.db #0xcf	; 207
	.db #0xa7	; 167
	.db #0x58	; 88	'X'
	.db #0x35	; 53	'5'
	.db #0xca	; 202
	.db #0xa7	; 167
	.db #0x58	; 88	'X'
	.db #0xb5	; 181
	.db #0x4a	; 74	'J'
	.db #0x97	; 151
	.db #0x08	; 8
	.db #0x67	; 103	'g'
	.db #0x08	; 8
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0xef	; 239
	.db #0xd7	; 215
	.db #0x28	; 40
	.db #0x57	; 87	'W'
	.db #0xa8	; 168
	.db #0xc0	; 192
	.db #0x2f	; 47
	.db #0x47	; 71	'G'
	.db #0xa8	; 168
	.db #0xd7	; 215
	.db #0x28	; 40
	.db #0xc2	; 194
	.db #0x20	; 32
	.db #0x90	; 144
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0xd0	; 208
	.db #0x8a	; 138
	.db #0x55	; 85	'U'
	.db #0xaf	; 175
	.db #0x50	; 80	'P'
	.db #0x2f	; 47
	.db #0xd0	; 208
	.db #0x89	; 137
	.db #0x40	; 64
	.db #0x9c	; 156
	.db #0x40	; 64
	.db #0x27	; 39
	.db #0x00	; 0
	.db #0xc6	; 198
	.db #0x00	; 0
	.db #0xa8	; 168
	.db #0x55	; 85	'U'
	.db #0x82	; 130
	.db #0x7d	; 125
	.db #0xa8	; 168
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0x00	; 0
	.db #0x7d	; 125
	.db #0x28	; 40
	.db #0x54	; 84	'T'
	.db #0x2a	; 42
	.db #0x54	; 84	'T'
	.db #0x31	; 49	'1'
	.db #0x00	; 0
	.db #0xe8	; 232
	.db #0x12	; 18
	.db #0xa0	; 160
	.db #0x53	; 83	'S'
	.db #0xe4	; 228
	.db #0x13	; 19
	.db #0xa0	; 160
	.db #0x51	; 81	'Q'
	.db #0xe4	; 228
	.db #0x11	; 17
	.db #0x26	; 38
	.db #0x01	; 1
	.db #0xc0	; 192
	.db #0x07	; 7
	.db #0x20	; 32
	.db #0x1d	; 29
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0xb0	; 176
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3e	; 62
	.db #0x1c	; 28
	.db #0x23	; 35
	.db #0x14	; 20
	.db #0x2a	; 42
	.db #0x1d	; 29
	.db #0x62	; 98	'b'
	.db #0x08	; 8
	.db #0xf4	; 244
	.db #0x68	; 104	'h'
	.db #0x95	; 149
	.db #0x00	; 0
	.db #0xf9	; 249
	.db #0x60	; 96
	.db #0x99	; 153
	.db #0x08	; 8
	.db #0xf7	; 247
	.db #0x63	; 99	'c'
	.db #0x9c	; 156
	.db #0x00	; 0
	.db #0xf7	; 247
	.db #0x63	; 99	'c'
	.db #0x94	; 148
	.db #0x1f	; 31
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0x01	; 1
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0x3e	; 62
	.db #0xc1	; 193
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0x3e	; 62
	.db #0xc1	; 193
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0x87	; 135
	.db #0x68	; 104	'h'
	.db #0x87	; 135
	.db #0x48	; 72	'H'
	.db #0x80	; 128
	.db #0x7f	; 127
	.db #0xb7	; 183
	.db #0x48	; 72	'H'
	.db #0x87	; 135
	.db #0x78	; 120	'x'
	.db #0xb0	; 176
	.db #0x4f	; 79	'O'
	.db #0xb7	; 183
	.db #0x48	; 72	'H'
	.db #0x67	; 103	'g'
	.db #0x08	; 8
	.db #0xa0	; 160
	.db #0x5f	; 95
	.db #0xa6	; 166
	.db #0x49	; 73	'I'
	.db #0x00	; 0
	.db #0xcf	; 207
	.db #0xa6	; 166
	.db #0x49	; 73	'I'
	.db #0x8c	; 140
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0xdf	; 223
	.db #0x8f	; 143
	.db #0x50	; 80	'P'
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0x00	; 0
	.db #0x7c	; 124
	.db #0x28	; 40
	.db #0xd5	; 213
	.db #0xa8	; 168
	.db #0x55	; 85	'U'
	.db #0x00	; 0
	.db #0x7d	; 125
	.db #0x28	; 40
	.db #0x55	; 85	'U'
	.db #0x28	; 40
	.db #0xd7	; 215
	.db #0x80	; 128
	.db #0x7d	; 125
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0xe0	; 224
	.db #0x10	; 16
	.db #0xa0	; 160
	.db #0x50	; 80	'P'
	.db #0xe0	; 224
	.db #0x10	; 16
	.db #0xa0	; 160
	.db #0x50	; 80	'P'
	.db #0xe0	; 224
	.db #0x18	; 24
	.db #0xa0	; 160
	.db #0x56	; 86	'V'
	.db #0x03	; 3
	.db #0xfc	; 252
	.db #0x41	; 65	'A'
	.db #0x06	; 6
	.db #0xb6	; 182
	.db #0x09	; 9
	.db #0x04	; 4
	.db #0x0b	; 11
	.db #0x0e	; 14
	.db #0x11	; 17
	.db #0x04	; 4
	.db #0x1a	; 26
	.db #0x1c	; 28
	.db #0x22	; 34
	.db #0x14	; 20
	.db #0x2a	; 42
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x40	; 64
	.db #0x80	; 128
	.db #0xb0	; 176
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x1e	; 30
	.db #0x21	; 33
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x0c	; 12
	.db #0xf3	; 243
	.db #0x40	; 64
	.db #0x1c	; 28
	.db #0x98	; 152
	.db #0x24	; 36
	.db #0x08	; 8
	.db #0x34	; 52	'4'
	.db #0x10	; 16
	.db #0x2f	; 47
	.db #0x37	; 55	'7'
	.db #0x48	; 72	'H'
	.db #0x27	; 39
	.db #0x58	; 88	'X'
	.db #0x30	; 48	'0'
	.db #0xcf	; 207
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0xb0	; 176
	.db #0x0f	; 15
	.db #0x06	; 6
	.db #0x09	; 9
	.db #0x00	; 0
	.db #0xcf	; 207
	.db #0x86	; 134
	.db #0x49	; 73	'I'
	.db #0x80	; 128
	.db #0x4f	; 79	'O'
	.db #0x06	; 6
	.db #0xf9	; 249
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0xb0	; 176
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7c	; 124
	.db #0x28	; 40
	.db #0x54	; 84	'T'
	.db #0x28	; 40
	.db #0x54	; 84	'T'
	.db #0x03	; 3
	.db #0x24	; 36
	.db #0x10	; 16
	.db #0x27	; 39
	.db #0x13	; 19
	.db #0x44	; 68	'D'
	.db #0x03	; 3
	.db #0x44	; 68	'D'
	.db #0x19	; 25
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x92	; 146
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xa7	; 167
	.db #0x58	; 88	'X'
	.db #0x35	; 53	'5'
	.db #0xca	; 202
	.db #0xa7	; 167
	.db #0x58	; 88	'X'
	.db #0xb5	; 181
	.db #0x4a	; 74	'J'
	.db #0x27	; 39
	.db #0x08	; 8
	.db #0xc7	; 199
	.db #0x08	; 8
	.db #0x01	; 1
	.db #0xfe	; 254
	.db #0x01	; 1
	.db #0x22	; 34
	.db #0xc7	; 199
	.db #0x28	; 40
	.db #0x47	; 71	'G'
	.db #0xa8	; 168
	.db #0xc0	; 192
	.db #0x2f	; 47
	.db #0x47	; 71	'G'
	.db #0xa8	; 168
	.db #0xc7	; 199
	.db #0x28	; 40
	.db #0xc4	; 196
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0x44	; 68	'D'
	.db #0x8a	; 138
	.db #0x55	; 85	'U'
	.db #0xaf	; 175
	.db #0x50	; 80	'P'
	.db #0x0f	; 15
	.db #0xd0	; 208
	.db #0x89	; 137
	.db #0x40	; 64
	.db #0xa2	; 162
	.db #0x40	; 64
	.db #0xb4	; 180
	.db #0x0a	; 10
	.db #0x04	; 4
	.db #0xfb	; 251
	.db #0x08	; 8
	.db #0x96	; 150
	.db #0x80	; 128
	.db #0x7d	; 125
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0x00	; 0
	.db #0x7d	; 125
	.db #0x2a	; 42
	.db #0x54	; 84	'T'
	.db #0xa9	; 169
	.db #0x54	; 84	'T'
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x21	; 33
	.db #0xa0	; 160
	.db #0x54	; 84	'T'
	.db #0xe8	; 232
	.db #0x14	; 20
	.db #0xa0	; 160
	.db #0x54	; 84	'T'
	.db #0xe0	; 224
	.db #0x14	; 20
	.db #0x48	; 72	'H'
	.db #0x04	; 4
	.db #0x20	; 32
	.db #0x0c	; 12
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x42	; 66	'B'
	.db #0x05	; 5
	.db #0xb0	; 176
	.db #0x05	; 5
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x03	; 3
	.db #0x14	; 20
	.db #0x00	; 0
	.db #0x17	; 23
	.db #0x1b	; 27
	.db #0x24	; 36
	.db #0x10	; 16
	.db #0x27	; 39
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0x01	; 1
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0x3e	; 62
	.db #0xc1	; 193
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0x3e	; 62
	.db #0xc1	; 193
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0x30	; 48	'0'
	.db #0xcf	; 207
	.db #0x87	; 135
	.db #0x48	; 72	'H'
	.db #0x80	; 128
	.db #0x7f	; 127
	.db #0xb7	; 183
	.db #0x48	; 72	'H'
	.db #0x87	; 135
	.db #0x78	; 120	'x'
	.db #0xb0	; 176
	.db #0x4f	; 79	'O'
	.db #0xb7	; 183
	.db #0x48	; 72	'H'
	.db #0x27	; 39
	.db #0x08	; 8
	.db #0x00	; 0
	.db #0xef	; 239
	.db #0x80	; 128
	.db #0x4f	; 79	'O'
	.db #0x06	; 6
	.db #0xf9	; 249
	.db #0xa0	; 160
	.db #0x4f	; 79	'O'
	.db #0x86	; 134
	.db #0x49	; 73	'I'
	.db #0x20	; 32
	.db #0xdf	; 223
	.db #0x8f	; 143
	.db #0x50	; 80	'P'
	.db #0x8a	; 138
	.db #0x55	; 85	'U'
	.db #0x2f	; 47
	.db #0xd0	; 208
	.db #0x28	; 40
	.db #0x55	; 85	'U'
	.db #0x28	; 40
	.db #0xd7	; 215
	.db #0x02	; 2
	.db #0x7d	; 125
	.db #0x28	; 40
	.db #0x55	; 85	'U'
	.db #0x28	; 40
	.db #0xd5	; 213
	.db #0x82	; 130
	.db #0x7d	; 125
	.db #0xa8	; 168
	.db #0x55	; 85	'U'
	.db #0xa8	; 168
	.db #0x55	; 85	'U'
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0xe0	; 224
	.db #0x1e	; 30
	.db #0xa4	; 164
	.db #0x52	; 82	'R'
	.db #0xe8	; 232
	.db #0x12	; 18
	.db #0xa4	; 164
	.db #0x52	; 82	'R'
	.db #0xe8	; 232
	.db #0x12	; 18
	.db #0xa0	; 160
	.db #0x52	; 82	'R'
	.db #0xe4	; 228
	.db #0x12	; 18
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0xb0	; 176
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x1f	; 31
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0xb0	; 176
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x07	; 7
	.db #0x08	; 8
	.db #0x17	; 23
	.db #0x08	; 8
	.db #0x20	; 32
	.db #0xcf	; 207
	.db #0x87	; 135
	.db #0x48	; 72	'H'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0xb0	; 176
	.db #0x0f	; 15
	.db #0x06	; 6
	.db #0xc9	; 201
	.db #0x80	; 128
	.db #0x4f	; 79	'O'
	.db #0x86	; 134
	.db #0x49	; 73	'I'
	.db #0x00	; 0
	.db #0xcf	; 207
	.db #0x86	; 134
	.db #0x49	; 73	'I'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0xb0	; 176
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7c	; 124
	.db #0x28	; 40
	.db #0x54	; 84	'T'
	.db #0x28	; 40
	.db #0x54	; 84	'T'
	.db #0x00	; 0
	.db #0x7c	; 124
	.db #0x0c	; 12
	.db #0x92	; 146
	.db #0x46	; 70	'F'
	.db #0x19	; 25
	.db #0xa2	; 162
	.db #0x15	; 21
	.db #0x03	; 3
	.db #0x14	; 20
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x18	; 24
	.db #0x03	; 3
	.db #0x24	; 36
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0xb0	; 176
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x40	; 64
	.db #0xd8	; 216
	.db #0x20	; 32
	.db #0x66	; 102	'f'
	.db #0x90	; 144
	.db #0x30	; 48	'0'
	.db #0x48	; 72	'H'
	.db #0x03	; 3
	.db #0x0c	; 12
	.db #0x03	; 3
	.db #0x0c	; 12
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0x7f	; 127
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
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x02	; 2
	.db #0xfd	; 253
	.db #0x02	; 2
	.db #0xfd	; 253
	.db #0x0e	; 14
	.db #0xf1	; 241
	.db #0x06	; 6
	.db #0xf9	; 249
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x60	; 96
	.db #0x9f	; 159
	.db #0x20	; 32
	.db #0xdf	; 223
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
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x40	; 64
	.db #0x80	; 128
	.db #0x30	; 48	'0'
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0x18	; 24
	.db #0xe0	; 224
	.db #0x06	; 6
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x01	; 1
	.db #0xb0	; 176
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x18	; 24
	.db #0x07	; 7
	.db #0x21	; 33
	.db #0x06	; 6
	.db #0x03	; 3
	.db #0x04	; 4
	.db #0x08	; 8
	.db #0x87	; 135
	.db #0x00	; 0
	.db #0x77	; 119	'w'
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x66	; 102	'f'
	.db #0x99	; 153
	.db #0xc2	; 194
	.db #0x3d	; 61
	.db #0xc2	; 194
	.db #0x3d	; 61
	.db #0xc3	; 195
	.db #0x3c	; 60
	.db #0x80	; 128
	.db #0x7f	; 127
	.db #0x04	; 4
	.db #0xf8	; 248
	.db #0x08	; 8
	.db #0xf6	; 246
	.db #0x10	; 16
	.db #0xef	; 239
	.db #0x06	; 6
	.db #0xf9	; 249
	.db #0x0e	; 14
	.db #0xf1	; 241
	.db #0x1c	; 28
	.db #0xe3	; 227
	.db #0x1c	; 28
	.db #0xe3	; 227
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
	.db #0xff	; 255
	.db #0x03	; 3
	.db #0xfc	; 252
	.db #0x01	; 1
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x08	; 8
	.db #0xf7	; 247
	.db #0x18	; 24
	.db #0xe7	; 231
	.db #0x10	; 16
	.db #0xef	; 239
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0x7f	; 127
	.db #0x80	; 128
	.db #0x7f	; 127
	.db #0x40	; 64
	.db #0xbf	; 191
	.db #0xc0	; 192
	.db #0x3f	; 63
	.db #0xe0	; 224
	.db #0x1f	; 31
	.db #0x30	; 48	'0'
	.db #0xcf	; 207
	.db #0x19	; 25
	.db #0xe6	; 230
	.db #0x18	; 24
	.db #0xe7	; 231
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x10	; 16
	.db #0xa7	; 167
	.db #0x20	; 32
	.db #0x87	; 135
	.db #0xc0	; 192
	.db #0x37	; 55	'7'
	.db #0x84	; 132
	.db #0x7b	; 123
	.db #0x04	; 4
	.db #0xfb	; 251
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xe2	; 226
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x18	; 24
	.db #0x65	; 101	'e'
	.db #0x0c	; 12
	.db #0x53	; 83	'S'
	.db #0x04	; 4
	.db #0x4b	; 75	'K'
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x17	; 23
	.db #0x10	; 16
	.db #0x2f	; 47
	.db #0x00	; 0
	.db #0x2f	; 47
	.db #0x08	; 8
	.db #0x47	; 71	'G'
	.db #0x00	; 0
	.db #0xef	; 239
	.db #0x00	; 0
	.db #0x27	; 39
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x08	; 8
	.db #0xd7	; 215
	.db #0x04	; 4
	.db #0xfb	; 251
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xf9	; 249
	.db #0x00	; 0
	.db #0xf9	; 249
	.db #0x10	; 16
	.db #0xef	; 239
	.db #0x31	; 49	'1'
	.db #0xce	; 206
	.db #0x21	; 33
	.db #0xde	; 222
	.db #0x60	; 96
	.db #0x9f	; 159
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x90	; 144
	.db #0x6f	; 111	'o'
	.db #0x80	; 128
	.db #0x7f	; 127
	.db #0x80	; 128
	.db #0x7f	; 127
	.db #0x40	; 64
	.db #0xbe	; 190
	.db #0x40	; 64
	.db #0xbe	; 190
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x06	; 6
	.db #0xf8	; 248
	.db #0x04	; 4
	.db #0xfb	; 251
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x20	; 32
	.db #0x1f	; 31
	.db #0x40	; 64
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0xf7	; 247
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x18	; 24
	.db #0xe7	; 231
	.db #0x10	; 16
	.db #0xef	; 239
	.db #0x30	; 48	'0'
	.db #0xcf	; 207
	.db #0x20	; 32
	.db #0xdf	; 223
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xef	; 239
	.db #0x00	; 0
	.db #0xcf	; 207
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0xb0	; 176
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x18	; 24
	.db #0x03	; 3
	.db #0x20	; 32
	.db #0xc6	; 198
	.db #0x00	; 0
	.db #0x44	; 68	'D'
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x87	; 135
	.db #0x03	; 3
	.db #0x84	; 132
	.db #0x02	; 2
	.db #0x4d	; 77	'M'
	.db #0x00	; 0
	.db #0x6f	; 111	'o'
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x18	; 24
	.db #0x27	; 39
	.db #0x10	; 16
	.db #0xef	; 239
	.db #0x00	; 0
	.db #0xc3	; 195
	.db #0x01	; 1
	.db #0xe6	; 230
	.db #0x01	; 1
	.db #0xe6	; 230
	.db #0x03	; 3
	.db #0xec	; 236
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x40	; 64
	.db #0xbf	; 191
	.db #0xa0	; 160
	.db #0x5f	; 95
	.db #0x88	; 136
	.db #0x77	; 119	'w'
	.db #0x84	; 132
	.db #0x7b	; 123
	.db #0x81	; 129
	.db #0x7e	; 126
	.db #0x01	; 1
	.db #0xfe	; 254
	.db #0x03	; 3
	.db #0xfc	; 252
	.db #0x04	; 4
	.db #0xfb	; 251
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xa0	; 160
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0x80	; 128
	.db #0x70	; 112	'p'
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x20	; 32
	.db #0xd8	; 216
	.db #0x10	; 16
	.db #0xec	; 236
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0xb0	; 176
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x26	; 38
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0xb0	; 176
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x26	; 38
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x81	; 129
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0xb0	; 176
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x34	; 52	'4'
	.db #0x00	; 0
	.db #0x64	; 100	'd'
	.db #0x02	; 2
	.db #0xfd	; 253
	.db #0x08	; 8
	.db #0xf5	; 245
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0xb0	; 176
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x26	; 38
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x60	; 96
	.db #0x56	; 86	'V'
	.db #0x89	; 137
	.db #0x70	; 112	'p'
	.db #0x8f	; 143
	.db #0x00	; 0
	.db #0xf6	; 246
	.db #0x00	; 0
	.db #0x72	; 114	'r'
	.db #0x00	; 0
	.db #0x22	; 34
	.db #0x18	; 24
	.db #0xa2	; 162
	.db #0x04	; 4
	.db #0xa2	; 162
	.db #0x00	; 0
	.db #0xe2	; 226
	.db #0x00	; 0
	.db #0x72	; 114	'r'
	.db #0x40	; 64
	.db #0x22	; 34
	.db #0x90	; 144
	.db #0x22	; 34
	.db #0x00	; 0
	.db #0x22	; 34
	.db #0x00	; 0
	.db #0x22	; 34
	.db #0x18	; 24
	.db #0x20	; 32
	.db #0x06	; 6
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0xb0	; 176
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x03	; 3
	.db #0x7c	; 124
	.db #0x07	; 7
	.db #0xf8	; 248
	.db #0x75	; 117	'u'
	.db #0x88	; 136
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x40	; 64
	.db #0x0f	; 15
	.db #0x87	; 135
	.db #0x78	; 120	'x'
	.db #0x05	; 5
	.db #0xf8	; 248
	.db #0x77	; 119	'w'
	.db #0x88	; 136
	.db #0x50	; 80	'P'
	.db #0x8f	; 143
	.db #0x70	; 112	'p'
	.db #0x8f	; 143
	.db #0x00	; 0
	.db #0xf6	; 246
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0xb0	; 176
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x26	; 38
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_mapframetiles:
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
	.db #0xff	; 255
_airbasemaptiles:
	.db #0x60	; 96
	.db #0x00	; 0
	.db #0x60	; 96
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x06	; 6
	.db #0x00	; 0
	.db #0x83	; 131
	.db #0x00	; 0
	.db #0x83	; 131
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xc4	; 196
	.db #0x00	; 0
	.db #0x64	; 100	'd'
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x86	; 134
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x82	; 130
	.db #0x00	; 0
	.db #0x82	; 130
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x11	; 17
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0xc1	; 193
	.db #0x00	; 0
	.db #0x61	; 97	'a'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x2f	; 47
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x71	; 113	'q'
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0xe2	; 226
	.db #0x00	; 0
	.db #0x21	; 33
	.db #0x00	; 0
	.db #0x22	; 34
	.db #0x00	; 0
	.db #0xb0	; 176
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0x86	; 134
	.db #0x00	; 0
	.db #0x85	; 133
	.db #0x00	; 0
	.db #0xc9	; 201
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x24	; 36
	.db #0x00	; 0
	.db #0x31	; 49	'1'
	.db #0x00	; 0
	.db #0x13	; 19
	.db #0x00	; 0
	.db #0x0c	; 12
	.db #0x00	; 0
	.db #0x44	; 68	'D'
	.db #0x00	; 0
	.db #0x25	; 37
	.db #0x00	; 0
	.db #0x54	; 84	'T'
	.db #0x1c	; 28
	.db #0x34	; 52	'4'
	.db #0x1c	; 28
	.db #0x36	; 54	'6'
	.db #0x1c	; 28
	.db #0x55	; 85	'U'
	.db #0x1c	; 28
	.db #0xd7	; 215
	.db #0x1c	; 28
	.db #0x15	; 21
	.db #0x1c	; 28
	.db #0x74	; 116	't'
	.db #0x1c	; 28
	.db #0xd7	; 215
	.db #0x1c	; 28
	.db #0x45	; 69	'E'
	.db #0x07	; 7
	.db #0x15	; 21
	.db #0x07	; 7
	.db #0xa5	; 165
	.db #0x07	; 7
	.db #0xcd	; 205
	.db #0x07	; 7
	.db #0x35	; 53	'5'
	.db #0x07	; 7
	.db #0xc5	; 197
	.db #0x07	; 7
	.db #0xbd	; 189
	.db #0x07	; 7
	.db #0x25	; 37
	.db #0x07	; 7
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x4b	; 75	'K'
	.db #0x01	; 1
	.db #0xa5	; 165
	.db #0x01	; 1
	.db #0x6d	; 109	'm'
	.db #0x01	; 1
	.db #0xb7	; 183
	.db #0x01	; 1
	.db #0x91	; 145
	.db #0x01	; 1
	.db #0x1d	; 29
	.db #0x01	; 1
	.db #0x73	; 115	's'
	.db #0x01	; 1
	.db #0x40	; 64
	.db #0xc0	; 192
	.db #0x4a	; 74	'J'
	.db #0xc0	; 192
	.db #0x50	; 80	'P'
	.db #0xc0	; 192
	.db #0x5e	; 94
	.db #0xc0	; 192
	.db #0x65	; 101	'e'
	.db #0xc0	; 192
	.db #0x4f	; 79	'O'
	.db #0xc0	; 192
	.db #0x71	; 113	'q'
	.db #0xc0	; 192
	.db #0x60	; 96
	.db #0xc0	; 192
	.db #0x50	; 80	'P'
	.db #0x70	; 112	'p'
	.db #0x54	; 84	'T'
	.db #0x70	; 112	'p'
	.db #0xd9	; 217
	.db #0x70	; 112	'p'
	.db #0x55	; 85	'U'
	.db #0x70	; 112	'p'
	.db #0xda	; 218
	.db #0x70	; 112	'p'
	.db #0xd9	; 217
	.db #0x70	; 112	'p'
	.db #0xd6	; 214
	.db #0x70	; 112	'p'
	.db #0xdc	; 220
	.db #0x70	; 112	'p'
	.db #0x21	; 33
	.db #0x3f	; 63
	.db #0xa1	; 161
	.db #0x3f	; 63
	.db #0x21	; 33
	.db #0x3f	; 63
	.db #0x43	; 67	'C'
	.db #0x7e	; 126
	.db #0xc2	; 194
	.db #0x7e	; 126
	.db #0xc3	; 195
	.db #0x7e	; 126
	.db #0x86	; 134
	.db #0xfc	; 252
	.db #0x85	; 133
	.db #0xfc	; 252
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x51	; 81	'Q'
	.db #0x00	; 0
	.db #0xe2	; 226
	.db #0x00	; 0
	.db #0x5d	; 93
	.db #0x00	; 0
	.db #0xc2	; 194
	.db #0x00	; 0
	.db #0x65	; 101	'e'
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0xff	; 255
	.db #0x20	; 32
	.db #0x3f	; 63
	.db #0x60	; 96
	.db #0x3f	; 63
	.db #0xa0	; 160
	.db #0x3f	; 63
	.db #0xa0	; 160
	.db #0x3f	; 63
	.db #0x60	; 96
	.db #0x3f	; 63
	.db #0x60	; 96
	.db #0x3f	; 63
	.db #0xa0	; 160
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0xff	; 255
	.db #0x30	; 48	'0'
	.db #0xe0	; 224
	.db #0x24	; 36
	.db #0xe0	; 224
	.db #0x29	; 41
	.db #0xe0	; 224
	.db #0x37	; 55	'7'
	.db #0xe0	; 224
	.db #0x3c	; 60
	.db #0xe0	; 224
	.db #0x23	; 35
	.db #0xe0	; 224
	.db #0x24	; 36
	.db #0xe0	; 224
	.db #0xff	; 255
	.db #0xf9	; 249
	.db #0x4f	; 79	'O'
	.db #0x09	; 9
	.db #0x1f	; 31
	.db #0x09	; 9
	.db #0x5f	; 95
	.db #0x11	; 17
	.db #0xbf	; 191
	.db #0x10	; 16
	.db #0xdf	; 223
	.db #0x10	; 16
	.db #0x9f	; 159
	.db #0x14	; 20
	.db #0xff	; 255
	.db #0x10	; 16
	.db #0xff	; 255
	.db #0x1f	; 31
	.db #0xf0	; 240
	.db #0x10	; 16
	.db #0xf0	; 240
	.db #0x10	; 16
	.db #0xf8	; 248
	.db #0x08	; 8
	.db #0xfe	; 254
	.db #0x88	; 136
	.db #0xfb	; 251
	.db #0x88	; 136
	.db #0xfb	; 251
	.db #0xa8	; 168
	.db #0xfc	; 252
	.db #0x88	; 136
	.db #0xfc	; 252
	.db #0xff	; 255
	.db #0x04	; 4
	.db #0x07	; 7
	.db #0x04	; 4
	.db #0x07	; 7
	.db #0x44	; 68	'D'
	.db #0x07	; 7
	.db #0xdc	; 220
	.db #0x07	; 7
	.db #0x24	; 36
	.db #0x07	; 7
	.db #0xbc	; 188
	.db #0x07	; 7
	.db #0x4c	; 76	'L'
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0xff	; 255
	.db #0x04	; 4
	.db #0xfc	; 252
	.db #0x06	; 6
	.db #0xfc	; 252
	.db #0x05	; 5
	.db #0xfc	; 252
	.db #0x06	; 6
	.db #0xfc	; 252
	.db #0x05	; 5
	.db #0xfc	; 252
	.db #0x05	; 5
	.db #0xfc	; 252
	.db #0x07	; 7
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0xc8	; 200
	.db #0x00	; 0
	.db #0x77	; 119	'w'
	.db #0x00	; 0
	.db #0x19	; 25
	.db #0x00	; 0
	.db #0xb9	; 185
	.db #0x00	; 0
	.db #0x47	; 71	'G'
	.db #0x00	; 0
	.db #0x84	; 132
	.db #0xfc	; 252
	.db #0x85	; 133
	.db #0xfc	; 252
	.db #0x86	; 134
	.db #0xfc	; 252
	.db #0xc2	; 194
	.db #0x7e	; 126
	.db #0x43	; 67	'C'
	.db #0x7e	; 126
	.db #0xc2	; 194
	.db #0x7e	; 126
	.db #0xe1	; 225
	.db #0x3f	; 63
	.db #0x21	; 33
	.db #0x3f	; 63
	.db #0x0a	; 10
	.db #0x0e	; 14
	.db #0x0a	; 10
	.db #0x0e	; 14
	.db #0x4a	; 74	'J'
	.db #0x0e	; 14
	.db #0xea	; 234
	.db #0x0e	; 14
	.db #0x1b	; 27
	.db #0x0e	; 14
	.db #0x6b	; 107	'k'
	.db #0x0e	; 14
	.db #0x5a	; 90	'Z'
	.db #0x0e	; 14
	.db #0x8b	; 139
	.db #0x0e	; 14
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x66	; 102	'f'
	.db #0x03	; 3
	.db #0xaa	; 170
	.db #0x03	; 3
	.db #0x72	; 114	'r'
	.db #0x03	; 3
	.db #0xaa	; 170
	.db #0x03	; 3
	.db #0x16	; 22
	.db #0x03	; 3
	.db #0xca	; 202
	.db #0x03	; 3
	.db #0x36	; 54	'6'
	.db #0x03	; 3
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xa2	; 162
	.db #0x80	; 128
	.db #0xce	; 206
	.db #0x80	; 128
	.db #0xb5	; 181
	.db #0x80	; 128
	.db #0xd6	; 214
	.db #0x80	; 128
	.db #0x89	; 137
	.db #0x80	; 128
	.db #0xbc	; 188
	.db #0x80	; 128
	.db #0xe3	; 227
	.db #0x80	; 128
	.db #0xa5	; 165
	.db #0xe0	; 224
	.db #0xb9	; 185
	.db #0xe0	; 224
	.db #0xa4	; 164
	.db #0xe0	; 224
	.db #0xb9	; 185
	.db #0xe0	; 224
	.db #0xab	; 171
	.db #0xe0	; 224
	.db #0xae	; 174
	.db #0xe0	; 224
	.db #0xb1	; 177
	.db #0xe0	; 224
	.db #0xa0	; 160
	.db #0xe0	; 224
	.db #0x29	; 41
	.db #0x38	; 56	'8'
	.db #0x2c	; 44
	.db #0x38	; 56	'8'
	.db #0x6a	; 106	'j'
	.db #0x38	; 56	'8'
	.db #0xed	; 237
	.db #0x38	; 56	'8'
	.db #0x68	; 104	'h'
	.db #0x38	; 56	'8'
	.db #0x2b	; 43
	.db #0x38	; 56	'8'
	.db #0xae	; 174
	.db #0x38	; 56	'8'
	.db #0xe8	; 232
	.db #0x38	; 56	'8'
	.db #0xf6	; 246
	.db #0x3e	; 62
	.db #0xf4	; 244
	.db #0xfc	; 252
	.db #0x14	; 20
	.db #0x1c	; 28
	.db #0x14	; 20
	.db #0x1c	; 28
	.db #0x14	; 20
	.db #0x1c	; 28
	.db #0x14	; 20
	.db #0x1c	; 28
	.db #0x14	; 20
	.db #0x1c	; 28
	.db #0x14	; 20
	.db #0x1c	; 28
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x40	; 64
	.db #0xc0	; 192
	.db #0x40	; 64
	.db #0xc0	; 192
	.db #0x40	; 64
	.db #0xc0	; 192
	.db #0x40	; 64
	.db #0xc0	; 192
	.db #0x40	; 64
	.db #0xc0	; 192
	.db #0x40	; 64
	.db #0xc0	; 192
	.db #0x40	; 64
	.db #0xc0	; 192
	.db #0x40	; 64
	.db #0xc0	; 192
	.db #0x50	; 80	'P'
	.db #0x70	; 112	'p'
	.db #0x50	; 80	'P'
	.db #0x70	; 112	'p'
	.db #0x50	; 80	'P'
	.db #0x70	; 112	'p'
	.db #0x50	; 80	'P'
	.db #0x70	; 112	'p'
	.db #0x50	; 80	'P'
	.db #0x70	; 112	'p'
	.db #0x50	; 80	'P'
	.db #0x70	; 112	'p'
	.db #0x50	; 80	'P'
	.db #0x70	; 112	'p'
	.db #0x50	; 80	'P'
	.db #0x70	; 112	'p'
	.db #0x21	; 33
	.db #0x3e	; 62
	.db #0x10	; 16
	.db #0x1f	; 31
	.db #0x09	; 9
	.db #0x0e	; 14
	.db #0x08	; 8
	.db #0x0f	; 15
	.db #0x10	; 16
	.db #0x1f	; 31
	.db #0x10	; 16
	.db #0x1f	; 31
	.db #0x10	; 16
	.db #0x1f	; 31
	.db #0x20	; 32
	.db #0x3f	; 63
	.db #0xc4	; 196
	.db #0x3b	; 59
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xc4	; 196
	.db #0x3b	; 59
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x44	; 68	'D'
	.db #0xbb	; 187
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x44	; 68	'D'
	.db #0xbb	; 187
	.db #0xc0	; 192
	.db #0xff	; 255
	.db #0x9e	; 158
	.db #0x61	; 97	'a'
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x9e	; 158
	.db #0x61	; 97	'a'
	.db #0x40	; 64
	.db #0xbf	; 191
	.db #0x9e	; 158
	.db #0x61	; 97	'a'
	.db #0x40	; 64
	.db #0xbf	; 191
	.db #0x9e	; 158
	.db #0x61	; 97	'a'
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x32	; 50	'2'
	.db #0xcd	; 205
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x32	; 50	'2'
	.db #0xcd	; 205
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x32	; 50	'2'
	.db #0xcd	; 205
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x32	; 50	'2'
	.db #0xcd	; 205
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x87	; 135
	.db #0x7d	; 125
	.db #0x07	; 7
	.db #0xfd	; 253
	.db #0x87	; 135
	.db #0x7d	; 125
	.db #0x0f	; 15
	.db #0xf9	; 249
	.db #0x8f	; 143
	.db #0x79	; 121	'y'
	.db #0x0f	; 15
	.db #0xf9	; 249
	.db #0x8f	; 143
	.db #0x7b	; 123
	.db #0x0f	; 15
	.db #0xf9	; 249
	.db #0xe3	; 227
	.db #0xbc	; 188
	.db #0xe0	; 224
	.db #0x3f	; 63
	.db #0xe3	; 227
	.db #0x3c	; 60
	.db #0xf0	; 240
	.db #0x1f	; 31
	.db #0xf3	; 243
	.db #0x1c	; 28
	.db #0xf0	; 240
	.db #0x1f	; 31
	.db #0xf3	; 243
	.db #0x5c	; 92
	.db #0xf0	; 240
	.db #0x1f	; 31
	.db #0x39	; 57	'9'
	.db #0xc6	; 198
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x39	; 57	'9'
	.db #0xc6	; 198
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x39	; 57	'9'
	.db #0xc6	; 198
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x39	; 57	'9'
	.db #0xc6	; 198
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xf9	; 249
	.db #0x06	; 6
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xf9	; 249
	.db #0x06	; 6
	.db #0x02	; 2
	.db #0xfd	; 253
	.db #0xf9	; 249
	.db #0x06	; 6
	.db #0x02	; 2
	.db #0xfd	; 253
	.db #0xf9	; 249
	.db #0x06	; 6
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xfc	; 252
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xfc	; 252
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xfc	; 252
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xfc	; 252
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0xff	; 255
	.db #0xa4	; 164
	.db #0x5c	; 92
	.db #0x08	; 8
	.db #0xf8	; 248
	.db #0x90	; 144
	.db #0x70	; 112	'p'
	.db #0x10	; 16
	.db #0xf0	; 240
	.db #0x08	; 8
	.db #0xf8	; 248
	.db #0x08	; 8
	.db #0xf8	; 248
	.db #0x08	; 8
	.db #0xf8	; 248
	.db #0x04	; 4
	.db #0xfc	; 252
	.db #0x0a	; 10
	.db #0x0e	; 14
	.db #0x0a	; 10
	.db #0x0e	; 14
	.db #0x0a	; 10
	.db #0x0e	; 14
	.db #0x0a	; 10
	.db #0x0e	; 14
	.db #0x0a	; 10
	.db #0x0e	; 14
	.db #0x0a	; 10
	.db #0x0e	; 14
	.db #0x0a	; 10
	.db #0x0e	; 14
	.db #0x0a	; 10
	.db #0x0e	; 14
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xa0	; 160
	.db #0xe0	; 224
	.db #0xa0	; 160
	.db #0xe0	; 224
	.db #0xa0	; 160
	.db #0xe0	; 224
	.db #0xa0	; 160
	.db #0xe0	; 224
	.db #0xa0	; 160
	.db #0xe0	; 224
	.db #0xa0	; 160
	.db #0xe0	; 224
	.db #0xa0	; 160
	.db #0xe0	; 224
	.db #0xa0	; 160
	.db #0xe0	; 224
	.db #0x7f	; 127
	.db #0x7c	; 124
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x28	; 40
	.db #0x38	; 56	'8'
	.db #0x28	; 40
	.db #0x38	; 56	'8'
	.db #0x28	; 40
	.db #0x38	; 56	'8'
	.db #0x28	; 40
	.db #0x38	; 56	'8'
	.db #0x28	; 40
	.db #0x38	; 56	'8'
	.db #0x28	; 40
	.db #0x38	; 56	'8'
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x07	; 7
	.db #0x06	; 6
	.db #0x3f	; 63
	.db #0x3a	; 58
	.db #0xff	; 255
	.db #0xc0	; 192
	.db #0xff	; 255
	.db #0x3c	; 60
	.db #0xc3	; 195
	.db #0x42	; 66	'B'
	.db #0xff	; 255
	.db #0x3d	; 61
	.db #0xff	; 255
	.db #0x06	; 6
	.db #0xff	; 255
	.db #0xc0	; 192
	.db #0xff	; 255
	.db #0x78	; 120	'x'
	.db #0x87	; 135
	.db #0x84	; 132
	.db #0xff	; 255
	.db #0x79	; 121	'y'
	.db #0xff	; 255
	.db #0x07	; 7
	.db #0xff	; 255
	.db #0xbf	; 191
	.db #0xcd	; 205
	.db #0xcf	; 207
	.db #0x3d	; 61
	.db #0x07	; 7
	.db #0x87	; 135
	.db #0x84	; 132
	.db #0xff	; 255
	.db #0x78	; 120	'x'
	.db #0xff	; 255
	.db #0x40	; 64
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x87	; 135
	.db #0x81	; 129
	.db #0xad	; 173
	.db #0x01	; 1
	.db #0xf9	; 249
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x87	; 135
	.db #0x84	; 132
	.db #0xff	; 255
	.db #0x78	; 120	'x'
	.db #0xff	; 255
	.db #0x40	; 64
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xe2	; 226
	.db #0xe0	; 224
	.db #0x40	; 64
	.db #0xc0	; 192
	.db #0x4e	; 78	'N'
	.db #0xc0	; 192
	.db #0x71	; 113	'q'
	.db #0xc0	; 192
	.db #0x87	; 135
	.db #0x84	; 132
	.db #0xff	; 255
	.db #0x78	; 120	'x'
	.db #0xff	; 255
	.db #0x41	; 65	'A'
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xfb	; 251
	.db #0xfb	; 251
	.db #0x51	; 81	'Q'
	.db #0x71	; 113	'q'
	.db #0x55	; 85	'U'
	.db #0x70	; 112	'p'
	.db #0xda	; 218
	.db #0x70	; 112	'p'
	.db #0x99	; 153
	.db #0xe6	; 230
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x99	; 153
	.db #0xe6	; 230
	.db #0xe0	; 224
	.db #0xff	; 255
	.db #0xf9	; 249
	.db #0xe6	; 230
	.db #0xe0	; 224
	.db #0xff	; 255
	.db #0xf9	; 249
	.db #0xe6	; 230
	.db #0x60	; 96
	.db #0x7f	; 127
	.db #0xc4	; 196
	.db #0x3b	; 59
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xc4	; 196
	.db #0x3b	; 59
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xc4	; 196
	.db #0x3b	; 59
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xc4	; 196
	.db #0x3b	; 59
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x9e	; 158
	.db #0x61	; 97	'a'
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x9e	; 158
	.db #0x61	; 97	'a'
	.db #0x40	; 64
	.db #0xbf	; 191
	.db #0x9e	; 158
	.db #0x61	; 97	'a'
	.db #0x40	; 64
	.db #0xbf	; 191
	.db #0x9e	; 158
	.db #0x61	; 97	'a'
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x32	; 50	'2'
	.db #0xcd	; 205
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x32	; 50	'2'
	.db #0xcd	; 205
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x32	; 50	'2'
	.db #0xcd	; 205
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x32	; 50	'2'
	.db #0xcd	; 205
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x83	; 131
	.db #0x7f	; 127
	.db #0x07	; 7
	.db #0xff	; 255
	.db #0x8f	; 143
	.db #0x7e	; 126
	.db #0x0f	; 15
	.db #0xfd	; 253
	.db #0x8f	; 143
	.db #0x7d	; 125
	.db #0x0f	; 15
	.db #0xfd	; 253
	.db #0x87	; 135
	.db #0x7d	; 125
	.db #0x07	; 7
	.db #0xfd	; 253
	.db #0xc3	; 195
	.db #0xfc	; 252
	.db #0xe0	; 224
	.db #0xff	; 255
	.db #0xf3	; 243
	.db #0x7c	; 124
	.db #0xf0	; 240
	.db #0x3f	; 63
	.db #0xf3	; 243
	.db #0x3c	; 60
	.db #0xf0	; 240
	.db #0x3f	; 63
	.db #0xe3	; 227
	.db #0x3c	; 60
	.db #0xe0	; 224
	.db #0x3f	; 63
	.db #0x39	; 57	'9'
	.db #0xc6	; 198
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x39	; 57	'9'
	.db #0xc6	; 198
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x39	; 57	'9'
	.db #0xc6	; 198
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x39	; 57	'9'
	.db #0xc6	; 198
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xf9	; 249
	.db #0x06	; 6
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xf9	; 249
	.db #0x06	; 6
	.db #0x02	; 2
	.db #0xfd	; 253
	.db #0xf9	; 249
	.db #0x06	; 6
	.db #0x02	; 2
	.db #0xfd	; 253
	.db #0xf9	; 249
	.db #0x06	; 6
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xfc	; 252
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xfc	; 252
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xfc	; 252
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xfc	; 252
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xb9	; 185
	.db #0x47	; 71	'G'
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0xb9	; 185
	.db #0x47	; 71	'G'
	.db #0x03	; 3
	.db #0xff	; 255
	.db #0xbb	; 187
	.db #0x47	; 71	'G'
	.db #0x03	; 3
	.db #0xff	; 255
	.db #0xbb	; 187
	.db #0x47	; 71	'G'
	.db #0x02	; 2
	.db #0xfe	; 254
	.db #0xe1	; 225
	.db #0x21	; 33
	.db #0xff	; 255
	.db #0x1e	; 30
	.db #0xff	; 255
	.db #0x82	; 130
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xdf	; 223
	.db #0xdf	; 223
	.db #0xaa	; 170
	.db #0x8e	; 142
	.db #0x9b	; 155
	.db #0x0e	; 14
	.db #0x6a	; 106	'j'
	.db #0x0e	; 14
	.db #0xe1	; 225
	.db #0x21	; 33
	.db #0xff	; 255
	.db #0x1e	; 30
	.db #0xff	; 255
	.db #0x02	; 2
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x0a	; 10
	.db #0x03	; 3
	.db #0x1a	; 26
	.db #0x03	; 3
	.db #0xf2	; 242
	.db #0x03	; 3
	.db #0xe1	; 225
	.db #0x21	; 33
	.db #0xff	; 255
	.db #0x1e	; 30
	.db #0xff	; 255
	.db #0x02	; 2
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xc1	; 193
	.db #0xc1	; 193
	.db #0x83	; 131
	.db #0x80	; 128
	.db #0xfe	; 254
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x03	; 3
	.db #0xff	; 255
	.db #0x1e	; 30
	.db #0xe1	; 225
	.db #0x21	; 33
	.db #0xff	; 255
	.db #0x9e	; 158
	.db #0xff	; 255
	.db #0xe0	; 224
	.db #0xff	; 255
	.db #0xfd	; 253
	.db #0xbb	; 187
	.db #0xf3	; 243
	.db #0xaf	; 175
	.db #0xe0	; 224
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xe0	; 224
	.db #0x60	; 96
	.db #0xfc	; 252
	.db #0x5c	; 92
	.db #0xff	; 255
	.db #0x03	; 3
	.db #0xff	; 255
	.db #0x3c	; 60
	.db #0xc3	; 195
	.db #0x42	; 66	'B'
	.db #0xff	; 255
	.db #0xbc	; 188
	.db #0x7f	; 127
	.db #0x60	; 96
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
	.db #0x06	; 6
	.db #0x3f	; 63
	.db #0x38	; 56	'8'
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
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x78	; 120	'x'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x02	; 2
	.db #0xff	; 255
	.db #0x78	; 120	'x'
	.db #0x26	; 38
	.db #0x38	; 56	'8'
	.db #0x6d	; 109	'm'
	.db #0x70	; 112	'p'
	.db #0xea	; 234
	.db #0xf0	; 240
	.db #0xed	; 237
	.db #0xf0	; 240
	.db #0xea	; 234
	.db #0xf0	; 240
	.db #0xcd	; 205
	.db #0xf0	; 240
	.db #0x9f	; 159
	.db #0xe0	; 224
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0x00	; 0
	.db #0x55	; 85	'U'
	.db #0x00	; 0
	.db #0xaa	; 170
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0xfe	; 254
	.db #0x7c	; 124
	.db #0x82	; 130
	.db #0x55	; 85	'U'
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0x04	; 4
	.db #0x51	; 81	'Q'
	.db #0x0c	; 12
	.db #0xaa	; 170
	.db #0x15	; 21
	.db #0x58	; 88	'X'
	.db #0x25	; 37
	.db #0xba	; 186
	.db #0x45	; 69	'E'
	.db #0x28	; 40
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0x00	; 0
	.db #0x55	; 85	'U'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0x01	; 1
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xfe	; 254
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0x00	; 0
	.db #0x55	; 85	'U'
	.db #0x00	; 0
	.db #0xaa	; 170
	.db #0x01	; 1
	.db #0x55	; 85	'U'
	.db #0x02	; 2
	.db #0xa0	; 160
	.db #0x1f	; 31
	.db #0x5b	; 91
	.db #0x24	; 36
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0x00	; 0
	.db #0x15	; 21
	.db #0xe0	; 224
	.db #0xea	; 234
	.db #0x10	; 16
	.db #0xb5	; 181
	.db #0x48	; 72	'H'
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x6b	; 107	'k'
	.db #0x94	; 148
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0x3e	; 62
	.db #0x5d	; 93
	.db #0x22	; 34
	.db #0x94	; 148
	.db #0x2a	; 42
	.db #0x5d	; 93
	.db #0x22	; 34
	.db #0x94	; 148
	.db #0x2a	; 42
	.db #0x5d	; 93
	.db #0xa2	; 162
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0x04	; 4
	.db #0x51	; 81	'Q'
	.db #0x0c	; 12
	.db #0xaa	; 170
	.db #0x15	; 21
	.db #0x58	; 88	'X'
	.db #0x25	; 37
	.db #0xba	; 186
	.db #0x45	; 69	'E'
	.db #0x28	; 40
	.db #0x55	; 85	'U'
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0x00	; 0
	.db #0x55	; 85	'U'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0x01	; 1
	.db #0xaa	; 170
	.db #0x55	; 85	'U'
	.db #0xfe	; 254
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xa4	; 164
	.db #0x1c	; 28
	.db #0x56	; 86	'V'
	.db #0x0e	; 14
	.db #0xb7	; 183
	.db #0x0f	; 15
	.db #0x57	; 87	'W'
	.db #0x0f	; 15
	.db #0xb7	; 183
	.db #0x0f	; 15
	.db #0x53	; 83	'S'
	.db #0x0f	; 15
	.db #0xf9	; 249
	.db #0x07	; 7
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x40	; 64
	.db #0xff	; 255
	.db #0x1e	; 30
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
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x1e	; 30
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
	.db #0xe0	; 224
	.db #0x60	; 96
	.db #0xfc	; 252
	.db #0x1c	; 28
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x04	; 4
	.db #0x07	; 7
	.db #0x09	; 9
	.db #0x0e	; 14
	.db #0x13	; 19
	.db #0x1c	; 28
	.db #0x20	; 32
	.db #0x3f	; 63
	.db #0x4f	; 79	'O'
	.db #0x70	; 112	'p'
	.db #0x9a	; 154
	.db #0xe0	; 224
	.db #0x35	; 53	'5'
	.db #0xc0	; 192
	.db #0x6a	; 106	'j'
	.db #0x80	; 128
	.db #0xd5	; 213
	.db #0x00	; 0
	.db #0xaa	; 170
	.db #0x00	; 0
	.db #0x55	; 85	'U'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xaa	; 170
	.db #0x00	; 0
	.db #0x55	; 85	'U'
	.db #0x00	; 0
	.db #0xaa	; 170
	.db #0x00	; 0
	.db #0x55	; 85	'U'
	.db #0x00	; 0
	.db #0xaa	; 170
	.db #0x00	; 0
	.db #0x55	; 85	'U'
	.db #0x00	; 0
	.db #0x04	; 4
	.db #0xfc	; 252
	.db #0xf2	; 242
	.db #0x0e	; 14
	.db #0xa9	; 169
	.db #0x07	; 7
	.db #0x54	; 84	'T'
	.db #0x03	; 3
	.db #0xaa	; 170
	.db #0x01	; 1
	.db #0x55	; 85	'U'
	.db #0x00	; 0
	.db #0xaa	; 170
	.db #0x00	; 0
	.db #0x55	; 85	'U'
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
	.db #0x20	; 32
	.db #0xe0	; 224
	.db #0x90	; 144
	.db #0x70	; 112	'p'
	.db #0x48	; 72	'H'
	.db #0x38	; 56	'8'
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
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x08	; 8
	.db #0x0f	; 15
	.db #0x10	; 16
	.db #0x1f	; 31
	.db #0x10	; 16
	.db #0x1f	; 31
	.db #0x28	; 40
	.db #0x0f	; 15
	.db #0x58	; 88	'X'
	.db #0x0f	; 15
	.db #0xfc	; 252
	.db #0x07	; 7
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x40	; 64
	.db #0xc0	; 192
	.db #0x20	; 32
	.db #0xe0	; 224
	.db #0x20	; 32
	.db #0xe0	; 224
	.db #0x3f	; 63
	.db #0xff	; 255
	.db #0x20	; 32
	.db #0xff	; 255
	.db #0x10	; 16
	.db #0xff	; 255
	.db #0x10	; 16
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x30	; 48	'0'
	.db #0x1f	; 31
	.db #0x50	; 80	'P'
	.db #0x1f	; 31
	.db #0xb0	; 176
	.db #0x1f	; 31
	.db #0xf0	; 240
	.db #0xff	; 255
	.db #0x10	; 16
	.db #0xff	; 255
	.db #0x10	; 16
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x08	; 8
	.db #0xf8	; 248
	.db #0x08	; 8
	.db #0xf8	; 248
	.db #0x08	; 8
	.db #0xf8	; 248
	.db #0x0f	; 15
	.db #0xff	; 255
	.db #0x08	; 8
	.db #0xff	; 255
	.db #0x08	; 8
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x32	; 50	'2'
	.db #0x03	; 3
	.db #0x4c	; 76	'L'
	.db #0x07	; 7
	.db #0xac	; 172
	.db #0x07	; 7
	.db #0xfc	; 252
	.db #0xff	; 255
	.db #0x04	; 4
	.db #0xff	; 255
	.db #0x08	; 8
	.db #0xff	; 255
	.db #0x08	; 8
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x08	; 8
	.db #0xf8	; 248
	.db #0x10	; 16
	.db #0xf0	; 240
	.db #0x10	; 16
	.db #0xf0	; 240
	.db #0x20	; 32
	.db #0xe0	; 224
	.db #0x40	; 64
	.db #0xc0	; 192
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x24	; 36
	.db #0x00	; 0
	.db #0x54	; 84	'T'
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0x10	; 16
	.db #0xf0	; 240
	.db #0x08	; 8
	.db #0xf8	; 248
	.db #0x0c	; 12
	.db #0x0f	; 15
	.db #0x10	; 16
	.db #0x1f	; 31
	.db #0x60	; 96
	.db #0x7f	; 127
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0x40	; 64
	.db #0x7f	; 127
	.db #0x40	; 64
	.db #0x7f	; 127
	.db #0x20	; 32
	.db #0x3f	; 63
	.db #0x10	; 16
	.db #0x1f	; 31
	.db #0x28	; 40
	.db #0xe0	; 224
	.db #0x34	; 52	'4'
	.db #0xe0	; 224
	.db #0x7e	; 126
	.db #0xc0	; 192
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x40	; 64
	.db #0xc0	; 192
	.db #0x40	; 64
	.db #0xc0	; 192
	.db #0x40	; 64
	.db #0xc0	; 192
	.db #0x04	; 4
	.db #0x07	; 7
	.db #0x04	; 4
	.db #0x07	; 7
	.db #0x0c	; 12
	.db #0x0f	; 15
	.db #0x08	; 8
	.db #0x0f	; 15
	.db #0x08	; 8
	.db #0x0f	; 15
	.db #0x08	; 8
	.db #0x0f	; 15
	.db #0x08	; 8
	.db #0x0f	; 15
	.db #0x18	; 24
	.db #0x1f	; 31
	.db #0x28	; 40
	.db #0xe0	; 224
	.db #0x34	; 52	'4'
	.db #0xe0	; 224
	.db #0x3e	; 62
	.db #0xf0	; 240
	.db #0x10	; 16
	.db #0xf0	; 240
	.db #0x10	; 16
	.db #0xf0	; 240
	.db #0x10	; 16
	.db #0xf0	; 240
	.db #0x10	; 16
	.db #0xf0	; 240
	.db #0x18	; 24
	.db #0xf8	; 248
	.db #0x04	; 4
	.db #0x07	; 7
	.db #0x04	; 4
	.db #0x07	; 7
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x34	; 52	'4'
	.db #0xf0	; 240
	.db #0x0a	; 10
	.db #0xf8	; 248
	.db #0x06	; 6
	.db #0xfe	; 254
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0x02	; 2
	.db #0xfe	; 254
	.db #0x02	; 2
	.db #0xfe	; 254
	.db #0x04	; 4
	.db #0xfc	; 252
	.db #0x08	; 8
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
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x0d	; 13
	.db #0x0f	; 15
	.db #0x12	; 18
	.db #0x1e	; 30
	.db #0x64	; 100	'd'
	.db #0x7c	; 124
	.db #0x88	; 136
	.db #0xf8	; 248
	.db #0x10	; 16
	.db #0xf0	; 240
	.db #0x7d	; 125
	.db #0x60	; 96
	.db #0x9b	; 155
	.db #0x90	; 144
	.db #0x0f	; 15
	.db #0x08	; 8
	.db #0x07	; 7
	.db #0x04	; 4
	.db #0x07	; 7
	.db #0x06	; 6
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x04	; 4
	.db #0x07	; 7
	.db #0x04	; 4
	.db #0x07	; 7
	.db #0xbe	; 190
	.db #0x06	; 6
	.db #0xd9	; 217
	.db #0x09	; 9
	.db #0xf0	; 240
	.db #0x10	; 16
	.db #0xe0	; 224
	.db #0x20	; 32
	.db #0xe0	; 224
	.db #0x60	; 96
	.db #0xa0	; 160
	.db #0xe0	; 224
	.db #0x20	; 32
	.db #0xe0	; 224
	.db #0x20	; 32
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xb0	; 176
	.db #0xf0	; 240
	.db #0x48	; 72	'H'
	.db #0x78	; 120	'x'
	.db #0x26	; 38
	.db #0x3e	; 62
	.db #0x11	; 17
	.db #0x1f	; 31
	.db #0x08	; 8
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
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x40	; 64
	.db #0xc0	; 192
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x07	; 7
	.db #0x04	; 4
	.db #0x1b	; 27
	.db #0x18	; 24
	.db #0x3d	; 61
	.db #0x20	; 32
	.db #0x7e	; 126
	.db #0x40	; 64
	.db #0xfe	; 254
	.db #0x80	; 128
	.db #0x7e	; 126
	.db #0x40	; 64
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xc0	; 192
	.db #0x40	; 64
	.db #0xe0	; 224
	.db #0x20	; 32
	.db #0xd8	; 216
	.db #0x18	; 24
	.db #0xbc	; 188
	.db #0x04	; 4
	.db #0x7e	; 126
	.db #0x02	; 2
	.db #0x7f	; 127
	.db #0x01	; 1
	.db #0x7e	; 126
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x0c	; 12
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0x48	; 72	'H'
	.db #0x00	; 0
	.db #0x44	; 68	'D'
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x90	; 144
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x42	; 66	'B'
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0xb0	; 176
	.db #0x00	; 0
	.db #0x8c	; 140
	.db #0x00	; 0
	.db #0x24	; 36
	.db #0x00	; 0
	.db #0x12	; 18
	.db #0x00	; 0
	.db #0xff	; 255
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
	.db #0x06	; 6
	.db #0x00	; 0
	.db #0x08	; 8
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x84	; 132
	.db #0x00	; 0
	.db #0x22	; 34
	.db #0x00	; 0
	.db #0x92	; 146
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x24	; 36
	.db #0x00	; 0
	.db #0x54	; 84	'T'
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
	.db #0x08	; 8
	.db #0x00	; 0
	.db #0x34	; 52	'4'
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
	.db #0x00	; 0
	.db #0x00	; 0
_medaltiles:
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x21	; 33
	.db #0x3f	; 63
	.db #0x10	; 16
	.db #0x1f	; 31
	.db #0x10	; 16
	.db #0x1f	; 31
	.db #0x08	; 8
	.db #0x0f	; 15
	.db #0x08	; 8
	.db #0x0f	; 15
	.db #0x04	; 4
	.db #0x07	; 7
	.db #0x04	; 4
	.db #0x07	; 7
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x06	; 6
	.db #0x04	; 4
	.db #0x05	; 5
	.db #0x04	; 4
	.db #0x06	; 6
	.db #0x04	; 4
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0x04	; 4
	.db #0xf8	; 248
	.db #0x88	; 136
	.db #0xf8	; 248
	.db #0x88	; 136
	.db #0x70	; 112	'p'
	.db #0xd0	; 208
	.db #0x70	; 112	'p'
	.db #0xd0	; 208
	.db #0x20	; 32
	.db #0xe0	; 224
	.db #0x20	; 32
	.db #0xe0	; 224
	.db #0x40	; 64
	.db #0xc0	; 192
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0xa0	; 160
	.db #0x20	; 32
	.db #0x60	; 96
	.db #0x20	; 32
	.db #0xa0	; 160
	.db #0x20	; 32
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x06	; 6
	.db #0x04	; 4
	.db #0x0d	; 13
	.db #0x08	; 8
	.db #0x06	; 6
	.db #0x04	; 4
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x40	; 64
	.db #0xc0	; 192
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0xa0	; 160
	.db #0x20	; 32
	.db #0x50	; 80	'P'
	.db #0x10	; 16
	.db #0xa0	; 160
	.db #0x20	; 32
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x0b	; 11
	.db #0x0b	; 11
	.db #0x14	; 20
	.db #0x15	; 21
	.db #0x0a	; 10
	.db #0x08	; 8
	.db #0x18	; 24
	.db #0x1c	; 28
	.db #0x0a	; 10
	.db #0x08	; 8
	.db #0x09	; 9
	.db #0x0c	; 12
	.db #0x14	; 20
	.db #0x16	; 22
	.db #0x0b	; 11
	.db #0x0b	; 11
	.db #0xd0	; 208
	.db #0xd0	; 208
	.db #0x28	; 40
	.db #0x68	; 104	'h'
	.db #0x90	; 144
	.db #0x30	; 48	'0'
	.db #0x58	; 88	'X'
	.db #0x18	; 24
	.db #0x10	; 16
	.db #0x30	; 48	'0'
	.db #0x50	; 80	'P'
	.db #0x10	; 16
	.db #0x28	; 40
	.db #0xa8	; 168
	.db #0xd0	; 208
	.db #0xd0	; 208
_titlelogomap:
	.db #0x00	; 0
	.db #0x23	; 35
	.db #0x24	; 36
	.db #0x25	; 37
	.db #0x31	; 49	'1'
	.db #0x32	; 50	'2'
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x3d	; 61
	.db #0x3e	; 62
	.db #0x47	; 71	'G'
	.db #0x48	; 72	'H'
	.db #0x49	; 73	'I'
	.db #0x53	; 83	'S'
	.db #0x54	; 84	'T'
	.db #0x55	; 85	'U'
	.db #0x00	; 0
	.db #0x26	; 38
	.db #0x27	; 39
	.db #0x28	; 40
	.db #0x33	; 51	'3'
	.db #0x34	; 52	'4'
	.db #0x35	; 53	'5'
	.db #0x3f	; 63
	.db #0x40	; 64
	.db #0x41	; 65	'A'
	.db #0x4a	; 74	'J'
	.db #0x4b	; 75	'K'
	.db #0x4c	; 76	'L'
	.db #0x56	; 86	'V'
	.db #0x57	; 87	'W'
	.db #0x58	; 88	'X'
	.db #0x29	; 41
	.db #0x2a	; 42
	.db #0x2b	; 43
	.db #0x2c	; 44
	.db #0x36	; 54	'6'
	.db #0x37	; 55	'7'
	.db #0x38	; 56	'8'
	.db #0x42	; 66	'B'
	.db #0x43	; 67	'C'
	.db #0x44	; 68	'D'
	.db #0x4d	; 77	'M'
	.db #0x4e	; 78	'N'
	.db #0x4f	; 79	'O'
	.db #0x59	; 89	'Y'
	.db #0x5a	; 90	'Z'
	.db #0x5b	; 91
	.db #0x2d	; 45
	.db #0x2e	; 46
	.db #0x2f	; 47
	.db #0x30	; 48	'0'
	.db #0x39	; 57	'9'
	.db #0x3a	; 58
	.db #0x3b	; 59
	.db #0x45	; 69	'E'
	.db #0x00	; 0
	.db #0x46	; 70	'F'
	.db #0x50	; 80	'P'
	.db #0x51	; 81	'Q'
	.db #0x52	; 82	'R'
	.db #0x5c	; 92
	.db #0x5d	; 93
	.db #0x5e	; 94
	.db #0x5f	; 95
	.db #0x60	; 96
	.db #0x63	; 99	'c'
	.db #0x64	; 100	'd'
	.db #0x63	; 99	'c'
	.db #0x64	; 100	'd'
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
	.db #0x61	; 97	'a'
	.db #0x62	; 98	'b'
	.db #0x65	; 101	'e'
	.db #0x66	; 102	'f'
	.db #0x67	; 103	'g'
	.db #0x68	; 104	'h'
	.db #0x65	; 101	'e'
	.db #0x66	; 102	'f'
	.db #0x6b	; 107	'k'
	.db #0x6c	; 108	'l'
	.db #0x61	; 97	'a'
	.db #0x62	; 98	'b'
	.db #0x65	; 101	'e'
	.db #0x66	; 102	'f'
	.db #0x6f	; 111	'o'
	.db #0x70	; 112	'p'
_passwscreenmap:
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
	.db #0x2c	; 44
	.db #0x2b	; 43
	.db #0x2b	; 43
	.db #0x2b	; 43
	.db #0x2b	; 43
	.db #0x2b	; 43
	.db #0x2b	; 43
	.db #0x2b	; 43
	.db #0x2d	; 45
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
	.db #0x30	; 48	'0'
	.db #0x33	; 51	'3'
	.db #0x00	; 0
	.db #0x33	; 51	'3'
	.db #0x00	; 0
	.db #0x33	; 51	'3'
	.db #0x00	; 0
	.db #0x33	; 51	'3'
	.db #0x31	; 49	'1'
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
	.db #0x2e	; 46
	.db #0x2a	; 42
	.db #0x2a	; 42
	.db #0x2a	; 42
	.db #0x2a	; 42
	.db #0x2a	; 42
	.db #0x2a	; 42
	.db #0x2a	; 42
	.db #0x2f	; 47
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
	.db #0x2c	; 44
	.db #0x2b	; 43
	.db #0x2b	; 43
	.db #0x2b	; 43
	.db #0x2b	; 43
	.db #0x2b	; 43
	.db #0x2b	; 43
	.db #0x2b	; 43
	.db #0x2b	; 43
	.db #0x2b	; 43
	.db #0x2b	; 43
	.db #0x2b	; 43
	.db #0x2b	; 43
	.db #0x2b	; 43
	.db #0x2b	; 43
	.db #0x2b	; 43
	.db #0x2b	; 43
	.db #0x2b	; 43
	.db #0x2d	; 45
	.db #0x00	; 0
	.db #0x30	; 48	'0'
	.db #0x0b	; 11
	.db #0x00	; 0
	.db #0x0c	; 12
	.db #0x00	; 0
	.db #0x0d	; 13
	.db #0x00	; 0
	.db #0x0e	; 14
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x11	; 17
	.db #0x00	; 0
	.db #0x12	; 18
	.db #0x00	; 0
	.db #0x13	; 19
	.db #0x31	; 49	'1'
	.db #0x00	; 0
	.db #0x30	; 48	'0'
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
	.db #0x31	; 49	'1'
	.db #0x00	; 0
	.db #0x30	; 48	'0'
	.db #0x14	; 20
	.db #0x00	; 0
	.db #0x15	; 21
	.db #0x00	; 0
	.db #0x16	; 22
	.db #0x00	; 0
	.db #0x17	; 23
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x19	; 25
	.db #0x00	; 0
	.db #0x1a	; 26
	.db #0x00	; 0
	.db #0x1b	; 27
	.db #0x00	; 0
	.db #0x1c	; 28
	.db #0x31	; 49	'1'
	.db #0x00	; 0
	.db #0x30	; 48	'0'
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
	.db #0x31	; 49	'1'
	.db #0x00	; 0
	.db #0x30	; 48	'0'
	.db #0x1d	; 29
	.db #0x00	; 0
	.db #0x1e	; 30
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0x21	; 33
	.db #0x00	; 0
	.db #0x22	; 34
	.db #0x00	; 0
	.db #0x23	; 35
	.db #0x00	; 0
	.db #0x24	; 36
	.db #0x00	; 0
	.db #0x32	; 50	'2'
	.db #0x31	; 49	'1'
	.db #0x00	; 0
	.db #0x30	; 48	'0'
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
	.db #0x31	; 49	'1'
	.db #0x00	; 0
	.db #0x30	; 48	'0'
	.db #0x00	; 0
	.db #0x1c	; 28
	.db #0x0f	; 15
	.db #0x1d	; 29
	.db #0x0f	; 15
	.db #0x1e	; 30
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0d	; 13
	.db #0x19	; 25
	.db #0x18	; 24
	.db #0x10	; 16
	.db #0x13	; 19
	.db #0x1c	; 28
	.db #0x17	; 23
	.db #0x00	; 0
	.db #0x31	; 49	'1'
	.db #0x00	; 0
	.db #0x2e	; 46
	.db #0x2a	; 42
	.db #0x2a	; 42
	.db #0x2a	; 42
	.db #0x2a	; 42
	.db #0x2a	; 42
	.db #0x2a	; 42
	.db #0x2a	; 42
	.db #0x2a	; 42
	.db #0x2a	; 42
	.db #0x2a	; 42
	.db #0x2a	; 42
	.db #0x2a	; 42
	.db #0x2a	; 42
	.db #0x2a	; 42
	.db #0x2a	; 42
	.db #0x2a	; 42
	.db #0x2a	; 42
	.db #0x2f	; 47
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
_overworldmap:
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x68	; 104	'h'
	.db #0x69	; 105	'i'
	.db #0x6a	; 106	'j'
	.db #0x6b	; 107	'k'
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x62	; 98	'b'
	.db #0x63	; 99	'c'
	.db #0x64	; 100	'd'
	.db #0x65	; 101	'e'
	.db #0x66	; 102	'f'
	.db #0x67	; 103	'g'
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x5c	; 92
	.db #0x5d	; 93
	.db #0x5e	; 94
	.db #0x5f	; 95
	.db #0x60	; 96
	.db #0x61	; 97	'a'
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x57	; 87	'W'
	.db #0x58	; 88	'X'
	.db #0x59	; 89	'Y'
	.db #0x5a	; 90	'Z'
	.db #0x5b	; 91
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x50	; 80	'P'
	.db #0x51	; 81	'Q'
	.db #0x52	; 82	'R'
	.db #0x53	; 83	'S'
	.db #0x54	; 84	'T'
	.db #0x55	; 85	'U'
	.db #0x56	; 86	'V'
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x48	; 72	'H'
	.db #0x49	; 73	'I'
	.db #0x4a	; 74	'J'
	.db #0x4b	; 75	'K'
	.db #0x4c	; 76	'L'
	.db #0x4d	; 77	'M'
	.db #0x4e	; 78	'N'
	.db #0x4f	; 79	'O'
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x3f	; 63
	.db #0x40	; 64
	.db #0x41	; 65	'A'
	.db #0x42	; 66	'B'
	.db #0x43	; 67	'C'
	.db #0x44	; 68	'D'
	.db #0x45	; 69	'E'
	.db #0x46	; 70	'F'
	.db #0x47	; 71	'G'
	.db #0x8e	; 142
	.db #0x86	; 134
	.db #0x87	; 135
	.db #0x88	; 136
	.db #0x89	; 137
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x3d	; 61
	.db #0x3e	; 62
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x6c	; 108	'l'
	.db #0x6d	; 109	'm'
	.db #0x81	; 129
	.db #0x82	; 130
	.db #0x83	; 131
	.db #0x84	; 132
	.db #0x85	; 133
	.db #0x8c	; 140
	.db #0x8d	; 141
	.db #0x39	; 57	'9'
	.db #0x3a	; 58
	.db #0x3b	; 59
	.db #0x3c	; 60
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x7b	; 123
	.db #0x7c	; 124
	.db #0x7d	; 125
	.db #0x7e	; 126
	.db #0x7f	; 127
	.db #0x80	; 128
	.db #0x8a	; 138
	.db #0x8b	; 139
	.db #0x33	; 51	'3'
	.db #0x34	; 52	'4'
	.db #0x35	; 53	'5'
	.db #0x36	; 54	'6'
	.db #0x37	; 55	'7'
	.db #0x38	; 56	'8'
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x73	; 115	's'
	.db #0x74	; 116	't'
	.db #0x75	; 117	'u'
	.db #0x76	; 118	'v'
	.db #0x77	; 119	'w'
	.db #0x78	; 120	'x'
	.db #0x79	; 121	'y'
	.db #0x7a	; 122	'z'
	.db #0x8e	; 142
	.db #0x2d	; 45
	.db #0x2e	; 46
	.db #0x2f	; 47
	.db #0x30	; 48	'0'
	.db #0x31	; 49	'1'
	.db #0x32	; 50	'2'
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x8e	; 142
	.db #0x6e	; 110	'n'
	.db #0x6f	; 111	'o'
	.db #0x70	; 112	'p'
	.db #0x6f	; 111	'o'
	.db #0x71	; 113	'q'
	.db #0x6f	; 111	'o'
	.db #0x6f	; 111	'o'
	.db #0x6f	; 111	'o'
	.db #0x72	; 114	'r'
_airbasemap:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x98	; 152
	.db #0x99	; 153
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
	.db #0x92	; 146
	.db #0x93	; 147
	.db #0x94	; 148
	.db #0x95	; 149
	.db #0x96	; 150
	.db #0x97	; 151
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xa0	; 160
	.db #0x00	; 0
	.db #0xa0	; 160
	.db #0x00	; 0
	.db #0xa0	; 160
	.db #0x00	; 0
	.db #0xa0	; 160
	.db #0x8c	; 140
	.db #0x8d	; 141
	.db #0x8e	; 142
	.db #0x8f	; 143
	.db #0x90	; 144
	.db #0x91	; 145
	.db #0x00	; 0
	.db #0xa0	; 160
	.db #0x00	; 0
	.db #0xa0	; 160
	.db #0x00	; 0
	.db #0xa0	; 160
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x9f	; 159
	.db #0x00	; 0
	.db #0x9f	; 159
	.db #0x00	; 0
	.db #0x9f	; 159
	.db #0x84	; 132
	.db #0x85	; 133
	.db #0x86	; 134
	.db #0x87	; 135
	.db #0x88	; 136
	.db #0x89	; 137
	.db #0x8a	; 138
	.db #0x8b	; 139
	.db #0x00	; 0
	.db #0x9f	; 159
	.db #0x00	; 0
	.db #0x9f	; 159
	.db #0x00	; 0
	.db #0x9f	; 159
	.db #0x9a	; 154
	.db #0x9b	; 155
	.db #0x9c	; 156
	.db #0x9d	; 157
	.db #0x9e	; 158
	.db #0x7f	; 127
	.db #0x80	; 128
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0x82	; 130
	.db #0x83	; 131
	.db #0x9a	; 154
	.db #0x9b	; 155
	.db #0x9c	; 156
	.db #0x9d	; 157
	.db #0x9e	; 158
	.db #0x00	; 0
	.db #0x6f	; 111	'o'
	.db #0x70	; 112	'p'
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
	.db #0x7d	; 125
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0x5b	; 91
	.db #0x5c	; 92
	.db #0x5d	; 93
	.db #0x5e	; 94
	.db #0x5f	; 95
	.db #0x60	; 96
	.db #0x61	; 97	'a'
	.db #0x62	; 98	'b'
	.db #0x63	; 99	'c'
	.db #0x64	; 100	'd'
	.db #0x65	; 101	'e'
	.db #0x66	; 102	'f'
	.db #0x67	; 103	'g'
	.db #0x68	; 104	'h'
	.db #0x69	; 105	'i'
	.db #0x6a	; 106	'j'
	.db #0x6b	; 107	'k'
	.db #0x6c	; 108	'l'
	.db #0x6d	; 109	'm'
	.db #0x6e	; 110	'n'
	.db #0x47	; 71	'G'
	.db #0x48	; 72	'H'
	.db #0x49	; 73	'I'
	.db #0x4a	; 74	'J'
	.db #0x4b	; 75	'K'
	.db #0x4c	; 76	'L'
	.db #0x4d	; 77	'M'
	.db #0x4e	; 78	'N'
	.db #0x4f	; 79	'O'
	.db #0x50	; 80	'P'
	.db #0x51	; 81	'Q'
	.db #0x52	; 82	'R'
	.db #0x53	; 83	'S'
	.db #0x54	; 84	'T'
	.db #0x55	; 85	'U'
	.db #0x56	; 86	'V'
	.db #0x57	; 87	'W'
	.db #0x58	; 88	'X'
	.db #0x59	; 89	'Y'
	.db #0x5a	; 90	'Z'
	.db #0x33	; 51	'3'
	.db #0x34	; 52	'4'
	.db #0x35	; 53	'5'
	.db #0x36	; 54	'6'
	.db #0x37	; 55	'7'
	.db #0x38	; 56	'8'
	.db #0x39	; 57	'9'
	.db #0x3a	; 58
	.db #0x3b	; 59
	.db #0x3c	; 60
	.db #0x3d	; 61
	.db #0x3e	; 62
	.db #0x3f	; 63
	.db #0x40	; 64
	.db #0x41	; 65	'A'
	.db #0x42	; 66	'B'
	.db #0x43	; 67	'C'
	.db #0x44	; 68	'D'
	.db #0x45	; 69	'E'
	.db #0x46	; 70	'F'
	.db #0x30	; 48	'0'
	.db #0x31	; 49	'1'
	.db #0x32	; 50	'2'
	.db #0x30	; 48	'0'
	.db #0x31	; 49	'1'
	.db #0x32	; 50	'2'
	.db #0x30	; 48	'0'
	.db #0x31	; 49	'1'
	.db #0x32	; 50	'2'
	.db #0x30	; 48	'0'
	.db #0x31	; 49	'1'
	.db #0x32	; 50	'2'
	.db #0x30	; 48	'0'
	.db #0x31	; 49	'1'
	.db #0x32	; 50	'2'
	.db #0x30	; 48	'0'
	.db #0x31	; 49	'1'
	.db #0x32	; 50	'2'
	.db #0x30	; 48	'0'
	.db #0x31	; 49	'1'
	.db #0x2d	; 45
	.db #0x2e	; 46
	.db #0x2f	; 47
	.db #0x2d	; 45
	.db #0x2e	; 46
	.db #0x2f	; 47
	.db #0x2d	; 45
	.db #0x2e	; 46
	.db #0x2f	; 47
	.db #0x2d	; 45
	.db #0x2e	; 46
	.db #0x2f	; 47
	.db #0x2d	; 45
	.db #0x2e	; 46
	.db #0x2f	; 47
	.db #0x2d	; 45
	.db #0x2e	; 46
	.db #0x2f	; 47
	.db #0x2d	; 45
	.db #0x2e	; 46
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
	.db #0x0d	; 13
	.db #0x0b	; 11
	.db #0x1a	; 26
	.db #0x1e	; 30
	.db #0x13	; 19
	.db #0x20	; 32
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x0d	; 13
	.db #0x13	; 19
	.db #0x1e	; 30
	.db #0x23	; 35
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db #0x17	; 23
	.db #0x19	; 25
	.db #0x1f	; 31
	.db #0x18	; 24
	.db #0x1e	; 30
	.db #0x0b	; 11
	.db #0x13	; 19
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x1a	; 26
	.db #0x0b	; 11
	.db #0x1d	; 29
	.db #0x1d	; 29
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db #0x1d	; 29
	.db #0x15	; 21
	.db #0x23	; 35
	.db #0x00	; 0
	.db #0x1e	; 30
	.db #0x1f	; 31
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x0f	; 15
	.db #0x16	; 22
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db #0x10	; 16
	.db #0x19	; 25
	.db #0x1c	; 28
	.db #0x1e	; 30
	.db #0x00	; 0
	.db #0x1d	; 29
	.db #0x1e	; 30
	.db #0x1c	; 28
	.db #0x0b	; 11
	.db #0x1e	; 30
	.db #0x19	; 25
	.db #0x1d	; 29
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db #0x1f	; 31
	.db #0x18	; 24
	.db #0x0e	; 14
	.db #0x0f	; 15
	.db #0x1c	; 28
	.db #0x11	; 17
	.db #0x1c	; 28
	.db #0x19	; 25
	.db #0x1f	; 31
	.db #0x18	; 24
	.db #0x0e	; 14
	.db #0x00	; 0
	.db #0x12	; 18
	.db #0x0b	; 11
	.db #0x16	; 22
	.db #0x16	; 22
	.db #0x1d	; 29
	.db 0x00
	.db #0x0f	; 15
	.db #0x18	; 24
	.db #0x0f	; 15
	.db #0x1c	; 28
	.db #0x11	; 17
	.db #0x23	; 35
	.db #0x00	; 0
	.db #0x0d	; 13
	.db #0x19	; 25
	.db #0x1c	; 28
	.db #0x0f	; 15
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
_stnamelengths:
	.db #0x0e	; 14
	.db #0x0c	; 12
	.db #0x0d	; 13
	.db #0x0a	; 10
	.db #0x0c	; 12
	.db #0x11	; 17
	.db #0x0b	; 11
_gameoveroptsy:
	.db #0x60	; 96
	.db #0x70	; 112	'p'
_mainoptsy:
	.db #0x58	; 88	'X'
	.db #0x68	; 104	'h'
	.db #0x78	; 120	'x'
_passconfoptsx:
	.db #0x13	; 19
	.db #0x53	; 83	'S'
_extrasoptsy:
	.db #0x30	; 48	'0'
	.db #0x40	; 64
	.db #0x70	; 112	'p'
	.db #0x80	; 128
	.db #0x90	; 144
_passconfy:
	.db #0x80	; 128
_blinkanimdur:
	.db #0x15	; 21
_wrongpassind:
	.db #0x63	; 99	'c'
_introscrdurr:
	.db #0xc8	; 200
_passwords:
	.db #0x0b	; 11
	.db #0x0c	; 12
	.db #0x0d	; 13
	.db #0x0e	; 14
	.db #0x1e	; 30
	.db #0x0b	; 11
	.db #0x1b	; 27
	.db #0x17	; 23
	.db #0x21	; 33
	.db #0x10	; 16
	.db #0x18	; 24
	.db #0x0d	; 13
	.db #0x0f	; 15
	.db #0x19	; 25
	.db #0x15	; 21
	.db #0x1c	; 28
	.db #0x1c	; 28
	.db #0x20	; 32
	.db #0x0d	; 13
	.db #0x24	; 36
	.db #0x20	; 32
	.db #0x14	; 20
	.db #0x0e	; 14
	.db #0x23	; 35
	.db #0x12	; 18
	.db #0x21	; 33
	.db #0x15	; 21
	.db #0x1b	; 27
	.db #0x1f	; 31
	.db #0x1c	; 28
	.db #0x1e	; 30
	.db #0x12	; 18
_mapcrsrcoords:
	.db #0x17	; 23
	.db #0x73	; 115	's'
	.db #0x4c	; 76	'L'
	.db #0x4c	; 76	'L'
	.db #0x7f	; 127
	.db #0x6a	; 106	'j'
	.db #0x11	; 17
	.db #0x56	; 86	'V'
	.db #0x36	; 54	'6'
	.db #0x54	; 84	'T'
	.db #0x47	; 71	'G'
	.db #0x5d	; 93
	.db #0x5d	; 93
	.db #0x5f	; 95
_gamestsign:
	.db #0x1d	; 29
	.db #0x1e	; 30
	.db #0x0b	; 11
	.db #0x1c	; 28
	.db #0x1e	; 30
	.db #0x00	; 0
	.db #0x11	; 17
	.db #0x0b	; 11
	.db #0x17	; 23
	.db #0x0f	; 15
_passwsign:
	.db #0x1a	; 26
	.db #0x0b	; 11
	.db #0x1d	; 29
	.db #0x1d	; 29
	.db #0x21	; 33
	.db #0x19	; 25
	.db #0x1c	; 28
	.db #0x0e	; 14
_creatorsign:
	.db #0x03	; 3
	.db #0x01	; 1
	.db #0x03	; 3
	.db #0x05	; 5
	.db #0x00	; 0
	.db #0x15	; 21
	.db #0x18	; 24
	.db #0x1d	; 29
	.db #0x00	; 0
	.db #0x0e	; 14
	.db #0x19	; 25
	.db #0x0c	; 12
	.db #0x1c	; 28
	.db #0x0f	; 15
	.db #0x20	; 32
_stagesign:
	.db #0x1d	; 29
	.db #0x1e	; 30
	.db #0x0b	; 11
	.db #0x11	; 17
	.db #0x0f	; 15
_gmoversign:
	.db #0x11	; 17
	.db #0x0b	; 11
	.db #0x17	; 23
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x19	; 25
	.db #0x20	; 32
	.db #0x0f	; 15
	.db #0x1c	; 28
_contsign:
	.db #0x0d	; 13
	.db #0x19	; 25
	.db #0x18	; 24
	.db #0x1e	; 30
	.db #0x13	; 19
	.db #0x18	; 24
	.db #0x1f	; 31
	.db #0x0f	; 15
_quitsign:
	.db #0x1b	; 27
	.db #0x1f	; 31
	.db #0x13	; 19
	.db #0x1e	; 30
_gopasssign:
	.db #0x1a	; 26
	.db #0x0b	; 11
	.db #0x1d	; 29
	.db #0x1d	; 29
	.db #0x21	; 33
	.db #0x19	; 25
	.db #0x1c	; 28
	.db #0x0e	; 14
	.db #0x25	; 37
_extrassign:
	.db #0x0f	; 15
	.db #0x22	; 34
	.db #0x1e	; 30
	.db #0x1c	; 28
	.db #0x0b	; 11
	.db #0x1d	; 29
_extrmenusign:
	.db #0x0f	; 15
	.db #0x22	; 34
	.db #0x1e	; 30
	.db #0x1c	; 28
	.db #0x0b	; 11
	.db #0x1d	; 29
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x17	; 23
	.db #0x0f	; 15
	.db #0x18	; 24
	.db #0x1f	; 31
_plasmasign:
	.db #0x1a	; 26
	.db #0x16	; 22
	.db #0x0b	; 11
	.db #0x1d	; 29
	.db #0x17	; 23
	.db #0x0b	; 11
	.db #0x00	; 0
	.db #0x1c	; 28
	.db #0x1f	; 31
	.db #0x18	; 24
_fightbosssign:
	.db #0x10	; 16
	.db #0x13	; 19
	.db #0x11	; 17
	.db #0x12	; 18
	.db #0x1e	; 30
	.db #0x00	; 0
	.db #0x0c	; 12
	.db #0x19	; 25
	.db #0x1d	; 29
	.db #0x1d	; 29
_bossrushsign:
	.db #0x0c	; 12
	.db #0x19	; 25
	.db #0x1d	; 29
	.db #0x1d	; 29
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1c	; 28
	.db #0x1f	; 31
	.db #0x1d	; 29
	.db #0x12	; 18
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x17	; 23
	.db #0x19	; 25
	.db #0x0e	; 14
	.db #0x0f	; 15
_regularsign:
	.db #0x1c	; 28
	.db #0x0f	; 15
	.db #0x11	; 17
	.db #0x1f	; 31
	.db #0x16	; 22
	.db #0x0b	; 11
	.db #0x1c	; 28
_glasscannonsign:
	.db #0x11	; 17
	.db #0x16	; 22
	.db #0x0b	; 11
	.db #0x1d	; 29
	.db #0x1d	; 29
	.db #0x00	; 0
	.db #0x0d	; 13
	.db #0x0b	; 11
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x19	; 25
	.db #0x18	; 24
_glassfeathersign:
	.db #0x11	; 17
	.db #0x16	; 22
	.db #0x0b	; 11
	.db #0x1d	; 29
	.db #0x1d	; 29
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x0f	; 15
	.db #0x0b	; 11
	.db #0x1e	; 30
	.db #0x12	; 18
	.db #0x0f	; 15
	.db #0x1c	; 28
_rushrestitlesign:
	.db #0x0c	; 12
	.db #0x19	; 25
	.db #0x1d	; 29
	.db #0x1d	; 29
	.db #0x00	; 0
	.db #0x1c	; 28
	.db #0x1f	; 31
	.db #0x1d	; 29
	.db #0x12	; 18
_rushresmodesign:
	.db #0x17	; 23
	.db #0x19	; 25
	.db #0x0e	; 14
	.db #0x0f	; 15
_rushresbossesdefsign:
	.db #0x0c	; 12
	.db #0x19	; 25
	.db #0x1d	; 29
	.db #0x1d	; 29
	.db #0x0f	; 15
	.db #0x1d	; 29
	.db #0x00	; 0
	.db #0x0c	; 12
	.db #0x0f	; 15
	.db #0x0b	; 11
	.db #0x1e	; 30
	.db #0x0f	; 15
	.db #0x18	; 24
	.db #0x25	; 37
_allsign:
	.db #0x0b	; 11
	.db #0x16	; 22
	.db #0x16	; 22
_goodjobsign:
	.db #0x11	; 17
	.db #0x19	; 25
	.db #0x19	; 25
	.db #0x0e	; 14
	.db #0x00	; 0
	.db #0x21	; 33
	.db #0x19	; 25
	.db #0x1c	; 28
	.db #0x15	; 21
	.db #0x27	; 39
_greatjobsign:
	.db #0x11	; 17
	.db #0x1c	; 28
	.db #0x0f	; 15
	.db #0x0b	; 11
	.db #0x1e	; 30
	.db #0x00	; 0
	.db #0x21	; 33
	.db #0x19	; 25
	.db #0x1c	; 28
	.db #0x15	; 21
	.db #0x27	; 39
_congratssign:
	.db #0x0d	; 13
	.db #0x19	; 25
	.db #0x18	; 24
	.db #0x11	; 17
	.db #0x1c	; 28
	.db #0x0b	; 11
	.db #0x1e	; 30
	.db #0x1f	; 31
	.db #0x16	; 22
	.db #0x0b	; 11
	.db #0x1e	; 30
	.db #0x13	; 19
	.db #0x19	; 25
	.db #0x18	; 24
	.db #0x1d	; 29
	.db #0x27	; 39
_awardedsign:
	.db #0x23	; 35
	.db #0x19	; 25
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x21	; 33
	.db #0x13	; 19
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x1e	; 30
	.db #0x12	; 18
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x17	; 23
	.db #0x0f	; 15
	.db #0x0e	; 14
	.db #0x0b	; 11
	.db #0x16	; 22
_medaltypessign:
	.db #0x00	; 0
	.db #0x19	; 25
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x0e	; 14
	.db #0x0f	; 15
	.db #0x0e	; 14
	.db #0x13	; 19
	.db #0x0d	; 13
	.db #0x0b	; 11
	.db #0x1e	; 30
	.db #0x13	; 19
	.db #0x19	; 25
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x19	; 25
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x1a	; 26
	.db #0x0f	; 15
	.db #0x1c	; 28
	.db #0x1d	; 29
	.db #0x0f	; 15
	.db #0x20	; 32
	.db #0x0f	; 15
	.db #0x1c	; 28
	.db #0x0b	; 11
	.db #0x18	; 24
	.db #0x0d	; 13
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x19	; 25
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x0b	; 11
	.db #0x16	; 22
	.db #0x19	; 25
	.db #0x1c	; 28
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_pushstartsign:
	.db #0x1a	; 26
	.db #0x1f	; 31
	.db #0x1d	; 29
	.db #0x12	; 18
	.db #0x00	; 0
	.db #0x1d	; 29
	.db #0x1e	; 30
	.db #0x0b	; 11
	.db #0x1c	; 28
	.db #0x1e	; 30
_medalssigns:
	.db #0x35	; 53	'5'
	.db #0x37	; 55	'7'
	.db #0x36	; 54	'6'
	.db #0x38	; 56	'8'
	.db #0x35	; 53	'5'
	.db #0x37	; 55	'7'
	.db #0x39	; 57	'9'
	.db #0x3a	; 58
	.db #0x35	; 53	'5'
	.db #0x37	; 55	'7'
	.db #0x3b	; 59
	.db #0x3c	; 60
_bossrushconfigs:
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x01	; 1
_medaltypeoffsx:
	.db #0x04	; 4
	.db #0x03	; 3
	.db #0x07	; 7
;menus.c:129: void main_menu() BANKED {
;	---------------------------------
; Function main_menu
; ---------------------------------
	b_main_menu	= 1
_main_menu::
;menus.c:130: reset_sprites(0, 3);
	ld	a, #0x03
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_reset_sprites
	add	sp, #2
;menus.c:131: init_common_menu_props();
	ld	e, #b_init_common_menu_props
	ld	hl, #_init_common_menu_props
	call	___sdcc_bcall_ehl
;menus.c:132: set_bkg_data(35, 78, titlelogotiles);
	ld	hl, #_titlelogotiles
	push	hl
	ld	de, #0x4e23
	push	de
	call	_set_bkg_data
	add	sp, #4
;menus.c:133: set_bkg_tiles(2, 1, 16, 6, titlelogomap);
	ld	hl, #_titlelogomap
	push	hl
	ld	de, #0x0610
	push	de
	ld	de, #0x0102
	push	de
	call	_set_bkg_tiles
	add	sp, #6
;menus.c:134: anim_reverse_blackout();
	call	_anim_reverse_blackout
;menus.c:135: set_bkg_tiles(2, 16, 15, 1, creatorsign);
	ld	hl, #_creatorsign
	push	hl
	ld	de, #0x010f
	push	de
	ld	de, #0x1002
	push	de
	call	_set_bkg_tiles
	add	sp, #6
;menus.c:136: play_song(&titletheme);
	ld	hl, #_titletheme
	push	hl
	ld	e, #b_play_song
	ld	hl, #_play_song
	call	___sdcc_bcall_ehl
	add	sp, #2
;menus.c:137: toggle_mute_music(0);
	xor	a, a
	push	af
	inc	sp
	call	_toggle_mute_music
	inc	sp
;menus.c:138: if(extrasflg == 1) {    //  Extras menu has been unlocked
	ld	a, (#_extrasflg)
	dec	a
	jr	NZ, 00102$
;menus.c:139: set_bkg_tiles(6, 9, 10, 1, gamestsign);
	ld	hl, #_gamestsign
	push	hl
	ld	de, #0x010a
	push	de
	ld	de, #0x0906
	push	de
	call	_set_bkg_tiles
	add	sp, #6
;menus.c:140: set_bkg_tiles(6, 11, 8, 1, passwsign);
	ld	hl, #_passwsign
	push	hl
	ld	de, #0x0108
	push	de
	ld	de, #0x0b06
	push	de
	call	_set_bkg_tiles
	add	sp, #6
;menus.c:141: set_bkg_tiles(6, 13, 6, 1, extrassign);
	ld	hl, #_extrassign
	push	hl
	ld	de, #0x0106
	push	de
	ld	de, #0x0d06
	push	de
	call	_set_bkg_tiles
	add	sp, #6
;menus.c:142: move_sprite(0, 44, mainoptsy[0]);
	ld	bc, #_mainoptsy+0
	ld	a, (bc)
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1218: OAM_item_t * itm = &shadow_OAM[nb];
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1219: itm->y=y, itm->x=x;
	ld	hl, #_shadow_OAM
	ld	(hl+), a
	ld	(hl), #0x2c
;menus.c:143: get_menu_pl_input(mainoptsy, 3);
	ld	a, #0x03
	push	af
	inc	sp
	push	bc
	ld	e, #b_get_menu_pl_input
	ld	hl, #_get_menu_pl_input
	call	___sdcc_bcall_ehl
	add	sp, #3
	jr	00103$
00102$:
;menus.c:145: set_bkg_tiles(6, 11, 10, 1, gamestsign);
	ld	hl, #_gamestsign
	push	hl
	ld	de, #0x010a
	push	de
	ld	de, #0x0b06
	push	de
	call	_set_bkg_tiles
	add	sp, #6
;menus.c:146: set_bkg_tiles(6, 13, 8, 1, passwsign);
	ld	hl, #_passwsign
	push	hl
	ld	de, #0x0108
	push	de
	ld	de, #0x0d06
	push	de
	call	_set_bkg_tiles
	add	sp, #6
;menus.c:147: move_sprite(0, 44, mainoptsy[1]);
	ld	bc, #_mainoptsy+1
	ld	a, (bc)
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1218: OAM_item_t * itm = &shadow_OAM[nb];
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1219: itm->y=y, itm->x=x;
	ld	hl, #_shadow_OAM
	ld	(hl+), a
	ld	(hl), #0x2c
;menus.c:148: get_menu_pl_input(mainoptsy + 1, 2);
	ld	a, #0x02
	push	af
	inc	sp
	push	bc
	ld	e, #b_get_menu_pl_input
	ld	hl, #_get_menu_pl_input
	call	___sdcc_bcall_ehl
	add	sp, #3
00103$:
;menus.c:150: remove_VBL(hUGE_dosound);
	ld	hl, #_hUGE_dosound
	push	hl
	call	_remove_VBL
	add	sp, #2
;menus.c:151: reset_sprites(0, 0);
	xor	a, a
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_reset_sprites
	add	sp, #2
;menus.c:152: anim_blackout();
	call	_anim_blackout
;menus.c:154: switch(menuidx) {
	ld	a, (#_menuidx)
	dec	a
	jr	Z, 00104$
	ld	a, (#_menuidx)
	sub	a, #0x02
	jr	Z, 00105$
	ret
;menus.c:155: case 1:
00104$:
;menus.c:156: password_menu();
	ld	e, #b_password_menu
	ld	hl, #_password_menu
;menus.c:157: break;
	jp  ___sdcc_bcall_ehl
;menus.c:158: case 2:
00105$:
;menus.c:159: extras_menu();
	ld	e, #b_extras_menu
	ld	hl, #_extras_menu
;menus.c:161: }
;menus.c:162: }
	jp  ___sdcc_bcall_ehl
;menus.c:165: void get_menu_pl_input(UINT8 * entries, UINT8 numentries) BANKED {
;	---------------------------------
; Function get_menu_pl_input
; ---------------------------------
	b_get_menu_pl_input	= 1
_get_menu_pl_input::
;menus.c:166: menuidx = 0; // First option set by default
	ld	hl, #_menuidx
	ld	(hl), #0x00
;menus.c:167: while(1) {
00110$:
;menus.c:168: if(joypad() & (J_DOWN | J_SELECT)) {
	call	_joypad
	ld	a, e
	and	a, #0x48
	jr	Z, 00107$
;menus.c:169: menuidx = menuidx + 1 == numentries ? 0 : menuidx + 1;
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
;menus.c:170: move_sprite(0, shadow_OAM[0].x, entries[menuidx]);
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
;menus.c:171: se_move_cursor();
	ld	e, #b_se_move_cursor
	ld	hl, #_se_move_cursor
	call	___sdcc_bcall_ehl
;menus.c:172: waitpadup();
	call	_waitpadup
	jr	00108$
00107$:
;menus.c:173: } else if(joypad() & J_UP) {
	call	_joypad
	bit	2, e
	jr	Z, 00104$
;menus.c:174: menuidx = menuidx == 0 ? numentries - 1 : menuidx - 1;
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
;menus.c:175: move_sprite(0, shadow_OAM[0].x, entries[menuidx]);
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
;menus.c:176: se_move_cursor();
	ld	e, #b_se_move_cursor
	ld	hl, #_se_move_cursor
	call	___sdcc_bcall_ehl
;menus.c:177: waitpadup();
	call	_waitpadup
	jr	00108$
00104$:
;menus.c:178: } else if(joypad() & (J_START | J_A)) {
	call	_joypad
	ld	a, e
	and	a, #0x90
	jr	NZ, 00111$
;menus.c:179: break;  // Player has made a choice
00108$:
;menus.c:181: manage_sound_chnls();
	call	_manage_sound_chnls
;menus.c:182: wait_vbl_done();
	call	_wait_vbl_done
	jp	00110$
00111$:
;menus.c:184: toggle_mute_music(1);
	ld	a, #0x01
	push	af
	inc	sp
	call	_toggle_mute_music
	inc	sp
;menus.c:185: se_choose_entry();
	ld	e, #b_se_choose_entry
	ld	hl, #_se_choose_entry
;menus.c:186: }
	jp  ___sdcc_bcall_ehl
;menus.c:189: void stage_intro_screen(UINT8 stnum) BANKED {
;	---------------------------------
; Function stage_intro_screen
; ---------------------------------
	b_stage_intro_screen	= 1
_stage_intro_screen::
	add	sp, #-3
;menus.c:190: init_common_menu_props();
	ld	e, #b_init_common_menu_props
	ld	hl, #_init_common_menu_props
	call	___sdcc_bcall_ehl
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1145: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 0x0002)
	ld	(hl), #0x04
;menus.c:192: set_bkg_data(43, 2, mapframetiles);
	ld	hl, #_mapframetiles
	push	hl
	ld	de, #0x022b
	push	de
	call	_set_bkg_data
	add	sp, #4
;menus.c:193: if(stnum < 3) {
	ldhl	sp,	#9
	ld	a, (hl)
	sub	a, #0x03
	jr	NC, 00102$
;menus.c:194: set_bkg_data(45, 98, overworldmaptiles);
	ld	hl, #_overworldmaptiles
	push	hl
	ld	de, #0x622d
	push	de
	call	_set_bkg_data
	add	sp, #4
;menus.c:195: set_bkg_tiles(0, 3, 20, 11, overworldmap);
	ld	hl, #_overworldmap
	push	hl
	ld	de, #0x0b14
	push	de
	ld	a, #0x03
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_set_bkg_tiles
	add	sp, #6
	jr	00103$
00102$:
;menus.c:197: set_bkg_data(45, 116, airbasemaptiles);
	ld	hl, #_airbasemaptiles
	push	hl
	ld	de, #0x742d
	push	de
	call	_set_bkg_data
	add	sp, #4
;menus.c:198: set_bkg_tiles(0, 3, 20, 11, airbasemap);
	ld	hl, #_airbasemap
	push	hl
	ld	de, #0x0b14
	push	de
	ld	a, #0x03
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_set_bkg_tiles
	add	sp, #6
00103$:
;menus.c:200: set_bkg_tiles(6, 1, 5, 1, stagesign);
	ld	hl, #_stagesign
	push	hl
	ld	de, #0x0105
	push	de
	ld	de, #0x0106
	push	de
	call	_set_bkg_tiles
	add	sp, #6
;menus.c:201: set_bkg_tile_xy(12, 1, stnum + 2);
	ldhl	sp,	#9
	ld	a, (hl)
	add	a, #0x02
	ld	d,a
	ld	e,#0x01
	push	de
	ld	a, #0x0c
	push	af
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
;menus.c:202: set_bkg_tiles((20 - stnamelengths[stnum]) / 2, 15, stnamelengths[stnum], 1, *(stagenames + stnum));
	ldhl	sp,	#9
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
	ld	a, h
	ldhl	sp,	#0
	ld	(hl), c
	inc	hl
	ld	(hl), a
	ld	bc, #_stnamelengths+0
	ldhl	sp,	#9
	ld	l, (hl)
	ld	h, #0x00
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ldhl	sp,	#2
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
	jr	Z, 00118$
	inc	hl
	ld	c, l
	ld	b, h
00118$:
	sra	b
	rr	c
	pop	hl
	push	hl
	push	hl
	ld	a, #0x01
	push	af
	inc	sp
	ldhl	sp,	#5
	ld	d, (hl)
	ld	e,#0x0f
	push	de
	ld	a, c
	push	af
	inc	sp
	call	_set_bkg_tiles
	add	sp, #6
;menus.c:203: fill_bkg_rect(0, 2, 20, 1, 44);
	ld	de, #0x2c01
	push	de
	ld	de, #0x1402
	push	de
	xor	a, a
	push	af
	inc	sp
	call	_fill_bkg_rect
	add	sp, #5
;menus.c:204: fill_bkg_rect(0, 14, 20, 1, 43);
	ld	de, #0x2b01
	push	de
	ld	de, #0x140e
	push	de
	xor	a, a
	push	af
	inc	sp
	call	_fill_bkg_rect
	add	sp, #5
;menus.c:205: move_sprite(0, mapcrsrcoords[stnum][0], mapcrsrcoords[stnum][1]);
	ld	bc, #_mapcrsrcoords+0
	ldhl	sp,	#9
	ld	l, (hl)
	ld	h, #0x00
	add	hl, hl
	add	hl, bc
	ld	c, l
	ld	b, h
	inc	bc
	ld	a, (bc)
	ld	b, a
	ld	c, (hl)
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1218: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #_shadow_OAM
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1219: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;menus.c:206: anim_reverse_blackout();
	call	_anim_reverse_blackout
;menus.c:207: for(i =  0; i != introscrdurr; i++) {
	ld	hl, #_i
	ld	(hl), #0x00
00114$:
	ld	hl, #_introscrdurr
	ld	c, (hl)
	ld	a, (#_i)
	sub	a, c
	jr	Z, 00108$
;menus.c:208: if(i % 16 == 0) {
	ld	a, (#_i)
	and	a, #0x0f
	jr	NZ, 00105$
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1156: return shadow_OAM[nb].tile;
	ld	a, (#(_shadow_OAM + 0x0002) + 0)
;menus.c:209: set_sprite_tile(0, get_sprite_tile(0) == 4 ? 5 : 4);
	sub	a, #0x04
	jr	NZ, 00119$
	ld	bc, #0x0005
	jr	00120$
00119$:
	ld	bc, #0x0004
00120$:
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1145: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 0x0002)
	ld	(hl), c
;menus.c:209: set_sprite_tile(0, get_sprite_tile(0) == 4 ? 5 : 4);
00105$:
;menus.c:211: if(joypad() & J_START) {
	call	_joypad
	ld	a, e
	rlca
	jr	C, 00108$
;menus.c:214: wait_vbl_done();
	call	_wait_vbl_done
;menus.c:207: for(i =  0; i != introscrdurr; i++) {
	ld	hl, #_i
	inc	(hl)
	jr	00114$
00108$:
;menus.c:216: anim_blackout();
	call	_anim_blackout
;menus.c:217: }
	add	sp, #3
	ret
;menus.c:220: void game_over_menu() BANKED {
;	---------------------------------
; Function game_over_menu
; ---------------------------------
	b_game_over_menu	= 1
_game_over_menu::
;menus.c:221: init_common_menu_props();
	ld	e, #b_init_common_menu_props
	ld	hl, #_init_common_menu_props
	call	___sdcc_bcall_ehl
;menus.c:222: if(bossrushflg != 0) {  // Do not display game over screen in boss rush mode or when fighting a single boss
	ld	hl, #_bossrushflg
	ld	a, (hl)
	or	a, a
	jr	Z, 00104$
;menus.c:223: if(bossrushflg == 1) {  // Do not display boss rush results for a single boss fight
	ld	a, (hl)
	dec	a
	jr	NZ, 00102$
;menus.c:224: boss_rush_results_screen();
	ld	e, #b_boss_rush_results_screen
	ld	hl, #_boss_rush_results_screen
	call	___sdcc_bcall_ehl
00102$:
;menus.c:226: menuidx = 1;
	ld	hl, #_menuidx
	ld	(hl), #0x01
;menus.c:227: stageclearflg = bossrushflg = 0;
	ld	hl, #_bossrushflg
	ld	(hl), #0x00
	ld	hl, #_stageclearflg
	ld	(hl), #0x00
;menus.c:228: return;
	ret
00104$:
;menus.c:230: set_bkg_tiles(5, 4, 9, 1, gmoversign);
	ld	hl, #_gmoversign
	push	hl
	ld	de, #0x0109
	push	de
	ld	de, #0x0405
	push	de
	call	_set_bkg_tiles
	add	sp, #6
;menus.c:231: set_bkg_tiles(7, 10, 8, 1, contsign);
	ld	hl, #_contsign
	push	hl
	ld	de, #0x0108
	push	de
	ld	de, #0x0a07
	push	de
	call	_set_bkg_tiles
	add	sp, #6
;menus.c:232: set_bkg_tiles(7, 12, 4, 1, quitsign);
	ld	hl, #_quitsign
	push	hl
	ld	de, #0x0104
	push	de
	ld	de, #0x0c07
	push	de
	call	_set_bkg_tiles
	add	sp, #6
;menus.c:233: set_bkg_tiles(3, 16, 9, 1, gopasssign);
	ld	hl, #_gopasssign
	push	hl
	ld	de, #0x0109
	push	de
	ld	de, #0x1003
	push	de
	call	_set_bkg_tiles
	add	sp, #6
;menus.c:234: set_bkg_tiles(12, 16, 4, 1, passwords[stagenum]);
	ld	bc, #_passwords+0
	ld	hl, #_stagenum
	ld	l, (hl)
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	add	hl, bc
	push	hl
	ld	de, #0x0104
	push	de
	ld	de, #0x100c
	push	de
	call	_set_bkg_tiles
	add	sp, #6
;menus.c:235: move_sprite(0, 52, gameoveroptsy[0]);
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1218: OAM_item_t * itm = &shadow_OAM[nb];
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1219: itm->y=y, itm->x=x;
	ld	a, (#_gameoveroptsy + 0)
	ld	hl, #_shadow_OAM
	ld	(hl+), a
	ld	(hl), #0x34
;menus.c:236: play_song(&gameovertheme);
	ld	hl, #_gameovertheme
	push	hl
	ld	e, #b_play_song
	ld	hl, #_play_song
	call	___sdcc_bcall_ehl
	add	sp, #2
;menus.c:237: anim_reverse_blackout();
	call	_anim_reverse_blackout
;menus.c:238: get_menu_pl_input(gameoveroptsy, 2);
	ld	a, #0x02
	push	af
	inc	sp
	ld	hl, #_gameoveroptsy
	push	hl
	ld	e, #b_get_menu_pl_input
	ld	hl, #_get_menu_pl_input
	call	___sdcc_bcall_ehl
	add	sp, #3
;menus.c:239: remove_VBL(hUGE_dosound);
	ld	hl, #_hUGE_dosound
	push	hl
	call	_remove_VBL
	add	sp, #2
;menus.c:240: reset_sprites(0, 0);
	xor	a, a
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_reset_sprites
	add	sp, #2
;menus.c:241: anim_blackout();
;menus.c:242: }
	jp  _anim_blackout
;menus.c:245: void init_passcursor(Passcursor * cr, UINT8 x, UINT8 y) BANKED {
;	---------------------------------
; Function init_passcursor
; ---------------------------------
	b_init_passcursor	= 1
_init_passcursor::
	dec	sp
;menus.c:246: for(i = 1; i < 6; i++) {
	ld	hl, #_i
	ld	(hl), #0x01
00110$:
;menus.c:247: set_sprite_tile(i, 2);
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
	ld	(hl), #0x02
;menus.c:246: for(i = 1; i < 6; i++) {
	ld	hl, #_i
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x06
	jr	C, 00110$
;menus.c:249: cr->x = x;
	ldhl	sp,#7
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl+)
	ld	b, a
	ld	a, (hl)
	ld	(bc), a
;menus.c:250: cr->y = y;
	ld	e, c
	ld	d, b
	inc	de
	inc	hl
	ld	a, (hl)
	ld	(de), a
;menus.c:251: cr->row = cr->col = 0;
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	inc	bc
	inc	bc
	inc	bc
	xor	a, a
	ld	(bc), a
	xor	a, a
	ld	(de), a
;menus.c:252: move_sprite(1, x, y);
	ld	a, (hl-)
	ld	c, a
	ld	b, (hl)
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1218: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 0x0004)
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1219: itm->y=y, itm->x=x;
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;menus.c:253: move_sprite(2, x + 8, y);
	ld	a, b
	add	a, #0x08
	ldhl	sp,	#0
	ld	(hl), a
	ld	e, (hl)
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1218: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 0x0008)
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1219: itm->y=y, itm->x=x;
	ld	a, c
	ld	(hl+), a
	ld	(hl), e
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1191: shadow_OAM[nb].prop=prop;
	ld	hl, #(_shadow_OAM + 0x000b)
	ld	(hl), #0x20
;menus.c:255: move_sprite(3, x, y + 8);
	ld	a, c
	add	a, #0x08
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1218: OAM_item_t * itm = &shadow_OAM[nb];
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1219: itm->y=y, itm->x=x;
	ld	c, a
	ld	hl, #(_shadow_OAM + 0x000c)
	ld	(hl+), a
	ld	(hl), b
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1191: shadow_OAM[nb].prop=prop;
	ld	hl, #(_shadow_OAM + 0x000f)
	ld	(hl), #0x40
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1218: OAM_item_t * itm = &shadow_OAM[nb];
	ld	de, #(_shadow_OAM + 0x0010)
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1219: itm->y=y, itm->x=x;
	ld	a, c
	ld	(de), a
	inc	de
	ldhl	sp,	#0
	ld	a, (hl)
	ld	(de), a
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1191: shadow_OAM[nb].prop=prop;
	ld	hl, #(_shadow_OAM + 0x0013)
	ld	(hl), #0x60
;menus.c:258: set_sprite_prop(4, 96);
;menus.c:259: }
	inc	sp
	ret
;menus.c:262: void move_passcursor(Passcursor * cr, INT8 dirctx, INT8 dircty) BANKED {
;	---------------------------------
; Function move_passcursor
; ---------------------------------
	b_move_passcursor	= 1
_move_passcursor::
	add	sp, #-9
;menus.c:263: INT8 nextcol = cr->col + dirctx;
	ldhl	sp,#15
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0003
	add	hl, bc
	inc	sp
	inc	sp
	ld	e, l
	ld	d, h
	push	de
	ld	a, (de)
	ldhl	sp,	#17
	add	a, (hl)
	ldhl	sp,	#2
	ld	(hl), a
;menus.c:264: INT8 nextrow = cr->row + dircty;
	ld	hl, #0x0002
	add	hl, bc
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
	ldhl	sp,	#18
	add	a, (hl)
	ldhl	sp,	#5
	ld	(hl), a
;menus.c:265: if(nextcol >= 0 && nextcol < 9 && nextrow >= 0 && nextrow < 3) {
	ldhl	sp,	#2
	bit	7, (hl)
	jp	NZ, 00102$
	ld	a, (hl)
	xor	a, #0x80
	sub	a, #0x89
	jp	NC, 00102$
	ldhl	sp,	#5
	bit	7, (hl)
	jp	NZ, 00102$
	ld	a, (hl)
	xor	a, #0x80
	sub	a, #0x83
	jp	NC, 00102$
;menus.c:266: cr->x += (dirctx * 16);
	ld	a, (bc)
	ld	e, a
	ldhl	sp,	#17
	ld	a, (hl)
	swap	a
	and	a, #0xf0
	add	a, e
	ld	(bc), a
;menus.c:267: cr->y += (dircty * 16);
	ld	l, c
	ld	h, b
	inc	hl
	push	hl
	ld	a, l
	ldhl	sp,	#8
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#7
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	inc	hl
	ld	(hl), a
	ldhl	sp,	#18
	ld	a, (hl)
	swap	a
	and	a, #0xf0
	ldhl	sp,	#8
	ld	e, (hl)
	add	a, e
	dec	hl
	dec	hl
	push	af
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	pop	af
	ld	(hl), a
;menus.c:268: cr->col = nextcol;
	pop	de
	push	de
	ldhl	sp,	#2
	ld	a, (hl)
	ld	(de), a
;menus.c:269: cr->row = nextrow;
	inc	hl
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (hl)
	ld	(de), a
;menus.c:270: move_sprite(1, cr->x, cr->y);
	inc	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	dec	hl
	dec	hl
	ld	(hl), a
	ld	a, (bc)
	ldhl	sp,	#8
	ld	(hl), a
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1218: OAM_item_t * itm = &shadow_OAM[nb];
	ld	de, #_shadow_OAM+4
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1219: itm->y=y, itm->x=x;
	ldhl	sp,	#5
	ld	a, (hl)
	ld	(de), a
	inc	de
	ldhl	sp,	#8
	ld	a, (hl)
	ld	(de), a
;menus.c:271: move_sprite(2, cr->x + 8, cr->y);
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	dec	hl
	dec	hl
	ld	(hl), a
	ld	a, (bc)
	add	a, #0x08
	ldhl	sp,	#8
	ld	(hl), a
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1218: OAM_item_t * itm = &shadow_OAM[nb];
	ld	de, #_shadow_OAM+8
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1219: itm->y=y, itm->x=x;
	ldhl	sp,	#5
	ld	a, (hl)
	ld	(de), a
	inc	de
	ldhl	sp,	#8
	ld	a, (hl)
	ld	(de), a
;menus.c:272: move_sprite(3, cr->x, cr->y + 8);
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	add	a, #0x08
	ld	d, a
	ld	a, (bc)
	ld	e, a
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1218: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 0x000c)
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1219: itm->y=y, itm->x=x;
	ld	a, d
	ld	(hl+), a
	ld	(hl), e
;menus.c:273: move_sprite(4, cr->x + 8, cr->y + 8);
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	add	a, #0x08
	ld	e, a
	ld	a, (bc)
	add	a, #0x08
	ld	c, a
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1218: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 0x0010)
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1219: itm->y=y, itm->x=x;
	ld	a, e
	ld	(hl+), a
	ld	(hl), c
;menus.c:273: move_sprite(4, cr->x + 8, cr->y + 8);
00102$:
;menus.c:275: se_move_cursor();
	ld	e, #b_se_move_cursor
	ld	hl, #_se_move_cursor
	call	___sdcc_bcall_ehl
;menus.c:276: custom_delay(7);
	ld	a, #0x07
	push	af
	inc	sp
	call	_custom_delay
	inc	sp
;menus.c:277: }
	add	sp, #9
	ret
;menus.c:280: void update_pass_field() BANKED {
;	---------------------------------
; Function update_pass_field
; ---------------------------------
	b_update_pass_field	= 1
_update_pass_field::
;menus.c:281: for(i = 0; i < 4; i++) {
	ld	hl, #_i
	ld	(hl), #0x00
00105$:
;menus.c:282: set_bkg_tile_xy(6 + i * 2, 3, passentry[i]);
	ld	a, #<(_passentry)
	ld	hl, #_i
	add	a, (hl)
	ld	c, a
	ld	a, #>(_passentry)
	adc	a, #0x00
	ld	b, a
	ld	a, (bc)
	ld	b, a
	ld	a, (hl)
	add	a, a
	add	a, #0x06
	push	bc
	inc	sp
	ld	h, #0x03
	push	hl
	inc	sp
	push	af
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
;menus.c:281: for(i = 0; i < 4; i++) {
	ld	hl, #_i
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x04
	jr	C, 00105$
;menus.c:284: if(passidx != 4) {
	ld	a, (#_passidx)
	sub	a, #0x04
	ret	Z
;menus.c:285: move_sprite(5, 61 + passidx * 16, 40);
	ld	a, (#_passidx)
	swap	a
	and	a, #0xf0
	add	a, #0x3d
	ld	c, a
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1218: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 0x0014)
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1219: itm->y=y, itm->x=x;
	ld	a, #0x28
	ld	(hl+), a
	ld	(hl), c
;menus.c:285: move_sprite(5, 61 + passidx * 16, 40);
;menus.c:287: }
	ret
;menus.c:290: void add_character() BANKED {
;	---------------------------------
; Function add_character
; ---------------------------------
	b_add_character	= 1
_add_character::
;menus.c:291: passentry[passidx] = crsr.row * 9 + crsr.col + 11;
	ld	bc, #_passentry+0
	ld	a, c
	ld	hl, #_passidx
	add	a, (hl)
	ld	c, a
	jr	NC, 00103$
	inc	b
00103$:
	ld	a, (#(_crsr + 0x0002) + 0)
	ld	e, a
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ld	l, a
	ld	de, #_crsr + 3
	ld	a, (de)
	add	a, l
	add	a, #0x0b
	ld	(bc), a
;menus.c:292: passidx++;
	ld	hl, #_passidx
	inc	(hl)
;menus.c:293: update_pass_field();
	ld	e, #b_update_pass_field
	ld	hl, #_update_pass_field
	call	___sdcc_bcall_ehl
;menus.c:294: se_add_character();
	ld	e, #b_se_add_character
	ld	hl, #_se_add_character
;menus.c:295: }
	jp  ___sdcc_bcall_ehl
;menus.c:298: void drop_character() BANKED {
;	---------------------------------
; Function drop_character
; ---------------------------------
	b_drop_character	= 1
_drop_character::
;menus.c:299: if(passidx > 0) {
	ld	hl, #_passidx
	ld	a, (hl)
	or	a, a
	ret	Z
;menus.c:300: passidx--;
	dec	(hl)
;menus.c:301: passentry[passidx] = 51;    // Empty tile
	ld	bc, #_passentry+0
	ld	a, c
	add	a, (hl)
	ld	c, a
	jr	NC, 00110$
	inc	b
00110$:
	ld	a, #0x33
	ld	(bc), a
;menus.c:302: update_pass_field();
	ld	e, #b_update_pass_field
	ld	hl, #_update_pass_field
	call	___sdcc_bcall_ehl
;menus.c:303: se_drop_character();
	ld	e, #b_se_drop_character
	ld	hl, #_se_drop_character
;menus.c:305: }
	jp  ___sdcc_bcall_ehl
;menus.c:308: void reset_password() BANKED {
;	---------------------------------
; Function reset_password
; ---------------------------------
	b_reset_password	= 1
_reset_password::
;menus.c:309: for(i = 0; i < 4; i++) {
	ld	hl, #_i
	ld	(hl), #0x00
00102$:
;menus.c:310: passentry[i] = 51;
	ld	a, #<(_passentry)
	ld	hl, #_i
	add	a, (hl)
	ld	c, a
	ld	a, #>(_passentry)
	adc	a, #0x00
	ld	b, a
	ld	a, #0x33
	ld	(bc), a
;menus.c:309: for(i = 0; i < 4; i++) {
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x04
	jr	C, 00102$
;menus.c:312: passidx = 0;
	ld	hl, #_passidx
	ld	(hl), #0x00
;menus.c:313: update_pass_field();
	ld	e, #b_update_pass_field
	ld	hl, #_update_pass_field
	call	___sdcc_bcall_ehl
;menus.c:314: se_drop_character();
	ld	e, #b_se_drop_character
	ld	hl, #_se_drop_character
;menus.c:315: }
	jp  ___sdcc_bcall_ehl
;menus.c:318: UINT8 get_stage_from_password() BANKED {
;	---------------------------------
; Function get_stage_from_password
; ---------------------------------
	b_get_stage_from_password	= 1
_get_stage_from_password::
;menus.c:319: for(i = 0; i != 8; i++) {
	ld	hl, #_i
	ld	(hl), #0x00
	ld	bc, #_passwords+0
00104$:
;menus.c:320: if(compare_password(passwords[i])) {
	ld	hl, #_i
	ld	l, (hl)
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	add	hl, bc
	push	bc
	push	hl
	ld	e, #b_compare_password
	ld	hl, #_compare_password
	call	___sdcc_bcall_ehl
	add	sp, #2
	ld	a, e
	pop	bc
	or	a, a
	jr	Z, 00105$
;menus.c:321: return i;   // Password array index matches stage number
	ld	hl, #_i
	ld	e, (hl)
	ret
00105$:
;menus.c:319: for(i = 0; i != 8; i++) {
	ld	hl, #_i
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x08
	jr	NZ, 00104$
;menus.c:324: return wrongpassind;  // Could not find entered password
	ld	hl, #_wrongpassind
	ld	e, (hl)
;menus.c:325: }
	ret
;menus.c:328: UBYTE compare_password(UINT8 * pass) BANKED {
;	---------------------------------
; Function compare_password
; ---------------------------------
	b_compare_password	= 1
_compare_password::
;menus.c:329: for(citr = 0; citr < 4; citr++) {
	ld	hl, #_citr
	ld	(hl), #0x00
00104$:
;menus.c:330: if(passentry[citr] != pass[citr]) {
	ld	a, #<(_passentry)
	ld	hl, #_citr
	add	a, (hl)
	ld	c, a
	ld	a, #>(_passentry)
	adc	a, #0x00
	ld	b, a
	ld	a, (bc)
	ld	c, a
;c
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_citr
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	sub	a, c
	jr	Z, 00105$
;menus.c:331: return 0;   // Letter mismatch
	ld	e, #0x00
	ret
00105$:
;menus.c:329: for(citr = 0; citr < 4; citr++) {
	ld	hl, #_citr
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x04
	jr	C, 00104$
;menus.c:334: return 1;
	ld	e, #0x01
;menus.c:335: }
	ret
;menus.c:338: UBYTE confirm_password() BANKED {
;	---------------------------------
; Function confirm_password
; ---------------------------------
	b_confirm_password	= 1
_confirm_password::
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1145: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 0x0002)
	ld	(hl), #0x01
	ld	hl, #(_shadow_OAM + 0x0016)
	ld	(hl), #0x00
;menus.c:341: move_sprite(0, passconfoptsx[1], passconfy);
	ld	hl, #_passconfy
	ld	b, (hl)
	ld	hl, #(_passconfoptsx + 0x0001)
	ld	c, (hl)
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1218: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #_shadow_OAM
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1219: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;menus.c:342: while(1) {
00107$:
;menus.c:343: wait_vbl_done();
	call	_wait_vbl_done
;menus.c:344: if(joypad() & (J_LEFT | J_RIGHT | J_SELECT)) {
	call	_joypad
	ld	a, e
	and	a, #0x43
	jr	Z, 00104$
;menus.c:345: move_sprite(0, passconfoptsx[shadow_OAM[0].x == passconfoptsx[0] ? 1 : 0], passconfy);
	ld	hl, #_passconfy
	ld	c, (hl)
	ld	a, (#(_shadow_OAM + 0x0001) + 0)
	ld	hl, #_passconfoptsx
	ld	b, (hl)
	sub	a, b
	jr	NZ, 00116$
	ld	de, #0x0001
	jr	00117$
00116$:
	ld	de, #0x0000
00117$:
	ld	hl, #_passconfoptsx
	add	hl, de
	ld	b, (hl)
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1218: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #_shadow_OAM
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1219: itm->y=y, itm->x=x;
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;menus.c:346: se_move_cursor();
	ld	e, #b_se_move_cursor
	ld	hl, #_se_move_cursor
	call	___sdcc_bcall_ehl
;menus.c:347: waitpadup();
	call	_waitpadup
	jr	00105$
00104$:
;menus.c:348: } else if(joypad() & (J_A |  J_START)) {
	call	_joypad
	ld	a, e
	and	a, #0x90
	jr	Z, 00105$
;menus.c:349: waitpadup();
	call	_waitpadup
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1145: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 0x0002)
	ld	(hl), #0x00
;menus.c:351: return shadow_OAM[0].x == passconfoptsx[1];
	ld	hl, #(_shadow_OAM + 0x0001)
	ld	c, (hl)
	ld	hl, #(_passconfoptsx + 0x0001)
	ld	b, (hl)
	ld	a, c
	sub	a, b
	ld	a, #0x01
	jr	Z, 00143$
	xor	a, a
00143$:
	ld	e, a
	ret
00105$:
;menus.c:353: manage_sound_chnls();
	call	_manage_sound_chnls
;menus.c:355: }
	jr	00107$
;menus.c:358: void anim_cursor_blink() BANKED {
;	---------------------------------
; Function anim_cursor_blink
; ---------------------------------
	b_anim_cursor_blink	= 1
_anim_cursor_blink::
;menus.c:359: if(menuanimcnt == 0) {
	ld	a, (#_menuanimcnt)
	or	a, a
	jr	NZ, 00102$
;menus.c:360: menuanimcnt = blinkanimdur;
	ld	a, (#_blinkanimdur)
	ld	(#_menuanimcnt),a
;menus.c:361: set_sprite_tile(5, shadow_OAM[5].tile == 0 ? 3 : 0);
	ld	a, (#(_shadow_OAM + 0x0016) + 0)
	or	a, a
	jr	NZ, 00107$
	ld	bc, #0x0003
	jr	00108$
00107$:
	ld	bc, #0x0000
00108$:
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1145: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 0x0016)
	ld	(hl), c
;menus.c:361: set_sprite_tile(5, shadow_OAM[5].tile == 0 ? 3 : 0);
	ret
00102$:
;menus.c:363: menuanimcnt--;
	ld	hl, #_menuanimcnt
	dec	(hl)
;menus.c:365: }
	ret
;menus.c:368: void password_menu() {
;	---------------------------------
; Function password_menu
; ---------------------------------
	b_password_menu	= 1
_password_menu::
	dec	sp
;menus.c:369: menuanimcnt = blinkanimdur;
	ld	a, (#_blinkanimdur)
	ld	(#_menuanimcnt),a
;menus.c:370: UINT8 matchedpassstage = wrongpassind;
	ld	a, (#_wrongpassind)
	ldhl	sp,	#0
	ld	(hl), a
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:840: SCX_REG+=x, SCY_REG+=y;
	ldh	a, (_SCX_REG+0)
	add	a, #0xfb
	ldh	(_SCX_REG+0),a
;menus.c:372: init_common_menu_props();
	ld	e, #b_init_common_menu_props
	ld	hl, #_init_common_menu_props
	call	___sdcc_bcall_ehl
;menus.c:373: set_bkg_data(42, 10, passwscreentiles);
	ld	hl, #_passwscreentiles
	push	hl
	ld	de, #0x0a2a
	push	de
	call	_set_bkg_data
	add	sp, #4
;menus.c:374: set_bkg_tiles(0, 0, 20, 18, passwscreenmap);
	ld	hl, #_passwscreenmap
	push	hl
	ld	de, #0x1214
	push	de
	xor	a, a
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_set_bkg_tiles
	add	sp, #6
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1145: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 0x0002)
	ld	(hl), #0x01
;menus.c:376: init_passcursor(&crsr, 17, 76);
	ld	de, #0x4c11
	push	de
	ld	hl, #_crsr
	push	hl
	ld	e, #b_init_passcursor
	ld	hl, #_init_passcursor
	call	___sdcc_bcall_ehl
	add	sp, #4
;menus.c:377: reset_password();
	ld	e, #b_reset_password
	ld	hl, #_reset_password
	call	___sdcc_bcall_ehl
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1145: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 0x0016)
	ld	(hl), #0x00
;menus.c:379: anim_reverse_blackout();
	call	_anim_reverse_blackout
;menus.c:381: while(matchedpassstage == wrongpassind) {
00119$:
	ld	hl, #_wrongpassind
	ld	c, (hl)
	ldhl	sp,	#0
	ld	a, (hl)
	sub	a, c
	jp	NZ,00121$
;menus.c:382: switch(joypad()) {
	call	_joypad
	ld	a, e
	cp	a, #0x01
	jr	Z, 00102$
	cp	a, #0x02
	jr	Z, 00101$
	cp	a, #0x04
	jr	Z, 00103$
	cp	a, #0x08
	jr	Z, 00104$
	cp	a, #0x10
	jr	Z, 00105$
	sub	a, #0x20
	jp	Z,00110$
	jp	00111$
;menus.c:383: case J_LEFT:
00101$:
;menus.c:384: move_passcursor(&crsr, -1, 0);
	xor	a, a
	ld	d,a
	ld	e,#0xff
	push	de
	ld	hl, #_crsr
	push	hl
	ld	e, #b_move_passcursor
	ld	hl, #_move_passcursor
	call	___sdcc_bcall_ehl
	add	sp, #4
;menus.c:385: break;
	jr	00111$
;menus.c:386: case J_RIGHT:
00102$:
;menus.c:387: move_passcursor(&crsr, 1, 0);
	xor	a, a
	ld	d,a
	ld	e,#0x01
	push	de
	ld	hl, #_crsr
	push	hl
	ld	e, #b_move_passcursor
	ld	hl, #_move_passcursor
	call	___sdcc_bcall_ehl
	add	sp, #4
;menus.c:388: break;
	jr	00111$
;menus.c:389: case J_UP:
00103$:
;menus.c:390: move_passcursor(&crsr, 0, -1);
	ld	a, #0xff
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	ld	hl, #_crsr
	push	hl
	ld	e, #b_move_passcursor
	ld	hl, #_move_passcursor
	call	___sdcc_bcall_ehl
	add	sp, #4
;menus.c:391: break;
	jr	00111$
;menus.c:392: case J_DOWN:
00104$:
;menus.c:393: move_passcursor(&crsr, 0, 1);
	ld	a, #0x01
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	ld	hl, #_crsr
	push	hl
	ld	e, #b_move_passcursor
	ld	hl, #_move_passcursor
	call	___sdcc_bcall_ehl
	add	sp, #4
;menus.c:394: break;
	jr	00111$
;menus.c:395: case J_A:
00105$:
;menus.c:396: if(crsr.row == 2 && crsr.col == 8) {
	ld	a, (#(_crsr + 0x0002) + 0)
	sub	a, #0x02
	jr	NZ, 00107$
	ld	a, (#(_crsr + 0x0003) + 0)
	sub	a, #0x08
	jr	NZ, 00107$
;menus.c:397: drop_character();
	ld	e, #b_drop_character
	ld	hl, #_drop_character
	call	___sdcc_bcall_ehl
	jr	00108$
00107$:
;menus.c:399: add_character();
	ld	e, #b_add_character
	ld	hl, #_add_character
	call	___sdcc_bcall_ehl
00108$:
;menus.c:401: waitpadup();
	call	_waitpadup
;menus.c:402: break;
	jr	00111$
;menus.c:403: case J_B:
00110$:
;menus.c:404: drop_character();
	ld	e, #b_drop_character
	ld	hl, #_drop_character
	call	___sdcc_bcall_ehl
;menus.c:405: waitpadup();
	call	_waitpadup
;menus.c:407: }
00111$:
;menus.c:408: if(passidx == 4) {   // Full password entered
	ld	a, (#_passidx)
	sub	a, #0x04
	jr	NZ, 00118$
;menus.c:409: if(confirm_password()) {
	ld	e, #b_confirm_password
	ld	hl, #_confirm_password
	call	___sdcc_bcall_ehl
	ld	a, e
	or	a, a
	jr	Z, 00115$
;menus.c:410: matchedpassstage = get_stage_from_password();
	ld	e, #b_get_stage_from_password
	ld	hl, #_get_stage_from_password
	call	___sdcc_bcall_ehl
	ldhl	sp,	#0
	ld	(hl), e
;menus.c:411: if(matchedpassstage == wrongpassind) {
	ld	hl, #_wrongpassind
	ld	c, (hl)
	ldhl	sp,	#0
	ld	a, (hl)
	sub	a, c
	jr	NZ, 00118$
;menus.c:412: reset_password();
	ld	e, #b_reset_password
	ld	hl, #_reset_password
	call	___sdcc_bcall_ehl
;menus.c:413: se_wrong_password();
	ld	e, #b_se_wrong_password
	ld	hl, #_se_wrong_password
	call	___sdcc_bcall_ehl
	jr	00118$
00115$:
;menus.c:416: reset_password();
	ld	e, #b_reset_password
	ld	hl, #_reset_password
	call	___sdcc_bcall_ehl
00118$:
;menus.c:419: anim_cursor_blink();
	ld	e, #b_anim_cursor_blink
	ld	hl, #_anim_cursor_blink
	call	___sdcc_bcall_ehl
;menus.c:420: manage_sound_chnls();
	call	_manage_sound_chnls
;menus.c:421: wait_vbl_done();
	call	_wait_vbl_done
	jp	00119$
00121$:
;menus.c:424: se_choose_entry();
	ld	e, #b_se_choose_entry
	ld	hl, #_se_choose_entry
	call	___sdcc_bcall_ehl
;menus.c:425: reset_sprites(0, 5);
	ld	a, #0x05
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_reset_sprites
	add	sp, #2
;menus.c:426: anim_blackout();
	call	_anim_blackout
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:826: SCX_REG=x, SCY_REG=y;
	ld	a, #0x00
	ldh	(_SCX_REG+0),a
	ld	a, #0x00
	ldh	(_SCY_REG+0),a
;menus.c:428: if(matchedpassstage == 7)   {   // Entered extras password
	ldhl	sp,	#0
	ld	a, (hl)
	sub	a, #0x07
	jr	NZ, 00123$
;menus.c:429: extrasflg = 1;
	ld	hl, #_extrasflg
	ld	(hl), #0x01
;menus.c:430: extras_menu();
	ld	e, #b_extras_menu
	ld	hl, #_extras_menu
	call	___sdcc_bcall_ehl
	jr	00129$
00123$:
;menus.c:432: stagenum = matchedpassstage;
	ldhl	sp,	#0
	ld	a, (hl)
	ld	(#_stagenum),a
00129$:
;menus.c:434: }
	inc	sp
	ret
;menus.c:437: void extras_menu() BANKED {
;	---------------------------------
; Function extras_menu
; ---------------------------------
	b_extras_menu	= 1
_extras_menu::
;menus.c:438: init_common_menu_props();
	ld	e, #b_init_common_menu_props
	ld	hl, #_init_common_menu_props
	call	___sdcc_bcall_ehl
;menus.c:439: set_bkg_tiles(4, 1, 12, 1, extrmenusign);
	ld	hl, #_extrmenusign
	push	hl
	ld	de, #0x010c
	push	de
	ld	de, #0x0104
	push	de
	call	_set_bkg_tiles
	add	sp, #6
;menus.c:440: set_bkg_tiles(5, 4, 10, 1, plasmasign);
	ld	hl, #_plasmasign
	push	hl
	ld	de, #0x010a
	push	de
	ld	de, #0x0405
	push	de
	call	_set_bkg_tiles
	add	sp, #6
;menus.c:441: set_bkg_tiles(5, 6, 10, 1, fightbosssign);
	ld	hl, #_fightbosssign
	push	hl
	ld	de, #0x010a
	push	de
	ld	de, #0x0605
	push	de
	call	_set_bkg_tiles
	add	sp, #6
;menus.c:442: set_bkg_tiles(2, 9, 16, 1, bossrushsign);
	ld	hl, #_bossrushsign
	push	hl
	ld	de, #0x0110
	push	de
	ld	de, #0x0902
	push	de
	call	_set_bkg_tiles
	add	sp, #6
;menus.c:443: set_bkg_tiles(5, 12, 7, 1, regularsign);
	ld	hl, #_regularsign
	push	hl
	ld	de, #0x0107
	push	de
	ld	de, #0x0c05
	push	de
	call	_set_bkg_tiles
	add	sp, #6
;menus.c:444: set_bkg_tiles(5, 14, 12, 1, glasscannonsign);
	ld	hl, #_glasscannonsign
	push	hl
	ld	de, #0x010c
	push	de
	ld	de, #0x0e05
	push	de
	call	_set_bkg_tiles
	add	sp, #6
;menus.c:445: set_bkg_tiles(5, 16, 13, 1, glassfeathersign);
	ld	hl, #_glassfeathersign
	push	hl
	ld	de, #0x010d
	push	de
	ld	de, #0x1005
	push	de
	call	_set_bkg_tiles
	add	sp, #6
;menus.c:446: move_sprite(0, 36, extrasoptsy[0]);
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1218: OAM_item_t * itm = &shadow_OAM[nb];
;F:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1219: itm->y=y, itm->x=x;
	ld	a, (#_extrasoptsy + 0)
	ld	hl, #_shadow_OAM
	ld	(hl+), a
	ld	(hl), #0x24
;menus.c:447: anim_reverse_blackout();
	call	_anim_reverse_blackout
;menus.c:448: get_menu_pl_input(extrasoptsy, 5);
	ld	a, #0x05
	push	af
	inc	sp
	ld	hl, #_extrasoptsy
	push	hl
	ld	e, #b_get_menu_pl_input
	ld	hl, #_get_menu_pl_input
	call	___sdcc_bcall_ehl
	add	sp, #3
;menus.c:449: waitpadup();
	call	_waitpadup
;menus.c:451: if(menuidx == 0) { // Plasma run
	ld	a, (#_menuidx)
	or	a, a
	jr	NZ, 00105$
;menus.c:452: defaultplgun = 3;
	ld	hl, #_defaultplgun
	ld	(hl), #0x03
	jp	_anim_blackout
00105$:
;menus.c:453: } else if(menuidx == 1) {    // Single boss fight
	ld	a, (#_menuidx)
	dec	a
	jr	NZ, 00102$
;menus.c:454: stagenum = choose_boss();
	ld	e, #b_choose_boss
	ld	hl, #_choose_boss
	call	___sdcc_bcall_ehl
	ld	hl, #_stagenum
	ld	(hl), e
;menus.c:455: se_choose_entry();
	ld	e, #b_se_choose_entry
	ld	hl, #_se_choose_entry
	call	___sdcc_bcall_ehl
;menus.c:456: bossrushflg = 2;
	ld	hl, #_bossrushflg
	ld	(hl), #0x02
;menus.c:457: defaultplgun = bossrushconfigs[0][0];
	ld	bc, #_bossrushconfigs+0
	ld	a, (bc)
	ld	(#_defaultplgun),a
;menus.c:458: pllives = bossrushconfigs[0][1];
	inc	bc
	ld	a, (bc)
	ld	(#_pllives),a
	jp	_anim_blackout
00102$:
;menus.c:460: bossrushflg = 1;
	ld	hl, #_bossrushflg
	ld	(hl), #0x01
;menus.c:461: defaultplgun = bossrushconfigs[menuidx - 2][0];
	ld	bc, #_bossrushconfigs+0
	ld	a, (#_menuidx)
	dec	a
	dec	a
	ld	l, a
	rla
	sbc	a, a
	ld	h, a
	add	hl, hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	(#_defaultplgun),a
;menus.c:462: pllives = bossrushconfigs[menuidx - 2][1];
	inc	bc
	ld	a, (bc)
	ld	(#_pllives),a
;menus.c:464: anim_blackout();
;menus.c:465: }
	jp  _anim_blackout
;menus.c:468: UINT8 choose_boss() BANKED {
;	---------------------------------
; Function choose_boss
; ---------------------------------
	b_choose_boss	= 1
_choose_boss::
;menus.c:469: i = 0;
	ld	hl, #_i
	ld	(hl), #0x00
;menus.c:470: set_bkg_data(42, 7, misctiles);
	ld	hl, #_misctiles
	push	hl
	ld	de, #0x072a
	push	de
	call	_set_bkg_data
	add	sp, #4
;menus.c:471: set_bkg_tile_xy(16, 6, 47);
	ld	de, #0x2f06
	push	de
	ld	a, #0x10
	push	af
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
;menus.c:472: set_bkg_tile_xy(17, 6, 2);
	ld	de, #0x0206
	push	de
	ld	a, #0x11
	push	af
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
;menus.c:473: set_bkg_tile_xy(18, 6, 48);
	ld	de, #0x3006
	push	de
	ld	a, #0x12
	push	af
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
;menus.c:474: while(1) {
00110$:
;menus.c:475: if(joypad() & J_LEFT) {
	call	_joypad
	bit	1, e
	jr	Z, 00107$
;menus.c:476: i = i == 0 ? 0 : i - 1;
	ld	a, (#_i)
	or	a, a
	jr	NZ, 00114$
	ld	bc, #0x0000
	jr	00115$
00114$:
	ld	a, (#_i)
	dec	a
	ld	c, a
	rla
00115$:
	ld	hl, #_i
	ld	(hl), c
;menus.c:477: set_bkg_tile_xy(17, 6, i + 2);
	ld	a, (hl)
	add	a, #0x02
	ld	d,a
	ld	e,#0x06
	push	de
	ld	a, #0x11
	push	af
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
;menus.c:478: se_add_character();
	ld	e, #b_se_add_character
	ld	hl, #_se_add_character
	call	___sdcc_bcall_ehl
;menus.c:479: custom_delay(7);
	ld	a, #0x07
	push	af
	inc	sp
	call	_custom_delay
	inc	sp
	jr	00110$
00107$:
;menus.c:480: } else if(joypad() & J_RIGHT) {
	call	_joypad
	ld	a, e
	rrca
	jr	NC, 00104$
;menus.c:481: i = i == 6 ? 6 : i + 1;
	ld	a, (#_i)
	sub	a, #0x06
	jr	NZ, 00116$
	ld	bc, #0x0006
	jr	00117$
00116$:
	ld	a, (#_i)
	inc	a
	ld	c, a
	rla
00117$:
	ld	hl, #_i
	ld	(hl), c
;menus.c:482: set_bkg_tile_xy(17, 6, i + 2);
	ld	a, (hl)
	add	a, #0x02
	ld	d,a
	ld	e,#0x06
	push	de
	ld	a, #0x11
	push	af
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
;menus.c:483: se_add_character();
	ld	e, #b_se_add_character
	ld	hl, #_se_add_character
	call	___sdcc_bcall_ehl
;menus.c:484: custom_delay(7);
	ld	a, #0x07
	push	af
	inc	sp
	call	_custom_delay
	inc	sp
	jr	00110$
00104$:
;menus.c:485: } else if(joypad() & (J_A | J_START)) {
	call	_joypad
	ld	a, e
	and	a, #0x90
	jp	Z,00110$
;menus.c:486: return i;
	ld	hl, #_i
	ld	e, (hl)
;menus.c:489: }
	ret
;menus.c:492: void boss_rush_results_screen() BANKED {
;	---------------------------------
; Function boss_rush_results_screen
; ---------------------------------
	b_boss_rush_results_screen	= 1
_boss_rush_results_screen::
;menus.c:493: init_common_menu_props();
	ld	e, #b_init_common_menu_props
	ld	hl, #_init_common_menu_props
	call	___sdcc_bcall_ehl
;menus.c:494: fill_bkg_rect(0, 0, 20, 18, 0);
	xor	a, a
	ld	d,a
	ld	e,#0x12
	push	de
	ld	a, #0x14
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
;menus.c:495: set_bkg_tiles(5, 1, 9, 1, rushrestitlesign);
	ld	hl, #_rushrestitlesign
	push	hl
	ld	de, #0x0109
	push	de
	ld	de, #0x0105
	push	de
	call	_set_bkg_tiles
	add	sp, #6
;menus.c:497: if(menuidx == 2) {
	ld	a, (#_menuidx)
	sub	a, #0x02
	jr	NZ, 00105$
;menus.c:498: set_bkg_tiles(3, 3, 7, 1, regularsign);
	ld	hl, #_regularsign
	push	hl
	ld	de, #0x0107
	push	de
	ld	de, #0x0303
	push	de
	call	_set_bkg_tiles
	add	sp, #6
;menus.c:499: set_bkg_tiles(12, 3, 4, 1, rushresmodesign);
	ld	hl, #_rushresmodesign
	push	hl
	ld	de, #0x0104
	push	de
	ld	de, #0x030c
	push	de
	call	_set_bkg_tiles
	add	sp, #6
	jr	00106$
00105$:
;menus.c:500: } else if(menuidx == 3) {
	ld	a, (#_menuidx)
	sub	a, #0x03
	jr	NZ, 00102$
;menus.c:501: set_bkg_tiles(1, 3, 12, 1, glasscannonsign);
	ld	hl, #_glasscannonsign
	push	hl
	ld	de, #0x010c
	push	de
	ld	de, #0x0301
	push	de
	call	_set_bkg_tiles
	add	sp, #6
;menus.c:502: set_bkg_tiles(14, 3, 4, 1, rushresmodesign);
	ld	hl, #_rushresmodesign
	push	hl
	ld	de, #0x0104
	push	de
	ld	de, #0x030e
	push	de
	call	_set_bkg_tiles
	add	sp, #6
	jr	00106$
00102$:
;menus.c:504: set_bkg_tiles(1, 3, 13, 1, glassfeathersign);
	ld	hl, #_glassfeathersign
	push	hl
	ld	de, #0x010d
	push	de
	ld	de, #0x0301
	push	de
	call	_set_bkg_tiles
	add	sp, #6
;menus.c:505: set_bkg_tiles(15, 3, 4, 1, rushresmodesign);
	ld	hl, #_rushresmodesign
	push	hl
	ld	de, #0x0104
	push	de
	ld	de, #0x030f
	push	de
	call	_set_bkg_tiles
	add	sp, #6
00106$:
;menus.c:508: if(stagenum == 7) {    // Beaten all bosses
	ld	a, (#_stagenum)
	sub	a, #0x07
	jp	NZ,00113$
;menus.c:509: set_bkg_data(53, 8, medaltiles);
	ld	hl, #_medaltiles
	push	hl
	ld	de, #0x0835
	push	de
	call	_set_bkg_data
	add	sp, #4
;menus.c:510: set_bkg_tiles(1, 5, 14, 1, rushresbossesdefsign);
	ld	hl, #_rushresbossesdefsign
	push	hl
	ld	de, #0x010e
	push	de
	ld	de, #0x0501
	push	de
	call	_set_bkg_tiles
	add	sp, #6
;menus.c:511: set_bkg_tiles(15, 5, 3, 1, allsign);
	ld	hl, #_allsign
	push	hl
	ld	de, #0x0103
	push	de
	ld	de, #0x050f
	push	de
	call	_set_bkg_tiles
	add	sp, #6
;menus.c:512: set_bkg_tiles(2, 7, 16, 1, congratssign);
	ld	hl, #_congratssign
	push	hl
	ld	de, #0x0110
	push	de
	ld	de, #0x0702
	push	de
	call	_set_bkg_tiles
	add	sp, #6
;menus.c:513: set_bkg_tiles(1, 9, 17, 1, awardedsign);
	ld	hl, #_awardedsign
	push	hl
	ld	de, #0x0111
	push	de
	ld	de, #0x0901
	push	de
	call	_set_bkg_tiles
	add	sp, #6
;menus.c:514: set_bkg_tiles(2, 11, 15, 1, medaltypessign[menuidx - 2]);
	ld	hl, #_menuidx
	ld	c, (hl)
	dec	c
	dec	c
	ld	a, c
	rlca
	sbc	a, a
	ld	b, a
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, bc
	ld	de, #_medaltypessign
	add	hl, de
	push	hl
	ld	de, #0x010f
	push	de
	ld	de, #0x0b02
	push	de
	call	_set_bkg_tiles
	add	sp, #6
;menus.c:515: set_bkg_tiles(9, 13, 2, 2, medalssigns[menuidx - 2]);
	ld	bc, #_medalssigns+0
	ld	a, (#_menuidx)
	dec	a
	dec	a
	ld	l, a
	rla
	sbc	a, a
	ld	h, a
	add	hl, hl
	add	hl, hl
	add	hl, bc
	push	hl
	ld	de, #0x0202
	push	de
	ld	de, #0x0d09
	push	de
	call	_set_bkg_tiles
	add	sp, #6
;menus.c:516: set_bkg_tiles(5, 16, 10, 1, pushstartsign);
	ld	hl, #_pushstartsign
	push	hl
	ld	de, #0x010a
	push	de
	ld	de, #0x1005
	push	de
	call	_set_bkg_tiles
	add	sp, #6
	jr	00114$
00113$:
;menus.c:518: set_bkg_tile_xy(17, 8, 1 + stagenum);
	ld	a, (#_stagenum)
	inc	a
	ld	d,a
	ld	e,#0x08
	push	de
	ld	a, #0x11
	push	af
	inc	sp
	call	_set_bkg_tile_xy
	add	sp, #3
;menus.c:519: set_bkg_tiles(3, 8, 14, 1, rushresbossesdefsign);
	ld	hl, #_rushresbossesdefsign
	push	hl
	ld	de, #0x010e
	push	de
	ld	de, #0x0803
	push	de
	call	_set_bkg_tiles
	add	sp, #6
;menus.c:520: set_bkg_tiles(5, 14, 10, 1, pushstartsign);
	ld	hl, #_pushstartsign
	push	hl
	ld	de, #0x010a
	push	de
	ld	de, #0x0e05
	push	de
	call	_set_bkg_tiles
	add	sp, #6
;menus.c:521: if(stagenum > 3) {
	ld	a, #0x03
	ld	hl, #_stagenum
	sub	a, (hl)
	jr	NC, 00110$
;menus.c:522: set_bkg_tiles(5, 10, 11, 1, greatjobsign);
	ld	hl, #_greatjobsign
	push	hl
	ld	de, #0x010b
	push	de
	ld	de, #0x0a05
	push	de
	call	_set_bkg_tiles
	add	sp, #6
	jr	00114$
00110$:
;menus.c:523: } else if(stagenum > 0) {
	ld	a, (#_stagenum)
	or	a, a
	jr	Z, 00114$
;menus.c:524: set_bkg_tiles(5, 10, 10, 1, goodjobsign);
	ld	hl, #_goodjobsign
	push	hl
	ld	de, #0x010a
	push	de
	ld	de, #0x0a05
	push	de
	call	_set_bkg_tiles
	add	sp, #6
00114$:
;menus.c:528: anim_reverse_blackout();
	call	_anim_reverse_blackout
;menus.c:529: waitpad(J_START);
	ld	a, #0x80
	push	af
	inc	sp
	call	_waitpad
	inc	sp
;menus.c:530: stagenum = defaultplgun = bossrushflg = 0;
	ld	hl, #_bossrushflg
	ld	(hl), #0x00
	ld	hl, #_defaultplgun
	ld	(hl), #0x00
	ld	hl, #_stagenum
	ld	(hl), #0x00
;menus.c:531: se_choose_entry();
	ld	e, #b_se_choose_entry
	ld	hl, #_se_choose_entry
	call	___sdcc_bcall_ehl
;menus.c:532: anim_blackout();
;menus.c:533: }
	jp  _anim_blackout
;menus.c:536: void play_song(const hUGESong_t * song) BANKED {
;	---------------------------------
; Function play_song
; ---------------------------------
	b_play_song	= 1
_play_song::
;menus.c:540: }
	di
;menus.c:538: hUGE_init(song);
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_hUGE_init
	add	sp, #2
;menus.c:539: add_VBL(hUGE_dosound);
	ld	hl, #_hUGE_dosound
	push	hl
	call	_add_VBL
	add	sp, #2
	ei
;menus.c:541: }
	ret
;menus.c:544: void se_choose_entry() BANKED {
;	---------------------------------
; Function se_choose_entry
; ---------------------------------
	b_se_choose_entry	= 1
_se_choose_entry::
;menus.c:545: mute_music_pl_chnl(0);
	xor	a, a
	push	af
	inc	sp
	call	_mute_music_pl_chnl
	inc	sp
;menus.c:546: NR10_REG = 0x64;
	ld	a, #0x64
	ldh	(_NR10_REG+0),a
;menus.c:547: NR11_REG = 0x88;
	ld	a, #0x88
	ldh	(_NR11_REG+0),a
;menus.c:548: NR12_REG = 0xF3;
	ld	a, #0xf3
	ldh	(_NR12_REG+0),a
;menus.c:549: NR13_REG = 0x3E;
	ld	a, #0x3e
	ldh	(_NR13_REG+0),a
;menus.c:550: NR14_REG = 0x86;
	ld	a, #0x86
	ldh	(_NR14_REG+0),a
;menus.c:551: }
	ret
;menus.c:554: void se_move_cursor() BANKED {
;	---------------------------------
; Function se_move_cursor
; ---------------------------------
	b_se_move_cursor	= 1
_se_move_cursor::
;menus.c:555: mute_music_pl_chnl(0);
	xor	a, a
	push	af
	inc	sp
	call	_mute_music_pl_chnl
	inc	sp
;menus.c:556: NR10_REG = 0x00;
	ld	a, #0x00
	ldh	(_NR10_REG+0),a
;menus.c:557: NR11_REG = 0xC9;
	ld	a, #0xc9
	ldh	(_NR11_REG+0),a
;menus.c:558: NR12_REG = 0xF2;
	ld	a, #0xf2
	ldh	(_NR12_REG+0),a
;menus.c:559: NR13_REG = 0x9F;
	ld	a, #0x9f
	ldh	(_NR13_REG+0),a
;menus.c:560: NR14_REG = 0x86;
	ld	a, #0x86
	ldh	(_NR14_REG+0),a
;menus.c:561: }
	ret
;menus.c:564: void se_wrong_password() BANKED {
;	---------------------------------
; Function se_wrong_password
; ---------------------------------
	b_se_wrong_password	= 1
_se_wrong_password::
;menus.c:565: mute_music_pl_chnl(0);
	xor	a, a
	push	af
	inc	sp
	call	_mute_music_pl_chnl
	inc	sp
;menus.c:566: NR10_REG = 0x0F;
	ld	a, #0x0f
	ldh	(_NR10_REG+0),a
;menus.c:567: NR11_REG = 0xFF;
	ld	a, #0xff
	ldh	(_NR11_REG+0),a
;menus.c:568: NR12_REG = 0xF2;
	ld	a, #0xf2
	ldh	(_NR12_REG+0),a
;menus.c:569: NR13_REG = 0x53;
	ld	a, #0x53
	ldh	(_NR13_REG+0),a
;menus.c:570: NR14_REG = 0x83;
	ld	a, #0x83
	ldh	(_NR14_REG+0),a
;menus.c:571: }
	ret
;menus.c:574: void se_add_character() BANKED {
;	---------------------------------
; Function se_add_character
; ---------------------------------
	b_se_add_character	= 1
_se_add_character::
;menus.c:575: mute_music_pl_chnl(1);
	ld	a, #0x01
	push	af
	inc	sp
	call	_mute_music_pl_chnl
	inc	sp
;menus.c:576: NR21_REG = 0x41;
	ld	a, #0x41
	ldh	(_NR21_REG+0),a
;menus.c:577: NR22_REG = 0xF2;
	ld	a, #0xf2
	ldh	(_NR22_REG+0),a
;menus.c:578: NR23_REG = 0x36;
	ld	a, #0x36
	ldh	(_NR23_REG+0),a
;menus.c:579: NR24_REG = 0x87;
	ld	a, #0x87
	ldh	(_NR24_REG+0),a
;menus.c:580: }
	ret
;menus.c:583: void se_drop_character() BANKED {
;	---------------------------------
; Function se_drop_character
; ---------------------------------
	b_se_drop_character	= 1
_se_drop_character::
;menus.c:584: mute_music_pl_chnl(3);
	ld	a, #0x03
	push	af
	inc	sp
	call	_mute_music_pl_chnl
	inc	sp
;menus.c:585: NR41_REG = 0x3A;
	ld	a, #0x3a
	ldh	(_NR41_REG+0),a
;menus.c:586: NR42_REG = 0xF3;
	ld	a, #0xf3
	ldh	(_NR42_REG+0),a
;menus.c:587: NR43_REG = 0x11;
	ld	a, #0x11
	ldh	(_NR43_REG+0),a
;menus.c:588: NR44_REG = 0xC0;
	ld	a, #0xc0
	ldh	(_NR44_REG+0),a
;menus.c:589: }
	ret
	.area _CODE_1
	.area _CABS (ABS)
