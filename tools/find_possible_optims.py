import re
src = "../src/track_and_field.68k"
nb = 0
prev_loaded = None
with open(src) as f:
    lines = list(f)

def remcomments(line):
    return re.sub("[\|\*].*","",line)

for i,line in enumerate(lines):
    line = remcomments(line)  # remove comments
    toks = line.split()
    if "GET_ADDRESS" in toks or "GET_UNCHECKED_ADDRESS" in toks:
        value = toks[1]
        if prev_loaded == value and i-prev_line < 6:
            print(f"Prev loaded: {prev_loaded} line {i+1} loaded at line {prev_line+1}")
            nb += 1
        prev_line = i
        prev_loaded = value
    if any(x in toks for x in ["rts","jmp","jra","jbsr","GET_REG_ADDRESS"]):
        prev_loaded = None
    if re.match("\w+:",line):
        prev_loaded = None


if nb:
    print(f"found {nb} GET_ADDRESS useless occs")
else:
    print("Nothing found")