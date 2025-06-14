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

def get_sprite_names():
    rval = {}
    groups = set()
    def add_range(a,b,name):
        for i in range(a,b):
            rval[i] = name
    def add_dual_range(a,b,name,group=False):

        for i in range(a,b):
            rval[i] = name
            rval[i+0x100] = name
        if group:
            groups.update(range(a,b))

    def add(i,name):
            rval[i] = name

    # giving names to the sprites is cosmetic
    # what is NOT cosmetic is the grouping which makes 2 16x8 sprites
    # a single 16x16 sprite, which is much more efficient to blit
    add_dual_range(0x39,0x40,"furthest_swarm_enemy")
    add_dual_range(1,0x13,"player_ship",group=True)
    add_range(0x1C0,0x1C6,"player_ship")
    add_dual_range(0x90,0x99,"player_ship",group=True)
    add_dual_range(0xC6,0xd4,"player_ship",group=True)
    add_dual_range(0xD0,0xD3,"player_ship")
    add_dual_range(0x34,0x36,"iceberg")
    add_dual_range(0x36,0x39,"iceberg",group=True)
    add_dual_range(0x88,0x90,"death_ray")
    add_dual_range(0x81,0x88,"ray_emitter")
    add_dual_range(0x78,0x7A,"neptune",group=True)
    add(0x13,"star")
    add(0x2d,"exploding_particle")
    add_dual_range(0xD4,0xDD,"earth")
    add_dual_range(0x2F,0x32,"big_explosion",group=True)
    add_dual_range(0x32,0x34,"explosion")
    add_dual_range(0xa0,0xbf,"enemy_ship",group=True)
    add_dual_range(0x4b,0x55,"side_satellite",group=True)
    add_dual_range(0xbc,0xc0,"bonus_satellite",group=True)
    add_dual_range(0xde,0xef,"enemy_ship",group=True)
    add_dual_range(0x61,0x77,"enemy_ship",group=True)
    add_dual_range(0x55,0x5F,"chance_ship",group=True)
    add_dual_range(0x23,0x2A,"chance_ship",group=True)
    add_dual_range(0x18,0x1f,"player_laser")
    add_dual_range(0x1f,0x23,"enemy_bomb")
    add_dual_range(0x7A,0x7B,"neptune")

    add_dual_range(0x65,0x66,"enemy_ship",group=True)
    add_dual_range(0x9A,0xA0,"enemy_ship",group=True)
    add_dual_range(0xEF,0x100,"enemy_ship",group=True)
    add_dual_range(0x15,0x18,"score")



    return rval,groups

# codes representing letters. No logic, duplicate letters, ... horrible
alphanum_tile_codes = {1,3,0xB,0xD,0xF,0x17,0x1A,0x1C,0x25,0x29,0x2A,0x2C,0x30,
0x34,0x37,0x39,0x3A,0x40,0x41,0x47,0x48,0x50,0x51,0x5B,0x5D,0x60,0x65,0x6A,0x6D,0x6E,0x73,
0x76,0x7E,0x7F,
0x87,0x88,0x8B,0x8F,
0x92,0x93,0x9D,0xA5,0xA7,0xAE,0xB0,0xB1,0xB2,0xB4,0xB5,0xB9,0xBF,0xC0,0xC1,0xC2,0xC3,0xC4,0xC6,
0xD7,0xDC,0xDF,0xE0,0xE4,0xE5,0xE7,0xE8,0xE9,0xEE,0xF1,0xF5,0xFA,0xFC,0xFF}
alphanum_tile_codes.update({x+0x100 for x in {9,0xE,0x1A,0x1F,0x22,0x27,0X38,
0x43,0x47,0x48,0x49,0x4B,
0x55,0x68,0x74,0x77,0x7A,0x7F,0x88,0x8B,0x99,0x9A,0xA9,0xB5,0xB7,0xB9,0xC2,
0xD4,0xD9,0xDA,0xDB,0xE9,0xEF,0xFB,0xFD
}})

if __name__ == "__main__":
    raise Exception("no main!")