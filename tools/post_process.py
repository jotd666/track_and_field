import re,pathlib

# post-conversion automatic patches, allowing not to change the asm file by hand
tablere = re.compile("move.w\t#(\w*table_....),d(.)")
jmpre = re.compile("(j..)\s+\[a,(.)\]")

def remove_instruction(lines,i):
    return change_instruction("",lines,i)

def remove_continuing_lines(lines,i):
    for j in range(i+1,i+4):
        if "[...]" in lines[j]:
            lines[j] = ""
        else:
            break

def change_instruction(code,lines,i):
    line = lines[i]
    toks = line.split("|")
    if len(toks)==2:
        toks[0] = f"\t{code}"
        remove_continuing_lines(lines,i)
        return " | ".join(toks)
    return line

def remove_code(pattern,lines,i):
    if pattern in lines[i]:
        lines[i] = remove_instruction(lines,i)
        remove_continuing_lines(lines,i)
    return lines[i]

def subt(m):
    tn = m.group(1)
    rn = m.group(2)
    return  f"lea\t{tn},a{rn}"

equates = []

this_dir = pathlib.Path(__file__).absolute().parent

source_dir = this_dir / "../src"

input_dict = {"system_1280":"read_system_inputs",
"in0_1281":"read_inputs_1",
"in1_1282":"read_inputs_2",
"audio_register_w_1100":"sound_start",
"nmi_mask_w_1082":"",
"sh_irqtrigger_w_1081":"",
}

store_to_video = re.compile("GET_ADDRESS\s+0x3")

# various dirty but at least automatic patches applying on the specific track and field code
with open(source_dir / "conv.s") as f:
    lines = list(f)

    for i,line in enumerate(lines):
        if " = " in line:
            equates.append(line)
            line = ""

        # remove code for rom checks, watchdog, ...
        for p in ("[rom_check_code]","watchdog_1000","coin_counter"):
            line = remove_code(p,lines,i)

        # pre-add video_address tag if we find a store instruction to an explicit 3000-3FFF address
        if store_to_video.search(line):
            line = line.rstrip() + " [video_address]\n"

        if "[video_address" in line:
            # give me the original instruction
            line = line.replace("_ADDRESS","_UNCHECKED_ADDRESS")
            # if it's a write, insert a "VIDEO_DIRTY" macro after the write
            for j in range(i+1,len(lines)):
                next_line = lines[j]
                if "[...]" not in next_line:
                    break
                if ",(a0)" in next_line or "clr" in next_line or "MOVE_W_FROM_REG" in next_line:
                    if any(x in next_line for x in ["address_word","MOVE_W_FROM_REG"]):
                        lines[j] = next_line+"\tVIDEO_WORD_DIRTY | [...]\n"
                    else:
                        lines[j] = next_line+"\tVIDEO_BYTE_DIRTY | [...]\n"
                    break

# not really needed
##        if "[scroll_address" in line:
##            # give me the original instruction
##            line = line.replace("_ADDRESS","_UNCHECKED_ADDRESS")
##            # if it's a write, insert a "SCROLL_DIRTY" macro after the write
##            for j in range(i+1,len(lines)):
##                next_line = lines[j]
##                if "[...]" not in next_line:
##                    break
##                if ",(a0)" in next_line or "clr" in next_line or "MOVE_W_FROM_REG" in next_line:
##                    if any(x in next_line for x in ["address_word","MOVE_W_FROM_REG"]):
##                        lines[j] = next_line+"\tSCROLL_WORD_DIRTY | [...]\n"
##                    else:
##                        lines[j] = next_line+"\tSCROLL_BYTE_DIRTY | [...]\n"
##                    break
        line = re.sub(tablere,subt,line)

        if "dsw1_1283" in line and "lda" in line:
            line = change_instruction("jbsr\tosd_read_dsw_1",lines,i)
        elif "dsw2_1200" in line and "lda" in line:
            line = change_instruction("jbsr\tosd_read_dsw_2",lines,i)

        if "multiply_ab" in line and "MAKE_D" in lines[i+1]:
            lines[i+1] = ""
        if "tfr" in line and "POP_SR" in lines[i+1] and "PUSH_SR" in lines[i-1]:
            # we don't need to save SR in this game when a TFR is done
            lines[i-1] = ""
            lines[i+1] = ""
        if "rox" in line and "POP_SR" in lines[i-1] and "PUSH_SR" in lines[i-3]:
            # we don't need to save SR as roxx uses X flag
            lines[i-3] = ""
            lines[i-1] = ""

        if "[$6853" in line:
            # insert level select cheat
            line = line + "\tGET_DP_ADDRESS\tcurrent_level_84\n\tmove.b\tstart_level,(a0)\n"
