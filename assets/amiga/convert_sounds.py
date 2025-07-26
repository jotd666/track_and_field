import subprocess,os,struct,glob,tempfile
import shutil

from shared import *

gamename = "track_and_field"
sox = "sox"

sound_dir = this_dir / ".." / "sounds"

def convert(out_dir,hq_sample_rate,lq_sample_rate,speech_sample_rate):
    if not shutil.which("sox"):
        raise Exception("sox command not in path, please install it")
    # BTW convert wav to mp3: ffmpeg -i input.wav -codec:a libmp3lame -b:a 330k output.mp3

    #wav_files = glob.glob("sounds/*.wav")

    vlq_sample_rate = 5000

    outfile = os.path.join(out_dir,"sounds.68k")
    sndfile = os.path.join(out_dir,"sound_entries.68k")


      #{"aga":18004,"ecs":12000,"ocs":11025}[mode]
     # if aga_mode else 8000


    loop_channel = 2
    on_air_channel = 1
    speech_channel = 3

    EMPTY_SND = "EMPTY_SND"
    sound_dict = {


    "STEP_SND"               :{"index":0x1,"channel":-1,"sample_rate":hq_sample_rate,"priority":40},
    "DWARF_SND"               :{"index":0x31,"channel":0,"sample_rate":hq_sample_rate,"priority":40},
   "BAR_13_SND"               :{"index":0x13,"channel":2,"sample_rate":hq_sample_rate,"priority":40},
   "BAR_10_SND"               :{"index":0x10,"channel":2,"sample_rate":hq_sample_rate,"priority":40},
   "SPACESHIP_FALLING_SND"               :{"index":0x1C,"channel":speech_channel,"sample_rate":lq_sample_rate,"priority":40},
   "HURDLE_SND"               :{"index":0x6,"channel":1,"sample_rate":hq_sample_rate,"priority":40},
    "HURDLE_2_SND"               :{"index":0x7,"channel":1,"sample_rate":hq_sample_rate,"priority":40},
    "HURDLE_A_SND"               :{"index":0xA,"channel":1,"sample_rate":hq_sample_rate,"priority":40},
    "HIGH_JUMP_FAIL_SND"            :{"index":0x2E,"channel":on_air_channel,"sample_rate":hq_sample_rate,"priority":40},
    "HIGH_JUMP_PASS_SND"            :{"index":0x2B,"channel":on_air_channel,"sample_rate":hq_sample_rate,"priority":40},
    "LONG_JUMP_SND"               :{"index":0x5,"channel":1,"sample_rate":hq_sample_rate,"priority":40},
    "JUMP_MEASURE_SND"               :{"index":0x25,"channel":loop_channel,"sample_rate":hq_sample_rate,"loops":True},
    "HURRY_SND"               :{"index":0x2f,"channel":1,"sample_rate":hq_sample_rate,"priority":40},
    "SWOOSH_SND"               :{"index":0x12,"channel":2,"sample_rate":hq_sample_rate,"priority":40},
    "HAMMER_MISS_SND"               :{"index":0x8,"channel":3,"sample_rate":hq_sample_rate,"priority":40},
    "THROW_SND"               :{"index":0xe,"channel":on_air_channel,"sample_rate":hq_sample_rate,"priority":40},
    "IN_AIR_SND"               :{"index":0x14,"channel":on_air_channel,"sample_rate":vlq_sample_rate,"priority":40},
    "LAND_SND"               :{"index":0xf,"channel":on_air_channel,"sample_rate":hq_sample_rate,"priority":40},
    "SOUND_B_SND"               :{"index":0xb,"channel":3,"sample_rate":hq_sample_rate,"priority":40},
    "SOUND_C_SND"               :{"index":0xc,"channel":3,"sample_rate":hq_sample_rate,"priority":40},
    "SOUND_D_SND"               :{"index":0xd,"channel":3,"sample_rate":hq_sample_rate,"priority":40},
    "CREDIT_SND"               :{"index":0x2,"channel":3,"sample_rate":hq_sample_rate,"priority":40},
    "LONG_JUMP_LAND_SND"        :{"index":0x9,"channel":on_air_channel,"sample_rate":hq_sample_rate,"priority":40},
    "GUNSHOT_SND"               :{"index":0xD,"channel":2,"sample_rate":hq_sample_rate,"priority":40},
    "CURSOR_MOVE_SND"            :{"index":0x17,"channel":3,"sample_rate":hq_sample_rate,"priority":40},
    "LETTER_ENTERED_SND"            :{"index":0x1b,"channel":3,"sample_rate":hq_sample_rate,"priority":40},
    "HORN_SND"               :{"index":0x28,"channel":3,"sample_rate":hq_sample_rate,"priority":40},
    "CHEERING_SND"               :{"index":0x41,"channel":loop_channel,"sample_rate":lq_sample_rate,"priority":40},
    "RECORD_BROKEN_TUNE_SND"      :{"index":0x33,"pattern":0x8,"volume":32},
    "CHARIOTS_TUNE_SND"      :{"index":0x1F,"pattern":0x3,"volume":32,"loops":True},
    "CHARIOTS_WIN_TUNE_SND"      :{"index":0x22,"pattern":0x3,"volume":32,"loops":True},  # same music for end and highscore
    "BEST_PLAYER_TUNE_SND"      :{"index":0x30,"pattern":0xA,"volume":32},
    "GAME_OVER_TUNE_SND"      :{"index":0x2D,"pattern":0xC,"volume":32},
    "START_EVENT_TUNE_SND"      :{"index":0x2C,"pattern":0xE,"volume":32},
    "NAME_ENTRY_SND"      :{"index":0x18,"pattern":0x0,"volume":32,"loops":True},


    }

    # ordering isn't very logic... ended up ripping the sounds with
    # cheering off, snapshot load just before finish in dash and setting
    # the proper second chrono. It's the fastest way to get sound ids and
    # rip them
    speech =  {"THE":0xA2,
    "SPACESHIP_SHOT":0xB0,
    "TIME":0x87,
    "POINT":0x85,
    "METRES":0x86,
    "SECONDS":0x88,
    "ZERO":0x90,
    "ONE":0x91,
    "TWO":0x92,
    "THREE":0x93,
    "FOUR":0x94,
    "FIVE":0x95,
    "SIX":0x96,
    "SEVEN":0x97,
    "EIGHT":0x98,
    "NINE":0x99,
    "TEN":0x9A,
    "ELEVEN":0x9B,
    "TWELVE":0x9C,
    "THIRTEEN":0x9D,
    "FOURTEEN":0xB6,
    "FIFTEEN":0xB7,
    "SIXTEEN":0xB8,
    "SEVENTEEN":0x9E,
    "EIGHTEEN":0xB9,
    "NINETEEN":0xBA,
    "TWENTY":0xBE,
    "THIRTY":0x9F,
    "FORTY":0xBB,
    "FIFTY":0xBC,
    "SIXTY":0xBD,
    "SEVENTY":0xBF,
    "EIGHTY":0xC0,
    "NINETY":0xC1,
    "ON_YOUR_MARK":0x80,
    "GET_SET":0x81,
    "FLYING":0xB3,
    "DISTANCE":0x84,
    "FOUL":0x82,
}




    # low quality is probably enough, speech sound is crap
    sound_dict.update({k+"_SND":{"index":v,"channel":speech_channel,"sample_rate":speech_sample_rate,"priority":40} for k,v in speech.items()})

    sound_dict["SIX_2_SND"] = {"index":0xA0,"same_as":"SIX_SND"}

    dummy_sounds = [
    0x34,3,4,  # credit
    0xC,0xB,
    0x40,
    0x1A,  # false start
    0xFF,
    0x1D,  # echo of ufo falling
      0x15,  # jav mount down echo
    ]

    with open(os.path.join(src_dir,"..","sounds.inc"),"w") as f:
        for k,v in sorted(sound_dict.items(),key = lambda x:x[1]["index"]):
            f.write(f"\t.equ\t{k},  0x{v['index']:x}\n")

    max_sound = 0x100  # max(x["index"] for x in sound_dict.values())+1
    sound_table = [""]*max_sound
    sound_table_set_1 = ["\t.long\t0,0"]*max_sound

    for d in dummy_sounds:
        sound_table_set_1[d] = f"\t.word\t3,0,0,0   | valid but muted"



    snd_header = rf"""
    # sound tables
    #
    # the "sound_table" table has 8 bytes per entry
    # first word: 0: no entry, 1: sample, 2: pattern from music module
    # second word: 0 except for music module: pattern number
    # longword: sample data pointer if sample, 0 if no entry and
    # 2 words: 0/1 noloop/loop followed by duration in ticks
    #
    # SOUND_ENTRY macro defines a ptplayer-compatible structure, with added the number
    # of ticks (PAL) giving the duration of the sample (offset 0xA)
    FXFREQBASE = 3579564

        .macro    SOUND_ENTRY    sound_name,size,channel,soundfreq,volume,priority,ticks
    \sound_name\()_sound:
        .long    \sound_name\()_raw
        .word   \size
        .word   FXFREQBASE/\soundfreq,\volume
        .byte    \channel
        .byte    \priority
        .word    \ticks
        .endm

    """

    def write_asm(contents,fw):
        n=0
        for c in contents:
            if n%16 == 0:
                fw.write("\n\t.byte\t0x{:x}".format(c))
            else:
                fw.write(",0x{:x}".format(c))
            n += 1
        fw.write("\n")

    music_module_label = f"{gamename}_tunes"

    raw_file = os.path.join(tempfile.gettempdir(),"out.raw")
    with open(sndfile,"w") as fst,open(outfile,"w") as fw:
        fst.write(snd_header)

        fw.write("\t.section\t.datachip\n")
        fw.write("\t.global\t{}\n".format(music_module_label))

        for wav_file,details in sound_dict.items():
            wav_name = os.path.basename(wav_file).lower()[:-4]
            if details.get("channel") is not None:
                fw.write("\t.global\t{}_raw\n".format(wav_name))


        for wav_entry,details in sound_dict.items():
            sound_index = details["index"]

            channel = details.get("channel")
            if channel is None:

                same_as = details.get("same_as")
                if same_as is None:
                    # if music loops, ticks are set to 1 so sound orders only can happen once (else music is started 50 times per second!!)

                    sound_table_set_1[sound_index] = "\t.word\t{},{},{}\n\t.byte\t{},{}".format(2,details["pattern"],0,details["volume"],int(details.get("loops",0)))
                else:
                    # aliased sound: reuse sample for a different sound index
                    wav_entry = same_as
                    details = sound_dict[same_as]
                    wav_name = os.path.basename(wav_entry).lower()[:-4]
                    wav = os.path.splitext(wav_name)[0]
                    sound_table_set_1[sound_index] = f"\t.word\t1,{int(details.get('loops',0))}\n\t.long\t{wav}_sound"
            else:
                wav_name = os.path.basename(wav_entry).lower()[:-4]
                wav_file = os.path.join(sound_dir,wav_name+".wav")

                def get_sox_cmd(sr,output):
                    return [sox,"--volume","3.0",wav_file,"--channels","1","-D","--bits","8","-r",str(sr),"--encoding","signed-integer",output]


                used_sampling_rate = details["sample_rate"]
                used_priority = details.get("priority",1)

                cmd = get_sox_cmd(used_sampling_rate,raw_file)

                subprocess.check_call(cmd)
                with open(raw_file,"rb") as f:
                    contents = f.read()

                # compute max amplitude so we can feed the sound chip with an amped sound sample
                # and reduce the replay volume. this gives better sound quality than replaying at max volume
                # (thanks no9 for the tip!)
                signed_data = [x if x < 128 else x-256 for x in contents]
                maxsigned = max(signed_data)
                minsigned = min(signed_data)

                amp_ratio = max(maxsigned,abs(minsigned))/32

                print(f"amp_ratio: {amp_ratio}")

                wav = os.path.splitext(wav_name)[0]
                if amp_ratio > 1:
                    print(f"{wav}: volume peaked {amp_ratio}")
                    amp_ratio = 1

                # added so we can monitor a kind of sound and queue it instead of
                # playing it right away (speech)
                ticks = details.get("ticks")
                if not ticks:
                    # default value
                    ticks = int(len(signed_data)/used_sampling_rate*85)+1  # inflate time (else speech is too fast)

                sound_table[sound_index] = "    SOUND_ENTRY {},{},{},{},{},{},{}\n".format(wav,len(signed_data)//2,channel,
                            used_sampling_rate,int(64*amp_ratio),used_priority,ticks)
                sound_table_set_1[sound_index] = f"\t.word\t1,{int(details.get('loops',0))}\n\t.long\t{wav}_sound"

                if amp_ratio > 0:
                    maxed_contents = [int(x/amp_ratio) for x in signed_data]
                else:
                    maxed_contents = signed_data



                signed_contents = bytes([x if x >= 0 else 256+x for x in maxed_contents])
                # pre-pad with 0W, used by ptplayer for idling
                if signed_contents[0] != b'\x00' and signed_contents[1] != b'\x00':
                    # add zeroes
                    signed_contents = struct.pack(">H",0) + signed_contents

                contents = signed_contents
                # align on 16-bit
                if len(contents)%2:
                    contents += b'\x00'
                # pre-pad with 0W, used by ptplayer for idling
                if contents[0] != b'\x00' and contents[1] != b'\x00':
                    # add zeroes
                    contents = b'\x00\x00' + contents

                fw.write("{}_raw:   | {} bytes".format(wav,len(contents)))

                if len(contents)>65530:
                    raise Exception(f"Sound {wav_entry} is too long")
                write_asm(contents,fw)


        # make sure next section will be aligned
        with open(os.path.join(sound_dir,f"tracknfield_conv.mod"),"rb") as f:
            contents = f.read()

        fw.write("{}:".format(music_module_label))
        write_asm(contents,fw)
        fw.write("\t.align\t8\n")


        fst.writelines(sound_table)
        fst.write("\n\t.global\t{0}\n\n{0}:\n".format("sound_table"))
        for i,st in enumerate(sound_table_set_1):
            fst.write(st)
            fst.write(" | {}\n".format(i))


hq=18004
convert(aga_src_dir,hq,hq//2,hq//2)
hq=11025
convert(ocs_src_dir,hq,8192,hq//2)



