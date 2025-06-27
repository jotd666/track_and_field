import os,re

this_dir = os.path.dirname(os.path.abspath(__file__))

jere = re.compile(r"\s+\.long\s+l_(\w\w\w\w)\b",flags=re.I)
jekre = re.compile(r"\s+\.long\s+(\w+)",flags=re.I)

with open(os.path.join(this_dir,"..","src","track_and_field.68k")) as f:
    lines = list(f)

result = set()

for line in lines:
    m = jere.match(line)
    if m:
        result.add(int(m.group(1),0x10))
    else:
        m = jekre.match(line)
        if m:
            print("Known: {}".format(m.group(1)))
with open(r"K:\Emulation\MAME\bkpts","w") as f:
    f.write("bpclear\n")
    for r in sorted(result):
        f.write(f"bpset ${r:04x}\n")

print(len(result))