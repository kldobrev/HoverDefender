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
	.globl _build_road_right
	.globl _scroll_level_bkg
	.globl _move_player
	.globl _init_player
	.globl _init_level_road
	.globl _init_level_bgk
	.globl _get_tile_idx
	.globl _performance_delay
	.globl _set_sprite_data
	.globl _set_bkg_tiles
	.globl _set_bkg_data
	.globl _wait_vbl_done
	.globl _set_interrupts
	.globl _disable_interrupts
	.globl _enable_interrupts
	.globl _joypad
	.globl _add_LCD
	.globl _plspeed
	.globl _pl
	.globl _speedincr
	.globl _cloudposx
	.globl _sceneryposx
	.globl _roadposx
	.globl _citr
	.globl _k
	.globl _j
	.globl _i
	.globl _nextcamtileidx
	.globl _camtileidx
	.globl _roadbuildidx
	.globl _level1road
	.globl _playerspritetiles
	.globl _cloudmap
	.globl _cloudtiles
	.globl _volcaniclvlmap
	.globl _volcaniclvltiles
	.globl _goodroadmap
	.globl _roadtiles
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_roadbuildidx::
	.ds 1
_camtileidx::
	.ds 1
_nextcamtileidx::
	.ds 1
_i::
	.ds 1
_j::
	.ds 1
_k::
	.ds 1
_citr::
	.ds 1
_roadposx::
	.ds 1
_sceneryposx::
	.ds 1
_cloudposx::
	.ds 1
_speedincr::
	.ds 1
_pl::
	.ds 8
