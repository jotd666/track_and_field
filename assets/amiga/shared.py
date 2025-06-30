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

player_sprite_pairs = (sr2(0,0x34) | sr2(0x40,0x48) |sr2(0x4A,0x52) |
sr2(0x54,0x60) |  sr2(0x88,0x90) |
sr2(0x92,0xA2) | {0xA4,0xA8,0xBC,0xAC,0xB4,0xDA,0xDC,0xDE} | sr2(0xC0,0xC6) |
sr2(0xD2,0xD8) | sr2(0xC8,0xCE)
)
group_sprite_pairs = player_sprite_pairs | {0xB0,0xB8} | sr2(0x62,0x68)

def get_sprite_names():

    rval = {k:"player" for k in player_sprite_pairs | set(range(0x7A,0x80))
    | {0x53,0x81,0x87,0xCE,0xCF,0xD0,0xD1,0x85,0x91,0xD8,0xD9} | set(range(0x70,0x7A))}
    rval[0xFC] = "bonus_spaceship"
    rval[0x3D] = "cursor"
    rval[0x80] = "gunshot"
    rval[0xA7] = "bar"
    rval[0xB0] = rval[0xB8] = "up_arrow"
    rval |= {k:"bystanders" for k in {0xDE,0xF4,0xF5}}
    #rval |= {k:"" for k in {0xDE,0xF4,0xF5}}
    rval |= {k:"referee" for k in sr2(0x62,0x68) | {0x68,0x69,0x6A,0x6B,0x6C,0x6D,
    0x82,0x83,0x84,0x86}}
    rval |= {k:"javelin" for k in range(0xE0,0xF1)}
    rval |= {k:"hammer" for k in sr2(0x34,0x3E)}
    return rval

def get_mirror_sprites():
    """ return the index of the sprites that need mirroring
as opposed to Gyruss, most of the sprites don't

"""
    rval = {k for k,v in get_sprite_names().items() if "hammer" in v}
    rval.update(range(0xCE,0xDD))
    rval.update({0xC6,0xC7})
    return rval

alphanum_tile_codes = set(range(0,10)) | set(range(65-48,65+27-48))

if __name__ == "__main__":
    raise Exception("no main!")