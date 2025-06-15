import re,pathlib

# post-conversion automatic patches, allowing not to change the asm file by hand
tablere = re.compile("move.w\t#(table_....),d(.)")
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

with open(source_dir / "conv.s") as f:
    lines = list(f)

    for i,line in enumerate(lines):
        if " = " in line:
            equates.append(line)
            line = ""

        # remove code for rom checks, watchdog, ...
        for p in ("[rom_check_code]","watchdog_1000"):
            line = remove_code(p,lines,i)

        if "dsw1_" in line:
            line = change_instruction("jbsr\tosd_read_dsw_1",lines,i)
        if "dsw2_" in line:
            line = change_instruction("jbsr\tosd_read_dsw_2",lines,i)

        if "multiply_ab" in line and "MAKE_D" in lines[i+1]:
            lines[i+1] = ""

        line = re.sub(tablere,subt,line)
        if "[$83bd" in line or "[$9db1" in line or "[$d804" in line:
            line = "\tPUSH_SR\n"+line
            lines[i+1] = lines[i+1]+"\tPOP_SR\n"
            lines[i+3] = ""


        elif "[$83cc" in line:
            line = change_instruction("subq.b\t#0x01,(a0)",lines,i)
            lines[i-1] = ""
            lines[i+1] = remove_instruction(lines,i+1)
            lines[i+2] = ""
            lines[i+4] = ""

        elif "[$6600" in line:
            line = "irq_6600:\n"+line
        elif "[$f000" in line:
            line = "reset_f000:\n"+line
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
\t.global\treset_f000
""")
    fw.writelines(lines)