_plspeed::
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
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;main.c:25: void performance_delay(UINT8 cycles) {
;	---------------------------------
; Function performance_delay
; ---------------------------------
_performance_delay::
;main.c:26: for(citr = 0; citr < cycles; citr++) {
	ld	hl, #_citr
	ld	(hl), #0x00
00103$:
	ld	a, (#_citr)
	ldhl	sp,	#2
	sub	a, (hl)
	ret	NC
;main.c:27: wait_vbl_done();
	call	_wait_vbl_done
;main.c:26: for(citr = 0; citr < cycles; citr++) {
	ld	hl, #_citr
	inc	(hl)
;main.c:29: }
	jr	00103$
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
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
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
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
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
_goodroadmap:
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
_volcaniclvltiles:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
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
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x05	; 5
	.db #0x06	; 6
	.db #0x04	; 4
	.db #0x07	; 7
	.db #0x05	; 5
	.db #0x06	; 6
	.db #0x09	; 9
	.db #0x0e	; 14
	.db #0x09	; 9
	.db #0x0e	; 14
	.db #0x19	; 25
	.db #0x1e	; 30
	.db #0x30	; 48	'0'
	.db #0x3f	; 63
	.db #0x61	; 97	'a'
	.db #0x7e	; 126
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x06	; 6
	.db #0x01	; 1
	.db #0x05	; 5
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xe0	; 224
	.db #0x60	; 96
	.db #0xa0	; 160
	.db #0xe0	; 224
	.db #0xa0	; 160
	.db #0x60	; 96
	.db #0xa0	; 160
	.db #0x60	; 96
	.db #0xa0	; 160
	.db #0x60	; 96
	.db #0x10	; 16
	.db #0xf0	; 240
	.db #0x90	; 144
	.db #0x70	; 112	'p'
	.db #0x98	; 152
	.db #0x78	; 120	'x'
	.db #0x8c	; 140
	.db #0x7c	; 124
	.db #0x86	; 134
	.db #0x7e	; 126
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf2	; 242
	.db #0x18	; 24
	.db #0xff	; 255
	.db #0x43	; 67	'C'
	.db #0xff	; 255
	.db #0xc4	; 196
	.db #0xff	; 255
	.db #0x10	; 16
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x3d	; 61
	.db #0x00	; 0
	.db #0x00	; 0
_volcaniclvlmap:
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0d	; 13
	.db #0x0f	; 15
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0d	; 13
	.db #0x0f	; 15
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0e	; 14
	.db #0x10	; 16
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0e	; 14
	.db #0x10	; 16
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0d	; 13
	.db #0x0f	; 15
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0d	; 13
	.db #0x0f	; 15
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0e	; 14
	.db #0x10	; 16
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0e	; 14
	.db #0x10	; 16
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0d	; 13
	.db #0x0f	; 15
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0d	; 13
	.db #0x0f	; 15
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0e	; 14
	.db #0x10	; 16
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0e	; 14
	.db #0x10	; 16
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0x11	; 17
_cloudtiles:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
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
	.db #0x00	; 0
	.db #0x4f	; 79	'O'
	.db #0x30	; 48	'0'
	.db #0xfe	; 254
	.db #0x01	; 1
	.db #0xf3	; 243
	.db #0x0c	; 12
	.db #0x9f	; 159
	.db #0x60	; 96
	.db #0xba	; 186
	.db #0x45	; 69	'E'
	.db #0xf6	; 246
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1c	; 28
	.db #0x00	; 0
	.db #0xf2	; 242
	.db #0x0c	; 12
	.db #0x7f	; 127
	.db #0x80	; 128
	.db #0xcf	; 207
	.db #0x30	; 48	'0'
	.db #0xf9	; 249
	.db #0x06	; 6
	.db #0x5d	; 93
	.db #0xa2	; 162
	.db #0x6f	; 111	'o'
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x2c	; 44
	.db #0x12	; 18
	.db #0x67	; 103	'g'
	.db #0x18	; 24
	.db #0x7c	; 124
	.db #0x03	; 3
	.db #0x57	; 87	'W'
	.db #0x28	; 40
	.db #0xf3	; 243
	.db #0x0c	; 12
	.db #0x26	; 38
	.db #0x40	; 64
	.db #0x22	; 34
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc8	; 200
	.db #0x10	; 16
	.db #0x38	; 56	'8'
	.db #0xc0	; 192
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x5c	; 92
	.db #0x20	; 32
	.db #0x14	; 20
	.db #0x08	; 8
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x13	; 19
	.db #0x08	; 8
	.db #0x1c	; 28
	.db #0x03	; 3
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3a	; 58
	.db #0x04	; 4
	.db #0x28	; 40
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x28	; 40
	.db #0x90	; 144
	.db #0x0c	; 12
	.db #0x00	; 0
	.db #0x66	; 102	'f'
	.db #0x00	; 0
	.db #0xbc	; 188
	.db #0x42	; 66	'B'
	.db #0x20	; 32
	.db #0x10	; 16
	.db #0x42	; 66	'B'
	.db #0x8c	; 140
	.db #0x10	; 16
	.db #0x08	; 8
_cloudmap:
	.db #0x06	; 6
	.db #0x07	; 7
	.db #0x0b	; 11
	.db #0x08	; 8
	.db #0x0b	; 11
	.db #0x06	; 6
	.db #0x07	; 7
	.db #0x0b	; 11
	.db #0x08	; 8
	.db #0x0a	; 10
	.db #0x0b	; 11
	.db #0x08	; 8
	.db #0x07	; 7
	.db #0x08	; 8
	.db #0x07	; 7
	.db #0x09	; 9
	.db #0x0a	; 10
	.db #0x07	; 7
	.db #0x06	; 6
	.db #0x06	; 6
_playerspritetiles:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x03	; 3
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
_level1road:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
;main.c:32: UINT8 get_tile_idx(UINT8 newidxnum) {   // Recalculate tile index according to the VRAM tile limit
;	---------------------------------
; Function get_tile_idx
; ---------------------------------
_get_tile_idx::
;main.c:33: return newidxnum > 31 ? newidxnum - 32 : newidxnum;
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
;main.c:34: }
	ret
;main.c:37: void init_level_bgk(const unsigned char * lvltiles, const unsigned char * lvlmap) {
;	---------------------------------
; Function init_level_bgk
; ---------------------------------
_init_level_bgk::
;main.c:38: set_bkg_data(5, 7, cloudtiles);
	ld	hl, #_cloudtiles
	push	hl
	ld	de, #0x0705
	push	de
	call	_set_bkg_data
	add	sp, #4
;main.c:39: set_bkg_tiles(0, 0, 20, 1, cloudmap);
	ld	bc, #_cloudmap+0
	push	bc
	ld	de, #0x0114
	push	de
	xor	a, a
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_set_bkg_tiles
	add	sp, #6
;main.c:40: set_bkg_tiles(20, 0, 20, 1, cloudmap);
	push	bc
	ld	de, #0x0114
	push	de
	xor	a, a
	ld	d,a
	ld	e,#0x14
	push	de
	call	_set_bkg_tiles
	add	sp, #6
;main.c:41: set_bkg_data(12, 6, lvltiles);
	pop	bc
	pop	hl
	push	hl
	push	bc
	push	hl
	ld	de, #0x060c
	push	de
	call	_set_bkg_data
	add	sp, #4
;main.c:42: set_bkg_tiles(0, 1, 20, 9, lvlmap);
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ld	de, #0x0914
	push	de
	ld	a, #0x01
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_set_bkg_tiles
	add	sp, #6
;main.c:43: set_bkg_tiles(20, 1, 20, 9, lvlmap);
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ld	de, #0x0914
	push	de
	ld	de, #0x0114
	push	de
	call	_set_bkg_tiles
	add	sp, #6
;main.c:44: }
	ret
;main.c:46: void init_level_road() {
;	---------------------------------
; Function init_level_road
; ---------------------------------
_init_level_road::
;main.c:47: set_bkg_data(0, 5, roadtiles);
	ld	hl, #_roadtiles
	push	hl
	ld	a, #0x05
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_set_bkg_data
	add	sp, #4
;main.c:48: for(roadbuildidx = 0; roadbuildidx < 7; roadbuildidx++) {
	ld	hl, #_roadbuildidx
	ld	(hl), #0x00
00102$:
;main.c:49: set_bkg_tiles(roadbuildidx * 3, 10, 3, 7, goodroadmap);
	ld	bc, #_goodroadmap
	ld	hl, #_roadbuildidx
	ld	a, (hl)
	ld	e, a
	add	a, a
	add	a, e
	push	bc
	ld	h, #0x07
	push	hl
	inc	sp
	ld	h, #0x03
	push	hl
	inc	sp
	ld	h, #0x0a
	push	hl
	inc	sp
	push	af
	inc	sp
	call	_set_bkg_tiles
	add	sp, #6
;main.c:48: for(roadbuildidx = 0; roadbuildidx < 7; roadbuildidx++) {
	ld	hl, #_roadbuildidx
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x07
	jr	C, 00102$
;main.c:51: camtileidx = 18;
	ld	hl, #_camtileidx
	ld	(hl), #0x12
;main.c:52: nextcamtileidx = camtileidx + 3;
	ld	hl, #_nextcamtileidx
	ld	(hl), #0x15
;main.c:53: }
	ret
;main.c:56: void init_player() {
;	---------------------------------
; Function init_player
; ---------------------------------
_init_player::
;main.c:57: pl.lives = 3;
	ld	hl, #_pl
	ld	(hl), #0x03
;main.c:58: pl.shield = 3;
	ld	hl, #(_pl + 0x0001)
	ld	(hl), #0x03
;main.c:59: pl.x = 16;
	ld	hl, #(_pl + 0x0006)
	ld	(hl), #0x10
;main.c:60: pl.y = 114;
	ld	hl, #(_pl + 0x0007)
	ld	(hl), #0x72
;main.c:62: set_sprite_data(0, 4, playerspritetiles);
	ld	hl, #_playerspritetiles
	push	hl
	ld	a, #0x04
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_set_sprite_data
	add	sp, #4
;C:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1145: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 0x0002)
	ld	(hl), #0x00
;main.c:64: pl.spritetiles[0] = 0;
	ld	hl, #(_pl + 0x0002)
	ld	(hl), #0x00
;C:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1145: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 0x0006)
	ld	(hl), #0x02
;main.c:66: pl.spritetiles[1] = 1;
	ld	hl, #(_pl + 0x0003)
	ld	(hl), #0x01
;C:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1145: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 0x000a)
	ld	(hl), #0x01
;main.c:68: pl.spritetiles[2] = 2;
	ld	hl, #(_pl + 0x0004)
	ld	(hl), #0x02
;C:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1145: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 0x000e)
	ld	(hl), #0x03
;main.c:70: pl.spritetiles[3] = 3;
	ld	hl, #(_pl + 0x0005)
	ld	(hl), #0x03
;main.c:72: move_sprite(0, pl.x, pl.y);
	ld	hl, #(_pl + 0x0007)
	ld	b, (hl)
	ld	hl, #(_pl + 0x0006)
	ld	c, (hl)
;C:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1218: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #_shadow_OAM
;C:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1219: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;main.c:73: move_sprite(1, pl.x + 8, pl.y);
	ld	hl, #(_pl + 0x0007)
	ld	b, (hl)
	ld	a, (#(_pl + 0x0006) + 0)
	add	a, #0x08
	ld	c, a
;C:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1218: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 0x0004)
;C:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1219: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;main.c:74: move_sprite(2, pl.x, pl.y + 8);
	ld	a, (#(_pl + 0x0007) + 0)
	add	a, #0x08
	ld	b, a
	ld	hl, #(_pl + 0x0006)
	ld	c, (hl)
;C:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1218: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 0x0008)
;C:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1219: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;main.c:75: move_sprite(3, pl.x + 8, pl.y + 8);
	ld	a, (#(_pl + 0x0007) + 0)
	add	a, #0x08
	ld	b, a
	ld	a, (#(_pl + 0x0006) + 0)
	add	a, #0x08
	ld	c, a
;C:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1218: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 0x000c)
;C:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1219: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;main.c:75: move_sprite(3, pl.x + 8, pl.y + 8);
;main.c:76: }
	ret
;main.c:79: void move_player(INT8 speedx, INT8 speedy) {
;	---------------------------------
; Function move_player
; ---------------------------------
_move_player::
	dec	sp
;main.c:80: pl.x += speedx;
	ld	a, (#(_pl + 0x0006) + 0)
	ldhl	sp,	#3
	add	a, (hl)
	ld	(#(_pl + 0x0006)),a
;main.c:81: pl.y += speedy;
	ld	a, (#(_pl + 0x0007) + 0)
	ldhl	sp,	#4
	add	a, (hl)
	ld	(#(_pl + 0x0007)),a
;main.c:83: move_sprite(pl.spritetiles[0], pl.x, pl.y);
	ld	hl, #(_pl + 0x0007)
	ld	c, (hl)
	ld	a, (#(_pl + 0x0006) + 0)
	ldhl	sp,	#0
	ld	(hl), a
	ld	hl, #_pl + 2
	ld	e, (hl)
;C:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1218: OAM_item_t * itm = &shadow_OAM[nb];
	xor	a, a
	ld	l, e
	ld	h, a
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
;C:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1219: itm->y=y, itm->x=x;
	ld	a, c
	ld	(hl+), a
	ld	c, l
	ld	b, h
	ldhl	sp,	#0
	ld	a, (hl)
	ld	(bc), a
;main.c:84: move_sprite(pl.spritetiles[1], pl.x + 8, pl.y);
	ld	hl, #(_pl + 0x0007)
	ld	b, (hl)
	ld	a, (#(_pl + 0x0006) + 0)
	add	a, #0x08
	ld	c, a
	ld	hl, #_pl + 3
	ld	e, (hl)
;C:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1218: OAM_item_t * itm = &shadow_OAM[nb];
	ld	d, #0x00
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
;C:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1219: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;main.c:85: move_sprite(pl.spritetiles[2], pl.x, pl.y + 8);
	ld	a, (#(_pl + 0x0007) + 0)
	add	a, #0x08
	ld	b, a
	ld	hl, #(_pl + 0x0006)
	ld	c, (hl)
	ld	hl, #_pl + 4
	ld	e, (hl)
;C:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1218: OAM_item_t * itm = &shadow_OAM[nb];
	ld	d, #0x00
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
;C:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1219: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;main.c:86: move_sprite(pl.spritetiles[3], pl.x + 8, pl.y + 8);
	ld	a, (#(_pl + 0x0007) + 0)
	add	a, #0x08
	ld	b, a
	ld	a, (#(_pl + 0x0006) + 0)
	add	a, #0x08
	ld	c, a
	ld	hl, #_pl + 5
	ld	e, (hl)
;C:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1218: OAM_item_t * itm = &shadow_OAM[nb];
	ld	d, #0x00
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
;C:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:1219: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;main.c:86: move_sprite(pl.spritetiles[3], pl.x + 8, pl.y + 8);
;main.c:87: }
	inc	sp
	ret
;main.c:90: void scroll_level_bkg() {
;	---------------------------------
; Function scroll_level_bkg
; ---------------------------------
_scroll_level_bkg::
;main.c:91: switch(LYC_REG) {
	ldh	a, (_LYC_REG+0)
	or	a, a
	jr	Z, 00101$
	cp	a, #0x08
	jr	Z, 00102$
	sub	a, #0x50
	jr	Z, 00103$
	ret
;main.c:92: case 0x00:
00101$:
;main.c:93: move_bkg(cloudposx, 0);
	ld	a, (#_cloudposx)
	ldh	(_SCX_REG+0),a
;C:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:826: SCX_REG=x, SCY_REG=y;
	ld	a, #0x00
	ldh	(_SCY_REG+0),a
;main.c:94: LYC_REG = 0x08;
	ld	a, #0x08
	ldh	(_LYC_REG+0),a
;main.c:95: break;
	ret
;main.c:96: case 0x08:
00102$:
;main.c:97: move_bkg(sceneryposx, 0);
	ld	a, (#_sceneryposx)
	ldh	(_SCX_REG+0),a
;C:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:826: SCX_REG=x, SCY_REG=y;
	ld	a, #0x00
	ldh	(_SCY_REG+0),a
;main.c:98: LYC_REG = 0x50;
	ld	a, #0x50
	ldh	(_LYC_REG+0),a
;main.c:99: break;
	ret
;main.c:100: case 0x50:
00103$:
;main.c:101: move_bkg(roadposx, 0);
	ld	a, (#_roadposx)
	ldh	(_SCX_REG+0),a
;C:/Game_Boy_Dev_Tools/gbdk/include/gb/gb.h:826: SCX_REG=x, SCY_REG=y;
	ld	a, #0x00
	ldh	(_SCY_REG+0),a
;main.c:102: LYC_REG = 0x00;
	ld	a, #0x00
	ldh	(_LYC_REG+0),a
;main.c:104: }
;main.c:105: }
	ret
;main.c:108: void build_road_right() {   // Automatically builds the road ahead while scrolling the stage
;	---------------------------------
; Function build_road_right
; ---------------------------------
_build_road_right::
;main.c:109: camtileidx = get_tile_idx((SCX_REG + 168) / 8); // Probably needs a check for high values
	ldh	a, (_SCX_REG+0)
	ld	b, #0x00
	add	a, #0xa8
	ld	c, a
	jr	NC, 00116$
	inc	b
00116$:
	ld	l, c
	ld	h, b
	bit	7, b
	jr	Z, 00105$
	ld	hl, #0x0007
	add	hl, bc
00105$:
	sra	h
	rr	l
	sra	h
	rr	l
	sra	h
	rr	l
	ld	a, l
	push	af
	inc	sp
	call	_get_tile_idx
	inc	sp
	ld	hl, #_camtileidx
	ld	(hl), e
;main.c:110: if(camtileidx == nextcamtileidx) {
	ld	a, (hl)
	ld	hl, #_nextcamtileidx
	sub	a, (hl)
	ret	NZ
;main.c:111: set_bkg_tiles(camtileidx, 10, 3, 7, goodroadmap);
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
;main.c:112: roadbuildidx++;
	ld	hl, #_roadbuildidx
	inc	(hl)
;main.c:113: nextcamtileidx = get_tile_idx(camtileidx + 3);
	ld	a, (#_camtileidx)
	add	a, #0x03
	push	af
	inc	sp
	call	_get_tile_idx
	inc	sp
	ld	hl, #_nextcamtileidx
	ld	(hl), e
;main.c:115: }
	ret
;main.c:117: void main() {
;	---------------------------------
; Function main
; ---------------------------------
_main::
;main.c:119: roadposx = sceneryposx = cloudposx = 0;
	ld	hl, #_cloudposx
	ld	(hl), #0x00
	ld	hl, #_sceneryposx
	ld	(hl), #0x00
	ld	hl, #_roadposx
	ld	(hl), #0x00
;main.c:120: speedincr = 1;
	ld	hl, #_speedincr
	ld	(hl), #0x01
;main.c:121: plspeed = 2;
	ld	hl, #_plspeed
	ld	(hl), #0x02
;main.c:123: DISPLAY_ON;
	ldh	a, (_LCDC_REG+0)
	or	a, #0x80
	ldh	(_LCDC_REG+0),a
;main.c:124: SHOW_BKG;
	ldh	a, (_LCDC_REG+0)
	or	a, #0x01
	ldh	(_LCDC_REG+0),a
;main.c:125: SHOW_SPRITES;
	ldh	a, (_LCDC_REG+0)
	or	a, #0x02
	ldh	(_LCDC_REG+0),a
;main.c:127: init_level_road();
	call	_init_level_road
;main.c:128: init_level_bgk(volcaniclvltiles, volcaniclvlmap);
	ld	hl, #_volcaniclvlmap
	push	hl
	ld	hl, #_volcaniclvltiles
	push	hl
	call	_init_level_bgk
	add	sp, #4
;main.c:130: STAT_REG = 0x45;
	ld	a, #0x45
	ldh	(_STAT_REG+0),a
;main.c:131: LYC_REG = 0x00;
	ld	a, #0x00
	ldh	(_LYC_REG+0),a
;main.c:133: disable_interrupts();
	call	_disable_interrupts
;main.c:134: add_LCD(scroll_level_bkg);
	ld	hl, #_scroll_level_bkg
	push	hl
	call	_add_LCD
	add	sp, #2
;main.c:135: enable_interrupts();
	call	_enable_interrupts
;main.c:137: set_interrupts(VBL_IFLAG | LCD_IFLAG);
	ld	a, #0x03
	push	af
	inc	sp
	call	_set_interrupts
	inc	sp
;main.c:139: init_player();
	call	_init_player
;main.c:141: while(1) {
00110$:
;main.c:143: build_road_right();
	call	_build_road_right
;main.c:144: cloudposx += speedincr - 1;
	ld	hl, #_speedincr
	ld	c, (hl)
	ld	a, c
	dec	a
	ld	hl, #_cloudposx
	ld	b, (hl)
	add	a, b
	ld	(hl), a
;main.c:145: sceneryposx += speedincr + 1;
	ld	a, c
	inc	a
	ld	hl, #_sceneryposx
	ld	b, (hl)
	add	a, b
	ld	(hl), a
;main.c:146: roadposx += speedincr + 3;
	inc	c
	inc	c
	inc	c
	ld	hl, #_roadposx
	ld	a, (hl)
	add	a, c
	ld	(hl), a
;main.c:148: if(joypad() & J_LEFT) {
	call	_joypad
	bit	1, e
	jr	Z, 00102$
;main.c:149: move_player(-plspeed, 0);
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
00102$:
;main.c:151: if(joypad() & J_RIGHT) {
	call	_joypad
	ld	a, e
	rrca
	jr	NC, 00104$
;main.c:152: move_player(plspeed, 0);
	xor	a, a
	push	af
	inc	sp
	ld	a, (#_plspeed)
	push	af
	inc	sp
	call	_move_player
	add	sp, #2
00104$:
;main.c:154: if(joypad() & J_UP) {
	call	_joypad
	bit	2, e
	jr	Z, 00106$
;main.c:155: move_player(0, -plspeed);
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
00106$:
;main.c:157: if(joypad() & J_DOWN) {
	call	_joypad
	bit	3, e
	jr	Z, 00108$
;main.c:158: move_player(0, plspeed);
	ld	a, (#_plspeed)
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_move_player
	add	sp, #2
00108$:
;main.c:161: wait_vbl_done();
	call	_wait_vbl_done
;main.c:164: }
	jr	00110$
	.area _CODE
	.area _CABS (ABS)
