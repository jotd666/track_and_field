import re

# post-conversion automatic patches, allowing not to change the asm file by hand
tablere = re.compile("move.w\t#(table_....),d(.)")
jmpre = re.compile("(j..)\s+\[a,(.)\]")

def remove_instruction(line):
    return change_instruction("",line)

def change_instruction(code,line):
    toks = line.split("|")
    toks[0] = f"\t{code}"
    return " | ".join(toks)

def subt(m):
    tn = m.group(1)
    rn = m.group(2)
    return  f"lea\t{tn},a{rn}"
with open("../src/conv.s") as f:
    lines = list(f)

    for i,line in enumerate(lines):
        line = re.sub(tablere,subt,line)
        if "[$83bd" in line or "[$9db1" in line or "[$d804" in line:
            line = "\tPUSH_SR\n"+line
            lines[i+1] = lines[i+1]+"\tPOP_SR\n"
            lines[i+3] = ""


        elif "[$83cc" in line:
            line = change_instruction("subq.b\t#0x01,(a0)",line)
            lines[i-1] = ""
            lines[i+1] = remove_instruction(lines[i+1])
            lines[i+2] = ""
            lines[i+4] = ""

        elif "[$6600" in line:
            line = "irq_6600:\n"+line
        elif "[$f000" in line:
            line = "reset_f000:\n"+line
        elif "unsupported instruction rti" in line:
            line = change_instruction("rts",line)
        elif "unsupported instruction lds" in line:
            line = remove_instruction(line)
        elif "unsupported instruction andcc" in line:
            line = change_instruction("CLR_XC_FLAGS",line)
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

with open("../src/track_and_field.68k","w") as fw:
    fw.write("""\t.global\tirq_6600
\t.global\treset_f000
""")
    fw.writelines(lines)