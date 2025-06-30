;	map(0x1000, 0x1000).mirror(0x007f).w("watchdog", FUNC(watchdog_timer_device::reset_w));       /* AFE */
;	map(0x1080, 0x1087).mirror(0x0078).w(m_mainlatch, FUNC(ls259_device::write_d0));
;	map(0x1100, 0x1100).mirror(0x007f).w("soundlatch", FUNC(generic_latch_8_device::write));  /* 32 */
;	map(0x1200, 0x1200).mirror(0x007f).portr("DSW2");
;	map(0x1280, 0x1280).mirror(0x007c).portr("SYSTEM");
;	map(0x1281, 0x1281).mirror(0x007c).portr("IN0");
;	map(0x1282, 0x1282).mirror(0x007c).portr("IN1");
;	map(0x1283, 0x1283).mirror(0x007c).portr("DSW1");
;	/* not used according to schems: map(0x1300, 0x1300).mirror(0x007f).portr("DSW3"); */
;	map(0x1800, 0x183f).ram().share(m_spriteram2);
;	map(0x1840, 0x185f).ram().share(m_scroll);
;	map(0x1860, 0x1bff).ram();
;	map(0x1c00, 0x1c3f).ram().share(m_spriteram);
;	map(0x1c40, 0x1c5f).ram().share(m_scroll2);
;	map(0x1c60, 0x1fff).ram();
;	map(0x2800, 0x2fff).ram().share("nvram");
;	map(0x3000, 0x37ff).ram().w(FUNC(trackfld_state::trackfld_videoram_w)).share(m_videoram);
;	map(0x3800, 0x3fff).ram().w(FUNC(trackfld_state::trackfld_colorram_w)).share(m_colorram);
;	map(0x6000, 0xffff).rom();

;	mainlatch.q_out_cb<0>().set(FUNC(trackfld_state::flip_screen_set));
;	mainlatch.q_out_cb<1>().set("trackfld_audio", FUNC(trackfld_audio_device::sh_irqtrigger_w));
;	mainlatch.q_out_cb<2>().set(FUNC(trackfld_state::nmi_mask_w));
;	mainlatch.q_out_cb<3>().set(FUNC(trackfld_state::coin_counter_1_w));
;	mainlatch.q_out_cb<4>().set(FUNC(trackfld_state::coin_counter_2_w));
;	mainlatch.q_out_cb<5>().set_nop();
;	mainlatch.q_out_cb<6>().set_nop();
;	mainlatch.q_out_cb<7>().set(FUNC(trackfld_state::irq_mask_w));
	

;	PORT_START("SYSTEM")
;	PORT_BIT( 0x01, IP_ACTIVE_LOW, IPT_COIN1 )
;	PORT_BIT( 0x02, IP_ACTIVE_LOW, IPT_COIN2 )
;	PORT_BIT( 0x04, IP_ACTIVE_LOW, IPT_SERVICE1 )
;	PORT_BIT( 0x08, IP_ACTIVE_LOW, IPT_START1 )
;	PORT_BIT( 0x10, IP_ACTIVE_LOW, IPT_START2 )
;	PORT_BIT( 0x20, IP_ACTIVE_LOW, IPT_UNKNOWN )
;	PORT_BIT( 0x40, IP_ACTIVE_LOW, IPT_UNKNOWN )
;	PORT_BIT( 0x80, IP_ACTIVE_LOW, IPT_UNKNOWN )
;
;	PORT_START("IN0")
;	PORT_BIT( 0x01, IP_ACTIVE_LOW, IPT_BUTTON3 ) PORT_PLAYER(1)
;	PORT_BIT( 0x02, IP_ACTIVE_LOW, IPT_BUTTON2 ) PORT_PLAYER(1)
;	PORT_BIT( 0x04, IP_ACTIVE_LOW, IPT_BUTTON1 ) PORT_PLAYER(1)
;	PORT_BIT( 0x08, IP_ACTIVE_LOW, IPT_START3 )
;	PORT_BIT( 0x10, IP_ACTIVE_LOW, IPT_BUTTON3 ) PORT_PLAYER(2)
;	PORT_BIT( 0x20, IP_ACTIVE_LOW, IPT_BUTTON2 ) PORT_PLAYER(2)
;	PORT_BIT( 0x40, IP_ACTIVE_LOW, IPT_BUTTON1 ) PORT_PLAYER(2)
;	PORT_BIT( 0x80, IP_ACTIVE_LOW, IPT_UNKNOWN )
;
;	PORT_START("IN1")
;	PORT_BIT( 0x01, IP_ACTIVE_LOW, IPT_BUTTON3  ) PORT_PLAYER(3) //PORT_COCKTAIL
;	PORT_BIT( 0x02, IP_ACTIVE_LOW, IPT_BUTTON2  ) PORT_PLAYER(3) //PORT_COCKTAIL
;	PORT_BIT( 0x04, IP_ACTIVE_LOW, IPT_BUTTON1  ) PORT_PLAYER(3) //PORT_COCKTAIL
;	PORT_BIT( 0x08, IP_ACTIVE_LOW, IPT_START4 )
;	PORT_BIT( 0x10, IP_ACTIVE_LOW, IPT_BUTTON3  ) PORT_PLAYER(4) //PORT_COCKTAIL
;	PORT_BIT( 0x20, IP_ACTIVE_LOW, IPT_BUTTON2  ) PORT_PLAYER(4) //PORT_COCKTAIL
;	PORT_BIT( 0x40, IP_ACTIVE_LOW, IPT_BUTTON1  ) PORT_PLAYER(4) //PORT_COCKTAIL
;	PORT_BIT( 0x80, IP_ACTIVE_LOW, IPT_UNKNOWN )
;
;	PORT_START("DSW1")
;	KONAMI_COINAGE_LOC(DEF_STR( Free_Play ), "No Coin B", SW1)
;	/* "No Coin B" = coins produce sound, but no effect on coin counter */
;
;	PORT_START("DSW2")
;	PORT_DIPNAME( 0x01, 0x01, DEF_STR( Lives ) )        PORT_DIPLOCATION("SW2:1")
;	PORT_DIPSETTING(    0x01, "1" )
;	PORT_DIPSETTING(    0x00, "2" )
;	PORT_DIPNAME( 0x02, 0x00, "After Last Event" )      PORT_DIPLOCATION("SW2:2")
;	PORT_DIPSETTING(    0x02, "Game Over" )
;	PORT_DIPSETTING(    0x00, "Game Continues" )
;	PORT_DIPNAME( 0x04, 0x00, DEF_STR( Cabinet ) )      PORT_DIPLOCATION("SW2:3")
;	PORT_DIPSETTING(    0x00, DEF_STR( Upright ) )
;	PORT_DIPSETTING(    0x04, DEF_STR( Cocktail ) )
;	PORT_DIPNAME( 0x08, 0x08, DEF_STR( Bonus_Life ) )   PORT_DIPLOCATION("SW2:4")
;	PORT_DIPSETTING(    0x08, DEF_STR( None ) )
;	PORT_DIPSETTING(    0x00, "100000" )
;	PORT_DIPNAME( 0x10, 0x10, "World Records" )         PORT_DIPLOCATION("SW2:5")
;	PORT_DIPSETTING(    0x10, "Don't Erase" )
;	PORT_DIPSETTING(    0x00, "Erase on Reset" )
;	PORT_DIPNAME( 0x60, 0x40, DEF_STR( Difficulty ) )   PORT_DIPLOCATION("SW2:6,7")
;	PORT_DIPSETTING(    0x60, DEF_STR( Easy ) )
;	PORT_DIPSETTING(    0x40, DEF_STR( Normal ) )
;	PORT_DIPSETTING(    0x20, DEF_STR( Hard ) )
;	PORT_DIPSETTING(    0x00, DEF_STR( Difficult ) )
;	PORT_DIPNAME( 0x80, 0x00, DEF_STR( Demo_Sounds ) )  PORT_DIPLOCATION("SW2:8")
;	PORT_DIPSETTING(    0x80, DEF_STR( Off ) )
;	PORT_DIPSETTING(    0x00, DEF_STR( On ) )


* page $28xx
global_state_00 = $00
boot_state_03 = $03
event_pointer_18 = $18
event_pointer_1a = $1a
copy_of_screen_flipped_21 = $21
number_of_credits_23 = $23
dsw1_copy_2c = $2c
dsw2_copy_2d = $2d
difficulty_2f = $2f
copy_of_inputs_30 = $30
copy_of_inputs_31 = $31
copy_of_inputs_32 = $32
hammer_speed_38 = $38
nb_objects_48 = $48
nb_players_minus_one_60 = $60
chrono_hundredth_second_7e = $7e
chrono_second_7f = $7f
p1_attempts_left_81 = $81
p2_attempts_left_a1 = $A1
p3_attempts_left_c1 = $C1
p4_attempts_left_e1 = max_accepted_faults_e1
current_level_84 = $84
high_jump_fault_9f = $9F
jump_foul_c9 = $c9
player_is_qualified_cd = $cd
angle_d8 = $d8
false_start_d9 = $d9
max_accepted_faults_e1 = $e1
display_chrono_ea = $ea
current_level_backup_f5 = $f5

* memory offsets
watchdog_1000 = $1000
flip_screen_set_1080 = $1080
sh_irqtrigger_w_1081 = $1081
nmi_mask_w_1082 = $1082
coin_counter_1_w_1083 = $1083
coin_counter_1_w_1084 = $1084
irq_mask_w_1087 = $1087
audio_register_w_1100 = $1100
dsw2_1200 = $1200
system_1280 = $1280
in0_1281 = $1281
in1_1282 = $1282
dsw1_1283 = $1283
sprite_ram_1800 = $1800
scroll_registers_1840 = $1840
copy_of_inputs_2830 = $2830
current_attempted_height_metre_286a = $286a
current_attempt_height_286b = $286b
current_attempted_height_centimetres_286c = $286c
failed_rom_check_2a8e = $2a8e
scroll_offsets_2af0 = $2af0
event_buffer_2900 = $2900
failed_rom_check_29d4 = $29d4
display_state_2b40 = $2b40
video_ram_3000 = $3000
color_ram_3800 = $3800
player_1_final_time_2960 = $2960		; dash/hurdles
player_2_final_time_296c = $296C		; dash/hurdles
qualifying_value_2866 = $2866
chrono_hundredth_second_287e = $287e

qualifying_values_aaf3 = $aaf3
high_jump_attempted_heights_edea = $edea

; the [xxx] tags are there to help the specific game post-processing to automatically
; change or remove the code. For instance [rom_check_code] lines can be removed without
; changing the game logic

reset_6000:
6000: 7F 10 87       CLR    irq_mask_w_1087				; disable interrupts
6003: 10 CE 1F 80    LDS    #$1F80				; set stack
6007: 86 28          LDA    #$28
6009: 1F 8B          TFR    A,DP				; set direct page to nvram
600B: 7F 10 80       CLR    flip_screen_set_1080				; no flip screen
600E: 5F             CLRB
600F: B7 10 00       STA    watchdog_1000
6012: 5A             DECB
6013: 26 FA          BNE    $600F
6015: 8E 28 00       LDX    #$2800				; clear NVRAM
6018: 6F 80          CLR    ,X+
601A: B7 10 00       STA    watchdog_1000
601D: 8C 2C 00       CMPX   #$2C00
6020: 26 F6          BNE    $6018
6022: 8E 2F E8       LDX    #$2FE8
6025: 6F 80          CLR    ,X+
6027: 8C 2F EE       CMPX   #$2FEE
602A: 26 F9          BNE    $6025
602C: 8E 2F F0       LDX    #$2FF0
602F: 6F 80          CLR    ,X+
6031: 8C 2F FE       CMPX   #$2FFE
6034: 26 F9          BNE    $602F
6036: 6F 84          CLR    ,X
6038: B6 2F FF       LDA    $2FFF
603B: 84 C0          ANDA   #$C0
603D: B7 2F FF       STA    $2FFF
6040: 8E 30 00       LDX    #video_ram_3000		; clear screen: 0x1E char, with 0 clut attribute
6043: 86 1E          LDA    #$1E
6045: 5F             CLRB
6046: E7 89 08 00    STB    $0800,X				; [video_address]
604A: A7 80          STA    ,X+				    ; [video_address]
604C: B7 10 00       STA    watchdog_1000
604F: 8C 38 00       CMPX   #color_ram_3800
6052: 26 F2          BNE    $6046
6054: 8E 18 00       LDX    #sprite_ram_1800		; clear sprites
6057: 6F 80          CLR    ,X+
6059: B7 10 00       STA    watchdog_1000
605C: 8C 20 00       CMPX   #$2000
605F: 26 F6          BNE    $6057
6061: 8E 29 00       LDX    #event_buffer_2900		; event buffer: no events
6064: CC FF FF       LDD    #$FFFF
6067: ED 81          STD    ,X++
6069: 8C 29 40       CMPX   #event_buffer_2900+$40
606C: 26 F9          BNE    $6067
606E: 8E 29 00       LDX    #event_buffer_2900
6071: 9F 18          STX    event_pointer_18			; copy contents of 2900 in 2818,281A
6073: 9F 1A          STX    event_pointer_1a
6075: 8E 29 40       LDX    #event_buffer_2900+$40		; copy contents of 2940 in 281C,281E
6078: 9F 1C          STX    $1C
607A: 9F 1E          STX    $1E
607C: 7F 10 80       CLR    flip_screen_set_1080		; no flip screen
607F: 7F 10 82       CLR    nmi_mask_w_1082		; nmi mask?
6082: B6 12 83       LDA    dsw1_1283
6085: 43             COMA				; negative logic
6086: 97 2C          STA    dsw1_copy_2c			; copy dip switch 1 in 282C
6088: B6 12 00       LDA    dsw2_1200
608B: 43             COMA
608C: 97 2D          STA    dsw2_copy_2d			; copy dip switch 2 in 282D
608E: 84 60          ANDA   #$60
6090: 44             LSRA
6091: 44             LSRA
6092: 44             LSRA
6093: 44             LSRA
6094: 44             LSRA
6095: 97 2F          STA    difficulty_2f
6097: 96 2C          LDA    dsw1_copy_2c
6099: 84 0F          ANDA   #$0F
609B: 48             ASLA
609C: 8E A4 3B       LDX    #$A43B
609F: EC 86          LDD    A,X
60A1: DD 28          STD    $28
60A3: 96 2C          LDA    dsw1_copy_2c
60A5: 84 F0          ANDA   #$F0
60A7: 44             LSRA
60A8: 44             LSRA
60A9: 44             LSRA
60AA: 8E A4 5B       LDX    #$A45B
60AD: EC 86          LDD    A,X
60AF: DD 2A          STD    $2A
60B1: B6 2F E7       LDA    $2FE7
60B4: 81 28          CMPA   #$28
60B6: 26 0E          BNE    $60C6
60B8: B6 2F EE       LDA    $2FEE
60BB: 81 74          CMPA   #$74
60BD: 26 07          BNE    $60C6
60BF: B6 2F EF       LDA    $2FEF
60C2: 81 EA          CMPA   #$EA
60C4: 27 28          BEQ    $60EE
60C6: B6 2F E7       LDA    $2FE7
60C9: 81 19          CMPA   #$19
60CB: 26 0E          BNE    $60DB
60CD: B6 2F EE       LDA    $2FEE
60D0: 81 65          CMPA   #$65
60D2: 26 07          BNE    $60DB
60D4: B6 2F EF       LDA    $2FEF
60D7: 81 DB          CMPA   #$DB
60D9: 27 13          BEQ    $60EE
60DB: 4F             CLRA
60DC: 5F             CLRB
60DD: FD 2F E0       STD    $2FE0
60E0: FD 2F E4       STD    $2FE4
60E3: 86 28          LDA    #$28
60E5: B7 2F E7       STA    $2FE7
60E8: CC 74 EA       LDD    #$74EA
60EB: FD 2F EE       STD    $2FEE
60EE: 86 64          LDA    #$64
60F0: 97 48          STA    nb_objects_48
60F2: CC 00 00       LDD    #$0000
60F5: 8E 2E B4       LDX    #$2EB4
60F8: ED 81          STD    ,X++
60FA: A7 80          STA    ,X+
60FC: 0A 48          DEC    nb_objects_48
60FE: 26 F8          BNE    $60F8
6100: B6 12 00       LDA    dsw2_1200
6103: 43             COMA
6104: 84 10          ANDA   #$10
6106: 10 27 00 4F    LBEQ   $6159
610A: 8E 2C 00       LDX    #$2C00
610D: CE A4 7B       LDU    #$A47B
6110: 86 06          LDA    #$06
6112: 97 40          STA    $40
6114: 86 03          LDA    #$03
6116: 97 41          STA    $41
6118: 86 15          LDA    #$15
611A: 97 42          STA    $42
611C: 86 03          LDA    #$03
611E: 97 43          STA    $43
6120: EC C1          LDD    ,U++
6122: ED 81          STD    ,X++
6124: EC C1          LDD    ,U++
6126: ED 81          STD    ,X++
6128: 96 42          LDA    $42
612A: A7 80          STA    ,X+
612C: A7 80          STA    ,X+
612E: A7 81          STA    ,X++
6130: B7 10 00       STA    watchdog_1000
6133: 0A 41          DEC    $41
6135: 0C 42          INC    $42
6137: 0A 43          DEC    $43
6139: 26 E5          BNE    $6120
613B: 30 08          LEAX   $8,X
613D: 0A 40          DEC    $40
613F: 26 D3          BNE    $6114
6141: 86 64          LDA    #$64
6143: 97 48          STA    nb_objects_48
6145: 10 8E A4 C3    LDY    #$A4C3
6149: EC A1          LDD    ,Y++
614B: ED 81          STD    ,X++
614D: EC A1          LDD    ,Y++
614F: ED 81          STD    ,X++
6151: A6 A4          LDA    ,Y
6153: A7 80          STA    ,X+
6155: 0A 48          DEC    nb_objects_48
6157: 26 EC          BNE    $6145
6159: 86 01          LDA    #$01
615B: B7 10 87       STA    irq_mask_w_1087
615E: 1C EF          ANDCC  #$EF
master_mainloop_6160:
6160: 9E 1A          LDX    event_pointer_1a
6162: EC 84          LDD    ,X					; load command and argument
6164: 48             ASLA
6165: 25 F9          BCS    master_mainloop_6160
6167: 10 8E FF FF    LDY    #$FFFF
616B: 10 AF 81       STY    ,X++			; ack event
616E: 8C 29 40       CMPX   #event_buffer_2900+$40
6171: 26 03          BNE    $6176
6173: 8E 29 00       LDX    #event_buffer_2900	; wrap
6176: 9F 1A          STX    event_pointer_1a
6178: 8E A4 1F       LDX    #event_table_a41f	; B is the parameter
617B: AD 96          JSR    [A,X]		; [jump_table]
617D: 20 E1          BRA    master_mainloop_6160

reset_display_617f:
617F: 7F 10 87       CLR    irq_mask_w_1087
6182: 10 8E 18 00    LDY    #sprite_ram_1800
6186: CE 1C 00       LDU    #$1C00
6189: CC 00 FF       LDD    #$00FF
618C: ED A1          STD    ,Y++
618E: ED C1          STD    ,U++
6190: 10 8C 18 30    CMPY   #$1830
6194: 26 F6          BNE    $618C
6196: 5F             CLRB
6197: ED A1          STD    ,Y++		; [scroll_address_word]
6199: ED C1          STD    ,U++		; [scroll_address_word]
619B: 10 8C 18 60    CMPY   #$1860
619F: 26 F6          BNE    $6197
61A1: 8E 30 00       LDX    #video_ram_3000
61A4: 86 08          LDA    #$08
61A6: 97 40          STA    $40
61A8: 0F 41          CLR    $41
61AA: 86 10          LDA    #$10
61AC: 6F 89 08 00    CLR    $0800,X		; [video_address]
61B0: A7 80          STA    ,X+			; [video_address]
61B2: 0A 41          DEC    $41
61B4: 26 F6          BNE    $61AC
61B6: 0A 40          DEC    $40
61B8: 26 F2          BNE    $61AC
61BA: 86 01          LDA    #$01
61BC: B7 10 87       STA    irq_mask_w_1087
61BF: 39             RTS

61C0: D7 72          STB    $72
61C2: 39             RTS

; the text to write is in ascii
; the code subtracts 0x30 to match with tiles
write_copyright_text_61c3:
61C3: 58             ASLB
61C4: 8E A4 E7       LDX    #$A4E7
61C7: 4F             CLRA
61C8: AE 8B          LDX    D,X
61CA: EE 81          LDU    ,X++
61CC: E6 80          LDB    ,X+
61CE: C1 3F          CMPB   #$3F
61D0: 27 0E          BEQ    $61E0
61D2: 96 72          LDA    $72
61D4: 98 73          EORA   $73
61D6: A7 C9 08 00    STA    $0800,U		; [video_address]
61DA: C0 30          SUBB   #$30		; ASCII => tile number
61DC: E7 C0          STB    ,U+			; [video_address]
61DE: 20 EC          BRA    $61CC
61E0: 39             RTS

61E1: 96 72          LDA    $72
61E3: 98 73          EORA   $73
61E5: A7 C9 08 00    STA    $0800,U		; [video_address]
61E9: E7 C4          STB    ,U			; [video_address]
61EB: 39             RTS

61EC: 80 30          SUBA   #$30

61EE: C6 00          LDB    #$00
write_char_and_move_cursor_61f0:
61F0: D8 73          EORB   $73
61F2: E7 C9 08 00    STB    $0800,U		; [video_address]
61F6: A7 C0          STA    ,U+         ; [video_address]
61F8: 39             RTS

61F9: 8E 2A A0       LDX    #$2AA0
61FC: CE 30 C1       LDU    #$30C1
61FF: 96 60          LDA    nb_players_minus_one_60
6201: 4C             INCA
6202: 97 40          STA    $40
6204: 10 8E A4 C8    LDY    #$A4C8
6208: A6 84          LDA    ,X
620A: 27 EC          BEQ    $61F8
620C: 4A             DECA
620D: E6 A6          LDB    A,Y
620F: 4C             INCA
6210: 8D DE          BSR    write_char_and_move_cursor_61f0
6212: 86 20          LDA    #$20
6214: 8D DA          BSR    write_char_and_move_cursor_61f0
6216: 33 41          LEAU   $1,U
6218: 34 04          PSHS   B
621A: 10 8E 29 90    LDY    #$2990
621E: A6 80          LDA    ,X+
6220: 4A             DECA
6221: C6 03          LDB    #$03
6223: 3D             MUL
6224: 31 AB          LEAY   D,Y
6226: 35 04          PULS   B
6228: 8D 3D          BSR    $6267
622A: 33 41          LEAU   $1,U
622C: 96 2D          LDA    dsw2_copy_2d
622E: 85 08          BITA   #$08
6230: 26 08          BNE    $623A
6232: 84 01          ANDA   #$01
6234: 26 04          BNE    $623A
6236: 33 42          LEAU   $2,U
6238: 20 23          BRA    $625D
623A: 34 04          PSHS   B
623C: C6 40          LDB    #$40
623E: 86 6B          LDA    #$6B
6240: BD 61 F0       JSR    write_char_and_move_cursor_61f0
6243: 10 8E 2B 81    LDY    #$2B81
6247: A6 1C          LDA    -$4,X
6249: 4A             DECA
624A: C6 20          LDB    #$20
624C: 3D             MUL
624D: A6 AB          LDA    D,Y
624F: 27 07          BEQ    $6258
6251: 81 0A          CMPA   #$0A
6253: 25 02          BCS    $6257
6255: 86 0A          LDA    #$0A
6257: 4A             DECA
6258: 35 04          PULS   B
625A: BD 61 F0       JSR    write_char_and_move_cursor_61f0
625D: 33 C8 2F       LEAU   difficulty_2f,U
6260: 0A 40          DEC    $40
6262: 10 26 FF 9E    LBNE   $6204
6266: 39             RTS


6267: 0F 41          CLR    $41
6269: A6 A0          LDA    ,Y+
626B: 8D 83          BSR    write_char_and_move_cursor_61f0
626D: A6 A0          LDA    ,Y+
626F: BD 61 F0       JSR    write_char_and_move_cursor_61f0
6272: A6 A0          LDA    ,Y+
6274: BD 61 F0       JSR    write_char_and_move_cursor_61f0
6277: 33 41          LEAU   $1,U
6279: 86 03          LDA    #$03
627B: 97 42          STA    $42
627D: A6 84          LDA    ,X
627F: 44             LSRA
6280: 44             LSRA
6281: 44             LSRA
6282: 44             LSRA
6283: 26 04          BNE    $6289
6285: 0D 41          TST    $41
6287: 27 07          BEQ    $6290
6289: 0C 41          INC    $41
628B: BD 61 F0       JSR    write_char_and_move_cursor_61f0
628E: 20 02          BRA    $6292
6290: 33 41          LEAU   $1,U
6292: A6 80          LDA    ,X+
6294: 84 0F          ANDA   #$0F
6296: 26 04          BNE    $629C
6298: 0D 41          TST    $41
629A: 27 07          BEQ    $62A3
629C: 0C 41          INC    $41
629E: BD 61 F0       JSR    write_char_and_move_cursor_61f0
62A1: 20 02          BRA    $62A5
62A3: 33 41          LEAU   $1,U
62A5: 0A 42          DEC    $42
62A7: 26 D4          BNE    $627D
62A9: 4F             CLRA
62AA: 7E 61 F0       JMP    write_char_and_move_cursor_61f0

62AD: 8E 29 90       LDX    #$2990
62B0: 96 DF          LDA    $DF
62B2: C6 03          LDB    #$03
62B4: 3D             MUL
62B5: 30 8B          LEAX   D,X
62B7: CE A4 C8       LDU    #$A4C8
62BA: 96 DF          LDA    $DF
62BC: E6 C6          LDB    A,U
62BE: CE 33 93       LDU    #$3393
62C1: 86 03          LDA    #$03
62C3: 97 40          STA    $40
62C5: E7 C9 08 00    STB    $0800,U		; [video_address]
62C9: A6 80          LDA    ,X+
62CB: A7 C0          STA    ,U+			; [video_address]
62CD: 0A 40          DEC    $40
62CF: 26 F4          BNE    $62C5
62D1: 39             RTS

62D2: 8E 2B 60       LDX    #$2B60
62D5: CE 32 04       LDU    #$3204
62D8: 86 04          LDA    #$04
62DA: 97 40          STA    $40
62DC: A6 84          LDA    ,X
62DE: 10 27 00 B8    LBEQ   $639A
62E2: 85 20          BITA   #$20
62E4: 10 26 00 BD    LBNE   $63A5
62E8: 84 10          ANDA   #$10
62EA: 27 03          BEQ    $62EF
62EC: 5F             CLRB
62ED: 20 09          BRA    $62F8

62EF: 10 8E A4 C8    LDY    #$A4C8
62F3: A6 84          LDA    ,X
62F5: 4A             DECA
62F6: E6 A6          LDB    A,Y
62F8: A6 84          LDA    ,X
62FA: 84 0F          ANDA   #$0F
62FC: BD 61 F0       JSR    write_char_and_move_cursor_61f0
62FF: 86 20          LDA    #$20
6301: BD 61 F0       JSR    write_char_and_move_cursor_61f0
6304: 33 41          LEAU   $1,U
6306: 34 04          PSHS   B
6308: 10 8E 29 90    LDY    #$2990
630C: A6 80          LDA    ,X+
630E: 84 10          ANDA   #$10
6310: 27 06          BEQ    $6318
6312: 10 8E A4 CC    LDY    #$A4CC
6316: 20 08          BRA    $6320
6318: A6 1F          LDA    -$1,X
631A: 4A             DECA
631B: C6 03          LDB    #$03
631D: 3D             MUL
631E: 31 AB          LEAY   D,Y
6320: 35 04          PULS   B
6322: A6 A0          LDA    ,Y+
6324: BD 61 F0       JSR    write_char_and_move_cursor_61f0
6327: A6 A0          LDA    ,Y+
6329: BD 61 F0       JSR    write_char_and_move_cursor_61f0
632C: A6 A0          LDA    ,Y+
632E: BD 61 F0       JSR    write_char_and_move_cursor_61f0
6331: 33 41          LEAU   $1,U
6333: 5F             CLRB
6334: A6 84          LDA    ,X
6336: BD 61 F0       JSR    write_char_and_move_cursor_61f0
6339: A6 01          LDA    $1,X
633B: BD 61 F0       JSR    write_char_and_move_cursor_61f0
633E: 34 04          PSHS   B
6340: BD 8A 1D       JSR    $8A1D
6343: C6 09          LDB    #$09
6345: BD 61 F0       JSR    write_char_and_move_cursor_61f0
6348: 35 04          PULS   B
634A: A6 02          LDA    $2,X
634C: BD 61 F0       JSR    write_char_and_move_cursor_61f0
634F: A6 03          LDA    $3,X
6351: BD 61 F0       JSR    write_char_and_move_cursor_61f0
6354: 96 84          LDA    current_level_84
6356: 81 05          CMPA   #$05
6358: 26 20          BNE    $637A
635A: 10 8E 2B 9F    LDY    #$2B9F
635E: A6 1F          LDA    -$1,X
6360: 4A             DECA
6361: C6 20          LDB    #$20
6363: 3D             MUL
6364: A6 AB          LDA    D,Y
6366: 26 12          BNE    $637A
6368: BD 87 7D       JSR    $877D
636B: 96 CD          LDA    player_is_qualified_cd
636D: 26 17          BNE    $6386
636F: A6 1F          LDA    -$1,X
6371: 4A             DECA
6372: 91 DF          CMPA   $DF
6374: 26 25          BNE    $639B
6376: 96 F4          LDA    $F4
6378: 27 21          BEQ    $639B
637A: BD 87 7D       JSR    $877D
637D: 96 CD          LDA    player_is_qualified_cd
637F: 26 05          BNE    $6386
6381: CC 51 40       LDD    #$5140
6384: 20 03          BRA    $6389

6386: CC 50 40       LDD    #$5040
6389: E7 C9 08 00    STB    $0800,U		; [video_address]
638D: A7 C4          STA    ,U			; [video_address]
638F: 33 C8 34       LEAU   $34,U
6392: 30 04          LEAX   $4,X
6394: 0A 40          DEC    $40
6396: 10 26 FF 42    LBNE   $62DC
639A: 39             RTS

639B: 6F C9 08 00    CLR    $0800,U		; [video_address]
639F: 86 10          LDA    #$10
63A1: A7 C4          STA    ,U			; [video_address]
63A3: 20 EA          BRA    $638F
63A5: 84 0F          ANDA   #$0F
63A7: BD 61 EE       JSR    $61EE
63AA: 86 20          LDA    #$20
63AC: BD 61 EE       JSR    $61EE
63AF: 33 41          LEAU   $1,U
63B1: 86 13          LDA    #$13
63B3: BD 61 EE       JSR    $61EE
63B6: 86 20          LDA    #$20
63B8: BD 61 EE       JSR    $61EE
63BB: 86 25          LDA    #$25
63BD: BD 61 EE       JSR    $61EE
63C0: 33 46          LEAU   $6,U
63C2: 30 01          LEAX   $1,X
63C4: 20 C9          BRA    $638F

draw_chrono_63c6:
63C6: 86 BF          LDA    #$BF
63C8: B4 3A D7       ANDA   $3AD7
63CB: 8A 80          ORA    #$80
; chrono attributes
63CD: B7 3A 9B       STA    $3A9B
63D0: B7 3A 9A       STA    $3A9A
63D3: B7 3A 98       STA    $3A98
63D6: B7 3A 97       STA    $3A97
63D9: B7 3A DB       STA    $3ADB
63DC: B7 3A DA       STA    $3ADA
63DF: B7 3A D8       STA    $3AD8
63E2: B7 3A D7       STA    $3AD7
63E5: 86 0F          LDA    #$0F
63E7: 94 7E          ANDA   chrono_hundredth_second_7e
63E9: 48             ASLA
63EA: B7 32 9B       STA    $329B	; [video_address] (chrono colon, upper tile)
63ED: 4C             INCA
63EE: B7 32 DB       STA    $32DB	; [video_address] (chrono colon, lower tile)
63F1: 86 F0          LDA    #$F0
63F3: 94 7E          ANDA   chrono_hundredth_second_7e
63F5: 44             LSRA
63F6: 44             LSRA
63F7: 44             LSRA
63F8: B7 32 9A       STA    $329A	; [video_address] (chrono 10th second digit, upper tile)
63FB: 4C             INCA
63FC: B7 32 DA       STA    $32DA	; [video_address] (chrono 10th second digit, lower tile)
63FF: 86 0F          LDA    #$0F
6401: 94 7F          ANDA   chrono_second_7f
6403: 48             ASLA
6404: B7 32 98       STA    $3298	; [video_address] (chrono second unit digit, upper tile)
6407: 4C             INCA
6408: B7 32 D8       STA    $32D8	; [video_address] (chrono second unit digit, lower tile)
640B: 86 F0          LDA    #$F0
640D: 94 7F          ANDA   chrono_second_7f
640F: 44             LSRA
6410: 44             LSRA
6411: 44             LSRA
6412: B7 32 97       STA    $3297	; [video_address] (chrono 1x second digit, upper tile)
6415: 4C             INCA
6416: B7 32 D7       STA    $32D7	; [video_address] (chrono 1x second digit, lower tile)
6419: 39             RTS

641A: FC 2A E1       LDD    $2AE1
641D: C0 10          SUBB   #$10
641F: FD 29 F8       STD    $29F8
6422: 8E ED 7B       LDX    #$ED7B
6425: 96 D8          LDA    angle_d8
6427: A6 86          LDA    A,X
6429: 44             LSRA
642A: 44             LSRA
642B: 44             LSRA
642C: 8E ED D5       LDX    #$EDD5
642F: D6 D8          LDB    angle_d8
6431: 50             NEGB
6432: E6 85          LDB    B,X
6434: 54             LSRB
6435: 54             LSRB
6436: 54             LSRB
6437: FD 29 FA       STD    $29FA
643A: BB 29 F8       ADDA   $29F8
643D: FB 29 F9       ADDB   $29F9
6440: FD 29 FC       STD    $29FC
6443: CE 18 10       LDU    #$1810
6446: BD 64 AB       JSR    $64AB
6449: FC 29 FA       LDD    $29FA
644C: 44             LSRA
644D: 54             LSRB
644E: FD 29 FA       STD    $29FA
6451: BB 29 F8       ADDA   $29F8
6454: FB 29 F9       ADDB   $29F9
6457: FD 29 FE       STD    $29FE
645A: CE 18 12       LDU    #$1812
645D: BD 64 AB       JSR    $64AB
6460: FC 29 FA       LDD    $29FA
6463: 44             LSRA
6464: 54             LSRB
6465: BB 29 F8       ADDA   $29F8
6468: FB 29 F9       ADDB   $29F9
646B: CE 18 14       LDU    #$1814
646E: BD 64 AB       JSR    $64AB
6471: FC 29 FC       LDD    $29FC
6474: BB 29 FE       ADDA   $29FE
6477: 44             LSRA
6478: FB 29 FF       ADDB   $29FF
647B: 54             LSRB
647C: CE 18 16       LDU    #$1816
647F: BD 64 AB       JSR    $64AB
6482: DE E4          LDU    $E4
6484: 33 C8 C1       LEAU   -$3F,U
6487: 96 D8          LDA    angle_d8
6489: D6 84          LDB    current_level_84
648B: C1 04          CMPB   #$04
648D: 26 03          BNE    $6492
648F: B6 2A 38       LDA    $2A38
6492: 5F             CLRB
6493: 34 04          PSHS   B
6495: BD 88 7F       JSR    $887F
6498: 97 46          STA    $46
649A: 1F 98          TFR    B,A
649C: 35 04          PULS   B
649E: BD 61 F0       JSR    write_char_and_move_cursor_61f0
64A1: 96 46          LDA    $46
64A3: BD 61 F0       JSR    write_char_and_move_cursor_61f0
64A6: 86 37          LDA    #$37			; degree sign
64A8: 7E 61 F0       JMP    write_char_and_move_cursor_61f0

64AB: 34 06          PSHS   D
64AD: 96 21          LDA    copy_of_screen_flipped_21
64AF: 26 12          BNE    $64C3
64B1: 35 06          PULS   D
64B3: A7 41          STA    $1,U
64B5: E7 C9 04 00    STB    $0400,U
64B9: CC F1 40       LDD    #$F140
64BC: A7 C9 04 01    STA    $0401,U
64C0: E7 C4          STB    ,U
64C2: 39             RTS

64C3: 35 06          PULS   D
64C5: 50             NEGB
64C6: 4A             DECA
64C7: C0 0E          SUBB   #$0E
64C9: A7 41          STA    $1,U
64CB: E7 C9 04 00    STB    $0400,U
64CF: CC F1 00       LDD    #$F100
64D2: A7 C9 04 01    STA    $0401,U
64D6: E7 C4          STB    ,U
64D8: 39             RTS

update_speed_bar_64d9:
64D9: CE 37 45       LDU    #$3745
64DC: 96 B0          LDA    $B0
64DE: C6 0A          LDB    #$0A
64E0: 3D             MUL
64E1: DB B1          ADDB   $B1
64E3: D7 41          STB    $41
64E5: D7 42          STB    $42
64E7: 8E A4 CF       LDX    #$A4CF
64EA: 5F             CLRB
64EB: 96 B2          LDA    $B2
64ED: A1 80          CMPA   ,X+
64EF: 25 03          BCS    $64F4
64F1: 5C             INCB
64F2: 20 F9          BRA    $64ED
64F4: 8E A4 D3       LDX    #$A4D3
64F7: A6 85          LDA    B,X
64F9: 97 43          STA    $43
64FB: 96 41          LDA    $41
64FD: 27 0F          BEQ    $650E
64FF: CC 0F 00       LDD    #$0F00
6502: D8 73          EORB   $73
6504: E7 C9 08 00    STB    $0800,U     ; [video_address]
6508: A7 C0          STA    ,U+         ; [video_address]
650A: 0A 41          DEC    $41
650C: 26 F6          BNE    $6504
650E: 96 43          LDA    $43
6510: 27 0C          BEQ    $651E
6512: C6 00          LDB    #$00
6514: D8 73          EORB   $73
6516: E7 C9 08 00    STB    $0800,U     ; [video_address]
651A: A7 C0          STA    ,U+         ; [video_address]
651C: 0C 42          INC    $42
651E: 86 0F          LDA    #$0F
6520: 90 42          SUBA   $42
6522: 27 11          BEQ    $6535
6524: 97 42          STA    $42
6526: CC 0B 00       LDD    #$0B00
6529: D8 73          EORB   $73
652B: E7 C9 08 00    STB    $0800,U		; [video_address]
652F: A7 C0          STA    ,U+			; [video_address]
6531: 0A 42          DEC    $42
6533: 26 F6          BNE    $652B
6535: CE 37 58       LDU    #$3758
6538: 96 B0          LDA    $B0
653A: BD 61 EE       JSR    $61EE
653D: 96 B1          LDA    $B1
653F: BD 61 EE       JSR    $61EE
6542: 96 B2          LDA    $B2
6544: BD 61 EE       JSR    $61EE
6547: 96 B3          LDA    $B3
6549: 7E 61 EE       JMP    $61EE
654C: 39             RTS

654D: CE 37 49       LDU    #$3749
6550: 96 B1          LDA    $B1
6552: 48             ASLA
6553: D6 B2          LDB    $B2
6555: C1 05          CMPB   #$05
6557: 25 03          BCS    $655C
6559: C0 05          SUBB   #$05
655B: 4C             INCA
655C: 5D             TSTB
655D: 27 01          BEQ    $6560
655F: 5A             DECB
6560: D7 43          STB    $43
6562: 97 41          STA    $41
6564: 97 42          STA    $42
6566: 27 0F          BEQ    $6577
6568: CC 0F 00       LDD    #$0F00
656B: D8 73          EORB   $73
656D: E7 C9 08 00    STB    $0800,U     ; [video_address]
6571: A7 C0          STA    ,U+         ; [video_address]
6573: 0A 42          DEC    $42
6575: 26 F6          BNE    $656D
6577: 96 43          LDA    $43
6579: 27 11          BEQ    $658C
657B: 8E A4 D7       LDX    #$A4D7
657E: A6 86          LDA    A,X
6580: C6 00          LDB    #$00
6582: D8 73          EORB   $73
6584: E7 C9 08 00    STB    $0800,U       ; [video_address]
6588: A7 C0          STA    ,U+           ; [video_address]
658A: 0C 41          INC    $41
658C: 86 0A          LDA    #$0A
658E: 90 41          SUBA   $41
6590: 23 11          BLS    $65A3
6592: 97 42          STA    $42
6594: CC 0B 00       LDD    #$0B00
6597: D8 73          EORB   $73
6599: E7 C9 08 00    STB    $0800,U         ; [video_address]
659D: A7 C0          STA    ,U+             ; [video_address]
659F: 0A 42          DEC    $42
65A1: 26 F6          BNE    $6599
65A3: CE 37 58       LDU    #$3758
65A6: 96 B0          LDA    $B0
65A8: BD 61 EE       JSR    $61EE
65AB: 96 B1          LDA    $B1
65AD: BD 61 EE       JSR    $61EE
65B0: 96 B2          LDA    $B2
65B2: BD 61 EE       JSR    $61EE
65B5: 96 B3          LDA    $B3
65B7: 7E 61 EE       JMP    $61EE
65BA: 86 02          LDA    #$02
65BC: 97 43          STA    $43
65BE: 8E 2A 10       LDX    #$2A10
65C1: CE 35 C4       LDU    #$35C4
65C4: 86 04          LDA    #$04
65C6: 97 44          STA    $44
65C8: A6 80          LDA    ,X+
65CA: BD 61 EE       JSR    $61EE
65CD: 0A 44          DEC    $44
65CF: 26 F7          BNE    $65C8
65D1: 8E 28 B0       LDX    #$28B0
65D4: 33 C8 10       LEAU   $10,U
65D7: 0A 43          DEC    $43
65D9: 26 E9          BNE    $65C4
65DB: 39             RTS

65DC: 8E 29 90       LDX    #$2990
65DF: 96 DF          LDA    $DF
65E1: C6 03          LDB    #$03
65E3: 3D             MUL
65E4: 30 8B          LEAX   D,X
65E6: CE A4 E3       LDU    #$A4E3
65E9: 96 DF          LDA    $DF
65EB: 84 01          ANDA   #$01
65ED: 48             ASLA
65EE: EE C6          LDU    A,U
65F0: C6 03          LDB    #$03
65F2: 96 72          LDA    $72
65F4: A7 C9 08 00    STA    $0800,U    ; [video_address]
65F8: A6 80          LDA    ,X+        
65FA: A7 C0          STA    ,U+        ; [video_address]
65FC: 5A             DECB
65FD: 26 F3          BNE    $65F2
65FF: 39             RTS

irq_6600:
6600: 7F 10 87       CLR    irq_mask_w_1087
6603: 86 01          LDA    #$01
6605: B7 10 00       STA    watchdog_1000
6608: BD D9 06       JSR    update_scrolling_d906
660B: 96 00          LDA    global_state_00
660D: 48             ASLA
660E: 8E A8 69       LDX    #main_jump_table_a869
6611: AD 96          JSR    [A,X]		; [jump_table]
6613: 0C 3F          INC    $3F
6615: BD 66 24       JSR    read_inputs_6624
6618: BD 66 4A       JSR    $664A
661B: BD 66 EB       JSR    $66EB
661E: 86 01          LDA    #$01
6620: B7 10 87       STA    irq_mask_w_1087
6623: 3B             RTI

read_inputs_6624:
6624: 8E 28 30       LDX    #copy_of_inputs_2830
6627: EC 03          LDD    $3,X	; copy previous values of inputs
6629: ED 06          STD    $6,X
662B: A6 05          LDA    $5,X
662D: A7 08          STA    $8,X
662F: EC 84          LDD    ,X
6631: ED 03          STD    $3,X
6633: A6 02          LDA    $2,X
6635: A7 05          STA    $5,X
6637: B6 12 80       LDA    system_1280
663A: 43             COMA
663B: A7 80          STA    ,X+
663D: B6 12 81       LDA    in0_1281
6640: 43             COMA
6641: A7 80          STA    ,X+
6643: B6 12 82       LDA    in1_1282
6646: 43             COMA
6647: A7 84          STA    ,X
6649: 39             RTS

664A: 96 2C          LDA    dsw1_copy_2c
664C: 84 0F          ANDA   #$0F
664E: 81 0F          CMPA   #$0F
6650: 26 05          BNE    $6657
6652: 86 63          LDA    #$63
6654: 97 23          STA    number_of_credits_23
6656: 39             RTS

6657: 96 24          LDA    $24
6659: 27 04          BEQ    $665F
665B: 0A 24          DEC    $24
665D: 86 01          LDA    #$01
665F: B7 10 83       STA    coin_counter_1_w_1083
6662: 96 26          LDA    $26
6664: 27 04          BEQ    $666A
6666: 0A 26          DEC    $26
6668: 86 01          LDA    #$01
666A: B7 10 84       STA    coin_counter_1_w_1084
666D: 8E 28 30       LDX    #copy_of_inputs_2830
6670: A6 06          LDA    $6,X
6672: AA 03          ORA    $3,X
6674: 43             COMA
6675: A4 84          ANDA   ,X		; mask with copy_of_inputs_2830, see if changes in inputs
6677: 84 07          ANDA   #$07
6679: 27 29          BEQ    $66A4
667B: 97 48          STA    nb_objects_48
667D: 96 22          LDA    $22
667F: 27 03          BEQ    $6684
6681: 4F             CLRA
6682: 20 02          BRA    $6686
6684: 86 34          LDA    #$34
6686: BD 85 12       JSR    $8512
6689: 86 04          LDA    #$04
668B: BD 85 12       JSR    $8512
668E: 86 03          LDA    #$03
6690: BD 85 12       JSR    $8512
6693: 86 02          LDA    #$02
6695: BD 85 12       JSR    $8512
6698: 8D 15          BSR    $66AF
669A: 96 48          LDA    nb_objects_48
669C: 85 01          BITA   #$01
669E: 26 05          BNE    $66A5
66A0: 85 02          BITA   #$02
66A2: 26 06          BNE    $66AA
66A4: 39             RTS

66A5: 86 03          LDA    #$03
66A7: 97 24          STA    $24
66A9: 39             RTS

66AA: 86 03          LDA    #$03
66AC: 97 26          STA    $26
66AE: 39             RTS

66AF: 96 48          LDA    nb_objects_48
66B1: 85 01          BITA   #$01
66B3: 26 09          BNE    $66BE
66B5: 85 02          BITA   #$02
66B7: 26 17          BNE    $66D0
66B9: 0C 23          INC    number_of_credits_23
66BB: 20 23          BRA    $66E0
66BD: 39             RTS

66BE: 0C 25          INC    $25
66C0: 96 25          LDA    $25
66C2: 91 28          CMPA   $28
66C4: 26 F7          BNE    $66BD
66C6: 96 29          LDA    $29
66C8: 9B 23          ADDA   number_of_credits_23
66CA: 97 23          STA    number_of_credits_23
66CC: 0F 25          CLR    $25
66CE: 20 10          BRA    $66E0
66D0: 0C 27          INC    $27
66D2: 96 27          LDA    $27
66D4: 91 2A          CMPA   $2A
66D6: 26 E5          BNE    $66BD
66D8: 96 2B          LDA    $2B
66DA: 9B 23          ADDA   number_of_credits_23
66DC: 97 23          STA    number_of_credits_23
66DE: 0F 27          CLR    $27
66E0: 96 23          LDA    number_of_credits_23
66E2: 81 64          CMPA   #$64
66E4: 25 04          BCS    $66EA
66E6: 86 63          LDA    #$63
66E8: 97 23          STA    number_of_credits_23
66EA: 39             RTS

66EB: 9E 1E          LDX    $1E
66ED: 9C 1C          CMPX   $1C
66EF: 26 01          BNE    $66F2
66F1: 39             RTS

66F2: A6 80          LDA    ,X+
66F4: B7 11 00       STA    audio_register_w_1100
66F7: 4F             CLRA
66F8: B7 10 81       STA    sh_irqtrigger_w_1081
66FB: 12             NOP
66FC: 12             NOP
66FD: 12             NOP
66FE: 12             NOP
66FF: 4C             INCA
6700: B7 10 81       STA    sh_irqtrigger_w_1081
6703: 8C 29 60       CMPX   #player_1_final_time_2960
6706: 26 03          BNE    $670B
6708: 8E 29 40       LDX    #$2940
670B: 9F 1E          STX    $1E
670D: 39             RTS

boot_670e:
670E: 8E A8 73       LDX    #boot_table_a873
6711: 96 03          LDA    boot_state_03
6713: 48             ASLA
6714: 6E 96          JMP    [A,X]	; [jump_table]

6716: 86 30          LDA    #$30
6718: 97 08          STA    $08
671A: 0C 03          INC    boot_state_03
671C: 39             RTS

671D: 0A 08          DEC    $08
671F: 26 04          BNE    $6725
6721: 0F 03          CLR    boot_state_03
6723: 0C 00          INC    global_state_00		; next state
6725: 39             RTS

rolling_demo_6726:
6726: 96 2C          LDA    dsw1_copy_2c
6728: 84 0F          ANDA   #$0F
672A: 81 0F          CMPA   #$0F
672C: 26 06          BNE    $6734
672E: BD 67 BF       JSR    $67BF
6731: 5D             TSTB
6732: 26 0A          BNE    $673E
6734: 0F 22          CLR    $22
6736: 8E A8 77       LDX    #table_a877
6739: 96 0F          LDA    $0F
673B: 48             ASLA
673C: AD 96          JSR    [A,X]	; [jump_table]
673E: B6 2F E7       LDA    $2FE7   ; [rom_check_code]
6741: 81 19          CMPA   #$19    ; [rom_check_code]
6743: 26 66          BNE    $67AB   ; [rom_check_code]
6745: B6 2F EE       LDA    $2FEE   ; [rom_check_code]
6748: 81 65          CMPA   #$65    ; [rom_check_code]
674A: 26 5F          BNE    $67AB   ; [rom_check_code]
674C: B6 2F EF       LDA    $2FEF   ; [rom_check_code]
674F: 81 DB          CMPA   #$DB    ; [rom_check_code]
6751: 26 58          BNE    $67AB   ; [rom_check_code]
6753: 10 8E A6 BC    LDY    #$A6BC  ; [rom_check_code]
6757: A6 A0          LDA    ,Y+     ; [rom_check_code]
6759: 4A             DECA           ; [rom_check_code]
675A: 81 4A          CMPA   #$4A    ; [rom_check_code]
675C: 26 4A          BNE    $67A8   ; [rom_check_code]
675E: A6 A0          LDA    ,Y+     ; [rom_check_code]
6760: 8B 20          ADDA   #$20    ; [rom_check_code]
6762: 81 6F          CMPA   #$6F    ; [rom_check_code]
6764: 26 42          BNE    $67A8   ; [rom_check_code]
6766: A6 A0          LDA    ,Y+     ; [rom_check_code]
6768: 80 05          SUBA   #$05    ; [rom_check_code]
676A: 81 49          CMPA   #$49    ; [rom_check_code]
676C: 26 3A          BNE    $67A8   ; [rom_check_code]
676E: A6 A0          LDA    ,Y+     ; [rom_check_code]
6770: 4C             INCA           ; [rom_check_code]
6771: 81 42          CMPA   #$42    ; [rom_check_code]
6773: 26 33          BNE    $67A8   ; [rom_check_code]
6775: A6 A0          LDA    ,Y+     ; [rom_check_code]
6777: 8B 03          ADDA   #$03    ; [rom_check_code]
6779: 81 50          CMPA   #$50    ; [rom_check_code]
677B: 26 2B          BNE    $67A8   ; [rom_check_code]
677D: A6 A0          LDA    ,Y+     ; [rom_check_code]
677F: 81 49          CMPA   #$49    ; [rom_check_code]
6781: 26 25          BNE    $67A8   ; [rom_check_code]
6783: 8E FC 47       LDX    #$FC47  ; [rom_check_code]
6786: 30 88 24       LEAX   $24,X   ; [rom_check_code]
6789: CC 00 00       LDD    #$0000  ; [rom_check_code]
678C: EB 81          ADDB   ,X++    ; [rom_check_code]
678E: 89 00          ADCA   #$00    ; [rom_check_code]
6790: 30 01          LEAX   $1,X    ; [rom_check_code]
6792: EB 84          ADDB   ,X      ; [rom_check_code]
6794: 89 00          ADCA   #$00    ; [rom_check_code]
6796: 30 03          LEAX   $3,X    ; [rom_check_code]
6798: EB 80          ADDB   ,X+     ; [rom_check_code]
679A: 89 00          ADCA   #$00    ; [rom_check_code]
679C: 30 02          LEAX   $2,X    ; [rom_check_code]
679E: EB 84          ADDB   ,X      ; [rom_check_code]
67A0: 89 00          ADCA   #$00    ; [rom_check_code]
67A2: 10 83 03 12    CMPD   #$0312  ; [rom_check_code]
67A6: 27 03          BEQ    $67AB   ; [rom_check_code]
67A8: 16 51 3B       LBRA   $B8E6   ; [rom_check_code] bogus address
67AB: 39             RTS

push_start_screen_67ac:
67AC: 8E A8 7D       LDX    #table_a87d
67AF: 96 03          LDA    boot_state_03
67B1: 48             ASLA
67B2: 6E 96          JMP    [A,X]	; [jump_table]

67B4: 8E A8 81       LDX    #table_a881
67B7: 96 06          LDA    $06
67B9: 48             ASLA
67BA: AD 96          JSR    [A,X]	; [jump_table]
67BC: BD D8 2B       JSR    $D82B
67BF: 4F             CLRA
67C0: 5F             CLRB
67C1: 8E 2B 80       LDX    #$2B80
67C4: ED 81          STD    ,X++
67C6: 8C 2C 00       CMPX   #$2C00
67C9: 26 F9          BNE    $67C4
67CB: D6 23          LDB    number_of_credits_23
67CD: 96 30          LDA    copy_of_inputs_30
67CF: 85 08          BITA   #$08
67D1: 26 12          BNE    one_player_start_67e5
67D3: 85 10          BITA   #$10
67D5: 26 17          BNE    two_player_start_67ee
67D7: 96 31          LDA    copy_of_inputs_31
67D9: 84 08          ANDA   #$08
67DB: 26 1B          BNE    three_player_start_67f8
67DD: 96 32          LDA    copy_of_inputs_32
67DF: 84 08          ANDA   #$08
67E1: 26 1F          BNE    four_player_start_6802
67E3: 5F             CLRB
67E4: 39             RTS

one_player_start_67e5:
67E5: C0 01          SUBB   #$01
67E7: 25 FA          BCS    $67E3
67E9: D7 23          STB    number_of_credits_23
67EB: 4F             CLRA
67EC: 20 1C          BRA    start_a_game_680a

two_player_start_67ee:
67EE: C0 02          SUBB   #$02
67F0: 25 F1          BCS    $67E3
67F2: D7 23          STB    number_of_credits_23
67F4: 86 01          LDA    #$01
67F6: 20 12          BRA    start_a_game_680a

three_player_start_67f8:
67F8: C0 03          SUBB   #$03
67FA: 25 E7          BCS    $67E3
67FC: D7 23          STB    number_of_credits_23
67FE: 86 02          LDA    #$02
6800: 20 08          BRA    start_a_game_680a

four_player_start_6802:
6802: C0 04          SUBB   #$04
6804: 25 DD          BCS    $67E3
6806: D7 23          STB    number_of_credits_23
6808: 86 03          LDA    #$03
start_a_game_680a:
680A: 97 60          STA    nb_players_minus_one_60
680C: 4F             CLRA
680D: 5F             CLRB
680E: DD 20          STD    $20
6810: DD 80          STD    $80
6812: DD 82          STD    $82
6814: 97 84          STA    current_level_84
6816: 97 9F          STA    high_jump_fault_9f
6818: 97 DF          STA    $DF
681A: 97 10          STA    $10
681C: 86 01          LDA    #$01
681E: 97 22          STA    $22
6820: 86 01          LDA    #$01
6822: D6 2D          LDB    dsw2_copy_2d
6824: 57             ASRB
6825: 24 02          BCC    $6829
6827: 86 02          LDA    #$02
6829: 97 49          STA    $49
682B: 8E 2B 80       LDX    #$2B80
682E: 96 60          LDA    nb_players_minus_one_60
6830: 4C             INCA
6831: 97 48          STA    nb_objects_48
6833: 86 01          LDA    #$01
6835: A7 84          STA    ,X
6837: 96 49          LDA    $49
6839: A7 01          STA    $1,X
683B: 6F 04          CLR    $4,X
683D: 6F 88 1F       CLR    $1F,X
6840: 30 88 20       LEAX   $20,X
6843: 0A 48          DEC    nb_objects_48
6845: 26 EC          BNE    $6833
; clear game variables (level, etc...)
6847: 4F             CLRA
6848: 5F             CLRB
6849: 8E 28 66       LDX    #qualifying_value_2866
684C: ED 81          STD    ,X++
684E: 8C 28 A0       CMPX   #$28A0
6851: 26 F9          BNE    $684C
6853: 8E 2F E8       LDX    #$2FE8
6856: ED 81          STD    ,X++
6858: 8C 2F EE       CMPX   #$2FEE
685B: 26 F9          BNE    $6856
685D: 8E 2F F0       LDX    #$2FF0
6860: ED 81          STD    ,X++
6862: 8C 2F FE       CMPX   #$2FFE
6865: 26 F9          BNE    $6860
6867: A7 84          STA    ,X
6869: B6 2F FF       LDA    $2FFF
686C: 84 C0          ANDA   #$C0
686E: B7 2F FF       STA    $2FFF
6871: 4F             CLRA
6872: 8E 29 60       LDX    #player_1_final_time_2960
6875: ED 81          STD    ,X++
6877: 8C 29 90       CMPX   #$2990
687A: 26 F9          BNE    $6875
687C: 8E 2A 80       LDX    #$2A80
687F: ED 81          STD    ,X++
6881: 8C 2A C0       CMPX   #$2AC0
6884: 26 F9          BNE    $687F
6886: 8E 2A A0       LDX    #$2AA0
6889: 86 01          LDA    #$01
688B: D6 60          LDB    nb_players_minus_one_60
688D: 5C             INCB
688E: A7 84          STA    ,X
6890: 30 04          LEAX   $4,X
6892: 4C             INCA
6893: 5A             DECB
6894: 26 F8          BNE    $688E
6896: 4F             CLRA
6897: BD 85 0E       JSR    $850E
689A: 86 18          LDA    #$18
689C: BD 85 0E       JSR    $850E
689F: 86 40          LDA    #$40
68A1: BD 85 0E       JSR    $850E
68A4: 86 02          LDA    #$02
68A6: 97 00          STA    global_state_00
68A8: 86 01          LDA    #$01
68AA: 97 03          STA    boot_state_03
68AC: 0F 06          CLR    $06
68AE: 0F 09          CLR    $09
68B0: 0F 0C          CLR    $0C
68B2: 0F 0F          CLR    $0F
68B4: 0F 12          CLR    $12
68B6: C6 01          LDB    #$01
68B8: 39             RTS

68B9: 7F 10 80       CLR    flip_screen_set_1080
68BC: CC 00 00       LDD    #$0000
68BF: BD 84 F5       JSR    queue_event_84f5
68C2: CC 01 01       LDD    #$0101
68C5: BD 84 F5       JSR    queue_event_84f5
68C8: CC 02 06       LDD    #$0206
68CB: BD 84 F5       JSR    queue_event_84f5
68CE: 96 2D          LDA    dsw2_copy_2d
68D0: 84 08          ANDA   #$08
68D2: 27 0C          BEQ    $68E0
68D4: CC 01 09       LDD    #$0109
68D7: BD 84 F5       JSR    queue_event_84f5
68DA: CC 02 12       LDD    #$0212
68DD: BD 84 F5       JSR    queue_event_84f5
68E0: CC 01 0A       LDD    #$010A
68E3: BD 84 F5       JSR    queue_event_84f5
68E6: CC 02 04       LDD    #$0204
68E9: BD 84 F5       JSR    queue_event_84f5
68EC: 86 02          LDA    #$02
68EE: 97 08          STA    $08
68F0: 0C 06          INC    $06
68F2: 39             RTS

68F3: 0A 08          DEC    $08
68F5: 26 0B          BNE    $6902
68F7: BD 8C 2F       JSR    reset_scrolling_8c2f
68FA: CE 30 C5       LDU    #$30C5
68FD: BD FC AB       JSR    $FCAB
6900: 0C 06          INC    $06
6902: 39             RTS

6903: CC 01 01       LDD    #$0101
6906: BD 84 F5       JSR    queue_event_84f5
6909: D6 23          LDB    number_of_credits_23
690B: 27 0D          BEQ    $691A
690D: C1 04          CMPB   #$04
690F: 25 02          BCS    $6913
6911: C6 04          LDB    #$04
6913: CB 17          ADDB   #$17
6915: 86 02          LDA    #$02
6917: BD 84 F5       JSR    queue_event_84f5
691A: 39             RTS

running_game_691b:
691B: 10 8E A8 87    LDY    #table_a887
691F: 96 03          LDA    boot_state_03
6921: 48             ASLA
6922: 6E B6          JMP    [A,Y]		; [jump_table]
6924: 96 06          LDA    $06
6926: 48             ASLA
6927: 10 8E A8 93    LDY    #table_a893
692B: 6E B6          JMP    [A,Y]		; [jump_table]
692D: 96 09          LDA    $09
692F: 48             ASLA
6930: 10 8E A8 97    LDY    #table_a897
6934: 6E B6          JMP    [A,Y]		; [jump_table]


setup_players_screen_6936:
6936: CC 00 00       LDD    #$0000
6939: BD 84 F5       JSR    queue_event_84f5
693C: 86 14          LDA    #$14
693E: 97 0B          STA    $0B
6940: 4F             CLRA
6941: D6 2D          LDB    dsw2_copy_2d
6943: C4 04          ANDB   #$04
6945: 26 08          BNE    $694F
6947: D6 DF          LDB    $DF
6949: C4 02          ANDB   #$02
694B: 27 02          BEQ    $694F
; more than 2 players in cocktail mode: flip screen
694D: 86 01          LDA    #$01
694F: B7 10 80       STA    flip_screen_set_1080
6952: 97 21          STA    copy_of_screen_flipped_21	; remember the screen state
6954: BD 8C 2F       JSR    reset_scrolling_8c2f
6957: 86 2C          LDA    #$2C
6959: BD 85 0E       JSR    $850E
695C: 0C 09          INC    $09
695E: 39             RTS

695F: 0A 0B          DEC    $0B
6961: 26 3C          BNE    $699F
6963: BD 88 25       JSR    $8825
6966: 96 22          LDA    $22
6968: 26 02          BNE    $696C
696A: 0F E1          CLR    max_accepted_faults_e1
696C: 4F             CLRA
696D: 5F             CLRB
696E: 8E 2B 60       LDX    #$2B60
6971: ED 81          STD    ,X++
6973: 8C 2B 74       CMPX   #$2B74
6976: 26 F9          BNE    $6971
6978: 8E 2B 60       LDX    #$2B60
697B: 96 84          LDA    current_level_84
697D: 81 00          CMPA   #$00
697F: 27 04          BEQ    $6985
6981: 81 03          CMPA   #$03
6983: 26 18          BNE    $699D
6985: 86 04          LDA    #$04
6987: 97 48          STA    nb_objects_48
6989: 10 8E A8 9D    LDY    #$A89D
698D: 86 05          LDA    #$05
698F: 97 49          STA    $49
6991: A6 A0          LDA    ,Y+
6993: A7 80          STA    ,X+
6995: 0A 49          DEC    $49
6997: 26 F8          BNE    $6991
6999: 0A 48          DEC    nb_objects_48
699B: 26 EC          BNE    $6989
699D: 0C 09          INC    $09
699F: 39             RTS

69A0: 10 8E AD A7    LDY    #$ADA7
69A4: CE 33 00       LDU    #$3300
69A7: E6 A0          LDB    ,Y+
69A9: D8 73          EORB   $73
69AB: 86 0B          LDA    #$0B
69AD: 97 48          STA    nb_objects_48
69AF: E7 C9 08 00    STB    $0800,U		; [video_address]
69B3: A6 A0          LDA    ,Y+
69B5: A7 C4          STA    ,U			; [video_address]
69B7: 33 C8 C0       LEAU   -$40,U
69BA: 0A 48          DEC    nb_objects_48
69BC: 26 F1          BNE    $69AF
69BE: 33 C9 02 C1    LEAU   $02C1,U
69C2: 11 83 33 20    CMPU   #$3320
69C6: 26 E3          BNE    $69AB
69C8: 0C 06          INC    $06
69CA: 0F 09          CLR    $09
69CC: 39             RTS

69CD: 96 22          LDA    $22
69CF: 27 05          BEQ    $69D6
69D1: 86 03          LDA    #$03
69D3: BD 84 F5       JSR    queue_event_84f5
69D6: 96 84          LDA    current_level_84
69D8: 81 00          CMPA   #$00
69DA: 27 04          BEQ    $69E0
69DC: 81 03          CMPA   #$03
69DE: 26 03          BNE    $69E3
69E0: BD 8E 20       JSR    $8E20
69E3: 8E 2C 00       LDX    #$2C00
69E6: 96 84          LDA    current_level_84
69E8: C6 20          LDB    #$20
69EA: 3D             MUL
69EB: 30 8B          LEAX   D,X
69ED: CE 31 16       LDU    #$3116
69F0: 86 03          LDA    #$03
69F2: 97 55          STA    $55
69F4: C6 0A          LDB    #$0A
69F6: A6 80          LDA    ,X+
69F8: 27 05          BEQ    $69FF
69FA: BD 61 F0       JSR    write_char_and_move_cursor_61f0
69FD: 20 02          BRA    $6A01
69FF: 33 41          LEAU   $1,U
6A01: A6 80          LDA    ,X+
6A03: BD 61 F0       JSR    write_char_and_move_cursor_61f0
6A06: BD 8A 1D       JSR    $8A1D
6A09: C6 09          LDB    #$09
6A0B: BD 61 F0       JSR    write_char_and_move_cursor_61f0
6A0E: C6 0A          LDB    #$0A
6A10: A6 80          LDA    ,X+
6A12: BD 61 F0       JSR    write_char_and_move_cursor_61f0
6A15: A6 80          LDA    ,X+
6A17: BD 61 F0       JSR    write_char_and_move_cursor_61f0
6A1A: 33 41          LEAU   $1,U
6A1C: A6 80          LDA    ,X+
6A1E: BD 61 F0       JSR    write_char_and_move_cursor_61f0
6A21: A6 80          LDA    ,X+
6A23: BD 61 F0       JSR    write_char_and_move_cursor_61f0
6A26: A6 81          LDA    ,X++
6A28: BD 61 F0       JSR    write_char_and_move_cursor_61f0
6A2B: 33 C8 37       LEAU   $37,U
6A2E: 0A 55          DEC    $55
6A30: 26 C4          BNE    $69F6
6A32: BD 93 09       JSR    load_and_display_qualifying_value_9309
6A35: 4F             CLRA
6A36: 5F             CLRB
6A37: DD EC          STD    $EC
6A39: DD EE          STD    $EE
6A3B: 8E 28 B0       LDX    #$28B0
6A3E: ED 81          STD    ,X++
6A40: 8C 28 DE       CMPX   #$28DE
6A43: 26 F9          BNE    $6A3E
6A45: 0F DE          CLR    $DE
6A47: 8E 2A 10       LDX    #$2A10
6A4A: ED 81          STD    ,X++
6A4C: 8C 2A 40       CMPX   #$2A40
6A4F: 26 F9          BNE    $6A4A
6A51: 96 22          LDA    $22
6A53: 26 14          BNE    $6A69
6A55: 96 2C          LDA    dsw1_copy_2c
6A57: 84 0F          ANDA   #$0F
6A59: 81 0F          CMPA   #$0F
6A5B: 26 0C          BNE    $6A69
6A5D: CC 01 0A       LDD    #$010A
6A60: BD 84 F5       JSR    queue_event_84f5
6A63: CC 02 2F       LDD    #$022F
6A66: BD 84 F5       JSR    queue_event_84f5
6A69: 0F 06          CLR    $06
6A6B: 0F 09          CLR    $09
6A6D: 0C 03          INC    boot_state_03
6A6F: 39             RTS

6A70: BD 8E 5F       JSR    $8E5F
6A73: 96 06          LDA    $06
6A75: 48             ASLA
6A76: 10 8E A8 A2    LDY    #table_a8a2
6A7A: 6E B6          JMP    [A,Y]	; [jump_table]

6A7C: 96 09          LDA    $09
6A7E: 48             ASLA
6A7F: 10 8E A8 A6    LDY    #table_a8a6
6A83: 6E B6          JMP    [A,Y]	; [jump_table]

init_game_playfield_6a85:
6A85: 4F             CLRA
6A86: 5F             CLRB
; reset sprites & scrolling to 0
6A87: 8E 18 00       LDX    #sprite_ram_1800
6A8A: ED 81          STD    ,X++			; [scroll_address_word] wrong tag but does the job
6A8C: 8C 1F 00       CMPX   #$1F00
6A8F: 26 F9          BNE    $6A8A
6A91: 8E 28 94       LDX    #$2894
6A94: 6F 80          CLR    ,X+
6A96: 8C 28 9C       CMPX   #$289C
6A99: 26 F9          BNE    $6A94
6A9B: 7F 2F E8       CLR    $2FE8
6A9E: 7F 2F EB       CLR    $2FEB
6AA1: 4F             CLRA
6AA2: 5F             CLRB
6AA3: 8E 28 B0       LDX    #$28B0
6AA6: ED 81          STD    ,X++
6AA8: 8C 28 D8       CMPX   #$28D8
6AAB: 26 F9          BNE    $6AA6
6AAD: 0F D8          CLR    angle_d8
6AAF: 8E 28 DA       LDX    #$28DA
6AB2: ED 81          STD    ,X++
6AB4: 8C 28 DE       CMPX   #$28DE
6AB7: 26 F9          BNE    $6AB2
6AB9: 0F DE          CLR    $DE
6ABB: 8E 2A 10       LDX    #$2A10
6ABE: ED 81          STD    ,X++
6AC0: 8C 2A 38       CMPX   #$2A38
6AC3: 26 F9          BNE    $6ABE
6AC5: 7F 2A 38       CLR    $2A38
6AC8: 8E 2A 3A       LDX    #$2A3A
6ACB: ED 81          STD    ,X++
6ACD: 8C 2A 3E       CMPX   #$2A3E
6AD0: 26 F9          BNE    $6ACB
6AD2: 7F 2A 3E       CLR    $2A3E
6AD5: 96 84          LDA    current_level_84
6AD7: 81 00          CMPA   #$00
6AD9: 27 09          BEQ    $6AE4
6ADB: 81 03          CMPA   #$03
6ADD: 27 05          BEQ    $6AE4
6ADF: 0F D9          CLR    false_start_D9
6AE1: 7F 2A 39       CLR    $2A39
6AE4: 0F 4B          CLR    $4B
6AE6: 0F A0          CLR    $A0
6AE8: 7F 2A 00       CLR    $2A00
6AEB: C6 04          LDB    #$04
6AED: 8E 29 A0       LDX    #$29A0
6AF0: 6F 84          CLR    ,X
6AF2: 30 88 20       LEAX   $20,X
6AF5: 5A             DECB
6AF6: 26 F8          BNE    $6AF0
6AF8: 7F 2A 40       CLR    $2A40
6AFB: 7F 2A C0       CLR    $2AC0
6AFE: 7F 2A E0       CLR    $2AE0
6B01: BD 8A 3F       JSR    $8A3F
6B04: 96 84          LDA    current_level_84
6B06: 81 00          CMPA   #$00
6B08: 27 0C          BEQ    $6B16
6B0A: 81 03          CMPA   #$03
6B0C: 27 08          BEQ    $6B16
6B0E: BD 8E BC       JSR    $8EBC
6B11: BD 8F 1E       JSR    $8F1E
6B14: 20 32          BRA    $6B48
6B16: BD 8F F6       JSR    $8FF6
6B19: 86 06          LDA    #$06
6B1B: BD 84 F5       JSR    queue_event_84f5
6B1E: CE 32 0B       LDU    #$320B
6B21: C6 03          LDB    #$03
6B23: BD 8A 15       JSR    $8A15
6B26: CE 32 4B       LDU    #$324B
6B29: C6 03          LDB    #$03
6B2B: BD 8A 15       JSR    $8A15
6B2E: 96 DF          LDA    $DF
6B30: 97 FB          STA    $FB
6B32: 84 02          ANDA   #$02
6B34: 97 DF          STA    $DF
6B36: BD 8F 1E       JSR    $8F1E
6B39: BD 90 74       JSR    $9074
6B3C: 0C DF          INC    $DF
6B3E: BD 8F B8       JSR    $8FB8
6B41: BD 90 74       JSR    $9074
6B44: 96 FB          LDA    $FB
6B46: 97 DF          STA    $DF
6B48: 0C 09          INC    $09
6B4A: 39             RTS

6B4B: BD 8E CC       JSR    $8ECC
6B4E: BD 8E F0       JSR    $8EF0
6B51: 4F             CLRA
6B52: D6 2D          LDB    dsw2_copy_2d
6B54: C4 04          ANDB   #$04
6B56: 26 08          BNE    $6B60
6B58: D6 DF          LDB    $DF
6B5A: C4 02          ANDB   #$02
6B5C: 27 02          BEQ    $6B60
6B5E: 86 01          LDA    #$01
6B60: B7 10 80       STA    flip_screen_set_1080
6B63: 97 21          STA    copy_of_screen_flipped_21
6B65: 96 84          LDA    current_level_84
6B67: 81 03          CMPA   #$03
6B69: 27 43          BEQ    $6BAE
6B6B: 81 00          CMPA   #$00
6B6D: 27 3F          BEQ    $6BAE
6B6F: 81 04          CMPA   #$04
6B71: 10 27 00 E6    LBEQ   $6C5B
6B75: 10 8E A8 B4    LDY    #$A8B4
6B79: 48             ASLA
6B7A: 10 AE A6       LDY    A,Y
6B7D: CE 37 00       LDU    #$3700
6B80: DF 85          STU    $85
6B82: FF 2F E9       STU    $2FE9
6B85: E6 A0          LDB    ,Y+
6B87: D8 73          EORB   $73
6B89: D7 89          STB    $89
6B8B: 86 0B          LDA    #$0B
6B8D: 97 48          STA    nb_objects_48
6B8F: E7 C9 08 00    STB    $0800,U		; [video_address]
6B93: A6 A0          LDA    ,Y+
6B95: A7 C4          STA    ,U			; [video_address]
6B97: 33 C8 C0       LEAU   -$40,U
6B9A: 0A 48          DEC    nb_objects_48
6B9C: 26 F1          BNE    $6B8F
6B9E: 33 C9 02 C1    LEAU   $02C1,U
6BA2: 11 83 37 40    CMPU   #$3740
6BA6: 26 E3          BNE    $6B8B
6BA8: 10 9F 87       STY    $87
6BAB: 16 00 B4       LBRA   $6C62
6BAE: CE 35 C0       LDU    #$35C0
6BB1: C6 20          LDB    #$20
6BB3: BD 8A 15       JSR    $8A15
6BB6: CE A8 B0       LDU    #$A8B0
6BB9: 4F             CLRA
6BBA: D6 84          LDB    current_level_84
6BBC: C1 00          CMPB   #$00
6BBE: 27 01          BEQ    $6BC1
6BC0: 4C             INCA
6BC1: 48             ASLA
6BC2: 10 AE C6       LDY    A,U
6BC5: CE 37 00       LDU    #$3700
6BC8: DF 85          STU    $85
6BCA: FF 2F E9       STU    $2FE9
6BCD: E6 A0          LDB    ,Y+
6BCF: D8 73          EORB   $73
6BD1: D7 89          STB    $89
6BD3: 86 05          LDA    #$05
6BD5: 97 48          STA    nb_objects_48
6BD7: E7 C9 08 00    STB    $0800,U			; [video_address]
6BDB: A6 A0          LDA    ,Y+
6BDD: A7 C4          STA    ,U				; [video_address]
6BDF: 33 C8 C0       LEAU   -$40,U
6BE2: 0A 48          DEC    nb_objects_48
6BE4: 26 F1          BNE    $6BD7
6BE6: 33 C9 01 41    LEAU   $0141,U
6BEA: 11 83 37 40    CMPU   #$3740
6BEE: 26 E3          BNE    $6BD3
6BF0: 10 9F 87       STY    $87
6BF3: CE A8 B0       LDU    #$A8B0
6BF6: 4F             CLRA
6BF7: D6 84          LDB    current_level_84
6BF9: C1 00          CMPB   #$00
6BFB: 27 01          BEQ    $6BFE
6BFD: 4C             INCA
6BFE: 48             ASLA
6BFF: 10 AE C6       LDY    A,U
6C02: CE 35 80       LDU    #$3580
6C05: DF 77          STU    $77
6C07: FF 2F EC       STU    $2FEC
6C0A: E6 A0          LDB    ,Y+
6C0C: D8 73          EORB   $73
6C0E: D7 7B          STB    $7B
6C10: 86 05          LDA    #$05
6C12: 97 48          STA    nb_objects_48
6C14: E7 C9 08 00    STB    $0800,U			; [video_address]
6C18: A6 A0          LDA    ,Y+
6C1A: A7 C4          STA    ,U			    ; [video_address]
6C1C: 33 C8 C0       LEAU   -$40,U
6C1F: 0A 48          DEC    nb_objects_48
6C21: 26 F1          BNE    $6C14
6C23: 33 C9 01 41    LEAU   $0141,U
6C27: 11 83 35 C0    CMPU   #$35C0
6C2B: 26 E3          BNE    $6C10
6C2D: 10 9F 79       STY    $79
6C30: 96 DF          LDA    $DF
6C32: 84 02          ANDA   #$02
6C34: 26 0E          BNE    $6C44
6C36: CC A4 A5       LDD    #$A4A5
6C39: FD 35 41       STD    $3541
6C3C: CC 80 80       LDD    #$8080
6C3F: FD 3D 41       STD    $3D41
6C42: 20 1E          BRA    $6C62
6C44: CC 66 67       LDD    #$6667
6C47: FD 36 C1       STD    $36C1
6C4A: CC 68 69       LDD    #$6869
6C4D: FD 35 41       STD    $3541
6C50: CC 80 80       LDD    #$8080
6C53: FD 3E C1       STD    $3EC1
6C56: FD 3D 41       STD    $3D41
6C59: 20 07          BRA    $6C62
6C5B: 10 8E B4 DE    LDY    #$B4DE
6C5F: BD A3 F8       JSR    $A3F8
6C62: 0C 09          INC    $09
6C64: 39             RTS

6C65: BD 87 FB       JSR    $87FB
6C68: 8E 28 A0       LDX    #$28A0
6C6B: 96 84          LDA    current_level_84
6C6D: 81 00          CMPA   #$00
6C6F: 27 16          BEQ    $6C87
6C71: 81 03          CMPA   #$03
6C73: 27 12          BEQ    $6C87
6C75: 81 04          CMPA   #$04
6C77: 27 27          BEQ    $6CA0
6C79: BD CB 17       JSR    $CB17
6C7C: 96 84          LDA    current_level_84
6C7E: 81 02          CMPA   #$02
6C80: 26 32          BNE    $6CB4
6C82: BD EA 1D       JSR    $EA1D
6C85: 20 2D          BRA    $6CB4
6C87: 96 DF          LDA    $DF
6C89: 97 FB          STA    $FB
6C8B: 84 02          ANDA   #$02
6C8D: 97 DF          STA    $DF
6C8F: BD CB 17       JSR    $CB17
6C92: 0C DF          INC    $DF
6C94: 8E 2A 00       LDX    #$2A00
6C97: BD CB 17       JSR    $CB17
6C9A: 96 FB          LDA    $FB
6C9C: 97 DF          STA    $DF
6C9E: 20 14          BRA    $6CB4
6CA0: CC DD E2       LDD    #$DDE2
6CA3: DD AE          STD    $AE
6CA5: 0F D0          CLR    $D0
6CA7: 86 01          LDA    #$01
6CA9: 97 A5          STA    $A5
6CAB: BD CB C5       JSR    $CBC5
6CAE: 8E 2A 00       LDX    #$2A00
6CB1: BD CC 2D       JSR    $CC2D
6CB4: BD 8E CC       JSR    $8ECC
6CB7: BD 8E F0       JSR    $8EF0
6CBA: 96 84          LDA    current_level_84
6CBC: 81 05          CMPA   #$05
6CBE: 27 11          BEQ    $6CD1
6CC0: 81 00          CMPA   #$00
6CC2: 27 0D          BEQ    $6CD1
6CC4: 81 03          CMPA   #$03
6CC6: 27 09          BEQ    $6CD1
6CC8: BD 87 58       JSR    $8758
6CCB: 96 84          LDA    current_level_84
6CCD: 81 04          CMPA   #$04
6CCF: 27 06          BEQ    $6CD7
6CD1: BD 8B 3A       JSR    $8B3A
6CD4: BD 8B 71       JSR    $8B71
6CD7: BD 8B A3       JSR    $8BA3
6CDA: 0D 22          TST    $22
6CDC: 26 05          BNE    $6CE3
6CDE: 0C 06          INC    $06
6CE0: 0F 09          CLR    $09
6CE2: 39             RTS

6CE3: CC 01 00       LDD    #$0100
6CE6: BD 84 F5       JSR    queue_event_84f5
6CE9: 86 02          LDA    #$02
6CEB: D6 DF          LDB    $DF
6CED: BD 84 F5       JSR    queue_event_84f5
6CF0: 86 05          LDA    #$05
6CF2: BD 84 F5       JSR    queue_event_84f5
6CF5: CC 02 07       LDD    #$0207
6CF8: BD 84 F5       JSR    queue_event_84f5
6CFB: 96 84          LDA    current_level_84
6CFD: 81 00          CMPA   #$00
6CFF: 27 04          BEQ    $6D05
6D01: 81 03          CMPA   #$03
6D03: 26 20          BNE    $6D25
6D05: 86 02          LDA    #$02
6D07: D6 DF          LDB    $DF
6D09: CB 08          ADDB   #$08
6D0B: BD 84 F5       JSR    queue_event_84f5
6D0E: 86 0D          LDA    #$0D
6D10: BD 84 F5       JSR    queue_event_84f5
6D13: 96 DF          LDA    $DF
6D15: 84 01          ANDA   #$01
6D17: 27 0C          BEQ    $6D25
6D19: CC 01 0B       LDD    #$010B
6D1C: BD 84 F5       JSR    queue_event_84f5
6D1F: CC 02 21       LDD    #$0221
6D22: BD 84 F5       JSR    queue_event_84f5
6D25: 86 80          LDA    #$80
6D27: 97 0B          STA    $0B
6D29: 0C 09          INC    $09
6D2B: 39             RTS

6D2C: BD 8E CC       JSR    $8ECC
6D2F: BD 8E F0       JSR    $8EF0
6D32: 96 84          LDA    current_level_84
6D34: 81 00          CMPA   #$00
6D36: 27 04          BEQ    $6D3C
6D38: 81 03          CMPA   #$03
6D3A: 26 0E          BNE    $6D4A
6D3C: 96 DF          LDA    $DF
6D3E: 84 01          ANDA   #$01
6D40: 26 05          BNE    $6D47
6D42: BD 8D 8D       JSR    $8D8D
6D45: 20 03          BRA    $6D4A
6D47: BD 8D 92       JSR    $8D92
6D4A: BD CE 9F       JSR    $CE9F
6D4D: BD 8D B0       JSR    $8DB0
6D50: 0A 0B          DEC    $0B
6D52: 26 11          BNE    $6D65
6D54: 7F 2A B5       CLR    $2AB5
6D57: 96 84          LDA    current_level_84
6D59: 81 00          CMPA   #$00
6D5B: 27 09          BEQ    $6D66
6D5D: 81 03          CMPA   #$03
6D5F: 27 05          BEQ    $6D66
6D61: 0C 06          INC    $06
6D63: 0F 09          CLR    $09
6D65: 39             RTS

6D66: CE 3E C4       LDU    #$3EC4
6D69: BD 8D 9D       JSR    $8D9D
6D6C: 96 DF          LDA    $DF
6D6E: 84 01          ANDA   #$01
6D70: 26 EF          BNE    $6D61
6D72: 0C DF          INC    $DF
6D74: 8E 2B 80       LDX    #$2B80
6D77: 96 DF          LDA    $DF
6D79: C6 20          LDB    #$20
6D7B: 3D             MUL
6D7C: 30 8B          LEAX   D,X
6D7E: A6 84          LDA    ,X
6D80: 27 36          BEQ    $6DB8
6D82: 8E 28 EC       LDX    #$28EC
6D85: 96 DF          LDA    $DF
6D87: A6 86          LDA    A,X
6D89: 26 2D          BNE    $6DB8
6D8B: CC 01 00       LDD    #$0100
6D8E: BD 84 F5       JSR    queue_event_84f5
6D91: 86 02          LDA    #$02
6D93: D6 DF          LDB    $DF
6D95: BD 84 F5       JSR    queue_event_84f5
6D98: 86 05          LDA    #$05
6D9A: BD 84 F5       JSR    queue_event_84f5
6D9D: CC 02 07       LDD    #$0207
6DA0: BD 84 F5       JSR    queue_event_84f5
6DA3: 86 02          LDA    #$02
6DA5: D6 DF          LDB    $DF
6DA7: CB 08          ADDB   #$08
6DA9: BD 84 F5       JSR    queue_event_84f5
6DAC: 86 0D          LDA    #$0D
6DAE: BD 84 F5       JSR    queue_event_84f5
6DB1: 86 80          LDA    #$80
6DB3: 97 0B          STA    $0B
6DB5: 0C 09          INC    $09
6DB7: 39             RTS

6DB8: CC 01 0B       LDD    #$010B
6DBB: BD 84 F5       JSR    queue_event_84f5
6DBE: CC 02 22       LDD    #$0222
6DC1: BD 84 F5       JSR    queue_event_84f5
6DC4: 0C 06          INC    $06
6DC6: 0F 09          CLR    $09
6DC8: 39             RTS

6DC9: BD 8E CC       JSR    $8ECC
6DCC: BD 8E F0       JSR    $8EF0
6DCF: BD 8D 92       JSR    $8D92
6DD2: BD CE 9F       JSR    $CE9F
6DD5: BD 8D B0       JSR    $8DB0
6DD8: 0A 0B          DEC    $0B
6DDA: 26 07          BNE    $6DE3
6DDC: 7F 2A B5       CLR    $2AB5
6DDF: 0C 06          INC    $06
6DE1: 0F 09          CLR    $09
6DE3: 39             RTS

6DE4: BD 8E CC       JSR    $8ECC
6DE7: BD 8E F0       JSR    $8EF0
6DEA: 96 09          LDA    $09
6DEC: 48             ASLA
6DED: 10 8E A8 C0    LDY    #table_a8c0
6DF1: 6E B6          JMP    [A,Y]		; [jump_table]

6DF3: 96 84          LDA    current_level_84
6DF5: 81 04          CMPA   #$04
6DF7: 27 09          BEQ    $6E02
6DF9: BD 8B 3A       JSR    $8B3A
6DFC: BD 8B 71       JSR    $8B71
6DFF: 0C 09          INC    $09
6E01: 39             RTS

6E02: 10 8E B4 DE    LDY    #$B4DE
6E06: BD A3 F8       JSR    $A3F8
6E09: 20 F4          BRA    $6DFF
6E0B: BD 87 FB       JSR    $87FB
6E0E: CE 18 28       LDU    #$1828
6E11: BD D2 74       JSR    $D274
6E14: 96 84          LDA    current_level_84
6E16: 81 00          CMPA   #$00
6E18: 27 04          BEQ    $6E1E
6E1A: 81 03          CMPA   #$03
6E1C: 26 10          BNE    $6E2E
6E1E: 0D 22          TST    $22
6E20: 27 0C          BEQ    $6E2E
6E22: CE 3E C4       LDU    #$3EC4
6E25: BD 8D 9D       JSR    $8D9D
6E28: CE 3D 44       LDU    #$3D44
6E2B: BD 8D 9D       JSR    $8D9D
6E2E: 0F 09          CLR    $09
6E30: 0F 06          CLR    $06
6E32: 0C 03          INC    boot_state_03
6E34: FC 2F E0       LDD    $2FE0		; [rom_check_code]
6E37: 10 83 0F A0    CMPD   #$0FA0		; [rom_check_code]
6E3B: 25 11          BCS    $6E4E		; [rom_check_code]
6E3D: B6 A6 C0       LDA    $A6C0		; [rom_check_code]
6E40: 81 4D          CMPA   #$4D        ; [rom_check_code]
6E42: 26 07          BNE    $6E4B       ; [rom_check_code]
6E44: B6 FC 71       LDA    $FC71       ; [rom_check_code]
6E47: 81 CC          CMPA   #$CC        ; [rom_check_code]
6E49: 27 03          BEQ    $6E4E       ; [rom_check_code]
6E4B: 16 81 AE       LBRA   $EFFC       ; [rom_check_code]
6E4E: 39             RTS

6E4F: BD 8A 9B       JSR    $8A9B
6E52: BD 8E 5F       JSR    $8E5F
6E55: 96 22          LDA    $22
6E57: 26 03          BNE    $6E5C
6E59: BD 90 C0       JSR    $90C0
6E5C: 96 84          LDA    current_level_84
6E5E: 81 00          CMPA   #$00
6E60: 27 0A          BEQ    $6E6C
6E62: 81 03          CMPA   #$03
6E64: 27 06          BEQ    $6E6C
6E66: BD 8F 1E       JSR    $8F1E
6E69: BD 8E CC       JSR    $8ECC
6E6C: 96 84          LDA    current_level_84
6E6E: 48             ASLA
6E6F: 10 8E A8 C4    LDY    #table_a8c4
6E73: 6E B6          JMP    [A,Y]	; [jump_table]

player_turn_ends_6e75:
6E75: BD 8E 5F       JSR    $8E5F
6E78: 96 22          LDA    $22
6E7A: 26 03          BNE    $6E7F
6E7C: BD 90 C0       JSR    $90C0
6E7F: 10 8E A8 D0    LDY    #table_a8d0
6E83: 96 06          LDA    $06
6E85: 48             ASLA
6E86: 6E B6          JMP    [A,Y]	; [jump_table]

6E88: 7F 2A B7       CLR    $2AB7
6E8B: 96 84          LDA    current_level_84
6E8D: 81 00          CMPA   #$00
6E8F: 10 27 00 68    LBEQ   $6EFB
6E93: 81 03          CMPA   #$03
6E95: 10 27 00 62    LBEQ   $6EFB
6E99: 81 05          CMPA   #$05
6E9B: 26 10          BNE    $6EAD
6E9D: 96 F4          LDA    $F4
6E9F: 27 57          BEQ    $6EF8
6EA1: 7C 2A B7       INC    $2AB7
6EA4: 96 9F          LDA    high_jump_fault_9f
6EA6: 81 02          CMPA   #$02
6EA8: 26 4E          BNE    $6EF8
6EAA: BD 87 92       JSR    $8792
6EAD: 8E 29 60       LDX    #player_1_final_time_2960
6EB0: 96 9F          LDA    high_jump_fault_9f
6EB2: D6 84          LDB    current_level_84
6EB4: C1 05          CMPB   #$05
6EB6: 26 02          BNE    $6EBA
6EB8: 96 7D          LDA    $7D
6EBA: 48             ASLA
6EBB: 48             ASLA
6EBC: 30 86          LEAX   A,X
6EBE: 96 DF          LDA    $DF
6EC0: C6 0C          LDB    #$0C
6EC2: 3D             MUL
6EC3: 30 8B          LEAX   D,X
6EC5: A6 84          LDA    ,X
6EC7: 81 16          CMPA   #$16
6EC9: 27 1A          BEQ    $6EE5
6ECB: 96 84          LDA    current_level_84
6ECD: 81 05          CMPA   #$05
6ECF: 27 0A          BEQ    $6EDB
6ED1: 86 A2          LDA    #$A2
6ED3: BD 85 0E       JSR    $850E
6ED6: 86 84          LDA    #$84
6ED8: BD 85 0E       JSR    $850E
6EDB: BD 6F 55       JSR    $6F55
6EDE: 86 FF          LDA    #$FF
6EE0: BD 85 0E       JSR    $850E
6EE3: 20 13          BRA    $6EF8
6EE5: 96 84          LDA    current_level_84
6EE7: 81 05          CMPA   #$05
6EE9: 27 0D          BEQ    $6EF8
6EEB: 7C 2A B7       INC    $2AB7
6EEE: 86 82          LDA    #$82
6EF0: BD 85 0E       JSR    $850E
6EF3: 86 FF          LDA    #$FF
6EF5: BD 85 0E       JSR    $850E
6EF8: 0C 06          INC    $06
6EFA: 39             RTS

6EFB: CE 29 60       LDU    #player_1_final_time_2960
6EFE: 96 DF          LDA    $DF
6F00: 84 02          ANDA   #$02
6F02: C6 0C          LDB    #$0C
6F04: 3D             MUL
6F05: 33 CB          LEAU   D,U
6F07: B6 2A B8       LDA    $2AB8
6F0A: 4A             DECA
6F0B: 44             LSRA
6F0C: 24 09          BCC    $6F17
6F0E: B6 2A 0A       LDA    $2A0A
6F11: 26 17          BNE    $6F2A
6F13: 30 4C          LEAX   $C,U
6F15: 20 06          BRA    $6F1D
6F17: 96 AA          LDA    $AA
6F19: 26 0F          BNE    $6F2A
6F1B: 1F 31          TFR    U,X
6F1D: 86 A2          LDA    #$A2
6F1F: BD 85 0E       JSR    $850E
6F22: 86 87          LDA    #$87
6F24: BD 85 0E       JSR    $850E
6F27: BD 6F 55       JSR    $6F55
6F2A: B6 2A B8       LDA    $2AB8
6F2D: 4A             DECA
6F2E: 44             LSRA
6F2F: 25 09          BCS    $6F3A
6F31: B6 2A 0A       LDA    $2A0A
6F34: 26 17          BNE    $6F4D
6F36: 30 4C          LEAX   $C,U
6F38: 20 06          BRA    $6F40
6F3A: 96 AA          LDA    $AA
6F3C: 26 0F          BNE    $6F4D
6F3E: 1F 31          TFR    U,X
6F40: 86 A2          LDA    #$A2
6F42: BD 85 0E       JSR    $850E
6F45: 86 87          LDA    #$87
6F47: BD 85 0E       JSR    $850E
6F4A: BD 6F 55       JSR    $6F55
6F4D: 86 FF          LDA    #$FF
6F4F: BD 85 0E       JSR    $850E
6F52: 0C 06          INC    $06
6F54: 39             RTS

6F55: A6 84          LDA    ,X
6F57: C6 0A          LDB    #$0A
6F59: 3D             MUL
6F5A: EB 01          ADDB   $1,X
6F5C: C1 0E          CMPB   #$0E
6F5E: 25 1C          BCS    $6F7C
6F60: C1 14          CMPB   #$14
6F62: 25 21          BCS    $6F85
6F64: 10 8E DE F7    LDY    #$DEF7
6F68: A6 84          LDA    ,X
6F6A: 80 02          SUBA   #$02
6F6C: A6 A6          LDA    A,Y
6F6E: BD 85 0E       JSR    $850E
6F71: A6 01          LDA    $1,X
6F73: 27 1B          BEQ    $6F90
6F75: 8B 90          ADDA   #$90
6F77: BD 85 0E       JSR    $850E
6F7A: 20 14          BRA    $6F90
6F7C: CB 90          ADDB   #$90
6F7E: 1F 98          TFR    B,A
6F80: BD 85 0E       JSR    $850E
6F83: 20 0B          BRA    $6F90
6F85: 10 8E DE F1    LDY    #$DEF1
6F89: C0 0E          SUBB   #$0E
6F8B: A6 A5          LDA    B,Y
6F8D: BD 85 0E       JSR    $850E
6F90: 86 85          LDA    #$85
6F92: BD 85 0E       JSR    $850E
6F95: A6 02          LDA    $2,X
6F97: 8B 90          ADDA   #$90
6F99: 81 96          CMPA   #$96
6F9B: 26 02          BNE    $6F9F
6F9D: 86 A0          LDA    #$A0
6F9F: BD 85 0E       JSR    $850E
6FA2: A6 03          LDA    $3,X
6FA4: 8B 90          ADDA   #$90
6FA6: 81 96          CMPA   #$96
6FA8: 26 02          BNE    $6FAC
6FAA: 86 A0          LDA    #$A0
6FAC: BD 85 0E       JSR    $850E
6FAF: 86 86          LDA    #$86
6FB1: D6 E6          LDB    $E6
6FB3: C1 1D          CMPB   #$1D
6FB5: 27 02          BEQ    $6FB9
6FB7: 86 88          LDA    #$88
6FB9: 7E 85 0E       JMP    $850E
6FBC: 0F 7E          CLR    chrono_hundredth_second_7e
6FBE: 0F 7F          CLR    chrono_second_7f
6FC0: 0F FE          CLR    $FE
6FC2: 0F FF          CLR    $FF
6FC4: 7F 2A 5E       CLR    $2A5E
6FC7: 7F 2A 5F       CLR    $2A5F
6FCA: 96 84          LDA    current_level_84
6FCC: 81 00          CMPA   #$00
6FCE: 10 27 00 D1    LBEQ   $70A3
6FD2: 81 03          CMPA   #$03
6FD4: 10 27 00 CB    LBEQ   $70A3
6FD8: 96 22          LDA    $22
6FDA: 27 1D          BEQ    $6FF9
6FDC: 96 84          LDA    current_level_84
6FDE: 81 05          CMPA   #$05
6FE0: 27 03          BEQ    $6FE5
6FE2: BD 87 09       JSR    $8709
6FE5: BD 71 3B       JSR    $713B
6FE8: BD 88 CD       JSR    $88CD
6FEB: 86 06          LDA    #$06
6FED: BD 84 F5       JSR    queue_event_84f5
6FF0: BD 8E BC       JSR    $8EBC
6FF3: BD 8F 1E       JSR    $8F1E
6FF6: BD 8E CC       JSR    $8ECC
6FF9: 0F 0A          CLR    $0A
6FFB: 96 84          LDA    current_level_84
6FFD: 81 05          CMPA   #$05
6FFF: 26 0A          BNE    $700B
7001: 96 F4          LDA    $F4
7003: 26 32          BNE    $7037
7005: 86 01          LDA    #$01
7007: 97 0A          STA    $0A
7009: 20 09          BRA    $7014
700B: BD 87 7A       JSR    check_player_qualified_877a
700E: 96 CD          LDA    player_is_qualified_cd
7010: 27 25          BEQ    $7037
7012: 0C 0A          INC    $0A
7014: 8E 28 A0       LDX    #$28A0
7017: A6 01          LDA    $1,X
7019: 84 F8          ANDA   #$F8
701B: A7 01          STA    $1,X
701D: CC DE B2       LDD    #$DEB2
7020: ED 0E          STD    $E,X
7022: BD CB 23       JSR    $CB23
7025: BD D8 4A       JSR    $D84A
7028: 96 E8          LDA    $E8
702A: 26 45          BNE    $7071
702C: 4F             CLRA
702D: BD 85 0E       JSR    $850E
7030: 86 41          LDA    #$41
7032: BD 85 0E       JSR    $850E
7035: 20 3A          BRA    $7071
7037: 8E 28 A0       LDX    #$28A0
703A: 96 84          LDA    current_level_84
703C: 81 05          CMPA   #$05
703E: 26 09          BNE    $7049
7040: CE AB 3B       LDU    #$AB3B
7043: 86 32          LDA    #$32
7045: A6 C6          LDA    A,U
7047: A7 01          STA    $1,X
7049: 96 9F          LDA    high_jump_fault_9f
704B: 81 02          CMPA   #$02
704D: 26 0A          BNE    $7059
704F: BD 71 3B       JSR    $713B
7052: BD 87 7D       JSR    $877D
7055: 96 CD          LDA    player_is_qualified_cd
7057: 27 0D          BEQ    $7066
7059: 8E 28 A0       LDX    #$28A0
705C: CC DE BD       LDD    #$DEBD
705F: ED 0E          STD    $E,X
7061: BD CB 2F       JSR    $CB2F
7064: 20 0B          BRA    $7071
7066: 8E 28 A0       LDX    #$28A0
7069: CC DD 87       LDD    #$DD87
706C: ED 0E          STD    $E,X
706E: BD CB 29       JSR    $CB29
7071: 96 E8          LDA    $E8
7073: 27 0E          BEQ    $7083
7075: BD D9 93       JSR    $D993
7078: BD D9 B2       JSR    $D9B2
707B: BD 8C 1D       JSR    clear_sprites_8c1d
707E: 86 33          LDA    #$33
7080: BD 85 0E       JSR    $850E
7083: 86 F0          LDA    #$F0
7085: D6 84          LDB    current_level_84
7087: C1 00          CMPB   #$00
7089: 27 13          BEQ    $709E
708B: C1 03          CMPB   #$03
708D: 27 0F          BEQ    $709E
708F: D6 61          LDB    $61
7091: 26 0B          BNE    $709E
7093: D6 63          LDB    $63
7095: 26 07          BNE    $709E
7097: F6 2A B7       LDB    $2AB7
709A: 27 02          BEQ    $709E
709C: 86 50          LDA    #$50
709E: 97 08          STA    $08
70A0: 0C 06          INC    $06
70A2: 39             RTS

70A3: 96 DF          LDA    $DF
70A5: 84 02          ANDA   #$02
70A7: 97 DF          STA    $DF
70A9: 0F 0A          CLR    $0A
70AB: 86 02          LDA    #$02
70AD: 97 49          STA    $49
70AF: 96 AA          LDA    $AA
70B1: D6 DF          LDB    $DF
70B3: C4 01          ANDB   #$01
70B5: 27 03          BEQ    $70BA
70B7: B6 2A 0A       LDA    $2A0A
70BA: 4D             TSTA
70BB: 26 09          BNE    $70C6
70BD: BD 87 7A       JSR    check_player_qualified_877a
70C0: 96 CD          LDA    player_is_qualified_cd
70C2: 27 41          BEQ    $7105
70C4: 0C 0A          INC    $0A
70C6: 8E 28 A0       LDX    #$28A0
70C9: 96 DF          LDA    $DF
70CB: 84 01          ANDA   #$01
70CD: 27 03          BEQ    $70D2
70CF: 8E 2A 00       LDX    #$2A00
70D2: B6 2A B8       LDA    $2AB8
70D5: 4A             DECA
70D6: 97 48          STA    nb_objects_48
70D8: 96 DF          LDA    $DF
70DA: 84 01          ANDA   #$01
70DC: 91 48          CMPA   nb_objects_48
70DE: 27 0A          BEQ    $70EA
70E0: CC DE BD       LDD    #$DEBD
70E3: ED 0E          STD    $E,X
70E5: BD CB 2F       JSR    $CB2F
70E8: 20 08          BRA    $70F2
70EA: CC DE B2       LDD    #$DEB2
70ED: ED 0E          STD    $E,X
70EF: BD CB 23       JSR    $CB23
70F2: 96 AA          LDA    $AA
70F4: D6 DF          LDB    $DF
70F6: C4 01          ANDB   #$01
70F8: 27 03          BEQ    $70FD
70FA: B6 2A 0A       LDA    $2A0A
70FD: 4D             TSTA
70FE: 26 19          BNE    $7119
7100: BD D8 4A       JSR    $D84A
7103: 20 14          BRA    $7119
7105: 8E 28 A0       LDX    #$28A0
7108: 96 DF          LDA    $DF
710A: 84 01          ANDA   #$01
710C: 27 03          BEQ    $7111
710E: 8E 2A 00       LDX    #$2A00
7111: CC DD 87       LDD    #$DD87
7114: ED 0E          STD    $E,X
7116: BD CB 29       JSR    $CB29
7119: 0C DF          INC    $DF
711B: 0A 49          DEC    $49
711D: 26 90          BNE    $70AF
711F: 0A DF          DEC    $DF
7121: 96 DF          LDA    $DF
7123: 84 02          ANDA   #$02
7125: 97 DF          STA    $DF
7127: 96 0A          LDA    $0A
7129: 27 0D          BEQ    $7138
712B: 96 E8          LDA    $E8
712D: 26 09          BNE    $7138
712F: 4F             CLRA
7130: BD 85 0E       JSR    $850E
7133: 86 41          LDA    #$41
7135: BD 85 0E       JSR    $850E
7138: 16 FF 36       LBRA   $7071
713B: 0F 7D          CLR    $7D
713D: BD 87 92       JSR    $8792
7140: 8E 29 60       LDX    #player_1_final_time_2960
7143: 96 DF          LDA    $DF
7145: C6 0C          LDB    #$0C
7147: 3D             MUL
7148: 30 8B          LEAX   D,X
714A: 96 7D          LDA    $7D
714C: 48             ASLA
714D: 48             ASLA
714E: 30 86          LEAX   A,X
7150: 39             RTS

7151: BD 8E CC       JSR    $8ECC
7154: BD 8E F0       JSR    $8EF0
7157: 96 E8          LDA    $E8
7159: 26 58          BNE    $71B3
715B: 7F 2A B9       CLR    $2AB9
715E: 8E 28 A0       LDX    #$28A0
7161: CE 18 08       LDU    #$1808
7164: BD CB A5       JSR    $CBA5
7167: 8E 2A 00       LDX    #$2A00
716A: A6 84          LDA    ,X
716C: 27 06          BEQ    $7174
716E: CE 18 10       LDU    #$1810
7171: BD CB A5       JSR    $CBA5
7174: BD 97 1B       JSR    $971B
7177: 96 0A          LDA    $0A
7179: 27 36          BEQ    $71B1
717B: 8E 3B 40       LDX    #$3B40
717E: 86 04          LDA    #$04
7180: D6 3F          LDB    $3F
7182: C4 08          ANDB   #$08
7184: 27 02          BEQ    $7188
7186: 86 03          LDA    #$03
7188: D6 84          LDB    current_level_84
718A: C1 04          CMPB   #$04
718C: 27 1A          BEQ    $71A8
718E: A7 80          STA    ,X+		; [video_address]
7190: 8C 3C 00       CMPX   #$3C00
7193: 26 F9          BNE    $718E
7195: D6 84          LDB    current_level_84
7197: C1 05          CMPB   #$05
7199: 27 04          BEQ    $719F
719B: C1 02          CMPB   #$02
719D: 26 12          BNE    $71B1
719F: A7 80          STA    ,X+		; [video_address]
71A1: 8C 3C 80       CMPX   #$3C80
71A4: 26 F9          BNE    $719F
71A6: 20 09          BRA    $71B1
71A8: 8A 80          ORA    #$80
71AA: A7 80          STA    ,X+		; [video_address]
71AC: 8C 3B C0       CMPX   #$3BC0
71AF: 26 F9          BNE    $71AA
71B1: 20 29          BRA    $71DC
71B3: 86 01          LDA    #$01
71B5: B7 2A B9       STA    $2AB9
71B8: 8E 39 16       LDX    #$3916
71BB: 96 E8          LDA    $E8
71BD: 27 1D          BEQ    $71DC
71BF: 4A             DECA
71C0: C6 40          LDB    #$40
71C2: 3D             MUL
71C3: 30 8B          LEAX   D,X
71C5: 86 09          LDA    #$09
71C7: 97 48          STA    nb_objects_48
71C9: 86 0A          LDA    #$0A
71CB: D6 3F          LDB    $3F
71CD: C4 08          ANDB   #$08
71CF: 27 02          BEQ    $71D3
71D1: 86 00          LDA    #$00
71D3: A7 80          STA    ,X+		; [video_address]
71D5: 0A 48          DEC    nb_objects_48
71D7: 26 FA          BNE    $71D3
71D9: BD D9 D3       JSR    $D9D3
71DC: 0A 08          DEC    $08
71DE: 26 44          BNE    $7224
71E0: 0F 61          CLR    $61
71E2: 96 E7          LDA    $E7
71E4: 27 0E          BEQ    $71F4
71E6: 97 E8          STA    $E8
71E8: 0F E7          CLR    $E7
71EA: 86 33          LDA    #$33
71EC: BD 85 0E       JSR    $850E
71EF: 96 F0          LDA    $F0
71F1: 97 08          STA    $08
71F3: 39             RTS

71F4: 8E 39 16       LDX    #$3916
71F7: 86 03          LDA    #$03
71F9: 97 49          STA    $49
71FB: 86 0A          LDA    #$0A
71FD: A7 80          STA    ,X+		; [video_address]
71FF: A7 80          STA    ,X+		; [video_address]
7201: 86 09          LDA    #$09
7203: A7 80          STA    ,X+		; [video_address]
7205: 86 06          LDA    #$06
7207: 97 48          STA    nb_objects_48
7209: 86 0A          LDA    #$0A
720B: A7 80          STA    ,X+		; [video_address]
720D: 0A 48          DEC    nb_objects_48
720F: 26 FA          BNE    $720B
7211: 30 88 37       LEAX   $37,X
7214: 0A 49          DEC    $49
7216: 26 E3          BNE    $71FB
7218: 0F 63          CLR    $63
721A: 0F E8          CLR    $E8
721C: 0C 03          INC    boot_state_03
721E: 0F 06          CLR    $06
7220: 0F 09          CLR    $09
7222: 0F 0A          CLR    $0A
7224: 39             RTS

7225: 8E A8 D6       LDX    #table_a8d6
7228: 96 06          LDA    $06
722A: 48             ASLA
722B: 6E 96          JMP    [A,X]	; [jump_table]

722D: 4F             CLRA
722E: 5F             CLRB
722F: FD 29 DB       STD    $29DB
7232: FD 2A 5E       STD    $2A5E
7235: 8E 29 E0       LDX    #$29E0
7238: ED 81          STD    ,X++
723A: 8C 29 F8       CMPX   #$29F8
723D: 26 F9          BNE    $7238
723F: 8E 2F E8       LDX    #$2FE8
7242: ED 81          STD    ,X++
7244: 8C 2F EE       CMPX   #$2FEE
7247: 26 F9          BNE    $7242
7249: 8E 2F F0       LDX    #$2FF0
724C: ED 81          STD    ,X++
724E: 8C 2F FE       CMPX   #$2FFE
7251: 26 F9          BNE    $724C
7253: A7 84          STA    ,X
7255: B6 2F FF       LDA    $2FFF
7258: 84 C0          ANDA   #$C0
725A: B7 2F FF       STA    $2FFF
725D: 96 84          LDA    current_level_84
725F: 81 04          CMPA   #$04
7261: 26 0C          BNE    $726F
7263: CE 18 10       LDU    #$1810
7266: BD D2 8C       JSR    $D28C
7269: CE 18 22       LDU    #$1822
726C: BD D2 8C       JSR    $D28C
726F: 96 22          LDA    $22
7271: 27 19          BEQ    $728C
7273: 96 84          LDA    current_level_84
7275: 81 05          CMPA   #$05
7277: 26 04          BNE    $727D
7279: 0D F4          TST    $F4
727B: 27 0C          BEQ    $7289
727D: 0C 9F          INC    high_jump_fault_9f
727F: 96 84          LDA    current_level_84
7281: 81 00          CMPA   #$00
7283: 27 07          BEQ    $728C
7285: 81 03          CMPA   #$03
7287: 27 03          BEQ    $728C
7289: BD 8A 2A       JSR    $8A2A
728C: 0C 06          INC    $06
728E: 39             RTS

; high jump over
728F: 96 9F          LDA    high_jump_fault_9f
7291: 91 E1          CMPA   max_accepted_faults_e1
7293: 26 27          BNE    $72BC
7295: 0D 22          TST    $22
7297: 26 09          BNE    $72A2
7299: 0C 12          INC    $12
729B: 0F 03          CLR    boot_state_03
729D: 0F 06          CLR    $06
729F: 0F 09          CLR    $09
72A1: 39             RTS

72A2: 96 84          LDA    current_level_84
72A4: 81 00          CMPA   #$00
72A6: 27 0B          BEQ    $72B3
72A8: 81 03          CMPA   #$03
72AA: 27 07          BEQ    $72B3
; end of level
72AC: 0C 03          INC    boot_state_03
72AE: 0F 06          CLR    $06
72B0: 0F 09          CLR    $09
72B2: 39             RTS

72B3: 0C 03          INC    boot_state_03
72B5: 0F 06          CLR    $06
72B7: 86 03          LDA    #$03
72B9: 97 09          STA    $09
72BB: 39             RTS

72BC: 86 04          LDA    #$04
72BE: 97 48          STA    nb_objects_48
72C0: 8E 2B 80       LDX    #$2B80
72C3: 96 DF          LDA    $DF
72C5: 4C             INCA
72C6: 84 03          ANDA   #$03
72C8: 97 DF          STA    $DF
72CA: C6 20          LDB    #$20
72CC: 3D             MUL
72CD: 30 8B          LEAX   D,X
72CF: A6 84          LDA    ,X
72D1: 27 07          BEQ    $72DA
72D3: A6 88 1F       LDA    $1F,X
72D6: 91 E1          CMPA   max_accepted_faults_e1
72D8: 25 08          BCS    $72E2
72DA: 0A 48          DEC    nb_objects_48
72DC: 26 E2          BNE    $72C0
72DE: 0C 03          INC    boot_state_03
72E0: 20 04          BRA    $72E6
72E2: 86 01          LDA    #$01
72E4: 97 03          STA    boot_state_03
72E6: 0F 06          CLR    $06
72E8: 0F 09          CLR    $09
72EA: 39             RTS

72EB: 8E A8 DA       LDX    #table_a8da
72EE: 96 06          LDA    $06
72F0: 48             ASLA
72F1: 6E 96          JMP    [A,X]	; [jump_table]

72F3: 8E A8 E8       LDX    #table_a8e8
72F6: 96 09          LDA    $09
72F8: 48             ASLA
72F9: 6E 96          JMP    [A,X]	; [jump_table]

72FB: BD 87 92       JSR    $8792
72FE: 8E 29 60       LDX    #player_1_final_time_2960
7301: 96 DF          LDA    $DF
7303: C6 0C          LDB    #$0C
7305: 3D             MUL
7306: 30 8B          LEAX   D,X
7308: 96 7D          LDA    $7D
730A: 48             ASLA
730B: 48             ASLA
730C: 30 86          LEAX   A,X
730E: BD 87 7D       JSR    $877D
7311: 96 CD          LDA    player_is_qualified_cd
7313: 26 16          BNE    $732B
7315: 0A 81          DEC    p1_attempts_left_81
7317: 26 12          BNE    $732B
7319: 96 80          LDA    $80
731B: 97 48          STA    nb_objects_48
731D: 0F 80          CLR    $80
731F: BD 8A 2A       JSR    $8A2A
7322: 96 48          LDA    nb_objects_48
7324: 97 80          STA    $80
7326: 0F 9F          CLR    high_jump_fault_9f
7328: 0C 09          INC    $09
732A: 39             RTS

732B: BD 8A 2A       JSR    $8A2A
732E: 0F 9F          CLR    high_jump_fault_9f
7330: 0C 09          INC    $09
7332: 0C 09          INC    $09
7334: 86 01          LDA    #$01
7336: 97 0B          STA    $0B
7338: 39             RTS

7339: BD 8C 3E       JSR    partially_reset_scrolling_8c3e
733C: B6 2A B9       LDA    $2AB9
733F: 27 03          BEQ    $7344
7341: BD D9 93       JSR    $D993
7344: BD 8B A3       JSR    $8BA3
7347: 86 2D          LDA    #$2D
7349: BD 85 0E       JSR    $850E
734C: CC 01 00       LDD    #$0100
734F: BD 84 F5       JSR    queue_event_84f5
7352: 86 02          LDA    #$02
7354: D6 DF          LDB    $DF
7356: BD 84 F5       JSR    queue_event_84f5
7359: 86 05          LDA    #$05
735B: BD 84 F5       JSR    queue_event_84f5
735E: CC 02 05       LDD    #$0205
7361: BD 84 F5       JSR    queue_event_84f5
7364: 86 01          LDA    #$01
7366: B7 2A B4       STA    $2AB4
7369: 86 80          LDA    #$80
736B: 97 0B          STA    $0B
736D: 0C 09          INC    $09
736F: 39             RTS

7370: B6 2A B4       LDA    $2AB4
7373: 27 03          BEQ    $7378
7375: BD 8D B0       JSR    $8DB0
7378: 0A 0B          DEC    $0B
737A: 26 37          BNE    $73B3
737C: 7F 2A B4       CLR    $2AB4
737F: 96 DF          LDA    $DF
7381: D6 84          LDB    current_level_84
7383: C1 05          CMPB   #$05
7385: 27 04          BEQ    $738B
7387: 91 60          CMPA   nb_players_minus_one_60
7389: 27 24          BEQ    $73AF
738B: 86 04          LDA    #$04
738D: 97 48          STA    nb_objects_48
738F: 96 DF          LDA    $DF
7391: 4C             INCA
7392: 84 03          ANDA   #$03
7394: 97 DF          STA    $DF
7396: C6 20          LDB    #$20
7398: 3D             MUL
7399: 8E 2B 80       LDX    #$2B80
739C: 30 8B          LEAX   D,X
739E: A6 84          LDA    ,X
73A0: 27 09          BEQ    $73AB
73A2: A6 88 1F       LDA    $1F,X
73A5: 91 E1          CMPA   max_accepted_faults_e1
73A7: 10 25 FF 37    LBCS   $72E2
73AB: 0A 48          DEC    nb_objects_48
73AD: 26 E0          BNE    $738F
73AF: 0C 06          INC    $06
73B1: 0F 09          CLR    $09
73B3: 39             RTS

73B4: 96 DF          LDA    $DF
73B6: 84 FE          ANDA   #$FE
73B8: 97 DF          STA    $DF
73BA: CE 2B 80       LDU    #$2B80
73BD: 96 DF          LDA    $DF
73BF: C6 20          LDB    #$20
73C1: 3D             MUL
73C2: 33 CB          LEAU   D,U
73C4: A6 C4          LDA    ,U
73C6: 27 15          BEQ    $73DD
73C8: 0F 9F          CLR    high_jump_fault_9f
73CA: BD 87 7A       JSR    check_player_qualified_877a
73CD: 6F C8 1F       CLR    $1F,U
73D0: 96 CD          LDA    player_is_qualified_cd
73D2: 26 09          BNE    $73DD
73D4: 6A 41          DEC    $1,U
73D6: 26 05          BNE    $73DD
73D8: 6F C4          CLR    ,U
73DA: 0C 09          INC    $09
73DC: 39             RTS

73DD: 0C 09          INC    $09
73DF: 0C 09          INC    $09
73E1: 86 01          LDA    #$01
73E3: 97 0B          STA    $0B
73E5: 39             RTS

73E6: B6 2A B4       LDA    $2AB4
73E9: 27 03          BEQ    $73EE
73EB: BD 8D B0       JSR    $8DB0
73EE: 0A 0B          DEC    $0B
73F0: 26 30          BNE    $7422
73F2: 7F 2A B4       CLR    $2AB4
73F5: 0C DF          INC    $DF
73F7: CE 2B 80       LDU    #$2B80
73FA: 96 DF          LDA    $DF
73FC: C6 20          LDB    #$20
73FE: 3D             MUL
73FF: 33 CB          LEAU   D,U
7401: A6 C4          LDA    ,U
7403: 27 15          BEQ    $741A
7405: 0F 9F          CLR    high_jump_fault_9f
7407: BD 87 7A       JSR    check_player_qualified_877a
740A: 6F C8 1F       CLR    $1F,U
740D: 96 CD          LDA    player_is_qualified_cd
740F: 26 09          BNE    $741A
7411: 6A 41          DEC    $1,U
7413: 26 05          BNE    $741A
7415: 6F C4          CLR    ,U
7417: 0C 09          INC    $09
7419: 39             RTS

741A: 0C 09          INC    $09
741C: 0C 09          INC    $09
741E: 86 01          LDA    #$01
7420: 97 0B          STA    $0B
7422: 39             RTS

7423: B6 2A B4       LDA    $2AB4
7426: 27 03          BEQ    $742B
7428: BD 8D B0       JSR    $8DB0
742B: 0A 0B          DEC    $0B
742D: 26 2E          BNE    $745D
742F: 0F D9          CLR    false_start_D9
7431: 7F 2A 39       CLR    $2A39
7434: 7F 2A B4       CLR    $2AB4
7437: 96 DF          LDA    $DF
7439: 84 02          ANDA   #$02
743B: 26 1C          BNE    $7459
743D: 86 02          LDA    #$02
743F: 97 DF          STA    $DF
7441: 97 48          STA    nb_objects_48
7443: 8E 2B 80       LDX    #$2B80
7446: 96 DF          LDA    $DF
7448: C6 20          LDB    #$20
744A: 3D             MUL
744B: 30 8B          LEAX   D,X
744D: A6 84          LDA    ,X
744F: 10 26 00 0B    LBNE   $745E
7453: 0C DF          INC    $DF
7455: 0A 48          DEC    nb_objects_48
7457: 26 EA          BNE    $7443
7459: 0C 06          INC    $06
745B: 0F 09          CLR    $09
745D: 39             RTS

745E: 86 01          LDA    #$01
7460: 97 03          STA    boot_state_03
7462: 0F 06          CLR    $06
7464: 0F 09          CLR    $09
7466: 39             RTS

7467: 8E A8 F8       LDX    #table_a8f8
746A: 96 09          LDA    $09
746C: 48             ASLA
746D: 6E 96          JMP    [A,X]	; [jump_table]

746F: 8E A8 FE       LDX    #table_a8fe
7472: 96 0C          LDA    $0C
7474: 48             ASLA
7475: 6E 96          JMP    [A,X]	; [jump_table]

7477: 8E 2B 74       LDX    #$2B74
747A: 4F             CLRA
747B: 5F             CLRB
747C: ED 81          STD    ,X++
747E: 8C 2B 80       CMPX   #$2B80
7481: 26 F9          BNE    $747C
7483: 0F 0D          CLR    $0D
7485: BD D3 17       JSR    $D317
7488: 0C 0C          INC    $0C
748A: 39             RTS

748B: 0C 0D          INC    $0D
748D: BD D3 17       JSR    $D317
7490: 0C 0C          INC    $0C
7492: 39             RTS

7493: 0C 0D          INC    $0D
7495: BD D3 17       JSR    $D317
7498: 0C 0C          INC    $0C
749A: 39             RTS

749B: 0C 0D          INC    $0D
749D: BD D3 17       JSR    $D317
74A0: 86 60          LDA    #$60
74A2: 97 0B          STA    $0B
74A4: 0C 09          INC    $09
74A6: 0F 0C          CLR    $0C
74A8: 39             RTS

74A9: 0A 0B          DEC    $0B
74AB: 26 6F          BNE    $751C
74AD: 8E 2A 80       LDX    #$2A80
74B0: CE 2B 74       LDU    #$2B74
74B3: 10 8E 2A B0    LDY    #$2AB0
74B7: 0F 13          CLR    $13
74B9: 0F 49          CLR    $49
74BB: 96 60          LDA    nb_players_minus_one_60
74BD: 4C             INCA
74BE: 97 48          STA    nb_objects_48
74C0: A6 02          LDA    $2,X
74C2: AB 42          ADDA   $2,U
74C4: 19             DAA
74C5: A7 02          STA    $2,X
74C7: A6 01          LDA    $1,X
74C9: A9 41          ADCA   $1,U
74CB: 19             DAA
74CC: A7 01          STA    $1,X
74CE: A6 84          LDA    ,X
74D0: A9 C4          ADCA   ,U
74D2: 19             DAA
74D3: A7 84          STA    ,X
74D5: 96 2D          LDA    dsw2_copy_2d
74D7: 84 08          ANDA   #$08
74D9: 27 2B          BEQ    $7506
74DB: A6 84          LDA    ,X
74DD: 84 0F          ANDA   #$0F
74DF: A1 A4          CMPA   ,Y
74E1: 27 1F          BEQ    $7502
74E3: A7 A4          STA    ,Y
74E5: 34 40          PSHS   U
74E7: CE 2B 81       LDU    #$2B81
74EA: 96 49          LDA    $49
74EC: C6 20          LDB    #$20
74EE: 3D             MUL
74EF: 6C CB          INC    D,U
74F1: 35 40          PULS   U
74F3: 96 13          LDA    $13
74F5: 26 0B          BNE    $7502
74F7: 0C 13          INC    $13
74F9: 34 20          PSHS   Y
74FB: 86 31          LDA    #$31
74FD: BD 85 0E       JSR    $850E
7500: 35 20          PULS   Y
7502: 31 21          LEAY   $1,Y
7504: 0C 49          INC    $49
7506: 30 03          LEAX   $3,X
7508: 33 43          LEAU   $3,U
750A: 0A 48          DEC    nb_objects_48
750C: 26 B2          BNE    $74C0
750E: BD 8C 4D       JSR    $8C4D
7511: 86 03          LDA    #$03
7513: BD 84 F5       JSR    queue_event_84f5
7516: 86 60          LDA    #$60
7518: 97 0B          STA    $0B
751A: 0C 09          INC    $09
751C: 39             RTS

751D: 0A 0B          DEC    $0B
751F: 26 07          BNE    $7528
7521: BD 8C 1D       JSR    clear_sprites_8c1d
7524: 0C 06          INC    $06
7526: 0F 09          CLR    $09
7528: 96 60          LDA    nb_players_minus_one_60
752A: 27 23          BEQ    $754F
752C: 96 82          LDA    $82
752E: 81 05          CMPA   #$05
7530: 26 1D          BNE    $754F
7532: 8E 2B 80       LDX    #$2B80
7535: C6 04          LDB    #$04
7537: 4F             CLRA
7538: 6D 84          TST    ,X
753A: 27 01          BEQ    $753D
753C: 4C             INCA
753D: 30 88 20       LEAX   $20,X
7540: 5A             DECB
7541: 26 F5          BNE    $7538
7543: 81 03          CMPA   #$03
7545: 25 08          BCS    $754F
7547: B6 2F FF       LDA    $2FFF
754A: 8A 40          ORA    #$40
754C: B7 2F FF       STA    $2FFF
754F: 39             RTS

7550: 4F             CLRA
7551: 5F             CLRB
7552: 8E 2A C0       LDX    #$2AC0
7555: ED 81          STD    ,X++
7557: 8C 2A E0       CMPX   #$2AE0
755A: 26 F9          BNE    $7555
755C: 8E 29 60       LDX    #player_1_final_time_2960
755F: ED 81          STD    ,X++
7561: 8C 29 90       CMPX   #$2990
7564: 26 F9          BNE    $755F
7566: 8E 2B 98       LDX    #$2B98
7569: 86 04          LDA    #$04
756B: 97 48          STA    nb_objects_48
756D: 4F             CLRA
756E: 5F             CLRB
756F: ED 84          STD    ,X
7571: ED 02          STD    $2,X
7573: 30 88 20       LEAX   $20,X
7576: 0A 48          DEC    nb_objects_48
7578: 26 F5          BNE    $756F
757A: 0C 06          INC    $06
757C: 39             RTS

757D: 0F DF          CLR    $DF
757F: 8E 2B 9F       LDX    #$2B9F
7582: 6F 84          CLR    ,X
7584: 30 88 20       LEAX   $20,X
7587: 8C 2C 1F       CMPX   #$2C1F
758A: 26 F6          BNE    $7582
758C: 0C 82          INC    $82
; next level
758E: 0C 84          INC    current_level_84
7590: 96 84          LDA    current_level_84
7592: 81 06          CMPA   #$06
7594: 26 08          BNE    $759E
; all levels have been completed
7596: 0F 84          CLR    current_level_84
7598: 96 2D          LDA    dsw2_copy_2d
759A: 84 02          ANDA   #$02
759C: 27 2A          BEQ    $75C8
759E: 86 04          LDA    #$04
75A0: 97 48          STA    nb_objects_48
75A2: 8E 2B 80       LDX    #$2B80
75A5: 96 DF          LDA    $DF
75A7: C6 20          LDB    #$20
75A9: 3D             MUL
75AA: 30 8B          LEAX   D,X
75AC: A6 84          LDA    ,X
75AE: 26 11          BNE    $75C1
75B0: 0C DF          INC    $DF
75B2: 96 DF          LDA    $DF
75B4: 84 03          ANDA   #$03
75B6: 97 DF          STA    $DF
75B8: 0A 48          DEC    nb_objects_48
75BA: 26 E6          BNE    $75A2
75BC: 0C 06          INC    $06
75BE: 0F 09          CLR    $09
75C0: 39             RTS

75C1: 0F 03          CLR    boot_state_03
75C3: 0F 06          CLR    $06
75C5: 0F 09          CLR    $09
75C7: 39             RTS

75C8: 8E 2B 80       LDX    #$2B80
75CB: C6 04          LDB    #$04
75CD: A6 84          LDA    ,X
75CF: 26 08          BNE    $75D9
75D1: 30 88 20       LEAX   $20,X
75D4: 5A             DECB
75D5: 26 F6          BNE    $75CD
75D7: 20 E3          BRA    $75BC
75D9: 8E 2B 80       LDX    #$2B80
75DC: C6 04          LDB    #$04
75DE: 6F 84          CLR    ,X
75E0: 30 88 20       LEAX   $20,X
75E3: 5A             DECB
75E4: 26 F8          BNE    $75DE
75E6: 0C 00          INC    global_state_00
75E8: 0F 03          CLR    boot_state_03
75EA: 0F 06          CLR    $06
75EC: 0F 09          CLR    $09
75EE: 39             RTS

75EF: 8E A9 06       LDX    #table_a906
75F2: 96 12          LDA    $12
75F4: 48             ASLA
75F5: 6E 96          JMP    [A,X]		; [jump_table]

75F7: 96 2C          LDA    dsw1_copy_2c
75F9: 84 0F          ANDA   #$0F
75FB: 81 0F          CMPA   #$0F
75FD: 27 07          BEQ    $7606
75FF: 96 23          LDA    number_of_credits_23
7601: 27 03          BEQ    $7606
7603: 7E 76 A5       JMP    $76A5
7606: 86 01          LDA    #$01
7608: D6 10          LDB    $10
760A: C4 01          ANDB   #$01
760C: 27 02          BEQ    $7610
760E: 86 03          LDA    #$03
7610: 97 84          STA    current_level_84
7612: 0F 82          CLR    $82
7614: 0F 9F          CLR    high_jump_fault_9f
7616: 0F DF          CLR    $DF
7618: 4F             CLRA
7619: 5F             CLRB
761A: FD 29 60       STD    player_1_final_time_2960
761D: FD 29 62       STD    $2962
7620: 7F 2A 9A       CLR    $2A9A
7623: 0C 12          INC    $12
7625: B6 2F FF       LDA    $2FFF
7628: 84 C0          ANDA   #$C0
762A: 81 40          CMPA   #$40
762C: 26 3E          BNE    $766C
762E: 10 8E FC 6B    LDY    #$FC6B           ; [rom_check_code]
7632: 8E 00 04       LDX    #$0004           ; [rom_check_code]
7635: 4F             CLRA                    ; [rom_check_code]
7636: 5F             CLRB                    ; [rom_check_code]
7637: EB A0          ADDB   ,Y+              ; [rom_check_code]
7639: 89 00          ADCA   #$00             ; [rom_check_code]
763B: 30 1F          LEAX   -$1,X            ; [rom_check_code]
763D: 26 F8          BNE    $7637            ; [rom_check_code]
763F: 31 22          LEAY   $2,Y             ; [rom_check_code]
7641: 8E 00 04       LDX    #$0004           ; [rom_check_code]
7644: EB A0          ADDB   ,Y+              ; [rom_check_code]
7646: 89 00          ADCA   #$00             ; [rom_check_code]
7648: 30 1F          LEAX   -$1,X            ; [rom_check_code]
764A: 26 F8          BNE    $7644            ; [rom_check_code]
764C: 31 22          LEAY   $2,Y             ; [rom_check_code]
764E: EB A4          ADDB   ,Y               ; [rom_check_code]
7650: 89 00          ADCA   #$00         ; [rom_check_code]
7652: 10 83 03 FD    CMPD   #$03FD       ; [rom_check_code]
7656: 26 11          BNE    $7669        ; [rom_check_code]
7658: FC A6 B8       LDD    $A6B8		; [rom_check_code] copyright message display address
765B: 10 83 37 0A    CMPD   #$370A		; [rom_check_code] strangely the "centuri" part isn't checked :)
765F: 26 08          BNE    $7669		; [rom_check_code]
7661: B6 A6 BF       LDA    $A6BF		; [rom_check_code]
7664: 4C             INCA				; [rom_check_code]
7665: 81 42          CMPA   #$42		; [rom_check_code]
7667: 27 03          BEQ    $766C		; [rom_check_code]
7669: 16 13 BC       LBRA   $8A28		; [rom_check_code]
766C: 39             RTS

766D: 96 2C          LDA    dsw1_copy_2c
766F: 84 0F          ANDA   #$0F
7671: 81 0F          CMPA   #$0F
7673: 27 07          BEQ    $767C
7675: 96 23          LDA    number_of_credits_23
7677: 27 03          BEQ    $767C
7679: 7E 76 A5       JMP    $76A5

767C: 8E A9 0C       LDX    #table_a90c
767F: 96 03          LDA    boot_state_03
7681: 48             ASLA
7682: 6E 96          JMP    [A,X]	; [jump_table]

7684: 96 2C          LDA    dsw1_copy_2c
7686: 84 0F          ANDA   #$0F
7688: 81 0F          CMPA   #$0F
768A: 27 07          BEQ    $7693
768C: 96 23          LDA    number_of_credits_23
768E: 27 03          BEQ    $7693
7690: 7E 76 A5       JMP    $76A5
7693: 0C 10          INC    $10
7695: 7F 2A 9A       CLR    $2A9A
7698: 0C 0F          INC    $0F
769A: 0F 12          CLR    $12
769C: 0F 03          CLR    boot_state_03
769E: 0F 06          CLR    $06
76A0: 0F 09          CLR    $09
76A2: 0F 0C          CLR    $0C
76A4: 39             RTS

76A5: CC 01 02       LDD    #$0102
76A8: 97 22          STA    $22
76AA: D7 00          STB    global_state_00
76AC: 0F 03          CLR    boot_state_03
76AE: 0F 06          CLR    $06
76B0: 0F 09          CLR    $09
76B2: 0F 0C          CLR    $0C
76B4: 0F 12          CLR    $12
76B6: 39             RTS

76B7: BD 8E CC       JSR    $8ECC
76BA: BD 8E F0       JSR    $8EF0
76BD: 96 06          LDA    $06
76BF: 48             ASLA
76C0: 10 8E A9 16    LDY    #table_a916
76C4: 6E B6          JMP    [A,Y]	; [jump_table]
76C6: 8E 28 A0       LDX    #$28A0
76C9: 96 09          LDA    $09
76CB: 48             ASLA
76CC: 10 8E A9 1C    LDY    #table_a91c
76D0: 6E B6          JMP    [A,Y]	; [jump_table]

76D2: 96 DF          LDA    $DF
76D4: 84 02          ANDA   #$02
76D6: 97 DF          STA    $DF
76D8: 97 FB          STA    $FB
76DA: BD 88 C8       JSR    $88C8
76DD: 86 02          LDA    #$02
76DF: 97 48          STA    nb_objects_48
76E1: 4F             CLRA
76E2: 5F             CLRB
76E3: ED 0B          STD    $B,X
76E5: ED 88 10       STD    $10,X
76E8: ED 88 12       STD    $12,X
76EB: CC DC E9       LDD    #$DCE9
76EE: ED 0E          STD    $E,X
76F0: BD CB 17       JSR    $CB17
76F3: 0C DF          INC    $DF
76F5: 30 89 01 60    LEAX   $0160,X
76F9: 0A 48          DEC    nb_objects_48
76FB: 26 E4          BNE    $76E1
76FD: 96 FB          LDA    $FB
76FF: 97 DF          STA    $DF
7701: 8E 29 A0       LDX    #$29A0
7704: 6C 84          INC    ,X
7706: BD CD 73       JSR    $CD73
7709: CC 01 00       LDD    #$0100
770C: BD 84 F5       JSR    queue_event_84f5
770F: 96 DF          LDA    $DF
7711: 84 02          ANDA   #$02
7713: 26 0E          BNE    $7723
7715: CC 02 0D       LDD    #$020D
7718: BD 84 F5       JSR    queue_event_84f5
771B: CC 02 0E       LDD    #$020E
771E: BD 84 F5       JSR    queue_event_84f5
7721: 20 0C          BRA    $772F
7723: CC 02 23       LDD    #$0223
7726: BD 84 F5       JSR    queue_event_84f5
7729: CC 02 24       LDD    #$0224
772C: BD 84 F5       JSR    queue_event_84f5
772F: CC 01 0A       LDD    #$010A
7732: BD 84 F5       JSR    queue_event_84f5
7735: CC 02 3A       LDD    #$023A
7738: BD 84 F5       JSR    queue_event_84f5
773B: CC 02 3B       LDD    #$023B
773E: BD 84 F5       JSR    queue_event_84f5
7741: 86 80          LDA    #$80
7743: BD 85 08       JSR    $8508
7746: 86 FF          LDA    #$FF
7748: BD 85 08       JSR    $8508
774B: 86 30          LDA    #$30
774D: 97 0A          STA    $0A
774F: 86 50          LDA    #$50
7751: 97 0B          STA    $0B
7753: 0C 09          INC    $09
7755: 39             RTS

7756: 96 DF          LDA    $DF
7758: 84 02          ANDA   #$02
775A: 97 DF          STA    $DF
775C: 97 FB          STA    $FB
775E: 96 0A          LDA    $0A
7760: 26 1A          BNE    $777C
7762: BD 88 C8       JSR    $88C8
7765: 6D 84          TST    ,X
7767: 26 03          BNE    $776C
7769: BD 77 94       JSR    $7794
776C: 96 0B          LDA    $0B
776E: 26 0E          BNE    $777E
7770: 8E 2A 00       LDX    #$2A00
7773: 0C DF          INC    $DF
7775: 6D 84          TST    ,X
7777: 26 08          BNE    $7781
7779: 7E 77 94       JMP    $7794
777C: 0A 0A          DEC    $0A
777E: 0A 0B          DEC    $0B
7780: 39             RTS

7781: 0F A0          CLR    $A0
7783: 6F 84          CLR    ,X
7785: 8E 29 A0       LDX    #$29A0
7788: 6C 84          INC    ,X
778A: BD CD 73       JSR    $CD73
778D: 86 14          LDA    #$14
778F: 97 0B          STA    $0B
7791: 0C 09          INC    $09
7793: 39             RTS

7794: 96 3F          LDA    $3F
7796: 44             LSRA
7797: 24 09          BCC    $77A2
7799: A6 02          LDA    $2,X
779B: 4C             INCA
779C: 81 6C          CMPA   #$6C
779E: 27 05          BEQ    $77A5
77A0: A7 02          STA    $2,X
77A2: 7E CB 82       JMP    $CB82
77A5: 6C 84          INC    ,X
77A7: 86 70          LDA    #$70
77A9: A7 02          STA    $2,X
77AB: 39             RTS

77AC: 96 DF          LDA    $DF
77AE: 84 02          ANDA   #$02
77B0: 97 DF          STA    $DF
77B2: 97 FB          STA    $FB
77B4: 0A 0B          DEC    $0B
77B6: 26 14          BNE    $77CC
77B8: BD 88 C8       JSR    $88C8
77BB: BD CD 63       JSR    $CD63
77BE: 8E 2A 00       LDX    #$2A00
77C1: 0C DF          INC    $DF
77C3: BD CD 63       JSR    $CD63
77C6: 86 64          LDA    #$64
77C8: 97 0B          STA    $0B
77CA: 0C 09          INC    $09
77CC: 39             RTS

77CD: 0A 0B          DEC    $0B
77CF: 26 10          BNE    $77E1
77D1: 86 81          LDA    #$81
77D3: BD 85 08       JSR    $8508
77D6: 86 FF          LDA    #$FF
77D8: BD 85 08       JSR    $8508
77DB: 86 30          LDA    #$30
77DD: 97 0B          STA    $0B
77DF: 0C 09          INC    $09
77E1: 39             RTS

77E2: 96 DF          LDA    $DF
77E4: 84 02          ANDA   #$02
77E6: 97 DF          STA    $DF
77E8: 97 FB          STA    $FB
77EA: 0A 0B          DEC    $0B
77EC: 26 14          BNE    $7802
77EE: BD 88 C8       JSR    $88C8
77F1: BD CD 68       JSR    $CD68
77F4: 8E 2A 00       LDX    #$2A00
77F7: 0C DF          INC    $DF
77F9: BD CD 68       JSR    $CD68
77FC: 86 A0          LDA    #$A0
77FE: 97 0B          STA    $0B
7800: 0C 09          INC    $09
7802: 39             RTS

7803: 96 DF          LDA    $DF
7805: 84 02          ANDA   #$02
7807: 97 DF          STA    $DF
7809: 8E 28 A0       LDX    #$28A0
780C: 86 02          LDA    #$02
780E: 97 50          STA    $50
7810: BD 78 9E       JSR    $789E
7813: 5D             TSTB
7814: 26 7E          BNE    $7894
7816: 0C DF          INC    $DF
7818: 8E 2A 00       LDX    #$2A00
781B: 0A 50          DEC    $50
781D: 26 F1          BNE    $7810
781F: 0A DF          DEC    $DF
7821: 96 A0          LDA    $A0
7823: 26 6E          BNE    $7893
7825: B6 2A 00       LDA    $2A00
7828: 26 69          BNE    $7893
782A: 0A 0B          DEC    $0B
782C: 26 65          BNE    $7893
782E: 0D 22          TST    $22
7830: 27 35          BEQ    $7867
7832: 86 0D          LDA    #$0D
7834: BD 85 0E       JSR    $850E
7837: 86 0C          LDA    #$0C
7839: BD 85 0E       JSR    $850E
783C: 86 0B          LDA    #$0B
783E: BD 85 0E       JSR    $850E
7841: CE 32 0B       LDU    #$320B
7844: 96 DF          LDA    $DF
7846: 84 02          ANDA   #$02
7848: C6 40          LDB    #$40
784A: 3D             MUL
784B: 33 CB          LEAU   D,U
784D: 86 02          LDA    #$02
784F: 97 48          STA    nb_objects_48
7851: 86 10          LDA    #$10
7853: C6 03          LDB    #$03
7855: 6F C9 08 00    CLR    $0800,U   			; [video_address]
7859: A7 C0          STA    ,U+           		; [video_address]
785B: 5A             DECB
785C: 26 F7          BNE    $7855
785E: 33 C8 3D       LEAU   $3D,U
7861: 0A 48          DEC    nb_objects_48
7863: 26 EE          BNE    $7853
7865: 20 0F          BRA    $7876
7867: 86 1A          LDA    #$1A
7869: BD 85 08       JSR    $8508
786C: 86 0C          LDA    #$0C
786E: BD 85 08       JSR    $8508
7871: 86 0D          LDA    #$0D
7873: BD 85 08       JSR    $8508
7876: CC 78 28       LDD    #$7828
7879: BD CE 73       JSR    $CE73
787C: CC 18 F8       LDD    #$18F8
787F: FD 2A C1       STD    $2AC1
7882: CC 48 F8       LDD    #$48F8
7885: FD 2A E1       STD    $2AE1
7888: 7F 2A B8       CLR    $2AB8
788B: 86 01          LDA    #$01
788D: 97 EA          STA    display_chrono_ea
788F: 0F 09          CLR    $09
7891: 0C 06          INC    $06
7893: 39             RTS

7894: BD 90 74       JSR    $9074
7897: 86 64          LDA    #$64
7899: 97 0B          STA    $0B
789B: 0C 09          INC    $09
789D: 39             RTS

789E: A6 84          LDA    ,X
78A0: 81 01          CMPA   #$01
78A2: 27 30          BEQ    $78D4
78A4: 81 02          CMPA   #$02
78A6: 27 52          BEQ    $78FA
78A8: A6 0A          LDA    $A,X
78AA: 26 26          BNE    $78D2
78AC: CE 28 39       LDU    #$2839
78AF: 96 DF          LDA    $DF
78B1: 84 01          ANDA   #$01
78B3: 27 02          BEQ    $78B7
78B5: 33 43          LEAU   $3,U
78B7: A6 42          LDA    $2,U
78B9: AA 41          ORA    $1,U
78BB: 43             COMA
78BC: A4 C4          ANDA   ,U
78BE: 84 05          ANDA   #$05
78C0: 27 10          BEQ    $78D2
78C2: 6C 84          INC    ,X
78C4: A6 02          LDA    $2,X
78C6: 8B 08          ADDA   #$08
78C8: A7 02          STA    $2,X
78CA: BD CC AB       JSR    $CCAB
78CD: 86 10          LDA    #$10
78CF: A7 88 22       STA    $22,X
78D2: 5F             CLRB
78D3: 39             RTS

78D4: 6A 88 22       DEC    $22,X
78D7: 26 1F          BNE    $78F8
78D9: 86 1A          LDA    #$1A
78DB: BD 85 0E       JSR    $850E
78DE: 86 0C          LDA    #$0C
78E0: BD 85 0E       JSR    $850E
78E3: 86 0D          LDA    #$0D
78E5: BD 85 0E       JSR    $850E
78E8: 6C 84          INC    ,X
78EA: A6 02          LDA    $2,X
78EC: 8B 08          ADDA   #$08
78EE: A7 02          STA    $2,X
78F0: BD CC B1       JSR    $CCB1
78F3: 86 10          LDA    #$10
78F5: A7 88 22       STA    $22,X
78F8: 5F             CLRB
78F9: 39             RTS

78FA: 6A 88 22       DEC    $22,X
78FD: 26 F9          BNE    $78F8
78FF: 86 1A          LDA    #$1A
7901: BD 85 0E       JSR    $850E
7904: 86 0C          LDA    #$0C
7906: BD 85 0E       JSR    $850E
7909: 86 0D          LDA    #$0D
790B: BD 85 0E       JSR    $850E
790E: A6 02          LDA    $2,X
7910: 8B 08          ADDA   #$08
7912: A7 02          STA    $2,X
7914: BD CC B7       JSR    $CCB7
7917: 6C 88 39       INC    $39,X
791A: BD 8B A3       JSR    $8BA3
791D: CC 01 00       LDD    #$0100
7920: BD 84 F5       JSR    queue_event_84f5
7923: 86 02          LDA    #$02
7925: D6 DF          LDB    $DF
7927: BD 84 F5       JSR    queue_event_84f5
792A: 86 05          LDA    #$05
792C: BD 84 F5       JSR    queue_event_84f5
792F: CC 02 25       LDD    #$0225
7932: BD 84 F5       JSR    queue_event_84f5
7935: C6 01          LDB    #$01
7937: 39             RTS

7938: BD 8D B0       JSR    $8DB0
793B: 96 0B          LDA    $0B
793D: 81 50          CMPA   #$50
793F: 26 0A          BNE    $794B
7941: 86 B3          LDA    #$B3
7943: BD 85 0E       JSR    $850E
7946: 86 FF          LDA    #$FF
7948: BD 85 0E       JSR    $850E
794B: 0A 0B          DEC    $0B
794D: 26 5F          BNE    $79AE
794F: 96 D9          LDA    false_start_D9
7951: D6 DF          LDB    $DF
7953: C4 01          ANDB   #$01
7955: 27 03          BEQ    $795A
7957: B6 2A 39       LDA    $2A39
795A: 81 03          CMPA   #$03
795C: 26 51          BNE    $79AF
795E: BD 79 CB       JSR    $79CB
7961: 96 DF          LDA    $DF
7963: 97 FB          STA    $FB
7965: 84 01          ANDA   #$01
7967: 27 04          BEQ    $796D
7969: 0A DF          DEC    $DF
796B: 20 02          BRA    $796F
796D: 0C DF          INC    $DF
796F: 96 AA          LDA    $AA
7971: D6 DF          LDB    $DF
7973: C4 01          ANDB   #$01
7975: 27 03          BEQ    $797A
7977: B6 2A 0A       LDA    $2A0A
797A: 4D             TSTA
797B: 27 03          BEQ    $7980
797D: BD 79 CB       JSR    $79CB
7980: 96 FB          LDA    $FB
7982: 97 DF          STA    $DF
7984: CE 28 EC       LDU    #$28EC
7987: 96 DF          LDA    $DF
7989: 6C C6          INC    A,U
798B: BD 8B A3       JSR    $8BA3
798E: CC 01 00       LDD    #$0100
7991: BD 84 F5       JSR    queue_event_84f5
7994: 86 02          LDA    #$02
7996: D6 DF          LDB    $DF
7998: BD 84 F5       JSR    queue_event_84f5
799B: 86 05          LDA    #$05
799D: BD 84 F5       JSR    queue_event_84f5
79A0: CC 02 26       LDD    #$0226
79A3: BD 84 F5       JSR    queue_event_84f5
79A6: 86 80          LDA    #$80
79A8: 97 0B          STA    $0B
79AA: 0C 09          INC    $09
79AC: 0F 0C          CLR    $0C
79AE: 39             RTS

79AF: 8E 18 00       LDX    #sprite_ram_1800
79B2: 4F             CLRA
79B3: 5F             CLRB
79B4: ED 89 04 00    STD    $0400,X
79B8: ED 81          STD    ,X++
79BA: 8C 18 30       CMPX   #$1830
79BD: 26 F5          BNE    $79B4
79BF: BD 8B 3A       JSR    $8B3A
79C2: BD 8B 71       JSR    $8B71
79C5: BD 87 FB       JSR    $87FB
79C8: 0F 09          CLR    $09
79CA: 39             RTS

79CB: 96 DF          LDA    $DF
79CD: 84 01          ANDA   #$01
79CF: 27 05          BEQ    $79D6
79D1: 7F 2A 39       CLR    $2A39
79D4: 20 02          BRA    $79D8
79D6: 0F D9          CLR    false_start_D9
79D8: CE 2B 60       LDU    #$2B60
79DB: 96 DF          LDA    $DF
79DD: C6 05          LDB    #$05
79DF: 3D             MUL
79E0: 33 CB          LEAU   D,U
79E2: 96 DF          LDA    $DF
79E4: 4C             INCA
79E5: 8A 20          ORA    #$20
79E7: A7 C4          STA    ,U
79E9: 39             RTS

79EA: 8E A9 2C       LDX    #table_a92c
79ED: 96 0C          LDA    $0C
79EF: 48             ASLA
79F0: 6E 96          JMP    [A,X]	; [jump_table]

79F2: BD 8D B0       JSR    $8DB0
79F5: 0A B0          DEC    $B0
79F7: 26 1D          BNE    $7A16
79F9: 8E 2B 80       LDX    #$2B80
79FC: 96 DF          LDA    $DF
79FE: C6 20          LDB    #$20
7A00: 3D             MUL
7A01: 30 8B          LEAX   D,X
7A03: 6A 01          DEC    $1,X
7A05: 26 09          BNE    $7A10
7A07: 6F 84          CLR    ,X
7A09: BD 73 39       JSR    $7339
7A0C: 0A 09          DEC    $09
7A0E: 20 04          BRA    $7A14
7A10: 86 01          LDA    #$01
7A12: 97 0B          STA    $0B
7A14: 0C 0C          INC    $0C
7A16: 39             RTS

7A17: BD 8D B0       JSR    $8DB0
7A1A: 0A 0B          DEC    $0B
7A1C: 26 56          BNE    $7A74
7A1E: 96 DF          LDA    $DF
7A20: 84 01          ANDA   #$01
7A22: 27 04          BEQ    $7A28
7A24: 0A DF          DEC    $DF
7A26: 20 02          BRA    $7A2A
7A28: 0C DF          INC    $DF
7A2A: 8E 2B 80       LDX    #$2B80
7A2D: 96 DF          LDA    $DF
7A2F: C6 20          LDB    #$20
7A31: 3D             MUL
7A32: 30 8B          LEAX   D,X
7A34: A6 84          LDA    ,X
7A36: 27 09          BEQ    $7A41
7A38: 8E 28 EC       LDX    #$28EC
7A3B: 96 DF          LDA    $DF
7A3D: A6 86          LDA    A,X
7A3F: 27 34          BEQ    $7A75
7A41: 0F D9          CLR    false_start_D9
7A43: 7F 2A 39       CLR    $2A39
7A46: 96 DF          LDA    $DF
7A48: 84 02          ANDA   #$02
7A4A: 26 1C          BNE    $7A68
7A4C: 86 02          LDA    #$02
7A4E: 97 DF          STA    $DF
7A50: 97 48          STA    nb_objects_48
7A52: 8E 2B 80       LDX    #$2B80
7A55: 96 DF          LDA    $DF
7A57: C6 20          LDB    #$20
7A59: 3D             MUL
7A5A: 30 8B          LEAX   D,X
7A5C: A6 84          LDA    ,X
7A5E: 26 15          BNE    $7A75
7A60: 0C DF          INC    $DF
7A62: 0A 48          DEC    nb_objects_48
7A64: 26 EC          BNE    $7A52
7A66: 0A DF          DEC    $DF
7A68: 86 05          LDA    #$05
7A6A: 97 03          STA    boot_state_03
7A6C: 86 01          LDA    #$01
7A6E: 97 06          STA    $06
7A70: 0F 09          CLR    $09
7A72: 0F 0C          CLR    $0C
7A74: 39             RTS

7A75: 86 01          LDA    #$01
7A77: 97 03          STA    boot_state_03
7A79: 0F 06          CLR    $06
7A7B: 0F 09          CLR    $09
7A7D: 0F 0C          CLR    $0C
7A7F: 39             RTS

7A80: 96 DF          LDA    $DF
7A82: 84 02          ANDA   #$02
7A84: 97 DF          STA    $DF
7A86: 97 FB          STA    $FB
7A88: BD D7 FF       JSR    chrono_tick_d7ff
7A8B: BD CE 69       JSR    $CE69
7A8E: 96 7F          LDA    chrono_second_7f
7A90: 81 40          CMPA   #$40
7A92: 10 27 00 54    LBEQ   $7AEA
7A96: BD 88 C8       JSR    $88C8
7A99: C6 02          LDB    #$02
7A9B: 8E 28 A0       LDX    #$28A0
7A9E: 34 04          PSHS   B
7AA0: 6D 88 22       TST    $22,X
7AA3: 26 0E          BNE    $7AB3
7AA5: BD 9F 82       JSR    $9F82
7AA8: 10 8E A9 30    LDY    #table_a930
7AAC: A6 84          LDA    ,X
7AAE: 48             ASLA
7AAF: AD B6          JSR    [A,Y]	; [jump_table]
7AB1: 20 03          BRA    $7AB6

7AB3: 6A 88 22       DEC    $22,X
7AB6: 0C DF          INC    $DF
7AB8: 30 89 01 60    LEAX   $0160,X
7ABC: 35 04          PULS   B
7ABE: 5A             DECB
7ABF: 26 DD          BNE    $7A9E
7AC1: 96 FB          LDA    $FB
7AC3: 97 DF          STA    $DF
7AC5: BD 9F CD       JSR    $9FCD
7AC8: BD 8C D7       JSR    $8CD7
7ACB: 0F DA          CLR    $DA
7ACD: 7F 2A 3A       CLR    $2A3A
7AD0: 96 A0          LDA    $A0
7AD2: 81 05          CMPA   #$05
7AD4: 26 13          BNE    $7AE9
7AD6: B6 2A 00       LDA    $2A00
7AD9: 81 05          CMPA   #$05
7ADB: 26 0C          BNE    $7AE9
7ADD: 4F             CLRA
7ADE: BD 85 08       JSR    $8508
7AE1: 86 30          LDA    #$30
7AE3: 97 0B          STA    $0B
7AE5: 0C 06          INC    $06
7AE7: 0F 09          CLR    $09
7AE9: 39             RTS

7AEA: 8E 28 A0       LDX    #$28A0
7AED: A6 88 33       LDA    $33,X
7AF0: 26 03          BNE    $7AF5
7AF2: BD 9F 15       JSR    $9F15
7AF5: 8E 2A 00       LDX    #$2A00
7AF8: 0C DF          INC    $DF
7AFA: A6 88 33       LDA    $33,X
7AFD: 26 03          BNE    $7B02
7AFF: BD 9F 15       JSR    $9F15
7B02: 0A DF          DEC    $DF
7B04: 20 D7          BRA    $7ADD
7B06: 96 7F          LDA    chrono_second_7f
7B08: 81 03          CMPA   #$03
7B0A: 25 03          BCS    $7B0F
7B0C: BD 90 12       JSR    $9012
7B0F: A6 88 36       LDA    $36,X
7B12: 27 0B          BEQ    $7B1F
7B14: 6C 84          INC    ,X
7B16: 6F 88 36       CLR    $36,X
7B19: A6 84          LDA    ,X
7B1B: 81 02          CMPA   #$02
7B1D: 27 46          BEQ    $7B65
7B1F: 10 8E 28 39    LDY    #$2839
7B23: 96 DF          LDA    $DF
7B25: 84 01          ANDA   #$01
7B27: 27 02          BEQ    $7B2B
7B29: 31 23          LEAY   $3,Y
7B2B: A6 22          LDA    $2,Y
7B2D: AA 21          ORA    $1,Y
7B2F: 43             COMA
7B30: A4 A4          ANDA   ,Y
7B32: 84 05          ANDA   #$05
7B34: 27 2E          BEQ    $7B64
7B36: 86 08          LDA    #$08
7B38: A7 88 3A       STA    $3A,X
7B3B: A6 0C          LDA    $C,X
7B3D: 8B 08          ADDA   #$08
7B3F: A7 0C          STA    $C,X
7B41: 6D 84          TST    ,X
7B43: 26 05          BNE    $7B4A
7B45: BD CC AB       JSR    $CCAB
7B48: 20 12          BRA    $7B5C
7B4A: BD CC B1       JSR    $CCB1
7B4D: CC DC E2       LDD    #$DCE2
7B50: ED 0E          STD    $E,X
7B52: 86 01          LDA    #$01
7B54: A7 88 17       STA    $17,X
7B57: 86 06          LDA    #$06
7B59: A7 88 16       STA    $16,X
7B5C: 6C 88 36       INC    $36,X
7B5F: 86 08          LDA    #$08
7B61: A7 88 22       STA    $22,X
7B64: 39             RTS

7B65: CC 01 00       LDD    #$0100
7B68: ED 88 11       STD    $11,X
7B6B: 7E 90 56       JMP    $9056
7B6E: BD 93 CD       JSR    $93CD
7B71: BD 94 88       JSR    $9488
7B74: BD 94 B8       JSR    $94B8
7B77: BD 93 73       JSR    $9373
7B7A: A6 0C          LDA    $C,X
7B7C: AB 88 3A       ADDA   $3A,X
7B7F: 24 02          BCC    $7B83
7B81: 6C 0B          INC    $B,X
7B83: A7 0C          STA    $C,X
7B85: 86 0C          LDA    #$0C
7B87: 7E 84 F5       JMP    queue_event_84f5
7B8A: A6 88 1C       LDA    $1C,X
7B8D: 26 05          BNE    $7B94
7B8F: EC 88 10       LDD    $10,X
7B92: 27 17          BEQ    $7BAB
7B94: BD 94 88       JSR    $9488
7B97: BD 94 B8       JSR    $94B8
7B9A: BD 93 73       JSR    $9373
7B9D: BD 93 79       JSR    $9379
7BA0: BD 7B C1       JSR    $7BC1
7BA3: 4D             TSTA
7BA4: 27 04          BEQ    $7BAA
7BA6: 6C 84          INC    ,X
7BA8: 6C 84          INC    ,X
7BAA: 39             RTS

7BAB: CC DC E9       LDD    #$DCE9
7BAE: ED 0E          STD    $E,X
7BB0: 20 F6          BRA    $7BA8
7BB2: 6C 02          INC    $2,X
7BB4: BD CB 82       JSR    $CB82
7BB7: BD 7B C1       JSR    $7BC1
7BBA: 4D             TSTA
7BBB: 27 02          BEQ    $7BBF
7BBD: 6C 84          INC    ,X
7BBF: 39             RTS

7BC0: 39             RTS

7BC1: 4F             CLRA
7BC2: E6 02          LDB    $2,X
7BC4: 10 83 00 F0    CMPD   #$00F0
7BC8: 25 04          BCS    $7BCE
7BCA: BD CB 1D       JSR    $CB1D
7BCD: 4C             INCA
7BCE: 39             RTS

7BCF: 0A 0B          DEC    $0B
7BD1: 26 09          BNE    $7BDC
7BD3: BD 96 D3       JSR    compare_contestants_tile_96d3
7BD6: 0C 03          INC    boot_state_03
7BD8: 0F 06          CLR    $06
7BDA: 0F 09          CLR    $09
7BDC: B6 2A 0A       LDA    $2A0A
7BDF: 26 56          BNE    $7C37
7BE1: FC 29 6C       LDD    player_2_final_time_296c
7BE4: 10 83 01 00    CMPD   #$0100
7BE8: 24 4D          BCC    $7C37
7BEA: 8E A4 E7       LDX    #$A4E7
7BED: 86 38          LDA    #$38
7BEF: AE 86          LDX    A,X
7BF1: 30 02          LEAX   $2,X
7BF3: 4F             CLRA
7BF4: 5F             CLRB
7BF5: 10 8E 00 0D    LDY    #$000D
7BF9: EB 80          ADDB   ,X+
7BFB: 89 00          ADCA   #$00
7BFD: 31 3F          LEAY   -$1,Y
7BFF: 26 F8          BNE    $7BF9
7C01: 10 83 03 4E    CMPD   #$034E
7C05: 26 2A          BNE    $7C31
7C07: 10 8E FC 6B    LDY    #$FC6B
7C0B: 8E 00 04       LDX    #$0004
7C0E: 4F             CLRA
7C0F: 5F             CLRB
7C10: EB A0          ADDB   ,Y+
7C12: 89 00          ADCA   #$00
7C14: 30 1F          LEAX   -$1,X
7C16: 26 F8          BNE    $7C10
7C18: 31 22          LEAY   $2,Y
7C1A: 8E 00 04       LDX    #$0004
7C1D: EB A0          ADDB   ,Y+
7C1F: 89 00          ADCA   #$00
7C21: 30 1F          LEAX   -$1,X
7C23: 26 F8          BNE    $7C1D
7C25: 31 22          LEAY   $2,Y
7C27: EB A4          ADDB   ,Y
7C29: 89 00          ADCA   #$00
7C2B: 10 83 03 FD    CMPD   #$03FD
7C2F: 27 06          BEQ    $7C37
7C31: 86 10          LDA    #$10
7C33: 97 00          STA    global_state_00
7C35: 97 06          STA    $06
7C37: 39             RTS

7C38: 96 06          LDA    $06
7C3A: 48             ASLA
7C3B: 10 8E A9 3C    LDY    #table_a93c
7C3F: 6E B6          JMP    [A,Y]		; [jump_table]

7C41: 10 8E A9 4C    LDY    #table_a94c
7C45: 96 09          LDA    $09
7C47: 48             ASLA
7C48: 6E B6          JMP    [A,Y]		; [jump_table]

7C4A: 8E 28 A0       LDX    #$28A0
7C4D: BD CB 17       JSR    $CB17
7C50: CC DC E9       LDD    #$DCE9
7C53: DD AE          STD    $AE
7C55: CC DD 5C       LDD    #$DD5C
7C58: FD 29 CE       STD    $29CE
7C5B: 4F             CLRA
7C5C: 5F             CLRB
7C5D: DD AB          STD    $AB
7C5F: DD B0          STD    $B0
7C61: DD B2          STD    $B2
7C63: FD 2A 98       STD    $2A98
7C66: 0F E9          CLR    $E9
7C68: 86 06          LDA    #$06
7C6A: 97 B6          STA    $B6
7C6C: 97 B7          STA    $B7
7C6E: CC 01 00       LDD    #$0100
7C71: BD 84 F5       JSR    queue_event_84f5
7C74: CC 02 0C       LDD    #$020C
7C77: BD 84 F5       JSR    queue_event_84f5
7C7A: CC 02 17       LDD    #$0217
7C7D: BD 84 F5       JSR    queue_event_84f5
7C80: CC 01 0A       LDD    #$010A
7C83: BD 84 F5       JSR    queue_event_84f5
7C86: CC 02 3C       LDD    #$023C
7C89: BD 84 F5       JSR    queue_event_84f5
7C8C: 86 09          LDA    #$09
7C8E: BD 84 F5       JSR    queue_event_84f5
7C91: BD 90 E8       JSR    $90E8
7C94: 86 05          LDA    #$05
7C96: 5D             TSTB
7C97: 27 02          BEQ    $7C9B
7C99: 86 1E          LDA    #$1E
7C9B: 97 0B          STA    $0B
7C9D: 0C 09          INC    $09
7C9F: 39             RTS

7CA0: 0A 0B          DEC    $0B
7CA2: 26 0E          BNE    $7CB2
7CA4: 86 28          LDA    #$28
7CA6: BD 85 08       JSR    $8508
7CA9: BD 8E 77       JSR    $8E77
7CAC: 0F 3F          CLR    $3F
7CAE: 0C 06          INC    $06
7CB0: 0F 09          CLR    $09
7CB2: 39             RTS

7CB3: 8E 28 39       LDX    #$2839
7CB6: 96 DF          LDA    $DF
7CB8: 44             LSRA
7CB9: 24 02          BCC    $7CBD
7CBB: 30 03          LEAX   $3,X
7CBD: A6 02          LDA    $2,X
7CBF: AA 01          ORA    $1,X
7CC1: 43             COMA
7CC2: A4 84          ANDA   ,X
7CC4: 84 05          ANDA   #$05
7CC6: 26 23          BNE    $7CEB
7CC8: 96 22          LDA    $22
7CCA: 27 03          BEQ    $7CCF
7CCC: BD 90 32       JSR    $9032
7CCF: BD 8E 00       JSR    $8E00
7CD2: 5D             TSTB
7CD3: 26 2A          BNE    $7CFF
7CD5: B6 2A 99       LDA    $2A99
7CD8: 27 10          BEQ    $7CEA
7CDA: B6 2A 98       LDA    $2A98
7CDD: 81 40          CMPA   #$40
7CDF: 25 09          BCS    $7CEA
7CE1: 84 3F          ANDA   #$3F
7CE3: 26 05          BNE    $7CEA
7CE5: 86 2F          LDA    #$2F
7CE7: BD 85 0E       JSR    $850E
7CEA: 39             RTS

7CEB: CC DC B6       LDD    #$DCB6
7CEE: DD AE          STD    $AE
7CF0: CE 36 56       LDU    #$3656
7CF3: BD 90 66       JSR    $9066
7CF6: 0F EA          CLR    display_chrono_ea
7CF8: 0F EB          CLR    $EB
7CFA: 0C 06          INC    $06
7CFC: 0F 09          CLR    $09
7CFE: 39             RTS

7CFF: 86 01          LDA    #$01
7D01: 97 EB          STA    $EB
7D03: 97 08          STA    $08
7D05: 86 06          LDA    #$06
7D07: 97 06          STA    $06
7D09: 0F 09          CLR    $09
7D0B: 39             RTS

7D0C: BD D7 FF       JSR    chrono_tick_d7ff
7D0F: 96 7F          LDA    chrono_second_7f
7D11: 81 40          CMPA   #$40
7D13: 27 EA          BEQ    $7CFF
7D15: 8E 28 A0       LDX    #$28A0
7D18: BD 93 CD       JSR    $93CD
7D1B: BD 94 88       JSR    $9488
7D1E: BD 94 B8       JSR    $94B8
7D21: 8E 28 A0       LDX    #$28A0
7D24: 86 09          LDA    #$09
7D26: BD 84 F5       JSR    queue_event_84f5
7D29: BD 91 35       JSR    $9135
7D2C: BD 85 87       JSR    $8587
7D2F: BD 9A 1C       JSR    $9A1C
7D32: BD 7D DD       JSR    $7DDD
7D35: 8E 29 A0       LDX    #$29A0
7D38: BD 85 87       JSR    $8587
7D3B: BD 99 B5       JSR    $99B5
7D3E: 39             RTS

7D3F: BD D7 FF       JSR    chrono_tick_d7ff
7D42: 96 22          LDA    $22
7D44: 26 18          BNE    $7D5E
7D46: B6 2A 9A       LDA    $2A9A
7D49: 26 13          BNE    $7D5E
7D4B: DC 7E          LDD    chrono_hundredth_second_7e
7D4D: 10 83 70 04    CMPD   #$7004
7D51: 26 0B          BNE    $7D5E
7D53: 86 01          LDA    #$01
7D55: B7 2A 9A       STA    $2A9A
7D58: 96 3F          LDA    $3F
7D5A: 84 07          ANDA   #$07
7D5C: 97 3F          STA    $3F
7D5E: 8E 28 A0       LDX    #$28A0
7D61: BD 94 88       JSR    $9488
7D64: BD 94 B8       JSR    $94B8
7D67: 8E 28 A0       LDX    #$28A0
7D6A: 86 09          LDA    #$09
7D6C: BD 84 F5       JSR    queue_event_84f5
7D6F: BD 91 35       JSR    $9135
7D72: BD 85 87       JSR    $8587
7D75: BD 99 1A       JSR    $991A
7D78: BD 9A F3       JSR    $9AF3
7D7B: 5D             TSTB
7D7C: 27 5E          BEQ    $7DDC
7D7E: 8E 29 A0       LDX    #$29A0
7D81: BD 85 87       JSR    $8587
7D84: BD 99 B5       JSR    $99B5
7D87: CE 28 39       LDU    #$2839
7D8A: 96 DF          LDA    $DF
7D8C: 84 01          ANDA   #$01
7D8E: 27 02          BEQ    $7D92
7D90: 33 43          LEAU   $3,U
7D92: A6 42          LDA    $2,U
7D94: AA 41          ORA    $1,U
7D96: 43             COMA
7D97: A4 C4          ANDA   ,U
7D99: 84 02          ANDA   #$02
7D9B: 27 3F          BEQ    $7DDC
7D9D: BD 9B 0E       JSR    $9B0E
7DA0: DC A1          LDD    p2_attempts_left_a1
7DA2: CB 20          ADDB   #$20
7DA4: FD 2A E1       STD    $2AE1
7DA7: 86 14          LDA    #$14
7DA9: 97 D8          STA    angle_d8
7DAB: 4F             CLRA
7DAC: BD 85 08       JSR    $8508
7DAF: 86 05          LDA    #$05
7DB1: BD 85 08       JSR    $8508
7DB4: 86 14          LDA    #$14
7DB6: BD 85 08       JSR    $8508
7DB9: 86 15          LDA    #$15
7DBB: BD 85 08       JSR    $8508
7DBE: 96 B2          LDA    $B2
7DC0: 9B E9          ADDA   $E9
7DC2: 97 B2          STA    $B2
7DC4: 80 0A          SUBA   #$0A
7DC6: 25 0E          BCS    $7DD6
7DC8: 97 B2          STA    $B2
7DCA: 0C B1          INC    $B1
7DCC: 96 B1          LDA    $B1
7DCE: 80 0A          SUBA   #$0A
7DD0: 25 04          BCS    $7DD6
7DD2: 97 B1          STA    $B1
7DD4: 0C B0          INC    $B0
7DD6: 0F CE          CLR    $CE
7DD8: 0C 06          INC    $06
7DDA: 0F 09          CLR    $09
7DDC: 39             RTS

7DDD: 0D D6          TST    $D6
7DDF: 27 0A          BEQ    $7DEB
7DE1: A6 06          LDA    $6,X
7DE3: 81 09          CMPA   #$09
7DE5: 27 05          BEQ    $7DEC
7DE7: 81 09          CMPA   #$09
7DE9: 27 08          BEQ    $7DF3
7DEB: 39             RTS

7DEC: 86 01          LDA    #$01
7DEE: A7 88 20       STA    $20,X
7DF1: 20 03          BRA    $7DF6
7DF3: 6F 88 20       CLR    $20,X
7DF6: 0F D6          CLR    $D6
7DF8: 6C 84          INC    ,X
7DFA: 0F 09          CLR    $09
7DFC: 0C 06          INC    $06
7DFE: 39             RTS

7DFF: 8E 28 A0       LDX    #$28A0
7E02: BD 97 DF       JSR    $97DF
7E05: BD 86 31       JSR    $8631
7E08: 7E 99 8B       JMP    $998B

7E0B: 8E 28 A0       LDX    #$28A0
7E0E: 10 8E A9 50    LDY    #table_a950
7E12: 96 09          LDA    $09
7E14: 48             ASLA
7E15: 6E B6          JMP    [A,Y]	; [jump_table]

7E17: CE 18 11       LDU    #$1811
7E1A: 86 08          LDA    #$08
7E1C: 97 48          STA    nb_objects_48
7E1E: 6F C9 03 FF    CLR    $03FF,U
7E22: 6F C1          CLR    ,U++
7E24: 0A 48          DEC    nb_objects_48
7E26: 26 F6          BNE    $7E1E
7E28: 0C 09          INC    $09
7E2A: 39             RTS

7E2B: 0A 08          DEC    $08
7E2D: 26 20          BNE    $7E4F
7E2F: 10 8E DC E9    LDY    #$DCE9
7E33: 10 9F AE       STY    $AE
7E36: BD 9A 2A       JSR    $9A2A
7E39: CE 18 08       LDU    #$1808
7E3C: BD CB 82       JSR    $CB82
7E3F: 8E 29 C0       LDX    #$29C0
7E42: 86 01          LDA    #$01
7E44: A7 84          STA    ,X
7E46: DC 98          LDD    $98
7E48: ED 01          STD    $1,X
7E4A: BD CC D7       JSR    $CCD7
7E4D: 0C 09          INC    $09
7E4F: 39             RTS

7E50: 8E 29 A0       LDX    #$29A0
7E53: 86 03          LDA    #$03
7E55: A7 84          STA    ,X
7E57: BD CC BD       JSR    $CCBD
7E5A: 86 25          LDA    #$25
7E5C: BD 85 0E       JSR    $850E
7E5F: 0C 09          INC    $09
7E61: 39             RTS

7E62: A6 84          LDA    ,X
7E64: 81 02          CMPA   #$02
7E66: 27 17          BEQ    $7E7F
7E68: 6C 02          INC    $2,X
7E6A: A6 02          LDA    $2,X
7E6C: 81 F0          CMPA   #$F0
7E6E: 24 08          BCC    $7E78
7E70: CE 18 08       LDU    #$1808
7E73: BD CB 82       JSR    $CB82
7E76: 20 07          BRA    $7E7F
7E78: BD CB 1D       JSR    $CB1D
7E7B: 86 02          LDA    #$02
7E7D: A7 84          STA    ,X
7E7F: 8E 29 C0       LDX    #$29C0
7E82: A6 84          LDA    ,X
7E84: 81 02          CMPA   #$02
7E86: 27 30          BEQ    $7EB8
7E88: 6C 02          INC    $2,X
7E8A: BD CC D7       JSR    $CCD7
7E8D: A6 02          LDA    $2,X
7E8F: D6 9B          LDB    $9B
7E91: CB 02          ADDB   #$02
7E93: D7 56          STB    $56
7E95: 91 56          CMPA   $56
7E97: 26 28          BNE    $7EC1
7E99: 86 02          LDA    #$02
7E9B: A7 84          STA    ,X
7E9D: 34 10          PSHS   X
7E9F: BD 86 F7       JSR    $86F7
7EA2: DC F0          LDD    $F0
7EA4: ED 84          STD    ,X
7EA6: DC F2          LDD    $F2
7EA8: ED 02          STD    $2,X
7EAA: BD 86 A1       JSR    $86A1
7EAD: 4F             CLRA
7EAE: BD 85 08       JSR    $8508
7EB1: 86 25          LDA    #$25
7EB3: BD 85 0E       JSR    $850E
7EB6: 35 10          PULS   X
7EB8: 96 A0          LDA    $A0
7EBA: 81 02          CMPA   #$02
7EBC: 26 02          BNE    $7EC0
7EBE: 0C 09          INC    $09
7EC0: 39             RTS

7EC1: BD 85 87       JSR    $8587
7EC4: 10 AE 03       LDY    $3,X
7EC7: A6 A4          LDA    ,Y		; [video_address]
7EC9: 81 4E          CMPA   #$4E
7ECB: 27 1F          BEQ    $7EEC
7ECD: 81 55          CMPA   #$55
7ECF: 27 1F          BEQ    $7EF0
7ED1: 81 56          CMPA   #$56
7ED3: 27 1F          BEQ    $7EF4
7ED5: 81 5D          CMPA   #$5D
7ED7: 27 1F          BEQ    $7EF8
7ED9: 86 04          LDA    #$04
7EDB: D6 3F          LDB    $3F
7EDD: C4 01          ANDB   #$01
7EDF: 26 01          BNE    $7EE2
7EE1: 4C             INCA
7EE2: 97 48          STA    nb_objects_48
7EE4: BD 86 7E       JSR    $867E
7EE7: 0A 48          DEC    nb_objects_48
7EE9: 26 F9          BNE    $7EE4
7EEB: 39             RTS

7EEC: 86 40          LDA    #$40
7EEE: 20 0A          BRA    $7EFA
7EF0: 86 41          LDA    #$41
7EF2: 20 06          BRA    $7EFA
7EF4: 86 42          LDA    #$42
7EF6: 20 02          BRA    $7EFA
7EF8: 86 43          LDA    #$43
7EFA: A7 A4          STA    ,Y		; [video_address]
7EFC: 39             RTS

7EFD: BD 96 E8       JSR    $96E8
7F00: 86 30          LDA    #$30
7F02: 97 0B          STA    $0B
7F04: 0C 09          INC    $09
7F06: 39             RTS

7F07: 0A 0B          DEC    $0B
7F09: 26 06          BNE    $7F11
7F0B: 0F 06          CLR    $06
7F0D: 0F 09          CLR    $09
7F0F: 0C 03          INC    boot_state_03
7F11: 39             RTS

7F12: 8E 28 A0       LDX    #$28A0
7F15: 10 8E A9 5C    LDY    #table_a95c
7F19: 96 09          LDA    $09
7F1B: 48             ASLA
7F1C: 6E B6          JMP    [A,Y]	; [jump_table]
7F1E: 0A 08          DEC    $08
7F20: 26 0F          BNE    $7F31
7F22: 10 8E DC E9    LDY    #$DCE9
7F26: 10 9F AE       STY    $AE
7F29: CE 18 08       LDU    #$1808
7F2C: BD CB 82       JSR    $CB82
7F2F: 0C 09          INC    $09
7F31: 39             RTS

7F32: 8E 29 A0       LDX    #$29A0
7F35: 86 02          LDA    #$02
7F37: A7 84          STA    ,X
7F39: BD CC BD       JSR    $CCBD
7F3C: 0C 09          INC    $09
7F3E: 39             RTS

7F3F: 96 EB          LDA    $EB
7F41: 26 12          BNE    $7F55
7F43: 6C 02          INC    $2,X
7F45: A6 02          LDA    $2,X
7F47: 81 F0          CMPA   #$F0
7F49: 24 07          BCC    $7F52
7F4B: CE 18 08       LDU    #$1808
7F4E: BD CB 82       JSR    $CB82
7F51: 39             RTS

7F52: BD CB 1D       JSR    $CB1D
7F55: 86 02          LDA    #$02
7F57: A7 84          STA    ,X
7F59: 0C 09          INC    $09
7F5B: 39             RTS

7F5C: BD 86 E3       JSR    $86E3
7F5F: BD 7F 6C       JSR    $7F6C
7F62: BD 96 E8       JSR    $96E8
7F65: 86 30          LDA    #$30
7F67: 97 0B          STA    $0B
7F69: 0C 09          INC    $09
7F6B: 39             RTS

7F6C: 96 AB          LDA    $AB
7F6E: 81 02          CMPA   #$02
7F70: 25 1C          BCS    $7F8E
7F72: CE 34 E4       LDU    #$34E4
7F75: 86 10          LDA    #$10
7F77: BD 61 EE       JSR    $61EE
7F7A: 86 16          LDA    #$16
7F7C: BD 61 EE       JSR    $61EE
7F7F: 86 1F          LDA    #$1F
7F81: BD 61 EE       JSR    $61EE
7F84: 86 25          LDA    #$25
7F86: BD 61 EE       JSR    $61EE
7F89: 86 1C          LDA    #$1C
7F8B: BD 61 EE       JSR    $61EE
7F8E: 39             RTS

7F8F: 0A 0B          DEC    $0B
7F91: 26 06          BNE    $7F99
7F93: 0F 06          CLR    $06
7F95: 0F 09          CLR    $09
7F97: 0C 03          INC    boot_state_03
7F99: 39             RTS

7F9A: 8E 28 A0       LDX    #$28A0
7F9D: 0A 0B          DEC    $0B
7F9F: 26 14          BNE    $7FB5
7FA1: 0A 0A          DEC    $0A
7FA3: 27 11          BEQ    $7FB6
7FA5: BD CE 42       JSR    $CE42
7FA8: 6C 88 32       INC    $32,X
7FAB: A6 02          LDA    $2,X
7FAD: 8B 08          ADDA   #$08
7FAF: A7 02          STA    $2,X
7FB1: 86 0C          LDA    #$0C
7FB3: 97 0B          STA    $0B
7FB5: 39             RTS

7FB6: 6F 88 32       CLR    $32,X
7FB9: 86 06          LDA    #$06
7FBB: 97 06          STA    $06
7FBD: 86 03          LDA    #$03
7FBF: 97 09          STA    $09
7FC1: 39             RTS

7FC2: BD 8E CC       JSR    $8ECC
7FC5: BD 8E F0       JSR    $8EF0
7FC8: 96 06          LDA    $06
7FCA: 48             ASLA
7FCB: 10 8E A9 66    LDY    #table_a966
7FCF: 6E B6          JMP    [A,Y]	; [jump_table]

7FD1: 96 DF          LDA    $DF
7FD3: 84 02          ANDA   #$02
7FD5: 97 DF          STA    $DF
7FD7: 97 FB          STA    $FB
7FD9: BD D7 FF       JSR    chrono_tick_d7ff
7FDC: BD CE 69       JSR    $CE69
7FDF: 96 7F          LDA    chrono_second_7f
7FE1: 81 40          CMPA   #$40
7FE3: 25 26          BCS    $800B
7FE5: 8E 28 A0       LDX    #$28A0
7FE8: A6 88 1C       LDA    $1C,X
7FEB: 26 1E          BNE    $800B
7FED: B6 2A 1C       LDA    $2A1C
7FF0: 26 19          BNE    $800B
7FF2: A6 88 33       LDA    $33,X
7FF5: 26 03          BNE    $7FFA
7FF7: BD 9F 15       JSR    $9F15
7FFA: 8E 2A 00       LDX    #$2A00
7FFD: 0C DF          INC    $DF
7FFF: A6 88 33       LDA    $33,X
8002: 26 03          BNE    $8007
8004: BD 9F 15       JSR    $9F15
8007: 0A DF          DEC    $DF
8009: 20 47          BRA    $8052
800B: BD 88 C8       JSR    $88C8
800E: C6 02          LDB    #$02
8010: 8E 28 A0       LDX    #$28A0
8013: 34 04          PSHS   B
8015: 6D 88 22       TST    $22,X
8018: 26 0E          BNE    $8028
801A: BD 9F 82       JSR    $9F82
801D: 10 8E A9 6C    LDY    #table_a96c
8021: A6 84          LDA    ,X
8023: 48             ASLA
8024: AD B6          JSR    [A,Y]	; [jump_table]
8026: 20 03          BRA    $802B

8028: 6A 88 22       DEC    $22,X
802B: 0C DF          INC    $DF
802D: 30 89 01 60    LEAX   $0160,X
8031: 35 04          PULS   B
8033: 5A             DECB
8034: 26 DD          BNE    $8013
8036: 96 FB          LDA    $FB
8038: 97 DF          STA    $DF
803A: BD 9F CD       JSR    $9FCD
803D: BD 8C D7       JSR    $8CD7
8040: 0F DA          CLR    $DA
8042: 7F 2A 3A       CLR    $2A3A
8045: 96 A0          LDA    $A0
8047: 81 05          CMPA   #$05
8049: 26 13          BNE    $805E
804B: B6 2A 00       LDA    $2A00
804E: 81 05          CMPA   #$05
8050: 26 0C          BNE    $805E
8052: 4F             CLRA
8053: BD 85 08       JSR    $8508
8056: 86 30          LDA    #$30
8058: 97 0B          STA    $0B
805A: 0C 06          INC    $06
805C: 0F 09          CLR    $09
805E: 39             RTS

805F: BD 9E 7D       JSR    $9E7D
8062: A6 88 1C       LDA    $1C,X
8065: 81 02          CMPA   #$02
8067: 10 27 01 0A    LBEQ   $8175
806B: 81 01          CMPA   #$01
806D: 10 27 00 4A    LBEQ   $80BB
8071: BD 8D 70       JSR    $8D70
8074: 5D             TSTB
8075: 10 26 00 DA    LBNE   $8153
8079: CE 28 39       LDU    #$2839
807C: 96 DF          LDA    $DF
807E: 84 01          ANDA   #$01
8080: 27 02          BEQ    $8084
8082: 33 43          LEAU   $3,U
8084: A6 42          LDA    $2,U
8086: AA 41          ORA    $1,U
8088: 43             COMA
8089: A4 C4          ANDA   ,U
808B: 84 02          ANDA   #$02
808D: 10 26 00 C2    LBNE   $8153
8091: BD 93 CD       JSR    $93CD
8094: BD 94 88       JSR    $9488
8097: BD 94 B8       JSR    $94B8
809A: BD 93 73       JSR    $9373
809D: A6 0C          LDA    $C,X
809F: AB 88 3A       ADDA   $3A,X
80A2: 24 02          BCC    $80A6
80A4: 6C 0B          INC    $B,X
80A6: A7 0C          STA    $C,X
80A8: 86 0C          LDA    #$0C
80AA: 7E 84 F5       JMP    queue_event_84f5
80AD: 4F             CLRA
80AE: E6 02          LDB    $2,X
80B0: 10 83 00 EE    CMPD   #$00EE
80B4: 25 04          BCS    $80BA
80B6: BD CB 1D       JSR    $CB1D
80B9: 4C             INCA
80BA: 39             RTS

80BB: 10 AE 88 18    LDY    $18,X
80BF: A6 A4          LDA    ,Y
80C1: 81 80          CMPA   #$80
80C3: 27 61          BEQ    $8126
80C5: 81 90          CMPA   #$90
80C7: 27 13          BEQ    $80DC
80C9: 20 02          BRA    $80CD
80CB: 31 21          LEAY   $1,Y
80CD: A6 01          LDA    $1,X
80CF: AB A0          ADDA   ,Y+
80D1: A7 01          STA    $1,X
80D3: 10 AF 88 18    STY    $18,X
80D7: 6C 88 1D       INC    $1D,X
80DA: 20 1B          BRA    $80F7
80DC: A6 88 37       LDA    $37,X
80DF: 81 05          CMPA   #$05
80E1: 27 E8          BEQ    $80CB
80E3: CE 28 39       LDU    #$2839
80E6: 96 DF          LDA    $DF
80E8: 84 01          ANDA   #$01
80EA: 27 02          BEQ    $80EE
80EC: 33 43          LEAU   $3,U
80EE: A6 C4          LDA    ,U
80F0: 84 02          ANDA   #$02
80F2: 27 D7          BEQ    $80CB
80F4: 6C 88 37       INC    $37,X
80F7: BD 93 CD       JSR    $93CD
80FA: BD 94 88       JSR    $9488
80FD: BD 94 B8       JSR    $94B8
8100: 6D 88 33       TST    $33,X
8103: 26 0B          BNE    $8110
8105: A6 0C          LDA    $C,X
8107: AB 88 3A       ADDA   $3A,X
810A: 24 02          BCC    $810E
810C: 6C 0B          INC    $B,X
810E: A7 0C          STA    $C,X
8110: A6 88 3A       LDA    $3A,X
8113: A7 88 15       STA    $15,X
8116: 86 04          LDA    #$04
8118: 97 49          STA    $49
811A: BD 94 4C       JSR    $944C
811D: 0A 49          DEC    $49
811F: 26 F9          BNE    $811A
8121: 86 0C          LDA    #$0C
8123: 7E 84 F5       JMP    queue_event_84f5
8126: BD 81 D1       JSR    $81D1
8129: BD 81 D1       JSR    $81D1
812C: 6F 88 37       CLR    $37,X
812F: 6F 88 1D       CLR    $1D,X
8132: CC DC B6       LDD    #$DCB6
8135: ED 0E          STD    $E,X
8137: 6D 88 33       TST    $33,X
813A: 27 03          BEQ    $813F
813C: 6C 84          INC    ,X
813E: 39             RTS

813F: A6 88 32       LDA    $32,X
8142: 26 04          BNE    $8148
8144: 6F 88 1C       CLR    $1C,X
8147: 39             RTS

8148: 86 02          LDA    #$02
814A: A7 88 1C       STA    $1C,X
814D: A7 88 2A       STA    $2A,X
8150: 7E 80 91       JMP    $8091
8153: 6C 88 1C       INC    $1C,X
8156: BD 81 96       JSR    $8196
8159: 8D 63          BSR    $81BE
815B: 8D 61          BSR    $81BE
815D: 86 06          LDA    #$06
815F: BD 85 0E       JSR    $850E
8162: 86 07          LDA    #$07
8164: BD 85 0E       JSR    $850E
8167: CC AB 77       LDD    #$AB77
816A: ED 88 18       STD    $18,X
816D: CC DD 2C       LDD    #$DD2C
8170: ED 0E          STD    $E,X
8172: 7E 80 BB       JMP    $80BB
8175: A6 88 2A       LDA    $2A,X
8178: 27 04          BEQ    $817E
817A: 6A 88 2A       DEC    $2A,X
817D: 39             RTS

817E: A6 88 31       LDA    $31,X
8181: 81 02          CMPA   #$02
8183: 27 01          BEQ    $8186
8185: 39             RTS

8186: A6 0C          LDA    $C,X
8188: 8B 01          ADDA   #$01
818A: 24 02          BCC    $818E
818C: 6C 0B          INC    $B,X
818E: A7 0C          STA    $C,X
8190: 86 01          LDA    #$01
8192: A7 88 3A       STA    $3A,X
8195: 39             RTS

8196: A6 88 10       LDA    $10,X
8199: C6 0A          LDB    #$0A
819B: 3D             MUL
819C: EB 88 11       ADDB   $11,X
819F: C1 03          CMPB   #$03
81A1: 25 10          BCS    $81B3
81A3: 8D 19          BSR    $81BE
81A5: A6 88 10       LDA    $10,X
81A8: C6 0A          LDB    #$0A
81AA: 3D             MUL
81AB: EB 88 11       ADDB   $11,X
81AE: C1 03          CMPB   #$03
81B0: 25 01          BCS    $81B3
81B2: 39             RTS

81B3: CC 00 03       LDD    #$0003
81B6: ED 88 10       STD    $10,X
81B9: 5F             CLRB
81BA: ED 88 12       STD    $12,X
81BD: 39             RTS

81BE: 6A 88 11       DEC    $11,X
81C1: A6 88 11       LDA    $11,X
81C4: 81 FF          CMPA   #$FF
81C6: 26 08          BNE    $81D0
81C8: 86 09          LDA    #$09
81CA: A7 88 11       STA    $11,X
81CD: 6A 88 10       DEC    $10,X
81D0: 39             RTS

81D1: 6C 88 11       INC    $11,X
81D4: A6 88 11       LDA    $11,X
81D7: 81 0A          CMPA   #$0A
81D9: 26 06          BNE    $81E1
81DB: 6F 88 11       CLR    $11,X
81DE: 6C 88 10       INC    $10,X
81E1: 39             RTS

81E2: 96 06          LDA    $06
81E4: 48             ASLA
81E5: 10 8E A9 78    LDY    #table_a978
81E9: 6E B6          JMP    [A,Y]		; [jump_table]

81EB: 8E A9 86       LDX    #table_a986
81EE: 96 09          LDA    $09
81F0: 48             ASLA
81F1: 6E 96          JMP    [A,X]		; [jump_table]

81F3: 8E 28 A0       LDX    #$28A0
81F6: 86 03          LDA    #$03
81F8: 97 B7          STA    $B7
81FA: CC DD E2       LDD    #$DDE2
81FD: DD AE          STD    $AE
81FF: CC 01 00       LDD    #$0100
8202: DD B0          STD    $B0
8204: 4F             CLRA
8205: DD B2          STD    $B2
8207: 86 06          LDA    #$06
8209: 97 D7          STA    $D7
820B: 97 A5          STA    $A5
820D: 0F D3          CLR    $D3
820F: BD CB C5       JSR    $CBC5
8212: 8E 2A 00       LDX    #$2A00
8215: BD CC 2D       JSR    $CC2D
8218: CC 01 00       LDD    #$0100
821B: BD 84 F5       JSR    queue_event_84f5
821E: CC 02 0C       LDD    #$020C
8221: BD 84 F5       JSR    queue_event_84f5
8224: CC 02 17       LDD    #$0217
8227: BD 84 F5       JSR    queue_event_84f5
822A: CC 01 0A       LDD    #$010A
822D: BD 84 F5       JSR    queue_event_84f5
8230: CC 02 3C       LDD    #$023C
8233: BD 84 F5       JSR    queue_event_84f5
8236: 86 0B          LDA    #$0B
8238: BD 84 F5       JSR    queue_event_84f5
823B: BD 90 E8       JSR    $90E8
823E: 86 05          LDA    #$05
8240: 5D             TSTB
8241: 27 02          BEQ    $8245
8243: 86 1E          LDA    #$1E
8245: 97 0B          STA    $0B
8247: 0C 09          INC    $09
8249: 39             RTS

824A: 0A 0B          DEC    $0B
824C: 26 12          BNE    $8260
824E: 86 28          LDA    #$28
8250: BD 85 08       JSR    $8508
8253: BD 8E 77       JSR    $8E77
8256: 7F 2A 98       CLR    $2A98
8259: 7F 2A 99       CLR    $2A99
825C: 0C 06          INC    $06
825E: 0F 09          CLR    $09
8260: 39             RTS

8261: 8E 28 39       LDX    #$2839
8264: 96 DF          LDA    $DF
8266: 84 01          ANDA   #$01
8268: 27 02          BEQ    $826C
826A: 30 03          LEAX   $3,X
826C: A6 02          LDA    $2,X
826E: AA 01          ORA    $1,X
8270: 43             COMA
8271: A4 84          ANDA   ,X
8273: 84 05          ANDA   #$05
8275: 26 06          BNE    $827D
8277: BD 8E 00       JSR    $8E00
827A: 5D             TSTB
827B: 27 05          BEQ    $8282
827D: 7F 2A B6       CLR    $2AB6
8280: 0C 06          INC    $06
8282: 39             RTS

8283: 8E 28 A0       LDX    #$28A0
8286: DC B0          LDD    $B0
8288: 10 83 01 05    CMPD   #$0105
828C: 27 2B          BEQ    $82B9
828E: CE A9 8A       LDU    #$A98A
8291: 96 D3          LDA    $D3
8293: A6 C6          LDA    A,U
8295: 27 13          BEQ    $82AA
8297: 97 49          STA    $49
8299: BD 91 14       JSR    $9114
829C: DC B0          LDD    $B0
829E: 10 83 01 05    CMPD   #$0105
82A2: 27 11          BEQ    $82B5
82A4: 0A 49          DEC    $49
82A6: 26 F1          BNE    $8299
82A8: 20 0F          BRA    $82B9
82AA: 96 3F          LDA    $3F
82AC: 84 07          ANDA   #$07
82AE: 27 09          BEQ    $82B9
82B0: BD 91 14       JSR    $9114
82B3: 20 04          BRA    $82B9
82B5: 0F B2          CLR    $B2
82B7: 0F B3          CLR    $B3
82B9: 86 0B          LDA    #$0B
82BB: BD 84 F5       JSR    queue_event_84f5
82BE: A6 02          LDA    $2,X
82C0: 81 89          CMPA   #$89
82C2: 27 5F          BEQ    $8323
82C4: BD CB C5       JSR    $CBC5
82C7: 8E 2A 00       LDX    #$2A00
82CA: BD CC 2D       JSR    $CC2D
82CD: CE 28 39       LDU    #$2839
82D0: 96 DF          LDA    $DF
82D2: 84 01          ANDA   #$01
82D4: 27 02          BEQ    $82D8
82D6: 33 43          LEAU   $3,U
82D8: A6 42          LDA    $2,U
82DA: AA 41          ORA    $1,U
82DC: 43             COMA
82DD: A4 C4          ANDA   ,U
82DF: 84 02          ANDA   #$02
82E1: 26 2B          BNE    $830E
82E3: 96 B1          LDA    $B1
82E5: 81 05          CMPA   #$05
82E7: 27 24          BEQ    $830D
82E9: CE 28 39       LDU    #$2839
82EC: 96 DF          LDA    $DF
82EE: 84 01          ANDA   #$01
82F0: 27 02          BEQ    $82F4
82F2: A6 42          LDA    $2,U
82F4: AA 41          ORA    $1,U
82F6: 43             COMA
82F7: A4 C4          ANDA   ,U
82F9: 84 05          ANDA   #$05
82FB: 27 10          BEQ    $830D
82FD: 7C 2A B6       INC    $2AB6
8300: B6 2A B6       LDA    $2AB6
8303: 81 03          CMPA   #$03
8305: 26 06          BNE    $830D
8307: 7F 2A B6       CLR    $2AB6
830A: BD 91 14       JSR    $9114
830D: 39             RTS

830E: BD A1 FA       JSR    $A1FA
8311: FC 2A 01       LDD    $2A01
8314: FD 2A 1E       STD    $2A1E
8317: 86 15          LDA    #$15
8319: B7 2A 38       STA    $2A38
831C: 0F D6          CLR    $D6
831E: 0C D7          INC    $D7
8320: 0C 06          INC    $06
8322: 39             RTS

8323: 86 30          LDA    #$30
8325: 97 08          STA    $08
8327: 86 06          LDA    #$06
8329: 97 06          STA    $06
832B: 0F 09          CLR    $09
832D: 39             RTS

832E: 10 8E A9 93    LDY    #table_a993
8332: 96 09          LDA    $09
8334: 48             ASLA
8335: 6E B6          JMP    [A,Y]	; [jump_table]

8337: 8E 2A 00       LDX    #$2A00
833A: BD A2 57       JSR    $A257
833D: BD CC 6B       JSR    $CC6B
8340: BD A2 B1       JSR    $A2B1
8343: 6C 88 1D       INC    $1D,X
8346: 8E 28 A0       LDX    #$28A0
8349: BD CB C5       JSR    $CBC5
834C: 39             RTS

834D: 8D 19          BSR    $8368
834F: 0A 0B          DEC    $0B
8351: 26 14          BNE    $8367
8353: BD A3 DA       JSR    $A3DA
8356: 8D 10          BSR    $8368
8358: 7F 2A C0       CLR    $2AC0
835B: 7F 2A E0       CLR    $2AE0
835E: 7F 2B 00       CLR    $2B00
8361: 86 05          LDA    #$05
8363: 97 08          STA    $08
8365: 20 C0          BRA    $8327
8367: 39             RTS

8368: 8E 2A C0       LDX    #$2AC0
836B: CE 18 20       LDU    #$1820
836E: 86 03          LDA    #$03
8370: 97 48          STA    nb_objects_48
8372: 6D 84          TST    ,X
8374: 27 03          BEQ    $8379
8376: BD CC 8B       JSR    $CC8B
8379: 30 88 20       LEAX   $20,X
837C: 33 42          LEAU   $2,U
837E: 0A 48          DEC    nb_objects_48
8380: 26 F0          BNE    $8372
8382: 39             RTS

8383: 10 8E A9 97    LDY    #table_a997
8387: 96 09          LDA    $09
8389: 48             ASLA
838A: 6E B6          JMP    [A,Y]	; [jump_table]

838C: 10 8E B6 E2    LDY    #$B6E2
8390: BD A3 F8       JSR    $A3F8
8393: 86 14          LDA    #$14
8395: BD 85 08       JSR    $8508
8398: 86 15          LDA    #$15
839A: BD 85 08       JSR    $8508
839D: 0C 09          INC    $09
839F: 39             RTS

83A0: 8E A9 A1       LDX    #$A9A1
83A3: 5F             CLRB
83A4: A6 80          LDA    ,X+
83A6: B1 2A 1A       CMPA   $2A1A
83A9: 27 07          BEQ    $83B2
83AB: 81 FF          CMPA   #$FF
83AD: 27 27          BEQ    $83D6
83AF: 5C             INCB
83B0: 20 F2          BRA    $83A4
83B2: 8E A9 B0       LDX    #$A9B0
83B5: A6 85          LDA    B,X
83B7: 97 53          STA    $53
83B9: 96 B2          LDA    $B2
83BB: 90 53          SUBA   $53
83BD: 97 B2          STA    $B2
83BF: 24 15          BCC    $83D6
83C1: 40             NEGA
83C2: 97 53          STA    $53
83C4: 86 0A          LDA    #$0A
83C6: 90 53          SUBA   $53
83C8: 97 B2          STA    $B2
83CA: 96 B1          LDA    $B1
83CC: 80 01          SUBA   #$01
83CE: 97 B1          STA    $B1
83D0: 24 04          BCC    $83D6
83D2: 0F B1          CLR    $B1
83D4: 0F B2          CLR    $B2
83D6: BD 88 8A       JSR    $888A
83D9: 0C 09          INC    $09
83DB: 39             RTS

83DC: 8E 2A 00       LDX    #$2A00
83DF: 96 D2          LDA    $D2
83E1: 26 25          BNE    $8408
83E3: CE 28 39       LDU    #$2839
83E6: 96 DF          LDA    $DF
83E8: 84 01          ANDA   #$01
83EA: 27 02          BEQ    $83EE
83EC: 33 43          LEAU   $3,U
83EE: A6 C4          LDA    ,U
83F0: 84 02          ANDA   #$02
83F2: 27 0F          BEQ    $8403
83F4: 7C 2A 38       INC    $2A38
83F7: B6 2A 38       LDA    $2A38
83FA: 81 50          CMPA   #$50
83FC: 27 05          BEQ    $8403
83FE: 7C 2A 38       INC    $2A38
8401: 20 05          BRA    $8408
8403: 0C D2          INC    $D2
8405: BD FB 26       JSR    $FB26
8408: 86 04          LDA    #$04
840A: BD 84 F5       JSR    queue_event_84f5
840D: BD DE FF       JSR    $DEFF
8410: DD 50          STD    $50
8412: 8E 2A 40       LDX    #$2A40
8415: AB 02          ADDA   $2,X
8417: A7 02          STA    $2,X
8419: B0 2A 1F       SUBA   $2A1F
841C: 97 52          STA    $52
841E: 10 8E ED 7B    LDY    #$ED7B
8422: B6 2A 18       LDA    $2A18
8425: 44             LSRA
8426: F6 2A 19       LDB    $2A19
8429: 26 01          BNE    $842C
842B: 44             LSRA
842C: A6 A6          LDA    A,Y
842E: D6 52          LDB    $52
8430: 3D             MUL
8431: 97 52          STA    $52
8433: B6 2A 1E       LDA    $2A1E
8436: 7D 2A 19       TST    $2A19
8439: 27 04          BEQ    $843F
843B: 90 52          SUBA   $52
843D: 20 02          BRA    $8441
843F: 9B 52          ADDA   $52
8441: A7 01          STA    $1,X
8443: BD CC 81       JSR    $CC81
8446: 8E 2A 00       LDX    #$2A00
8449: DC 50          LDD    $50
844B: AB 0C          ADDA   $C,X
844D: A7 0C          STA    $C,X
844F: A7 02          STA    $2,X
8451: EB 0B          ADDB   $B,X
8453: E7 0B          STB    $B,X
8455: 7D 2A 19       TST    $2A19
8458: 27 04          BEQ    $845E
845A: D0 52          SUBB   $52
845C: 20 02          BRA    $8460
845E: DB 52          ADDB   $52
8460: E7 01          STB    $1,X
8462: F1 2A 41       CMPB   $2A41
8465: 25 03          BCS    $846A
8467: 7E CC 77       JMP    $CC77
846A: FC 2A 41       LDD    $2A41
846D: ED 01          STD    $1,X
846F: A6 02          LDA    $2,X
8471: BB 2A BA       ADDA   $2ABA
8474: A7 02          STA    $2,X
8476: BD CC 77       JSR    $CC77
8479: 8E 2A 40       LDX    #$2A40
847C: 6F 01          CLR    $1,X
847E: 6F 02          CLR    $2,X
8480: BD CC 81       JSR    $CC81
8483: 4F             CLRA
8484: BD 85 08       JSR    $8508
8487: 86 09          LDA    #$09
8489: BD 85 08       JSR    $8508
848C: 0C 06          INC    $06
848E: 0F 09          CLR    $09
8490: 39             RTS

8491: 10 8E A9 9D    LDY    #table_a99d
8495: 96 09          LDA    $09
8497: 48             ASLA
8498: 6E B6          JMP    [A,Y]	; [jump_table]

849A: B6 2A 02       LDA    $2A02
849D: 80 20          SUBA   #$20
849F: 97 52          STA    $52
84A1: 8E A9 A1       LDX    #$A9A1
84A4: 5F             CLRB
84A5: A6 80          LDA    ,X+
84A7: B1 2A 1A       CMPA   $2A1A
84AA: 27 07          BEQ    $84B3
84AC: 81 FF          CMPA   #$FF
84AE: 27 23          BEQ    $84D3
84B0: 5C             INCB
84B1: 20 F2          BRA    $84A5
84B3: 8E A9 A9       LDX    #$A9A9
84B6: A6 85          LDA    B,X
84B8: 9B 52          ADDA   $52
84BA: 8B 02          ADDA   #$02
84BC: B0 2A BA       SUBA   $2ABA
84BF: 97 52          STA    $52
84C1: 0C 97          INC    $97
84C3: CE AA F0       LDU    #$AAF0
84C6: BD 89 A5       JSR    $89A5
84C9: BD 86 C0       JSR    $86C0
84CC: 86 1E          LDA    #$1E
84CE: 97 0B          STA    $0B
84D0: 0C 09          INC    $09
84D2: 39             RTS

84D3: 86 30          LDA    #$30
84D5: 97 08          STA    $08
84D7: 0C 06          INC    $06
84D9: 0F 09          CLR    $09
84DB: 39             RTS

84DC: 0A 0B          DEC    $0B
84DE: 26 06          BNE    $84E6
84E0: 0F 06          CLR    $06
84E2: 0F 09          CLR    $09
84E4: 0C 03          INC    boot_state_03
84E6: 39             RTS

84E7: 0A 08          DEC    $08
84E9: 26 09          BNE    $84F4
84EB: BD 86 E3       JSR    $86E3
84EE: 0C 03          INC    boot_state_03
84F0: 0F 06          CLR    $06
84F2: 0F 09          CLR    $09
84F4: 39             RTS

queue_event_84f5:
84F5: 10 9E 18       LDY    event_pointer_18
84F8: ED A1          STD    ,Y++
84FA: 10 8C 29 40    CMPY   #$2940
84FE: 26 04          BNE    $8504
8500: 10 8E 29 00    LDY    #event_buffer_2900
8504: 10 9F 18       STY    event_pointer_18
8507: 39             RTS

8508: D6 2D          LDB    dsw2_copy_2d
850A: C4 80          ANDB   #$80
850C: 26 04          BNE    $8512
850E: 0D 22          TST    $22
8510: 27 12          BEQ    $8524
8512: 10 9E 1C       LDY    $1C
8515: A7 A0          STA    ,Y+
8517: 10 8C 29 60    CMPY   #player_1_final_time_2960
851B: 26 04          BNE    $8521
851D: 10 8E 29 40    LDY    #$2940
8521: 10 9F 1C       STY    $1C
8524: 39             RTS

8525: B6 2F E8       LDA    $2FE8
8528: 84 07          ANDA   #$07
852A: 26 5A          BNE    $8586
852C: FE 2F E9       LDU    $2FE9
852F: 10 9E 87       LDY    $87
8532: A6 A4          LDA    ,Y
8534: 81 FF          CMPA   #$FF
8536: 26 03          BNE    $853B
8538: 10 AE 21       LDY    $1,Y
853B: 86 04          LDA    #$04
853D: 97 4A          STA    $4A
853F: D6 89          LDB    $89
8541: E7 C9 08 00    STB    $0800,U			; [video_address]
8545: A6 A0          LDA    ,Y+
8547: A7 C4          STA    ,U              ; [video_address]
8549: 33 C8 C0       LEAU   -$40,U
854C: 0A 4A          DEC    $4A
854E: 26 F1          BNE    $8541
8550: 86 07          LDA    #$07
8552: 97 4A          STA    $4A
8554: 96 84          LDA    current_level_84
8556: 81 02          CMPA   #$02
8558: 26 0A          BNE    $8564
855A: 31 23          LEAY   $3,Y
855C: 33 C9 FF 40    LEAU   -$00C0,U
8560: 86 04          LDA    #$04
8562: 97 4A          STA    $4A
8564: E7 C9 08 00    STB    $0800,U			; [video_address]
8568: A6 A0          LDA    ,Y+
856A: A7 C4          STA    ,U				; [video_address]
856C: 33 C8 C0       LEAU   -$40,U
856F: 0A 4A          DEC    $4A
8571: 26 F1          BNE    $8564
8573: 33 C9 02 C1    LEAU   $02C1,U
8577: 11 83 37 40    CMPU   #$3740
857B: 26 03          BNE    $8580
857D: CE 37 00       LDU    #$3700
8580: FF 2F E9       STU    $2FE9
8583: 10 9F 87       STY    $87
8586: 39             RTS

8587: 0F 64          CLR    $64
8589: DE 85          LDU    $85
858B: 33 C9 00 C0    LEAU   $00C0,U
858F: A6 02          LDA    $2,X
8591: 84 F8          ANDA   #$F8
8593: 44             LSRA
8594: 44             LSRA
8595: 44             LSRA
8596: 33 41          LEAU   $1,U
8598: 11 83 37 FF    CMPU   #$37FF
859C: 25 03          BCS    $85A1
859E: CE 37 C0       LDU    #$37C0
85A1: 4A             DECA
85A2: 26 F2          BNE    $8596
85A4: A6 01          LDA    $1,X
85A6: 84 F8          ANDA   #$F8
85A8: 44             LSRA
85A9: 44             LSRA
85AA: 44             LSRA
85AB: 33 C8 C0       LEAU   -$40,U
85AE: 4A             DECA
85AF: 26 FA          BNE    $85AB
85B1: DF 4C          STU    $4C
85B3: A6 02          LDA    $2,X
85B5: 84 07          ANDA   #$07
85B7: 97 55          STA    $55
85B9: 96 94          LDA    $94
85BB: 84 07          ANDA   #$07
85BD: 9B 55          ADDA   $55
85BF: A7 0D          STA    $D,X
85C1: 81 08          CMPA   #$08
85C3: 25 14          BCS    $85D9
85C5: 80 08          SUBA   #$08
85C7: A7 0D          STA    $D,X
85C9: 0C 64          INC    $64
85CB: DC 4C          LDD    $4C
85CD: C3 00 01       ADDD   #$0001
85D0: C5 3F          BITB   #$3F
85D2: 26 03          BNE    $85D7
85D4: 83 00 40       SUBD   #$0040
85D7: 20 02          BRA    $85DB
85D9: DC 4C          LDD    $4C
85DB: ED 03          STD    $3,X
85DD: 39             RTS

85DE: DE 77          LDU    $77
85E0: 33 C9 02 40    LEAU   $0240,U
85E4: A6 02          LDA    $2,X
85E6: 84 F8          ANDA   #$F8
85E8: 44             LSRA
85E9: 44             LSRA
85EA: 44             LSRA
85EB: 33 41          LEAU   $1,U
85ED: 11 83 37 FF    CMPU   #$37FF
85F1: 25 03          BCS    $85F6
85F3: CE 37 C0       LDU    #$37C0
85F6: 4A             DECA
85F7: 26 F2          BNE    $85EB
85F9: A6 01          LDA    $1,X
85FB: 84 F8          ANDA   #$F8
85FD: 44             LSRA
85FE: 44             LSRA
85FF: 44             LSRA
8600: 33 C8 C0       LEAU   -$40,U
8603: 4A             DECA
8604: 26 FA          BNE    $8600
8606: DF 4C          STU    $4C
8608: A6 02          LDA    $2,X
860A: 84 07          ANDA   #$07
860C: 97 55          STA    $55
860E: 96 76          LDA    $76
8610: 84 07          ANDA   #$07
8612: 9B 55          ADDA   $55
8614: A7 0D          STA    $D,X
8616: 81 08          CMPA   #$08
8618: 25 12          BCS    $862C
861A: 80 08          SUBA   #$08
861C: A7 0D          STA    $D,X
861E: DC 4C          LDD    $4C
8620: C3 00 01       ADDD   #$0001
8623: C5 3F          BITB   #$3F
8625: 26 03          BNE    $862A
8627: 83 00 40       SUBD   #$0040
862A: 20 02          BRA    $862E
862C: DC 4C          LDD    $4C
862E: ED 03          STD    $3,X
8630: 39             RTS

8631: DE 85          LDU    $85
8633: 33 C9 00 C0    LEAU   $00C0,U
8637: A6 02          LDA    $2,X
8639: 84 F8          ANDA   #$F8
863B: 44             LSRA
863C: 44             LSRA
863D: 44             LSRA
863E: 33 41          LEAU   $1,U
8640: 11 83 37 FF    CMPU   #$37FF
8644: 25 03          BCS    $8649
8646: CE 37 C0       LDU    #$37C0
8649: 4A             DECA
864A: 26 F2          BNE    $863E
864C: A6 88 14       LDA    $14,X
864F: 44             LSRA
8650: 44             LSRA
8651: 44             LSRA
8652: 33 C8 C0       LEAU   -$40,U
8655: 4A             DECA
8656: 26 FA          BNE    $8652
8658: DF 4C          STU    $4C
865A: A6 02          LDA    $2,X
865C: 84 07          ANDA   #$07
865E: 97 55          STA    $55
8660: 96 94          LDA    $94
8662: 84 07          ANDA   #$07
8664: 9B 55          ADDA   $55
8666: 81 08          CMPA   #$08
8668: 25 0E          BCS    $8678
866A: DC 4C          LDD    $4C
866C: C3 00 01       ADDD   #$0001
866F: C5 3F          BITB   #$3F
8671: 26 03          BNE    $8676
8673: 83 00 40       SUBD   #$0040
8676: 20 02          BRA    $867A
8678: DC 4C          LDD    $4C
867A: ED 88 1E       STD    $1E,X
867D: 39             RTS

867E: BD 86 F7       JSR    $86F7
8681: 6C 03          INC    $3,X
8683: A6 03          LDA    $3,X
8685: 81 0A          CMPA   #$0A
8687: 26 18          BNE    $86A1
8689: 6F 03          CLR    $3,X
868B: 6C 02          INC    $2,X
868D: A6 02          LDA    $2,X
868F: 81 0A          CMPA   #$0A
8691: 26 0E          BNE    $86A1
8693: 6F 02          CLR    $2,X
8695: 6C 01          INC    $1,X
8697: A6 01          LDA    $1,X
8699: 81 0A          CMPA   #$0A
869B: 26 04          BNE    $86A1
869D: 6F 01          CLR    $1,X
869F: 6C 84          INC    ,X
86A1: CE 34 E4       LDU    #$34E4
86A4: A6 84          LDA    ,X
86A6: BD 61 EE       JSR    $61EE
86A9: A6 01          LDA    $1,X
86AB: BD 61 EE       JSR    $61EE
86AE: BD 8A 1D       JSR    $8A1D
86B1: C6 09          LDB    #$09
86B3: BD 61 F0       JSR    write_char_and_move_cursor_61f0
86B6: A6 02          LDA    $2,X
86B8: BD 61 EE       JSR    $61EE
86BB: A6 03          LDA    $3,X
86BD: 7E 61 EE       JMP    $61EE
86C0: BD 86 F7       JSR    $86F7
86C3: CE 28 6A       LDU    #current_attempted_height_metre_286a
86C6: A6 C4          LDA    ,U
86C8: 44             LSRA
86C9: 44             LSRA
86CA: 44             LSRA
86CB: 44             LSRA
86CC: A7 84          STA    ,X
86CE: A6 C4          LDA    ,U
86D0: 84 0F          ANDA   #$0F
86D2: A7 01          STA    $1,X
86D4: A6 41          LDA    $1,U
86D6: 44             LSRA
86D7: 44             LSRA
86D8: 44             LSRA
86D9: 44             LSRA
86DA: A7 02          STA    $2,X
86DC: A6 41          LDA    $1,U
86DE: 84 0F          ANDA   #$0F
86E0: A7 03          STA    $3,X
86E2: 39             RTS

86E3: BD 86 F7       JSR    $86F7
86E6: 86 16          LDA    #$16
86E8: A7 84          STA    ,X
86EA: 86 1F          LDA    #$1F
86EC: A7 01          STA    $1,X
86EE: 86 25          LDA    #$25
86F0: A7 02          STA    $2,X
86F2: 86 1C          LDA    #$1C
86F4: A7 03          STA    $3,X
86F6: 39             RTS

86F7: 8E 29 60       LDX    #player_1_final_time_2960
86FA: 96 DF          LDA    $DF
86FC: C6 0C          LDB    #$0C
86FE: 3D             MUL
86FF: 30 8B          LEAX   D,X
8701: 96 9F          LDA    high_jump_fault_9f
8703: C6 04          LDB    #$04
8705: 3D             MUL
8706: 30 8B          LEAX   D,X
8708: 39             RTS

8709: CE 32 58       LDU    #$3258
870C: 96 9F          LDA    high_jump_fault_9f
870E: C6 40          LDB    #$40
8710: 3D             MUL
8711: 33 CB          LEAU   D,U
8713: BD 86 F7       JSR    $86F7
8716: A6 84          LDA    ,X
8718: 81 16          CMPA   #$16
871A: 27 20          BEQ    $873C
871C: A6 80          LDA    ,X+
871E: 26 02          BNE    $8722
8720: 86 10          LDA    #$10
8722: BD 61 EE       JSR    $61EE
8725: A6 80          LDA    ,X+
8727: BD 61 EE       JSR    $61EE
872A: BD 8A 1D       JSR    $8A1D
872D: C6 09          LDB    #$09
872F: BD 61 F0       JSR    write_char_and_move_cursor_61f0
8732: A6 80          LDA    ,X+
8734: BD 61 EE       JSR    $61EE
8737: A6 80          LDA    ,X+
8739: 7E 61 EE       JMP    $61EE
873C: 86 10          LDA    #$10
873E: BD 61 EE       JSR    $61EE
8741: 86 16          LDA    #$16
8743: BD 61 EE       JSR    $61EE
8746: 86 1F          LDA    #$1F
8748: BD 61 EE       JSR    $61EE
874B: 86 25          LDA    #$25
874D: BD 61 EE       JSR    $61EE
8750: 86 1C          LDA    #$1C
8752: BD 61 EE       JSR    $61EE
8755: 30 04          LEAX   $4,X
8757: 39             RTS

8758: 8E 29 60       LDX    #player_1_final_time_2960
875B: 96 DF          LDA    $DF
875D: C6 0C          LDB    #$0C
875F: 3D             MUL
8760: 30 8B          LEAX   D,X
8762: CE 32 58       LDU    #$3258
8765: 96 9F          LDA    high_jump_fault_9f
8767: 97 48          STA    nb_objects_48
8769: 27 0A          BEQ    $8775
876B: BD 87 16       JSR    $8716
876E: 33 C8 3B       LEAU   $3B,U
8771: 0A 48          DEC    nb_objects_48
8773: 26 F6          BNE    $876B
8775: C6 05          LDB    #$05
8777: 7E 8A 15       JMP    $8A15

check_player_qualified_877a:
877A: BD 86 F7       JSR    $86F7
877D: 0F CD          CLR    player_is_qualified_cd
877F: A6 84          LDA    ,X
8781: 81 16          CMPA   #$16
8783: 27 0C          BEQ    $8791
; check if player is qualified
8785: 10 8E 28 66    LDY    #qualifying_value_2866
8789: BD 89 68       JSR    compare_performances_8968
878C: 5D             TSTB
878D: 27 02          BEQ    $8791
; player is qualified
878F: 0C CD          INC    player_is_qualified_cd
8791: 39             RTS

8792: 0F 7D          CLR    $7D
8794: 8E 29 60       LDX    #player_1_final_time_2960
8797: 96 DF          LDA    $DF
8799: C6 0C          LDB    #$0C
879B: 3D             MUL
879C: 30 8B          LEAX   D,X
879E: 31 04          LEAY   $4,X
87A0: A6 84          LDA    ,X
87A2: 81 16          CMPA   #$16
87A4: 27 22          BEQ    $87C8
87A6: E6 A4          LDB    ,Y
87A8: C1 16          CMPB   #$16
87AA: 27 20          BEQ    $87CC
87AC: A1 A4          CMPA   ,Y
87AE: 25 18          BCS    $87C8
87B0: 22 1A          BHI    $87CC
87B2: A6 01          LDA    $1,X
87B4: A1 21          CMPA   $1,Y
87B6: 25 10          BCS    $87C8
87B8: 22 12          BHI    $87CC
87BA: A6 02          LDA    $2,X
87BC: A1 22          CMPA   $2,Y
87BE: 25 08          BCS    $87C8
87C0: 22 0A          BHI    $87CC
87C2: A6 03          LDA    $3,X
87C4: A1 23          CMPA   $3,Y
87C6: 24 04          BCC    $87CC
87C8: 30 04          LEAX   $4,X
87CA: 0C 7D          INC    $7D
87CC: 31 24          LEAY   $4,Y
87CE: A6 84          LDA    ,X
87D0: 81 16          CMPA   #$16
87D2: 27 22          BEQ    $87F6
87D4: E6 A4          LDB    ,Y
87D6: C1 16          CMPB   #$16
87D8: 27 20          BEQ    $87FA
87DA: A1 A4          CMPA   ,Y
87DC: 25 18          BCS    $87F6
87DE: 22 1A          BHI    $87FA
87E0: A6 01          LDA    $1,X
87E2: A1 21          CMPA   $1,Y
87E4: 25 10          BCS    $87F6
87E6: 22 12          BHI    $87FA
87E8: A6 02          LDA    $2,X
87EA: A1 22          CMPA   $2,Y
87EC: 25 08          BCS    $87F6
87EE: 22 0A          BHI    $87FA
87F0: A6 03          LDA    $3,X
87F2: A1 23          CMPA   $3,Y
87F4: 24 04          BCC    $87FA
87F6: 86 02          LDA    #$02
87F8: 97 7D          STA    $7D
87FA: 39             RTS

87FB: 8E 29 A0       LDX    #$29A0
87FE: CE AB 3B       LDU    #$AB3B
8801: 96 84          LDA    current_level_84
8803: C6 0A          LDB    #$0A
8805: 3D             MUL
8806: 33 CB          LEAU   D,U
8808: EC C1          LDD    ,U++
880A: DD A1          STD    p2_attempts_left_a1
880C: 97 B4          STA    $B4
880E: 0F A0          CLR    $A0
8810: 86 04          LDA    #$04
8812: 97 48          STA    nb_objects_48
8814: EC C1          LDD    ,U++
8816: ED 01          STD    $1,X
8818: A7 88 14       STA    $14,X
881B: 6F 84          CLR    ,X
881D: 30 88 20       LEAX   $20,X
8820: 0A 48          DEC    nb_objects_48
8822: 26 F0          BNE    $8814
8824: 39             RTS

8825: 8E AB A3       LDX    #$ABA3
8828: 96 84          LDA    current_level_84
882A: C6 07          LDB    #$07
882C: 3D             MUL
882D: 30 8B          LEAX   D,X
882F: CE 28 E0       LDU    #$28E0
8832: C6 07          LDB    #$07
8834: A6 80          LDA    ,X+
8836: A7 C0          STA    ,U+
8838: 5A             DECB
8839: 26 F9          BNE    $8834
883B: 39             RTS

883C: 10 8E 2A F5    LDY    #$2AF5
8840: 6C A0          INC    ,Y+
8842: 10 8C 2B 00    CMPY   #$2B00
8846: 26 F8          BNE    $8840
8848: 0C 94          INC    $94
884A: BD 96 0C       JSR    $960C
884D: 0A 49          DEC    $49
884F: 26 EB          BNE    $883C
8851: 39             RTS

8852: EC 03          LDD    $3,X
8854: C3 00 01       ADDD   #$0001
8857: C5 3F          BITB   #$3F
8859: 26 03          BNE    $885E
885B: 83 00 40       SUBD   #$0040
885E: 1F 02          TFR    D,Y
8860: 39             RTS

8861: CE 28 F0       LDU    #$28F0
8864: 5F             CLRB
8865: A6 C4          LDA    ,U
8867: A1 A4          CMPA   ,Y
8869: 26 13          BNE    $887E
886B: A6 41          LDA    $1,U
886D: A1 21          CMPA   $1,Y
886F: 26 0D          BNE    $887E
8871: A6 42          LDA    $2,U
8873: A1 22          CMPA   $2,Y
8875: 25 07          BCS    $887E
8877: A6 43          LDA    $3,U
8879: A1 23          CMPA   $3,Y
887B: 25 01          BCS    $887E
887D: 5C             INCB
887E: 39             RTS

887F: 5F             CLRB
8880: 81 0A          CMPA   #$0A
8882: 25 05          BCS    $8889
8884: 80 0A          SUBA   #$0A
8886: 5C             INCB
8887: 20 F7          BRA    $8880
8889: 39             RTS

888A: DE E4          LDU    $E4
888C: 10 8E A9 B7    LDY    #$A9B7
8890: D6 84          LDB    current_level_84
8892: E6 A5          LDB    B,Y
8894: D7 48          STB    nb_objects_48
8896: 10 8E AF 62    LDY    #$AF62
889A: 96 84          LDA    current_level_84
889C: 81 01          CMPA   #$01
889E: 27 04          BEQ    $88A4
88A0: 10 8E AF 62    LDY    #$AF62
88A4: D6 48          LDB    nb_objects_48
88A6: D8 73          EORB   $73
88A8: 86 05          LDA    #$05
88AA: 97 48          STA    nb_objects_48
88AC: 86 03          LDA    #$03
88AE: 97 49          STA    $49
88B0: A6 A0          LDA    ,Y+
88B2: E7 C9 08 00    STB    $0800,U				; [video_address]
88B6: A7 C4          STA    ,U					; [video_address]
88B8: 33 C8 C0       LEAU   -$40,U
88BB: 0A 49          DEC    $49
88BD: 26 F1          BNE    $88B0
88BF: 33 C9 00 C1    LEAU   $00C1,U
88C3: 0A 48          DEC    nb_objects_48
88C5: 26 E5          BNE    $88AC
88C7: 39             RTS

88C8: 96 FB          LDA    $FB
88CA: 97 DF          STA    $DF
88CC: 39             RTS

88CD: 10 8E 2B 61    LDY    #$2B61
88D1: A6 84          LDA    ,X
88D3: 81 16          CMPA   #$16
88D5: 26 03          BNE    $88DA
88D7: 8E 2A 9C       LDX    #$2A9C
88DA: 86 04          LDA    #$04
88DC: 97 48          STA    nb_objects_48
88DE: BD 89 68       JSR    compare_performances_8968
88E1: 5D             TSTB
88E2: 26 1E          BNE    $8902
88E4: A6 3F          LDA    -$1,Y
88E6: 84 0F          ANDA   #$0F
88E8: 4A             DECA
88E9: 91 DF          CMPA   $DF
88EB: 27 07          BEQ    $88F4
88ED: 31 25          LEAY   $5,Y
88EF: 0A 48          DEC    nb_objects_48
88F1: 26 EB          BNE    $88DE
88F3: 39             RTS

88F4: A6 3F          LDA    -$1,Y
88F6: 84 20          ANDA   #$20
88F8: 27 07          BEQ    $8901
88FA: 96 DF          LDA    $DF
88FC: 4C             INCA
88FD: 8A 10          ORA    #$10
88FF: A7 3F          STA    -$1,Y
8901: 39             RTS

8902: 1F 23          TFR    Y,U
8904: 33 5F          LEAU   -$1,U
8906: 96 48          LDA    nb_objects_48
8908: 97 49          STA    $49
890A: A6 3F          LDA    -$1,Y
890C: 84 0F          ANDA   #$0F
890E: 4A             DECA
890F: 91 DF          CMPA   $DF
8911: 27 06          BEQ    $8919
8913: 31 25          LEAY   $5,Y
8915: 0A 49          DEC    $49
8917: 26 F1          BNE    $890A
8919: 96 48          LDA    nb_objects_48
891B: 90 49          SUBA   $49
891D: 97 48          STA    nb_objects_48
891F: 27 1A          BEQ    $893B
8921: 4A             DECA
8922: C6 05          LDB    #$05
8924: 3D             MUL
8925: 33 CB          LEAU   D,U
8927: 20 02          BRA    $892B
8929: 33 5B          LEAU   -$5,U
892B: A6 C4          LDA    ,U		; [video_address]
892D: A7 45          STA    $5,U		; [video_address]
892F: EC 41          LDD    $1,U		; [video_address]
8931: ED 46          STD    $6,U		; [video_address_word]
8933: EC 43          LDD    $3,U		; [video_address]
8935: ED 48          STD    $8,U		; [video_address_word]
8937: 0A 48          DEC    nb_objects_48
8939: 26 EE          BNE    $8929
893B: 96 84          LDA    current_level_84
893D: 81 00          CMPA   #$00
893F: 27 04          BEQ    $8945
8941: 81 03          CMPA   #$03
8943: 26 15          BNE    $895A
8945: 96 AA          LDA    $AA
8947: D6 DF          LDB    $DF
8949: C4 01          ANDB   #$01
894B: 27 03          BEQ    $8950
894D: B6 2A 0A       LDA    $2A0A
8950: 4D             TSTA
8951: 27 07          BEQ    $895A
8953: 96 DF          LDA    $DF
8955: 4C             INCA
8956: 8A 10          ORA    #$10
8958: 20 03          BRA    $895D
895A: 96 DF          LDA    $DF
895C: 4C             INCA
895D: A7 C0          STA    ,U+		; [video_address]
895F: EC 81          LDD    ,X++
8961: ED C1          STD    ,U++		; [video_address_word]
8963: EC 84          LDD    ,X
8965: ED C4          STD    ,U		; [video_address]
8967: 39             RTS

; compare times/length/height
; comparison is inverted for times of course
; < X: time/length
; < Y: time/length to compare to
; > B: 1 if time in X is < time in Y
; > B: 1 if length in X is > length in Y
compare_performances_8968:
8968: 0F 62          CLR    $62
896A: 5F             CLRB
896B: A6 A4          LDA    ,Y
896D: A1 84          CMPA   ,X
896F: 25 26          BCS    $8997
8971: 22 2B          BHI    $899E
8973: A6 21          LDA    $1,Y
8975: A1 01          CMPA   $1,X
8977: 25 1E          BCS    $8997
8979: 22 23          BHI    $899E
897B: A6 22          LDA    $2,Y
897D: A1 02          CMPA   $2,X
897F: 25 16          BCS    $8997
8981: 22 1B          BHI    $899E
8983: 96 84          LDA    current_level_84
8985: 81 FF          CMPA   #$FF
8987: 27 0C          BEQ    $8995
8989: A6 23          LDA    $3,Y
898B: A1 03          CMPA   $3,X
898D: 25 08          BCS    $8997
898F: 22 0D          BHI    $899E
8991: 86 01          LDA    #$01
8993: 97 62          STA    $62
8995: 5C             INCB
8996: 39             RTS

8997: 96 E6          LDA    $E6
8999: 81 1D          CMPA   #$1D
899B: 27 F8          BEQ    $8995
899D: 39             RTS

899E: 96 E6          LDA    $E6
89A0: 81 23          CMPA   #$23
89A2: 27 F1          BEQ    $8995
89A4: 39             RTS

89A5: 0F 6A          CLR    $6A
89A7: 0F 6B          CLR    $6B
89A9: 0F 6C          CLR    $6C
89AB: 96 97          LDA    $97
89AD: 27 37          BEQ    $89E6
89AF: 10 8E 28 6A    LDY    #current_attempted_height_metre_286a
89B3: A6 42          LDA    $2,U
89B5: AB 22          ADDA   $2,Y
89B7: 19             DAA
89B8: A7 22          STA    $2,Y
89BA: A6 41          LDA    $1,U
89BC: A9 21          ADCA   $1,Y
89BE: 19             DAA
89BF: A7 21          STA    $1,Y
89C1: A6 C4          LDA    ,U
89C3: A9 A4          ADCA   ,Y
89C5: 19             DAA
89C6: A7 A4          STA    ,Y
89C8: 0A 52          DEC    $52
89CA: 26 E7          BNE    $89B3
89CC: B6 2A BB       LDA    $2ABB
89CF: 48             ASLA
89D0: 48             ASLA
89D1: 48             ASLA
89D2: 48             ASLA
89D3: BA 2A BC       ORA    $2ABC
89D6: 97 48          STA    nb_objects_48
89D8: A6 21          LDA    $1,Y
89DA: 9B 48          ADDA   nb_objects_48
89DC: 19             DAA
89DD: A7 21          STA    $1,Y
89DF: A6 A4          LDA    ,Y
89E1: 89 00          ADCA   #$00
89E3: 19             DAA
89E4: A7 A4          STA    ,Y
89E6: 96 6A          LDA    $6A
89E8: 44             LSRA
89E9: 44             LSRA
89EA: 44             LSRA
89EB: 44             LSRA
89EC: 97 F0          STA    $F0
89EE: 96 6A          LDA    $6A
89F0: 84 0F          ANDA   #$0F
89F2: 97 F1          STA    $F1
89F4: 96 6B          LDA    $6B
89F6: 44             LSRA
89F7: 44             LSRA
89F8: 44             LSRA
89F9: 44             LSRA
89FA: 97 F2          STA    $F2
89FC: 96 6B          LDA    $6B
89FE: 84 0F          ANDA   #$0F
8A00: 97 F3          STA    $F3
8A02: 39             RTS

8A03: 34 10          PSHS   X
8A05: 8E 2A E0       LDX    #$2AE0
8A08: CE 18 18       LDU    #$1818
8A0B: 10 8E DD 6F    LDY    #$DD6F
8A0F: BD CE D3       JSR    $CED3
8A12: 35 10          PULS   X
8A14: 39             RTS

8A15: 86 10          LDA    #$10
8A17: A7 C0          STA    ,U+		; [video_address]
8A19: 5A             DECB
8A1A: 26 FB          BNE    $8A17
8A1C: 39             RTS

8A1D: 86 A7          LDA    #$A7
8A1F: D6 E6          LDB    $E6
8A21: C1 1D          CMPB   #$1D
8A23: 27 02          BEQ    $8A27
8A25: 86 6B          LDA    #$6B
8A27: 39             RTS

8A28: 20 FE          BRA    $8A28		; [rom_check_code]

8A2A: 8D 61          BSR    $8A8D
8A2C: EC C4          LDD    ,U
8A2E: ED 84          STD    ,X
8A30: A6 42          LDA    $2,U
8A32: A7 02          STA    $2,X
8A34: A6 44          LDA    $4,U
8A36: A7 04          STA    $4,X
8A38: A6 C8 1F       LDA    $1F,U
8A3B: A7 88 1F       STA    $1F,X
8A3E: 39             RTS

8A3F: 0D 22          TST    $22
8A41: 26 08          BNE    $8A4B
8A43: 86 01          LDA    #$01
8A45: 97 AA          STA    $AA
8A47: B7 2A 0A       STA    $2A0A
8A4A: 39             RTS

8A4B: 8D 40          BSR    $8A8D
8A4D: 0F AA          CLR    $AA
8A4F: 7F 2A 0A       CLR    $2A0A
8A52: EC 84          LDD    ,X
8A54: ED C4          STD    ,U
8A56: A6 88 1F       LDA    $1F,X
8A59: A7 C8 1F       STA    $1F,U
8A5C: 96 84          LDA    current_level_84
8A5E: 81 00          CMPA   #$00
8A60: 27 04          BEQ    $8A66
8A62: 81 03          CMPA   #$03
8A64: 26 21          BNE    $8A87
8A66: 96 DF          LDA    $DF
8A68: 84 01          ANDA   #$01
8A6A: 26 18          BNE    $8A84
8A6C: A6 88 20       LDA    $20,X
8A6F: 26 03          BNE    $8A74
8A71: 7C 2A 0A       INC    $2A0A
8A74: 96 DF          LDA    $DF
8A76: 4C             INCA
8A77: CE 28 EC       LDU    #$28EC
8A7A: A6 C6          LDA    A,U
8A7C: 27 05          BEQ    $8A83
8A7E: 86 01          LDA    #$01
8A80: B7 2A 0A       STA    $2A0A
8A83: 39             RTS

8A84: 0C AA          INC    $AA
8A86: 39             RTS

8A87: 86 01          LDA    #$01
8A89: B7 2A 0A       STA    $2A0A
8A8C: 39             RTS

8A8D: CE 28 80       LDU    #$2880
8A90: 8E 2B 80       LDX    #$2B80
8A93: 96 DF          LDA    $DF
8A95: C6 20          LDB    #$20
8A97: 3D             MUL
8A98: 30 8B          LEAX   D,X
8A9A: 39             RTS

8A9B: 96 22          LDA    $22
8A9D: 27 66          BEQ    $8B05
8A9F: 10 8E A9 E8    LDY    #$A9E8
8AA3: 96 3F          LDA    $3F
8AA5: 84 1F          ANDA   #$1F
8AA7: 31 A6          LEAY   A,Y
8AA9: 8E 28 31       LDX    #$2831
8AAC: 96 21          LDA    copy_of_screen_flipped_21
8AAE: 27 02          BEQ    $8AB2
8AB0: 30 01          LEAX   $1,X
8AB2: 96 AA          LDA    $AA
8AB4: 26 0E          BNE    $8AC4
8AB6: A6 06          LDA    $6,X
8AB8: 97 3B          STA    $3B
8ABA: A6 03          LDA    $3,X
8ABC: 97 3A          STA    $3A
8ABE: A6 84          LDA    ,X
8AC0: 97 39          STA    $39
8AC2: 20 0C          BRA    $8AD0
8AC4: A6 A4          LDA    ,Y
8AC6: 97 3B          STA    $3B
8AC8: A6 21          LDA    $1,Y
8ACA: 97 3A          STA    $3A
8ACC: A6 22          LDA    $2,Y
8ACE: 97 39          STA    $39
8AD0: 96 84          LDA    current_level_84
8AD2: 81 00          CMPA   #$00
8AD4: 27 04          BEQ    $8ADA
8AD6: 81 03          CMPA   #$03
8AD8: 26 05          BNE    $8ADF
8ADA: B6 2A 0A       LDA    $2A0A
8ADD: 26 19          BNE    $8AF8
8ADF: A6 06          LDA    $6,X
8AE1: 44             LSRA
8AE2: 44             LSRA
8AE3: 44             LSRA
8AE4: 44             LSRA
8AE5: 97 3E          STA    $3E
8AE7: A6 03          LDA    $3,X
8AE9: 44             LSRA
8AEA: 44             LSRA
8AEB: 44             LSRA
8AEC: 44             LSRA
8AED: 97 3D          STA    $3D
8AEF: A6 84          LDA    ,X
8AF1: 44             LSRA
8AF2: 44             LSRA
8AF3: 44             LSRA
8AF4: 44             LSRA
8AF5: 97 3C          STA    $3C
8AF7: 39             RTS

8AF8: A6 A4          LDA    ,Y
8AFA: 97 3E          STA    $3E
8AFC: A6 21          LDA    $1,Y
8AFE: 97 3D          STA    $3D
8B00: A6 22          LDA    $2,Y
8B02: 97 3C          STA    $3C
8B04: 39             RTS

8B05: 10 8E A9 E8    LDY    #$A9E8
8B09: 96 3F          LDA    $3F
8B0B: 84 1F          ANDA   #$1F
8B0D: 31 A6          LEAY   A,Y
8B0F: A6 A8 11       LDA    $11,Y
8B12: 97 3E          STA    $3E
8B14: A6 A8 12       LDA    $12,Y
8B17: 97 3D          STA    $3D
8B19: A6 A8 13       LDA    $13,Y
8B1C: 97 3C          STA    $3C
8B1E: B6 2A 9A       LDA    $2A9A
8B21: 27 0A          BEQ    $8B2D
8B23: 10 8E AA 17    LDY    #$AA17
8B27: 96 3F          LDA    $3F
8B29: 84 1F          ANDA   #$1F
8B2B: 31 A6          LEAY   A,Y
8B2D: A6 A4          LDA    ,Y
8B2F: 97 3B          STA    $3B
8B31: A6 21          LDA    $1,Y
8B33: 97 3A          STA    $3A
8B35: A6 22          LDA    $2,Y
8B37: 97 39          STA    $39
8B39: 39             RTS

8B3A: 10 8E A9 BD    LDY    #$A9BD
8B3E: 96 84          LDA    current_level_84
8B40: 48             ASLA
8B41: 10 AE A6       LDY    A,Y
8B44: CE 34 40       LDU    #$3440
8B47: E6 A0          LDB    ,Y+
8B49: D8 73          EORB   $73
8B4B: E7 C9 08 00    STB    $0800,U			; [video_address]
8B4F: A6 A0          LDA    ,Y+
8B51: 81 FF          CMPA   #$FF
8B53: 26 05          BNE    $8B5A
8B55: 10 AE A4       LDY    ,Y
8B58: 20 F1          BRA    $8B4B
8B5A: A7 C4          STA    ,U				; [video_address]
8B5C: 33 C8 C0       LEAU   -$40,U
8B5F: E7 C9 08 00    STB    $0800,U			; [video_address]
8B63: A6 A0          LDA    ,Y+
8B65: A7 C4          STA    ,U				; [video_address]
8B67: 33 C8 41       LEAU   $41,U
8B6A: 11 83 34 80    CMPU   #$3480
8B6E: 26 DB          BNE    $8B4B
8B70: 39             RTS

8B71: 10 8E AD 79    LDY    #$AD79
8B75: CE 33 C0       LDU    #$33C0
8B78: E6 A0          LDB    ,Y+
8B7A: D8 73          EORB   $73
8B7C: 86 03          LDA    #$03
8B7E: 97 48          STA    nb_objects_48
8B80: E7 C9 08 00    STB    $0800,U			; [video_address]
8B84: A6 A0          LDA    ,Y+
8B86: 81 FF          CMPA   #$FF
8B88: 26 05          BNE    $8B8F
8B8A: 10 AE A4       LDY    ,Y
8B8D: 20 F1          BRA    $8B80
8B8F: A7 C4          STA    ,U				; [video_address]
8B91: 33 C8 C0       LEAU   -$40,U
8B94: 0A 48          DEC    nb_objects_48
8B96: 26 E8          BNE    $8B80
8B98: 33 C9 00 C1    LEAU   $00C1,U
8B9C: 11 83 34 00    CMPU   #$3400
8BA0: 26 DA          BNE    $8B7C
8BA2: 39             RTS

8BA3: CE 33 49       LDU    #$3349
8BA6: CC 54 40       LDD    #$5440
8BA9: E7 C9 08 00    STB    $0800,U			; [video_address]
8BAD: A7 C0          STA    ,U+			; [video_address]
8BAF: 86 0C          LDA    #$0C
8BB1: 97 48          STA    nb_objects_48
8BB3: CC 55 40       LDD    #$5540
8BB6: E7 C9 08 00    STB    $0800,U			; [video_address]
8BBA: A7 C0          STA    ,U+			; [video_address]
8BBC: 0A 48          DEC    nb_objects_48
8BBE: 26 F6          BNE    $8BB6
8BC0: CC 54 50       LDD    #$5450
8BC3: E7 C9 08 00    STB    $0800,U			; [video_address]
8BC7: A7 C0          STA    ,U+			; [video_address]
8BC9: 33 C8 32       LEAU   $32,U
8BCC: 86 03          LDA    #$03
8BCE: 97 49          STA    $49
8BD0: CC 56 40       LDD    #$5640
8BD3: E7 C9 08 00    STB    $0800,U			; [video_address]
8BD7: A7 C0          STA    ,U+			; [video_address]
8BD9: 86 0C          LDA    #$0C
8BDB: 97 48          STA    nb_objects_48
8BDD: 86 10          LDA    #$10
8BDF: 6F C9 08 00    CLR    $0800,U			; [video_address]
8BE3: A7 C0          STA    ,U+			; [video_address]
8BE5: 0A 48          DEC    nb_objects_48
8BE7: 26 F6          BNE    $8BDF
8BE9: CC 56 50       LDD    #$5650
8BEC: E7 C9 08 00    STB    $0800,U			; [video_address]
8BF0: A7 C0          STA    ,U+			; [video_address]
8BF2: 33 C8 32       LEAU   $32,U
8BF5: 0A 49          DEC    $49
8BF7: 26 D7          BNE    $8BD0
8BF9: CC 54 60       LDD    #$5460
8BFC: E7 C9 08 00    STB    $0800,U			; [video_address]
8C00: A7 C0          STA    ,U+			; [video_address]
8C02: 86 0C          LDA    #$0C
8C04: 97 48          STA    nb_objects_48
8C06: CC 55 60       LDD    #$5560
8C09: E7 C9 08 00    STB    $0800,U			; [video_address]
8C0D: A7 C0          STA    ,U+			; [video_address]
8C0F: 0A 48          DEC    nb_objects_48
8C11: 26 F6          BNE    $8C09
8C13: CC 54 70       LDD    #$5470
8C16: E7 C9 08 00    STB    $0800,U			; [video_address]
8C1A: A7 C0          STA    ,U+			; [video_address]
8C1C: 39             RTS

clear_sprites_8c1d:
8C1D: 4F             CLRA
8C1E: 5F             CLRB
8C1F: CE 18 00       LDU    #sprite_ram_1800
8C22: ED C9 04 00    STD    $0400,U
8C26: ED C1          STD    ,U++
8C28: 11 83 18 30    CMPU   #sprite_ram_1800+$30
8C2C: 26 F4          BNE    $8C22
8C2E: 39             RTS

reset_scrolling_8c2f:
8C2F: 8E 18 40       LDX    #scroll_registers_1840
8C32: 6F 89 04 00    CLR    $0400,X		;  [scroll_address]
8C36: 6F 80          CLR    ,X+			;  [scroll_address]
8C38: 8C 18 60       CMPX   #scroll_registers_1840+$20
8C3B: 26 F5          BNE    $8C32
8C3D: 39             RTS

partially_reset_scrolling_8c3e:
8C3E: 8E 18 4D       LDX    #scroll_registers_1840+$D
8C41: 6F 89 04 00    CLR    $0400,X	;  [scroll_address]
8C45: 6F 80          CLR    ,X+		;  [scroll_address]
8C47: 8C 18 52       CMPX   #$1852
8C4A: 26 F5          BNE    $8C41
8C4C: 39             RTS

8C4D: 8E 2A A0       LDX    #$2AA0
8C50: 4F             CLRA
8C51: 5F             CLRB
8C52: ED 81          STD    ,X++
8C54: 8C 2A B0       CMPX   #$2AB0
8C57: 26 F9          BNE    $8C52
8C59: 96 84          LDA    current_level_84
8C5B: 97 F5          STA    current_level_backup_f5
8C5D: 86 FF          LDA    #$FF
8C5F: 97 84          STA    current_level_84
8C61: 96 E6          LDA    $E6
8C63: 97 50          STA    $50
8C65: 86 1D          LDA    #$1D
8C67: 97 E6          STA    $E6
8C69: 86 01          LDA    #$01
8C6B: 97 48          STA    nb_objects_48
8C6D: 8E 2A 80       LDX    #$2A80
8C70: 10 8E 2A A0    LDY    #$2AA0
8C74: A7 A4          STA    ,Y
8C76: EC 84          LDD    ,X
8C78: ED 21          STD    $1,Y
8C7A: A6 02          LDA    $2,X
8C7C: A7 23          STA    $3,Y
8C7E: 96 60          LDA    nb_players_minus_one_60
8C80: 97 4D          STA    $4D
8C82: 27 4A          BEQ    $8CCE
8C84: 96 48          LDA    nb_objects_48
8C86: 97 49          STA    $49
8C88: 0F 4A          CLR    $4A
8C8A: 10 8E 2A A1    LDY    #$2AA1
8C8E: 30 03          LEAX   $3,X
8C90: BD 89 68       JSR    compare_performances_8968
8C93: 5D             TSTB
8C94: 26 0E          BNE    $8CA4
8C96: 0C 4A          INC    $4A
8C98: 31 24          LEAY   $4,Y
8C9A: 0A 49          DEC    $49
8C9C: 26 F2          BNE    $8C90
8C9E: 31 3F          LEAY   -$1,Y
8CA0: 1F 23          TFR    Y,U
8CA2: 20 17          BRA    $8CBB
8CA4: 86 03          LDA    #$03
8CA6: 90 4A          SUBA   $4A
8CA8: 97 4C          STA    $4C
8CAA: CE 2A AC       LDU    #$2AAC
8CAD: 33 5C          LEAU   -$4,U
8CAF: EC C4          LDD    ,U
8CB1: ED 44          STD    $4,U
8CB3: EC 42          LDD    $2,U
8CB5: ED 46          STD    $6,U
8CB7: 0A 4C          DEC    $4C
8CB9: 26 F2          BNE    $8CAD
8CBB: 96 48          LDA    nb_objects_48
8CBD: 4C             INCA
8CBE: A7 C4          STA    ,U
8CC0: A6 84          LDA    ,X
8CC2: A7 41          STA    $1,U
8CC4: EC 01          LDD    $1,X
8CC6: ED 42          STD    $2,U
8CC8: 0C 48          INC    nb_objects_48
8CCA: 0A 4D          DEC    $4D
8CCC: 26 B6          BNE    $8C84
8CCE: 96 F5          LDA    current_level_backup_f5
8CD0: 97 84          STA    current_level_84
8CD2: 96 50          LDA    $50
8CD4: 97 E6          STA    $E6
8CD6: 39             RTS

8CD7: 96 AA          LDA    $AA
8CD9: 26 05          BNE    $8CE0
8CDB: B6 2A 0A       LDA    $2A0A
8CDE: 27 53          BEQ    $8D33
8CE0: DC C4          LDD    $C4
8CE2: 10 83 00 28    CMPD   #$0028
8CE6: 25 4B          BCS    $8D33
8CE8: 96 AA          LDA    $AA
8CEA: 27 0A          BEQ    $8CF6
8CEC: 10 8E 28 B0    LDY    #$28B0
8CF0: 96 C3          LDA    $C3
8CF2: 27 40          BEQ    $8D34
8CF4: 20 0D          BRA    $8D03
8CF6: B6 2A 0A       LDA    $2A0A
8CF9: 27 38          BEQ    $8D33
8CFB: 10 8E 2A 10    LDY    #$2A10
8CFF: 96 C3          LDA    $C3
8D01: 26 31          BNE    $8D34
8D03: 96 3F          LDA    $3F
8D05: 84 03          ANDA   #$03
8D07: 26 2A          BNE    $8D33
8D09: 6C 22          INC    $2,Y
8D0B: A6 22          LDA    $2,Y
8D0D: 81 0A          CMPA   #$0A
8D0F: 26 0E          BNE    $8D1F
8D11: 6F 22          CLR    $2,Y
8D13: 6C 21          INC    $1,Y
8D15: A6 21          LDA    $1,Y
8D17: 81 0A          CMPA   #$0A
8D19: 26 04          BNE    $8D1F
8D1B: 6F 21          CLR    $1,Y
8D1D: 6C A4          INC    ,Y
8D1F: A6 A4          LDA    ,Y
8D21: C6 0A          LDB    #$0A
8D23: 3D             MUL
8D24: EB 21          ADDB   $1,Y
8D26: C1 0D          CMPB   #$0D
8D28: 25 09          BCS    $8D33
8D2A: CC 01 03       LDD    #$0103
8D2D: ED A4          STD    ,Y
8D2F: 4F             CLRA
8D30: 5F             CLRB
8D31: ED 22          STD    $2,Y
8D33: 39             RTS

8D34: 96 3F          LDA    $3F
8D36: 84 01          ANDA   #$01
8D38: 26 28          BNE    $8D62
8D3A: C6 09          LDB    #$09
8D3C: 6A 22          DEC    $2,Y
8D3E: A6 22          LDA    $2,Y
8D40: 81 FF          CMPA   #$FF
8D42: 26 1E          BNE    $8D62
8D44: E7 22          STB    $2,Y
8D46: 6A 21          DEC    $1,Y
8D48: A6 21          LDA    $1,Y
8D4A: 81 06          CMPA   #$06
8D4C: 27 15          BEQ    $8D63
8D4E: 81 FF          CMPA   #$FF
8D50: 26 10          BNE    $8D62
8D52: E7 21          STB    $1,Y
8D54: 6A A4          DEC    ,Y
8D56: A6 A4          LDA    ,Y
8D58: 81 FF          CMPA   #$FF
8D5A: 26 06          BNE    $8D62
8D5C: 4F             CLRA
8D5D: 5F             CLRB
8D5E: ED A4          STD    ,Y
8D60: ED 22          STD    $2,Y
8D62: 39             RTS

8D63: 6D A4          TST    ,Y
8D65: 26 08          BNE    $8D6F
8D67: CC 00 07       LDD    #$0007
8D6A: ED A4          STD    ,Y
8D6C: 5F             CLRB
8D6D: ED 22          STD    $2,Y
8D6F: 39             RTS

8D70: 5F             CLRB
8D71: A6 0A          LDA    $A,X
8D73: 27 17          BEQ    $8D8C
8D75: 96 DF          LDA    $DF
8D77: 84 01          ANDA   #$01
8D79: 26 05          BNE    $8D80
8D7B: BD 85 87       JSR    $8587
8D7E: 20 03          BRA    $8D83
8D80: BD 85 DE       JSR    $85DE
8D83: 5F             CLRB
8D84: A6 98 03       LDA    [$03,X]	; [video_address]
8D87: 81 32          CMPA   #$32
8D89: 26 01          BNE    $8D8C
8D8B: 5C             INCB
8D8C: 39             RTS

8D8D: CE 3E C4       LDU    #$3EC4
8D90: 20 03          BRA    $8D95
8D92: CE 3D 44       LDU    #$3D44
8D95: 86 0C          LDA    #$0C
8D97: D6 3F          LDB    $3F
8D99: C4 08          ANDB   #$08
8D9B: 27 02          BEQ    $8D9F
8D9D: 86 0B          LDA    #$0B
8D9F: C6 03          LDB    #$03
8DA1: A7 C0          STA    ,U+			; [video_address]
8DA3: 5A             DECB
8DA4: 26 FB          BNE    $8DA1
8DA6: 33 41          LEAU   $1,U
8DA8: C6 03          LDB    #$03
8DAA: A7 C0          STA    ,U+			; [video_address]
8DAC: 5A             DECB
8DAD: 26 FB          BNE    $8DAA
8DAF: 39             RTS

8DB0: CE 3B 8A       LDU    #$3B8A
8DB3: 86 09          LDA    #$09
8DB5: 97 49          STA    $49
8DB7: 86 01          LDA    #$01
8DB9: D6 3F          LDB    $3F
8DBB: C4 10          ANDB   #$10
8DBD: 27 02          BEQ    $8DC1
8DBF: 86 00          LDA    #$00
8DC1: A7 C0          STA    ,U+		; [video_address]
8DC3: 0A 49          DEC    $49
8DC5: 26 FA          BNE    $8DC1
8DC7: 10 8E A4 C8    LDY    #$A4C8
8DCB: 96 DF          LDA    $DF
8DCD: A6 A6          LDA    A,Y
8DCF: D6 3F          LDB    $3F
8DD1: C4 10          ANDB   #$10
8DD3: 27 02          BEQ    $8DD7
8DD5: 86 00          LDA    #$00
8DD7: A7 C0          STA    ,U+				; [video_address]
8DD9: A7 C0          STA    ,U+				; [video_address]
8DDB: A7 C0          STA    ,U+				; [video_address]
8DDD: CE 3B CA       LDU    #$3BCA
8DE0: 86 02          LDA    #$02
8DE2: 97 48          STA    nb_objects_48
8DE4: 86 0C          LDA    #$0C
8DE6: 97 49          STA    $49
8DE8: 86 01          LDA    #$01
8DEA: D6 3F          LDB    $3F
8DEC: C4 10          ANDB   #$10
8DEE: 27 02          BEQ    $8DF2
8DF0: 86 00          LDA    #$00
8DF2: A7 C0          STA    ,U+		; [video_address]
8DF4: 0A 49          DEC    $49
8DF6: 26 FA          BNE    $8DF2
8DF8: 33 C8 34       LEAU   $34,U
8DFB: 0A 48          DEC    nb_objects_48
8DFD: 26 E5          BNE    $8DE4
8DFF: 39             RTS

8E00: 5F             CLRB
8E01: 7C 2A 98       INC    $2A98
8E04: CE A9 DC       LDU    #$A9DC
8E07: 96 84          LDA    current_level_84
8E09: A6 C6          LDA    A,U
8E0B: B1 2A 98       CMPA   $2A98
8E0E: 26 0F          BNE    $8E1F
8E10: 7C 2A 99       INC    $2A99
8E13: 7F 2A 98       CLR    $2A98
8E16: B6 2A 99       LDA    $2A99
8E19: 81 02          CMPA   #$02
8E1B: 26 02          BNE    $8E1F
8E1D: C6 01          LDB    #$01
8E1F: 39             RTS

8E20: CE 32 52       LDU    #$3252
8E23: 86 03          LDA    #$03
8E25: 97 48          STA    nb_objects_48
8E27: 86 10          LDA    #$10
8E29: C6 04          LDB    #$04
8E2B: 6F C9 08 00    CLR    $0800,U			; [video_address]
8E2F: A7 C0          STA    ,U+			    ; [video_address]
8E31: 5A             DECB
8E32: 26 F7          BNE    $8E2B
8E34: 33 C8 3C       LEAU   $3C,U
8E37: 0A 48          DEC    nb_objects_48
8E39: 26 EE          BNE    $8E29
8E3B: 8E AF 80       LDX    #$AF80
8E3E: CE 32 56       LDU    #$3256
8E41: 86 04          LDA    #$04
8E43: 97 48          STA    nb_objects_48
8E45: C6 40          LDB    #$40
8E47: 86 07          LDA    #$07
8E49: 97 49          STA    $49
8E4B: A6 80          LDA    ,X+
8E4D: E7 C9 08 00    STB    $0800,U			; [video_address]
8E51: A7 C0          STA    ,U+			    ; [video_address]
8E53: 0A 49          DEC    $49
8E55: 26 F4          BNE    $8E4B
8E57: 33 C8 39       LEAU   $39,U
8E5A: 0A 48          DEC    nb_objects_48
8E5C: 26 E9          BNE    $8E47
8E5E: 39             RTS

8E5F: CE 32 1E       LDU    #$321E
8E62: 96 3F          LDA    $3F
8E64: 84 10          ANDA   #$10
8E66: 27 05          BEQ    $8E6D
8E68: CC 10 00       LDD    #$1000
8E6B: 20 03          BRA    $8E70

8E6D: CC 6A 40       LDD    #$6A40
8E70: E7 C9 08 00    STB    $0800,U		; [video_address]
8E74: A7 C4          STA    ,U			; [video_address]
8E76: 39             RTS

8E77: 7F 2A BA       CLR    $2ABA
8E7A: 7F 2A BB       CLR    $2ABB
8E7D: 7F 2A BC       CLR    $2ABC
8E80: CE 29 60       LDU    #player_1_final_time_2960
8E83: 96 DF          LDA    $DF
8E85: C6 0C          LDB    #$0C
8E87: 3D             MUL
8E88: 33 CB          LEAU   D,U
8E8A: 96 9F          LDA    high_jump_fault_9f
8E8C: 27 2D          BEQ    $8EBB
8E8E: 4A             DECA
8E8F: 48             ASLA
8E90: 48             ASLA
8E91: 33 C6          LEAU   A,U
8E93: A6 C4          LDA    ,U
8E95: 81 16          CMPA   #$16
8E97: 27 22          BEQ    $8EBB
8E99: EC C4          LDD    ,U
8E9B: FD 2A BB       STD    $2ABB
8E9E: CE A9 E2       LDU    #$A9E2
8EA1: 96 84          LDA    current_level_84
8EA3: A6 C6          LDA    A,U
8EA5: 97 48          STA    nb_objects_48
8EA7: B6 2A BB       LDA    $2ABB
8EAA: C6 0A          LDB    #$0A
8EAC: 3D             MUL
8EAD: FB 2A BC       ADDB   $2ABC
8EB0: 4F             CLRA
8EB1: D0 48          SUBB   nb_objects_48
8EB3: 25 03          BCS    $8EB8
8EB5: 4C             INCA
8EB6: 20 F9          BRA    $8EB1
8EB8: B7 2A BA       STA    $2ABA
8EBB: 39             RTS

8EBC: CE 32 03       LDU    #$3203
8EBF: C6 04          LDB    #$04
8EC1: 86 10          LDA    #$10
8EC3: A7 C4          STA    ,U		; [video_address]
8EC5: 33 C8 40       LEAU   $40,U
8EC8: 5A             DECB
8EC9: 26 F8          BNE    $8EC3
8ECB: 39             RTS

8ECC: 96 22          LDA    $22
8ECE: 27 1F          BEQ    $8EEF
8ED0: CE 32 03       LDU    #$3203
8ED3: B6 2A BD       LDA    $2ABD
8ED6: C6 40          LDB    #$40
8ED8: 3D             MUL
8ED9: 33 CB          LEAU   D,U
8EDB: 96 3F          LDA    $3F
8EDD: 84 10          ANDA   #$10
8EDF: 27 05          BEQ    $8EE6
8EE1: CC 6A 53       LDD    #$6A53
8EE4: 20 03          BRA    $8EE9
8EE6: CC 10 00       LDD    #$1000
8EE9: E7 C9 08 00    STB    $0800,U		; [video_address]
8EED: A7 C4          STA    ,U			; [video_address]
8EEF: 39             RTS

8EF0: 96 22          LDA    $22
8EF2: 27 29          BEQ    $8F1D
8EF4: 96 84          LDA    current_level_84
8EF6: 81 00          CMPA   #$00
8EF8: 27 04          BEQ    $8EFE
8EFA: 81 03          CMPA   #$03
8EFC: 26 1F          BNE    $8F1D
8EFE: CE 32 03       LDU    #$3203
8F01: B6 2A BE       LDA    $2ABE
8F04: C6 40          LDB    #$40
8F06: 3D             MUL
8F07: 33 CB          LEAU   D,U
8F09: 96 3F          LDA    $3F
8F0B: 84 10          ANDA   #$10
8F0D: 27 05          BEQ    $8F14
8F0F: CC 6A 50       LDD    #$6A50
8F12: 20 03          BRA    $8F17
8F14: CC 10 00       LDD    #$1000
8F17: E7 C9 08 00    STB    $0800,U		; [video_address]
8F1B: A7 C4          STA    ,U          ; [video_address]
8F1D: 39             RTS

8F1E: 96 22          LDA    $22
8F20: 27 28          BEQ    $8F4A
8F22: 8E 2B 60       LDX    #$2B60
8F25: 7F 2A BD       CLR    $2ABD
8F28: 96 DF          LDA    $DF
8F2A: 4C             INCA
8F2B: E6 84          LDB    ,X
8F2D: C4 0F          ANDB   #$0F
8F2F: D7 50          STB    $50
8F31: 91 50          CMPA   $50
8F33: 27 0B          BEQ    $8F40
8F35: 6D 84          TST    ,X
8F37: 27 12          BEQ    $8F4B
8F39: 7C 2A BD       INC    $2ABD
8F3C: 30 05          LEAX   $5,X
8F3E: 20 EB          BRA    $8F2B
8F40: A6 84          LDA    ,X
8F42: 84 20          ANDA   #$20
8F44: 27 04          BEQ    $8F4A
8F46: 8D 88          BSR    $8ED0
8F48: 20 41          BRA    $8F8B
8F4A: 39             RTS

8F4B: BD 8E D0       JSR    $8ED0
8F4E: 96 AA          LDA    $AA
8F50: 26 39          BNE    $8F8B
8F52: 33 41          LEAU   $1,U
8F54: 96 DF          LDA    $DF
8F56: 10 8E A4 C8    LDY    #$A4C8
8F5A: E6 A6          LDB    A,Y
8F5C: 4C             INCA
8F5D: E7 C9 08 00    STB    $0800,U		; [video_address]
8F61: A7 C0          STA    ,U+         ; [video_address]
8F63: 86 20          LDA    #$20
8F65: E7 C9 08 00    STB    $0800,U		; [video_address]
8F69: A7 C1          STA    ,U++        ; [video_address]
8F6B: 34 04          PSHS   B
8F6D: 10 8E 29 90    LDY    #$2990
8F71: 96 DF          LDA    $DF
8F73: C6 03          LDB    #$03
8F75: 3D             MUL
8F76: 31 AB          LEAY   D,Y
8F78: 86 03          LDA    #$03
8F7A: 97 48          STA    nb_objects_48
8F7C: 35 04          PULS   B
8F7E: A6 A0          LDA    ,Y+
8F80: E7 C9 08 00    STB    $0800,U   ; [video_address]
8F84: A7 C0          STA    ,U+       ; [video_address]
8F86: 0A 48          DEC    nb_objects_48
8F88: 26 F4          BNE    $8F7E
8F8A: 39             RTS

8F8B: 33 41          LEAU   $1,U
8F8D: 96 DF          LDA    $DF
8F8F: 4C             INCA
8F90: 5F             CLRB
8F91: E7 C9 08 00    STB    $0800,U   ; [video_address]
8F95: A7 C0          STA    ,U+       ; [video_address]
8F97: 86 20          LDA    #$20
8F99: E7 C9 08 00    STB    $0800,U   ; [video_address]
8F9D: A7 C1          STA    ,U++      ; [video_address]
8F9F: 86 13          LDA    #$13
8FA1: E7 C9 08 00    STB    $0800,U   ; [video_address]
8FA5: A7 C0          STA    ,U+       ; [video_address]
8FA7: 86 20          LDA    #$20
8FA9: E7 C9 08 00    STB    $0800,U   ; [video_address]
8FAD: A7 C0          STA    ,U+       ; [video_address]
8FAF: 86 25          LDA    #$25
8FB1: E7 C9 08 00    STB    $0800,U   ; [video_address]
8FB5: A7 C0          STA    ,U+       ; [video_address]
8FB7: 39             RTS

8FB8: 96 22          LDA    $22
8FBA: 27 1E          BEQ    $8FDA
8FBC: 8E 2B 60       LDX    #$2B60
8FBF: 7F 2A BE       CLR    $2ABE
8FC2: 96 DF          LDA    $DF
8FC4: 4C             INCA
8FC5: E6 84          LDB    ,X
8FC7: C4 0F          ANDB   #$0F
8FC9: D7 50          STB    $50
8FCB: 91 50          CMPA   $50
8FCD: 27 0B          BEQ    $8FDA
8FCF: 6D 84          TST    ,X
8FD1: 27 08          BEQ    $8FDB
8FD3: 7C 2A BE       INC    $2ABE
8FD6: 30 05          LEAX   $5,X
8FD8: 20 EB          BRA    $8FC5
8FDA: 39             RTS

8FDB: 96 EC          LDA    $EC
8FDD: D6 DF          LDB    $DF
8FDF: C4 02          ANDB   #$02
8FE1: 27 02          BEQ    $8FE5
8FE3: 96 EE          LDA    $EE
8FE5: 4D             TSTA
8FE6: 26 03          BNE    $8FEB
8FE8: 7C 2A BE       INC    $2ABE
8FEB: BD 8E FE       JSR    $8EFE
8FEE: B6 2A 0A       LDA    $2A0A
8FF1: 26 98          BNE    $8F8B
8FF3: 7E 8F 52       JMP    $8F52
8FF6: CE 32 03       LDU    #$3203
8FF9: 86 04          LDA    #$04
8FFB: 97 48          STA    nb_objects_48
8FFD: 86 10          LDA    #$10
8FFF: C6 07          LDB    #$07
9001: 6F C9 08 00    CLR    $0800,U   ; [video_address]
9005: A7 C0          STA    ,U+       ; [video_address]
9007: 5A             DECB
9008: 26 F7          BNE    $9001
900A: 33 C8 39       LEAU   $39,U
900D: 0A 48          DEC    nb_objects_48
900F: 26 EE          BNE    $8FFF
9011: 39             RTS

9012: CE 36 D1       LDU    #$36D1
9015: 96 DF          LDA    $DF
9017: 84 01          ANDA   #$01
9019: 27 03          BEQ    $901E
901B: CE 35 51       LDU    #$3551
901E: C6 0C          LDB    #$0C
9020: 96 3F          LDA    $3F
9022: 84 10          ANDA   #$10
9024: 27 02          BEQ    $9028
9026: C6 0B          LDB    #$0B
9028: 86 0E          LDA    #$0E
902A: 97 48          STA    nb_objects_48
902C: 10 8E A9 CE    LDY    #$A9CE
9030: 20 15          BRA    $9047
9032: CE 36 56       LDU    #$3656
9035: C6 0C          LDB    #$0C
9037: 96 3F          LDA    $3F
9039: 84 10          ANDA   #$10
903B: 27 02          BEQ    $903F
903D: C6 0B          LDB    #$0B
903F: 86 05          LDA    #$05
9041: 97 48          STA    nb_objects_48
9043: 10 8E A9 C9    LDY    #$A9C9
9047: A6 A0          LDA    ,Y+
9049: E7 C9 08 00    STB    $0800,U   ; [video_address]
904D: 80 30          SUBA   #$30      
904F: A7 C0          STA    ,U+       ; [video_address]
9051: 0A 48          DEC    nb_objects_48
9053: 26 F2          BNE    $9047
9055: 39             RTS

9056: CE 36 D1       LDU    #$36D1
9059: 96 DF          LDA    $DF
905B: 84 01          ANDA   #$01
905D: 27 03          BEQ    $9062
905F: CE 35 51       LDU    #$3551
9062: C6 0E          LDB    #$0E
9064: 20 02          BRA    $9068
9066: C6 05          LDB    #$05
9068: 86 4E          LDA    #$4E
906A: 6F C9 08 00    CLR    $0800,U    ; [video_address]
906E: A7 C0          STA    ,U+        ; [video_address]
9070: 5A             DECB
9071: 26 F7          BNE    $906A
9073: 39             RTS

9074: 96 22          LDA    $22
9076: 27 47          BEQ    $90BF
9078: CE 32 0B       LDU    #$320B
907B: B6 2A BD       LDA    $2ABD
907E: D6 DF          LDB    $DF
9080: C4 01          ANDB   #$01
9082: 27 03          BEQ    $9087
9084: B6 2A BE       LDA    $2ABE
9087: C6 40          LDB    #$40
9089: 3D             MUL
908A: 33 CB          LEAU   D,U
908C: 96 D9          LDA    false_start_D9
908E: D6 DF          LDB    $DF
9090: C4 01          ANDB   #$01
9092: 27 03          BEQ    $9097
9094: B6 2A 39       LDA    $2A39
9097: 97 48          STA    nb_objects_48
9099: 97 49          STA    $49
909B: 27 0D          BEQ    $90AA
909D: CC 9D 03       LDD    #$9D03
90A0: E7 C9 08 00    STB    $0800,U    ; [video_address]
90A4: A7 C0          STA    ,U+        ; [video_address]
90A6: 0A 49          DEC    $49
90A8: 26 F6          BNE    $90A0
90AA: 86 03          LDA    #$03
90AC: 90 48          SUBA   nb_objects_48
90AE: 97 49          STA    $49
90B0: 27 0D          BEQ    $90BF
90B2: CC 9D 00       LDD    #$9D00
90B5: E7 C9 08 00    STB    $0800,U     ; [video_address]
90B9: A7 C0          STA    ,U+         ; [video_address]
90BB: 0A 49          DEC    $49
90BD: 26 F6          BNE    $90B5
90BF: 39             RTS

90C0: 96 3F          LDA    $3F
90C2: 84 10          ANDA   #$10
90C4: 27 12          BEQ    $90D8
90C6: CC 01 03       LDD    #$0103
90C9: BD 84 F5       JSR    queue_event_84f5
90CC: CC 02 15       LDD    #$0215
90CF: BD 84 F5       JSR    queue_event_84f5
90D2: CC 02 16       LDD    #$0216
90D5: 7E 84 F5       JMP    queue_event_84f5
90D8: CE 32 4C       LDU    #$324C
90DB: C6 04          LDB    #$04
90DD: BD 8A 15       JSR    $8A15
90E0: CE 32 CC       LDU    #$32CC
90E3: C6 04          LDB    #$04
90E5: 7E 8A 15       JMP    $8A15
90E8: 5F             CLRB
90E9: 96 9F          LDA    high_jump_fault_9f
90EB: 26 19          BNE    $9106
90ED: 8E 2B 80       LDX    #$2B80
90F0: 4F             CLRA
90F1: 6D 84          TST    ,X		; [video_address] (can reach 3000)
90F3: 26 0B          BNE    $9100
90F5: 30 88 20       LEAX   $20,X
90F8: 8C 2C 01       CMPX   #$2C01
90FB: 27 09          BEQ    $9106
90FD: 4C             INCA
90FE: 20 F1          BRA    $90F1
9100: 91 DF          CMPA   $DF
9102: 26 02          BNE    $9106
9104: C6 01          LDB    #$01
9106: 39             RTS

9107: 10 8E 28 B0    LDY    #$28B0
910B: BD 88 61       JSR    $8861
910E: 5D             TSTB
910F: 26 02          BNE    $9113
9111: 8D 0B          BSR    $911E
9113: 39             RTS

9114: 0C B3          INC    $B3
9116: 96 B3          LDA    $B3
9118: 81 0A          CMPA   #$0A
911A: 26 18          BNE    $9134
911C: 0F B3          CLR    $B3
911E: 0C B2          INC    $B2
9120: 96 B2          LDA    $B2
9122: 81 0A          CMPA   #$0A
9124: 26 0E          BNE    $9134
9126: 0F B2          CLR    $B2
9128: 0C B1          INC    $B1
912A: 96 B1          LDA    $B1
912C: 81 0A          CMPA   #$0A
912E: 26 04          BNE    $9134
9130: 0F B1          CLR    $B1
9132: 0C B0          INC    $B0
9134: 39             RTS

9135: 96 CE          LDA    $CE
9137: 26 41          BNE    $917A
9139: A6 0C          LDA    $C,X
913B: AB 88 3A       ADDA   $3A,X
913E: 24 02          BCC    $9142
9140: 6C 0B          INC    $B,X
9142: A7 0C          STA    $C,X
9144: A6 02          LDA    $2,X
9146: AB 88 3A       ADDA   $3A,X
9149: 81 80          CMPA   #$80
914B: 25 10          BCS    $915D
914D: 80 80          SUBA   #$80
914F: A7 88 15       STA    $15,X
9152: 86 01          LDA    #$01
9154: 97 CE          STA    $CE
9156: 86 80          LDA    #$80
9158: A7 02          STA    $2,X
915A: 7E 91 B0       JMP    $91B0
915D: 6F 88 15       CLR    $15,X
9160: A6 88 3A       LDA    $3A,X
9163: 10 27 39 D4    LBEQ   $CB3B
9167: 97 4C          STA    $4C
9169: A6 02          LDA    $2,X
916B: 9B 4C          ADDA   $4C
916D: A7 02          STA    $2,X
916F: 6C 88 15       INC    $15,X
9172: BD CB 3B       JSR    $CB3B
9175: 0A 4C          DEC    $4C
9177: 26 F9          BNE    $9172
9179: 39             RTS

917A: A6 02          LDA    $2,X
917C: 91 E2          CMPA   $E2
917E: 27 1D          BEQ    $919D
9180: 96 3F          LDA    $3F
9182: 84 01          ANDA   #$01
9184: 26 17          BNE    $919D
9186: 6A 02          DEC    $2,X
9188: A6 0C          LDA    $C,X
918A: AB 88 3A       ADDA   $3A,X
918D: 24 02          BCC    $9191
918F: 6C 0B          INC    $B,X
9191: A7 0C          STA    $C,X
9193: A6 88 3A       LDA    $3A,X
9196: 4C             INCA
9197: C6 01          LDB    #$01
9199: D7 4B          STB    $4B
919B: 20 10          BRA    $91AD
919D: A6 0C          LDA    $C,X
919F: AB 88 3A       ADDA   $3A,X
91A2: 24 02          BCC    $91A6
91A4: 6C 0B          INC    $B,X
91A6: A7 0C          STA    $C,X
91A8: A6 88 3A       LDA    $3A,X
91AB: 0F 4B          CLR    $4B
91AD: A7 88 15       STA    $15,X
91B0: 96 49          LDA    $49
91B2: 34 72          PSHS   U,Y,X,A
91B4: 96 B5          LDA    $B5
91B6: 26 06          BNE    $91BE
91B8: BD CB 3B       JSR    $CB3B
91BB: 16 00 4A       LBRA   $9208
91BE: 97 49          STA    $49
91C0: 10 8E 2A F0    LDY    #scroll_offsets_2af0
91C4: CE AA 3A       LDU    #$AA3A
91C7: 96 84          LDA    current_level_84
91C9: 48             ASLA
91CA: 33 D6          LEAU   [A,U]
91CC: A6 C0          LDA    ,U+
91CE: 81 FF          CMPA   #$FF
91D0: 27 18          BEQ    $91EA
91D2: 95 94          BITA   $94
91D4: 26 14          BNE    $91EA
91D6: 6C A4          INC    ,Y
91D8: 10 8C 2A F5    CMPY   #$2AF5
91DC: 26 03          BNE    $91E1
91DE: BD 92 6C       JSR    $926C
91E1: 10 8C 2A F4    CMPY   #$2AF4
91E5: 26 03          BNE    $91EA
91E7: BD 92 53       JSR    $9253
91EA: 31 21          LEAY   $1,Y
91EC: 10 8C 2B 00    CMPY   #$2B00
91F0: 26 DA          BNE    $91CC
91F2: 96 84          LDA    current_level_84
91F4: 81 00          CMPA   #$00
91F6: 27 0C          BEQ    $9204
91F8: 81 03          CMPA   #$03
91FA: 27 08          BEQ    $9204
91FC: 0C 94          INC    $94
91FE: BD 96 0C       JSR    $960C
9201: BD 9A 7A       JSR    $9A7A
9204: 0A 49          DEC    $49
9206: 26 B8          BNE    $91C0
9208: 35 72          PULS   A,X,Y,U
920A: 97 49          STA    $49
920C: 39             RTS

920D: 0D 21          TST    copy_of_screen_flipped_21
920F: 27 0C          BEQ    $921D
9211: 6D A4          TST    ,Y
9213: 26 04          BNE    $9219
9215: 6A A9 04 00    DEC    $0400,Y
9219: 6A A4          DEC    ,Y
921B: 20 08          BRA    $9225
921D: 6C A4          INC    ,Y
921F: 26 04          BNE    $9225
9221: 6C A9 04 00    INC    $0400,Y
9225: 39             RTS

9226: 96 84          LDA    current_level_84
9228: 81 02          CMPA   #$02
922A: 27 26          BEQ    $9252
922C: 81 05          CMPA   #$05
922E: 27 22          BEQ    $9252
9230: 8E 29 E0       LDX    #$29E0
9233: A6 A4          LDA    ,Y
9235: A7 84          STA    ,X
9237: EC 21          LDD    $1,Y
9239: ED 01          STD    $1,X
923B: EC 23          LDD    $3,Y
923D: ED 03          STD    $3,X
923F: 34 20          PSHS   Y
9241: BD 92 9D       JSR    $929D
9244: 35 20          PULS   Y
9246: A6 84          LDA    ,X
9248: A7 A4          STA    ,Y
924A: EC 01          LDD    $1,X
924C: ED 21          STD    $1,Y
924E: EC 03          LDD    $3,X
9250: ED 23          STD    $3,Y
9252: 39             RTS

9253: 34 70          PSHS   U,Y,X
9255: 86 F0          LDA    #$F0
9257: B4 2F FF       ANDA   $2FFF
925A: B7 2F FF       STA    $2FFF
925D: 86 07          LDA    #$07
925F: B7 29 E5       STA    $29E5
9262: 10 8E 2F F0    LDY    #$2FF0
9266: BD 92 26       JSR    $9226
9269: 35 70          PULS   X,Y,U
926B: 39             RTS

926C: 34 70          PSHS   U,Y,X
926E: 86 F0          LDA    #$F0
9270: B4 2F FF       ANDA   $2FFF
9273: 8A 02          ORA    #$02
9275: B7 2F FF       STA    $2FFF
9278: 86 10          LDA    #$10
927A: B7 29 E5       STA    $29E5
927D: 10 8E 2F F5    LDY    #$2FF5
9281: BD 92 26       JSR    $9226
9284: 86 F0          LDA    #$F0
9286: B4 2F FF       ANDA   $2FFF
9289: 8A 04          ORA    #$04
928B: B7 2F FF       STA    $2FFF
928E: 86 38          LDA    #$38
9290: B7 29 E5       STA    $29E5
9293: 10 8E 2F FA    LDY    #$2FFA
9297: BD 92 26       JSR    $9226
929A: 35 70          PULS   X,Y,U
929C: 39             RTS

929D: F6 2F FF       LDB    $2FFF
92A0: C4 0F          ANDB   #$0F
92A2: CE 18 2E       LDU    #$182E
92A5: 50             NEGB
92A6: 33 C5          LEAU   B,U
92A8: 10 AE 03       LDY    $3,X
92AB: A6 84          LDA    ,X
92AD: 81 01          CMPA   #$01
92AF: 27 38          BEQ    $92E9
92B1: 81 02          CMPA   #$02
92B3: 27 34          BEQ    $92E9
92B5: 81 03          CMPA   #$03
92B7: 26 0A          BNE    $92C3
92B9: CC F8 F8       LDD    #$F8F8
92BC: ED 01          STD    $1,X
92BE: BD D1 2F       JSR    $D12F
92C1: 20 45          BRA    $9308
92C3: 96 3F          LDA    $3F
92C5: 84 3F          ANDA   #$3F
92C7: A1 05          CMPA   $5,X
92C9: 26 3D          BNE    $9308
92CB: 6C 84          INC    ,X
92CD: B6 2F FF       LDA    $2FFF
92D0: 84 0F          ANDA   #$0F
92D2: 10 8E AA 86    LDY    #$AA86
92D6: 31 A6          LEAY   A,Y
92D8: 34 40          PSHS   U
92DA: CE AA 8C       LDU    #$AA8C
92DD: 33 C6          LEAU   A,U
92DF: EC C4          LDD    ,U
92E1: ED 01          STD    $1,X
92E3: 35 40          PULS   U
92E5: EC A4          LDD    ,Y
92E7: ED 03          STD    $3,X
92E9: 10 AE 03       LDY    $3,X
92EC: A6 84          LDA    ,X
92EE: 4A             DECA
92EF: 31 A6          LEAY   A,Y
92F1: BD D1 2F       JSR    $D12F
92F4: 6A 02          DEC    $2,X
92F6: A6 02          LDA    $2,X
92F8: 91 A2          CMPA   $A2
92FA: 24 05          BCC    $9301
92FC: 86 02          LDA    #$02
92FE: B7 29 E0       STA    $29E0
9301: 6D 02          TST    $2,X
9303: 26 03          BNE    $9308
9305: 7C 29 E0       INC    $29E0
9308: 39             RTS

; aaf3: 4 tables of $C bytes. Easy table:
;   dash:    13 50    long jump  06 50
;   javelin: 70 00    hurdles:   14 00
;   hammer:  75 00    long jump: 02 30

load_and_display_qualifying_value_9309:
9309: 8E AA F3       LDX    #qualifying_values_aaf3
930C: 8D 58          BSR    $9366
930E: 5D             TSTB
930F: 26 09          BNE    $931A
; fetch the proper values according to level & difficulty
9311: 96 2F          LDA    difficulty_2f
9313: C6 0C          LDB    #$0C
9315: 3D             MUL
9316: 30 8B          LEAX   D,X
9318: 20 08          BRA    $9322
931A: 30 88 30       LEAX   $30,X
931D: 5A             DECB
931E: 27 02          BEQ    $9322
9320: 30 0C          LEAX   $C,X
9322: 96 84          LDA    current_level_84
9324: 48             ASLA
9325: 30 86          LEAX   A,X
9327: 10 8E 28 66    LDY    #qualifying_value_2866
932B: CE 32 18       LDU    #$3218
932E: C6 01          LDB    #$01
9330: A6 84          LDA    ,X
9332: 44             LSRA
9333: 44             LSRA
9334: 44             LSRA
9335: 44             LSRA
9336: A7 A4          STA    ,Y
9338: 26 02          BNE    $933C
933A: 86 10          LDA    #$10
933C: BD 61 F0       JSR    write_char_and_move_cursor_61f0
933F: A6 80          LDA    ,X+
9341: 84 0F          ANDA   #$0F
9343: A7 21          STA    $1,Y
9345: BD 61 F0       JSR    write_char_and_move_cursor_61f0
9348: BD 8A 1D       JSR    $8A1D
934B: C6 09          LDB    #$09
934D: BD 61 F0       JSR    write_char_and_move_cursor_61f0
9350: C6 01          LDB    #$01
9352: A6 84          LDA    ,X
9354: 44             LSRA
9355: 44             LSRA
9356: 44             LSRA
9357: 44             LSRA
9358: A7 22          STA    $2,Y
935A: BD 61 F0       JSR    write_char_and_move_cursor_61f0
935D: A6 80          LDA    ,X+
935F: 84 0F          ANDA   #$0F
9361: A7 23          STA    $3,Y
9363: 7E 61 F0       JMP    write_char_and_move_cursor_61f0

9366: 96 82          LDA    $82
9368: 5F             CLRB
9369: 80 06          SUBA   #$06
936B: 25 03          BCS    $9370
936D: 5C             INCB
936E: 20 F9          BRA    $9369
9370: 8B 06          ADDA   #$06
9372: 39             RTS

9373: 86 06          LDA    #$06
9375: A7 88 16       STA    $16,X
9378: 39             RTS

9379: A6 88 1C       LDA    $1C,X
937C: 81 01          CMPA   #$01
937E: 27 1B          BEQ    $939B
9380: 6F 88 15       CLR    $15,X
9383: A6 88 3A       LDA    $3A,X
9386: 10 27 37 B1    LBEQ   $CB3B
938A: 97 4A          STA    $4A
938C: AB 02          ADDA   $2,X
938E: A7 02          STA    $2,X
9390: 6C 88 15       INC    $15,X
9393: BD CB 3B       JSR    $CB3B
9396: 0A 4A          DEC    $4A
9398: 26 F9          BNE    $9393
939A: 39             RTS

939B: 10 AE 88 18    LDY    $18,X
939F: A6 A4          LDA    ,Y
93A1: 81 80          CMPA   #$80
93A3: 10 27 ED 7F    LBEQ   $8126
93A7: 81 90          CMPA   #$90
93A9: 26 02          BNE    $93AD
93AB: 31 21          LEAY   $1,Y
93AD: A6 01          LDA    $1,X
93AF: AB A0          ADDA   ,Y+
93B1: A7 01          STA    $1,X
93B3: 10 AF 88 18    STY    $18,X
93B7: 6C 88 1D       INC    $1D,X
93BA: BD 93 CD       JSR    $93CD
93BD: BD 94 88       JSR    $9488
93C0: BD 94 B8       JSR    $94B8
93C3: A6 88 3A       LDA    $3A,X
93C6: AB 02          ADDA   $2,X
93C8: A7 02          STA    $2,X
93CA: 7E CD 87       JMP    $CD87
93CD: 86 02          LDA    #$02
93CF: 97 48          STA    nb_objects_48
93D1: BD 94 4C       JSR    $944C
93D4: 0A 48          DEC    nb_objects_48
93D6: 26 F9          BNE    $93D1
93D8: 10 8E 28 39    LDY    #$2839
93DC: 96 DF          LDA    $DF
93DE: 84 01          ANDA   #$01
93E0: 27 02          BEQ    $93E4
93E2: 31 23          LEAY   $3,Y
93E4: A6 21          LDA    $1,Y
93E6: 84 05          ANDA   #$05
93E8: 26 61          BNE    $944B
93EA: A6 A4          LDA    ,Y
93EC: 84 05          ANDA   #$05
93EE: 27 5B          BEQ    $944B
93F0: 10 8E AA B2    LDY    #$AAB2
93F4: 96 84          LDA    current_level_84
93F6: 81 00          CMPA   #$00
93F8: 26 04          BNE    $93FE
93FA: 10 8E AA 92    LDY    #$AA92
93FE: A6 88 10       LDA    $10,X
9401: C6 0A          LDB    #$0A
9403: 3D             MUL
9404: EB 88 11       ADDB   $11,X
9407: 58             ASLB
9408: 5C             INCB
9409: A6 A5          LDA    B,Y
940B: AB 88 13       ADDA   $13,X
940E: 19             DAA
940F: 97 49          STA    $49
9411: 84 0F          ANDA   #$0F
9413: A7 88 13       STA    $13,X
9416: 96 49          LDA    $49
9418: 44             LSRA
9419: 44             LSRA
941A: 44             LSRA
941B: 44             LSRA
941C: AB 88 12       ADDA   $12,X
941F: 19             DAA
9420: 97 49          STA    $49
9422: 5A             DECB
9423: A6 A5          LDA    B,Y
9425: 9B 49          ADDA   $49
9427: 19             DAA
9428: 97 49          STA    $49
942A: 84 0F          ANDA   #$0F
942C: A7 88 12       STA    $12,X
942F: 96 49          LDA    $49
9431: 44             LSRA
9432: 44             LSRA
9433: 44             LSRA
9434: 44             LSRA
9435: AB 88 11       ADDA   $11,X
9438: 19             DAA
9439: 97 49          STA    $49
943B: 84 0F          ANDA   #$0F
943D: A7 88 11       STA    $11,X
9440: 96 49          LDA    $49
9442: 44             LSRA
9443: 44             LSRA
9444: 44             LSRA
9445: 44             LSRA
9446: 27 03          BEQ    $944B
9448: 6C 88 10       INC    $10,X
944B: 39             RTS

944C: C6 09          LDB    #$09
944E: 6A 88 13       DEC    $13,X
9451: A6 88 13       LDA    $13,X
9454: 81 FF          CMPA   #$FF
9456: 26 2F          BNE    $9487
9458: E7 88 13       STB    $13,X
945B: 6A 88 12       DEC    $12,X
945E: A6 88 12       LDA    $12,X
9461: 81 FF          CMPA   #$FF
9463: 26 22          BNE    $9487
9465: E7 88 12       STB    $12,X
9468: 6A 88 11       DEC    $11,X
946B: A6 88 11       LDA    $11,X
946E: 81 FF          CMPA   #$FF
9470: 26 15          BNE    $9487
9472: E7 88 11       STB    $11,X
9475: 6A 88 10       DEC    $10,X
9478: A6 88 10       LDA    $10,X
947B: 81 FF          CMPA   #$FF
947D: 26 08          BNE    $9487
947F: 4F             CLRA
9480: 5F             CLRB
9481: ED 88 10       STD    $10,X
9484: ED 88 12       STD    $12,X
9487: 39             RTS

9488: 31 88 10       LEAY   $10,X
948B: CE 28 4C       LDU    #$284C
948E: 86 03          LDA    #$03
9490: 97 48          STA    nb_objects_48
9492: A6 A0          LDA    ,Y+
9494: 5F             CLRB
9495: 80 06          SUBA   #$06
9497: 25 03          BCS    $949C
9499: 5C             INCB
949A: 20 F9          BRA    $9495
949C: 8B 06          ADDA   #$06
949E: E7 C0          STB    ,U+
94A0: C6 0A          LDB    #$0A
94A2: 3D             MUL
94A3: 1F 98          TFR    B,A
94A5: AB A0          ADDA   ,Y+
94A7: 0A 48          DEC    nb_objects_48
94A9: 26 E9          BNE    $9494
94AB: 5F             CLRB
94AC: 80 06          SUBA   #$06
94AE: 25 03          BCS    $94B3
94B0: 5C             INCB
94B1: 20 F9          BRA    $94AC
94B3: 8B 06          ADDA   #$06
94B5: E7 C4          STB    ,U
94B7: 39             RTS

94B8: 6F 88 3A       CLR    $3A,X
94BB: 96 4C          LDA    $4C
94BD: 97 50          STA    $50
94BF: 96 4D          LDA    $4D
94C1: 48             ASLA
94C2: 48             ASLA
94C3: 48             ASLA
94C4: 48             ASLA
94C5: 9A 4E          ORA    $4E
94C7: 97 51          STA    $51
94C9: 96 4F          LDA    $4F
94CB: 48             ASLA
94CC: 48             ASLA
94CD: 48             ASLA
94CE: 48             ASLA
94CF: 97 52          STA    $52
94D1: 96 52          LDA    $52
94D3: AB 88 3D       ADDA   $3D,X
94D6: 19             DAA
94D7: 97 52          STA    $52
94D9: 96 51          LDA    $51
94DB: AB 88 3C       ADDA   $3C,X
94DE: 19             DAA
94DF: 97 51          STA    $51
94E1: 96 50          LDA    $50
94E3: AB 88 3B       ADDA   $3B,X
94E6: 19             DAA
94E7: 97 50          STA    $50
94E9: 0F 4C          CLR    $4C
94EB: 0F 4D          CLR    $4D
94ED: 0F 4E          CLR    $4E
94EF: CE AA ED       LDU    #$AAED
94F2: 10 8E 28 4C    LDY    #$284C
94F6: A6 22          LDA    $2,Y
94F8: 97 56          STA    $56
94FA: AB 42          ADDA   $2,U
94FC: 19             DAA
94FD: A7 22          STA    $2,Y
94FF: A6 21          LDA    $1,Y
9501: 97 55          STA    $55
9503: A9 41          ADCA   $1,U
9505: 19             DAA
9506: A7 21          STA    $1,Y
9508: A6 A4          LDA    ,Y
950A: 97 54          STA    $54
950C: A9 C4          ADCA   ,U
950E: 19             DAA
950F: A7 A4          STA    ,Y
9511: 6C 88 3A       INC    $3A,X
9514: 96 4C          LDA    $4C
9516: 97 59          STA    $59
9518: 0F 58          CLR    $58
951A: 96 4D          LDA    $4D
951C: 97 5B          STA    $5B
951E: 0F 5A          CLR    $5A
9520: 96 4E          LDA    $4E
9522: 97 5D          STA    $5D
9524: 0F 5C          CLR    $5C
9526: 4F             CLRA
9527: D6 50          LDB    $50
9529: 10 93 58       CMPD   $58
952C: 25 14          BCS    $9542
952E: 22 BF          BHI    $94EF
9530: D6 51          LDB    $51
9532: 10 93 5A       CMPD   $5A
9535: 25 0B          BCS    $9542
9537: 22 B6          BHI    $94EF
9539: D6 52          LDB    $52
953B: 10 93 5C       CMPD   $5C
953E: 23 02          BLS    $9542
9540: 20 AD          BRA    $94EF
9542: 6A 88 3A       DEC    $3A,X
9545: 10 27 00 84    LBEQ   $95CD
9549: 10 8E 28 54    LDY    #$2854
954D: BD 95 F5       JSR    $95F5
9550: 10 8E 28 50    LDY    #$2850
9554: BD 95 F5       JSR    $95F5
9557: 10 8E 28 53    LDY    #$2853
955B: CE 28 57       LDU    #$2857
955E: A6 A4          LDA    ,Y
9560: A0 C4          SUBA   ,U
9562: 24 22          BCC    $9586
9564: A6 A4          LDA    ,Y
9566: 8B 0A          ADDA   #$0A
9568: A0 C4          SUBA   ,U
956A: 97 48          STA    nb_objects_48
956C: 6A 3F          DEC    -$1,Y
956E: A6 3F          LDA    -$1,Y
9570: 81 FF          CMPA   #$FF
9572: 26 10          BNE    $9584
9574: C6 09          LDB    #$09
9576: E7 3F          STB    -$1,Y
9578: 6A 3E          DEC    -$2,Y
957A: A6 3E          LDA    -$2,Y
957C: 81 FF          CMPA   #$FF
957E: 26 04          BNE    $9584
9580: E7 3E          STB    -$2,Y
9582: 6A 3D          DEC    -$3,Y
9584: 96 48          LDA    nb_objects_48
9586: A7 C4          STA    ,U
9588: A6 3F          LDA    -$1,Y
958A: A0 5F          SUBA   -$1,U
958C: 24 18          BCC    $95A6
958E: A6 3F          LDA    -$1,Y
9590: 8B 0A          ADDA   #$0A
9592: A0 5F          SUBA   -$1,U
9594: 97 48          STA    nb_objects_48
9596: 6A 3E          DEC    -$2,Y
9598: A6 3E          LDA    -$2,Y
959A: 81 FF          CMPA   #$FF
959C: 26 06          BNE    $95A4
959E: C6 09          LDB    #$09
95A0: E7 3E          STB    -$2,Y
95A2: 6A 3D          DEC    -$3,Y
95A4: 96 48          LDA    nb_objects_48
95A6: A7 5F          STA    -$1,U
95A8: A6 3E          LDA    -$2,Y
95AA: A0 5E          SUBA   -$2,U
95AC: 24 0C          BCC    $95BA
95AE: A6 3E          LDA    -$2,Y
95B0: 8B 0A          ADDA   #$0A
95B2: A0 5E          SUBA   -$2,U
95B4: 97 48          STA    nb_objects_48
95B6: 6A 3D          DEC    -$3,Y
95B8: 96 48          LDA    nb_objects_48
95BA: A7 5E          STA    -$2,U
95BC: A6 3D          LDA    -$3,Y
95BE: A0 5D          SUBA   -$3,U
95C0: 10 25 CA 3C    LBCS   $6000
95C4: A7 5D          STA    -$3,U
95C6: 10 8E 28 54    LDY    #$2854
95CA: 7E 95 DB       JMP    $95DB
95CD: 10 8E 28 50    LDY    #$2850
95D1: BD 95 F5       JSR    $95F5
95D4: 10 8E 28 50    LDY    #$2850
95D8: 7E 95 DB       JMP    $95DB
95DB: A6 A4          LDA    ,Y
95DD: A7 88 3B       STA    $3B,X
95E0: A6 21          LDA    $1,Y
95E2: 48             ASLA
95E3: 48             ASLA
95E4: 48             ASLA
95E5: 48             ASLA
95E6: AA 22          ORA    $2,Y
95E8: A7 88 3C       STA    $3C,X
95EB: A6 23          LDA    $3,Y
95ED: 48             ASLA
95EE: 48             ASLA
95EF: 48             ASLA
95F0: 48             ASLA
95F1: A7 88 3D       STA    $3D,X
95F4: 39             RTS

95F5: A6 22          LDA    $2,Y
95F7: 44             LSRA
95F8: 44             LSRA
95F9: 44             LSRA
95FA: 44             LSRA
95FB: A7 23          STA    $3,Y
95FD: A6 21          LDA    $1,Y
95FF: 84 0F          ANDA   #$0F
9601: A7 22          STA    $2,Y
9603: 64 21          LSR    $1,Y
9605: 64 21          LSR    $1,Y
9607: 64 21          LSR    $1,Y
9609: 64 21          LSR    $1,Y
960B: 39             RTS

960C: 96 94          LDA    $94
960E: 84 07          ANDA   #$07
9610: 26 0F          BNE    $9621
9612: DE 85          LDU    $85
9614: 33 41          LEAU   $1,U
9616: 11 83 37 40    CMPU   #$3740
961A: 26 03          BNE    $961F
961C: CE 37 00       LDU    #$3700
961F: DF 85          STU    $85
9621: 39             RTS

9622: 96 DE          LDA    $DE
9624: 84 07          ANDA   #$07
9626: 26 0F          BNE    $9637
9628: DE 85          LDU    $85
962A: 33 41          LEAU   $1,U
962C: 11 83 37 40    CMPU   #$3740
9630: 26 03          BNE    $9635
9632: CE 37 00       LDU    #$3700
9635: DF 85          STU    $85
9637: 39             RTS

9638: B6 2A 3E       LDA    $2A3E
963B: 84 07          ANDA   #$07
963D: 26 0F          BNE    $964E
963F: DE 77          LDU    $77
9641: 33 41          LEAU   $1,U
9643: 11 83 35 C0    CMPU   #$35C0
9647: 26 03          BNE    $964C
9649: CE 35 80       LDU    #$3580
964C: DF 77          STU    $77
964E: 39             RTS

964F: 96 84          LDA    current_level_84
9651: 81 00          CMPA   #$00
9653: 27 42          BEQ    $9697
9655: BD 88 C8       JSR    $88C8
9658: 8E 28 A0       LDX    #$28A0
965B: 6D 88 33       TST    $33,X
965E: 26 16          BNE    $9676
9660: BD 85 87       JSR    $8587
9663: BD 9C 4D       JSR    $9C4D
9666: BD 9E EB       JSR    $9EEB
9669: 34 10          PSHS   X
966B: 8E 2A C0       LDX    #$2AC0
966E: BD 85 87       JSR    $8587
9671: BD 9E D8       JSR    $9ED8
9674: 35 10          PULS   X
9676: 8E 2A 00       LDX    #$2A00
9679: 0C DF          INC    $DF
967B: 6D 88 33       TST    $33,X
967E: 26 16          BNE    $9696
9680: BD 85 DE       JSR    $85DE
9683: BD 9C 4D       JSR    $9C4D
9686: BD 9E EB       JSR    $9EEB
9689: 34 10          PSHS   X
968B: 8E 2A E0       LDX    #$2AE0
968E: BD 85 DE       JSR    $85DE
9691: BD 9E D8       JSR    $9ED8
9694: 35 10          PULS   X
9696: 39             RTS

9697: BD 88 C8       JSR    $88C8
969A: 8E 28 A0       LDX    #$28A0
969D: 6D 88 33       TST    $33,X
96A0: 26 13          BNE    $96B5
96A2: BD 85 87       JSR    $8587
96A5: BD 9E EB       JSR    $9EEB
96A8: 34 10          PSHS   X
96AA: 8E 2A C0       LDX    #$2AC0
96AD: BD 85 87       JSR    $8587
96B0: BD 9E D8       JSR    $9ED8
96B3: 35 10          PULS   X
96B5: 8E 2A 00       LDX    #$2A00
96B8: 0C DF          INC    $DF
96BA: 6D 88 33       TST    $33,X
96BD: 26 13          BNE    $96D2
96BF: BD 85 DE       JSR    $85DE
96C2: BD 9E EB       JSR    $9EEB
96C5: 34 10          PSHS   X
96C7: 8E 2A E0       LDX    #$2AE0
96CA: BD 85 DE       JSR    $85DE
96CD: BD 9E D8       JSR    $9ED8
96D0: 35 10          PULS   X
96D2: 39             RTS

compare_contestants_tile_96d3:
96D3: 8E 29 60       LDX    #player_1_final_time_2960
96D6: 96 DF          LDA    $DF
96D8: 84 02          ANDA   #$02
96DA: 27 03          BEQ    $96DF
96DC: 8E 29 78       LDX    #$2978
96DF: 31 0C          LEAY   $C,X
96E1: A6 84          LDA    ,X
96E3: 81 04          CMPA   #$04
96E5: 25 16          BCS    $96FD
96E7: 39             RTS

96E8: 8E 29 60       LDX    #player_1_final_time_2960
96EB: 96 DF          LDA    $DF
96ED: C6 0C          LDB    #$0C
96EF: 3D             MUL
96F0: 30 8B          LEAX   D,X
96F2: 31 04          LEAY   $4,X
96F4: BD 89 68       JSR    compare_performances_8968
96F7: 96 62          LDA    $62
96F9: 27 1F          BEQ    $971A
96FB: 31 24          LEAY   $4,Y
96FD: BD 89 68       JSR    compare_performances_8968
9700: 96 62          LDA    $62
9702: 27 16          BEQ    $971A
9704: A6 84          LDA    ,X
9706: 81 16          CMPA   #$16
9708: 27 10          BEQ    $971A
970A: 86 01          LDA    #$01
970C: 97 61          STA    $61
970E: CC 70 F0       LDD    #$70F0
9711: FD 29 D1       STD    $29D1
9714: CC DE E3       LDD    #$DEE3
9717: FD 29 DE       STD    $29DE
971A: 39             RTS

971B: 96 61          LDA    $61
971D: 27 1D          BEQ    $973C
971F: 34 10          PSHS   X
9721: 8E 29 D0       LDX    #$29D0
9724: 6A 02          DEC    $2,X
9726: 26 09          BNE    $9731
9728: 6F 01          CLR    $1,X
972A: 6F 02          CLR    $2,X
972C: 0F 61          CLR    $61
972E: BD D5 40       JSR    $D540
9731: A6 02          LDA    $2,X
9733: 81 28          CMPA   #$28
9735: 27 06          BEQ    $973D
9737: BD CC FA       JSR    $CCFA
973A: 35 10          PULS   X
973C: 39             RTS

973D: CC DE DB       LDD    #$DEDB
9740: ED 0E          STD    $E,X
9742: 20 F3          BRA    $9737
9744: 96 21          LDA    copy_of_screen_flipped_21
9746: 26 44          BNE    $978C
9748: B6 2A FB       LDA    $2AFB
974B: 97 48          STA    nb_objects_48
974D: 27 1A          BEQ    $9769
974F: 8E 18 58       LDX    #$1858
9752: 6C 80          INC    ,X+
9754: 26 04          BNE    $975A
9756: 6C 89 03 FF    INC    $03FF,X
975A: 8C 18 5D       CMPX   #$185D
975D: 26 F3          BNE    $9752
975F: 7C 2F E8       INC    $2FE8
9762: BD 9B 1D       JSR    $9B1D
9765: 0A 48          DEC    nb_objects_48
9767: 26 E6          BNE    $974F
9769: B6 2A F5       LDA    $2AF5
976C: 97 48          STA    nb_objects_48
976E: 27 1A          BEQ    $978A
9770: 8E 18 52       LDX    #$1852
9773: 6C 80          INC    ,X+
9775: 26 04          BNE    $977B
9777: 6C 89 03 FF    INC    $03FF,X
977B: 8C 18 57       CMPX   #$1857
977E: 26 F3          BNE    $9773
9780: 7C 2F EB       INC    $2FEB
9783: BD 9B 5C       JSR    $9B5C
9786: 0A 48          DEC    nb_objects_48
9788: 26 E6          BNE    $9770
978A: 20 46          BRA    $97D2
978C: B6 2A FB       LDA    $2AFB
978F: 97 48          STA    nb_objects_48
9791: 27 1C          BEQ    $97AF
9793: 8E 18 58       LDX    #$1858
9796: 6D 84          TST    ,X
9798: 26 04          BNE    $979E
979A: 6A 89 04 00    DEC    $0400,X
979E: 6A 80          DEC    ,X+
97A0: 8C 18 5D       CMPX   #$185D
97A3: 26 F1          BNE    $9796
97A5: 7C 2F E8       INC    $2FE8
97A8: BD 9B 1D       JSR    $9B1D
97AB: 0A 48          DEC    nb_objects_48
97AD: 26 E4          BNE    $9793
97AF: B6 2A F5       LDA    $2AF5
97B2: 97 48          STA    nb_objects_48
97B4: 27 1C          BEQ    $97D2
97B6: 8E 18 52       LDX    #$1852
97B9: 6D 84          TST    ,X
97BB: 26 04          BNE    $97C1
97BD: 6A 89 04 00    DEC    $0400,X
97C1: 6A 80          DEC    ,X+
97C3: 8C 18 57       CMPX   #$1857
97C6: 26 F1          BNE    $97B9
97C8: 7C 2F EB       INC    $2FEB
97CB: BD 9B 5C       JSR    $9B5C
97CE: 0A 48          DEC    nb_objects_48
97D0: 26 E4          BNE    $97B6
97D2: 8E 2A F0       LDX    #scroll_offsets_2af0
97D5: 4F             CLRA
97D6: 5F             CLRB
97D7: ED 81          STD    ,X++
97D9: 8C 2B 00       CMPX   #$2B00
97DC: 26 F9          BNE    $97D7
97DE: 39             RTS

97DF: BD DE FF       JSR    $DEFF
97E2: EB 01          ADDB   $1,X
97E4: E7 01          STB    $1,X
97E6: E6 88 14       LDB    $14,X
97E9: C0 08          SUBB   #$08
97EB: E1 01          CMPB   $1,X
97ED: 10 22 00 DF    LBHI   $98D0
97F1: D6 CE          LDB    $CE
97F3: 10 26 00 87    LBNE   $987E
97F7: AB 02          ADDA   $2,X
97F9: A7 02          STA    $2,X		; update parabol X (player in air, javelin)
97FB: 97 4A          STA    $4A
97FD: 0D D7          TST    $D7
97FF: 26 24          BNE    $9825
9801: CE 28 39       LDU    #$2839
9804: 96 DF          LDA    $DF
9806: 84 01          ANDA   #$01
9808: 27 02          BEQ    $980C
980A: 33 43          LEAU   $3,U
980C: A6 C4          LDA    ,U
980E: 84 02          ANDA   #$02
9810: 27 0B          BEQ    $981D
9812: 96 D8          LDA    angle_d8
9814: 4C             INCA
9815: 81 51          CMPA   #$51
9817: 27 0C          BEQ    $9825
9819: 97 D8          STA    angle_d8
981B: 20 08          BRA    $9825
981D: 0C D7          INC    $D7
981F: BD E4 52       JSR    $E452
9822: BD FB 26       JSR    $FB26
9825: 86 08          LDA    #$08
9827: BD 84 F5       JSR    queue_event_84f5
982A: BD 8A 03       JSR    $8A03
982D: 4F             CLRA
982E: D6 4A          LDB    $4A
9830: 83 00 E0       SUBD   #$00E0
9833: 25 0D          BCS    $9842
9835: D7 4B          STB    $4B
9837: 86 01          LDA    #$01
9839: 97 CE          STA    $CE
983B: 86 E0          LDA    #$E0
983D: A7 02          STA    $2,X
983F: 7E 98 C2       JMP    $98C2
9842: BD CA F5       JSR    $CAF5
9845: 96 B0          LDA    $B0
9847: C6 0A          LDB    #$0A
9849: 3D             MUL
984A: DB B1          ADDB   $B1
984C: C1 0D          CMPB   #$0D
984E: 25 09          BCS    $9859
9850: CC 01 03       LDD    #$0103
9853: DD B0          STD    $B0
9855: 4F             CLRA
9856: 5F             CLRB
9857: DD B2          STD    $B2
9859: CE 28 39       LDU    #$2839
985C: 96 DF          LDA    $DF
985E: 84 01          ANDA   #$01
9860: 27 02          BEQ    $9864
9862: A6 42          LDA    $2,U
9864: AA 41          ORA    $1,U
9866: 43             COMA
9867: A4 C4          ANDA   ,U
9869: 84 05          ANDA   #$05
986B: 27 10          BEQ    $987D
986D: 7C 2A B6       INC    $2AB6
9870: B6 2A B6       LDA    $2AB6
9873: 81 02          CMPA   #$02
9875: 26 06          BNE    $987D
9877: 7F 2A B6       CLR    $2AB6
987A: BD 91 14       JSR    $9114
987D: 39             RTS

987E: 97 4B          STA    $4B
9880: 96 99          LDA    $99
9882: 90 4B          SUBA   $4B
9884: 97 99          STA    $99
9886: 34 10          PSHS   X
9888: 8E 29 A0       LDX    #$29A0
988B: A6 84          LDA    ,X
988D: 27 11          BEQ    $98A0
988F: A6 02          LDA    $2,X
9891: 90 4B          SUBA   $4B
9893: 24 03          BCC    $9898
9895: 6F 84          CLR    ,X
9897: 4F             CLRA
9898: A7 02          STA    $2,X
989A: CE 18 22       LDU    #$1822
989D: BD D2 3E       JSR    $D23E
98A0: 8E 2A E0       LDX    #$2AE0
98A3: A6 02          LDA    $2,X
98A5: 90 4B          SUBA   $4B
98A7: 24 01          BCC    $98AA
98A9: 4F             CLRA
98AA: A7 02          STA    $2,X
98AC: BD 8A 03       JSR    $8A03
98AF: 86 08          LDA    #$08
98B1: BD 84 F5       JSR    queue_event_84f5
98B4: 8E 29 E0       LDX    #$29E0
98B7: A6 02          LDA    $2,X
98B9: 90 4B          SUBA   $4B
98BB: A7 02          STA    $2,X
98BD: BD CD 2B       JSR    $CD2B
98C0: 35 10          PULS   X
98C2: 96 4B          LDA    $4B
98C4: 10 27 32 2D    LBEQ   $CAF5
98C8: 97 49          STA    $49
98CA: BD 88 3C       JSR    $883C
98CD: 7E CA F5       JMP    $CAF5
98D0: 4F             CLRA
98D1: BD 85 08       JSR    $8508
98D4: 86 09          LDA    #$09
98D6: BD 85 08       JSR    $8508
98D9: A6 02          LDA    $2,X
98DB: BB 2A BA       ADDA   $2ABA
98DE: A7 02          STA    $2,X
98E0: A6 88 14       LDA    $14,X
98E3: A7 01          STA    $1,X
98E5: EC 01          LDD    $1,X
98E7: DD 9A          STD    $9A
98E9: A6 02          LDA    $2,X
98EB: 84 07          ANDA   #$07
98ED: 97 50          STA    $50
98EF: 96 94          LDA    $94
98F1: 84 07          ANDA   #$07
98F3: 9B 50          ADDA   $50
98F5: 84 07          ANDA   #$07
98F7: 97 AD          STA    $AD
98F9: A6 98 1E       LDA    [$1E,X]		; [video_address]
98FC: 81 5D          CMPA   #$5D
98FE: 26 09          BNE    $9909
9900: BD CD 20       JSR    $CD20
9903: 86 05          LDA    #$05
9905: D6 C9          LDB    jump_foul_C9
9907: 27 05          BEQ    $990E
9909: BD 7F 6C       JSR    $7F6C
990C: 86 06          LDA    #$06
990E: 97 06          STA    $06
9910: BD CB 11       JSR    $CB11
9913: 0F 09          CLR    $09
9915: 86 32          LDA    #$32
9917: 97 08          STA    $08
9919: 39             RTS

991A: 96 97          LDA    $97
991C: 26 21          BNE    $993F
991E: BD 88 52       JSR    $8852
9921: A6 A4          LDA    ,Y		; [video_address]
9923: 81 52          CMPA   #$52
9925: 27 01          BEQ    $9928
9927: 39             RTS

9928: 10 9F 95       STY    $95
992B: 96 94          LDA    $94
992D: 84 07          ANDA   #$07
992F: 97 57          STA    $57
9931: EC 01          LDD    $1,X
9933: C4 F8          ANDB   #$F8
9935: CB 11          ADDB   #$11
9937: D0 57          SUBB   $57
9939: DD 98          STD    $98
993B: 86 01          LDA    #$01
993D: 97 97          STA    $97
993F: 10 AE 03       LDY    $3,X
9942: 10 9C 95       CMPY   $95
9945: 27 0B          BEQ    $9952
9947: BD 88 52       JSR    $8852
994A: 10 9C 95       CMPY   $95
994D: 27 15          BEQ    $9964
994F: 7E 99 84       JMP    $9984
9952: A6 02          LDA    $2,X
9954: A0 0D          SUBA   $D,X
9956: 8B 08          ADDA   #$08
9958: E6 02          LDB    $2,X
995A: CB 07          ADDB   #$07
995C: D7 50          STB    $50
995E: 90 50          SUBA   $50
9960: 25 22          BCS    $9984
9962: 20 12          BRA    $9976
9964: A6 02          LDA    $2,X
9966: 8B 08          ADDA   #$08
9968: A0 0D          SUBA   $D,X
996A: 8B 08          ADDA   #$08
996C: E6 02          LDB    $2,X
996E: CB 07          ADDB   #$07
9970: D7 50          STB    $50
9972: 90 50          SUBA   $50
9974: 25 0E          BCS    $9984
9976: 0F E9          CLR    $E9
9978: 81 05          CMPA   #$05
997A: 24 07          BCC    $9983
997C: CE AA D2       LDU    #$AAD2
997F: A6 C6          LDA    A,U
9981: 97 E9          STA    $E9
9983: 39             RTS

9984: 86 01          LDA    #$01
9986: 97 C9          STA    jump_foul_C9
9988: 0F E9          CLR    $E9
998A: 39             RTS

998B: 96 97          LDA    $97
998D: 26 25          BNE    $99B4
998F: EC 88 1E       LDD    $1E,X
9992: BD 88 54       JSR    $8854
9995: A6 A4          LDA    ,Y		; [video_address]
9997: 81 52          CMPA   #$52
9999: 26 19          BNE    $99B4
999B: 10 9F 95       STY    $95
999E: 96 94          LDA    $94
99A0: 84 07          ANDA   #$07
99A2: 97 57          STA    $57
99A4: E6 02          LDB    $2,X
99A6: C4 F8          ANDB   #$F8
99A8: CB 11          ADDB   #$11
99AA: D0 57          SUBB   $57
99AC: 86 30          LDA    #$30
99AE: DD 98          STD    $98
99B0: 86 01          LDA    #$01
99B2: 97 97          STA    $97
99B4: 39             RTS

99B5: A6 84          LDA    ,X
99B7: 27 07          BEQ    $99C0
99B9: 86 01          LDA    #$01
99BB: B7 2B 2F       STA    $2B2F
99BE: 20 24          BRA    $99E4
99C0: 7D 2B 2F       TST    $2B2F
99C3: 27 05          BEQ    $99CA
99C5: 86 02          LDA    #$02
99C7: B7 2B 2F       STA    $2B2F
99CA: 10 8E AA D7    LDY    #$AAD7
99CE: 96 84          LDA    current_level_84
99D0: E6 A6          LDB    A,Y
99D2: EE 03          LDU    $3,X
99D4: 81 02          CMPA   #$02
99D6: 26 03          BNE    $99DB
99D8: 33 C8 40       LEAU   $40,U
99DB: E1 C4          CMPB   ,U			; [video_address]
99DD: 27 01          BEQ    $99E0
99DF: 39             RTS

99E0: 86 01          LDA    #$01
99E2: A7 84          STA    ,X
99E4: 7E CC BD       JMP    $CCBD
99E7: A6 84          LDA    ,X
99E9: 26 07          BNE    $99F2
99EB: A6 98 03       LDA    [$03,X]		; [video_address]
99EE: 81 AB          CMPA   #$AB
99F0: 27 01          BEQ    $99F3
99F2: 39             RTS

99F3: 86 01          LDA    #$01
99F5: A7 84          STA    ,X
99F7: B7 2B 20       STA    $2B20
99FA: A6 02          LDA    $2,X
99FC: A0 0D          SUBA   $D,X
99FE: A7 02          STA    $2,X
9A00: 6C 02          INC    $2,X
9A02: 8B 02          ADDA   #$02
9A04: B7 2B 02       STA    $2B02
9A07: B7 2B 12       STA    $2B12
9A0A: EC 03          LDD    $3,X
9A0C: DD 95          STD    $95
9A0E: 0D 21          TST    copy_of_screen_flipped_21
9A10: 27 00          BEQ    $9A12
9A12: B6 2B 02       LDA    $2B02
9A15: 4A             DECA
9A16: B7 2B 22       STA    $2B22
9A19: 7E CD A8       JMP    $CDA8

9A1C: 96 D6          LDA    $D6
9A1E: 26 09          BNE    $9A29
9A20: A6 98 03       LDA    [$03,X]	; [video_address]
9A23: 91 E3          CMPA   $E3
9A25: 26 02          BNE    $9A29
9A27: 0C D6          INC    $D6
9A29: 39             RTS

9A2A: EC 88 1E       LDD    $1E,X
9A2D: 10 93 95       CMPD   $95
9A30: 24 03          BCC    $9A35
9A32: C3 00 40       ADDD   #$0040
9A35: 93 95          SUBD   $95
9A37: 86 08          LDA    #$08
9A39: 3D             MUL
9A3A: DB AD          ADDB   $AD
9A3C: CB 04          ADDB   #$04
9A3E: C0 06          SUBB   #$06
9A40: F0 2A BA       SUBB   $2ABA
9A43: D7 52          STB    $52
9A45: CE AA ED       LDU    #$AAED
9A48: BD 89 A5       JSR    $89A5
9A4B: FC 2F E4       LDD    $2FE4
9A4E: 10 83 00 32    CMPD   #$0032
9A52: 25 25          BCS    $9A79
9A54: DC F1          LDD    $F1
9A56: 10 83 07 02    CMPD   #$0702
9A5A: 26 1D          BNE    $9A79
9A5C: CE A6 BA       LDU    #$A6BA
9A5F: 4F             CLRA
9A60: 5F             CLRB
9A61: 10 8E 00 0D    LDY    #$000D
9A65: EB C0          ADDB   ,U+
9A67: 89 00          ADCA   #$00
9A69: 31 3F          LEAY   -$1,Y
9A6B: 26 F8          BNE    $9A65
9A6D: 10 83 03 4E    CMPD   #$034E
9A71: 27 06          BEQ    $9A79
9A73: 86 0A          LDA    #$0A
9A75: 97 03          STA    boot_state_03
9A77: 97 06          STA    $06
9A79: 39             RTS

9A7A: 0A 99          DEC    $99
9A7C: BD CB 3B       JSR    $CB3B
9A7F: 7E 9A 82       JMP    $9A82
9A82: 34 10          PSHS   X
9A84: 8E 29 A0       LDX    #$29A0
9A87: CE 18 22       LDU    #$1822
9A8A: A6 84          LDA    ,X
9A8C: 27 12          BEQ    $9AA0
9A8E: 6A 02          DEC    $2,X
9A90: 27 11          BEQ    $9AA3
9A92: BD D2 3E       JSR    $D23E
9A95: 35 10          PULS   X
9A97: B6 1C 20       LDA    $1C20
9A9A: 27 06          BEQ    $9AA2
9A9C: 7A 1C 20       DEC    $1C20
9A9F: 39             RTS

9AA0: 35 10          PULS   X
9AA2: 39             RTS

9AA3: 6F 01          CLR    $1,X
9AA5: BD D2 62       JSR    $D262
9AA8: 6F 84          CLR    ,X
9AAA: 20 F4          BRA    $9AA0
9AAC: 34 10          PSHS   X
9AAE: 8E 2A C0       LDX    #$2AC0
9AB1: A6 84          LDA    ,X
9AB3: 27 19          BEQ    $9ACE
9AB5: A6 02          LDA    $2,X
9AB7: 4A             DECA
9AB8: A7 02          STA    $2,X
9ABA: 96 84          LDA    current_level_84
9ABC: 81 00          CMPA   #$00
9ABE: 27 0B          BEQ    $9ACB
9AC0: 96 84          LDA    current_level_84
9AC2: 81 05          CMPA   #$05
9AC4: 26 08          BNE    $9ACE
9AC6: BD CD A8       JSR    $CDA8
9AC9: 20 03          BRA    $9ACE
9ACB: BD CE 26       JSR    $CE26
9ACE: 35 10          PULS   X
9AD0: 39             RTS

9AD1: 34 10          PSHS   X
9AD3: 8E 2A C0       LDX    #$2AC0
9AD6: A6 84          LDA    ,X
9AD8: 27 05          BEQ    $9ADF
9ADA: 6A 02          DEC    $2,X
9ADC: BD CE 26       JSR    $CE26
9ADF: 35 10          PULS   X
9AE1: 39             RTS

9AE2: 34 10          PSHS   X
9AE4: 8E 2A E0       LDX    #$2AE0
9AE7: A6 84          LDA    ,X
9AE9: 27 05          BEQ    $9AF0
9AEB: 6A 02          DEC    $2,X
9AED: BD CE 26       JSR    $CE26
9AF0: 35 10          PULS   X
9AF2: 39             RTS

9AF3: A6 98 03       LDA    [$03,X]		; [video_address]
9AF6: 81 5D          CMPA   #$5D
9AF8: 27 03          BEQ    $9AFD
9AFA: C6 01          LDB    #$01
9AFC: 39             RTS

9AFD: 86 07          LDA    #$07
9AFF: 97 06          STA    $06
9B01: 0F 09          CLR    $09
9B03: 6F 88 32       CLR    $32,X
9B06: 86 03          LDA    #$03
9B08: 97 0A          STA    $0A
9B0A: 97 0B          STA    $0B
9B0C: 5F             CLRB
9B0D: 39             RTS

9B0E: 8E 28 A0       LDX    #$28A0
9B11: EC 01          LDD    $1,X
9B13: 8E 29 E0       LDX    #$29E0
9B16: ED 01          STD    $1,X
9B18: 6C 84          INC    ,X
9B1A: 7E CD 2B       JMP    $CD2B

9B1D: B6 2F E8       LDA    $2FE8
9B20: 84 07          ANDA   #$07
9B22: 26 37          BNE    $9B5B
9B24: FE 2F E9       LDU    $2FE9
9B27: 10 9E 87       LDY    $87
9B2A: A6 A4          LDA    ,Y
9B2C: 81 FF          CMPA   #$FF
9B2E: 26 03          BNE    $9B33
9B30: 10 AE 21       LDY    $1,Y
9B33: 86 05          LDA    #$05
9B35: 97 4A          STA    $4A
9B37: D6 89          LDB    $89
9B39: E7 C9 08 00    STB    $0800,U     ; [video_address]
9B3D: A6 A0          LDA    ,Y+        
9B3F: A7 C4          STA    ,U          ; [video_address]
9B41: 33 C8 C0       LEAU   -$40,U
9B44: 0A 4A          DEC    $4A
9B46: 26 F1          BNE    $9B39
9B48: 33 C9 01 41    LEAU   $0141,U
9B4C: 11 83 37 40    CMPU   #$3740
9B50: 26 03          BNE    $9B55
9B52: CE 37 00       LDU    #$3700
9B55: FF 2F E9       STU    $2FE9
9B58: 10 9F 87       STY    $87
9B5B: 39             RTS

9B5C: B6 2F EB       LDA    $2FEB
9B5F: 84 07          ANDA   #$07
9B61: 26 37          BNE    $9B9A
9B63: FE 2F EC       LDU    $2FEC
9B66: 10 9E 79       LDY    $79
9B69: A6 A4          LDA    ,Y
9B6B: 81 FF          CMPA   #$FF
9B6D: 26 03          BNE    $9B72
9B6F: 10 AE 21       LDY    $1,Y
9B72: 86 05          LDA    #$05
9B74: 97 4A          STA    $4A
9B76: D6 7B          LDB    $7B
9B78: E7 C9 08 00    STB    $0800,U     ; [video_address]
9B7C: A6 A0          LDA    ,Y+
9B7E: A7 C4          STA    ,U           ; [video_address]
9B80: 33 C8 C0       LEAU   -$40,U
9B83: 0A 4A          DEC    $4A
9B85: 26 F1          BNE    $9B78
9B87: 33 C9 01 41    LEAU   $0141,U
9B8B: 11 83 35 C0    CMPU   #$35C0
9B8F: 26 03          BNE    $9B94
9B91: CE 35 80       LDU    #$3580
9B94: FF 2F EC       STU    $2FEC
9B97: 10 9F 79       STY    $79
9B9A: 39             RTS

9B9B: 39             RTS

9B9C: A6 88 15       LDA    $15,X
9B9F: 26 09          BNE    $9BAA
9BA1: E6 84          LDB    ,X
9BA3: C1 02          CMPB   #$02
9BA5: 25 23          BCS    $9BCA
9BA7: 7E CB 3B       JMP    $CB3B
9BAA: 97 49          STA    $49
9BAC: 96 DF          LDA    $DF
9BAE: 84 01          ANDA   #$01
9BB0: 26 19          BNE    $9BCB
9BB2: 7C 2A FB       INC    $2AFB
9BB5: 0C DE          INC    $DE
9BB7: BD 96 22       JSR    $9622
9BBA: A6 84          LDA    ,X
9BBC: 81 02          CMPA   #$02
9BBE: 25 03          BCS    $9BC3
9BC0: BD CB 3B       JSR    $CB3B
9BC3: BD 9A D1       JSR    $9AD1
9BC6: 0A 49          DEC    $49
9BC8: 26 E8          BNE    $9BB2
9BCA: 39             RTS

9BCB: 7C 2A F5       INC    $2AF5
9BCE: 86 01          LDA    #$01
9BD0: 97 B5          STA    $B5
9BD2: BD 91 B0       JSR    $91B0
9BD5: 0C 94          INC    $94
9BD7: 7C 2A 3E       INC    $2A3E
9BDA: BD 96 38       JSR    $9638
9BDD: A6 84          LDA    ,X
9BDF: 81 02          CMPA   #$02
9BE1: 25 03          BCS    $9BE6
9BE3: BD CB 3B       JSR    $CB3B
9BE6: BD 9A 82       JSR    $9A82
9BE9: BD 9A E2       JSR    $9AE2
9BEC: 0A 49          DEC    $49
9BEE: 26 DB          BNE    $9BCB
9BF0: 39             RTS

9BF1: 96 DF          LDA    $DF
9BF3: 84 01          ANDA   #$01
9BF5: 26 10          BNE    $9C07
9BF7: 7C 2A FB       INC    $2AFB
9BFA: 0C DE          INC    $DE
9BFC: BD 96 22       JSR    $9622
9BFF: BD 9A D1       JSR    $9AD1
9C02: 0A 49          DEC    $49
9C04: 26 F1          BNE    $9BF7
9C06: 39             RTS

9C07: 7C 2A F5       INC    $2AF5
9C0A: 86 01          LDA    #$01
9C0C: 97 B5          STA    $B5
9C0E: BD 91 B0       JSR    $91B0
9C11: 0C 94          INC    $94
9C13: 7C 2A 3E       INC    $2A3E
9C16: BD 96 38       JSR    $9638
9C19: BD 9A 82       JSR    $9A82
9C1C: BD 9A E2       JSR    $9AE2
9C1F: 0A 49          DEC    $49
9C21: 26 E4          BNE    $9C07
9C23: 39             RTS

9C24: 86 08          LDA    #$08
9C26: 97 49          STA    $49
9C28: 86 05          LDA    #$05
9C2A: 97 4A          STA    $4A
9C2C: 10 8E 2A F5    LDY    #$2AF5
9C30: 96 DF          LDA    $DF
9C32: 84 01          ANDA   #$01
9C34: 26 02          BNE    $9C38
9C36: 31 26          LEAY   $6,Y
9C38: A6 A4          LDA    ,Y
9C3A: 9B 49          ADDA   $49
9C3C: A7 A0          STA    ,Y+
9C3E: 96 DF          LDA    $DF
9C40: 84 01          ANDA   #$01
9C42: 26 05          BNE    $9C49
9C44: BD 96 22       JSR    $9622
9C47: 20 03          BRA    $9C4C
9C49: BD 96 38       JSR    $9638
9C4C: 39             RTS

9C4D: A6 01          LDA    $1,X
9C4F: 84 07          ANDA   #$07
9C51: 97 49          STA    $49
9C53: EC 03          LDD    $3,X
9C55: C3 00 01       ADDD   #$0001
9C58: C5 3F          BITB   #$3F
9C5A: 26 03          BNE    $9C5F
9C5C: 83 00 40       SUBD   #$0040
9C5F: 1F 02          TFR    D,Y
9C61: A6 A4          LDA    ,Y		; [video_address]
9C63: 81 D2          CMPA   #$D2
9C65: 27 6C          BEQ    $9CD3
9C67: A6 A4          LDA    ,Y		; [video_address]
9C69: 81 D3          CMPA   #$D3
9C6B: 10 27 00 92    LBEQ   $9D01
9C6F: 10 AE 03       LDY    $3,X
9C72: A6 A4          LDA    ,Y		; [video_address]
9C74: 81 D2          CMPA   #$D2
9C76: 10 27 00 A6    LBEQ   $9D20
9C7A: A6 A4          LDA    ,Y		; [video_address]
9C7C: 81 D3          CMPA   #$D3
9C7E: 10 27 00 C1    LBEQ   $9D43
9C82: EC 03          LDD    $3,X
9C84: 83 00 01       SUBD   #$0001
9C87: DD 4E          STD    $4E
9C89: C4 3F          ANDB   #$3F
9C8B: C1 3F          CMPB   #$3F
9C8D: 26 07          BNE    $9C96
9C8F: DC 4E          LDD    $4E
9C91: C3 00 40       ADDD   #$0040
9C94: 20 02          BRA    $9C98
9C96: DC 4E          LDD    $4E
9C98: 1F 02          TFR    D,Y
9C9A: A6 A4          LDA    ,Y		; [video_address]
9C9C: 81 D2          CMPA   #$D2
9C9E: 10 27 00 E2    LBEQ   $9D84
9CA2: A6 A4          LDA    ,Y		; [video_address]
9CA4: 81 D3          CMPA   #$D3
9CA6: 10 27 00 EB    LBEQ   $9D95
9CAA: EC 03          LDD    $3,X
9CAC: 83 00 02       SUBD   #$0002
9CAF: DD 4E          STD    $4E
9CB1: C4 3E          ANDB   #$3E
9CB3: C1 3E          CMPB   #$3E
9CB5: 26 07          BNE    $9CBE
9CB7: DC 4E          LDD    $4E
9CB9: C3 00 40       ADDD   #$0040
9CBC: 20 02          BRA    $9CC0
9CBE: DC 4E          LDD    $4E
9CC0: 1F 02          TFR    D,Y
9CC2: A6 A4          LDA    ,Y		; [video_address]
9CC4: 81 D2          CMPA   #$D2
9CC6: 10 27 01 00    LBEQ   $9DCA
9CCA: A6 A4          LDA    ,Y		; [video_address]
9CCC: 81 D3          CMPA   #$D3
9CCE: 10 27 01 07    LBEQ   $9DD9
9CD2: 39             RTS

9CD3: A6 06          LDA    $6,X
9CD5: 81 0F          CMPA   #$0F
9CD7: 26 08          BNE    $9CE1
9CD9: A6 0D          LDA    $D,X
9CDB: 81 06          CMPA   #$06
9CDD: 10 24 01 05    LBCC   $9DE6
9CE1: A6 06          LDA    $6,X
9CE3: 81 4B          CMPA   #$4B
9CE5: 10 27 01 3E    LBEQ   $9E27
9CE9: A6 06          LDA    $6,X
9CEB: 81 4D          CMPA   #$4D
9CED: 10 27 00 00    LBEQ   $9CF1
9CF1: A6 88 1C       LDA    $1C,X
9CF4: 26 08          BNE    $9CFE
9CF6: A6 0D          LDA    $D,X
9CF8: 81 06          CMPA   #$06
9CFA: 10 24 01 29    LBCC   $9E27
9CFE: 16 FF 66       LBRA   $9C67
9D01: A6 06          LDA    $6,X
9D03: 81 0F          CMPA   #$0F
9D05: 26 08          BNE    $9D0F
9D07: 96 49          LDA    $49
9D09: 81 03          CMPA   #$03
9D0B: 10 25 00 ED    LBCS   $9DFC
9D0F: A6 06          LDA    $6,X
9D11: 81 4D          CMPA   #$4D
9D13: 26 08          BNE    $9D1D
9D15: A6 0D          LDA    $D,X
9D17: 81 04          CMPA   #$04
9D19: 10 25 00 DF    LBCS   $9DFC
9D1D: 16 FF 4F       LBRA   $9C6F
9D20: A6 06          LDA    $6,X
9D22: 81 0F          CMPA   #$0F
9D24: 10 27 00 FF    LBEQ   $9E27
9D28: A6 06          LDA    $6,X
9D2A: 81 4B          CMPA   #$4B
9D2C: 10 27 00 B6    LBEQ   $9DE6
9D30: A6 06          LDA    $6,X
9D32: 81 4D          CMPA   #$4D
9D34: 10 27 00 EF    LBEQ   $9E27
9D38: 6D 88 1C       TST    $1C,X
9D3B: 26 03          BNE    $9D40
9D3D: 16 00 E7       LBRA   $9E27
9D40: 16 FF 37       LBRA   $9C7A
9D43: A6 06          LDA    $6,X
9D45: 81 0F          CMPA   #$0F
9D47: 26 0E          BNE    $9D57
9D49: A6 0D          LDA    $D,X
9D4B: 81 06          CMPA   #$06
9D4D: 24 08          BCC    $9D57
9D4F: 96 49          LDA    $49
9D51: 81 03          CMPA   #$03
9D53: 10 25 00 FA    LBCS   $9E51
9D57: A6 06          LDA    $6,X
9D59: 81 4B          CMPA   #$4B
9D5B: 26 06          BNE    $9D63
9D5D: 96 49          LDA    $49
9D5F: 10 27 00 EE    LBEQ   $9E51
9D63: A6 06          LDA    $6,X
9D65: 81 4D          CMPA   #$4D
9D67: 26 18          BNE    $9D81
9D69: A6 0D          LDA    $D,X
9D6B: 81 04          CMPA   #$04
9D6D: 25 0A          BCS    $9D79
9D6F: 96 49          LDA    $49
9D71: 81 03          CMPA   #$03
9D73: 10 25 00 DA    LBCS   $9E51
9D77: 20 08          BRA    $9D81
9D79: 96 49          LDA    $49
9D7B: 81 06          CMPA   #$06
9D7D: 10 25 00 D0    LBCS   $9E51
9D81: 16 FE FE       LBRA   $9C82
9D84: A6 06          LDA    $6,X
9D86: 81 0E          CMPA   #$0E
9D88: 10 27 00 9B    LBEQ   $9E27
9D8C: 81 4A          CMPA   #$4A
9D8E: 10 27 00 95    LBEQ   $9E27
9D92: 16 FF 0D       LBRA   $9CA2
9D95: A6 06          LDA    $6,X
9D97: 81 0E          CMPA   #$0E
9D99: 26 10          BNE    $9DAB
9D9B: A6 0D          LDA    $D,X
9D9D: 81 04          CMPA   #$04
9D9F: 24 0A          BCC    $9DAB
9DA1: 81 06          CMPA   #$06
9DA3: 24 57          BCC    $9DFC
9DA5: 96 49          LDA    $49
9DA7: 81 04          CMPA   #$04
9DA9: 25 51          BCS    $9DFC
9DAB: A6 06          LDA    $6,X
9DAD: 81 4A          CMPA   #$4A
9DAF: 26 16          BNE    $9DC7
9DB1: A6 0D          LDA    $D,X
9DB3: 24 0A          BCC    $9DBF
9DB5: 96 49          LDA    $49
9DB7: 81 04          CMPA   #$04
9DB9: 10 25 00 94    LBCS   $9E51
9DBD: 20 08          BRA    $9DC7
9DBF: 96 49          LDA    $49
9DC1: 81 04          CMPA   #$04
9DC3: 10 25 00 8A    LBCS   $9E51
9DC7: 16 FE E0       LBRA   $9CAA
9DCA: A6 06          LDA    $6,X
9DCC: 81 0E          CMPA   #$0E
9DCE: 26 06          BNE    $9DD6
9DD0: A6 0D          LDA    $D,X
9DD2: 81 02          CMPA   #$02
9DD4: 25 10          BCS    $9DE6
9DD6: 16 FE F1       LBRA   $9CCA
9DD9: A6 06          LDA    $6,X
9DDB: 81 0E          CMPA   #$0E
9DDD: 26 06          BNE    $9DE5
9DDF: A6 0D          LDA    $D,X
9DE1: 81 02          CMPA   #$02
9DE3: 25 17          BCS    $9DFC
9DE5: 39             RTS

9DE6: A6 04          LDA    $4,X
9DE8: 84 3F          ANDA   #$3F
9DEA: 80 02          SUBA   #$02
9DEC: 25 07          BCS    $9DF5
9DEE: EC 03          LDD    $3,X
9DF0: C3 00 3E       ADDD   #$003E
9DF3: 20 16          BRA    $9E0B
9DF5: EC 03          LDD    $3,X
9DF7: C3 00 7E       ADDD   #$007E
9DFA: 20 0F          BRA    $9E0B
9DFC: A6 04          LDA    $4,X
9DFE: 84 3F          ANDA   #$3F
9E00: 80 02          SUBA   #$02
9E02: 25 02          BCS    $9E06
9E04: 20 EF          BRA    $9DF5
9E06: EC 03          LDD    $3,X
9E08: C3 00 BE       ADDD   #$00BE
9E0B: ED 88 20       STD    $20,X
9E0E: 20 00          BRA    $9E10
9E10: 1F 12          TFR    X,Y
9E12: 31 A8 10       LEAY   $10,Y
9E15: 86 02          LDA    #$02
9E17: 97 48          STA    nb_objects_48
9E19: C6 09          LDB    #$09
9E1B: BD 8D 46       JSR    $8D46
9E1E: 0A 48          DEC    nb_objects_48
9E20: 26 F7          BNE    $9E19
9E22: BD 81 96       JSR    $8196
9E25: 20 4A          BRA    $9E71
9E27: A6 04          LDA    $4,X
9E29: 84 3F          ANDA   #$3F
9E2B: 80 02          SUBA   #$02
9E2D: 25 07          BCS    $9E36
9E2F: EC 03          LDD    $3,X
9E31: C3 00 3E       ADDD   #$003E
9E34: 20 16          BRA    $9E4C
9E36: EC 03          LDD    $3,X
9E38: C3 00 7E       ADDD   #$007E
9E3B: 20 0F          BRA    $9E4C
9E3D: A6 04          LDA    $4,X
9E3F: 84 3F          ANDA   #$3F
9E41: 80 02          SUBA   #$02
9E43: 25 02          BCS    $9E47
9E45: 20 EF          BRA    $9E36
9E47: EC 03          LDD    $3,X
9E49: C3 00 BE       ADDD   #$00BE
9E4C: ED 88 20       STD    $20,X
9E4F: 20 08          BRA    $9E59
9E51: EC 03          LDD    $3,X
9E53: C3 00 7E       ADDD   #$007E
9E56: ED 88 20       STD    $20,X
9E59: CC 00 02       LDD    #$0002
9E5C: ED 88 10       STD    $10,X
9E5F: ED 88 12       STD    $12,X
9E62: 86 01          LDA    #$01
9E64: A7 88 31       STA    $31,X
9E67: 6D 88 1C       TST    $1C,X
9E6A: 26 05          BNE    $9E71
9E6C: 86 02          LDA    #$02
9E6E: A7 88 1C       STA    $1C,X
9E71: 86 01          LDA    #$01
9E73: A7 88 29       STA    $29,X
9E76: A7 88 2F       STA    difficulty_2f,X
9E79: 6F 88 30       CLR    $30,X
9E7C: 39             RTS

9E7D: 6D 88 29       TST    $29,X
9E80: 27 4C          BEQ    $9ECE
9E82: 10 8E AF 08    LDY    #$AF08
9E86: A6 88 30       LDA    $30,X
9E89: C6 1E          LDB    #$1E
9E8B: 3D             MUL
9E8C: 31 AB          LEAY   D,Y
9E8E: EE 88 20       LDU    $20,X
9E91: 86 06          LDA    #$06
9E93: 97 50          STA    $50
9E95: C6 80          LDB    #$80
9E97: 86 05          LDA    #$05
9E99: 97 51          STA    $51
9E9B: E7 C9 08 00    STB    $0800,U     ; [video_address]
9E9F: A6 A0          LDA    ,Y+
9EA1: A7 C4          STA    ,U          ; [video_address]
9EA3: 33 C8 C0       LEAU   -$40,U
9EA6: 0A 51          DEC    $51
9EA8: 26 F1          BNE    $9E9B
9EAA: 33 C9 01 41    LEAU   $0141,U
9EAE: 34 04          PSHS   B
9EB0: 1F 30          TFR    U,D
9EB2: C5 3F          BITB   #$3F
9EB4: 26 03          BNE    $9EB9
9EB6: 33 C8 C0       LEAU   -$40,U
9EB9: 35 04          PULS   B
9EBB: 0A 50          DEC    $50
9EBD: 26 D8          BNE    $9E97
9EBF: 6C 88 30       INC    $30,X
9EC2: A6 88 30       LDA    $30,X
9EC5: 81 03          CMPA   #$03
9EC7: 27 06          BEQ    $9ECF
9EC9: 86 04          LDA    #$04
9ECB: A7 88 2F       STA    difficulty_2f,X
9ECE: 39             RTS

9ECF: 6F 88 29       CLR    $29,X
9ED2: 86 0A          LDA    #$0A
9ED4: BD 85 0E       JSR    $850E
9ED7: 39             RTS

9ED8: A6 84          LDA    ,X
9EDA: 26 07          BNE    $9EE3
9EDC: A6 98 03       LDA    [$03,X]		; [video_address]
9EDF: 81 50          CMPA   #$50
9EE1: 27 01          BEQ    $9EE4
9EE3: 39             RTS

9EE4: 86 01          LDA    #$01
9EE6: A7 84          STA    ,X
9EE8: 7E CE 26       JMP    $CE26
9EEB: CE 2A C0       LDU    #$2AC0
9EEE: 8C 28 A0       CMPX   #$28A0
9EF1: 27 03          BEQ    $9EF6
9EF3: 33 C8 20       LEAU   $20,U
9EF6: A6 02          LDA    $2,X
9EF8: A0 42          SUBA   $2,U
9EFA: 8B 03          ADDA   #$03
9EFC: 81 06          CMPA   #$06
9EFE: 24 60          BCC    $9F60
9F00: 6C 84          INC    ,X
9F02: 6C 88 33       INC    $33,X
9F05: 6C 88 34       INC    $34,X
9F08: B6 2A B8       LDA    $2AB8
9F0B: 26 08          BNE    $9F15
9F0D: 96 DF          LDA    $DF
9F0F: 84 01          ANDA   #$01
9F11: 4C             INCA
9F12: B7 2A B8       STA    $2AB8
9F15: A6 0A          LDA    $A,X
9F17: 26 02          BNE    $9F1B
9F19: 0F EA          CLR    display_chrono_ea		; stop chronometer
9F1B: CE 29 60       LDU    #player_1_final_time_2960
9F1E: 96 DF          LDA    $DF
9F20: C6 0C          LDB    #$0C
9F22: 3D             MUL
9F23: 33 CB          LEAU   D,U
9F25: BD 9F 61       JSR    store_player_final_time_9f61
9F28: 34 10          PSHS   X
9F2A: 1F 31          TFR    U,X
9F2C: BD 88 CD       JSR    $88CD
9F2F: 35 10          PULS   X
9F31: 96 22          LDA    $22
9F33: 27 2B          BEQ    $9F60
9F35: 86 06          LDA    #$06
9F37: BD 84 F5       JSR    queue_event_84f5
9F3A: 96 DF          LDA    $DF
9F3C: 44             LSRA
9F3D: 24 15          BCC    $9F54
9F3F: BD 8F B8       JSR    $8FB8
9F42: 96 A0          LDA    $A0
9F44: 81 03          CMPA   #$03
9F46: 24 0F          BCC    $9F57
9F48: 7C 2A BD       INC    $2ABD
9F4B: 0A DF          DEC    $DF
9F4D: BD 8F 4B       JSR    $8F4B
9F50: 0C DF          INC    $DF
9F52: 20 03          BRA    $9F57
9F54: BD 8F 1E       JSR    $8F1E
9F57: BD 8E BC       JSR    $8EBC
9F5A: BD 8E CC       JSR    $8ECC
9F5D: BD 8E F0       JSR    $8EF0
9F60: 39             RTS

; for 1P U=2960, 2P CPU U=296C
store_player_final_time_9f61:
9F61: 10 8E 28 7E    LDY    #chrono_hundredth_second_287e
9F65: A6 21          LDA    $1,Y
9F67: 44             LSRA
9F68: 44             LSRA
9F69: 44             LSRA
9F6A: 44             LSRA
9F6B: A7 C4          STA    ,U
9F6D: A6 21          LDA    $1,Y
9F6F: 84 0F          ANDA   #$0F
9F71: A7 41          STA    $1,U
9F73: A6 A4          LDA    ,Y
9F75: 44             LSRA
9F76: 44             LSRA
9F77: 44             LSRA
9F78: 44             LSRA
9F79: A7 42          STA    $2,U
9F7B: A6 A4          LDA    ,Y
9F7D: 84 0F          ANDA   #$0F
9F7F: A7 43          STA    $3,U
9F81: 39             RTS

9F82: A6 88 34       LDA    $34,X
9F85: 27 45          BEQ    $9FCC
9F87: 10 8E AF 71    LDY    #$AF71
9F8B: 96 84          LDA    current_level_84
9F8D: 81 00          CMPA   #$00
9F8F: 27 0D          BEQ    $9F9E
9F91: CE 37 1F       LDU    #$371F
9F94: 8C 28 A0       CMPX   #$28A0
9F97: 27 10          BEQ    $9FA9
9F99: CE 35 9F       LDU    #$359F
9F9C: 20 0B          BRA    $9FA9
9F9E: CE 37 24       LDU    #$3724
9FA1: 8C 28 A0       CMPX   #$28A0
9FA4: 27 03          BEQ    $9FA9
9FA6: CE 35 A4       LDU    #$35A4
9FA9: 86 03          LDA    #$03
9FAB: 97 48          STA    nb_objects_48
9FAD: 86 05          LDA    #$05
9FAF: 97 49          STA    $49
9FB1: C6 80          LDB    #$80
9FB3: D8 73          EORB   $73
9FB5: A6 A0          LDA    ,Y+
9FB7: E7 C9 08 00    STB    $0800,U     ; [video_address]
9FBB: A7 C4          STA    ,U          ; [video_address]
9FBD: 33 C8 C0       LEAU   -$40,U
9FC0: 0A 49          DEC    $49
9FC2: 26 F1          BNE    $9FB5
9FC4: 33 C9 01 41    LEAU   $0141,U
9FC8: 0A 48          DEC    nb_objects_48
9FCA: 26 E1          BNE    $9FAD
9FCC: 39             RTS

9FCD: 96 FA          LDA    $FA
9FCF: 97 DF          STA    $DF
9FD1: 96 C3          LDA    $C3
9FD3: 97 C6          STA    $C6
9FD5: DC C4          LDD    $C4
9FD7: DD C7          STD    $C7
9FD9: BD 88 C8       JSR    $88C8
9FDC: 8E 28 A0       LDX    #$28A0
9FDF: 0F C3          CLR    $C3
9FE1: DC AB          LDD    $AB
9FE3: B3 2A 0B       SUBD   $2A0B
9FE6: 24 0C          BCC    $9FF4
9FE8: 0C C3          INC    $C3
9FEA: 0C DF          INC    $DF
9FEC: 8E 2A 00       LDX    #$2A00
9FEF: FC 2A 0B       LDD    $2A0B
9FF2: 93 AB          SUBD   $AB
9FF4: DD C4          STD    $C4
9FF6: A6 88 33       LDA    $33,X
9FF9: 26 22          BNE    $A01D
9FFB: D6 C3          LDB    $C3
9FFD: D1 C6          CMPB   $C6
9FFF: 27 19          BEQ    $A01A
A001: 86 70          LDA    #$70
A003: A0 02          SUBA   $2,X
A005: 27 13          BEQ    $A01A
A007: 97 51          STA    $51
A009: 97 52          STA    $52
A00B: 86 70          LDA    #$70
A00D: A7 02          STA    $2,X
A00F: BD A1 BE       JSR    $A1BE
A012: A6 88 3A       LDA    $3A,X
A015: 90 52          SUBA   $52
A017: A7 88 3A       STA    $3A,X
A01A: BD A1 31       JSR    $A131
A01D: 8E 28 A0       LDX    #$28A0
A020: 96 FA          LDA    $FA
A022: 97 DF          STA    $DF
A024: BD 88 C8       JSR    $88C8
A027: 0D C3          TST    $C3
A029: 26 05          BNE    $A030
A02B: 0C DF          INC    $DF
A02D: 8E 2A 00       LDX    #$2A00
A030: A6 88 33       LDA    $33,X
A033: 27 03          BEQ    $A038
A035: 7E 96 4F       JMP    $964F
A038: 96 C3          LDA    $C3
A03A: 91 C6          CMPA   $C6
A03C: 27 0D          BEQ    $A04B
A03E: BD A1 31       JSR    $A131
A041: 96 C5          LDA    $C5
A043: 97 4C          STA    $4C
A045: BD A0 E4       JSR    $A0E4
A048: 7E 96 4F       JMP    $964F
A04B: DC C4          LDD    $C4
A04D: 83 00 60       SUBD   #$0060
A050: 24 6B          BCC    $A0BD
A052: 0D CC          TST    $CC
A054: 27 1F          BEQ    $A075
A056: 0F CC          CLR    $CC
A058: 86 60          LDA    #$60
A05A: 90 C5          SUBA   $C5
A05C: 97 51          STA    $51
A05E: A6 88 3A       LDA    $3A,X
A061: 90 51          SUBA   $51
A063: A7 88 3A       STA    $3A,X
A066: A6 02          LDA    $2,X
A068: 9B 51          ADDA   $51
A06A: A7 02          STA    $2,X
A06C: BD A1 31       JSR    $A131
A06F: BD A1 BE       JSR    $A1BE
A072: 7E 96 4F       JMP    $964F
A075: 0F 4D          CLR    $4D
A077: DC C4          LDD    $C4
A079: 93 C7          SUBD   $C7
A07B: 24 06          BCC    $A083
A07D: 0C 4D          INC    $4D
A07F: DC C7          LDD    $C7
A081: 93 C4          SUBD   $C4
A083: D7 4C          STB    $4C
A085: 0D 4D          TST    $4D
A087: 27 2B          BEQ    $A0B4
A089: A6 88 3A       LDA    $3A,X
A08C: 97 51          STA    $51
A08E: AB 02          ADDA   $2,X
A090: A7 02          STA    $2,X
A092: BD A1 BE       JSR    $A1BE
A095: 96 D3          LDA    $D3
A097: 8C 2A 00       CMPX   #$2A00
A09A: 27 03          BEQ    $A09F
A09C: B6 2A 33       LDA    $2A33
A09F: 4D             TSTA
A0A0: 26 0F          BNE    $A0B1
A0A2: 96 DA          LDA    $DA
A0A4: 8C 2A 00       CMPX   #$2A00
A0A7: 27 03          BEQ    $A0AC
A0A9: B6 2A 3A       LDA    $2A3A
A0AC: 97 4C          STA    $4C
A0AE: BD A0 E4       JSR    $A0E4
A0B1: 7E 96 4F       JMP    $964F
A0B4: BD A1 31       JSR    $A131
A0B7: BD A0 D8       JSR    $A0D8
A0BA: 7E 96 4F       JMP    $964F
A0BD: 0D CC          TST    $CC
A0BF: 26 11          BNE    $A0D2
A0C1: 0C CC          INC    $CC
A0C3: A6 02          LDA    $2,X
A0C5: 80 10          SUBA   #$10
A0C7: 97 4C          STA    $4C
A0C9: BD A1 31       JSR    $A131
A0CC: BD A0 E4       JSR    $A0E4
A0CF: 7E 96 4F       JMP    $964F
A0D2: BD A1 31       JSR    $A131
A0D5: 7E 96 4F       JMP    $964F
A0D8: 96 C5          LDA    $C5
A0DA: 90 C8          SUBA   $C8
A0DC: 24 01          BCC    $A0DF
A0DE: 40             NEGA
A0DF: 97 4C          STA    $4C
A0E1: 7E A0 E4       JMP    $A0E4
A0E4: 0D 4C          TST    $4C
A0E6: 27 39          BEQ    $A121
A0E8: A6 02          LDA    $2,X
A0EA: 90 4C          SUBA   $4C
A0EC: A7 02          STA    $2,X
A0EE: BD CE 53       JSR    $CE53
A0F1: BD D1 D4       JSR    $D1D4
A0F4: 96 4C          LDA    $4C
A0F6: 97 53          STA    $53
A0F8: 8C 28 A0       CMPX   #$28A0
A0FB: 26 05          BNE    $A102
A0FD: BD 9A D1       JSR    $9AD1
A100: 20 03          BRA    $A105
A102: BD 9A E2       JSR    $9AE2
A105: 0A 53          DEC    $53
A107: 26 EF          BNE    $A0F8
A109: 10 8E 2A F5    LDY    #$2AF5
A10D: 96 DF          LDA    $DF
A10F: 84 01          ANDA   #$01
A111: 26 02          BNE    $A115
A113: 31 26          LEAY   $6,Y
A115: 6C A0          INC    ,Y+
A117: 6C 88 3E       INC    $3E,X
A11A: BD A1 22       JSR    $A122
A11D: 0A 4C          DEC    $4C
A11F: 26 E8          BNE    $A109
A121: 39             RTS

A122: 96 DF          LDA    $DF
A124: 84 01          ANDA   #$01
A126: 26 03          BNE    $A12B
A128: 7E 96 22       JMP    $9622
A12B: BD 9A 82       JSR    $9A82
A12E: 7E 96 38       JMP    $9638
A131: A6 88 1C       LDA    $1C,X
A134: 81 02          CMPA   #$02
A136: 27 28          BEQ    $A160
A138: 81 01          CMPA   #$01
A13A: 27 0B          BEQ    $A147
A13C: A6 88 3A       LDA    $3A,X
A13F: 0F 4B          CLR    $4B
A141: A7 88 15       STA    $15,X
A144: 7E 9B 9C       JMP    $9B9C
A147: A6 88 3A       LDA    $3A,X
A14A: 6D 88 33       TST    $33,X
A14D: 26 0A          BNE    $A159
A14F: 97 49          STA    $49
A151: 27 03          BEQ    $A156
A153: BD 9B F1       JSR    $9BF1
A156: 7E CD 87       JMP    $CD87
A159: AB 02          ADDA   $2,X
A15B: A7 02          STA    $2,X
A15D: 7E CD 87       JMP    $CD87
A160: A6 88 31       LDA    $31,X
A163: 81 02          CMPA   #$02
A165: 27 2B          BEQ    $A192
A167: BD CE 42       JSR    $CE42
A16A: A6 88 2A       LDA    $2A,X
A16D: 26 22          BNE    $A191
A16F: 6C 88 32       INC    $32,X
A172: A6 88 32       LDA    $32,X
A175: 81 03          CMPA   #$03
A177: 26 13          BNE    $A18C
A179: 6C 88 31       INC    $31,X
A17C: 6F 88 10       CLR    $10,X
A17F: 86 02          LDA    #$02
A181: A7 88 11       STA    $11,X
A184: BD 81 96       JSR    $8196
A187: 86 10          LDA    #$10
A189: A7 88 2B       STA    $2B,X
A18C: 86 10          LDA    #$10
A18E: A7 88 2A       STA    $2A,X
A191: 39             RTS

A192: A6 88 3A       LDA    $3A,X
A195: 27 05          BEQ    $A19C
A197: 97 49          STA    $49
A199: BD 9B F1       JSR    $9BF1
A19C: A6 88 32       LDA    $32,X
A19F: 81 06          CMPA   #$06
A1A1: 27 11          BEQ    $A1B4
A1A3: BD CE 42       JSR    $CE42
A1A6: 6A 88 2B       DEC    $2B,X
A1A9: 26 08          BNE    $A1B3
A1AB: 6C 88 32       INC    $32,X
A1AE: 86 10          LDA    #$10
A1B0: A7 88 2B       STA    $2B,X
A1B3: 39             RTS

A1B4: 6F 88 1C       CLR    $1C,X
A1B7: 6F 88 31       CLR    $31,X
A1BA: 6F 88 32       CLR    $32,X
A1BD: 39             RTS

A1BE: A6 88 1C       LDA    $1C,X
A1C1: 81 02          CMPA   #$02
A1C3: 27 25          BEQ    $A1EA
A1C5: 81 01          CMPA   #$01
A1C7: 27 1E          BEQ    $A1E7
A1C9: A6 84          LDA    ,X
A1CB: 81 02          CMPA   #$02
A1CD: 25 12          BCS    $A1E1
A1CF: 96 51          LDA    $51
A1D1: A7 88 15       STA    $15,X
A1D4: 27 08          BEQ    $A1DE
A1D6: BD CB 3B       JSR    $CB3B
A1D9: 0A 51          DEC    $51
A1DB: 26 F9          BNE    $A1D6
A1DD: 39             RTS

A1DE: 7E CB 3B       JMP    $CB3B
A1E1: BD CE 53       JSR    $CE53
A1E4: 7E D1 D4       JMP    $D1D4
A1E7: 7E CD 87       JMP    $CD87
A1EA: A6 88 31       LDA    $31,X
A1ED: 81 02          CMPA   #$02
A1EF: 27 01          BEQ    $A1F2
A1F1: 39             RTS

A1F2: A6 88 2A       LDA    $2A,X
A1F5: 26 FA          BNE    $A1F1
A1F7: 7E A1 9C       JMP    $A19C
A1FA: 96 D0          LDA    $D0
A1FC: 84 0C          ANDA   #$0C
A1FE: 44             LSRA
A1FF: 44             LSRA
A200: 4C             INCA
A201: 84 03          ANDA   #$03
A203: B7 2A 19       STA    $2A19
A206: 96 D0          LDA    $D0
A208: 8B 04          ADDA   #$04
A20A: 84 07          ANDA   #$07
A20C: 48             ASLA
A20D: D6 D7          LDB    $D7
A20F: C1 FF          CMPB   #$FF
A211: 27 07          BEQ    $A21A
A213: 54             LSRB
A214: 5C             INCB
A215: E1 05          CMPB   $5,X
A217: 22 01          BHI    $A21A
A219: 4C             INCA
A21A: CE AA DD       LDU    #$AADD
A21D: A6 C6          LDA    A,U
A21F: B7 2A 18       STA    $2A18
A222: 96 D0          LDA    $D0
A224: 8B 04          ADDA   #$04
A226: 84 0F          ANDA   #$0F
A228: 48             ASLA
A229: D6 D7          LDB    $D7
A22B: C1 FF          CMPB   #$FF
A22D: 27 07          BEQ    $A236
A22F: 54             LSRB
A230: 5C             INCB
A231: E1 05          CMPB   $5,X
A233: 22 01          BHI    $A236
A235: 4C             INCA
A236: B7 2A 1A       STA    $2A1A
A239: 8E AB ED       LDX    #$ABED
A23C: B6 2A 1A       LDA    $2A1A
A23F: 48             ASLA
A240: 48             ASLA
A241: 30 86          LEAX   A,X
A243: EC 84          LDD    ,X
A245: B7 2A 21       STA    $2A21
A248: F7 2A 23       STB    $2A23
A24B: 7F 2A 20       CLR    $2A20
A24E: 7F 2A 22       CLR    $2A22
A251: EC 02          LDD    $2,X
A253: FD 2A 25       STD    $2A25
A256: 39             RTS

A257: 10 8E ED 7B    LDY    #$ED7B
A25B: A6 88 18       LDA    $18,X
A25E: A6 A6          LDA    A,Y
A260: E6 88 1D       LDB    $1D,X
A263: 3D             MUL
A264: 44             LSRA
A265: 56             RORB
A266: 44             LSRA
A267: 56             RORB
A268: 44             LSRA
A269: 56             RORB
A26A: 44             LSRA
A26B: 56             RORB
A26C: 44             LSRA
A26D: 56             RORB
A26E: D7 4D          STB    $4D
A270: A6 88 1E       LDA    $1E,X
A273: E6 88 19       LDB    $19,X
A276: C4 02          ANDB   #$02
A278: 27 04          BEQ    $A27E
A27A: 90 4D          SUBA   $4D
A27C: 20 02          BRA    $A280
A27E: 9B 4D          ADDA   $4D
A280: A7 01          STA    $1,X
A282: 10 8E ED D5    LDY    #$EDD5
A286: A6 88 18       LDA    $18,X
A289: 40             NEGA
A28A: A6 A6          LDA    A,Y
A28C: E6 88 1D       LDB    $1D,X
A28F: 3D             MUL
A290: 44             LSRA
A291: 56             RORB
A292: 44             LSRA
A293: 56             RORB
A294: 44             LSRA
A295: 56             RORB
A296: 44             LSRA
A297: 56             RORB
A298: 44             LSRA
A299: 56             RORB
A29A: D7 4D          STB    $4D
A29C: A6 88 1F       LDA    $1F,X
A29F: E6 88 19       LDB    $19,X
A2A2: 27 08          BEQ    $A2AC
A2A4: C1 03          CMPB   #$03
A2A6: 27 04          BEQ    $A2AC
A2A8: 90 4D          SUBA   $4D
A2AA: 20 02          BRA    $A2AE
A2AC: 9B 4D          ADDA   $4D
A2AE: A7 02          STA    $2,X
A2B0: 39             RTS

A2B1: 4F             CLRA
A2B2: E6 02          LDB    $2,X
A2B4: 10 83 00 98    CMPD   #$0098
A2B8: 10 24 00 F9    LBCC   $A3B5
A2BC: 10 A3 88 22    CMPD   $22,X
A2C0: 23 1C          BLS    $A2DE
A2C2: E6 01          LDB    $1,X
A2C4: A6 88 1A       LDA    $1A,X
A2C7: 81 10          CMPA   #$10
A2C9: 23 0B          BLS    $A2D6
A2CB: 4F             CLRA
A2CC: 10 A3 88 20    CMPD   $20,X
A2D0: 10 23 00 92    LBLS   $A366
A2D4: 20 07          BRA    $A2DD
A2D6: 4F             CLRA
A2D7: 10 A3 88 20    CMPD   $20,X
A2DB: 24 6B          BCC    $A348
A2DD: 39             RTS

A2DE: A6 88 23       LDA    number_of_credits_23,X
A2E1: A7 02          STA    $2,X
A2E3: E6 01          LDB    $1,X
A2E5: A6 88 1A       LDA    $1A,X
A2E8: 81 10          CMPA   #$10
A2EA: 23 09          BLS    $A2F5
A2EC: 4F             CLRA
A2ED: 10 A3 88 20    CMPD   $20,X
A2F1: 23 0B          BLS    $A2FE
A2F3: 20 0E          BRA    $A303
A2F5: 4F             CLRA
A2F6: 10 A3 88 20    CMPD   $20,X
A2FA: 24 02          BCC    $A2FE
A2FC: 20 05          BRA    $A303
A2FE: A6 88 21       LDA    $21,X
A301: A7 01          STA    $1,X
A303: 86 28          LDA    #$28
A305: 4C             INCA
A306: B7 2A C2       STA    $2AC2
A309: 7C 2A C0       INC    $2AC0
A30C: 86 68          LDA    #$68
A30E: B0 2A 25       SUBA   $2A25
A311: A1 01          CMPA   $1,X
A313: 25 13          BCS    $A328
A315: 86 28          LDA    #$28
A317: B0 2A 25       SUBA   $2A25
A31A: A1 01          CMPA   $1,X
A31C: 24 1A          BCC    $A338
A31E: A6 01          LDA    $1,X
A320: BB 2A 25       ADDA   $2A25
A323: B7 2A C1       STA    $2AC1
A326: 20 75          BRA    $A39D
A328: 86 68          LDA    #$68
A32A: B7 2A C1       STA    $2AC1
A32D: CC 78 38       LDD    #$7838
A330: FD 2A E1       STD    $2AE1
A333: 7C 2A E0       INC    $2AE0
A336: 20 65          BRA    $A39D
A338: 86 28          LDA    #$28
A33A: B7 2A C1       STA    $2AC1
A33D: CC 18 38       LDD    #$1838
A340: FD 2B 01       STD    $2B01
A343: 7C 2B 00       INC    $2B00
A346: 20 55          BRA    $A39D
A348: A6 88 21       LDA    $21,X
A34B: A7 01          STA    $1,X
A34D: 86 78          LDA    #$78
A34F: B7 2A E1       STA    $2AE1
A352: 7C 2A E0       INC    $2AE0
A355: 86 38          LDA    #$38
A357: B0 2A 26       SUBA   $2A26
A35A: A1 02          CMPA   $2,X
A35C: 24 26          BCC    $A384
A35E: BD A3 AF       JSR    $A3AF
A361: B7 2A E2       STA    $2AE2
A364: 20 37          BRA    $A39D
A366: A6 88 21       LDA    $21,X
A369: A7 01          STA    $1,X
A36B: 86 18          LDA    #$18
A36D: B7 2B 01       STA    $2B01
A370: 7C 2B 00       INC    $2B00
A373: 86 38          LDA    #$38
A375: B0 2A 26       SUBA   $2A26
A378: A1 02          CMPA   $2,X
A37A: 24 12          BCC    $A38E
A37C: BD A3 AF       JSR    $A3AF
A37F: B7 2B 02       STA    $2B02
A382: 20 19          BRA    $A39D
A384: 86 38          LDA    #$38
A386: B7 2A E2       STA    $2AE2
A389: CC 68 28       LDD    #$6828
A38C: 20 08          BRA    $A396
A38E: 86 38          LDA    #$38
A390: B7 2B 02       STA    $2B02
A393: CC 28 28       LDD    #$2828
A396: 5C             INCB
A397: FD 2A C1       STD    $2AC1
A39A: 7C 2A C0       INC    $2AC0
A39D: BD CC 6B       JSR    $CC6B
A3A0: BD A3 DA       JSR    $A3DA
A3A3: 86 08          LDA    #$08
A3A5: BD 85 0E       JSR    $850E
A3A8: 86 30          LDA    #$30
A3AA: 97 0B          STA    $0B
A3AC: 0C 09          INC    $09
A3AE: 39             RTS

A3AF: A6 02          LDA    $2,X
A3B1: BB 2A 26       ADDA   $2A26
A3B4: 39             RTS

A3B5: 96 BD          LDA    $BD
A3B7: 44             LSRA
A3B8: 44             LSRA
A3B9: 97 48          STA    nb_objects_48
A3BB: CC 5C 14       LDD    #$5C14
A3BE: DB 48          ADDB   nb_objects_48
A3C0: ED 88 1E       STD    $1E,X
A3C3: ED 0B          STD    $B,X
A3C5: FD 2A 41       STD    $2A41
A3C8: 6F 88 1D       CLR    $1D,X
A3CB: 8E 28 A0       LDX    #$28A0
A3CE: 6F 01          CLR    $1,X
A3D0: 6F 02          CLR    $2,X
A3D2: BD CB 35       JSR    $CB35
A3D5: 0C 06          INC    $06
A3D7: 0F 09          CLR    $09
A3D9: 39             RTS

A3DA: 86 01          LDA    #$01
A3DC: B7 2A C5       STA    $2AC5
A3DF: B7 2A E5       STA    $2AE5
A3E2: B7 2B 05       STA    $2B05
A3E5: CC DE A4       LDD    #$DEA4
A3E8: FD 2A CE       STD    $2ACE
A3EB: CC DE 9D       LDD    #$DE9D
A3EE: FD 2A EE       STD    $2AEE
A3F1: CC DE AB       LDD    #$DEAB
A3F4: FD 2B 0E       STD    $2B0E
A3F7: 39             RTS

A3F8: CE 37 00       LDU    #$3700
A3FB: E6 A0          LDB    ,Y+
A3FD: D8 73          EORB   $73
A3FF: D7 89          STB    $89
A401: 86 10          LDA    #$10
A403: 97 48          STA    nb_objects_48
A405: E7 C9 08 00    STB    $0800,U      ; [video_address]
A409: A6 A0          LDA    ,Y+
A40B: A7 C4          STA    ,U           ; [video_address]
A40D: 33 C8 C0       LEAU   -$40,U
A410: 0A 48          DEC    nb_objects_48
A412: 26 F1          BNE    $A405
A414: 33 C9 04 01    LEAU   $0401,U
A418: 11 83 37 20    CMPU   #$3720
A41C: 26 E3          BNE    $A401
A41E: 39             RTS

event_table_a41f:
	dc.w	reset_display_617f	; $a41f
	dc.w	$61c0	; $a421
	dc.w	write_copyright_text_61c3	; $a423
	dc.w	$61f9	; $a425
	dc.w	$6482	; $a427
	dc.w	$62ad	; $a429
	dc.w	$62d2	; $a42b
	dc.w	draw_chrono_63c6	; $a42d
	dc.w	$641a	; $a42f
	dc.w	update_speed_bar_64d9	; $a431
	dc.w	$654c	; $a433
	dc.w	$654d	; $a435
	dc.w	$65ba	; $a437
	dc.w	$65dc	; $a439
	
main_jump_table_a869:
	dc.w	boot_670e	; $a869
	dc.w	rolling_demo_6726	; $a86b
	dc.w	push_start_screen_67ac	; $a86d
	dc.w	running_game_691b	; $a86f
	dc.w	high_scores_effb	; $a871
boot_table_a873:
	dc.w	$6716	; $a873
	dc.w	$671d	; $a875
table_a877:
	dc.w	$fbb6	; $a877
	dc.w	$75ef	; $a879
	dc.w	high_scores_effb	; $a87b
table_a87d:
	dc.w	$67b4	; $a87d
	dc.w	$f6fa	; $a87f
table_a881:
	dc.w	$68b9	; $a881
	dc.w	$68f3	; $a883
	dc.w	$6903	; $a885
table_a887:
	dc.w	$6924	; $a887
	dc.w	$6a70	; $a889
	dc.w	$6e4f	; $a88b
	dc.w	player_turn_ends_6e75	; $a88d
	dc.w	$7225	; $a88f
	dc.w	$72eb	; $a891
table_a893:
	dc.w	$692d	; $a893
	dc.w	$69cd	; $a895
table_a897:
	dc.w	setup_players_screen_6936	; $a897
	dc.w	$695f	; $a899
	dc.w	$69a0	; $a89b
	
table_a8a2:
	dc.w	$6a7c	; $a8a2
	dc.w	$6de4	; $a8a4
table_a8a6:
	dc.w	init_game_playfield_6a85	; $a8a6
	dc.w	$6b4b	; $a8a8
	dc.w	$6c65	; $a8aa
	dc.w	$6d2c	; $a8ac
	dc.w	$6dc9	; $a8ae
table_a8c0:
	dc.w	$6df3	; $a8c0
	dc.w	$6e0b	; $a8c2
table_a8c4:
	dc.w	$76b7	; $a8c4
	dc.w	$7c38	; $a8c6
	dc.w	$e649	; $a8c8
	dc.w	$7fc2	; $a8ca
	dc.w	$81e2	; $a8cc
	dc.w	$e282	; $a8ce
table_a8d0:
	dc.w	$6e88	; $a8d0
	dc.w	$6fbc	; $a8d2
	dc.w	$7151	; $a8d4
table_a8d6:
	dc.w	$722d	; $a8d6
	dc.w	$728f	; $a8d8
table_a8da:
	dc.w	$72f3	; $a8da
	dc.w	$7467	; $a8dc
	dc.w	$d59d	; $a8de
	dc.w	display_champion_message_f435	; $a8e0
	dc.w	$7550	; $a8e2
	dc.w	$757d	; $a8e4
	dc.w	$dadf	; $a8e6
table_a8e8:
	dc.w	$72fb	; $a8e8
	dc.w	$7339	; $a8ea
	dc.w	$7370	; $a8ec
	dc.w	$73b4	; $a8ee
	dc.w	$7339	; $a8f0
	dc.w	$73e6	; $a8f2
	dc.w	$7339	; $a8f4
	dc.w	$7423	; $a8f6
table_a8f8:
	dc.w	$746f	; $a8f8
	dc.w	$74a9	; $a8fa
	dc.w	$751d	; $a8fc
table_a8fe:
	dc.w	$7477	; $a8fe
	dc.w	$748b	; $a900
	dc.w	$7493	; $a902
	dc.w	$749b	; $a904
table_a906:
	dc.w	$75f7	; $a906
	dc.w	$766d	; $a908
	dc.w	$7684	; $a90a
table_a90c:
	dc.w	$6924	; $a90c
	dc.w	$6a70	; $a90e
	dc.w	$6e4f	; $a910
	dc.w	player_turn_ends_6e75	; $a912
	dc.w	$7225	; $a914
table_a916:
	dc.w	$76c6	; $a916
	dc.w	$7a80	; $a918
	dc.w	$7bcf	; $a91a
table_a91c:
	dc.w	$76d2	; $a91c
	dc.w	$7756	; $a91e
	dc.w	$77ac	; $a920
	dc.w	$77cd	; $a922
	dc.w	$77e2	; $a924
	dc.w	$7803	; $a926
	dc.w	$7938	; $a928
	dc.w	$79ea	; $a92a
table_a92c:
	dc.w	$79f2	; $a92c
	dc.w	$7a17	; $a92e
table_a930:
	dc.w	$7b06	; $a930
	dc.w	$7b06	; $a932
	dc.w	$7b6e	; $a934
	dc.w	$7b8a	; $a936
	dc.w	$7bb2	; $a938
	dc.w	$7bc0	; $a93a
table_a93c:
	dc.w	$7c41	; $a93c
	dc.w	$7cb3	; $a93e
	dc.w	$7d0c	; $a940
	dc.w	$7d3f	; $a942
	dc.w	$7dff	; $a944
	dc.w	$7e0b	; $a946
	dc.w	$7f12	; $a948
	dc.w	$7f9a	; $a94a
table_a94c:
	dc.w	$7c4a	; $a94c
	dc.w	$7ca0	; $a94e
table_a950:
	dc.w	$7e17	; $a950
	dc.w	$7e2b	; $a952
	dc.w	$7e50	; $a954
	dc.w	$7e62	; $a956
	dc.w	$7efd	; $a958
	dc.w	$7f07	; $a95a
table_a95c:
	dc.w	$7f1e	; $a95c
	dc.w	$7f32	; $a95e
	dc.w	$7f3f	; $a960
	dc.w	$7f5c	; $a962
	dc.w	$7f8f	; $a964
table_a966:
	dc.w	$76c6	; $a966
	dc.w	$7fd1	; $a968
	dc.w	$7bcf	; $a96a
table_a96c:
	dc.w	$7b06	; $a96c
	dc.w	$7b06	; $a96e
	dc.w	$805f	; $a970
	dc.w	$7b8a	; $a972
	dc.w	$7bb2	; $a974
	dc.w	$7bc0	; $a976
table_a978:
	dc.w	$81eb	; $a978
	dc.w	$8261	; $a97a
	dc.w	$8283	; $a97c
	dc.w	$832e	; $a97e
	dc.w	$8383	; $a980
	dc.w	$8491	; $a982
	dc.w	$84e7	; $a984
table_a986:
	dc.w	$81f3	; $a986
	dc.w	$824a	; $a988
table_a993:
	dc.w	$8337	; $a993
	dc.w	$834d	; $a995
table_a997:
	dc.w	$838c	; $a997
	dc.w	$83a0	; $a999
	dc.w	$83dc	; $a99b
table_a99d:
	dc.w	$849a	; $a99d
	dc.w	$84dc	; $a99f
	
CAF5: A6 88 1D       LDA    $1D,X
CAF8: 5F             CLRB
CAF9: 80 0B          SUBA   #$0B
CAFB: 25 07          BCS    $CB04
CAFD: 5C             INCB
CAFE: C1 05          CMPB   #$05
CB00: 24 02          BCC    $CB04
CB02: 20 F5          BRA    $CAF9
CB04: CE DD 10       LDU    #$DD10
CB07: 86 04          LDA    #$04
CB09: 3D             MUL
CB0A: 33 CB          LEAU   D,U
CB0C: 1F 30          TFR    U,D
CB0E: 7E CD 6B       JMP    $CD6B
CB11: CC DD 28       LDD    #$DD28
CB14: 7E CD 6B       JMP    $CD6B
CB17: CC DC B2       LDD    #$DCB2
CB1A: 7E CD 6B       JMP    $CD6B
CB1D: CC DD 0C       LDD    #$DD0C
CB20: 7E CD 6B       JMP    $CD6B
CB23: CC DE B2       LDD    #$DEB2
CB26: 7E CD 6B       JMP    $CD6B
CB29: CC DD 87       LDD    #$DD87
CB2C: 7E CD 6B       JMP    $CD6B
CB2F: CC DE BD       LDD    #$DEBD
CB32: 7E CD 6B       JMP    $CD6B
CB35: CC DD D6       LDD    #$DDD6
CB38: 7E CD 6B       JMP    $CD6B
CB3B: A6 84          LDA    ,X
CB3D: 81 01          CMPA   #$01
CB3F: 27 3B          BEQ    $CB7C
CB41: A6 88 15       LDA    $15,X
CB44: 27 30          BEQ    $CB76
CB46: 96 4B          LDA    $4B
CB48: 27 05          BEQ    $CB4F
CB4A: 6A 88 15       DEC    $15,X
CB4D: 27 27          BEQ    $CB76
CB4F: 6A 88 17       DEC    $17,X
CB52: 26 22          BNE    $CB76
CB54: 10 AE 0E       LDY    $E,X
CB57: 31 24          LEAY   $4,Y
CB59: A6 A4          LDA    ,Y
CB5B: 81 FF          CMPA   #$FF
CB5D: 26 03          BNE    $CB62
CB5F: 10 AE 21       LDY    $1,Y
CB62: 10 AF 0E       STY    $E,X
CB65: A6 A4          LDA    ,Y
CB67: 81 09          CMPA   #$09
CB69: 26 05          BNE    $CB70
CB6B: 86 01          LDA    #$01
CB6D: BD 85 0E       JSR    $850E
CB70: A6 88 16       LDA    $16,X
CB73: A7 88 17       STA    $17,X
CB76: BD CE 53       JSR    $CE53
CB79: 7E CE C4       JMP    $CEC4
CB7C: 10 8E DC B6    LDY    #$DCB6
CB80: 20 F4          BRA    $CB76
CB82: BD CE 53       JSR    $CE53
CB85: A6 05          LDA    $5,X
CB87: 27 04          BEQ    $CB8D
CB89: 6A 05          DEC    $5,X
CB8B: 20 15          BRA    $CBA2
CB8D: 10 AE 0E       LDY    $E,X
CB90: 31 24          LEAY   $4,Y
CB92: A6 A4          LDA    ,Y
CB94: 81 FF          CMPA   #$FF
CB96: 26 03          BNE    $CB9B
CB98: 10 AE 21       LDY    $1,Y
CB9B: 86 06          LDA    #$06
CB9D: A7 05          STA    $5,X
CB9F: 10 AF 0E       STY    $E,X
CBA2: 7E CE C4       JMP    $CEC4
CBA5: A6 05          LDA    $5,X
CBA7: 27 04          BEQ    $CBAD
CBA9: 6A 05          DEC    $5,X
CBAB: 20 15          BRA    $CBC2
CBAD: 10 AE 0E       LDY    $E,X
CBB0: 31 24          LEAY   $4,Y
CBB2: A6 A4          LDA    ,Y
CBB4: 81 FF          CMPA   #$FF
CBB6: 26 03          BNE    $CBBB
CBB8: 10 AE 21       LDY    $1,Y
CBBB: 86 0A          LDA    #$0A
CBBD: A7 05          STA    $5,X
CBBF: 10 AF 0E       STY    $E,X
CBC2: 7E D2 96       JMP    $D296
CBC5: A6 05          LDA    $5,X
CBC7: 27 04          BEQ    $CBCD
CBC9: 6A 05          DEC    $5,X
CBCB: 20 5A          BRA    $CC27
CBCD: EE 0E          LDU    $E,X
CBCF: 33 48          LEAU   $8,U
CBD1: A6 C4          LDA    ,U
CBD3: 81 FF          CMPA   #$FF
CBD5: 26 0E          BNE    $CBE5
CBD7: EE 41          LDU    $1,U
CBD9: 0C D3          INC    $D3
CBDB: 0A D7          DEC    $D7
CBDD: 96 D7          LDA    $D7
CBDF: 81 FF          CMPA   #$FF
CBE1: 26 02          BNE    $CBE5
CBE3: 0F D7          CLR    $D7
CBE5: EF 0E          STU    $E,X
CBE7: 96 D7          LDA    $D7
CBE9: A7 05          STA    $5,X
CBEB: 0C D0          INC    $D0
CBED: 96 22          LDA    $22
CBEF: 26 11          BNE    $CC02
CBF1: 96 D0          LDA    $D0
CBF3: 81 4C          CMPA   #$4C
CBF5: 26 0B          BNE    $CC02
CBF7: 86 01          LDA    #$01
CBF9: B7 2A 9A       STA    $2A9A
CBFC: 96 3F          LDA    $3F
CBFE: 84 07          ANDA   #$07
CC00: 97 3F          STA    $3F
CC02: 96 D0          LDA    $D0
CC04: 84 0F          ANDA   #$0F
CC06: 81 0B          CMPA   #$0B
CC08: 26 05          BNE    $CC0F
CC0A: 86 12          LDA    #$12
CC0C: BD 85 0E       JSR    $850E
CC0F: 96 D0          LDA    $D0
CC11: D6 D7          LDB    $D7
CC13: 27 06          BEQ    $CC1B
CC15: 84 01          ANDA   #$01
CC17: 26 0E          BNE    $CC27
CC19: 20 04          BRA    $CC1F
CC1B: 84 03          ANDA   #$03
CC1D: 26 08          BNE    $CC27
CC1F: 96 A2          LDA    $A2
CC21: 27 04          BEQ    $CC27
CC23: 0C A2          INC    $A2
CC25: 0C BD          INC    $BD
CC27: BD CE 53       JSR    $CE53
CC2A: 7E CF B3       JMP    $CFB3
CC2D: DC A1          LDD    p2_attempts_left_a1
CC2F: DD 4E          STD    $4E
CC31: 10 8E AB CD    LDY    #$ABCD
CC35: 96 D0          LDA    $D0
CC37: 84 0F          ANDA   #$0F
CC39: 48             ASLA
CC3A: EC A6          LDD    A,Y
CC3C: 9B 4E          ADDA   $4E
CC3E: 80 03          SUBA   #$03
CC40: DB 4F          ADDB   $4F
CC42: C0 03          SUBB   #$03
CC44: ED 01          STD    $1,X
CC46: 10 8E DE 5D    LDY    #$DE5D
CC4A: 96 D0          LDA    $D0
CC4C: 84 0F          ANDA   #$0F
CC4E: 48             ASLA
CC4F: 48             ASLA
CC50: 31 A6          LEAY   A,Y
CC52: 96 D0          LDA    $D0
CC54: 84 0F          ANDA   #$0F
CC56: 81 0B          CMPA   #$0B
CC58: 27 04          BEQ    $CC5E
CC5A: 81 0C          CMPA   #$0C
CC5C: 26 04          BNE    $CC62
CC5E: 86 09          LDA    #$09
CC60: 97 7C          STA    $7C
CC62: CE 18 10       LDU    #$1810
CC65: BD D1 9F       JSR    $D19F
CC68: 0F 7C          CLR    $7C
CC6A: 39             RTS

CC6B: B6 2A 1A       LDA    $2A1A
CC6E: 48             ASLA
CC6F: 10 8E DE 5D    LDY    #$DE5D
CC73: 31 A6          LEAY   A,Y
CC75: 20 EB          BRA    $CC62
CC77: 10 8E DD 6C    LDY    #$DD6C
CC7B: CE 18 10       LDU    #$1810
CC7E: 7E D1 6A       JMP    $D16A
CC81: 10 8E DD 6D    LDY    #$DD6D
CC85: CE 18 12       LDU    #$1812
CC88: 7E D1 6A       JMP    $D16A
CC8B: A6 05          LDA    $5,X
CC8D: 27 04          BEQ    $CC93
CC8F: 6A 05          DEC    $5,X
CC91: 20 15          BRA    $CCA8
CC93: 10 AE 0E       LDY    $E,X
CC96: 31 22          LEAY   $2,Y
CC98: A6 A4          LDA    ,Y
CC9A: 81 FF          CMPA   #$FF
CC9C: 26 03          BNE    $CCA1
CC9E: 10 AE 21       LDY    $1,Y
CCA1: 86 04          LDA    #$04
CCA3: A7 05          STA    $5,X
CCA5: 10 AF 0E       STY    $E,X
CCA8: 7E D1 36       JMP    $D136
CCAB: CC DD 7B       LDD    #$DD7B
CCAE: 7E CD 6B       JMP    $CD6B
CCB1: CC DD 7F       LDD    #$DD7F
CCB4: 7E CD 6B       JMP    $CD6B
CCB7: CC DC B6       LDD    #$DCB6
CCBA: 7E CD 6B       JMP    $CD6B
CCBD: D6 84          LDB    current_level_84
CCBF: 58             ASLB
CCC0: 10 8E DC 30    LDY    #$DC30
CCC4: 10 AE A5       LDY    B,Y
CCC7: A6 84          LDA    ,X
CCC9: 27 0B          BEQ    $CCD6
CCCB: 4A             DECA
CCCC: 48             ASLA
CCCD: 10 AE A6       LDY    A,Y
CCD0: CE 18 22       LDU    #$1822
CCD3: 7E D0 B1       JMP    update_sprite_buffer_d0b1
CCD6: 39             RTS

CCD7: A6 05          LDA    $5,X
CCD9: 27 04          BEQ    $CCDF
CCDB: 6A 05          DEC    $5,X
CCDD: 20 15          BRA    $CCF4
CCDF: 10 AE 0E       LDY    $E,X
CCE2: 31 22          LEAY   $2,Y
CCE4: A6 A4          LDA    ,Y
CCE6: 81 FF          CMPA   #$FF
CCE8: 26 03          BNE    $CCED
CCEA: 10 AE 21       LDY    $1,Y
CCED: 86 04          LDA    #$04
CCEF: A7 05          STA    $5,X
CCF1: 10 AF 0E       STY    $E,X
CCF4: CE 18 28       LDU    #$1828
CCF7: 7E D2 B2       JMP    $D2B2
CCFA: A6 05          LDA    $5,X
CCFC: 27 04          BEQ    $CD02
CCFE: 6A 05          DEC    $5,X
CD00: 20 15          BRA    $CD17
CD02: 10 AE 0E       LDY    $E,X
CD05: 31 21          LEAY   $1,Y
CD07: A6 A4          LDA    ,Y
CD09: 81 FF          CMPA   #$FF
CD0B: 26 03          BNE    $CD10
CD0D: 10 AE 21       LDY    $1,Y
CD10: 86 04          LDA    #$04
CD12: A7 05          STA    $5,X
CD14: 10 AF 0E       STY    $E,X
CD17: 10 AE 0E       LDY    $E,X
CD1A: CE 18 18       LDU    #$1818
CD1D: 7E D1 2F       JMP    $D12F
CD20: 10 8E DD 67    LDY    #$DD67
CD24: DC 9A          LDD    $9A
CD26: CE 18 2C       LDU    #$182C
CD29: 20 09          BRA    $CD34
CD2B: CE 18 2E       LDU    #$182E
CD2E: 10 8E DD 6A    LDY    #$DD6A
CD32: EC 01          LDD    $1,X
CD34: 34 02          PSHS   A
CD36: 96 21          LDA    copy_of_screen_flipped_21
CD38: 26 13          BNE    $CD4D
CD3A: 35 02          PULS   A
CD3C: A7 41          STA    $1,U
CD3E: E7 C9 04 00    STB    $0400,U
CD42: A6 A4          LDA    ,Y
CD44: A7 C9 04 01    STA    $0401,U
CD48: C6 4F          LDB    #$4F
CD4A: E7 C4          STB    ,U
CD4C: 39             RTS

CD4D: 35 02          PULS   A
CD4F: 50             NEGB
CD50: C0 0E          SUBB   #$0E
CD52: A7 41          STA    $1,U
CD54: E7 C9 04 00    STB    $0400,U
CD58: A6 A4          LDA    ,Y
CD5A: A7 C9 04 01    STA    $0401,U
CD5E: C6 0F          LDB    #$0F
CD60: E7 C4          STB    ,U
CD62: 39             RTS

CD63: CC DD 73       LDD    #$DD73
CD66: 20 03          BRA    $CD6B
CD68: CC DD 77       LDD    #$DD77
CD6B: 1F 02          TFR    D,Y
CD6D: BD CE 53       JSR    $CE53
CD70: 7E CE C7       JMP    $CEC7
CD73: 10 8E DD 83    LDY    #$DD83
CD77: A6 84          LDA    ,X
CD79: 81 01          CMPA   #$01
CD7B: 27 04          BEQ    $CD81
CD7D: 10 8E DD 85    LDY    #$DD85
CD81: CE 18 22       LDU    #$1822
CD84: 7E D0 B1       JMP    update_sprite_buffer_d0b1
CD87: A6 88 1D       LDA    $1D,X
CD8A: 81 08          CMPA   #$08
CD8C: 25 0A          BCS    $CD98
CD8E: 81 24          CMPA   #$24
CD90: 25 0C          BCS    $CD9E
CD92: 10 8E DD 34    LDY    #$DD34
CD96: 20 0A          BRA    $CDA2
CD98: 10 8E DD 2C    LDY    #$DD2C
CD9C: 20 04          BRA    $CDA2
CD9E: 10 8E DD 30    LDY    #$DD30
CDA2: BD CE 53       JSR    $CE53
CDA5: 7E CE C7       JMP    $CEC7
CDA8: A6 84          LDA    ,X
CDAA: 10 27 00 77    LBEQ   $CE25
CDAE: 7A 2B 02       DEC    $2B02
CDB1: 7A 2B 12       DEC    $2B12
CDB4: 7A 2B 22       DEC    $2B22
CDB7: 10 8E DD 92    LDY    #$DD92
CDBB: CE 18 00       LDU    #sprite_ram_1800
CDBE: A6 02          LDA    $2,X
CDC0: 81 EA          CMPA   #$EA
CDC2: 24 61          BCC    $CE25
CDC4: BD D1 2F       JSR    $D12F
CDC7: 10 8E DD 93    LDY    #$DD93
CDCB: CE 18 02       LDU    #$1802
CDCE: 8E 2B 10       LDX    #$2B10
CDD1: BD D1 2F       JSR    $D12F
CDD4: 10 8E DD 93    LDY    #$DD93
CDD8: CE 18 04       LDU    #$1804
CDDB: 8E 2B 00       LDX    #$2B00
CDDE: BD D1 2F       JSR    $D12F
CDE1: 10 8E DD 93    LDY    #$DD93
CDE5: CE 18 2A       LDU    #$182A
CDE8: 8E 2B 00       LDX    #$2B00
CDEB: 86 06          LDA    #$06
CDED: AB 02          ADDA   $2,X
CDEF: A7 02          STA    $2,X
CDF1: BD D1 2F       JSR    $D12F
CDF4: 86 FA          LDA    #$FA
CDF6: AB 02          ADDA   $2,X
CDF8: A7 02          STA    $2,X
CDFA: 10 8E DD 93    LDY    #$DD93
CDFE: CE 18 2C       LDU    #$182C
CE01: 8E 2B 10       LDX    #$2B10
CE04: 86 06          LDA    #$06
CE06: AB 02          ADDA   $2,X
CE08: A7 02          STA    $2,X
CE0A: BD D1 2F       JSR    $D12F
CE0D: 86 FA          LDA    #$FA
CE0F: AB 02          ADDA   $2,X
CE11: A7 02          STA    $2,X
CE13: 7D 2B 20       TST    $2B20
CE16: 27 0D          BEQ    $CE25
CE18: 10 8E DD 94    LDY    #$DD94
CE1C: CE 18 28       LDU    #$1828
CE1F: 8E 2B 20       LDX    #$2B20
CE22: BD D1 2F       JSR    $D12F
CE25: 39             RTS

CE26: A6 84          LDA    ,X
CE28: 27 FB          BEQ    $CE25
CE2A: 10 8E DD 95    LDY    #$DD95
CE2E: CE 18 00       LDU    #sprite_ram_1800
CE31: 96 DF          LDA    $DF
CE33: 84 01          ANDA   #$01
CE35: 27 02          BEQ    $CE39
CE37: 33 44          LEAU   $4,U
CE39: 7E D0 B1       JMP    update_sprite_buffer_d0b1

CE3C: BD CE 53       JSR    $CE53
CE3F: 7E D1 D4       JMP    $D1D4
CE42: 10 8E DC 48    LDY    #$DC48
CE46: A6 88 32       LDA    $32,X
CE49: 48             ASLA
CE4A: 10 AE A6       LDY    A,Y
CE4D: BD CE 53       JSR    $CE53
CE50: 7E CE C7       JMP    $CEC7
CE53: CE 18 08       LDU    #$1808
CE56: 96 84          LDA    current_level_84
CE58: 81 00          CMPA   #$00
CE5A: 27 04          BEQ    $CE60
CE5C: 81 03          CMPA   #$03
CE5E: 26 08          BNE    $CE68
CE60: 96 DF          LDA    $DF
CE62: 84 01          ANDA   #$01
CE64: 27 02          BEQ    $CE68
CE66: 33 48          LEAU   $8,U
CE68: 39             RTS

CE69: 96 7E          LDA    chrono_hundredth_second_7e
CE6B: 84 07          ANDA   #$07
CE6D: 27 01          BEQ    $CE70
CE6F: 39             RTS

CE70: 86 FF          LDA    #$FF
CE72: 5F             CLRB
CE73: CE 18 20       LDU    #$1820
CE76: 34 06          PSHS   D
CE78: 96 21          LDA    copy_of_screen_flipped_21
CE7A: 26 0D          BNE    $CE89
CE7C: 35 06          PULS   D
CE7E: A7 41          STA    $1,U
CE80: E7 C9 04 00    STB    $0400,U
CE84: CC 80 40       LDD    #$8040
CE87: 20 0F          BRA    $CE98
CE89: 35 06          PULS   D
CE8B: 50             NEGB
CE8C: 4A             DECA
CE8D: C0 0E          SUBB   #$0E
CE8F: A7 41          STA    $1,U
CE91: E7 C9 04 00    STB    $0400,U
CE95: CC 80 80       LDD    #$8080
CE98: A7 C9 04 01    STA    $0401,U
CE9C: E7 C4          STB    ,U
CE9E: 39             RTS

CE9F: 8E 29 E0       LDX    #$29E0
CEA2: CE 18 28       LDU    #$1828
CEA5: 10 8E DC 54    LDY    #$DC54
CEA9: 96 DF          LDA    $DF
CEAB: C6 0A          LDB    #$0A
CEAD: 3D             MUL
CEAE: 31 AB          LEAY   D,Y
CEB0: EC A1          LDD    ,Y++
CEB2: ED 01          STD    $1,X
CEB4: 86 01          LDA    #$01
CEB6: B7 2A B5       STA    $2AB5
CEB9: 96 3F          LDA    $3F
CEBB: 84 10          ANDA   #$10
CEBD: 10 27 00 F5    LBEQ   $CFB6
CEC1: 16 03 B0       LBRA   $D274

CEC4: 10 AE 0E       LDY    $E,X
CEC7: A6 A4          LDA    ,Y
CEC9: 81 FF          CMPA   #$FF
CECB: 26 06          BNE    $CED3
CECD: EC 21          LDD    $1,Y
CECF: ED 0E          STD    $E,X
CED1: 20 F1          BRA    $CEC4

CED3: 96 21          LDA    copy_of_screen_flipped_21
CED5: 26 67          BNE    $CF3E
CED7: A6 A4          LDA    ,Y
CED9: C6 40          LDB    #$40
CEDB: A7 C9 04 01    STA    $0401,U
CEDF: DA DF          ORB    $DF
CEE1: E7 C4          STB    ,U
CEE3: ED 06          STD    $6,X
CEE5: EC 01          LDD    $1,X
CEE7: 10 27 03 89    LBEQ   $D274
CEEB: 4C             INCA
CEEC: A7 41          STA    $1,U
CEEE: E7 C9 04 00    STB    $0400,U
CEF2: A6 21          LDA    $1,Y
CEF4: C6 40          LDB    #$40
CEF6: A7 C9 04 03    STA    $0403,U
CEFA: DA DF          ORB    $DF
CEFC: E7 42          STB    $2,U
CEFE: A7 08          STA    $8,X
CF00: EC 01          LDD    $1,X
CF02: 4C             INCA
CF03: C0 10          SUBB   #$10
CF05: A7 43          STA    $3,U
CF07: E7 C9 04 02    STB    $0402,U
CF0B: A6 22          LDA    $2,Y
CF0D: C6 40          LDB    #$40
CF0F: A7 C9 04 05    STA    $0405,U
CF13: DA DF          ORB    $DF
CF15: E7 44          STB    $4,U
CF17: A7 09          STA    $9,X
CF19: EC 01          LDD    $1,X
CF1B: 8B 10          ADDA   #$10
CF1D: 4C             INCA
CF1E: A7 45          STA    $5,U
CF20: E7 C9 04 04    STB    $0404,U
CF24: A6 23          LDA    $3,Y
CF26: C6 40          LDB    #$40
CF28: A7 C9 04 07    STA    $0407,U
CF2C: DA DF          ORB    $DF
CF2E: E7 46          STB    $6,U
CF30: EC 01          LDD    $1,X
CF32: 8B 10          ADDA   #$10
CF34: 4C             INCA
CF35: C0 10          SUBB   #$10
CF37: A7 47          STA    $7,U
CF39: E7 C9 04 06    STB    $0406,U
CF3D: 39             RTS

CF3E: A6 A4          LDA    ,Y
CF40: C6 40          LDB    #$40
CF42: A7 C9 04 01    STA    $0401,U
CF46: DA DF          ORB    $DF
CF48: C8 40          EORB   #$40
CF4A: E7 C4          STB    ,U
CF4C: ED 06          STD    $6,X
CF4E: EC 01          LDD    $1,X
CF50: 10 27 03 20    LBEQ   $D274
CF54: 50             NEGB
CF55: 4A             DECA
CF56: C0 0E          SUBB   #$0E
CF58: A7 41          STA    $1,U
CF5A: E7 C9 04 00    STB    $0400,U
CF5E: A6 21          LDA    $1,Y
CF60: C6 40          LDB    #$40
CF62: A7 C9 04 03    STA    $0403,U
CF66: DA DF          ORB    $DF
CF68: C8 40          EORB   #$40
CF6A: E7 42          STB    $2,U
CF6C: A7 08          STA    $8,X
CF6E: EC 01          LDD    $1,X
CF70: 50             NEGB
CF71: 4A             DECA
CF72: CB 02          ADDB   #$02
CF74: A7 43          STA    $3,U
CF76: E7 C9 04 02    STB    $0402,U
CF7A: A6 22          LDA    $2,Y
CF7C: C6 40          LDB    #$40
CF7E: A7 C9 04 05    STA    $0405,U
CF82: DA DF          ORB    $DF
CF84: C8 40          EORB   #$40
CF86: E7 44          STB    $4,U
CF88: A7 09          STA    $9,X
CF8A: EC 01          LDD    $1,X
CF8C: 50             NEGB
CF8D: 8B 0F          ADDA   #$0F
CF8F: C0 0E          SUBB   #$0E
CF91: A7 45          STA    $5,U
CF93: E7 C9 04 04    STB    $0404,U
CF97: A6 23          LDA    $3,Y
CF99: C6 40          LDB    #$40
CF9B: A7 C9 04 07    STA    $0407,U
CF9F: DA DF          ORB    $DF
CFA1: C8 40          EORB   #$40
CFA3: E7 46          STB    $6,U
CFA5: EC 01          LDD    $1,X
CFA7: 50             NEGB
CFA8: 8B 0F          ADDA   #$0F
CFAA: CB 02          ADDB   #$02
CFAC: A7 47          STA    $7,U
CFAE: E7 C9 04 06    STB    $0406,U
CFB2: 39             RTS

CFB3: 10 AE 0E       LDY    $E,X
CFB6: 96 21          LDA    copy_of_screen_flipped_21
CFB8: 26 73          BNE    $D02D
CFBA: EC A4          LDD    ,Y
CFBC: A7 C9 04 01    STA    $0401,U
CFC0: 7D 2A B5       TST    $2AB5
CFC3: 26 02          BNE    $CFC7
CFC5: DA DF          ORB    $DF
CFC7: E7 C4          STB    ,U
CFC9: ED 06          STD    $6,X
CFCB: EC 01          LDD    $1,X
CFCD: 10 27 02 A3    LBEQ   $D274
CFD1: 4C             INCA
CFD2: A7 41          STA    $1,U
CFD4: E7 C9 04 00    STB    $0400,U
CFD8: EC 22          LDD    $2,Y
CFDA: A7 C9 04 03    STA    $0403,U
CFDE: 7D 2A B5       TST    $2AB5
CFE1: 26 02          BNE    $CFE5
CFE3: DA DF          ORB    $DF
CFE5: E7 42          STB    $2,U
CFE7: A7 08          STA    $8,X
CFE9: EC 01          LDD    $1,X
CFEB: 4C             INCA
CFEC: C0 10          SUBB   #$10
CFEE: A7 43          STA    $3,U
CFF0: E7 C9 04 02    STB    $0402,U
CFF4: EC 24          LDD    $4,Y
CFF6: A7 C9 04 05    STA    $0405,U
CFFA: 7D 2A B5       TST    $2AB5
CFFD: 26 02          BNE    $D001
CFFF: DA DF          ORB    $DF
D001: E7 44          STB    $4,U
D002: 44             LSRA
D003: A7 09          STA    $9,X
D005: EC 01          LDD    $1,X
D007: 8B 10          ADDA   #$10
D009: 4C             INCA
D00A: A7 45          STA    $5,U
D00C: E7 C9 04 04    STB    $0404,U
D010: EC 26          LDD    $6,Y
D012: A7 C9 04 07    STA    $0407,U
D016: 7D 2A B5       TST    $2AB5
D019: 26 02          BNE    $D01D
D01B: DA DF          ORB    $DF
D01D: E7 46          STB    $6,U
D01F: EC 01          LDD    $1,X
D021: 8B 10          ADDA   #$10
D023: 4C             INCA
D024: C0 10          SUBB   #$10
D026: A7 47          STA    $7,U
D028: E7 C9 04 06    STB    $0406,U
D02C: 39             RTS

D02D: EC A4          LDD    ,Y
D02F: A7 C9 04 01    STA    $0401,U
D033: 7D 2A B5       TST    $2AB5
D036: 26 02          BNE    $D03A
D038: DA DF          ORB    $DF
D03A: C8 40          EORB   #$40
D03C: E7 C4          STB    ,U
D03E: ED 06          STD    $6,X
D040: EC 01          LDD    $1,X
D042: 10 27 02 2E    LBEQ   $D274
D046: 50             NEGB
D047: 4A             DECA
D048: C0 0E          SUBB   #$0E
D04A: A7 41          STA    $1,U
D04C: E7 C9 04 00    STB    $0400,U
D050: EC 22          LDD    $2,Y
D052: A7 C9 04 03    STA    $0403,U
D056: 7D 2A B5       TST    $2AB5
D059: 26 02          BNE    $D05D
D05B: DA DF          ORB    $DF
D05D: C8 40          EORB   #$40
D05F: E7 42          STB    $2,U
D061: A7 08          STA    $8,X
D063: EC 01          LDD    $1,X
D065: 50             NEGB
D066: 4A             DECA
D067: CB 02          ADDB   #$02
D069: A7 43          STA    $3,U
D06B: E7 C9 04 02    STB    $0402,U
D06F: EC 24          LDD    $4,Y
D071: A7 C9 04 05    STA    $0405,U
D075: 7D 2A B5       TST    $2AB5
D078: 26 02          BNE    $D07C
D07A: DA DF          ORB    $DF
D07C: C8 40          EORB   #$40
D07E: E7 44          STB    $4,U
D080: A7 09          STA    $9,X
D082: EC 01          LDD    $1,X
D084: 50             NEGB
D085: 8B 0F          ADDA   #$0F
D087: C0 0E          SUBB   #$0E
D089: A7 45          STA    $5,U
D08B: E7 C9 04 04    STB    $0404,U
D08F: EC 26          LDD    $6,Y
D091: A7 C9 04 07    STA    $0407,U
D095: 7D 2A B5       TST    $2AB5
D098: 26 02          BNE    $D09C
D09A: DA DF          ORB    $DF
D09C: C8 40          EORB   #$40
D09E: E7 46          STB    $6,U
D0A0: EC 01          LDD    $1,X
D0A2: 50             NEGB
D0A3: 8B 0F          ADDA   #$0F
D0A5: CB 02          ADDB   #$02
D0A7: A7 47          STA    $7,U
D0A9: E7 C9 04 06    STB    $0406,U
D0AD: 39             RTS

; write object to sprite buffer
; < Y: object structure
; < X: ???
; < U: sprite pointer to write into

D0AE: 10 AE 0E       LDY    $E,X
update_sprite_buffer_d0b1:
D0B1: A6 A4          LDA    ,Y
D0B3: 81 FF          CMPA   #$FF
D0B5: 26 06          BNE    $D0BD	; valid slot: run update
D0B7: EC 21          LDD    $1,Y
D0B9: ED 0E          STD    $E,X
D0BB: 20 F1          BRA    $D0AE

D0BD: 96 21          LDA    copy_of_screen_flipped_21
D0BF: 26 31          BNE    $D0F2
; straight screen
D0C1: A6 21          LDA    $1,Y
D0C3: C6 40          LDB    #$40
D0C5: A7 C9 04 03    STA    $0403,U		; store sprite code
D0C9: E7 42          STB    $2,U		; store sprite attribute
D0CB: A7 08          STA    $8,X
D0CD: EC 01          LDD    $1,X
D0CF: 8B 10          ADDA   #$10
D0D1: 4C             INCA
D0D2: A7 43          STA    $3,U		; store sprite Y
D0D4: E7 C9 04 02    STB    $0402,U		; store sprite X
update_sprite_buffer_d0d8:
D0D8: A6 A4          LDA    ,Y
D0DA: C6 4F          LDB    #$4F
D0DC: A7 C9 04 01    STA    $0401,U		; store sprite code
D0E0: E7 C4          STB    ,U			; store sprite attribute
D0E2: ED 06          STD    $6,X
D0E4: EC 01          LDD    $1,X
D0E6: 10 27 01 99    LBEQ   $D283
D0EA: 4C             INCA
D0EB: A7 41          STA    $1,U		; store sprite Y part 2
D0ED: E7 C9 04 00    STB    $0400,U		; store sprite X
D0F1: 39             RTS

D0F2: A6 21          LDA    $1,Y
D0F4: C6 40          LDB    #$40
D0F6: A7 C9 04 03    STA    $0403,U
D0FA: C8 40          EORB   #$40
D0FC: E7 42          STB    $2,U
D0FE: A7 08          STA    $8,X
D100: EC 01          LDD    $1,X
D102: 50             NEGB
D103: 8B 0F          ADDA   #$0F
D105: C0 0E          SUBB   #$0E
D107: A7 43          STA    $3,U
D109: E7 C9 04 02    STB    $0402,U
D10D: A6 A4          LDA    ,Y
D10F: C6 4F          LDB    #$4F
D111: A7 C9 04 01    STA    $0401,U
D115: C8 40          EORB   #$40
D117: E7 C4          STB    ,U
D119: ED 06          STD    $6,X
D11B: EC 01          LDD    $1,X
D11D: 10 27 01 62    LBEQ   $D283
D121: 50             NEGB
D122: 4A             DECA
D123: C0 0E          SUBB   #$0E
D125: A7 41          STA    $1,U
D127: E7 C9 04 00    STB    $0400,U
D12B: 39             RTS

D12C: 10 AE 0E       LDY    $E,X

D12F: 96 21          LDA    copy_of_screen_flipped_21
D131: 26 DA          BNE    $D10D
D133: 16 FF A2       LBRA   update_sprite_buffer_d0d8

D136: 10 AE 0E       LDY    $E,X
D139: 96 21          LDA    copy_of_screen_flipped_21
D13B: 26 14          BNE    $D151
D13D: EC A4          LDD    ,Y
D13F: A7 C9 04 01    STA    $0401,U
D143: E7 C4          STB    ,U
D145: ED 06          STD    $6,X
D147: EC 01          LDD    $1,X
D149: 4C             INCA
D14A: A7 41          STA    $1,U
D14C: E7 C9 04 00    STB    $0400,U
D150: 39             RTS

D151: EC A4          LDD    ,Y
D153: A7 C9 04 01    STA    $0401,U
D157: C8 40          EORB   #$40
D159: E7 C4          STB    ,U
D15B: ED 06          STD    $6,X
D15D: EC 01          LDD    $1,X
D15F: 50             NEGB
D160: 4A             DECA
D161: C0 0E          SUBB   #$0E
D163: A7 41          STA    $1,U
D165: E7 C9 04 00    STB    $0400,U
D169: 39             RTS

D16A: EC 01          LDD    $1,X
D16C: 34 02          PSHS   A
D16E: 96 21          LDA    copy_of_screen_flipped_21
D170: 26 14          BNE    $D186
D172: 35 02          PULS   A
D174: 4C             INCA
D175: A7 41          STA    $1,U
D177: E7 C9 04 00    STB    $0400,U
D17B: A6 A4          LDA    ,Y
D17D: C6 40          LDB    #$40
D17F: A7 C9 04 01    STA    $0401,U
D183: E7 C4          STB    ,U
D185: 39             RTS

D186: 35 02          PULS   A
D188: 50             NEGB
D189: 4A             DECA
D18A: C0 0E          SUBB   #$0E
D18C: A7 41          STA    $1,U
D18E: E7 C9 04 00    STB    $0400,U
D192: A6 A4          LDA    ,Y
D194: C6 40          LDB    #$40
D196: A7 C9 04 01    STA    $0401,U
D19A: C8 40          EORB   #$40
D19C: E7 C4          STB    ,U
D19E: 39             RTS

D19F: EC 01          LDD    $1,X
D1A1: 34 02          PSHS   A
D1A3: 96 21          LDA    copy_of_screen_flipped_21
D1A5: 26 14          BNE    $D1BB
D1A7: 35 02          PULS   A
D1A9: 4C             INCA
D1AA: A7 41          STA    $1,U
D1AC: E7 C9 04 00    STB    $0400,U
D1B0: EC A4          LDD    ,Y
D1B2: A7 C9 04 01    STA    $0401,U
D1B6: DA 7C          ORB    $7C
D1B8: E7 C4          STB    ,U
D1BA: 39             RTS

D1BB: 35 02          PULS   A
D1BD: 50             NEGB
D1BE: 4A             DECA
D1BF: C0 0E          SUBB   #$0E
D1C1: A7 41          STA    $1,U
D1C3: E7 C9 04 00    STB    $0400,U
D1C7: EC A4          LDD    ,Y
D1C9: A7 C9 04 01    STA    $0401,U
D1CD: DA 7C          ORB    $7C
D1CF: C8 40          EORB   #$40
D1D1: E7 C4          STB    ,U
D1D3: 39             RTS

D1D4: 96 21          LDA    copy_of_screen_flipped_21
D1D6: 26 31          BNE    $D209
D1D8: EC 01          LDD    $1,X
D1DA: 10 27 00 96    LBEQ   $D274
D1DE: 4C             INCA
D1DF: C0 10          SUBB   #$10
D1E1: A7 43          STA    $3,U
D1E3: E7 C9 04 02    STB    $0402,U
D1E7: EC 01          LDD    $1,X
D1E9: 8B 10          ADDA   #$10
D1EB: 4C             INCA
D1EC: A7 45          STA    $5,U
D1EE: E7 C9 04 04    STB    $0404,U
D1F2: EC 01          LDD    $1,X
D1F4: 8B 10          ADDA   #$10
D1F6: 4C             INCA
D1F7: C0 10          SUBB   #$10
D1F9: A7 47          STA    $7,U
D1FB: E7 C9 04 06    STB    $0406,U
D1FF: EC 01          LDD    $1,X
D201: 4C             INCA
D202: A7 41          STA    $1,U
D204: E7 C9 04 00    STB    $0400,U
D208: 39             RTS

D209: EC 01          LDD    $1,X
D20B: 27 67          BEQ    $D274
D20D: 50             NEGB
D20E: 4A             DECA
D20F: CB 02          ADDB   #$02
D211: A7 43          STA    $3,U
D213: E7 C9 04 02    STB    $0402,U
D217: EC 01          LDD    $1,X
D219: 50             NEGB
D21A: 8B 0F          ADDA   #$0F
D21C: C0 0E          SUBB   #$0E
D21E: A7 45          STA    $5,U
D220: E7 C9 04 04    STB    $0404,U
D224: EC 01          LDD    $1,X
D226: 50             NEGB
D227: 8B 0F          ADDA   #$0F
D229: CB 02          ADDB   #$02
D22B: A7 47          STA    $7,U
D22D: E7 C9 04 06    STB    $0406,U
D231: EC 01          LDD    $1,X
D233: 50             NEGB
D234: 4A             DECA
D235: C0 0E          SUBB   #$0E
D237: A7 41          STA    $1,U
D239: E7 C9 04 00    STB    $0400,U
D23D: 39             RTS

D23E: 96 21          LDA    copy_of_screen_flipped_21
D240: 26 0E          BNE    $D250
D242: EC 01          LDD    $1,X
D244: 27 3D          BEQ    $D283
D246: 8B 10          ADDA   #$10
D248: A7 43          STA    $3,U
D24A: E7 C9 04 02    STB    $0402,U
D24E: 20 AF          BRA    $D1FF
D250: EC 01          LDD    $1,X
D252: 27 2F          BEQ    $D283
D254: 50             NEGB
D255: 8B 0F          ADDA   #$0F
D257: C0 0E          SUBB   #$0E
D259: A7 43          STA    $3,U
D25B: E7 C9 04 02    STB    $0402,U
D25F: 20 D0          BRA    $D231
D261: 39             RTS

D262: EC 01          LDD    $1,X
D264: 27 1D          BEQ    $D283
D266: 4C             INCA
D267: A7 41          STA    $1,U
D269: E7 C9 04 00    STB    $0400,U
D26D: A7 43          STA    $3,U
D26F: E7 C9 04 02    STB    $0402,U
D273: 39             RTS

D274: CC FF 00       LDD    #$FF00
D277: A7 47          STA    $7,U
D279: E7 C9 04 06    STB    $0406,U
D27D: A7 45          STA    $5,U
D27F: E7 C9 04 04    STB    $0404,U
D283: CC FF 00       LDD    #$FF00
D286: A7 43          STA    $3,U
D288: E7 C9 04 02    STB    $0402,U
D28C: CC FF 00       LDD    #$FF00
D28F: A7 41          STA    $1,U
D291: E7 C9 04 00    STB    $0400,U
D295: 39             RTS

D296: 10 AE 0E       LDY    $E,X
D299: A6 A4          LDA    ,Y
D29B: A7 C9 04 01    STA    $0401,U
D29F: A6 21          LDA    $1,Y
D2A1: A7 C9 04 03    STA    $0403,U
D2A5: A6 22          LDA    $2,Y
D2A7: A7 C9 04 05    STA    $0405,U
D2AB: A6 23          LDA    $3,Y
D2AD: A7 C9 04 07    STA    $0407,U
D2B1: 39             RTS

D2B2: 10 AE 0E       LDY    $E,X
D2B5: 96 21          LDA    copy_of_screen_flipped_21
D2B7: 26 2B          BNE    $D2E4
D2B9: A6 A4          LDA    ,Y
D2BB: C6 40          LDB    #$40
D2BD: A7 C9 04 01    STA    $0401,U
D2C1: E7 C4          STB    ,U
D2C3: ED 06          STD    $6,X
D2C5: EC 01          LDD    $1,X
D2C7: A7 41          STA    $1,U
D2C9: E7 C9 04 00    STB    $0400,U
D2CD: A6 21          LDA    $1,Y
D2CF: C6 40          LDB    #$40
D2D1: A7 C9 04 03    STA    $0403,U
D2D5: E7 42          STB    $2,U
D2D7: A7 08          STA    $8,X
D2D9: EC 01          LDD    $1,X
D2DB: CB 10          ADDB   #$10
D2DD: A7 43          STA    $3,U
D2DF: E7 C9 04 02    STB    $0402,U
D2E3: 39             RTS

D2E4: A6 A4          LDA    ,Y
D2E6: C6 40          LDB    #$40
D2E8: A7 C9 04 01    STA    $0401,U
D2EC: C8 40          EORB   #$40
D2EE: E7 C4          STB    ,U
D2F0: ED 06          STD    $6,X
D2F2: EC 01          LDD    $1,X
D2F4: 50             NEGB
D2F5: C0 0E          SUBB   #$0E
D2F7: A7 41          STA    $1,U
D2F9: E7 C9 04 00    STB    $0400,U
D2FD: A6 21          LDA    $1,Y
D2FF: C6 40          LDB    #$40
D301: A7 C9 04 03    STA    $0403,U
D305: C8 40          EORB   #$40
D307: E7 42          STB    $2,U
D309: A7 08          STA    $8,X
D30B: EC 01          LDD    $1,X
D30D: 50             NEGB
D30E: C0 1E          SUBB   #$1E
D310: A7 43          STA    $3,U
D312: E7 C9 04 02    STB    $0402,U
D316: 39             RTS

D317: 10 8E 2B 61    LDY    #$2B61
D31B: 96 0D          LDA    $0D
D31D: C6 05          LDB    #$05
D31F: 3D             MUL
D320: 31 AB          LEAY   D,Y
D322: A6 3F          LDA    -$1,Y
D324: 27 1F          BEQ    $D345
D326: 84 10          ANDA   #$10
D328: 26 1B          BNE    $D345
D32A: 96 2D          LDA    dsw2_copy_2d
D32C: 84 08          ANDA   #$08
D32E: 27 0D          BEQ    $D33D
D330: 1F 21          TFR    Y,X
D332: 34 20          PSHS   Y
D334: BD 87 7D       JSR    $877D
D337: 35 20          PULS   Y
D339: 96 CD          LDA    player_is_qualified_cd
D33B: 27 08          BEQ    $D345
D33D: 8E DC 7C       LDX    #table_dc7c
D340: 96 84          LDA    current_level_84
D342: 48             ASLA
D343: 6E 96          JMP    [A,X]		; [jump_table]

D345: 39             RTS

D346: A6 A4          LDA    ,Y
D348: C6 0A          LDB    #$0A
D34A: 3D             MUL
D34B: EB 21          ADDB   $1,Y
D34D: C0 03          SUBB   #$03
D34F: 25 1B          BCS    $D36C
D351: D7 52          STB    $52
D353: 27 06          BEQ    $D35B
D355: CE DC 96       LDU    #$DC96
D358: BD D5 2C       JSR    $D52C
D35B: A6 22          LDA    $2,Y
D35D: C6 0A          LDB    #$0A
D35F: 3D             MUL
D360: EB 23          ADDB   $3,Y
D362: D7 52          STB    $52
D364: 27 06          BEQ    $D36C
D366: CE DC 8A       LDU    #$DC8A
D369: BD D5 2C       JSR    $D52C
D36C: 39             RTS

D36D: EC 21          LDD    $1,Y
D36F: 27 74          BEQ    $D3E5
D371: DD 50          STD    $50
D373: 0F 53          CLR    $53
D375: 0A 51          DEC    $51
D377: 96 51          LDA    $51
D379: 81 FF          CMPA   #$FF
D37B: 26 06          BNE    $D383
D37D: 86 09          LDA    #$09
D37F: 97 51          STA    $51
D381: 0A 50          DEC    $50
D383: 0A 50          DEC    $50
D385: 0A 50          DEC    $50
D387: 96 50          LDA    $50
D389: C6 0A          LDB    #$0A
D38B: 3D             MUL
D38C: DB 51          ADDB   $51
D38E: 58             ASLB
D38F: A6 23          LDA    $3,Y
D391: 81 05          CMPA   #$05
D393: 25 01          BCS    $D396
D395: 5C             INCB
D396: C1 05          CMPB   #$05
D398: 25 04          BCS    $D39E
D39A: C6 05          LDB    #$05
D39C: 0C 53          INC    $53
D39E: D7 52          STB    $52
D3A0: 27 39          BEQ    $D3DB
D3A2: CE DC 92       LDU    #$DC92
D3A5: BD D5 2C       JSR    $D52C
D3A8: 96 53          LDA    $53
D3AA: 27 2F          BEQ    $D3DB
D3AC: EC 22          LDD    $2,Y
D3AE: DD 50          STD    $50
D3B0: 96 51          LDA    $51
D3B2: 80 05          SUBA   #$05
D3B4: 24 0A          BCC    $D3C0
D3B6: 96 51          LDA    $51
D3B8: 8B 05          ADDA   #$05
D3BA: 97 51          STA    $51
D3BC: 0A 50          DEC    $50
D3BE: 20 02          BRA    $D3C2
D3C0: 97 51          STA    $51
D3C2: 96 50          LDA    $50
D3C4: 80 03          SUBA   #$03
D3C6: 25 13          BCS    $D3DB
D3C8: 97 50          STA    $50
D3CA: 96 50          LDA    $50
D3CC: C6 0A          LDB    #$0A
D3CE: 3D             MUL
D3CF: DB 51          ADDB   $51
D3D1: D7 52          STB    $52
D3D3: 27 06          BEQ    $D3DB
D3D5: CE DC 92       LDU    #$DC92
D3D8: BD D5 2C       JSR    $D52C
D3DB: 86 01          LDA    #$01
D3DD: 97 52          STA    $52
D3DF: CE DC 9A       LDU    #$DC9A
D3E2: BD D5 2C       JSR    $D52C
D3E5: 39             RTS

D3E6: A6 A4          LDA    ,Y
D3E8: C6 0A          LDB    #$0A
D3EA: 3D             MUL
D3EB: EB 21          ADDB   $1,Y
D3ED: D7 51          STB    $51
D3EF: C1 0F          CMPB   #$0F
D3F1: 24 4A          BCC    $D43D
D3F3: C6 0E          LDB    #$0E
D3F5: D0 51          SUBB   $51
D3F7: C1 04          CMPB   #$04
D3F9: 25 0A          BCS    $D405
D3FB: 86 04          LDA    #$04
D3FD: 97 52          STA    $52
D3FF: C0 04          SUBB   #$04
D401: D7 53          STB    $53
D403: 20 04          BRA    $D409
D405: D7 52          STB    $52
D407: 0F 53          CLR    $53
D409: 96 52          LDA    $52
D40B: 27 12          BEQ    $D41F
D40D: CE DC 96       LDU    #$DC96
D410: BD D5 2C       JSR    $D52C
D413: 96 53          LDA    $53
D415: 97 52          STA    $52
D417: 27 06          BEQ    $D41F
D419: CE DC 98       LDU    #$DC98
D41C: BD D5 2C       JSR    $D52C
D41F: A6 22          LDA    $2,Y
D421: C6 0A          LDB    #$0A
D423: 3D             MUL
D424: EB 23          ADDB   $3,Y
D426: D7 50          STB    $50
D428: 86 64          LDA    #$64
D42A: 90 50          SUBA   $50
D42C: 97 52          STA    $52
D42E: CE DC 8C       LDU    #$DC8C
D431: 96 51          LDA    $51
D433: 81 0B          CMPA   #$0B
D435: 25 03          BCS    $D43A
D437: CE DC 8A       LDU    #$DC8A
D43A: BD D5 2C       JSR    $D52C
D43D: 39             RTS

D43E: A6 A4          LDA    ,Y
D440: C6 0A          LDB    #$0A
D442: 3D             MUL
D443: EB 21          ADDB   $1,Y
D445: D7 51          STB    $51
D447: C1 18          CMPB   #$18
D449: 24 4A          BCC    $D495
D44B: C6 17          LDB    #$17
D44D: D0 51          SUBB   $51
D44F: C1 0B          CMPB   #$0B
D451: 25 0A          BCS    $D45D
D453: 86 0B          LDA    #$0B
D455: 97 52          STA    $52
D457: C0 0B          SUBB   #$0B
D459: D7 53          STB    $53
D45B: 20 04          BRA    $D461
D45D: D7 52          STB    $52
D45F: 0F 53          CLR    $53
D461: 96 52          LDA    $52
D463: 27 12          BEQ    $D477
D465: CE DC 94       LDU    #$DC94
D468: BD D5 2C       JSR    $D52C
D46B: 96 53          LDA    $53
D46D: 97 52          STA    $52
D46F: 27 06          BEQ    $D477
D471: CE DC 96       LDU    #$DC96
D474: BD D5 2C       JSR    $D52C
D477: A6 22          LDA    $2,Y
D479: C6 0A          LDB    #$0A
D47B: 3D             MUL
D47C: EB 23          ADDB   $3,Y
D47E: D7 50          STB    $50
D480: 86 64          LDA    #$64
D482: 90 50          SUBA   $50
D484: 97 52          STA    $52
D486: CE DC 8A       LDU    #$DC8A
D489: 96 51          LDA    $51
D48B: 81 0D          CMPA   #$0D
D48D: 25 03          BCS    $D492
D48F: CE DC 88       LDU    #$DC88
D492: BD D5 2C       JSR    $D52C
D495: 39             RTS

D496: A6 A4          LDA    ,Y
D498: C6 0A          LDB    #$0A
D49A: 3D             MUL
D49B: EB 21          ADDB   $1,Y
D49D: D7 51          STB    $51
D49F: C0 0F          SUBB   #$0F
D4A1: 25 3D          BCS    $D4E0
D4A3: C1 23          CMPB   #$23
D4A5: 25 0A          BCS    $D4B1
D4A7: 86 23          LDA    #$23
D4A9: 97 52          STA    $52
D4AB: C0 23          SUBB   #$23
D4AD: D7 53          STB    $53
D4AF: 20 04          BRA    $D4B5
D4B1: D7 52          STB    $52
D4B3: 0F 53          CLR    $53
D4B5: 96 52          LDA    $52
D4B7: 27 12          BEQ    $D4CB
D4B9: CE DC 8E       LDU    #$DC8E
D4BC: BD D5 2C       JSR    $D52C
D4BF: 96 53          LDA    $53
D4C1: 97 52          STA    $52
D4C3: 27 06          BEQ    $D4CB
D4C5: CE DC 90       LDU    #$DC90
D4C8: BD D5 2C       JSR    $D52C
D4CB: A6 22          LDA    $2,Y
D4CD: 97 52          STA    $52
D4CF: 27 0F          BEQ    $D4E0
D4D1: CE DC 88       LDU    #$DC88
D4D4: 96 51          LDA    $51
D4D6: 81 32          CMPA   #$32
D4D8: 25 03          BCS    $D4DD
D4DA: CE DC 8A       LDU    #$DC8A
D4DD: BD D5 2C       JSR    $D52C
D4E0: 39             RTS

D4E1: A6 A4          LDA    ,Y
D4E3: C6 0A          LDB    #$0A
D4E5: 3D             MUL
D4E6: EB 21          ADDB   $1,Y
D4E8: D7 51          STB    $51
D4EA: C0 0A          SUBB   #$0A
D4EC: 25 3D          BCS    $D52B
D4EE: C1 28          CMPB   #$28
D4F0: 25 0A          BCS    $D4FC
D4F2: 86 28          LDA    #$28
D4F4: 97 52          STA    $52
D4F6: C0 28          SUBB   #$28
D4F8: D7 53          STB    $53
D4FA: 20 04          BRA    $D500
D4FC: D7 52          STB    $52
D4FE: 0F 53          CLR    $53
D500: 96 52          LDA    $52
D502: 27 12          BEQ    $D516
D504: CE DC 8E       LDU    #$DC8E
D507: BD D5 2C       JSR    $D52C
D50A: 96 53          LDA    $53
D50C: 97 52          STA    $52
D50E: 27 06          BEQ    $D516
D510: CE DC 90       LDU    #$DC90
D513: BD D5 2C       JSR    $D52C
D516: A6 22          LDA    $2,Y
D518: 97 52          STA    $52
D51A: 27 0F          BEQ    $D52B
D51C: CE DC 88       LDU    #$DC88
D51F: 96 51          LDA    $51
D521: 81 32          CMPA   #$32
D523: 25 03          BCS    $D528
D525: CE DC 8A       LDU    #$DC8A
D528: BD D5 2C       JSR    $D52C
D52B: 39             RTS

D52C: 8E 2B 74       LDX    #$2B74
D52F: A6 3F          LDA    -$1,Y
D531: 84 0F          ANDA   #$0F
D533: 4A             DECA
D534: C6 03          LDB    #$03
D536: 3D             MUL
D537: 30 8B          LEAX   D,X
D539: 8D 4C          BSR    $D587
D53B: 0A 52          DEC    $52
D53D: 26 FA          BNE    $D539
D53F: 39             RTS

D540: 34 70          PSHS   U,Y,X
D542: 96 84          LDA    current_level_84
D544: 81 00          CMPA   #$00
D546: 27 08          BEQ    $D550
D548: 81 03          CMPA   #$03
D54A: 27 04          BEQ    $D550
D54C: 8D 2C          BSR    $D57A
D54E: 20 1B          BRA    $D56B
D550: 96 DF          LDA    $DF
D552: 97 FB          STA    $FB
D554: 84 02          ANDA   #$02
D556: 97 DF          STA    $DF
D558: 96 AA          LDA    $AA
D55A: 26 02          BNE    $D55E
D55C: 8D 1C          BSR    $D57A
D55E: 0C DF          INC    $DF
D560: B6 2A 0A       LDA    $2A0A
D563: 26 02          BNE    $D567
D565: 8D 13          BSR    $D57A
D567: 96 FB          LDA    $FB
D569: 97 DF          STA    $DF
D56B: 86 31          LDA    #$31
D56D: BD 85 0E       JSR    $850E
D570: BD 8C 4D       JSR    $8C4D
D573: 35 70          PULS   X,Y,U
D575: 86 03          LDA    #$03
D577: 7E 84 F5       JMP    queue_event_84f5

D57A: 8E 2A 80       LDX    #$2A80
D57D: 96 DF          LDA    $DF
D57F: C6 03          LDB    #$03
D581: 3D             MUL
D582: 30 8B          LEAX   D,X
D584: CE DC 94       LDU    #$DC94
D587: A6 02          LDA    $2,X
D589: AB 41          ADDA   $1,U
D58B: 19             DAA
D58C: A7 02          STA    $2,X
D58E: A6 01          LDA    $1,X
D590: A9 C4          ADCA   ,U
D592: 19             DAA
D593: A7 01          STA    $1,X
D595: A6 84          LDA    ,X
D597: 89 00          ADCA   #$00
D599: 19             DAA
D59A: A7 84          STA    ,X
D59C: 39             RTS

D59D: 8E DC 9C       LDX    #table_dc9c
D5A0: 96 09          LDA    $09
D5A2: 48             ASLA
D5A3: 6E 96          JMP    [A,X]		; [jump_table]

D5A5: 96 60          LDA    nb_players_minus_one_60
D5A7: 27 1C          BEQ    $D5C5
D5A9: 0F D8          CLR    angle_d8
D5AB: 8E 2B 60       LDX    #$2B60
D5AE: 96 84          LDA    current_level_84
D5B0: 81 00          CMPA   #$00
D5B2: 27 04          BEQ    $D5B8
D5B4: 81 03          CMPA   #$03
D5B6: 26 44          BNE    $D5FC
D5B8: C6 03          LDB    #$03
D5BA: A6 84          LDA    ,X
D5BC: 84 30          ANDA   #$30
D5BE: 27 08          BEQ    $D5C8
D5C0: 30 05          LEAX   $5,X
D5C2: 5A             DECB
D5C3: 26 F5          BNE    $D5BA
D5C5: 0C 06          INC    $06
D5C7: 39             RTS

D5C8: A6 80          LDA    ,X+
D5CA: 84 0F          ANDA   #$0F
D5CC: 27 F7          BEQ    $D5C5
D5CE: BD 87 7D       JSR    $877D
D5D1: 96 CD          LDA    player_is_qualified_cd
D5D3: 27 F0          BEQ    $D5C5
D5D5: 0C D8          INC    angle_d8
D5D7: 30 04          LEAX   $4,X
D5D9: 8C 2B 74       CMPX   #$2B74
D5DC: 27 E7          BEQ    $D5C5
D5DE: A6 84          LDA    ,X
D5E0: 84 30          ANDA   #$30
D5E2: 26 08          BNE    $D5EC
D5E4: A6 84          LDA    ,X
D5E6: 84 0F          ANDA   #$0F
D5E8: 27 02          BEQ    $D5EC
D5EA: 0C D8          INC    angle_d8
D5EC: 30 05          LEAX   $5,X
D5EE: 8C 2B 74       CMPX   #$2B74
D5F1: 26 EB          BNE    $D5DE
D5F3: 96 D8          LDA    angle_d8
D5F5: 81 02          CMPA   #$02
D5F7: 25 CC          BCS    $D5C5
D5F9: 0C 09          INC    $09
D5FB: 39             RTS

D5FC: 30 01          LEAX   $1,X
D5FE: BD 87 7D       JSR    $877D
D601: 96 CD          LDA    player_is_qualified_cd
D603: 27 C0          BEQ    $D5C5
D605: 0C D8          INC    angle_d8
D607: C6 03          LDB    #$03
D609: 30 04          LEAX   $4,X
D60B: A6 84          LDA    ,X
D60D: 27 07          BEQ    $D616
D60F: 0C D8          INC    angle_d8
D611: 30 05          LEAX   $5,X
D613: 5A             DECB
D614: 26 F5          BNE    $D60B
D616: 20 DB          BRA    $D5F3
D618: BD 8C 2F       JSR    reset_scrolling_8c2f
D61B: 86 30          LDA    #$30
D61D: BD 85 0E       JSR    $850E
D620: CC 00 00       LDD    #$0000
D623: BD 84 F5       JSR    queue_event_84f5
D626: 86 02          LDA    #$02
D628: 97 0B          STA    $0B
D62A: 0C 09          INC    $09
D62C: 39             RTS

D62D: 0A 0B          DEC    $0B
D62F: 26 FB          BNE    $D62C
D631: CC 01 00       LDD    #$0100
D634: BD 84 F5       JSR    queue_event_84f5
D637: 86 02          LDA    #$02
D639: D6 84          LDB    current_level_84
D63B: CB 30          ADDB   #$30
D63D: BD 84 F5       JSR    queue_event_84f5
D640: CC 01 01       LDD    #$0101
D643: BD 84 F5       JSR    queue_event_84f5
D646: CC 02 39       LDD    #$0239
D649: BD 84 F5       JSR    queue_event_84f5
D64C: BD D7 71       JSR    $D771
D64F: 4F             CLRA
D650: D6 2D          LDB    dsw2_copy_2d
D652: C4 04          ANDB   #$04
D654: 26 08          BNE    $D65E
D656: D6 DF          LDB    $DF
D658: C4 02          ANDB   #$02
D65A: 27 02          BEQ    $D65E
D65C: 86 01          LDA    #$01
D65E: B7 10 80       STA    flip_screen_set_1080
D661: CE 31 87       LDU    #$3187
D664: C6 12          LDB    #$12
D666: BD D7 EC       JSR    $D7EC
D669: CE 33 47       LDU    #$3347
D66C: C6 12          LDB    #$12
D66E: BD D7 EC       JSR    $D7EC
D671: CE 31 C7       LDU    #$31C7
D674: C6 06          LDB    #$06
D676: BD D7 F4       JSR    $D7F4
D679: CE 31 D8       LDU    #$31D8
D67C: C6 06          LDB    #$06
D67E: BD D7 F4       JSR    $D7F4
D681: CE 34 0B       LDU    #$340B
D684: 0F 07          CLR    $07
D686: A6 84          LDA    ,X
D688: 27 78          BEQ    $D702
D68A: 85 30          BITA   #$30
D68C: 27 09          BEQ    $D697
D68E: 30 05          LEAX   $5,X
D690: 8C 2B 74       CMPX   #$2B74
D693: 27 6D          BEQ    $D702
D695: 20 EF          BRA    $D686
D697: 10 8E A4 C8    LDY    #$A4C8
D69B: 4A             DECA
D69C: E6 A6          LDB    A,Y
D69E: D7 49          STB    $49
D6A0: 86 01          LDA    #$01
D6A2: BD 84 F5       JSR    queue_event_84f5
D6A5: 86 02          LDA    #$02
D6A7: D6 07          LDB    $07
D6A9: CB 36          ADDB   #$36
D6AB: BD 84 F5       JSR    queue_event_84f5
D6AE: D6 49          LDB    $49
D6B0: A6 84          LDA    ,X
D6B2: BD 61 F0       JSR    write_char_and_move_cursor_61f0
D6B5: 86 20          LDA    #$20
D6B7: BD 61 F0       JSR    write_char_and_move_cursor_61f0
D6BA: 33 41          LEAU   $1,U
D6BC: BD D7 DF       JSR    $D7DF
D6BF: D6 49          LDB    $49
D6C1: A6 A0          LDA    ,Y+
D6C3: BD 61 F0       JSR    write_char_and_move_cursor_61f0
D6C6: A6 A0          LDA    ,Y+
D6C8: BD 61 F0       JSR    write_char_and_move_cursor_61f0
D6CB: A6 A0          LDA    ,Y+
D6CD: BD 61 F0       JSR    write_char_and_move_cursor_61f0
D6D0: 33 42          LEAU   $2,U
D6D2: A6 80          LDA    ,X+
D6D4: 27 05          BEQ    $D6DB
D6D6: BD 61 F0       JSR    write_char_and_move_cursor_61f0
D6D9: 20 02          BRA    $D6DD
D6DB: 33 41          LEAU   $1,U
D6DD: A6 80          LDA    ,X+
D6DF: BD 61 F0       JSR    write_char_and_move_cursor_61f0
D6E2: BD 8A 1D       JSR    $8A1D
D6E5: C6 01          LDB    #$01
D6E7: BD 61 F0       JSR    write_char_and_move_cursor_61f0
D6EA: D6 49          LDB    $49
D6EC: A6 80          LDA    ,X+
D6EE: BD 61 F0       JSR    write_char_and_move_cursor_61f0
D6F1: A6 80          LDA    ,X+
D6F3: BD 61 F0       JSR    write_char_and_move_cursor_61f0
D6F6: 0C 07          INC    $07
D6F8: 33 C8 73       LEAU   $73,U
D6FB: 8C 2B 74       CMPX   #$2B74
D6FE: 10 26 FF 84    LBNE   $D686
D702: 8E 28 A0       LDX    #$28A0
D705: CC 28 80       LDD    #$2880
D708: DD A1          STD    p2_attempts_left_a1
D70A: CC DE B2       LDD    #$DEB2
D70D: DD AE          STD    $AE
D70F: BD CB 23       JSR    $CB23
D712: 86 FF          LDA    #$FF
D714: 97 0B          STA    $0B
D716: 0C 09          INC    $09
D718: 39             RTS

D719: 96 3F          LDA    $3F
D71B: 84 03          ANDA   #$03
D71D: 26 23          BNE    $D742
D71F: BD DA 6A       JSR    $DA6A
D722: CE 39 88       LDU    #$3988
D725: C6 04          LDB    #$04
D727: BD DA 77       JSR    copy_4b_chars_da77
D72A: CE 39 98       LDU    #$3998
D72D: C6 02          LDB    #$02
D72F: BD DA 8B       JSR    $DA8B
D732: CE 3B 58       LDU    #$3B58
D735: C6 04          LDB    #$04
D737: BD DA AB       JSR    $DAAB
D73A: CE 3B 47       LDU    #$3B47
D73D: C6 02          LDB    #$02
D73F: BD DA BF       JSR    $DABF
D742: BD D7 71       JSR    $D771
D745: 96 3F          LDA    $3F
D747: 84 04          ANDA   #$04
D749: 27 08          BEQ    $D753
D74B: CC 01 00       LDD    #$0100
D74E: BD 84 F5       JSR    queue_event_84f5
D751: 20 06          BRA    $D759
D753: CC 01 01       LDD    #$0101
D756: BD 84 F5       JSR    queue_event_84f5
D759: CC 02 39       LDD    #$0239
D75C: BD 84 F5       JSR    queue_event_84f5
D75F: 8E 28 A0       LDX    #$28A0
D762: BD CE 53       JSR    $CE53
D765: BD CB A5       JSR    $CBA5
D768: 0A 0B          DEC    $0B
D76A: 26 04          BNE    $D770
D76C: 0C 06          INC    $06
D76E: 0F 09          CLR    $09
D770: 39             RTS

D771: 8E 2B 60       LDX    #$2B60
D774: A6 84          LDA    ,X
D776: 84 30          ANDA   #$30
D778: 27 04          BEQ    $D77E
D77A: 30 05          LEAX   $5,X
D77C: 20 F6          BRA    $D774
D77E: A6 84          LDA    ,X
D780: D6 3F          LDB    $3F
D782: C4 04          ANDB   #$04
D784: 27 03          BEQ    $D789
D786: 5F             CLRB
D787: 20 06          BRA    $D78F
D789: CE A4 C8       LDU    #$A4C8
D78C: 4A             DECA
D78D: E6 C6          LDB    A,U
D78F: CE 32 C9       LDU    #$32C9
D792: A6 84          LDA    ,X
D794: 97 DF          STA    $DF
D796: 0A DF          DEC    $DF
D798: BD 61 F0       JSR    write_char_and_move_cursor_61f0
D79B: 86 20          LDA    #$20
D79D: BD 61 F0       JSR    write_char_and_move_cursor_61f0
D7A0: 33 42          LEAU   $2,U
D7A2: 34 04          PSHS   B
D7A4: BD D7 DF       JSR    $D7DF
D7A7: 35 04          PULS   B
D7A9: A6 A0          LDA    ,Y+
D7AB: BD 61 F0       JSR    write_char_and_move_cursor_61f0
D7AE: A6 A0          LDA    ,Y+
D7B0: BD 61 F0       JSR    write_char_and_move_cursor_61f0
D7B3: A6 A0          LDA    ,Y+
D7B5: BD 61 F0       JSR    write_char_and_move_cursor_61f0
D7B8: 33 42          LEAU   $2,U
D7BA: A6 80          LDA    ,X+
D7BC: 27 05          BEQ    $D7C3
D7BE: BD 61 F0       JSR    write_char_and_move_cursor_61f0
D7C1: 20 02          BRA    $D7C5
D7C3: 33 41          LEAU   $1,U
D7C5: A6 80          LDA    ,X+
D7C7: BD 61 F0       JSR    write_char_and_move_cursor_61f0
D7CA: 34 04          PSHS   B
D7CC: BD 8A 1D       JSR    $8A1D
D7CF: 35 04          PULS   B
D7D1: BD 61 F0       JSR    write_char_and_move_cursor_61f0
D7D4: A6 80          LDA    ,X+
D7D6: BD 61 F0       JSR    write_char_and_move_cursor_61f0
D7D9: A6 80          LDA    ,X+
D7DB: BD 61 F0       JSR    write_char_and_move_cursor_61f0
D7DE: 39             RTS

D7DF: 10 8E 29 90    LDY    #$2990
D7E3: A6 80          LDA    ,X+
D7E5: 4A             DECA
D7E6: C6 03          LDB    #$03
D7E8: 3D             MUL
D7E9: 31 AB          LEAY   D,Y
D7EB: 39             RTS

D7EC: 86 48          LDA    #$48
D7EE: A7 C0          STA    ,U+		; [video_address]
D7F0: 5A             DECB
D7F1: 26 FB          BNE    $D7EE
D7F3: 39             RTS

D7F4: 86 48          LDA    #$48
D7F6: A7 C4          STA    ,U		; [video_address]
D7F8: 33 C8 40       LEAU   $40,U
D7FB: 5A             DECB
D7FC: 26 F8          BNE    $D7F6
D7FE: 39             RTS

; add 1/100th of a second, but called at 60Hz so tricks are
; done to add more than once at times
chrono_tick_d7ff:
D7FF: 96 7E          LDA    chrono_hundredth_second_7e
D801: 8B 01          ADDA   #$01
D803: 19             DAA
D804: 97 7E          STA    chrono_hundredth_second_7e
D806: 25 11          BCS    $D819		; hundredth wrapped? 99->00?
; not wrapped, make up for routine being called only every 1/60th of
; a second and not every 1/100th
D808: 84 0F          ANDA   #$0F
D80A: 27 14          BEQ    $D820
D80C: 81 05          CMPA   #$05
D80E: 27 10          BEQ    $D820
D810: 96 7E          LDA    chrono_hundredth_second_7e
D812: 8B 01          ADDA   #$01
D814: 19             DAA
D815: 97 7E          STA    chrono_hundredth_second_7e
D817: 20 07          BRA    $D820
D819: 96 7F          LDA    chrono_second_7f
D81B: 8B 01          ADDA   #$01
D81D: 19             DAA
D81E: 97 7F          STA    chrono_second_7f
D820: 0D EA          TST    display_chrono_ea
D822: 27 06          BEQ    $D82A
; send draw chrono event
D824: CC 07 00       LDD    #$0700
D827: BD 84 F5       JSR    queue_event_84f5
D82A: 39             RTS

D82B: 96 2C          LDA    dsw1_copy_2c
D82D: 84 0F          ANDA   #$0F
D82F: 81 0F          CMPA   #$0F
D831: 27 16          BEQ    $D849
D833: 96 23          LDA    number_of_credits_23
D835: C6 0A          LDB    #$0A
D837: BD FB 6A       JSR    $FB6A
D83A: F7 37 1D       STB    $371D
D83D: B7 37 1E       STA    $371E
D840: 86 0A          LDA    #$0A
D842: 98 73          EORA   $73
D844: 1F 89          TFR    A,B
D846: FD 3F 1D       STD    $3F1D
D849: 39             RTS

D84A: BD 86 F7       JSR    $86F7
D84D: 10 8E 2C 00    LDY    #$2C00
D851: 86 20          LDA    #$20
D853: D6 84          LDB    current_level_84
D855: 3D             MUL
D856: 31 AB          LEAY   D,Y
D858: 31 A8 10       LEAY   $10,Y
D85B: CE 29 90       LDU    #$2990
D85E: 96 DF          LDA    $DF
D860: C6 03          LDB    #$03
D862: 3D             MUL
D863: 33 C5          LEAU   B,U
D865: 86 03          LDA    #$03
D867: 97 50          STA    $50
D869: BD 89 68       JSR    compare_performances_8968
D86C: 5D             TSTB
D86D: 27 2A          BEQ    $D899
D86F: EC A4          LDD    ,Y
D871: ED 28          STD    $8,Y
D873: EC 22          LDD    $2,Y
D875: ED 2A          STD    $A,Y
D877: EC 24          LDD    $4,Y
D879: ED 2C          STD    $C,Y
D87B: A6 26          LDA    $6,Y
D87D: A7 2E          STA    $E,Y
D87F: EC 84          LDD    ,X
D881: ED A4          STD    ,Y
D883: EC 02          LDD    $2,X
D885: ED 22          STD    $2,Y
D887: EC C4          LDD    ,U
D889: ED 24          STD    $4,Y
D88B: A6 42          LDA    $2,U
D88D: A7 26          STA    $6,Y
D88F: 96 DF          LDA    $DF
D891: A7 27          STA    $7,Y
D893: 31 38          LEAY   -$8,Y
D895: 0A 50          DEC    $50
D897: 26 D0          BNE    $D869
D899: 96 50          LDA    $50
D89B: 4C             INCA
D89C: 81 04          CMPA   #$04
D89E: 25 03          BCS    $D8A3
D8A0: 4F             CLRA
D8A1: 20 21          BRA    $D8C4
D8A3: D6 DF          LDB    $DF
D8A5: 56             RORB
D8A6: 24 0E          BCC    $D8B6
D8A8: 0D E8          TST    $E8
D8AA: 27 0A          BEQ    $D8B6
D8AC: 91 E8          CMPA   $E8
D8AE: 22 02          BHI    $D8B2
D8B0: 0C E8          INC    $E8
D8B2: 97 E7          STA    $E7
D8B4: 20 02          BRA    $D8B8
D8B6: 97 E8          STA    $E8
D8B8: 96 E8          LDA    $E8
D8BA: 81 04          CMPA   #$04
D8BC: 26 06          BNE    $D8C4
D8BE: 96 E7          LDA    $E7
D8C0: 97 E8          STA    $E8
D8C2: 0F E7          CLR    $E7
D8C4: BD 86 F7       JSR    $86F7
D8C7: 10 8E 2C 00    LDY    #$2C00
D8CB: 86 20          LDA    #$20
D8CD: D6 84          LDB    current_level_84
D8CF: 3D             MUL
D8D0: 31 AB          LEAY   D,Y
D8D2: 8E 31 16       LDX    #$3116
D8D5: 86 03          LDA    #$03
D8D7: 97 48          STA    nb_objects_48
D8D9: EC A1          LDD    ,Y++
D8DB: 4D             TSTA
D8DC: 26 02          BNE    $D8E0
D8DE: 86 10          LDA    #$10
D8E0: ED 81          STD    ,X++		; [video_address_word]
D8E2: 96 E6          LDA    $E6
D8E4: 81 23          CMPA   #$23
D8E6: 27 04          BEQ    $D8EC
D8E8: 86 A7          LDA    #$A7
D8EA: 20 02          BRA    $D8EE
D8EC: 86 6B          LDA    #$6B
D8EE: A7 80          STA    ,X+		; [video_address]
D8F0: EC A1          LDD    ,Y++
D8F2: ED 81          STD    ,X++		; [video_address_word]
D8F4: 30 01          LEAX   $1,X
D8F6: EC A1          LDD    ,Y++
D8F8: ED 81          STD    ,X++		; [video_address]
D8FA: A6 A1          LDA    ,Y++
D8FC: A7 84          STA    ,X		; [video_address]
D8FE: 30 88 38       LEAX   $38,X
D901: 0A 48          DEC    nb_objects_48
D903: 26 D4          BNE    $D8D9
D905: 39             RTS

update_scrolling_d906:
D906: 8E 18 4D       LDX    #scroll_registers_1840+$D
D909: 10 8E 2A F0    LDY    #scroll_offsets_2af0
D90D: A6 84          LDA    ,X			; load current values [scroll_address]
D90F: E6 89 04 00    LDB    $0400,X		; of scroll registers [scroll_address]
D913: 0D 21          TST    copy_of_screen_flipped_21
D915: 27 06          BEQ    $D91D
D917: A0 A0          SUBA   ,Y+
D919: C2 00          SBCB   #$00
D91B: 20 04          BRA    $D921

D91D: AB A0          ADDA   ,Y+		; non flipped
D91F: C9 00          ADCB   #$00
D921: A7 80          STA    ,X+		; low nibble (1Cxx)  [scroll_address]
D923: E7 89 03 FF    STB    $03FF,X		; high nibble  [scroll_address]
D927: 10 8C 2A F5    CMPY   #$2AF5
D92B: 26 E0          BNE    $D90D
D92D: 96 84          LDA    current_level_84
D92F: 81 00          CMPA   #$00
D931: 10 27 BE 0F    LBEQ   $9744
D935: 81 03          CMPA   #$03
D937: 10 27 BE 09    LBEQ   $9744
D93B: A6 84          LDA    ,X		;  [scroll_address]
D93D: E6 89 04 00    LDB    $0400,X		;  [scroll_address]
D941: 0D 21          TST    copy_of_screen_flipped_21
D943: 27 06          BEQ    $D94B
D945: A0 A0          SUBA   ,Y+
D947: C2 00          SBCB   #$00
D949: 20 04          BRA    $D94F
D94B: AB A0          ADDA   ,Y+
D94D: C9 00          ADCB   #$00
D94F: A7 80          STA    ,X+				;  [scroll_address]
D951: E7 89 03 FF    STB    $03FF,X		;  [scroll_address]
D955: 10 8C 2B 00    CMPY   #$2B00
D959: 26 E0          BNE    $D93B
D95B: 7D 2A FF       TST    $2AFF
D95E: 27 32          BEQ    $D992
D960: 8E 28 A0       LDX    #$28A0
D963: 7D 2A FF       TST    $2AFF
D966: 27 0E          BEQ    $D976
D968: BD 9A AC       JSR    $9AAC
D96B: 7C 2F E8       INC    $2FE8
D96E: 7A 2A FF       DEC    $2AFF
D971: BD 85 25       JSR    $8525
D974: 20 ED          BRA    $D963
D976: 8E 2A F0       LDX    #scroll_offsets_2af0
D979: CC 00 00       LDD    #$0000
D97C: ED 81          STD    ,X++
D97E: 8C 2B 00       CMPX   #$2B00
D981: 26 F9          BNE    $D97C
D983: 96 84          LDA    current_level_84
D985: 81 05          CMPA   #$05
D987: 26 09          BNE    $D992
D989: 8E 2A C0       LDX    #$2AC0
D98C: BD 85 87       JSR    $8587
D98F: BD 99 E7       JSR    $99E7
D992: 39             RTS

D993: BD 8C 2F       JSR    reset_scrolling_8c2f
D996: CE 33 40       LDU    #$3340
D999: 86 11          LDA    #$11
D99B: 97 48          STA    nb_objects_48
D99D: 86 10          LDA    #$10
D99F: C6 20          LDB    #$20
D9A1: 6F C9 08 00    CLR    $0800,U       ; [video_address]
D9A5: A7 C0          STA    ,U+           ; [video_address]
D9A7: 5A             DECB
D9A8: 26 F7          BNE    $D9A1
D9AA: 33 C8 20       LEAU   $20,U
D9AD: 0A 48          DEC    nb_objects_48
D9AF: 26 EE          BNE    $D99F
D9B1: 39             RTS

D9B2: CE 33 82       LDU    #$3382
D9B5: C6 1C          LDB    #$1C
D9B7: BD D7 EC       JSR    $D7EC
D9BA: CE 36 C2       LDU    #$36C2
D9BD: C6 1C          LDB    #$1C
D9BF: BD D7 EC       JSR    $D7EC
D9C2: CE 33 C2       LDU    #$33C2
D9C5: C6 0C          LDB    #$0C
D9C7: BD D7 F4       JSR    $D7F4
D9CA: CE 33 DD       LDU    #$33DD
D9CD: C6 0C          LDB    #$0C
D9CF: BD D7 F4       JSR    $D7F4
D9D2: 39             RTS

D9D3: 96 3F          LDA    $3F
D9D5: 84 03          ANDA   #$03
D9D7: 10 26 00 23    LBNE   $D9FE
D9DB: BD DA 6A       JSR    $DA6A
D9DE: CE 3B 82       LDU    #$3B82
D9E1: C6 07          LDB    #$07
D9E3: BD DA 77       JSR    copy_4b_chars_da77
D9E6: CE 3B DD       LDU    #$3BDD
D9E9: C6 03          LDB    #$03
D9EB: BD DA 8B       JSR    $DA8B
D9EE: CE 3E DE       LDU    #$3EDE
D9F1: C6 07          LDB    #$07
D9F3: BD DA AB       JSR    $DAAB
D9F6: CE 3E 82       LDU    #$3E82
D9F9: C6 03          LDB    #$03
D9FB: BD DA BF       JSR    $DABF
D9FE: 96 3F          LDA    $3F
DA00: 84 04          ANDA   #$04
DA02: 27 39          BEQ    $DA3D
DA04: CC 01 03       LDD    #$0103
DA07: BD 84 F5       JSR    queue_event_84f5
DA0A: CC 02 27       LDD    #$0227
DA0D: BD 84 F5       JSR    queue_event_84f5
DA10: CC 01 0A       LDD    #$010A
DA13: BD 84 F5       JSR    queue_event_84f5
DA16: CC 02 28       LDD    #$0228
DA19: BD 84 F5       JSR    queue_event_84f5
DA1C: 86 02          LDA    #$02
DA1E: D6 E8          LDB    $E8
DA20: CB 2B          ADDB   #$2B
DA22: BD 84 F5       JSR    queue_event_84f5
DA25: CC 02 29       LDD    #$0229
DA28: BD 84 F5       JSR    queue_event_84f5
DA2B: CC 01 01       LDD    #$0101
DA2E: BD 84 F5       JSR    queue_event_84f5
DA31: CC 02 2A       LDD    #$022A
DA34: BD 84 F5       JSR    queue_event_84f5
DA37: CC 02 2B       LDD    #$022B
DA3A: 7E 84 F5       JMP    queue_event_84f5
DA3D: CC 01 00       LDD    #$0100
DA40: BD 84 F5       JSR    queue_event_84f5
DA43: CC 02 27       LDD    #$0227
DA46: BD 84 F5       JSR    queue_event_84f5
DA49: CC 02 28       LDD    #$0228
DA4C: BD 84 F5       JSR    queue_event_84f5
DA4F: 86 02          LDA    #$02
DA51: D6 E8          LDB    $E8
DA53: CB 2B          ADDB   #$2B
DA55: BD 84 F5       JSR    queue_event_84f5
DA58: CC 02 29       LDD    #$0229
DA5B: BD 84 F5       JSR    queue_event_84f5
DA5E: CC 02 2A       LDD    #$022A
DA61: BD 84 F5       JSR    queue_event_84f5
DA64: CC 02 2B       LDD    #$022B
DA67: 7E 84 F5       JMP    queue_event_84f5
DA6A: 0C 13          INC    $13
DA6C: 10 8E DC A4    LDY    #$DCA4
DA70: 96 13          LDA    $13
DA72: 84 03          ANDA   #$03
DA74: 31 A6          LEAY   A,Y
DA76: 39             RTS

copy_4b_chars_da77:
DA77: A6 A4          LDA    ,Y
DA79: A7 C0          STA    ,U+		; [video_address]
DA7B: A6 21          LDA    $1,Y
DA7D: A7 C0          STA    ,U+		; [video_address]
DA7F: A6 22          LDA    $2,Y
DA81: A7 C0          STA    ,U+		; [video_address]
DA83: A6 23          LDA    $3,Y
DA85: A7 C0          STA    ,U+		; [video_address]
DA87: 5A             DECB
DA88: 26 ED          BNE    copy_4b_chars_da77
DA8A: 39             RTS

DA8B: A6 A4          LDA    ,Y
DA8D: A7 C4          STA    ,U		; [video_address]
DA8F: 33 C8 40       LEAU   $40,U
DA92: A6 21          LDA    $1,Y
DA94: A7 C4          STA    ,U		; [video_address]
DA96: 33 C8 40       LEAU   $40,U
DA99: A6 22          LDA    $2,Y
DA9B: A7 C4          STA    ,U		; [video_address]
DA9D: 33 C8 40       LEAU   $40,U
DAA0: A6 23          LDA    $3,Y
DAA2: A7 C4          STA    ,U		; [video_address]
DAA4: 33 C8 40       LEAU   $40,U
DAA7: 5A             DECB
DAA8: 26 E1          BNE    $DA8B
DAAA: 39             RTS

DAAB: A6 A4          LDA    ,Y
DAAD: A7 C2          STA    ,-U		; [video_address]
DAAF: A6 21          LDA    $1,Y
DAB1: A7 C2          STA    ,-U		; [video_address]
DAB3: A6 22          LDA    $2,Y
DAB5: A7 C2          STA    ,-U		; [video_address]
DAB7: A6 23          LDA    $3,Y
DAB9: A7 C2          STA    ,-U		; [video_address]
DABB: 5A             DECB
DABC: 26 ED          BNE    $DAAB
DABE: 39             RTS

DABF: A6 A4          LDA    ,Y
DAC1: A7 C4          STA    ,U		; [video_address]
DAC3: 33 C8 C0       LEAU   -$40,U
DAC6: A6 21          LDA    $1,Y
DAC8: A7 C4          STA    ,U		; [video_address]
DACA: 33 C8 C0       LEAU   -$40,U
DACD: A6 22          LDA    $2,Y
DACF: A7 C4          STA    ,U		; [video_address]
DAD1: 33 C8 C0       LEAU   -$40,U
DAD4: A6 23          LDA    $3,Y
DAD6: A7 C4          STA    ,U		; [video_address]
DAD8: 33 C8 C0       LEAU   -$40,U
DADB: 5A             DECB
DADC: 26 E1          BNE    $DABF
DADE: 39             RTS

DADF: 8E DC AC       LDX    #table_dcac
DAE2: 96 09          LDA    $09
DAE4: 48             ASLA
DAE5: 6E 96          JMP    [A,X]		; [jump_table]

DAE7: 96 60          LDA    nb_players_minus_one_60
DAE9: 27 15          BEQ    $DB00
DAEB: BD 8C 2F       JSR    reset_scrolling_8c2f
DAEE: 86 30          LDA    #$30
DAF0: BD 85 0E       JSR    $850E
DAF3: CC 00 00       LDD    #$0000
DAF6: BD 84 F5       JSR    queue_event_84f5
DAF9: 86 02          LDA    #$02
DAFB: 97 0B          STA    $0B
DAFD: 0C 09          INC    $09
DAFF: 39             RTS

DB00: 0C 00          INC    global_state_00
DB02: 0F 03          CLR    boot_state_03
DB04: 0F 06          CLR    $06
DB06: 0F 09          CLR    $09
DB08: 39             RTS

DB09: 0A 0B          DEC    $0B
DB0B: 26 FB          BNE    $DB08
DB0D: CC 01 01       LDD    #$0101
DB10: BD 84 F5       JSR    queue_event_84f5
DB13: CC 02 3D       LDD    #$023D
DB16: BD 84 F5       JSR    queue_event_84f5
DB19: BD DB FF       JSR    $DBFF
DB1C: 4F             CLRA
DB1D: D6 2D          LDB    dsw2_copy_2d
DB1F: C4 04          ANDB   #$04
DB21: 26 08          BNE    $DB2B
DB23: D6 DF          LDB    $DF
DB25: C4 02          ANDB   #$02
DB27: 27 02          BEQ    $DB2B
DB29: 86 01          LDA    #$01
DB2B: B7 10 80       STA    flip_screen_set_1080
DB2E: CE 31 87       LDU    #$3187
DB31: C6 12          LDB    #$12
DB33: BD D7 EC       JSR    $D7EC
DB36: CE 33 47       LDU    #$3347
DB39: C6 12          LDB    #$12
DB3B: BD D7 EC       JSR    $D7EC
DB3E: CE 31 C7       LDU    #$31C7
DB41: C6 06          LDB    #$06
DB43: BD D7 F4       JSR    $D7F4
DB46: CE 31 D8       LDU    #$31D8
DB49: C6 06          LDB    #$06
DB4B: BD D7 F4       JSR    $D7F4
DB4E: CE 34 0B       LDU    #$340B
DB51: 0F 07          CLR    $07
DB53: 96 60          LDA    nb_players_minus_one_60
DB55: 97 50          STA    $50
DB57: A6 84          LDA    ,X
DB59: 10 8E A4 C8    LDY    #$A4C8
DB5D: 4A             DECA
DB5E: E6 A6          LDB    A,Y
DB60: D7 49          STB    $49
DB62: 86 01          LDA    #$01
DB64: BD 84 F5       JSR    queue_event_84f5
DB67: 86 02          LDA    #$02
DB69: D6 07          LDB    $07
DB6B: CB 36          ADDB   #$36
DB6D: BD 84 F5       JSR    queue_event_84f5
DB70: D6 49          LDB    $49
DB72: A6 84          LDA    ,X
DB74: BD 61 F0       JSR    write_char_and_move_cursor_61f0
DB77: 86 20          LDA    #$20
DB79: BD 61 F0       JSR    write_char_and_move_cursor_61f0
DB7C: 33 41          LEAU   $1,U
DB7E: BD D7 DF       JSR    $D7DF
DB81: D6 49          LDB    $49
DB83: BD 62 67       JSR    $6267
DB86: 0C 07          INC    $07
DB88: 33 C8 72       LEAU   $72,U
DB8B: 0A 50          DEC    $50
DB8D: 26 C8          BNE    $DB57
DB8F: 8E 28 A0       LDX    #$28A0
DB92: CC 28 80       LDD    #$2880
DB95: DD A1          STD    p2_attempts_left_a1
DB97: CC DE B2       LDD    #$DEB2
DB9A: DD AE          STD    $AE
DB9C: BD CB 23       JSR    $CB23
DB9F: 86 FF          LDA    #$FF
DBA1: 97 0B          STA    $0B
DBA3: 0C 09          INC    $09
DBA5: 39             RTS

DBA6: 96 3F          LDA    $3F
DBA8: 84 03          ANDA   #$03
DBAA: 26 23          BNE    $DBCF
DBAC: BD DA 6A       JSR    $DA6A
DBAF: CE 39 88       LDU    #$3988
DBB2: C6 04          LDB    #$04
DBB4: BD DA 77       JSR    copy_4b_chars_da77
DBB7: CE 39 98       LDU    #$3998
DBBA: C6 02          LDB    #$02
DBBC: BD DA 8B       JSR    $DA8B
DBBF: CE 3B 58       LDU    #$3B58
DBC2: C6 04          LDB    #$04
DBC4: BD DA AB       JSR    $DAAB
DBC7: CE 3B 47       LDU    #$3B47
DBCA: C6 02          LDB    #$02
DBCC: BD DA BF       JSR    $DABF
DBCF: BD DB FF       JSR    $DBFF
DBD2: 96 3F          LDA    $3F
DBD4: 84 04          ANDA   #$04
DBD6: 27 08          BEQ    $DBE0
DBD8: CC 01 00       LDD    #$0100
DBDB: BD 84 F5       JSR    queue_event_84f5
DBDE: 20 06          BRA    $DBE6
DBE0: CC 01 01       LDD    #$0101
DBE3: BD 84 F5       JSR    queue_event_84f5
DBE6: CC 02 3D       LDD    #$023D
DBE9: BD 84 F5       JSR    queue_event_84f5
DBEC: 8E 28 A0       LDX    #$28A0
DBEF: BD CE 53       JSR    $CE53
DBF2: BD CB A5       JSR    $CBA5
DBF5: 0A 0B          DEC    $0B
DBF7: 26 05          BNE    $DBFE
DBF9: 7E DB 00       JMP    $DB00
DBFC: 0F 09          CLR    $09
DBFE: 39             RTS

DBFF: 8E 2A A0       LDX    #$2AA0
DC02: A6 84          LDA    ,X
DC04: D6 3F          LDB    $3F
DC06: C4 04          ANDB   #$04
DC08: 27 03          BEQ    $DC0D
DC0A: 5F             CLRB
DC0B: 20 06          BRA    $DC13
DC0D: CE A4 C8       LDU    #$A4C8
DC10: 4A             DECA
DC11: E6 C6          LDB    A,U
DC13: CE 32 C9       LDU    #$32C9
DC16: A6 84          LDA    ,X
DC18: 97 DF          STA    $DF
DC1A: 0A DF          DEC    $DF
DC1C: BD 61 F0       JSR    write_char_and_move_cursor_61f0
DC1F: 86 20          LDA    #$20
DC21: BD 61 F0       JSR    write_char_and_move_cursor_61f0
DC24: 33 41          LEAU   $1,U
DC26: 34 04          PSHS   B
DC28: BD D7 DF       JSR    $D7DF
DC2B: 35 04          PULS   B
DC2D: 7E 62 67       JMP    $6267

table_dc7c:
	dc.w	$d3e6	; $dc7c
	dc.w	$d346	; $dc7e
	dc.w	$d496	; $dc80
	dc.w	$d43e	; $dc82
	dc.w	$d4e1	; $dc84
	dc.w	$d36d	; $dc86
	
table_dc9c:
	dc.w	$d5a5	; $dc9c
	dc.w	$d618	; $dc9e
	dc.w	$d62d	; $dca0
	dc.w	$d719	; $dca2
	
table_dcac:
	dc.w	$dae7	; $dcac
	dc.w	$db09	; $dcae
	dc.w	$dba6	; $dcb0
	
DEFF: 0F 4F          CLR    $4F
DF01: 96 3F          LDA    $3F
DF03: C6 03          LDB    #$03
DF05: BD FB 6A       JSR    $FB6A
DF08: 4D             TSTA
DF09: 27 0D          BEQ    $DF18
DF0B: 86 FF          LDA    #$FF
DF0D: 97 4F          STA    $4F
DF0F: 96 84          LDA    current_level_84
DF11: 81 02          CMPA   #$02
DF13: 27 03          BEQ    $DF18
DF15: 5F             CLRB
DF16: 4F             CLRA
DF17: 39             RTS

DF18: 1F 12          TFR    X,Y
DF1A: 96 B0          LDA    $B0
DF1C: C6 06          LDB    #$06
DF1E: BD FB 6A       JSR    $FB6A
DF21: D7 4A          STB    $4A
DF23: C6 0A          LDB    #$0A
DF25: 3D             MUL
DF26: DB B1          ADDB   $B1
DF28: 1F 98          TFR    B,A
DF2A: C6 06          LDB    #$06
DF2C: BD FB 6A       JSR    $FB6A
DF2F: D7 4B          STB    $4B
DF31: C6 0A          LDB    #$0A
DF33: 3D             MUL
DF34: DB B2          ADDB   $B2
DF36: 1F 98          TFR    B,A
DF38: C6 06          LDB    #$06
DF3A: BD FB 6A       JSR    $FB6A
DF3D: D7 4C          STB    $4C
DF3F: C6 0A          LDB    #$0A
DF41: 3D             MUL
DF42: DB B3          ADDB   $B3
DF44: 1F 98          TFR    B,A
DF46: C6 06          LDB    #$06
DF48: BD FB 6A       JSR    $FB6A
DF4B: D7 4D          STB    $4D
DF4D: 96 4C          LDA    $4C
DF4F: C6 0A          LDB    #$0A
DF51: 3D             MUL
DF52: 0F 4C          CLR    $4C
DF54: D3 4C          ADDD   $4C
DF56: DD 48          STD    nb_objects_48
DF58: 96 4B          LDA    $4B
DF5A: C6 64          LDB    #$64
DF5C: 3D             MUL
DF5D: D3 48          ADDD   nb_objects_48
DF5F: DD 48          STD    nb_objects_48
DF61: D6 4A          LDB    $4A
DF63: 86 E8          LDA    #$E8
DF65: 3D             MUL
DF66: D3 48          ADDD   nb_objects_48
DF68: DD 48          STD    nb_objects_48
DF6A: D6 4A          LDB    $4A
DF6C: 86 03          LDA    #$03
DF6E: 3D             MUL
DF6F: DB 48          ADDB   nb_objects_48
DF71: D7 48          STB    nb_objects_48
DF73: A6 A8 38       LDA    $38,Y
DF76: 8E ED D5       LDX    #$EDD5
DF79: 40             NEGA
DF7A: A6 86          LDA    A,X
DF7C: 97 4E          STA    $4E
DF7E: BD E0 26       JSR    $E026
DF81: DD 4A          STD    $4A
DF83: 8E ED D6       LDX    #$EDD6
DF86: 96 84          LDA    current_level_84
DF88: A6 86          LDA    A,X
DF8A: 34 02          PSHS   A
DF8C: D6 4B          LDB    $4B
DF8E: 3D             MUL
DF8F: DD 50          STD    $50
DF91: 35 02          PULS   A
DF93: D6 4A          LDB    $4A
DF95: 3D             MUL
DF96: DB 50          ADDB   $50
DF98: D7 50          STB    $50
DF9A: DC 50          LDD    $50
DF9C: 47             ASRA
DF9D: 56             RORB
DF9E: 47             ASRA
DF9F: 56             RORB
DFA0: 47             ASRA
DFA1: 56             RORB
DFA2: 47             ASRA
DFA3: 56             RORB
DFA4: DD 4A          STD    $4A
DFA6: A6 A8 38       LDA    $38,Y
DFA9: 8E ED 7B       LDX    #$ED7B
DFAC: A6 86          LDA    A,X
DFAE: 97 4E          STA    $4E
DFB0: BD E0 26       JSR    $E026
DFB3: DD 4C          STD    $4C
DFB5: 8E ED DC       LDX    #$EDDC
DFB8: 96 84          LDA    current_level_84
DFBA: A6 86          LDA    A,X
DFBC: 34 02          PSHS   A
DFBE: D6 4D          LDB    $4D
DFC0: 3D             MUL
DFC1: DD 50          STD    $50
DFC3: 35 02          PULS   A
DFC5: D6 4C          LDB    $4C
DFC7: 3D             MUL
DFC8: DB 50          ADDB   $50
DFCA: D7 50          STB    $50
DFCC: DC 50          LDD    $50
DFCE: 47             ASRA
DFCF: 56             RORB
DFD0: 47             ASRA
DFD1: 56             RORB
DFD2: 47             ASRA
DFD3: 56             RORB
DFD4: 47             ASRA
DFD5: 56             RORB
DFD6: DD 4C          STD    $4C
DFD8: FC 2A 5E       LDD    $2A5E
DFDB: 58             ASLB
DFDC: 49             ROLA
DFDD: DD 50          STD    $50
DFDF: 47             ASRA
DFE0: 56             RORB
DFE1: 47             ASRA
DFE2: 56             RORB
DFE3: D3 50          ADDD   $50
DFE5: DD 50          STD    $50
DFE7: DC 4C          LDD    $4C
DFE9: 93 50          SUBD   $50
DFEB: DD 4C          STD    $4C
DFED: 96 4F          LDA    $4F
DFEF: 81 FF          CMPA   #$FF
DFF1: 27 0B          BEQ    $DFFE
DFF3: FC 2A 5E       LDD    $2A5E
DFF6: C3 00 01       ADDD   #$0001
DFF9: FD 2A 5E       STD    $2A5E
DFFC: 0C BD          INC    $BD
DFFE: DC 4C          LDD    $4C
E000: 58             ASLB
E001: 49             ROLA
E002: 58             ASLB
E003: 49             ROLA
E004: F3 29 9E       ADDD   $299E
E007: 97 51          STA    $51
E009: 4F             CLRA
E00A: FD 29 9E       STD    $299E
E00D: DC 4A          LDD    $4A
E00F: 58             ASLB
E010: 49             ROLA
E011: 58             ASLB
E012: 49             ROLA
E013: F3 29 9C       ADDD   $299C
E016: 97 50          STA    $50
E018: 4F             CLRA
E019: FD 29 9C       STD    $299C
E01C: DC 50          LDD    $50
E01E: 1F 21          TFR    Y,X
E020: 0D 4F          TST    $4F
E022: 27 01          BEQ    $E025
E024: 5F             CLRB
E025: 39             RTS

E026: CC 00 00       LDD    #$0000
E029: DD 50          STD    $50
E02B: 96 49          LDA    $49
E02D: D6 4E          LDB    $4E
E02F: 3D             MUL
E030: 97 51          STA    $51
E032: 96 48          LDA    nb_objects_48
E034: D6 4E          LDB    $4E
E036: 3D             MUL
E037: D3 50          ADDD   $50
E039: 39             RTS

E03A: B6 28 09       LDA    $2809
E03D: 10 8E ED E2    LDY    #table_ede2
E041: 48             ASLA
E042: 6E B6          JMP    [A,Y]	; [jump_table]

E044: 10 8E 2B 98    LDY    #$2B98
E048: 86 20          LDA    #$20
E04A: F6 28 DF       LDB    $28DF
E04D: 3D             MUL
E04E: 31 AB          LEAY   D,Y
E050: EC A1          LDD    ,Y++
E052: B7 2A D4       STA    $2AD4
E055: F7 2A DE       STB    $2ADE
E058: EC A4          LDD    ,Y
E05A: B7 28 F4       STA    $28F4
E05D: F7 29 D3       STB    $29D3
E060: CC 01 00       LDD    #$0100
E063: BD 84 F5       JSR    queue_event_84f5
E066: C6 0F          LDB    #$0F
E068: 86 02          LDA    #$02
E06A: BD 84 F5       JSR    queue_event_84f5
E06D: 5C             INCB
E06E: C1 12          CMPB   #$12
E070: 26 F6          BNE    $E068
E072: 7F 28 EA       CLR    $28EA
E075: 86 01          LDA    #$01
E077: B7 28 EB       STA    $28EB
E07A: CC 00 00       LDD    #$0000
E07D: FD 2A 98       STD    $2A98
E080: 7C 28 09       INC    $2809
E083: 39             RTS

E084: 4F             CLRA
E085: 7D 2A D4       TST    $2AD4
E088: 26 05          BNE    $E08F
E08A: 7C 2A D4       INC    $2AD4
E08D: 20 09          BRA    $E098
E08F: B6 2A DE       LDA    $2ADE
E092: 7D 28 F4       TST    $28F4
E095: 26 01          BNE    $E098
E097: 4C             INCA
E098: B7 2A DE       STA    $2ADE
E09B: 81 04          CMPA   #$04
E09D: 24 0F          BCC    $E0AE
E09F: 48             ASLA
E0A0: 48             ASLA
E0A1: 10 8E ED EA    LDY    #high_jump_attempted_heights_edea
E0A5: 31 A6          LEAY   A,Y
E0A7: CE ED FA       LDU    #$EDFA
E0AA: 33 C6          LEAU   A,U
E0AC: 20 3C          BRA    $E0EA

E0AE: 86 0C          LDA    #$0C
E0B0: 10 8E ED EA    LDY    #high_jump_attempted_heights_edea
E0B4: 31 A6          LEAY   A,Y
E0B6: EC A1          LDD    ,Y++
E0B8: FD 28 6A       STD    current_attempted_height_metre_286a
E0BB: EC A4          LDD    ,Y
E0BD: FD 28 6C       STD    current_attempted_height_centimetres_286c
E0C0: CC 00 06       LDD    #$0006
E0C3: FD 28 F0       STD    $28F0
E0C6: CC 00 00       LDD    #$0000
E0C9: FD 28 F2       STD    $28F2
E0CC: 10 8E 28 6E    LDY    #$286E
E0D0: B6 2A DE       LDA    $2ADE
E0D3: 80 03          SUBA   #$03
E0D5: AB A2          ADDA   ,-Y
E0D7: 81 0A          CMPA   #$0A
E0D9: 25 0B          BCS    $E0E6
E0DB: C6 0A          LDB    #$0A
E0DD: BD FB 6A       JSR    $FB6A
E0E0: A7 A4          STA    ,Y
E0E2: 1F 98          TFR    B,A
E0E4: 20 EF          BRA    $E0D5
E0E6: A7 A4          STA    ,Y
E0E8: 20 16          BRA    $E100

E0EA: 8E 28 F0       LDX    #$28F0
E0ED: EC C1          LDD    ,U++
E0EF: ED 81          STD    ,X++
E0F1: EC C4          LDD    ,U
E0F3: ED 84          STD    ,X
E0F5: 8E 28 6A       LDX    #current_attempted_height_metre_286a
E0F8: EC A1          LDD    ,Y++
E0FA: ED 81          STD    ,X++
E0FC: EC A4          LDD    ,Y
E0FE: ED 84          STD    ,X
E100: FC 28 F0       LDD    $28F0
E103: FD 2A 5A       STD    $2A5A
E106: FC 28 F2       LDD    $28F2
E109: FD 2A 5C       STD    $2A5C
E10C: CC 00 00       LDD    #$0000
E10F: FD 28 B0       STD    $28B0
E112: FD 28 B1       STD    $28B1
E115: 86 78          LDA    #$78
E117: B7 2A CF       STA    $2ACF
E11A: 8E 32 D8       LDX    #$32D8
E11D: B6 28 9F       LDA    $289F
E120: C6 00          LDB    #$00
E122: 80 01          SUBA   #$01
E124: 2B 02          BMI    $E128
E126: C6 03          LDB    #$03
E128: E7 89 08 00    STB    $0800,X			; [video_address]
E12C: C6 9D          LDB    #$9D
E12E: E7 80          STB    ,X+			; [video_address]
E130: 8C 32 DB       CMPX   #$32DB
E133: 26 EB          BNE    $E120
E135: 8E 28 6A       LDX    #current_attempted_height_metre_286a
E138: BD 6F 55       JSR    $6F55
E13B: 86 FF          LDA    #$FF
E13D: BD 85 0E       JSR    $850E
E140: 7C 28 09       INC    $2809
E143: 39             RTS

; long jump
E144: 5F             CLRB
E145: B6 28 3F       LDA    $283F
E148: 85 08          BITA   #$08
E14A: 27 05          BEQ    $E151
E14C: CA 03          ORB    #$03
E14E: F8 28 73       EORB   $2873
E151: F7 28 48       STB    $2848
E154: 8E 32 98       LDX    #$3298
E157: 10 8E 28 6A    LDY    #current_attempted_height_metre_286a
E15B: EC A1          LDD    ,Y++
E15D: 4D             TSTA
E15E: 26 02          BNE    $E162
E160: 86 10          LDA    #$10
E162: ED 81          STD    ,X++	; [video_address_word]
E164: 86 A7          LDA    #$A7
E166: A7 80          STA    ,X+		; [video_address]
E168: EC A4          LDD    ,Y
E16A: ED 84          STD    ,X			; [video_address_word]
E16C: 30 89 07 FD    LEAX   $07FD,X
E170: B6 28 48       LDA    $2848
E173: 1F 89          TFR    A,B
E175: ED 81          STD    ,X++   ; [video_address_word]
E177: A7 80          STA    ,X+   ; [video_address]
E179: ED 84          STD    ,X    ; [video_address_word]
E17B: BF 28 48       STX    $2848
E17E: BD FB 8F       JSR    $FB8F
E181: 84 05          ANDA   #$05
E183: 26 0B          BNE    $E190
E185: BD E1 AE       JSR    $E1AE
E188: BD 8E 00       JSR    $8E00
E18B: C1 01          CMPB   #$01
E18D: 27 01          BEQ    $E190
E18F: 39             RTS

E190: BD E1 DC       JSR    $E1DC
E193: 86 02          LDA    #$02
E195: B7 28 B2       STA    $28B2
E198: 7F 28 EB       CLR    $28EB
E19B: 4F             CLRA
E19C: 1F 89          TFR    A,B
E19E: BE 28 48       LDX    $2848
E1A1: ED 84          STD    ,X    ; [video_address_word]
E1A3: 86 09          LDA    #$09
E1A5: A7 82          STA    ,-X		; [video_address]
E1A7: 4F             CLRA
E1A8: ED 83          STD    ,--X   ; [video_address_word]
E1AA: 7C 28 09       INC    $2809
E1AD: 39             RTS

E1AE: 10 8E 35 CC    LDY    #$35CC
E1B2: CC 23 24       LDD    #$2324
E1B5: ED A1          STD    ,Y++	; [video_address_word]
E1B7: CC 11 22       LDD    #$1122
E1BA: ED A1          STD    ,Y++	; [video_address_word]
E1BC: 86 24          LDA    #$24
E1BE: A7 A4          STA    ,Y		; [video_address]
E1C0: B6 28 3F       LDA    $283F
E1C3: 84 04          ANDA   #$04
E1C5: 26 05          BNE    $E1CC
E1C7: CC 08 08       LDD    #$0808
E1CA: 20 03          BRA    $E1CF
E1CC: CC 06 06       LDD    #$0606
E1CF: ED A9 07 FC    STD    $07FC,Y		; [video_address_word]
E1D3: ED A9 07 FE    STD    $07FE,Y		; [video_address_word]
E1D7: A7 A9 08 00    STA    $0800,Y		; [video_address_word]
E1DB: 39             RTS

E1DC: 10 8E 35 CC    LDY    #$35CC
E1E0: CC 10 10       LDD    #$1010
E1E3: ED A1          STD    ,Y++		; [video_address_word]
E1E5: ED A1          STD    ,Y++		; [video_address_word]
E1E7: A7 A4          STA    ,Y				; [video_address]
E1E9: CC 08 08       LDD    #$0808
E1EC: ED A9 07 FC    STD    $07FC,Y	; [video_address_word]
E1F0: ED A9 07 FE    STD    $07FE,Y ; [video_address_word]
E1F4: A7 A9 08 00    STA    $0800,Y ; [video_address_word]
E1F8: 39             RTS

E1F9: 7F 2A D7       CLR    $2AD7
E1FC: B6 28 6C       LDA    current_attempted_height_centimetres_286c
E1FF: C6 0A          LDB    #$0A
E201: 3D             MUL
E202: FB 28 6D       ADDB   $286D
E205: F7 28 49       STB    $2849
E208: B6 28 6B       LDA    current_attempt_height_286b
E20B: C6 64          LDB    #$64
E20D: 3D             MUL
E20E: FB 28 49       ADDB   $2849
E211: F7 28 48       STB    $2848
E214: C1 EC          CMPB   #$EC
E216: 24 09          BCC    $E221
E218: 86 0A          LDA    #$0A
E21A: 3D             MUL
E21B: 58             ASLB
E21C: 49             ROLA
E21D: 58             ASLB
E21E: 49             ROLA
E21F: 20 0B          BRA    $E22C
E221: C0 EB          SUBB   #$EB
E223: 86 32          LDA    #$32
E225: 3D             MUL
E226: 58             ASLB
E227: 49             ROLA
E228: 58             ASLB
E229: 49             ROLA
E22A: 8B 24          ADDA   #$24
E22C: 8B 2B          ADDA   #$2B
E22E: B7 2B 01       STA    $2B01
E231: 86 47          LDA    #$47
E233: B7 2B 11       STA    $2B11
E236: 86 38          LDA    #$38
E238: B7 2A C1       STA    $2AC1
E23B: 86 F8          LDA    #$F8
E23D: B7 2A C2       STA    $2AC2
E240: 4C             INCA
E241: B7 2B 02       STA    $2B02
E244: B7 2B 12       STA    $2B12
E247: 7F 29 80       CLR    $2980
E24A: 7F 2B 20       CLR    $2B20
E24D: FC 2B 01       LDD    $2B01
E250: FD 2B 21       STD    $2B21
E253: 7D 28 21       TST    $2821
E256: 27 06          BEQ    $E25E
E258: 7A 2B 01       DEC    $2B01
E25B: 7A 2B 01       DEC    $2B01
E25E: CC 37 2A       LDD    #$372A
E261: FD 28 E4       STD    $28E4
E264: CC 00 00       LDD    #$0000
E267: FD 2A E1       STD    $2AE1
E26A: CC DC B6       LDD    #$DCB6
E26D: FD 28 AE       STD    $28AE
E270: 86 01          LDA    #$01
E272: B7 28 B7       STA    $28B7
E275: CC 00 00       LDD    #$0000
E278: FD 2A 98       STD    $2A98
E27B: 7F 28 09       CLR    $2809
E27E: 7C 28 06       INC    $2806
E281: 39             RTS

E282: 96 06          LDA    $06
E284: 48             ASLA
E285: 10 8E EE 0A    LDY    #table_ee0a
E289: 6E B6          JMP    [A,Y]	; [jump_table]

E28B: BD D7 FF       JSR    chrono_tick_d7ff
E28E: DC 7E          LDD    chrono_hundredth_second_7e
E290: 10 83 70 02    CMPD   #$7002
E294: 26 0B          BNE    $E2A1
E296: 0D 22          TST    $22
E298: 26 07          BNE    $E2A1
E29A: 86 01          LDA    #$01
E29C: B7 2A 9A       STA    $2A9A
E29F: 0F 3F          CLR    $3F
E2A1: 8E 28 A0       LDX    #$28A0
E2A4: BD 91 07       JSR    $9107
E2A7: BD 94 88       JSR    $9488
E2AA: BD 94 B8       JSR    $94B8
E2AD: 8E 28 A0       LDX    #$28A0
E2B0: BD 93 73       JSR    $9373
E2B3: BD 91 35       JSR    $9135
E2B6: BD 85 87       JSR    $8587
E2B9: BD E2 E5       JSR    $E2E5
E2BC: 8E 29 A0       LDX    #$29A0
E2BF: BD 85 87       JSR    $8587
E2C2: BD 99 B5       JSR    $99B5
E2C5: BD FB 8F       JSR    $FB8F
E2C8: 84 02          ANDA   #$02
E2CA: 27 18          BEQ    $E2E4
E2CC: 86 5A          LDA    #$5A
E2CE: 97 D8          STA    angle_d8
E2D0: DC A1          LDD    p2_attempts_left_a1
E2D2: FD 2A E1       STD    $2AE1
E2D5: BD 88 8A       JSR    $888A
E2D8: BD 8A 03       JSR    $8A03
E2DB: BD 64 1A       JSR    $641A
E2DE: 0F CE          CLR    $CE
E2E0: 0C 06          INC    $06
E2E2: 0F 09          CLR    $09
E2E4: 39             RTS

E2E5: BD 88 52       JSR    $8852
E2E8: A6 A4          LDA    ,Y		; [video_address]
E2EA: 81 AD          CMPA   #$AD
E2EC: 27 01          BEQ    $E2EF
E2EE: 39             RTS

E2EF: 86 01          LDA    #$01
E2F1: 97 C9          STA    jump_foul_C9
E2F3: 97 F4          STA    $F4
E2F5: 86 04          LDA    #$04
E2F7: 97 06          STA    $06
E2F9: 0F 09          CLR    $09
E2FB: 39             RTS

E2FC: 8E 29 A0       LDX    #$29A0
E2FF: 86 03          LDA    #$03
E301: A7 84          STA    ,X
E303: BD CC BD       JSR    $CCBD
E306: 8E 29 60       LDX    #player_1_final_time_2960
E309: 96 DF          LDA    $DF
E30B: C6 0C          LDB    #$0C
E30D: 3D             MUL
E30E: 30 8B          LEAX   D,X
E310: 10 8E 28 6A    LDY    #current_attempted_height_metre_286a
E314: 96 9F          LDA    high_jump_fault_9f
E316: 48             ASLA
E317: 48             ASLA
E318: 30 86          LEAX   A,X
E31A: EC A1          LDD    ,Y++
E31C: ED 81          STD    ,X++
E31E: EC A4          LDD    ,Y
E320: ED 84          STD    ,X
E322: 96 9F          LDA    high_jump_fault_9f
E324: 81 02          CMPA   #$02
E326: 10 26 00 78    LBNE   $E3A2
E32A: 10 8E ED EA    LDY    #high_jump_attempted_heights_edea
E32E: 8E 29 68       LDX    #$2968
E331: 96 DF          LDA    $DF
E333: C6 0C          LDB    #$0C
E335: 3D             MUL
E336: 30 85          LEAX   B,X
E338: BD 89 68       JSR    compare_performances_8968
E33B: 0D 62          TST    $62
E33D: 27 06          BEQ    $E345
E33F: 7C 29 D3       INC    $29D3
E342: 7F 29 D4       CLR    failed_rom_check_29d4
E345: BD 87 7A       JSR    check_player_qualified_877a
E348: 0D CD          TST    player_is_qualified_cd
E34A: 27 56          BEQ    $E3A2
E34C: 7D 29 D3       TST    $29D3
E34F: 27 51          BEQ    $E3A2
E351: 96 3F          LDA    $3F
E353: 84 07          ANDA   #$07
E355: 26 2C          BNE    $E383
E357: B6 29 D4       LDA    failed_rom_check_29d4	; [rom_check_code]
E35A: 81 04          CMPA   #$04                    ; [rom_check_code]
E35C: 27 26          BEQ    $E384                   ; [rom_check_code]
E35E: CE 18 2E       LDU    #$182E
E361: 8E 29 D0       LDX    #$29D0
E364: 10 8E DE D3    LDY    #$DED3
E368: 31 A6          LEAY   A,Y
E36A: CC 36 30       LDD    #$3630
E36D: FD 29 D1       STD    $29D1
E370: BD D1 2F       JSR    $D12F
E373: 7F 2A 8E       CLR    failed_rom_check_2a8e
* rom check!
E376: B6 C4 18       LDA    $C418                     ; [rom_check_code]
E379: 81 B1          CMPA   #$B1                      ; [rom_check_code]
E37B: 27 03          BEQ    $E380                     ; [rom_check_code]
E37D: 7C 2A 8E       INC    failed_rom_check_2a8e     ; [rom_check_code]
E380: 7C 29 D4       INC    failed_rom_check_29d4     ; [rom_check_code]
E383: 39             RTS

E384: B6 29 D1       LDA    $29D1
E387: 8B 10          ADDA   #$10
E389: B7 29 D1       STA    $29D1
E38C: 8E 29 D0       LDX    #$29D0
E38F: CE 18 06       LDU    #$1806
E392: 10 8E DE DB    LDY    #$DEDB
E396: BD D1 2F       JSR    $D12F
E399: BD D5 40       JSR    $D540
E39C: 7F 29 D3       CLR    $29D3
E39F: 7F 29 D4       CLR    failed_rom_check_29d4
E3A2: 0C 06          INC    $06
E3A4: 0C 06          INC    $06
E3A6: 39             RTS

* rom check after 2 faults at high jump, very vicious :)
E3A7: 96 9F          LDA    high_jump_fault_9f     ; [rom_check_code]
E3A9: 81 02          CMPA   #$02            ; [rom_check_code]
E3AB: 26 08          BNE    $E3B5		  ; [rom_check_code]
E3AD: 7D 2A 8E       TST    failed_rom_check_2a8e  ; [rom_check_code]
E3B0: 27 03          BEQ    $E3B5		; [rom_check_code]
E3B2: 7E D0 00       JMP    $D000		; [rom_check_code]
E3B5: 8E 29 A0       LDX    #$29A0
E3B8: 6D 84          TST    ,X
E3BA: 27 07          BEQ    $E3C3
E3BC: 86 02          LDA    #$02
E3BE: A7 84          STA    ,X
E3C0: BD CC BD       JSR    $CCBD
E3C3: 86 05          LDA    #$05
E3C5: 97 06          STA    $06
E3C7: 7F 2A CF       CLR    $2ACF
E3CA: 86 01          LDA    #$01
E3CC: 97 F4          STA    $F4
E3CE: B7 2A B7       STA    $2AB7
E3D1: 86 03          LDA    #$03
E3D3: 8E 3A D7       LDX    #$3AD7
E3D6: D6 9F          LDB    high_jump_fault_9f
E3D8: 5C             INCB
E3D9: A7 85          STA    B,X		; [video_address]
E3DB: 86 82          LDA    #$82
E3DD: BD 85 0E       JSR    $850E
E3E0: 86 FF          LDA    #$FF
E3E2: BD 85 0E       JSR    $850E
E3E5: 39             RTS

E3E6: B6 2A CF       LDA    $2ACF
E3E9: 8B 08          ADDA   #$08
E3EB: 27 04          BEQ    $E3F1
E3ED: B7 2A CF       STA    $2ACF
E3F0: 39             RTS

E3F1: 0F 06          CLR    $06
E3F3: 0F 09          CLR    $09
E3F5: 0C 03          INC    boot_state_03
E3F7: 10 8E 2B 98    LDY    #$2B98
E3FB: 86 20          LDA    #$20
E3FD: D6 DF          LDB    $DF
E3FF: 3D             MUL
E400: 31 AB          LEAY   D,Y
E402: B6 2A D4       LDA    $2AD4
E405: F6 2A DE       LDB    $2ADE
E408: ED A1          STD    ,Y++
E40A: 96 F4          LDA    $F4
E40C: F6 29 D3       LDB    $29D3
E40F: ED A4          STD    ,Y
E411: 39             RTS

E412: 8E EE 16       LDX    #table_ee16
E415: 96 09          LDA    $09
E417: 48             ASLA
E418: 6E 96          JMP    [A,X]		; [jump_table]

E41A: DC A1          LDD    p2_attempts_left_a1
E41C: FD 2A E1       STD    $2AE1
E41F: 0F C9          CLR    jump_foul_C9
E421: 0F F4          CLR    $F4
E423: 7F 2B 25       CLR    $2B25
E426: 0F BD          CLR    $BD
E428: B6 2A C2       LDA    $2AC2
E42B: 8B 06          ADDA   #$06
E42D: B7 2A CB       STA    $2ACB
E430: BD E4 52       JSR    $E452
E433: 0C 09          INC    $09
E435: 7F 2A C5       CLR    $2AC5
E438: 7F 2A C9       CLR    $2AC9
E43B: 7F 2B 28       CLR    $2B28
E43E: 0F FC          CLR    $FC
E440: 0F 3F          CLR    $3F
E442: 86 05          LDA    #$05
E444: BD 85 0E       JSR    $850E
E447: 86 14          LDA    #$14
E449: BD 85 0E       JSR    $850E
E44C: 86 15          LDA    #$15
E44E: BD 85 0E       JSR    $850E
E451: 39             RTS

E452: 96 B0          LDA    $B0
E454: C6 0A          LDB    #$0A
E456: 3D             MUL
E457: DB B1          ADDB   $B1
E459: 86 09          LDA    #$09
E45B: 3D             MUL
E45C: 96 D8          LDA    angle_d8
E45E: 10 8E ED 7B    LDY    #$ED7B
E462: A6 A6          LDA    A,Y
E464: 3D             MUL
E465: 4A             DECA
E466: 4A             DECA
E467: 4A             DECA
E468: 1F 89          TFR    A,B
E46A: FD 2A D0       STD    $2AD0
E46D: 7F 2A D2       CLR    $2AD2
E470: 39             RTS

E471: BD FB A7       JSR    $FBA7
E474: 84 02          ANDA   #$02
E476: 27 10          BEQ    $E488
E478: C6 14          LDB    #$14
E47A: D1 D8          CMPB   angle_d8
E47C: 27 0A          BEQ    $E488
E47E: 0A D8          DEC    angle_d8
E480: 86 08          LDA    #$08
E482: BD 84 F5       JSR    queue_event_84f5
E485: BD 8A 03       JSR    $8A03
E488: BD FB 8F       JSR    $FB8F
E48B: 84 05          ANDA   #$05
E48D: 27 04          BEQ    $E493
E48F: 0C B3          INC    $B3
E491: 0C B3          INC    $B3
E493: BD E6 01       JSR    $E601
E496: 8E 28 A0       LDX    #$28A0
E499: BD DE FF       JSR    $DEFF
E49C: DD 48          STD    nb_objects_48
E49E: 7D 2A C9       TST    $2AC9
E4A1: 26 09          BNE    $E4AC
E4A3: C1 00          CMPB   #$00
E4A5: 2A 05          BPL    $E4AC
E4A7: C6 FF          LDB    #$FF
E4A9: F7 2A C9       STB    $2AC9
E4AC: 4F             CLRA
E4AD: 7A 2A D1       DEC    $2AD1
E4B0: 26 16          BNE    $E4C8
E4B2: B6 2A D0       LDA    $2AD0
E4B5: B7 2A D1       STA    $2AD1
E4B8: 7C 2A D2       INC    $2AD2
E4BB: B6 2A D2       LDA    $2AD2
E4BE: 81 02          CMPA   #$02
E4C0: 26 06          BNE    $E4C8
E4C2: 96 A1          LDA    p2_attempts_left_a1
E4C4: 8B 04          ADDA   #$04
E4C6: 97 A1          STA    p2_attempts_left_a1
E4C8: B6 2A D2       LDA    $2AD2
E4CB: 10 8E EE 1C    LDY    #$EE1C
E4CF: 48             ASLA
E4D0: 10 AE A6       LDY    A,Y
E4D3: 10 8C FF FF    CMPY   #$FFFF
E4D7: 26 07          BNE    $E4E0
E4D9: 86 03          LDA    #$03
E4DB: B7 2A D2       STA    $2AD2
E4DE: 20 E8          BRA    $E4C8
E4E0: 8E 28 A0       LDX    #$28A0
E4E3: DC 48          LDD    nb_objects_48
E4E5: 9B A2          ADDA   $A2
E4E7: DB A1          ADDB   p2_attempts_left_a1
E4E9: 97 A2          STA    $A2
E4EB: D7 A1          STB    p2_attempts_left_a1
E4ED: CE 18 08       LDU    #$1808
E4F0: BD CE D3       JSR    $CED3
E4F3: 0D C9          TST    jump_foul_C9
E4F5: 26 43          BNE    $E53A
E4F7: 96 A2          LDA    $A2
E4F9: 8B 0F          ADDA   #$0F
E4FB: B1 2A CB       CMPA   $2ACB
E4FE: 25 3A          BCS    $E53A
E500: 80 1F          SUBA   #$1F
E502: B1 2A CB       CMPA   $2ACB
E505: 22 33          BHI    $E53A
E507: B6 2A D2       LDA    $2AD2
E50A: 48             ASLA
E50B: 48             ASLA
E50C: 48             ASLA
E50D: 48             ASLA
E50E: 48             ASLA
E50F: 8E EE 32       LDX    #$EE32
E512: 30 86          LEAX   A,X
E514: 96 A2          LDA    $A2
E516: 8B 0F          ADDA   #$0F
E518: B0 2A CB       SUBA   $2ACB
E51B: A6 86          LDA    A,X
E51D: 81 21          CMPA   #$21
E51F: 27 19          BEQ    $E53A
E521: 9B A1          ADDA   p2_attempts_left_a1
E523: 80 0F          SUBA   #$0F
E525: B1 2B 21       CMPA   $2B21
E528: 22 10          BHI    $E53A
E52A: 0C C9          INC    jump_foul_C9
E52C: 0C F4          INC    $F4
E52E: 7C 2B 25       INC    $2B25
E531: 4F             CLRA
E532: BD 85 0E       JSR    $850E
E535: 86 13          LDA    #$13
E537: BD 85 0E       JSR    $850E
E53A: 96 A1          LDA    p2_attempts_left_a1
E53C: 81 37          CMPA   #$37
E53E: 23 03          BLS    $E543
E540: B7 2A C5       STA    $2AC5
E543: 7D 2A C9       TST    $2AC9
E546: 27 1E          BEQ    $E566
E548: 8E 28 A0       LDX    #$28A0
E54B: BD 85 87       JSR    $8587
E54E: 9E A3          LDX    $A3
E550: A6 88 C0       LDA    -$40,X		; [video_address]
E553: 5F             CLRB
E554: 81 AD          CMPA   #$AD
E556: 27 0F          BEQ    $E567
E558: 81 AF          CMPA   #$AF
E55A: 27 0B          BEQ    $E567
E55C: C6 08          LDB    #$08
E55E: 81 B3          CMPA   #$B3
E560: 27 05          BEQ    $E567
E562: 81 B6          CMPA   #$B6
E564: 27 01          BEQ    $E567
E566: 39             RTS

E567: 96 A2          LDA    $A2
E569: 8B 0F          ADDA   #$0F
E56B: B1 2A CB       CMPA   $2ACB
E56E: 24 04          BCC    $E574
E570: 0C C9          INC    jump_foul_C9
E572: 0C F4          INC    $F4
E574: 86 00          LDA    #$00
E576: BD 85 0E       JSR    $850E
E579: 96 C9          LDA    jump_foul_C9
E57B: 27 07          BEQ    $E584
E57D: 86 2E          LDA    #$2E
E57F: BD 85 0E       JSR    $850E
E582: 20 05          BRA    $E589
E584: 86 2B          LDA    #$2B
E586: BD 85 0E       JSR    $850E
E589: 96 A1          LDA    p2_attempts_left_a1
E58B: 80 04          SUBA   #$04
E58D: 97 A1          STA    p2_attempts_left_a1
E58F: F7 2A CA       STB    $2ACA
E592: 0C 09          INC    $09
E594: 86 0A          LDA    #$0A
E596: B7 2A C8       STA    $2AC8
E599: CC 00 00       LDD    #$0000
E59C: FD 2A C6       STD    $2AC6
E59F: 39             RTS

E5A0: BD E6 01       JSR    $E601
E5A3: 7A 2A C8       DEC    $2AC8
E5A6: 27 01          BEQ    $E5A9
E5A8: 39             RTS

E5A9: 10 BE 2A C6    LDY    $2AC6
E5AD: 10 8C 00 00    CMPY   #$0000
E5B1: 26 04          BNE    $E5B7
E5B3: 10 8E EE B2    LDY    #$EEB2
E5B7: EC A1          LDD    ,Y++
E5B9: 81 FF          CMPA   #$FF
E5BB: 27 1F          BEQ    $E5DC
E5BD: 9B A2          ADDA   $A2
E5BF: DB A1          ADDB   p2_attempts_left_a1
E5C1: 97 A2          STA    $A2
E5C3: D7 A1          STB    p2_attempts_left_a1
E5C5: A6 A0          LDA    ,Y+
E5C7: B7 2A C8       STA    $2AC8
E5CA: 30 22          LEAX   $2,Y
E5CC: BF 2A C6       STX    $2AC6
E5CF: 10 AE A4       LDY    ,Y
E5D2: CE 18 08       LDU    #$1808
E5D5: 8E 28 A0       LDX    #$28A0
E5D8: BD CE D3       JSR    $CED3
E5DB: 39             RTS

E5DC: 8E 18 10       LDX    #$1810
E5DF: 10 8E 1C 10    LDY    #$1C10
E5E3: CC FF FF       LDD    #$FFFF
E5E6: ED 81          STD    ,X++
E5E8: ED A1          STD    ,Y++
E5EA: 8C 18 20       CMPX   #$1820
E5ED: 26 F7          BNE    $E5E6
E5EF: B6 2A CA       LDA    $2ACA
E5F2: 9B A1          ADDA   p2_attempts_left_a1
E5F4: 97 A1          STA    p2_attempts_left_a1
E5F6: 0F 09          CLR    $09
E5F8: 0C 06          INC    $06
E5FA: 96 06          LDA    $06
E5FC: 9B C9          ADDA   jump_foul_C9
E5FE: 97 06          STA    $06
E600: 39             RTS

E601: 7D 2B 20       TST    $2B20
E604: 27 42          BEQ    $E648
E606: 7D 2B 25       TST    $2B25
E609: 27 2D          BEQ    $E638
E60B: 7C 2B 28       INC    $2B28
E60E: B6 2B 28       LDA    $2B28
E611: 47             ASRA
E612: 25 24          BCS    $E638
E614: 47             ASRA
E615: 25 21          BCS    $E638
E617: 47             ASRA
E618: 25 1E          BCS    $E638
E61A: 7C 2B 22       INC    $2B22
E61D: 7C 2B 22       INC    $2B22
E620: 40             NEGA
E621: BB 2B 21       ADDA   $2B21
E624: B1 2A C1       CMPA   $2AC1
E627: 24 0C          BCC    $E635
E629: 7F 2B 25       CLR    $2B25
E62C: 86 10          LDA    #$10
E62E: BD 85 0E       JSR    $850E
E631: B6 2A C1       LDA    $2AC1
E634: 4C             INCA
E635: B7 2B 21       STA    $2B21
E638: 10 8E DD 94    LDY    #$DD94
E63C: CE 18 28       LDU    #$1828
E63F: 8E 2B 20       LDX    #$2B20
E642: BD D1 2F       JSR    $D12F
E645: 8E 28 A0       LDX    #$28A0
E648: 39             RTS

E649: 96 06          LDA    $06
E64B: 48             ASLA
E64C: 10 8E EE D3    LDY    #table_eed3
E650: 6E B6          JMP    [A,Y]		; [jump_table]

E652: 96 09          LDA    $09
E654: 48             ASLA
E655: 8E EE E1       LDX    #table_eee1
E658: 6E 96          JMP    [A,X]		; [jump_table]

E65A: BD 90 E8       JSR    $90E8
E65D: 86 05          LDA    #$05
E65F: 5D             TSTB
E660: 27 02          BEQ    $E664
E662: 86 1E          LDA    #$1E
E664: B7 29 9C       STA    $299C
E667: 0C 09          INC    $09
E669: 39             RTS

E66A: 7A 29 9C       DEC    $299C
E66D: 10 26 00 8B    LBNE   $E6FC
E671: CC 00 00       LDD    #$0000
E674: DD B0          STD    $B0
E676: DD B2          STD    $B2
E678: FD 2B 18       STD    $2B18
E67B: FD 2B 20       STD    $2B20
E67E: DD 7E          STD    chrono_hundredth_second_7e
E680: 97 EA          STA    display_chrono_ea
E682: FD 29 9C       STD    $299C
E685: FD 29 9E       STD    $299E
E688: FD 2A 98       STD    $2A98
E68B: 86 14          LDA    #$14
E68D: 97 D8          STA    angle_d8
E68F: 86 03          LDA    #$03
E691: 97 B7          STA    $B7
E693: CC 01 09       LDD    #$0109
E696: FD 2B 1E       STD    $2B1E
E699: CC DC E9       LDD    #$DCE9
E69C: DD AE          STD    $AE
E69E: 86 01          LDA    #$01
E6A0: 97 EB          STA    $EB
E6A2: 97 DA          STA    $DA
E6A4: 0F 97          CLR    $97
E6A6: 7F 29 A0       CLR    $29A0
E6A9: 0F BD          CLR    $BD
E6AB: CC 28 F8       LDD    #$28F8
E6AE: FD 2B 21       STD    $2B21
E6B1: 7F 2B 20       CLR    $2B20
E6B4: 7F 2B 28       CLR    $2B28
E6B7: 4F             CLRA
E6B8: 5F             CLRB
E6B9: FD 2B 18       STD    $2B18
E6BC: FD 2B 1A       STD    $2B1A
E6BF: DD FE          STD    $FE
E6C1: B7 2B 1C       STA    $2B1C
E6C4: B7 29 9C       STA    $299C
E6C7: B7 2B 2F       STA    $2B2F
E6CA: CC 01 00       LDD    #$0100
E6CD: BD 84 F5       JSR    queue_event_84f5
E6D0: CC 02 0C       LDD    #$020C
E6D3: BD 84 F5       JSR    queue_event_84f5
E6D6: CC 02 17       LDD    #$0217
E6D9: BD 84 F5       JSR    queue_event_84f5
E6DC: CC 01 0A       LDD    #$010A
E6DF: BD 84 F5       JSR    queue_event_84f5
E6E2: CC 02 3C       LDD    #$023C
E6E5: BD 84 F5       JSR    queue_event_84f5
E6E8: CC 36 16       LDD    #$3616
E6EB: DD E4          STD    $E4
E6ED: BD 88 8A       JSR    $888A
E6F0: BD 64 82       JSR    $6482
E6F3: 86 28          LDA    #$28
E6F5: BD 85 0E       JSR    $850E
E6F8: 0C 06          INC    $06
E6FA: 0F 09          CLR    $09
E6FC: 39             RTS

; javelin
E6FD: BD E1 AE       JSR    $E1AE
E700: BD FB 8F       JSR    $FB8F
E703: 84 05          ANDA   #$05
E705: 26 22          BNE    $E729
E707: BD 8E 00       JSR    $8E00
E70A: C1 01          CMPB   #$01
E70C: 27 28          BEQ    $E736
E70E: FC 2A 98       LDD    $2A98
E711: 10 83 40 01    CMPD   #$4001
E715: 27 0C          BEQ    $E723
E717: 10 83 80 01    CMPD   #$8001
E71B: 27 06          BEQ    $E723
E71D: 10 83 C0 01    CMPD   #$C001
E721: 26 05          BNE    $E728
E723: 86 2F          LDA    #$2F
E725: BD 85 0E       JSR    $850E
E728: 39             RTS

E729: BD E1 DC       JSR    $E1DC
E72C: CC DD 9B       LDD    #$DD9B
E72F: DD AE          STD    $AE
E731: 0F EB          CLR    $EB
E733: 0C 06          INC    $06
E735: 39             RTS

E736: BD E1 DC       JSR    $E1DC
E739: BD E7 ED       JSR    $E7ED
E73C: 10 8E 18 00    LDY    #sprite_ram_1800
E740: 86 06          LDA    #$06
E742: C6 00          LDB    #$00
E744: E7 A9 04 00    STB    $0400,Y
E748: E7 A0          STB    ,Y+
E74A: 4A             DECA
E74B: 26 F7          BNE    $E744
E74D: 86 05          LDA    #$05
E74F: 97 06          STA    $06
E751: 16 02 40       LBRA   $E994
E754: BD D7 FF       JSR    chrono_tick_d7ff
E757: DC 7E          LDD    chrono_hundredth_second_7e
E759: C1 40          CMPB   #$40
E75B: 27 D9          BEQ    $E736
E75D: 0D 22          TST    $22
E75F: 26 11          BNE    $E772
E761: 10 83 80 03    CMPD   #$8003
E765: 26 0B          BNE    $E772
E767: 86 01          LDA    #$01
E769: B7 2A 9A       STA    $2A9A
E76C: 96 3F          LDA    $3F
E76E: 84 07          ANDA   #$07
E770: 97 3F          STA    $3F
E772: 8E 28 A0       LDX    #$28A0
E775: BD 93 CD       JSR    $93CD
E778: BD 94 88       JSR    $9488
E77B: BD 94 B8       JSR    $94B8
E77E: BD 93 73       JSR    $9373
E781: BD 91 35       JSR    $9135
E784: DC A1          LDD    p2_attempts_left_a1
E786: FD 2B 38       STD    $2B38
E789: BD E9 C4       JSR    update_carried_javelin_sprite_e9c4
E78C: 8E 28 A0       LDX    #$28A0
E78F: 86 09          LDA    #$09
E791: BD 84 F5       JSR    queue_event_84f5	; update_speed_bar_64d9
E794: BD 85 87       JSR    $8587
E797: 86 8A          LDA    #$8A
E799: C6 C3          LDB    #$C3
E79B: 10 9E A3       LDY    $A3
E79E: 31 A8 40       LEAY   $40,Y
E7A1: A1 A4          CMPA   ,Y				; [video_address]
E7A3: 26 03          BNE    $E7A8
E7A5: BD E7 ED       JSR    $E7ED
E7A8: E1 A4          CMPB   ,Y		; [video_address]
E7AA: 10 27 00 4C    LBEQ   $E7FA
E7AE: 10 8C 36 40    CMPY   #$3640
E7B2: 26 03          BNE    $E7B7
E7B4: 31 A8 40       LEAY   $40,Y
E7B7: A1 3F          CMPA   -$1,Y		; [video_address]
E7B9: 26 03          BNE    $E7BE
E7BB: BD E7 ED       JSR    $E7ED
E7BE: E1 3F          CMPB   -$1,Y		; [video_address]
E7C0: 10 27 00 36    LBEQ   $E7FA
E7C4: 8E 29 A0       LDX    #$29A0
E7C7: BD 85 87       JSR    $8587
E7CA: BD 99 B5       JSR    $99B5
E7CD: BD EC B7       JSR    $ECB7
E7D0: BD FB 8F       JSR    $FB8F
E7D3: 84 02          ANDA   #$02
E7D5: 26 01          BNE    $E7D8
E7D7: 39             RTS

E7D8: 10 8E DD 9B    LDY    #$DD9B
E7DC: 10 9F AE       STY    $AE
E7DF: CE 18 08       LDU    #$1808
E7E2: 8E 28 A0       LDX    #$28A0
E7E5: BD CE D3       JSR    $CED3
E7E8: 0F 09          CLR    $09
E7EA: 0C 06          INC    $06
E7EC: 39             RTS

E7ED: 86 02          LDA    #$02
E7EF: B7 29 A0       STA    $29A0
E7F2: 86 01          LDA    #$01
E7F4: 97 C9          STA    jump_foul_C9
E7F6: BD ED 61       JSR    $ED61
E7F9: 39             RTS

E7FA: 10 8E 18 00    LDY    #sprite_ram_1800
E7FE: 86 06          LDA    #$06
E800: C6 00          LDB    #$00
E802: E7 A9 04 00    STB    $0400,Y
E806: E7 A0          STB    ,Y+
E808: 4A             DECA
E809: 26 F7          BNE    $E802
E80B: 0F 09          CLR    $09
E80D: 86 05          LDA    #$05
E80F: 97 06          STA    $06
E811: 39             RTS

E812: 96 09          LDA    $09
E814: 48             ASLA
E815: 10 8E EE E5    LDY    #table_eee5
E819: 6E B6          JMP    [A,Y]	; [jump_table]

E81B: CC 00 00       LDD    #$0000
E81E: FD 2B 3A       STD    $2B3A
E821: FD 2A DB       STD    $2ADB
E824: DD 6E          STD    $6E
E826: DD 70          STD    $70
E828: 86 08          LDA    #$08
E82A: B7 2B 3C       STA    $2B3C
E82D: DC D8          LDD    angle_d8
E82F: FD 2B 3E       STD    $2B3E
E832: 7F 2B 1D       CLR    $2B1D
E835: 7F 2B 17       CLR    $2B17
E838: 0F BD          CLR    $BD
E83A: 86 0E          LDA    #$0E
E83C: BD 85 0E       JSR    $850E
E83F: 86 FF          LDA    #$FF
E841: 97 B7          STA    $B7
E843: 0C 09          INC    $09
E845: 39             RTS

E846: 7A 2B 3C       DEC    $2B3C
E849: 26 3F          BNE    $E88A
E84B: BD FB A7       JSR    $FBA7
E84E: 84 02          ANDA   #$02
E850: 27 02          BEQ    $E854
E852: 0C D8          INC    angle_d8
E854: B6 2B 3B       LDA    $2B3B
E857: 81 02          CMPA   #$02
E859: 27 30          BEQ    $E88B
E85B: 48             ASLA
E85C: 10 8E EE ED    LDY    #$EEED
E860: 10 AE A6       LDY    A,Y
E863: CE 18 08       LDU    #$1808
E866: 8E 28 A0       LDX    #$28A0
E869: BD CE D3       JSR    $CED3
E86C: 10 9F AE       STY    $AE
E86F: 96 B5          LDA    $B5
E871: 40             NEGA
E872: AB 02          ADDA   $2,X
E874: A7 02          STA    $2,X
E876: BD 91 B0       JSR    $91B0
E879: BD ED 61       JSR    $ED61
E87C: BD ED 09       JSR    $ED09
E87F: 86 06          LDA    #$06
E881: B7 2B 3C       STA    $2B3C
E884: 7C 2B 3B       INC    $2B3B
E887: BD EC B7       JSR    $ECB7
E88A: 39             RTS

E88B: 86 01          LDA    #$01
E88D: 97 A0          STA    $A0
E88F: 86 FF          LDA    #$FF
E891: 97 B7          STA    $B7
E893: 0C 09          INC    $09
E895: 86 14          LDA    #$14
E897: BD 85 0E       JSR    $850E
E89A: 86 15          LDA    #$15
E89C: BD 85 0E       JSR    $850E
E89F: 39             RTS

E8A0: B6 2B 17       LDA    $2B17
E8A3: 10 8E EE F3    LDY    #table_eef3
E8A7: 48             ASLA
E8A8: 6E B6          JMP    [A,Y]	; [jump_table]

E8AA: BD FB A7       JSR    $FBA7
E8AD: 84 02          ANDA   #$02
E8AF: 26 05          BNE    $E8B6
E8B1: 7C 2B 17       INC    $2B17
E8B4: 20 0C          BRA    $E8C2
E8B6: BD EA 66       JSR    $EA66
E8B9: 96 D8          LDA    angle_d8
E8BB: 81 50          CMPA   #$50
E8BD: 26 03          BNE    $E8C2
E8BF: 7C 2B 17       INC    $2B17
E8C2: BD 88 8A       JSR    $888A
E8C5: BD 64 82       JSR    $6482
E8C8: 7E E8 D4       JMP    $E8D4
E8CB: BD EA 79       JSR    $EA79
E8CE: 7C 2B 17       INC    $2B17
E8D1: 7E E8 D4       JMP    $E8D4
E8D4: BD EB 20       JSR    $EB20
E8D7: 7D 2B 3A       TST    $2B3A
E8DA: 26 5D          BNE    $E939
E8DC: 39             RTS

E8DD: BD DE FF       JSR    $DEFF
E8E0: FB 2B 38       ADDB   $2B38
E8E3: F7 2B 38       STB    $2B38
E8E6: FC 2B 38       LDD    $2B38
E8E9: FD 2B 31       STD    $2B31
E8EC: 8E 2B 30       LDX    #$2B30
E8EF: CE 18 00       LDU    #sprite_ram_1800
E8F2: 10 8E DE D7    LDY    #$DED7
E8F6: BD D1 2F       JSR    $D12F
E8F9: 86 04          LDA    #$04
E8FB: A4 C4          ANDA   ,U
E8FD: A7 C4          STA    ,U
E8FF: 86 C5          LDA    #$C5
E901: 97 49          STA    $49
E903: 86 02          LDA    #$02
E905: 97 48          STA    nb_objects_48
E907: B6 2B 31       LDA    $2B31
E90A: 8B 10          ADDA   #$10
E90C: 81 28          CMPA   #$28
E90E: 25 14          BCS    $E924
E910: B7 2B 31       STA    $2B31
E913: 33 42          LEAU   $2,U
E915: 31 21          LEAY   $1,Y
E917: BD D1 2F       JSR    $D12F
E91A: 96 49          LDA    $49
E91C: A7 C4          STA    ,U
E91E: 0C 49          INC    $49
E920: 0A 48          DEC    nb_objects_48
E922: 26 E3          BNE    $E907
E924: B6 2B 38       LDA    $2B38
E927: 81 38          CMPA   #$38
E929: 25 01          BCS    $E92C
E92B: 39             RTS

E92C: CE 18 04       LDU    #$1804
E92F: 10 8E DE DB    LDY    #$DEDB
E933: BD D1 2F       JSR    $D12F
E936: BD D5 40       JSR    $D540
E939: 0D C9          TST    jump_foul_C9
E93B: 26 05          BNE    $E942
E93D: 7D 2B 1D       TST    $2B1D
E940: 26 02          BNE    $E944
E942: 0C 06          INC    $06
E944: 86 00          LDA    #$00
E946: BD 85 0E       JSR    $850E
E949: 86 0F          LDA    #$0F
E94B: BD 85 0E       JSR    $850E
E94E: 0F 09          CLR    $09
E950: 0C 06          INC    $06
E952: 39             RTS

E953: 8E 29 A0       LDX    #$29A0
E956: 86 03          LDA    #$03
E958: A7 84          STA    ,X
E95A: BD CC BD       JSR    $CCBD
E95D: 10 8E 2B 18    LDY    #$2B18
E961: 8E 29 60       LDX    #player_1_final_time_2960
E964: 96 DF          LDA    $DF
E966: C6 0C          LDB    #$0C
E968: 3D             MUL
E969: 30 8B          LEAX   D,X
E96B: 96 9F          LDA    high_jump_fault_9f
E96D: 48             ASLA
E96E: 48             ASLA
E96F: 30 86          LEAX   A,X
E971: EC A1          LDD    ,Y++
E973: ED 81          STD    ,X++
E975: EC A4          LDD    ,Y
E977: A7 84          STA    ,X
E979: BD 87 09       JSR    $8709
E97C: 86 06          LDA    #$06
E97E: 97 06          STA    $06
E980: 0F 09          CLR    $09
E982: 7F 2A CF       CLR    $2ACF
E985: 39             RTS

E986: 8E 29 A0       LDX    #$29A0
E989: 6D 84          TST    ,X
E98B: 27 07          BEQ    $E994
E98D: 86 02          LDA    #$02
E98F: A7 84          STA    ,X
E991: BD CC BD       JSR    $CCBD
E994: 8E 29 60       LDX    #player_1_final_time_2960
E997: 96 DF          LDA    $DF
E999: C6 0C          LDB    #$0C
E99B: 3D             MUL
E99C: 30 8B          LEAX   D,X
E99E: 96 9F          LDA    high_jump_fault_9f
E9A0: 48             ASLA
E9A1: 48             ASLA
E9A2: 30 86          LEAX   A,X
E9A4: 86 16          LDA    #$16
E9A6: A7 80          STA    ,X+
E9A8: 86 1F          LDA    #$1F
E9AA: A7 80          STA    ,X+
E9AC: 86 25          LDA    #$25
E9AE: A7 80          STA    ,X+
E9B0: 86 1C          LDA    #$1C
E9B2: A7 84          STA    ,X
E9B4: BD 87 09       JSR    $8709
E9B7: 0C 06          INC    $06
E9B9: 7F 2A CF       CLR    $2ACF
E9BC: 39             RTS

E9BD: 0F 06          CLR    $06
E9BF: 0F 09          CLR    $09
E9C1: 0C 03          INC    boot_state_03
E9C3: 39             RTS

update_carried_javelin_sprite_e9c4:
E9C4: 96 21          LDA    copy_of_screen_flipped_21
E9C6: 43             COMA
E9C7: 1C 00          ANDCC  #$00
E9C9: 46             RORA
E9CA: 46             RORA
E9CB: 46             RORA
E9CC: 84 43          ANDA   #$43
E9CE: 97 4F          STA    $4F
E9D0: 96 D8          LDA    angle_d8
E9D2: C6 05          LDB    #$05
E9D4: BD FB 6A       JSR    $FB6A
E9D7: D7 48          STB    nb_objects_48
E9D9: C1 00          CMPB   #$00
E9DB: 2A 07          BPL    $E9E4
E9DD: 50             NEGB
E9DE: 96 4F          LDA    $4F
E9E0: 8A 80          ORA    #$80
E9E2: 97 4F          STA    $4F
E9E4: CB E0          ADDB   #$E0
E9E6: D7 4E          STB    $4E
E9E8: 10 8E EF 53    LDY    #$EF53
E9EC: 96 48          LDA    nb_objects_48
E9EE: C6 06          LDB    #$06
E9F0: 3D             MUL
E9F1: 31 A5          LEAY   B,Y

update_flying_javelin_sprite_e9f3:
E9F3: 8E 2B 30       LDX    #$2B30
E9F6: CE 17 FE       LDU    #$17FE	; sprite_ram_1800-2
E9F9: 86 03          LDA    #$03
E9FB: 97 48          STA    nb_objects_48	; javelin is 3 objects
; loop to update objects
E9FD: EC 08          LDD    $8,X
E9FF: AB A0          ADDA   ,Y+
EA01: EB A0          ADDB   ,Y+
EA03: ED 01          STD    $1,X
EA05: 33 42          LEAU   $2,U	; next sprite block
EA07: 0C 4F          INC    $4F
EA09: 34 20          PSHS   Y
EA0B: 10 8E 28 4E    LDY    #$284E
EA0F: BD D1 2F       JSR    $D12F
EA12: 96 4F          LDA    $4F
EA14: A7 C4          STA    ,U
EA16: 35 20          PULS   Y
EA18: 0A 48          DEC    nb_objects_48
EA1A: 26 E1          BNE    $E9FD
EA1C: 39             RTS

EA1D: 8E 28 A0       LDX    #$28A0
EA20: CC 10 05       LDD    #$1005
EA23: AB 01          ADDA   $1,X
EA25: EB 02          ADDB   $2,X
EA27: FD 2B 31       STD    $2B31
EA2A: CE 18 00       LDU    #sprite_ram_1800
EA2D: 8E 2B 30       LDX    #$2B30
EA30: 10 8E 28 4E    LDY    #$284E
EA34: CC E0 44       LDD    #$E044
EA37: DD 4E          STD    $4E
EA39: BD D1 2F       JSR    $D12F
EA3C: 96 21          LDA    copy_of_screen_flipped_21
EA3E: 43             COMA
EA3F: 1C 00          ANDCC  #$00
EA41: 46             RORA
EA42: 46             RORA
EA43: 46             RORA
EA44: 84 44          ANDA   #$44
EA46: A7 C4          STA    ,U
EA48: 97 4F          STA    $4F
EA4A: 86 02          LDA    #$02
EA4C: 97 48          STA    nb_objects_48
EA4E: A6 02          LDA    $2,X
EA50: 80 10          SUBA   #$10
EA52: 2B 11          BMI    $EA65
EA54: A7 02          STA    $2,X
EA56: 33 42          LEAU   $2,U
EA58: 6C 21          INC    $1,Y
EA5A: BD D1 2F       JSR    $D12F
EA5D: 96 4F          LDA    $4F
EA5F: A7 C4          STA    ,U
EA61: 0A 48          DEC    nb_objects_48
EA63: 26 E9          BNE    $EA4E
EA65: 39             RTS

EA66: D6 D8          LDB    angle_d8
EA68: C1 50          CMPB   #$50
EA6A: 27 0C          BEQ    $EA78
EA6C: 0C D8          INC    angle_d8
EA6E: 96 D8          LDA    angle_d8
EA70: C6 05          LDB    #$05
EA72: BD FB 6A       JSR    $FB6A
EA75: F7 2A DA       STB    $2ADA
EA78: 39             RTS

EA79: BD FB 26       JSR    $FB26
EA7C: DC B0          LDD    $B0
EA7E: 81 01          CMPA   #$01
EA80: 26 0E          BNE    $EA90
EA82: C1 03          CMPB   #$03
EA84: 25 0A          BCS    $EA90
EA86: CC 01 03       LDD    #$0103
EA89: DD B0          STD    $B0
EA8B: CC 00 00       LDD    #$0000
EA8E: DD B2          STD    $B2
EA90: 86 03          LDA    #$03
EA92: 9B B1          ADDA   $B1
EA94: 19             DAA
EA95: 85 F0          BITA   #$F0
EA97: 27 04          BEQ    $EA9D
EA99: 0C B0          INC    $B0
EA9B: 84 0F          ANDA   #$0F
EA9D: 97 B1          STA    $B1
EA9F: 86 03          LDA    #$03
EAA1: 9B B2          ADDA   $B2
EAA3: 19             DAA
EAA4: 85 F0          BITA   #$F0
EAA6: 27 04          BEQ    $EAAC
EAA8: 0C B1          INC    $B1
EAAA: 84 0F          ANDA   #$0F
EAAC: 97 B2          STA    $B2
EAAE: 0D 9F          TST    high_jump_fault_9f
EAB0: 27 37          BEQ    $EAE9
EAB2: D6 DF          LDB    $DF
EAB4: 10 8E 29 60    LDY    #player_1_final_time_2960
EAB8: 86 0C          LDA    #$0C
EABA: 3D             MUL
EABB: 31 A5          LEAY   B,Y
EABD: 96 9F          LDA    high_jump_fault_9f
EABF: 4A             DECA
EAC0: 48             ASLA
EAC1: 48             ASLA
EAC2: 31 A6          LEAY   A,Y
EAC4: A6 A4          LDA    ,Y
EAC6: 81 16          CMPA   #$16
EAC8: 27 1F          BEQ    $EAE9
EACA: C6 0A          LDB    #$0A
EACC: 3D             MUL
EACD: EB 21          ADDB   $1,Y
EACF: 57             ASRB
EAD0: 1F 98          TFR    B,A
EAD2: 10 8E 28 B4    LDY    #$28B4
EAD6: AB A2          ADDA   ,-Y
EAD8: 81 0A          CMPA   #$0A
EADA: 25 0B          BCS    $EAE7
EADC: C6 0A          LDB    #$0A
EADE: BD FB 6A       JSR    $FB6A
EAE1: A7 A4          STA    ,Y
EAE3: 1F 98          TFR    B,A
EAE5: 20 EF          BRA    $EAD6
EAE7: A7 A4          STA    ,Y
EAE9: D6 D8          LDB    angle_d8
EAEB: D7 48          STB    nb_objects_48
EAED: 10 8E ED 7B    LDY    #$ED7B
EAF1: A6 A5          LDA    B,Y
EAF3: 5F             CLRB
EAF4: 90 48          SUBA   nb_objects_48
EAF6: 25 03          BCS    $EAFB
EAF8: 5C             INCB
EAF9: 20 F9          BRA    $EAF4
EAFB: D7 49          STB    $49
EAFD: 96 B0          LDA    $B0
EAFF: C6 0A          LDB    #$0A
EB01: 3D             MUL
EB02: DB B1          ADDB   $B1
EB04: 96 49          LDA    $49
EB06: 3D             MUL
EB07: 86 23          LDA    #$23
EB09: 3D             MUL
EB0A: 8B 00          ADDA   #$00
EB0C: C6 03          LDB    #$03
EB0E: 3D             MUL
EB0F: F7 2A D8       STB    $2AD8
EB12: F7 2A D9       STB    $2AD9
EB15: 96 48          LDA    nb_objects_48
EB17: C6 05          LDB    #$05
EB19: BD FB 6A       JSR    $FB6A
EB1C: F7 2A DA       STB    $2ADA
EB1F: 39             RTS

EB20: BD FB 8F       JSR    $FB8F
EB23: 85 05          BITA   #$05
EB25: 27 18          BEQ    $EB3F
EB27: 7C 2A D7       INC    $2AD7
EB2A: B6 2A D7       LDA    $2AD7
EB2D: 81 02          CMPA   #$02
EB2F: 26 0E          BNE    $EB3F
EB31: 10 8E 28 AF    LDY    #$28AF
EB35: 86 01          LDA    #$01
EB37: C6 04          LDB    #$04
EB39: BD EC 73       JSR    $EC73
EB3C: 7F 2A D7       CLR    $2AD7
EB3F: 7D 2B 3A       TST    $2B3A
EB42: 26 59          BNE    $EB9D
EB44: 8E 28 A0       LDX    #$28A0
EB47: BD DE FF       JSR    $DEFF
EB4A: B7 2B 35       STA    $2B35
EB4D: FB 2B 38       ADDB   $2B38
EB50: F7 2B 38       STB    $2B38
EB53: BD EC 35       JSR    $EC35
EB56: BD EC 8E       JSR    $EC8E
EB59: 7A 2A D9       DEC    $2AD9
EB5C: 26 11          BNE    $EB6F
EB5E: B6 2A DA       LDA    $2ADA
EB61: 4A             DECA
EB62: 81 F1          CMPA   #$F1
EB64: 27 03          BEQ    $EB69
EB66: B7 2A DA       STA    $2ADA
EB69: B6 2A D8       LDA    $2AD8
EB6C: B7 2A D9       STA    $2AD9
EB6F: D6 21          LDB    copy_of_screen_flipped_21
EB71: 53             COMB
EB72: 1C 00          ANDCC  #$00
EB74: 56             RORB
EB75: 56             RORB
EB76: 56             RORB
EB77: C4 43          ANDB   #$43
EB79: B6 2A DA       LDA    $2ADA
EB7C: 2A 03          BPL    $EB81
EB7E: 40             NEGA
EB7F: CA 80          ORB    #$80
EB81: D7 4F          STB    $4F
EB83: 8B E0          ADDA   #$E0
EB85: 97 4E          STA    $4E
EB87: B6 2A DA       LDA    $2ADA
EB8A: C6 06          LDB    #$06
EB8C: 3D             MUL
EB8D: 10 8E EF 53    LDY    #$EF53
EB91: 31 A5          LEAY   B,Y
EB93: BD E9 F3       JSR    update_flying_javelin_sprite_e9f3
EB96: BD EB A3       JSR    $EBA3
EB99: BD EB DA       JSR    $EBDA
EB9C: 39             RTS

EB9D: 86 01          LDA    #$01
EB9F: B7 2B 3A       STA    $2B3A
EBA2: 39             RTS

EBA3: 7D 2B 35       TST    $2B35
EBA6: 27 31          BEQ    $EBD9
EBA8: 8E 28 A0       LDX    #$28A0
EBAB: 0F B5          CLR    $B5
EBAD: 0C B5          INC    $B5
EBAF: 6A 02          DEC    $2,X
EBB1: A6 02          LDA    $2,X
EBB3: 81 0E          CMPA   #$0E
EBB5: 2A 04          BPL    $EBBB
EBB7: 6F 01          CLR    $1,X
EBB9: 6F 02          CLR    $2,X
EBBB: BD 91 B0       JSR    $91B0
EBBE: BD ED 09       JSR    $ED09
EBC1: BD EC B7       JSR    $ECB7
EBC4: 7A 2B 35       DEC    $2B35
EBC7: B6 2B 2F       LDA    $2B2F
EBCA: 81 02          CMPA   #$02
EBCC: 27 D5          BEQ    $EBA3
EBCE: 8E 29 A0       LDX    #$29A0
EBD1: BD 85 87       JSR    $8587
EBD4: BD 99 B5       JSR    $99B5
EBD7: 20 CA          BRA    $EBA3
EBD9: 39             RTS

EBDA: B6 2B 38       LDA    $2B38
EBDD: F6 2A DA       LDB    $2ADA
EBE0: 10 8E EF EA    LDY    #$EFEA
EBE4: AB A5          ADDA   B,Y
EBE6: 10 8E EF 53    LDY    #$EF53
EBEA: 34 02          PSHS   A
EBEC: 86 06          LDA    #$06
EBEE: 3D             MUL
EBEF: 35 02          PULS   A
EBF1: AB A5          ADDA   B,Y
EBF3: 81 FC          CMPA   #$FC
EBF5: 24 0C          BCC    $EC03
EBF7: 81 38          CMPA   #$38
EBF9: 24 07          BCC    $EC02
EBFB: 81 28          CMPA   #$28
EBFD: 25 03          BCS    $EC02
EBFF: 7C 2B 3A       INC    $2B3A
EC02: 39             RTS

EC03: 0D C9          TST    jump_foul_C9
EC05: 26 F0          BNE    $EBF7
EC07: 0C 09          INC    $09
EC09: CC 00 00       LDD    #$0000
EC0C: DD B0          STD    $B0
EC0E: DD B2          STD    $B2
EC10: 4F             CLRA
EC11: BD 85 0E       JSR    $850E
EC14: 86 0F          LDA    #$0F
EC16: BD 85 0E       JSR    $850E
EC19: 86 B0          LDA    #$B0
EC1B: BD 85 0E       JSR    $850E
EC1E: 86 FF          LDA    #$FF
EC20: BD 85 0E       JSR    $850E
EC23: 86 1C          LDA    #$1C
EC25: BD 85 0E       JSR    $850E
EC28: 86 1D          LDA    #$1D
EC2A: BD 85 0E       JSR    $850E
EC2D: 0F BD          CLR    $BD
EC2F: 86 F1          LDA    #$F1
EC31: B7 2B 38       STA    $2B38
EC34: 39             RTS

EC35: 7D 2B 1D       TST    $2B1D
EC38: 27 53          BEQ    $EC8D
EC3A: 4D             TSTA
EC3B: 27 50          BEQ    $EC8D
EC3D: 97 49          STA    $49
EC3F: 10 8E 2B 17    LDY    #$2B17
EC43: FC 2B 18       LDD    $2B18
EC46: 10 B3 2B 1E    CMPD   $2B1E
EC4A: 26 14          BNE    $EC60
EC4C: C6 04          LDB    #$04
EC4E: 86 03          LDA    #$03
EC50: BD EC 73       JSR    $EC73
EC53: C6 05          LDB    #$05
EC55: 86 02          LDA    #$02
EC57: BD EC 73       JSR    $EC73
EC5A: 7C 2B 1E       INC    $2B1E
EC5D: 7C 2B 1E       INC    $2B1E
EC60: C6 04          LDB    #$04
EC62: 86 06          LDA    #$06
EC64: BD EC 73       JSR    $EC73
EC67: C6 05          LDB    #$05
EC69: 86 04          LDA    #$04
EC6B: BD EC 73       JSR    $EC73
EC6E: 0A 49          DEC    $49
EC70: 26 EE          BNE    $EC60
EC72: 39             RTS

EC73: AB A5          ADDA   B,Y
EC75: 19             DAA
EC76: 85 10          BITA   #$10
EC78: 27 11          BEQ    $EC8B
EC7A: 97 48          STA    nb_objects_48
EC7C: 84 0F          ANDA   #$0F
EC7E: A7 A5          STA    B,Y
EC80: 96 48          LDA    nb_objects_48
EC82: 47             ASRA
EC83: 47             ASRA
EC84: 47             ASRA
EC85: 47             ASRA
EC86: 5A             DECB
EC87: 26 EA          BNE    $EC73
EC89: 20 00          BRA    $EC8B
EC8B: A7 A5          STA    B,Y
EC8D: 39             RTS

EC8E: 7D 2B 1D       TST    $2B1D
EC91: 27 23          BEQ    $ECB6
EC93: 0D C9          TST    jump_foul_C9
EC95: 26 1F          BNE    $ECB6
EC97: 10 8E 2B 18    LDY    #$2B18
EC9B: 8E 29 60       LDX    #player_1_final_time_2960
EC9E: 96 DF          LDA    $DF
ECA0: C6 0C          LDB    #$0C
ECA2: 3D             MUL
ECA3: 30 85          LEAX   B,X
ECA5: 96 9F          LDA    high_jump_fault_9f
ECA7: 48             ASLA
ECA8: 48             ASLA
ECA9: 30 86          LEAX   A,X
ECAB: EC A1          LDD    ,Y++
ECAD: ED 81          STD    ,X++
ECAF: EC A4          LDD    ,Y
ECB1: ED 84          STD    ,X
ECB3: BD 87 09       JSR    $8709
ECB6: 39             RTS

ECB7: 7D 2B 1D       TST    $2B1D
ECBA: 26 39          BNE    $ECF5
ECBC: B6 2B 39       LDA    $2B39
ECBF: B7 2B 32       STA    $2B32
ECC2: 86 38          LDA    #$38
ECC4: B7 2B 31       STA    $2B31
ECC7: 8E 2B 30       LDX    #$2B30
ECCA: BD 85 87       JSR    $8587
ECCD: 5F             CLRB
ECCE: 10 BE 2B 33    LDY    $2B33
ECD2: 31 A8 40       LEAY   $40,Y
ECD5: 86 8A          LDA    #$8A
ECD7: A1 A4          CMPA   ,Y		; [video_address]
ECD9: 27 0F          BEQ    $ECEA
ECDB: 10 8C 36 00    CMPY   #$3600
ECDF: 26 03          BNE    $ECE4
ECE1: 31 A8 40       LEAY   $40,Y
ECE4: CB 08          ADDB   #$08
ECE6: A1 3F          CMPA   -$1,Y		; [video_address]
ECE8: 26 0B          BNE    $ECF5
ECEA: 7C 2B 1D       INC    $2B1D
ECED: FB 2B 3D       ADDB   $2B3D
ECF0: 1F 98          TFR    B,A
ECF2: BD EC 35       JSR    $EC35
ECF5: 39             RTS

ECF6: 5D             TSTB
ECF7: 27 0F          BEQ    $ED08
ECF9: 7C 2B 38       INC    $2B38
ECFC: F7 2B 35       STB    $2B35
ECFF: BD EC B7       JSR    $ECB7
ED02: F6 2B 35       LDB    $2B35
ED05: 5A             DECB
ED06: 20 EE          BRA    $ECF6
ED08: 39             RTS

ED09: 8E 2B 20       LDX    #$2B20
ED0C: BD 85 87       JSR    $8587
ED0F: 10 AE 03       LDY    $3,X
ED12: 86 6D          LDA    #$6D
ED14: A1 A4          CMPA   ,Y		; [video_address]
ED16: 27 0F          BEQ    $ED27
ED18: 10 8C 36 80    CMPY   #$3680
ED1C: 26 03          BNE    $ED21
ED1E: 31 A8 40       LEAY   $40,Y
ED21: 31 3F          LEAY   -$1,Y
ED23: A1 A4          CMPA   ,Y		; [video_address]
ED25: 26 39          BNE    $ED60
ED27: B6 2B 28       LDA    $2B28
ED2A: 27 31          BEQ    $ED5D
ED2C: C6 8F          LDB    #$8F
ED2E: 81 0A          CMPA   #$0A
ED30: 25 1F          BCS    $ED51
ED32: 80 0A          SUBA   #$0A
ED34: 10 8C 36 80    CMPY   #$3680
ED38: 26 0D          BNE    $ED47
ED3A: E7 A8 3F       STB    $3F,Y			; [video_address]
ED3D: C6 06          LDB    #$06
ED3F: D8 73          EORB   $73
ED41: E7 A9 08 3F    STB    $083F,Y		; [video_address]
ED45: 20 0A          BRA    $ED51
ED47: E7 3F          STB    -$1,Y		; [video_address]
ED49: C6 06          LDB    #$06
ED4B: 98 37          EORA   $37
ED4D: E7 A9 07 FF    STB    $07FF,Y		; [video_address]
ED51: 8B 8E          ADDA   #$8E
ED53: A7 A4          STA    ,Y		; [video_address]
ED55: 86 06          LDA    #$06
ED57: 98 73          EORA   $73
ED59: A7 A9 08 00    STA    $0800,Y		; [video_address]
ED5D: 7C 2B 28       INC    $2B28
ED60: 39             RTS

ED61: 0D C9          TST    jump_foul_C9
ED63: 27 15          BEQ    $ED7A
ED65: CC 16 1F       LDD    #$161F
ED68: FD 35 C7       STD    $35C7
ED6B: CC 25 1C       LDD    #$251C
ED6E: FD 35 C9       STD    $35C9
ED71: CC 08 08       LDD    #$0808
ED74: FD 3D C7       STD    $3DC7
ED77: FD 3D C9       STD    $3DC9
ED7A: 39             RTS

; not sure if all offsets are valid, the range of the index
; is unknown

table_ede2:
	dc.w	$e044	; $ede2
	dc.w	$e084	; $ede4
	dc.w	$e144	; $ede6
	dc.w	$e1f9	; $ede8
	
table_ee0a:
	dc.w	$e03a	; $ee0a
	dc.w	$e28b	; $ee0c
	dc.w	$e412	; $ee0e
	dc.w	$e2fc	; $ee10
	dc.w	$e3a7	; $ee12
	dc.w	$e3e6	; $ee14
table_ee16:
	dc.w	$e41a	; $ee16
	dc.w	$e471	; $ee18
	dc.w	$e5a0	; $ee1a



table_eed3:
	dc.w	$e652	; $eed3
	dc.w	$e6fd	; $eed5
	dc.w	$e754	; $eed7
	dc.w	$e812	; $eed9
	dc.w	$e953	; $eedb
	dc.w	$e986	; $eedd
	dc.w	$e9bd	; $eedf
table_eee1:
	dc.w	$e65a	; $eee1
	dc.w	$e66a	; $eee3
table_eee5:
	dc.w	$e81b	; $eee5
	dc.w	$e846	; $eee7
	dc.w	$e8a0	; $eee9
	dc.w	$e8dd	; $eeeb
table_eef3:
	dc.w	$e8aa	; $eef3
	dc.w	$e8cb	; $eef5
	dc.w	$e8d4	; $eef7

; called on game over
high_scores_effb:
EFFB: 96 31          LDA    $31                                          
EFFD: 8A 80          ORA    #$80                                         
EFFF: 43             COMA                                                
F000: BA 2A 9B       ORA    $2A9B
F003: B7 2A 9B       STA    $2A9B
F006: 0D 22          TST    $22
F008: 26 0E          BNE    $F018
F00A: 96 2C          LDA    dsw1_copy_2c
F00C: 84 0F          ANDA   #$0F
F00E: 81 0F          CMPA   #$0F
F010: 27 06          BEQ    $F018
F012: 0D 23          TST    number_of_credits_23
F014: 10 26 86 8D    LBNE   $76A5
F018: 96 03          LDA    boot_state_03
F01A: 48             ASLA
F01B: 10 8E FD 89    LDY    #table_fd89
F01F: AD B6          JSR    [A,Y]	; [jump_table]
F021: 96 03          LDA    boot_state_03
F023: 81 02          CMPA   #$02
F025: 25 03          BCS    $F02A
F027: 7E 67 BF       JMP    $67BF
F02A: 39             RTS

F02B: CC 00 00       LDD    #$0000
F02E: BD 84 F5       JSR    queue_event_84f5
F031: 86 14          LDA    #$14
F033: B7 2A 92       STA    $2A92
F036: 86 FF          LDA    #$FF
F038: 97 84          STA    current_level_84
F03A: FC 2A 80       LDD    $2A80
F03D: FD 2A 93       STD    $2A93
F040: B6 2A 82       LDA    $2A82
F043: B7 2A 95       STA    $2A95
F046: FC 2A 52       LDD    $2A52
F049: FD 2A 96       STD    $2A96
F04C: 0F DF          CLR    $DF
F04E: CC 01 00       LDD    #$0100
F051: FD 2A 90       STD    $2A90
F054: CC DC B6       LDD    #$DCB6
F057: DD AE          STD    $AE
F059: 0C 03          INC    boot_state_03
F05B: 39             RTS

F05C: 7D 2A 91       TST    $2A91
F05F: 10 26 00 95    LBNE   $F0F8
F063: 0D 22          TST    $22
F065: 10 27 00 8F    LBEQ   $F0F8
F069: 10 8E 2C C0    LDY    #$2CC0
F06D: B6 2A 92       LDA    $2A92
F070: 81 0B          CMPA   #$0B
F072: 24 08          BCC    $F07C
F074: C6 32          LDB    #$32
F076: 3D             MUL
F077: 83 00 05       SUBD   #$0005
F07A: 20 08          BRA    $F084
F07C: 80 0A          SUBA   #$0A
F07E: C6 1E          LDB    #$1E
F080: 3D             MUL
F081: C3 01 F1       ADDD   #$01F1
F084: 31 AB          LEAY   D,Y
F086: 86 0A          LDA    #$0A
F088: 97 48          STA    nb_objects_48
F08A: 8E 2A 93       LDX    #$2A93
F08D: 86 1D          LDA    #$1D
F08F: 97 E6          STA    $E6
F091: BD 89 68       JSR    compare_performances_8968
F094: 5D             TSTB
F095: 27 4C          BEQ    $F0E3
F097: B6 2A 92       LDA    $2A92
F09A: 81 0B          CMPA   #$0B
F09C: 24 22          BCC    $F0C0
F09E: EC A4          LDD    ,Y
F0A0: ED 25          STD    $5,Y
F0A2: A6 22          LDA    $2,Y
F0A4: A7 27          STA    $7,Y
F0A6: EC 84          LDD    ,X
F0A8: ED A4          STD    ,Y
F0AA: A6 02          LDA    $2,X
F0AC: A7 22          STA    $2,Y
F0AE: 10 8C 2E AF    CMPY   #$2EAF
F0B2: 27 04          BEQ    $F0B8
F0B4: EC 23          LDD    $3,Y
F0B6: ED 28          STD    $8,Y
F0B8: EC 03          LDD    $3,X
F0BA: ED 23          STD    $3,Y
F0BC: 31 3B          LEAY   -$5,Y
F0BE: 20 18          BRA    $F0D8
F0C0: 10 8C 2F DD    CMPY   #$2FDD
F0C4: 27 08          BEQ    $F0CE
F0C6: EC A4          LDD    ,Y
F0C8: ED 23          STD    $3,Y
F0CA: A6 22          LDA    $2,Y
F0CC: A7 25          STA    $5,Y
F0CE: EC 84          LDD    ,X
F0D0: ED A4          STD    ,Y
F0D2: A6 02          LDA    $2,X
F0D4: A7 22          STA    $2,Y
F0D6: 31 3D          LEAY   -$3,Y
F0D8: 0A 48          DEC    nb_objects_48
F0DA: 26 B5          BNE    $F091
F0DC: B6 2A 92       LDA    $2A92
F0DF: 81 01          CMPA   #$01
F0E1: 26 15          BNE    $F0F8
F0E3: 96 48          LDA    nb_objects_48
F0E5: 4C             INCA
F0E6: 81 0B          CMPA   #$0B
F0E8: 26 05          BNE    $F0EF
F0EA: 7C 2A 92       INC    $2A92
F0ED: 86 01          LDA    #$01
F0EF: B7 2A 91       STA    $2A91
F0F2: B6 2A 92       LDA    $2A92
F0F5: B7 2A 90       STA    $2A90
F0F8: 7A 2A 92       DEC    $2A92
F0FB: 27 01          BEQ    $F0FE
F0FD: 39             RTS

F0FE: 0D 22          TST    $22
F100: 27 61          BEQ    $F163
F102: 96 DF          LDA    $DF
F104: 10 8E 2A 52    LDY    #$2A52
F108: 31 A6          LEAY   A,Y
F10A: B6 2A 90       LDA    $2A90
F10D: 4A             DECA
F10E: C6 0A          LDB    #$0A
F110: 3D             MUL
F111: FB 2A 91       ADDB   $2A91
F114: 5A             DECB
F115: E7 A4          STB    ,Y
F117: 4F             CLRA
F118: 10 8E 2A 52    LDY    #$2A52
F11C: 91 DF          CMPA   $DF
F11E: 27 09          BEQ    $F129
F120: E1 A6          CMPB   A,Y
F122: 22 02          BHI    $F126
F124: 6C A6          INC    A,Y
F126: 4C             INCA
F127: 20 F3          BRA    $F11C
F129: 96 DF          LDA    $DF
F12B: 91 60          CMPA   nb_players_minus_one_60
F12D: 27 2E          BEQ    $F15D
F12F: 0C DF          INC    $DF
F131: 4C             INCA
F132: 10 8E 2A 52    LDY    #$2A52
F136: 48             ASLA
F137: 31 A6          LEAY   A,Y
F139: CE 2A 80       LDU    #$2A80
F13C: 47             ASRA
F13D: C6 03          LDB    #$03
F13F: 3D             MUL
F140: 33 C5          LEAU   B,U
F142: EC A4          LDD    ,Y
F144: FD 2A 96       STD    $2A96
F147: EC C1          LDD    ,U++
F149: FD 2A 93       STD    $2A93
F14C: A6 C4          LDA    ,U
F14E: B7 2A 95       STA    $2A95
F151: CC 01 00       LDD    #$0100
F154: FD 2A 90       STD    $2A90
F157: 86 14          LDA    #$14
F159: B7 2A 92       STA    $2A92
F15C: 39             RTS

F15D: B6 2A 52       LDA    $2A52
F160: BD F1 78       JSR    $F178
F163: 0F DF          CLR    $DF
F165: 86 0A          LDA    #$0A
F167: B7 2A 92       STA    $2A92
F16A: CC 00 00       LDD    #$0000
F16D: BD 84 F5       JSR    queue_event_84f5
F170: 86 1F          LDA    #$1F
F172: BD 85 0E       JSR    $850E
F175: 0C 03          INC    boot_state_03
F177: 39             RTS

F178: 4C             INCA
F179: C6 0A          LDB    #$0A
F17B: BD FB 6A       JSR    $FB6A
F17E: 4D             TSTA
F17F: 26 03          BNE    $F184
F181: 86 0A          LDA    #$0A
F183: 5A             DECB
F184: B7 2A 91       STA    $2A91
F187: 5C             INCB
F188: F7 2A 90       STB    $2A90
F18B: 39             RTS

F18C: 7D 2A 92       TST    $2A92
F18F: 27 05          BEQ    $F196
F191: 7A 2A 92       DEC    $2A92
F194: 20 77          BRA    $F20D
F196: 8E 31 0A       LDX    #$310A
F199: 10 8E FD 94    LDY    #$FD94
F19D: 86 0B          LDA    #$0B
F19F: E6 A6          LDB    A,Y
F1A1: C0 30          SUBB   #$30
F1A3: E7 86          STB    A,X		; [video_address]
F1A5: 4A             DECA
F1A6: 26 F7          BNE    $F19F
F1A8: CC 0B 01       LDD    #$0B01
F1AB: 30 89 08 00    LEAX   $0800,X
F1AF: E7 86          STB    A,X				; [video_address]
F1B1: 4A             DECA
F1B2: 26 FB          BNE    $F1AF
F1B4: 8E 31 88       LDX    #$3188
F1B7: 10 8E FD A0    LDY    #$FDA0
F1BB: 0D 22          TST    $22
F1BD: 26 04          BNE    $F1C3
F1BF: 10 8E FD AE    LDY    #$FDAE
F1C3: 86 0E          LDA    #$0E
F1C5: E6 A6          LDB    A,Y
F1C7: C0 30          SUBB   #$30
F1C9: E7 86          STB    A,X				; [video_address]
F1CB: 4A             DECA
F1CC: 26 F7          BNE    $F1C5
F1CE: 0D 22          TST    $22
F1D0: 27 17          BEQ    $F1E9
F1D2: 96 DF          LDA    $DF
F1D4: 4C             INCA
F1D5: A7 09          STA    $9,X				; [video_address]
F1D7: 4A             DECA
F1D8: 10 8E 29 90    LDY    #$2990
F1DC: C6 03          LDB    #$03
F1DE: 3D             MUL
F1DF: 31 A5          LEAY   B,Y
F1E1: EC A1          LDD    ,Y++
F1E3: ED 0B          STD    $B,X			; [video_address]
F1E5: A6 A4          LDA    ,Y
F1E7: A7 0D          STA    $D,X			; [video_address]
F1E9: CC 0E 00       LDD    #$0E00
F1EC: 30 89 08 00    LEAX   $0800,X
F1F0: E7 86          STB    A,X				; [video_address]
F1F2: 4A             DECA
F1F3: 26 FB          BNE    $F1F0
F1F5: B6 2A 90       LDA    $2A90
F1F8: 81 15          CMPA   #$15
F1FA: 24 12          BCC    $F20E
F1FC: 7F 29 9C       CLR    $299C
F1FF: 96 DF          LDA    $DF
F201: 47             ASRA
F202: D6 2D          LDB    dsw2_copy_2d
F204: C5 04          BITB   #$04
F206: 26 03          BNE    $F20B
F208: B7 10 80       STA    flip_screen_set_1080
F20B: 0C 03          INC    boot_state_03
F20D: 39             RTS

F20E: 8E FD BD       LDX    #$FDBD
F211: 10 8E 33 46    LDY    #$3346
F215: 86 09          LDA    #$09
F217: 97 48          STA    nb_objects_48
F219: EC 81          LDD    ,X++
F21B: 83 30 30       SUBD   #$3030
F21E: ED A1          STD    ,Y++			; [video_address_word]
F220: 0A 48          DEC    nb_objects_48
F222: 26 F5          BNE    $F219
F224: 86 6D          LDA    #$6D
F226: B7 29 9C       STA    $299C
F229: 86 03          LDA    #$03
F22B: B7 2A 91       STA    $2A91
F22E: 97 03          STA    boot_state_03
F230: 20 CD          BRA    $F1FF
F232: B6 29 9C       LDA    $299C
F235: 81 0A          CMPA   #$0A
F237: 10 24 00 FC    LBCC   $F337
F23B: 8E 32 47       LDX    #$3247
F23E: C6 80          LDB    #$80
F240: 3D             MUL
F241: 30 8B          LEAX   D,X
F243: 10 8E 2C C0    LDY    #$2CC0
F247: B6 2A 90       LDA    $2A90
F24A: 4A             DECA
F24B: 81 0A          CMPA   #$0A
F24D: 24 0F          BCC    $F25E
F24F: C6 32          LDB    #$32
F251: 3D             MUL
F252: 31 AB          LEAY   D,Y
F254: B6 29 9C       LDA    $299C
F257: C6 05          LDB    #$05
F259: 3D             MUL
F25A: 31 A5          LEAY   B,Y
F25C: 20 13          BRA    $F271
F25E: 80 0A          SUBA   #$0A
F260: C6 1E          LDB    #$1E
F262: 3D             MUL
F263: 31 AB          LEAY   D,Y
F265: 31 A9 01 F4    LEAY   $01F4,Y
F269: B6 29 9C       LDA    $299C
F26C: C6 03          LDB    #$03
F26E: 3D             MUL
F26F: 31 A5          LEAY   B,Y
F271: 30 0C          LEAX   $C,X
F273: 86 03          LDA    #$03
F275: 97 48          STA    nb_objects_48
F277: 0F 49          CLR    $49
F279: 5F             CLRB
F27A: A6 A0          LDA    ,Y+
F27C: 44             LSRA
F27D: 56             RORB
F27E: 44             LSRA
F27F: 56             RORB
F280: 44             LSRA
F281: 56             RORB
F282: 44             LSRA
F283: 56             RORB
F284: 54             LSRB
F285: 54             LSRB
F286: 54             LSRB
F287: 54             LSRB
F288: 4D             TSTA
F289: 26 04          BNE    $F28F
F28B: 0D 49          TST    $49
F28D: 27 08          BEQ    $F297
F28F: 0C 49          INC    $49
F291: A7 84          STA    ,X			; [video_address]
F293: 6F 89 08 00    CLR    $0800,X			; [video_address]
F297: 30 01          LEAX   $1,X
F299: 5D             TSTB
F29A: 26 04          BNE    $F2A0
F29C: 0D 49          TST    $49
F29E: 27 08          BEQ    $F2A8
F2A0: 0C 49          INC    $49
F2A2: E7 84          STB    ,X			; [video_address]
F2A4: 6F 89 08 00    CLR    $0800,X		; [video_address]
F2A8: 30 01          LEAX   $1,X
F2AA: 0A 48          DEC    nb_objects_48
F2AC: 26 CB          BNE    $F279
F2AE: 4F             CLRA
F2AF: A7 84          STA    ,X				; [video_address]
F2B1: 6F 89 08 00    CLR    $0800,X				; [video_address]
F2B5: 30 88 EE       LEAX   -$12,X
F2B8: B6 2A 90       LDA    $2A90
F2BB: 81 0B          CMPA   #$0B
F2BD: 24 2E          BCC    $F2ED
F2BF: EC A4          LDD    ,Y
F2C1: C4 1F          ANDB   #$1F
F2C3: CB 10          ADDB   #$10
F2C5: D7 4C          STB    $4C
F2C7: 84 7C          ANDA   #$7C
F2C9: 44             LSRA
F2CA: 44             LSRA
F2CB: 8B 10          ADDA   #$10
F2CD: 97 4A          STA    $4A
F2CF: EC A4          LDD    ,Y
F2D1: 58             ASLB
F2D2: 49             ROLA
F2D3: 58             ASLB
F2D4: 49             ROLA
F2D5: 58             ASLB
F2D6: 49             ROLA
F2D7: 84 1F          ANDA   #$1F
F2D9: 8B 10          ADDA   #$10
F2DB: 97 4B          STA    $4B
F2DD: DC 4A          LDD    $4A
F2DF: ED 07          STD    $7,X	; [video_address]
F2E1: 6F 89 08 07    CLR    $0807,X	; [video_address]
F2E5: 96 4C          LDA    $4C
F2E7: A7 09          STA    $9,X	; [video_address]
F2E9: 6F 89 08 09    CLR    $0809,X	; [video_address]
F2ED: B6 2A 90       LDA    $2A90
F2F0: 4A             DECA
F2F1: C6 0A          LDB    #$0A
F2F3: 3D             MUL
F2F4: FB 29 9C       ADDB   $299C
F2F7: 5C             INCB
F2F8: 1F 98          TFR    B,A
F2FA: C6 0A          LDB    #$0A
F2FC: BD FB 6A       JSR    $FB6A
F2FF: A7 04          STA    $4,X		; [video_address]
F301: 5D             TSTB
F302: 27 0E          BEQ    $F312
F304: 1F 98          TFR    B,A
F306: C6 0A          LDB    #$0A
F308: BD FB 6A       JSR    $FB6A
F30B: A7 03          STA    $3,X	; [video_address]
F30D: 5D             TSTB
F30E: 27 02          BEQ    $F312
F310: E7 02          STB    $2,X	; [video_address]
F312: CC 1E 1F       LDD    #$1E1F
F315: ED 1F          STD    -$1,X	; [video_address]
F317: 86 2B          LDA    #$2B
F319: A7 01          STA    $1,X			; [video_address_word]
F31B: 86 0B          LDA    #$0B
F31D: 97 48          STA    nb_objects_48
F31F: B6 29 9C       LDA    $299C
F322: CE FD CF       LDU    #$FDCF
F325: A6 C6          LDA    A,U
F327: 1F 89          TFR    A,B
F329: 30 89 07 FF    LEAX   $07FF,X
F32D: ED 81          STD    ,X++			; [video_address_word]
F32F: 0A 48          DEC    nb_objects_48
F331: 26 FA          BNE    $F32D
F333: 7C 29 9C       INC    $299C
F336: 39             RTS

F337: 86 6D          LDA    #$6D
F339: B7 29 9C       STA    $299C
F33C: 0C 03          INC    boot_state_03
F33E: 39             RTS

F33F: 96 3F          LDA    $3F
F341: 84 03          ANDA   #$03
F343: 27 01          BEQ    $F346
F345: 39             RTS

F346: 7A 29 9C       DEC    $299C
F349: 10 27 00 76    LBEQ   $F3C3
F34D: 86 20          LDA    #$20
F34F: 97 48          STA    nb_objects_48
F351: CE 39 C0       LDU    #$39C0
F354: B6 2A 91       LDA    $2A91
F357: 5F             CLRB
F358: 47             ASRA
F359: 56             RORB
F35A: 33 CB          LEAU   D,U
F35C: B6 29 9C       LDA    $299C
F35F: 84 03          ANDA   #$03
F361: 10 8E FD D9    LDY    #$FDD9
F365: A6 A6          LDA    A,Y
F367: 1F 89          TFR    A,B
F369: 8E 39 80       LDX    #$3980
F36C: ED 81          STD    ,X++		; [video_address_word]
F36E: ED C1          STD    ,U++		; [video_address_word]
F370: 0A 48          DEC    nb_objects_48
F372: 26 F8          BNE    $F36C
F374: 0D 22          TST    $22
F376: 26 02          BNE    $F37A
F378: 0F DF          CLR    $DF
F37A: CC 30 E8       LDD    #$30E8
F37D: DD A1          STD    p2_attempts_left_a1
F37F: 8E 28 A0       LDX    #$28A0
F382: CE 18 00       LDU    #sprite_ram_1800
F385: BD CE C4       JSR    $CEC4
F388: EC 01          LDD    $1,X
F38A: C0 D0          SUBB   #$D0
F38C: ED 01          STD    $1,X
F38E: 33 48          LEAU   $8,U
F390: 0D 22          TST    $22
F392: 26 02          BNE    $F396
F394: 0C DF          INC    $DF
F396: BD CE C4       JSR    $CEC4
F399: EC 01          LDD    $1,X
F39B: 8B 58          ADDA   #$58
F39D: ED 01          STD    $1,X
F39F: 33 48          LEAU   $8,U
F3A1: 0D 22          TST    $22
F3A3: 26 02          BNE    $F3A7
F3A5: 0C DF          INC    $DF
F3A7: BD CE C4       JSR    $CEC4
F3AA: EC 01          LDD    $1,X
F3AC: CB D0          ADDB   #$D0
F3AE: ED 01          STD    $1,X
F3B0: 33 48          LEAU   $8,U
F3B2: 0D 22          TST    $22
F3B4: 26 02          BNE    $F3B8
F3B6: 0C DF          INC    $DF
F3B8: BD CE C4       JSR    $CEC4
F3BB: EC 0E          LDD    $E,X
F3BD: C3 00 04       ADDD   #$0004
F3C0: ED 0E          STD    $E,X
F3C2: 39             RTS

F3C3: 0C 03          INC    boot_state_03
F3C5: 39             RTS

F3C6: 7D 2A 9B       TST    $2A9B
F3C9: 26 0C          BNE    $F3D7
F3CB: 86 89          LDA    #$89
F3CD: 0F 84          CLR    current_level_84
F3CF: BD 85 12       JSR    $8512
F3D2: 86 FF          LDA    #$FF
F3D4: BD 85 12       JSR    $8512
F3D7: 96 DF          LDA    $DF
F3D9: 91 60          CMPA   nb_players_minus_one_60
F3DB: 27 3D          BEQ    $F41A
F3DD: 0D 22          TST    $22
F3DF: 27 39          BEQ    $F41A
F3E1: 0C DF          INC    $DF
F3E3: 4C             INCA
F3E4: 10 8E 2A 52    LDY    #$2A52
F3E8: 31 A6          LEAY   A,Y
F3EA: A6 A4          LDA    ,Y
F3EC: 0F 84          CLR    current_level_84
F3EE: BD F1 78       JSR    $F178
F3F1: 86 18          LDA    #$18
F3F3: 97 48          STA    nb_objects_48
F3F5: CC 00 F0       LDD    #$00F0
F3F8: 8E 18 00       LDX    #sprite_ram_1800
F3FB: 10 8E 1C 00    LDY    #$1C00
F3FF: ED 81          STD    ,X++
F401: ED A1          STD    ,Y++
F403: 0A 48          DEC    nb_objects_48
F405: 26 F8          BNE    $F3FF
F407: CC 00 00       LDD    #$0000
F40A: BD 84 F5       JSR    queue_event_84f5
F40D: 7F 29 9C       CLR    $299C
F410: 86 14          LDA    #$14
F412: B7 2A 92       STA    $2A92
F415: 86 02          LDA    #$02
F417: 97 03          STA    boot_state_03
F419: 39             RTS

F41A: 0F 84          CLR    current_level_84
F41C: 0F DF          CLR    $DF
F41E: 0F 60          CLR    nb_players_minus_one_60
F420: 0D 22          TST    $22
F422: 0F 03          CLR    boot_state_03
F424: 0F 0F          CLR    $0F
F426: 26 04          BNE    $F42C
F428: 86 01          LDA    #$01
F42A: 97 00          STA    global_state_00
F42C: 86 00          LDA    #$00
F42E: BD 85 12       JSR    $8512
F431: 7F 2A 9B       CLR    $2A9B
F434: 39             RTS

display_champion_message_f435:
F435: 96 82          LDA    $82
F437: 4C             INCA
F438: C6 06          LDB    #$06
F43A: BD FB 6A       JSR    $FB6A
F43D: 4D             TSTA
F43E: 26 0C          BNE    $F44C
F440: BD F6 D1       JSR    $F6D1
F443: 96 09          LDA    $09
F445: 48             ASLA

F446: 10 8E FD DD    LDY    #table_fddd
F44A: 6E B6          JMP    [A,Y]	; [jump_table]

F44C: 0C 06          INC    $06
F44E: 39             RTS

F44F: B6 2B 80       LDA    $2B80
F452: BA 2B A0       ORA    $2BA0
F455: BA 2B C0       ORA    $2BC0
F458: BA 2B E0       ORA    $2BE0
F45B: 10 27 02 61    LBEQ   $F6C0
F45F: CC 00 00       LDD    #$0000
F462: BD 84 F5       JSR    queue_event_84f5
F465: 86 00          LDA    #$00
F467: BD 85 0E       JSR    $850E
F46A: 86 22          LDA    #$22
F46C: BD 85 0E       JSR    $850E
F46F: 7F 2A 4C       CLR    $2A4C
F472: CC DE B2       LDD    #$DEB2
F475: DD AE          STD    $AE
F477: CC DE C8       LDD    #$DEC8
F47A: FD 2A 0E       STD    $2A0E
F47D: CC 48 84       LDD    #$4884
F480: FD 2A 40       STD    $2A40
F483: CC 30 5C       LDD    #$305C
F486: FD 2A 42       STD    $2A42
F489: CC 30 AC       LDD    #$30AC
F48C: FD 2A 44       STD    $2A44
F48F: 86 10          LDA    #$10
F491: B7 2A 4C       STA    $2A4C
F494: 0C 09          INC    $09
F496: 39             RTS

F497: B6 2A A0       LDA    $2AA0
F49A: 4A             DECA
F49B: 44             LSRA
F49C: 97 48          STA    nb_objects_48
F49E: 96 2D          LDA    dsw2_copy_2d
F4A0: 43             COMA
F4A1: 44             LSRA
F4A2: 44             LSRA
F4A3: 94 48          ANDA   nb_objects_48
F4A5: 97 21          STA    copy_of_screen_flipped_21
F4A7: B7 10 80       STA    flip_screen_set_1080
F4AA: 8E FD E5       LDX    #$FDE5
F4AD: 10 8E 31 0B    LDY    #$310B
F4B1: 86 06          LDA    #$06
F4B3: 97 48          STA    nb_objects_48
F4B5: CC 48 48       LDD    #$4848
F4B8: EE 81          LDU    ,X++
F4BA: 33 C9 CF D0    LEAU   -$3030,U
F4BE: EF A8 40       STU    $40,Y		; [video_address_word]
F4C1: ED A9 00 80    STD    $0080,Y		; [video_address_word]
F4C5: ED A1          STD    ,Y++		; [video_address_word]
F4C7: CC 01 01       LDD    #$0101
F4CA: ED A9 07 FE    STD    $07FE,Y     ; [video_address_word]
F4CE: ED A9 08 3E    STD    $083E,Y     ; [video_address_word]
F4D2: ED A9 08 7E    STD    $087E,Y     ; [video_address_word]
F4D6: 0A 48          DEC    nb_objects_48
F4D8: 26 DB          BNE    $F4B5
F4DA: 86 48          LDA    #$48
F4DC: B7 31 4A       STA    $314A
F4DF: B7 31 57       STA    $3157
F4E2: 10 8E 35 C9    LDY    #$35C9
F4E6: 8E FD F1       LDX    #$FDF1
F4E9: 86 06          LDA    #$06
F4EB: 97 48          STA    nb_objects_48
F4ED: 86 0F          LDA    #$0F
F4EF: 97 49          STA    $49
F4F1: C6 80          LDB    #$80
F4F3: A6 80          LDA    ,X+
F4F5: 26 03          BNE    $F4FA
F4F7: CC 10 00       LDD    #$1000
F4FA: E7 A9 08 00    STB    $0800,Y	; [video_address]
F4FE: A7 A0          STA    ,Y+		; [video_address]
F500: 0A 49          DEC    $49
F502: 26 ED          BNE    $F4F1
F504: 31 A8 31       LEAY   $31,Y
F507: 0A 48          DEC    nb_objects_48
F509: 26 E2          BNE    $F4ED
F50B: 0C 09          INC    $09
F50D: 39             RTS

F50E: 8E 2A A0       LDX    #$2AA0
F511: 10 8E 2A 48    LDY    #$2A48
F515: 86 04          LDA    #$04
F517: 97 48          STA    nb_objects_48
F519: CE 2B 80       LDU    #$2B80
F51C: A6 84          LDA    ,X
F51E: 27 0D          BEQ    $F52D
F520: 4A             DECA
F521: C6 20          LDB    #$20
F523: 3D             MUL
F524: 6D CB          TST    D,U
F526: 27 05          BEQ    $F52D
F528: A6 84          LDA    ,X
F52A: 4A             DECA
F52B: A7 A0          STA    ,Y+
F52D: 30 04          LEAX   $4,X
F52F: 0A 48          DEC    nb_objects_48
F531: 26 E9          BNE    $F51C
F533: 10 8C 2A 4C    CMPY   #$2A4C
F537: 26 02          BNE    $F53B
F539: 31 3F          LEAY   -$1,Y
F53B: 86 FF          LDA    #$FF
F53D: A7 A4          STA    ,Y
F53F: 7F 2A 4C       CLR    $2A4C
F542: 0C 09          INC    $09
F544: 39             RTS

F545: 96 0C          LDA    $0C
F547: 10 8E FE 4B    LDY    #table_fe4b
F54B: 48             ASLA
F54C: 6E B6          JMP    [A,Y]	; [jump_table]

F54E: 96 3F          LDA    $3F
F550: 85 07          BITA   #$07
F552: 10 26 00 8B    LBNE   $F5E1
F556: 8E 32 49       LDX    #$3249
F559: 96 2D          LDA    dsw2_copy_2d
F55B: 84 02          ANDA   #$02
F55D: 26 14          BNE    $F573
F55F: B6 2A 4C       LDA    $2A4C
F562: 81 10          CMPA   #$10
F564: 24 06          BCC    $F56C
F566: 30 89 00 80    LEAX   $0080,X
F56A: 20 07          BRA    $F573
F56C: 84 EF          ANDA   #$EF
F56E: 8A 20          ORA    #$20
F570: B7 2A 4C       STA    $2A4C
F573: 10 8E FE 51    LDY    #$FE51
F577: B6 2A 4C       LDA    $2A4C
F57A: 81 17          CMPA   #$17
F57C: 26 10          BNE    $F58E
F57E: 96 82          LDA    $82
F580: C6 06          LDB    #$06
F582: BD FB 6A       JSR    $FB6A
F585: F7 2A 4F       STB    $2A4F
F588: 5C             INCB
F589: B6 2A 4C       LDA    $2A4C
F58C: 20 2C          BRA    $F5BA
F58E: 81 18          CMPA   #$18
F590: 26 10          BNE    $F5A2
F592: F6 2A 4F       LDB    $2A4F
F595: C1 04          CMPB   #$04
F597: 25 02          BCS    $F59B
F599: C6 03          LDB    #$03
F59B: CE FE 81       LDU    #$FE81
F59E: E6 C5          LDB    B,U
F5A0: 20 18          BRA    $F5BA
F5A2: 81 19          CMPA   #$19
F5A4: 26 10          BNE    $F5B6
F5A6: F6 2A 4F       LDB    $2A4F
F5A9: C1 04          CMPB   #$04
F5AB: 25 02          BCS    $F5AF
F5AD: C6 03          LDB    #$03
F5AF: CE FE 85       LDU    #$FE85
F5B2: E6 C5          LDB    B,U
F5B4: 20 04          BRA    $F5BA
F5B6: E6 A6          LDB    A,Y
F5B8: C0 30          SUBB   #$30
F5BA: 34 04          PSHS   B
F5BC: C6 10          LDB    #$10
F5BE: BD FB 6A       JSR    $FB6A
F5C1: 34 02          PSHS   A
F5C3: 86 80          LDA    #$80
F5C5: 3D             MUL
F5C6: 30 8B          LEAX   D,X
F5C8: 35 02          PULS   A
F5CA: 35 04          PULS   B
F5CC: E7 86          STB    A,X
F5CE: C6 0A          LDB    #$0A
F5D0: 30 89 08 00    LEAX   $0800,X
F5D4: E7 86          STB    A,X
F5D6: B6 2A 4C       LDA    $2A4C
F5D9: 4C             INCA
F5DA: 81 30          CMPA   #$30
F5DC: 27 04          BEQ    $F5E2
F5DE: B7 2A 4C       STA    $2A4C
F5E1: 39             RTS

F5E2: 0C 0C          INC    $0C
F5E4: 7F 2A 4C       CLR    $2A4C
F5E7: 7F 2A 4D       CLR    $2A4D
F5EA: 39             RTS

F5EB: 8E 2A 48       LDX    #$2A48
F5EE: B6 2A 4D       LDA    $2A4D
F5F1: A6 86          LDA    A,X
F5F3: 81 FF          CMPA   #$FF
F5F5: 27 38          BEQ    $F62F
F5F7: B6 2A 4C       LDA    $2A4C
F5FA: 85 0F          BITA   #$0F
F5FC: 26 20          BNE    $F61E
F5FE: 8E FE 89       LDX    #$FE89
F601: CE 2A 40       LDU    #$2A40
F604: 10 8E 2A 48    LDY    #$2A48
F608: B6 2A 4D       LDA    $2A4D
F60B: 31 A6          LEAY   A,Y
F60D: 48             ASLA
F60E: EE C6          LDU    A,U
F610: DF A1          STU    p2_attempts_left_a1
F612: AE 86          LDX    A,X
F614: 48             ASLA
F615: 48             ASLA
F616: CE 18 08       LDU    #$1808
F619: 33 C6          LEAU   A,U
F61B: BD F6 37       JSR    $F637
F61E: 7A 2A 4C       DEC    $2A4C
F621: 27 01          BEQ    $F624
F623: 39             RTS

F624: B6 2A 4D       LDA    $2A4D
F627: 81 02          CMPA   #$02
F629: 27 04          BEQ    $F62F
F62B: 7C 2A 4D       INC    $2A4D
F62E: 39             RTS

F62F: 86 CF          LDA    #$CF
F631: B7 2A 4C       STA    $2A4C
F634: 0C 0C          INC    $0C
F636: 39             RTS

F637: CC 20 1C       LDD    #$201C
F63A: ED 84          STD    ,X
F63C: CC 11 29       LDD    #$1129
F63F: ED 02          STD    $2,X
F641: CC 15 22       LDD    #$1522
F644: ED 04          STD    $4,X
F646: A6 A4          LDA    ,Y
F648: 97 DF          STA    $DF
F64A: 4C             INCA
F64B: A7 07          STA    $7,X
F64D: 4A             DECA
F64E: 10 8E 29 90    LDY    #$2990
F652: C6 03          LDB    #$03
F654: 3D             MUL
F655: 31 AB          LEAY   D,Y
F657: EC A1          LDD    ,Y++
F659: ED 89 00 82    STD    $0082,X
F65D: A6 A4          LDA    ,Y
F65F: A7 89 00 84    STA    $0084,X
F663: 30 89 08 00    LEAX   $0800,X
F667: CC 00 00       LDD    #$0000
F66A: ED 81          STD    ,X++
F66C: ED 81          STD    ,X++
F66E: ED 81          STD    ,X++
F670: ED 84          STD    ,X
F672: 10 8E A4 C8    LDY    #$A4C8
F676: 96 DF          LDA    $DF
F678: A6 A6          LDA    A,Y
F67A: 1F 89          TFR    A,B
F67C: ED 88 7C       STD    $7C,X
F67F: A7 88 7E       STA    chrono_hundredth_second_7e,X
F682: 8E 28 A0       LDX    #$28A0
F685: EC 0E          LDD    $E,X
F687: C3 00 04       ADDD   #$0004
F68A: ED 0E          STD    $E,X
F68C: BD CE C4       JSR    $CEC4
F68F: 39             RTS

F690: 96 3F          LDA    $3F
F692: 84 01          ANDA   #$01
F694: 27 01          BEQ    $F697
F696: 39             RTS

F697: B6 2A 4C       LDA    $2A4C
F69A: 85 0F          BITA   #$0F
F69C: 26 1C          BNE    $F6BA
F69E: 86 0F          LDA    #$0F
F6A0: 97 DF          STA    $DF
F6A2: FC 2A 40       LDD    $2A40
F6A5: C0 04          SUBB   #$04
F6A7: FD 2A 01       STD    $2A01
F6AA: 8E 2A 00       LDX    #$2A00
F6AD: CE 18 00       LDU    #sprite_ram_1800
F6B0: BD CE C4       JSR    $CEC4
F6B3: EC 0E          LDD    $E,X
F6B5: C3 00 04       ADDD   #$0004
F6B8: ED 0E          STD    $E,X
F6BA: 7A 2A 4C       DEC    $2A4C
F6BD: 27 01          BEQ    $F6C0
F6BF: 39             RTS

F6C0: 86 00          LDA    #$00
F6C2: BD 85 0E       JSR    $850E
F6C5: 0F DF          CLR    $DF
F6C7: 7F 2A 50       CLR    $2A50
F6CA: 0F 09          CLR    $09
F6CC: 0F 0C          CLR    $0C
F6CE: 0C 06          INC    $06
F6D0: 39             RTS

F6D1: 96 3F          LDA    $3F
F6D3: 84 03          ANDA   #$03
F6D5: 26 22          BNE    $F6F9
F6D7: BD DA 6A       JSR    $DA6A
F6DA: CE 39 0B       LDU    #$390B
F6DD: C6 03          LDB    #$03
F6DF: BD DA 77       JSR    copy_4b_chars_da77
F6E2: CE 39 97       LDU    #$3997
F6E5: C6 03          LDB    #$03
F6E7: BD DA AB       JSR    $DAAB
F6EA: 96 3F          LDA    $3F
F6EC: 47             ASRA
F6ED: 47             ASRA
F6EE: 84 03          ANDA   #$03
F6F0: B7 39 4A       STA    $394A
F6F3: 40             NEGA
F6F4: 84 03          ANDA   #$03
F6F6: B7 39 57       STA    $3957
F6F9: 39             RTS

F6FA: BD 8A 9B       JSR    $8A9B
F6FD: BD FA 92       JSR    $FA92
F700: 96 3F          LDA    $3F
F702: B1 29 A2       CMPA   $29A2
F705: 26 03          BNE    $F70A
F707: 7C 29 A3       INC    $29A3
F70A: 96 06          LDA    $06
F70C: 48             ASLA
F70D: 10 8E FE 8F    LDY    #table_fe8f
F711: 6E B6          JMP    [A,Y]	; [jump_table]

F713: CC 00 00       LDD    #$0000
F716: BD 84 F5       JSR    queue_event_84f5
F719: CC 01 03       LDD    #$0103
F71C: BD 84 F5       JSR    queue_event_84f5
F71F: CC 02 13       LDD    #$0213
F722: BD 84 F5       JSR    queue_event_84f5
F725: C6 14          LDB    #$14
F727: BD 84 F5       JSR    queue_event_84f5
F72A: 8E A4 C8       LDX    #$A4C8
F72D: 0F 48          CLR    nb_objects_48
F72F: D6 60          LDB    nb_players_minus_one_60
F731: D1 48          CMPB   nb_objects_48
F733: 25 16          BCS    $F74B
F735: D6 48          LDB    nb_objects_48
F737: E6 85          LDB    B,X
F739: 86 01          LDA    #$01
F73B: BD 84 F5       JSR    queue_event_84f5
F73E: D6 48          LDB    nb_objects_48
F740: CB 1D          ADDB   #$1D
F742: 86 02          LDA    #$02
F744: BD 84 F5       JSR    queue_event_84f5
F747: 0C 48          INC    nb_objects_48
F749: 20 E4          BRA    $F72F
F74B: 10 8E 29 90    LDY    #$2990
F74F: CC FF FF       LDD    #$FFFF
F752: ED A1          STD    ,Y++
F754: 10 8C 29 9C    CMPY   #$299C
F758: 26 F8          BNE    $F752
F75A: 4F             CLRA
F75B: 5F             CLRB
F75C: FD 29 9C       STD    $299C
F75F: FD 29 9E       STD    $299E
F762: 96 3F          LDA    $3F
F764: B7 29 A2       STA    $29A2
F767: 7F 29 A3       CLR    $29A3
F76A: 0F AA          CLR    $AA
F76C: 7F 2A 0A       CLR    $2A0A
F76F: 7F 10 80       CLR    flip_screen_set_1080
F772: 0C 06          INC    $06
F774: FC 2F E4       LDD    $2FE4
F777: C3 00 01       ADDD   #$0001
F77A: FD 2F E4       STD    $2FE4
F77D: 7F 2F E6       CLR    $2FE6
F780: B6 12 83       LDA    dsw1_1283
F783: 26 08          BNE    $F78D
F785: B6 12 00       LDA    dsw2_1200
F788: 26 03          BNE    $F78D
F78A: 73 2F E6       COM    $2FE6
F78D: 39             RTS

F78E: 8E 35 87       LDX    #$3587
F791: 10 8E FE 99    LDY    #$FE99
F795: CE FE B1       LDU    #$FEB1
F798: CC 04 03       LDD    #$0403
F79B: DD 48          STD    nb_objects_48
F79D: A6 C4          LDA    ,U
F79F: 1F 89          TFR    A,B
F7A1: ED 89 08 00    STD    $0800,X		; [video_address_word]
F7A5: EC A1          LDD    ,Y++
F7A7: ED 81          STD    ,X++		; [video_address_word]
F7A9: 0A 48          DEC    nb_objects_48
F7AB: 26 F0          BNE    $F79D
F7AD: 86 04          LDA    #$04
F7AF: 97 48          STA    nb_objects_48
F7B1: A6 C0          LDA    ,U+
F7B3: 30 88 38       LEAX   $38,X
F7B6: 0A 49          DEC    $49
F7B8: 26 E3          BNE    $F79D
F7BA: CE 30 C5       LDU    #$30C5
F7BD: BD FC AB       JSR    $FCAB
F7C0: 0C 06          INC    $06
F7C2: FC 2F E0       LDD    $2FE0
F7C5: C3 00 01       ADDD   #$0001
F7C8: FD 2F E0       STD    $2FE0
F7CB: 39             RTS

F7CC: B6 29 9C       LDA    $299C
F7CF: 81 1E          CMPA   #$1E
F7D1: 27 29          BEQ    $F7FC
F7D3: 10 8E FE BE    LDY    #$FEBE
F7D7: 48             ASLA
F7D8: 10 AE A6       LDY    A,Y
F7DB: 47             ASRA
F7DC: 81 1B          CMPA   #$1B
F7DE: 25 0C          BCS    $F7EC
F7E0: 80 1B          SUBA   #$1B
F7E2: 48             ASLA
F7E3: CE FE B8       LDU    #$FEB8
F7E6: EC C6          LDD    A,U
F7E8: ED A4          STD    ,Y		; [video_address_word]
F7EA: 20 04          BRA    $F7F0

F7EC: 8B 11          ADDA   #$11
F7EE: A7 A4          STA    ,Y			; [video_address]
F7F0: 86 00          LDA    #$00
F7F2: 1F 89          TFR    A,B
F7F4: ED A9 08 00    STD    $0800,Y		; [video_address_word]
F7F8: 7C 29 9C       INC    $299C
F7FB: 39             RTS

F7FC: 7F 29 9C       CLR    $299C
F7FF: 0C 06          INC    $06
F801: 39             RTS

F802: 8E 28 39       LDX    #$2839
F805: 96 DF          LDA    $DF
F807: 84 01          ANDA   #$01
F809: C6 03          LDB    #$03
F80B: 3D             MUL
F80C: 30 85          LEAX   B,X
F80E: A6 84          LDA    ,X
F810: 84 07          ANDA   #$07
F812: A7 84          STA    ,X
F814: 6D 84          TST    ,X
F816: 27 49          BEQ    $F861
F818: 7F 29 9D       CLR    $299D
F81B: 6D 01          TST    $1,X
F81D: 27 17          BEQ    $F836
F81F: 7D 29 9F       TST    $299F
F822: 27 05          BEQ    $F829
F824: 7A 29 9F       DEC    $299F
F827: 20 41          BRA    $F86A
F829: A6 01          LDA    $1,X
F82B: A4 84          ANDA   ,X
F82D: 84 05          ANDA   #$05
F82F: C6 0A          LDB    #$0A
F831: F7 29 9F       STB    $299F
F834: 20 0A          BRA    $F840
F836: A6 01          LDA    $1,X
F838: 43             COMA
F839: A4 84          ANDA   ,X
F83B: C6 20          LDB    #$20
F83D: F7 29 9F       STB    $299F
F840: B7 29 A1       STA    $29A1
F843: 76 29 A1       ROR    $29A1
F846: 24 03          BCC    $F84B
F848: BD F8 D9       JSR    $F8D9
F84B: 76 29 A1       ROR    $29A1
F84E: 24 09          BCC    $F859
F850: BD F8 FD       JSR    $F8FD
F853: 81 FF          CMPA   #$FF
F855: 10 27 01 14    LBEQ   $F96D
F859: 76 29 A1       ROR    $29A1
F85C: 24 03          BCC    $F861
F85E: BD F8 EB       JSR    $F8EB
F861: 96 3F          LDA    $3F
F863: 84 02          ANDA   #$02
F865: 26 03          BNE    $F86A
F867: 7C 29 9D       INC    $299D
F86A: 10 8E FE BE    LDY    #$FEBE
F86E: B6 29 9C       LDA    $299C
F871: 48             ASLA
F872: EC A6          LDD    A,Y
F874: D7 50          STB    $50
F876: 58             ASLB
F877: 49             ROLA
F878: 58             ASLB
F879: 49             ROLA
F87A: 48             ASLA
F87B: 48             ASLA
F87C: 48             ASLA
F87D: 40             NEGA
F87E: 80 0C          SUBA   #$0C
F880: 97 A1          STA    p2_attempts_left_a1
F882: 96 50          LDA    $50
F884: 48             ASLA
F885: 48             ASLA
F886: 48             ASLA
F887: 80 02          SUBA   #$02
F889: F6 29 9C       LDB    $299C
F88C: C1 1B          CMPB   #$1B
F88E: 25 02          BCS    $F892
F890: 8B 03          ADDA   #$03
F892: 97 A2          STA    $A2
F894: 8E 28 A0       LDX    #$28A0
F897: 10 8E DD 6E    LDY    #$DD6E
F89B: CE 18 00       LDU    #sprite_ram_1800
F89E: BD D1 2F       JSR    $D12F
F8A1: 86 40          LDA    #$40
F8A3: 0D 21          TST    copy_of_screen_flipped_21
F8A5: 27 02          BEQ    $F8A9
F8A7: 86 80          LDA    #$80
F8A9: F6 29 9C       LDB    $299C
F8AC: C1 1B          CMPB   #$1B
F8AE: 25 04          BCS    $F8B4
F8B0: 8A 02          ORA    #$02
F8B2: 20 02          BRA    $F8B6
F8B4: 8A 01          ORA    #$01
F8B6: B7 18 00       STA    sprite_ram_1800
F8B9: B6 29 9D       LDA    $299D
F8BC: 81 FF          CMPA   #$FF
F8BE: 10 27 00 AB    LBEQ   $F96D
F8C2: 39             RTS

F8C3: F6 29 9C       LDB    $299C
F8C6: 8E FE BE       LDX    #$FEBE
F8C9: 58             ASLB
F8CA: AE 85          LDX    B,X
F8CC: C6 0A          LDB    #$0A
F8CE: D8 73          EORB   $73
F8D0: E7 89 08 00    STB    $0800,X
F8D4: E7 89 08 01    STB    $0801,X
F8D8: 39             RTS

F8D9: 86 17          LDA    #$17
F8DB: BD 85 0E       JSR    $850E
F8DE: F6 29 9C       LDB    $299C
F8E1: 5C             INCB
F8E2: C1 1E          CMPB   #$1E
F8E4: 26 01          BNE    $F8E7
F8E6: 5F             CLRB
F8E7: F7 29 9C       STB    $299C
F8EA: 39             RTS

F8EB: 86 17          LDA    #$17
F8ED: BD 85 0E       JSR    $850E
F8F0: F6 29 9C       LDB    $299C
F8F3: C0 01          SUBB   #$01
F8F5: 2A 02          BPL    $F8F9
F8F7: C6 1D          LDB    #$1D
F8F9: F7 29 9C       STB    $299C
F8FC: 39             RTS

F8FD: 86 1B          LDA    #$1B
F8FF: BD 85 0E       JSR    $850E
F902: F6 29 9C       LDB    $299C
F905: C1 1B          CMPB   #$1B
F907: 27 36          BEQ    $F93F
F909: C1 1C          CMPB   #$1C
F90B: 27 36          BEQ    $F943
F90D: C1 1D          CMPB   #$1D
F90F: 27 59          BEQ    $F96A
F911: CB 11          ADDB   #$11
F913: D7 48          STB    nb_objects_48
F915: 8E 29 90       LDX    #$2990
F918: D6 DF          LDB    $DF
F91A: 86 03          LDA    #$03
F91C: 3D             MUL
F91D: 30 85          LEAX   B,X
F91F: F6 29 9E       LDB    $299E
F922: 96 48          LDA    nb_objects_48
F924: A7 85          STA    B,X
F926: 8E 35 16       LDX    #$3516
F929: D6 DF          LDB    $DF
F92B: 86 80          LDA    #$80
F92D: 3D             MUL
F92E: 30 8B          LEAX   D,X
F930: F6 29 9E       LDB    $299E
F933: 96 48          LDA    nb_objects_48
F935: A7 85          STA    B,X		; [video_address]
F937: C1 02          CMPB   #$02
F939: 27 2F          BEQ    $F96A
F93B: 7C 29 9E       INC    $299E
F93E: 39             RTS

F93F: C6 10          LDB    #$10
F941: 20 D0          BRA    $F913

F943: F6 29 9E       LDB    $299E
F946: 27 21          BEQ    $F969
F948: 7A 29 9E       DEC    $299E
F94B: 10 8E 35 16    LDY    #$3516
F94F: 96 DF          LDA    $DF
F951: C6 80          LDB    #$80
F953: 3D             MUL
F954: 31 AB          LEAY   D,Y
F956: CE 29 90       LDU    #$2990
F959: 96 DF          LDA    $DF
F95B: C6 03          LDB    #$03
F95D: 3D             MUL
F95E: 33 CB          LEAU   D,U
F960: F6 29 9E       LDB    $299E
F963: 86 10          LDA    #$10
F965: A7 A5          STA    B,Y
F967: A7 C5          STA    B,U
F969: 39             RTS

F96A: 86 FF          LDA    #$FF
F96C: 39             RTS

F96D: BD FA C3       JSR    $FAC3
F970: BD FA EE       JSR    $FAEE
F973: 96 DF          LDA    $DF
F975: 91 60          CMPA   nb_players_minus_one_60
F977: 27 1C          BEQ    $F995
F979: 0C DF          INC    $DF
F97B: 4C             INCA
F97C: B7 29 9C       STA    $299C
F97F: D6 2D          LDB    dsw2_copy_2d
F981: C5 04          BITB   #$04
F983: 26 06          BNE    $F98B
F985: 47             ASRA
F986: B7 10 80       STA    flip_screen_set_1080
F989: 97 21          STA    copy_of_screen_flipped_21
F98B: 7F 29 9D       CLR    $299D
F98E: 7F 29 9E       CLR    $299E
F991: 7F 29 9F       CLR    $299F
F994: 39             RTS

F995: 86 3C          LDA    #$3C
F997: B7 29 9C       STA    $299C
F99A: 0C 06          INC    $06
F99C: 39             RTS

F99D: FC 2F E4       LDD    $2FE4
F9A0: 10 83 05 DC    CMPD   #$05DC
F9A4: 26 0B          BNE    $F9B1
F9A6: 86 19          LDA    #$19
F9A8: B7 2F E7       STA    $2FE7
F9AB: CC 65 DB       LDD    #$65DB
F9AE: FD 2F EE       STD    $2FEE
F9B1: 7D 29 A3       TST    $29A3
F9B4: 27 76          BEQ    $FA2C
F9B6: 7A 29 9C       DEC    $299C
F9B9: 26 71          BNE    $FA2C
F9BB: 7F 29 A0       CLR    $29A0
F9BE: 7F 10 80       CLR    flip_screen_set_1080
F9C1: 0F 03          CLR    boot_state_03
F9C3: 0F 06          CLR    $06
F9C5: 4F             CLRA
F9C6: BD 85 0E       JSR    $850E
F9C9: 10 8E 2A 52    LDY    #$2A52
F9CD: 8E 29 90       LDX    #$2990
F9D0: 86 04          LDA    #$04
F9D2: 97 48          STA    nb_objects_48
F9D4: A6 02          LDA    $2,X
F9D6: 80 10          SUBA   #$10
F9D8: 46             RORA
F9D9: 66 21          ROR    $1,Y
F9DB: 46             RORA
F9DC: 66 21          ROR    $1,Y
F9DE: 46             RORA
F9DF: 66 21          ROR    $1,Y
F9E1: 46             RORA
F9E2: 66 21          ROR    $1,Y
F9E4: 46             RORA
F9E5: 66 21          ROR    $1,Y
F9E7: A6 01          LDA    $1,X
F9E9: 80 10          SUBA   #$10
F9EB: 46             RORA
F9EC: 66 21          ROR    $1,Y
F9EE: 46             RORA
F9EF: 66 21          ROR    $1,Y
F9F1: 46             RORA
F9F2: 66 21          ROR    $1,Y
F9F4: 46             RORA
F9F5: 66 A4          ROR    ,Y
F9F7: 46             RORA
F9F8: 66 A4          ROR    ,Y
F9FA: A6 84          LDA    ,X
F9FC: 80 10          SUBA   #$10
F9FE: 46             RORA
F9FF: 66 A4          ROR    ,Y
FA01: 46             RORA
FA02: 66 A4          ROR    ,Y
FA04: 46             RORA
FA05: 66 A4          ROR    ,Y
FA07: 46             RORA
FA08: 66 A4          ROR    ,Y
FA0A: 46             RORA
FA0B: 66 A4          ROR    ,Y
FA0D: 66 A4          ROR    ,Y
FA0F: 31 22          LEAY   $2,Y
FA11: 30 03          LEAX   $3,X
FA13: 0A 48          DEC    nb_objects_48
FA15: 26 BD          BNE    $F9D4
FA17: 86 03          LDA    #$03
FA19: 97 00          STA    global_state_00
FA1B: 0F DF          CLR    $DF
FA1D: CC 00 00       LDD    #$0000
FA20: FD 18 00       STD    sprite_ram_1800
FA23: FD 1C 00       STD    $1C00
FA26: FD 29 9C       STD    $299C
FA29: FD 29 9E       STD    $299E
FA2C: B6 2F E6       LDA    $2FE6
FA2F: 27 60          BEQ    $FA91
FA31: 7F 10 80       CLR    flip_screen_set_1080
FA34: FC 29 90       LDD    $2990
FA37: 10 83 19 23    CMPD   #$1923
FA3B: 26 54          BNE    $FA91
FA3D: FC 29 92       LDD    $2992
FA40: 10 83 19 18    CMPD   #$1918
FA44: 26 4B          BNE    $FA91
FA46: FC 29 94       LDD    $2994
FA49: 10 83 11 22    CMPD   #$1122
FA4D: 26 42          BNE    $FA91
FA4F: FC 29 96       LDD    $2996
FA52: 10 83 11 2B    CMPD   #$112B
FA56: 26 39          BNE    $FA91
FA58: FC 29 98       LDD    $2998
FA5B: 10 83 1C 11    CMPD   #$1C11
FA5F: 26 30          BNE    $FA91
FA61: FC 29 9A       LDD    $299A
FA64: 10 83 12 1F    CMPD   #$121F
FA68: 26 27          BNE    $FA91
FA6A: CC 0A 1B       LDD    #$0A1B
FA6D: FD 34 8A       STD    $348A
FA70: CC 1F 1E       LDD    #$1F1E
FA73: FD 34 8C       STD    $348C
FA76: CC 11 1D       LDD    #$111D
FA79: FD 34 8E       STD    $348E
FA7C: CC 19 10       LDD    #$1910
FA7F: FD 34 90       STD    $3490
FA82: CC 01 09       LDD    #$0109
FA85: FD 34 92       STD    $3492
FA88: CC 08 03       LDD    #$0803
FA8B: FD 34 94       STD    $3494
FA8E: 7E FA 8E       JMP    $FA8E
FA91: 39             RTS

FA92: 8E 3B C7       LDX    #$3BC7
FA95: 10 8E FE B4    LDY    #$FEB4
FA99: 96 3F          LDA    $3F
FA9B: 47             ASRA
FA9C: 47             ASRA
FA9D: 84 03          ANDA   #$03
FA9F: A6 A6          LDA    A,Y
FAA1: C6 0F          LDB    #$0F
FAA3: A7 85          STA    B,X		; [video_address]
FAA5: 5A             DECB
FAA6: 26 FB          BNE    $FAA3
FAA8: D6 DF          LDB    $DF
FAAA: C1 FF          CMPB   #$FF
FAAC: 27 14          BEQ    $FAC2
FAAE: 8E 3D 11       LDX    #$3D11
FAB1: 34 02          PSHS   A
FAB3: 58             ASLB
FAB4: 86 40          LDA    #$40
FAB6: 3D             MUL
FAB7: 30 8B          LEAX   D,X
FAB9: 35 02          PULS   A
FABB: C6 07          LDB    #$07
FABD: A7 85          STA    B,X		; [video_address]
FABF: 5A             DECB
FAC0: 26 FB          BNE    $FABD
FAC2: 39             RTS

FAC3: 8E 29 90       LDX    #$2990
FAC6: 96 DF          LDA    $DF
FAC8: C6 03          LDB    #$03
FACA: 3D             MUL
FACB: 30 85          LEAX   B,X
FACD: A6 80          LDA    ,X+
FACF: 81 FF          CMPA   #$FF
FAD1: 26 08          BNE    $FADB
FAD3: 96 DF          LDA    $DF
FAD5: 8B 11          ADDA   #$11
FAD7: A7 1F          STA    -$1,X
FAD9: 20 02          BRA    $FADD

FADB: 86 10          LDA    #$10
FADD: E6 80          LDB    ,X+
FADF: C1 FF          CMPB   #$FF
FAE1: 26 02          BNE    $FAE5
FAE3: A7 1F          STA    -$1,X
FAE5: E6 84          LDB    ,X
FAE7: C1 FF          CMPB   #$FF
FAE9: 26 02          BNE    $FAED
FAEB: A7 84          STA    ,X
FAED: 39             RTS

FAEE: 8E 35 16       LDX    #$3516
FAF1: 10 8E 29 90    LDY    #$2990
FAF5: 96 DF          LDA    $DF
FAF7: C6 03          LDB    #$03
FAF9: 3D             MUL
FAFA: 31 AB          LEAY   D,Y
FAFC: 96 DF          LDA    $DF
FAFE: C6 80          LDB    #$80
FB00: 3D             MUL
FB01: 30 8B          LEAX   D,X
FB03: EC A4          LDD    ,Y
FB05: ED 84          STD    ,X		; [video_address_word]
FB07: A6 22          LDA    $2,Y
FB09: A7 02          STA    $2,X		; [video_address_word]
FB0B: 10 8E A4 C8    LDY    #$A4C8
FB0F: 96 DF          LDA    $DF
FB11: A6 A6          LDA    A,Y
FB13: 1F 89          TFR    A,B
FB15: ED 89 07 FC    STD    $07FC,X		; [video_address_word]
FB19: ED 89 07 FE    STD    $07FE,X		; [video_address_word]
FB1D: ED 89 08 00    STD    $0800,X		; [video_address_word]
FB21: A7 89 08 02    STA    $0802,X		; [video_address_word]
FB25: 39             RTS

FB26: A6 88 38       LDA    $38,X
FB29: 80 2D          SUBA   #$2D
FB2B: 27 13          BEQ    $FB40
FB2D: 2A 01          BPL    $FB30
FB2F: 40             NEGA
FB30: 81 01          CMPA   #$01
FB32: 27 08          BEQ    $FB3C
FB34: 81 02          CMPA   #$02
FB36: 26 1F          BNE    $FB57
FB38: 86 01          LDA    #$01
FB3A: 20 06          BRA    $FB42
FB3C: 86 03          LDA    #$03
FB3E: 20 02          BRA    $FB42
FB40: 86 06          LDA    #$06
FB42: 10 8E 28 B3    LDY    #$28B3
FB46: AB A2          ADDA   ,-Y
FB48: 19             DAA
FB49: 85 70          BITA   #$70
FB4B: 27 08          BEQ    $FB55
FB4D: 84 0F          ANDA   #$0F
FB4F: A7 A4          STA    ,Y
FB51: 86 01          LDA    #$01
FB53: 20 F1          BRA    $FB46
FB55: A7 A4          STA    ,Y
FB57: DC B0          LDD    $B0
FB59: 10 83 01 05    CMPD   #$0105
FB5D: 25 0A          BCS    $FB69
FB5F: CC 01 05       LDD    #$0105
FB62: DD B0          STD    $B0
FB64: CC 00 00       LDD    #$0000
FB67: DD B2          STD    $B2
FB69: 39             RTS

FB6A: 6F E2          CLR    ,-S
FB6C: 6F E2          CLR    ,-S
FB6E: 6C E4          INC    ,S
FB70: 58             ASLB
FB71: 24 FB          BCC    $FB6E
FB73: 56             RORB
FB74: E7 61          STB    $1,S
FB76: 5F             CLRB
FB77: A0 61          SUBA   $1,S
FB79: 24 06          BCC    $FB81
FB7B: AB 61          ADDA   $1,S
FB7D: 1C FE          ANDCC  #$FE
FB7F: 20 02          BRA    $FB83
FB81: 1A 01          ORCC   #$01
FB83: 59             ROLB
FB84: 64 61          LSR    $1,S
FB86: 6A E4          DEC    ,S
FB88: 26 ED          BNE    $FB77
FB8A: 6F E0          CLR    ,S+
FB8C: 6F E0          CLR    ,S+
FB8E: 39             RTS

FB8F: 34 20          PSHS   Y
FB91: 10 8E 28 39    LDY    #$2839
FB95: B6 28 DF       LDA    $28DF
FB98: 46             RORA
FB99: 24 02          BCC    $FB9D
FB9B: 31 23          LEAY   $3,Y
FB9D: A6 22          LDA    $2,Y
FB9F: AA 21          ORA    $1,Y
FBA1: 43             COMA
FBA2: A4 A4          ANDA   ,Y
FBA4: 35 20          PULS   Y
FBA6: 39             RTS

FBA7: 10 8E 28 39    LDY    #$2839
FBAB: B6 28 DF       LDA    $28DF
FBAE: 46             RORA
FBAF: 24 02          BCC    $FBB3
FBB1: 31 23          LEAY   $3,Y
FBB3: A6 A4          LDA    ,Y
FBB5: 39             RTS

FBB6: 96 2C          LDA    dsw1_copy_2c
FBB8: 84 0F          ANDA   #$0F
FBBA: 81 0F          CMPA   #$0F
FBBC: 27 0A          BEQ    $FBC8
FBBE: 96 23          LDA    number_of_credits_23
FBC0: 27 06          BEQ    $FBC8
FBC2: 7F 2B 40       CLR    display_state_2b40
FBC5: 7E 76 A5       JMP    $76A5

FBC8: B6 2B 40       LDA    display_state_2b40
FBCB: 48             ASLA
FBCC: 8E FE FA       LDX    #table_fefa
FBCF: 6E 96          JMP    [A,X]	; [jump_table]

init_title_screen_fbd1:
FBD1: CC 30 F0       LDD    #$30F0
FBD4: 8E 18 00       LDX    #sprite_ram_1800
FBD7: CE 1C 00       LDU    #$1C00
FBDA: E7 80          STB    ,X+
FBDC: E7 C0          STB    ,U+
FBDE: 4A             DECA
FBDF: 26 F9          BNE    $FBDA
FBE1: CC 00 00       LDD    #$0000
FBE4: BD 84 F5       JSR    queue_event_84f5
FBE7: 7C 2B 40       INC    display_state_2b40
FBEA: 86 02          LDA    #$02
FBEC: B7 2B 4E       STA    $2B4E
FBEF: 7F 10 80       CLR    flip_screen_set_1080
FBF2: 0F 21          CLR    copy_of_screen_flipped_21
FBF4: 86 90          LDA    #$90
FBF6: B7 2B 41       STA    $2B41
FBF9: 8E 2B 50       LDX    #$2B50
FBFC: A7 84          STA    ,X
FBFE: 8B 21          ADDA   #$21
FC00: A7 03          STA    $3,X
FC02: 8B 14          ADDA   #$14
FC04: A7 06          STA    $6,X
FC06: 8B 16          ADDA   #$16
FC08: A7 09          STA    $9,X
FC0A: 86 38          LDA    #$38
FC0C: 97 A1          STA    p2_attempts_left_a1
FC0E: CC DC B6       LDD    #$DCB6
FC11: ED 01          STD    $1,X
FC13: C3 00 08       ADDD   #$0008
FC16: ED 04          STD    $4,X
FC18: C3 00 08       ADDD   #$0008
FC1B: ED 07          STD    $7,X
FC1D: C3 00 08       ADDD   #$0008
FC20: ED 0A          STD    $A,X
FC22: 39             RTS

draw_title_tiles_fc23:
FC23: CE 30 E1       LDU    #video_ram_3000+$E1
FC26: BD FC AB       JSR    $FCAB
FC29: CE 35 00       LDU    #video_ram_3000+$500
FC2C: 86 40          LDA    #$40
FC2E: B7 2B 4D       STA    $2B4D
FC31: 86 1C          LDA    #$1C
FC33: C6 40          LDB    #$40
FC35: E7 C9 08 00    STB    $0800,U		; [video_address]
FC39: A7 C0          STA    ,U+			; [video_address]
FC3B: 7A 2B 4D       DEC    $2B4D
FC3E: 26 06          BNE    $FC46
FC40: 4C             INCA
FC41: C6 40          LDB    #$40
FC43: F7 2B 4D       STB    $2B4D
FC46: 11 83 36 80    CMPU   #$3680
FC4A: 26 E7          BNE    $FC33
FC4C: CE 34 46       LDU    #$3446
FC4F: CC 12 40       LDD    #$1240
FC52: B7 2B 4D       STA    $2B4D
FC55: E7 C9 08 00    STB    $0800,U		; [video_address]
FC59: A6 80          LDA    ,X+
FC5B: A7 C0          STA    ,U+			; [video_address]
FC5D: 7A 2B 4D       DEC    $2B4D
FC60: 26 F3          BNE    $FC55
FC62: 33 C8 2E       LEAU   $2E,U
FC65: 11 83 35 06    CMPU   #$3506
FC69: 26 E4          BNE    $FC4F
FC6B: CC 01 00       LDD    #$0100
FC6E: BD 84 F5       JSR    queue_event_84f5
FC71: CC 02 1C       LDD    #$021C
FC74: BD 84 F5       JSR    queue_event_84f5
FC77: CC 02 3E       LDD    #$023E
FC7A: BD 84 F5       JSR    queue_event_84f5
FC7D: 7C 2B 40       INC    display_state_2b40
animate_runners_in_title_fc80:
FC80: BD FD 07       JSR    $FD07
FC83: CE 18 42       LDU    #scroll_registers_1840+2
FC86: A6 C4          LDA    ,U			; [scroll_address]
FC88: 81 E0          CMPA   #$E0
FC8A: 26 03          BNE    $FC8F
; title reached scroll final position: next state
FC8C: 7C 2B 40       INC    display_state_2b40
; scroll title to the left
FC8F: 6C C0          INC    ,U+			; [scroll_address]
FC91: 11 83 18 50    CMPU   #scroll_registers_1840+$10
FC95: 26 F8          BNE    $FC8F
FC97: 39             RTS

FC98: BD FD 07       JSR    $FD07
FC9B: 7C 2B 41       INC    $2B41
FC9E: 26 0A          BNE    $FCAA
FCA0: 7A 2B 4E       DEC    $2B4E
FCA3: 26 05          BNE    $FCAA
FCA5: 0C 0F          INC    $0F
FCA7: 7F 2B 40       CLR    display_state_2b40
FCAA: 39             RTS

FCAB: 8E FF 02       LDX    #$FF02
FCAE: 86 03          LDA    #$03
FCB0: B7 2B 5F       STA    $2B5F
FCB3: CC 07 40       LDD    #$0740
FCB6: B7 2B 4D       STA    $2B4D
FCB9: E7 C9 08 00    STB    $0800,U  ; [video_address]
FCBD: A6 80          LDA    ,X+
FCBF: A7 C0          STA    ,U+      ; [video_address]
FCC1: 7A 2B 4D       DEC    $2B4D
FCC4: 26 F3          BNE    $FCB9
FCC6: 33 C8 39       LEAU   $39,U
FCC9: 7A 2B 5F       DEC    $2B5F
FCCC: 26 E5          BNE    $FCB3
FCCE: 33 41          LEAU   $1,U
FCD0: 86 08          LDA    #$08
FCD2: B7 2B 5F       STA    $2B5F
FCD5: CC 13 40       LDD    #$1340
FCD8: B7 2B 4D       STA    $2B4D
FCDB: E7 C9 08 00    STB    $0800,U      ; [video_address]
FCDF: A6 80          LDA    ,X+
FCE1: A7 C0          STA    ,U+      ; [video_address]
FCE3: 7A 2B 4D       DEC    $2B4D
FCE6: 26 F3          BNE    $FCDB
FCE8: 33 C8 2D       LEAU   dsw2_copy_2d,U
FCEB: 7A 2B 5F       DEC    $2B5F
FCEE: 26 E5          BNE    $FCD5
FCF0: 33 C9 FD 87    LEAU   -$0279,U
FCF4: 86 12          LDA    #$12
FCF6: B7 2B 4D       STA    $2B4D
FCF9: E7 C9 08 00    STB    $0800,U      ; [video_address]
FCFD: A6 80          LDA    ,X+
FCFF: A7 C0          STA    ,U+      ; [video_address]
FD01: 7A 2B 4D       DEC    $2B4D
FD04: 26 F3          BNE    $FCF9
FD06: 39             RTS

FD07: B6 2B 4F       LDA    $2B4F
FD0A: 8B 40          ADDA   #$40
FD0C: B7 2B 4F       STA    $2B4F
FD0F: 26 63          BNE    $FD74
FD11: 0F DF          CLR    $DF
FD13: B6 2B 50       LDA    $2B50
FD16: 4C             INCA
FD17: 97 A2          STA    $A2
FD19: FC 2B 51       LDD    $2B51
FD1C: CE 18 00       LDU    #sprite_ram_1800
FD1F: BD FD 75       JSR    $FD75
FD22: 96 A2          LDA    $A2
FD24: B7 2B 50       STA    $2B50
FD27: DC AE          LDD    $AE
FD29: FD 2B 51       STD    $2B51
FD2C: B6 2B 53       LDA    $2B53
FD2F: 97 A2          STA    $A2
FD31: FC 2B 54       LDD    $2B54
FD34: CE 18 08       LDU    #$1808
FD37: BD FD 75       JSR    $FD75
FD3A: 96 A2          LDA    $A2
FD3C: B7 2B 53       STA    $2B53
FD3F: DC AE          LDD    $AE
FD41: FD 2B 54       STD    $2B54
FD44: B6 2B 56       LDA    $2B56
FD47: 97 A2          STA    $A2
FD49: FC 2B 57       LDD    $2B57
FD4C: CE 18 10       LDU    #$1810
FD4F: BD FD 75       JSR    $FD75
FD52: 96 A2          LDA    $A2
FD54: B7 2B 56       STA    $2B56
FD57: DC AE          LDD    $AE
FD59: FD 2B 57       STD    $2B57
FD5C: B6 2B 59       LDA    $2B59
FD5F: 97 A2          STA    $A2
FD61: FC 2B 5A       LDD    $2B5A
FD64: CE 18 18       LDU    #$1818
FD67: BD FD 75       JSR    $FD75
FD6A: 96 A2          LDA    $A2
FD6C: B7 2B 59       STA    $2B59
FD6F: DC AE          LDD    $AE
FD71: FD 2B 5A       STD    $2B5A
FD74: 39             RTS

FD75: C3 00 04       ADDD   #$0004
FD78: DD AE          STD    $AE
FD7A: 96 A2          LDA    $A2
FD7C: 8B 04          ADDA   #$04
FD7E: 97 A2          STA    $A2
FD80: 8E 28 A0       LDX    #$28A0
FD83: BD CE C4       JSR    $CEC4
FD86: 0C DF          INC    $DF
FD88: 39             RTS

table_fd89:
	dc.w	$f02b	; $fd89
	dc.w	$f05c	; $fd8b
	dc.w	$f18c	; $fd8d
	dc.w	$f232	; $fd8f
	dc.w	$f33f	; $fd91
	dc.w	$f3c6	; $fd93
	
table_fddd:
	dc.w	$f44f	; $fddd
	dc.w	$f497	; $fddf
	dc.w	$f50e	; $fde1
	dc.w	$f545	; $fde3
	
table_fe4b:
	dc.w	$f54e	; $fe4b
	dc.w	$f5eb	; $fe4d
	dc.w	$f690	; $fe4f

table_fe8f:
	dc.w	$f713	; $fe8f
	dc.w	$f78e	; $fe91
	dc.w	$f7cc	; $fe93
	dc.w	$f802	; $fe95
	dc.w	$f99d	; $fe97
	
table_fefa:
	dc.w	init_title_screen_fbd1	; $fefa
	dc.w	draw_title_tiles_fc23	; $fefc
	dc.w	animate_runners_in_title_fc80	; $fefe
	dc.w	$fc98	; $ff00