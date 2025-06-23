import bitplanelib
import os,pathlib


this_dir = pathlib.Path(os.path.abspath(__file__)).parent
src_dir = this_dir / os.pardir / "src" / "amiga"

# http://amiga-dev.wikidot.com/hardware:bplcon1


# table with fine shift + byte offset
def doit(width):
    asm_output = src_dir / f"scroll_table_{width}.68k"
    wmask = width-1
    scroll_table = [0]*512

    if width == 64:
        # bob playfield gets 0-shift value
        other_plane_mask_1 = 0x0C
    else:
        other_plane_mask_1 = 0x04       # not sure!
    other_plane_mask_2 = 0x0F

    items = []
    for x in range(0,512):
        shift = (wmask-(x & wmask))
        offset = (x // width)*(width//8)
        # pre-encode shift for bplcon

        shiftval_msb = ((shift&(wmask & 0x30))>>2)      # 2 high bits H7 H6
        items.append((shiftval_msb<<4)|other_plane_mask_1) # put same shift for background playfield
        shiftval_lsb = (shift&0xF)                      # 4 low bits H5->H2
        items.append((shiftval_lsb<<4)|other_plane_mask_2) # put same shift for background playfield

        items.append(0)
        items.append(offset)

    if asm_output:
        with open(asm_output,"w") as f:
            bitplanelib.dump_asm_bytes(bytes(items),f,True)
    return items

if __name__ == "__main__":
    doit(width = 64)   # FMODE=3
