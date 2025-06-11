with open("rom.bin","rb") as f:
    contents = f.read()

size = 0x100
address = 0XEE0A
offset = 0x6000

block = contents[address-offset:address-offset+size]

print(f"table_{address:04x}:")
for i in range(0,len(block),2):
    a = block[i]*256 + block[i+1]
    if 0x6000 > a:
        break
    print(f"\tdc.w\t${a:04x}\t; ${address:04x}")
    address += 2