##        if "[$727d" in line:
##            line = "\ttst.b\tinfinite_lives_flag\n\tjne\t0f\n" + line

        if "[$727f" in line:
            line = "0:\n"+line

##        if "[$7315" in line:
##            # insert nb attempts trainer
##            line = "\ttst.b\tinfinite_lives_flag\n\tjne\tl_732b\n" + line
        if "[$83bd" in line or "[$9db1" in line or "[$d804" in line:
            line = "\tPUSH_SR\n"+line
            lines[i+1] = lines[i+1]+"\tPOP_SR\n"
            lines[i+3] = ""

##        elif "[$877a" in line:
##            line = "\ttst.b\tinfinite_lives_flag\n\tjne\tqualified_878f\n"
        elif "[$605f" in line:
            # don't do the init clear loop
            line = remove_instruction(lines,i)
##        elif "[$878f" in line:
##            line = "qualified_878f:\n" + line

        elif "[$83cc" in line:
            line = change_instruction("subq.b\t#0x01,(a0)",lines,i)
            lines[i-1] = ""
            lines[i+1] = remove_instruction(lines,i+1)
            lines[i+2] = ""
            lines[i+4] = ""

        elif "flip_screen_set_1080" in line or "nmi_mask_1082" in line:
            line = remove_instruction(lines,i)
            remove_continuing_lines(lines,i)

        elif "irq_mask_w_1087" in line:
            # check next line
            next_line = lines[i+1]
            if "clr" in next_line:
                line = change_instruction("jbsr\tosd_disable_interrupts",lines,i)
            else:
                line = change_instruction("jbsr\tosd_enable_interrupts",lines,i)
                lines[i-1] = remove_instruction(lines,i-1)

        if "GET_ADDRESS" in line:
            val = line.split()[1]
            osd_call = input_dict.get(val)
            if osd_call is not None:
                if osd_call:
                    line = change_instruction(f"jbsr\tosd_{osd_call}",lines,i)
                else:
                    line = remove_instruction(lines,i)
                lines[i+1] = remove_instruction(lines,i+1)


        elif "unsupported instruction rti" in line:
            line = change_instruction("rts",lines,i)
        elif "unsupported instruction lds" in line:
            line = remove_instruction(lines,i)
        elif "unsupported instruction andcc" in line:
            line = change_instruction("CLR_XC_FLAGS",lines,i)
        elif "jump_table" in line:
            m = jmpre.search(line)
            if m:
                inst = m.group(1).upper()
                reg = "A2" if m.group(2)=="x" else "A3"
                rest = re.sub(".*\"","",line)
                line = f"\t{inst}_A_INDEXED\t{reg}{rest}"
        if "ERROR" in line:
            print(line)
        lines[i] = line




with open(source_dir / "data.inc","w") as fw:
    fw.writelines(equates)

with open(source_dir / "track_and_field.68k","w") as fw:
    fw.write("""\t.include "track_and_field.inc"
.include "data.inc"
\t.global\tirq_6600
\t.global\treset_6000
""")
    fw.writelines(lines)