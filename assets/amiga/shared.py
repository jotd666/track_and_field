from PIL import Image,ImageOps
import os,sys,bitplanelib,subprocess,json,pathlib

this_dir = pathlib.Path(__file__).absolute().parent

data_dir = this_dir / ".." / ".."
src_dir = this_dir / ".." / ".." / "src" / "amiga"

sheets_path = this_dir / ".." / "sheets"
dump_dir = this_dir / "dumps"

used_sprite_cluts_file = this_dir / "used_sprite_cluts.json"
used_tile_cluts_file = this_dir / "used_tile_cluts.json"
used_graphics_dir = this_dir / "used_graphics"

def palette_pad(palette,pad_nb):
    palette += (pad_nb-len(palette)) * [(0x10,0x20,0x30)]

def ensure_empty(d):
    if os.path.exists(d):
        for f in os.listdir(d):
            x = os.path.join(d,f)
            if os.path.isfile(x):
                os.remove(x)
    else:
        os.makedirs(d)

def ensure_exists(d):
    if os.path.exists(d):
        pass
    else:
        os.makedirs(d)

sr2 = lambda a,b : set(range(a,b,2))

group_sprite_pairs = (sr2(0,0x34) | sr2(0x40,0x52) |
sr2(0x54,0x60) | sr2(0x62,0x68) | sr2(0x88,0x90) |
sr2(0x92,0xA2) | {0xA4,0xA8,0xB0,0xB8,0xBC} | sr2(0xC0,0xCE) |
sr2(0xD2,0xDE)
)

def get_sprite_names():
    rval = {}


    return rval,group_sprite_pairs

alphanum_tile_codes = set(range(0,10)) | set(range(65-48,65+27-48))

if __name__ == "__main__":
    raise Exception("no main!")