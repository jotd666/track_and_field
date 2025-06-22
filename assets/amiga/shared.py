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



    return rval,groups

alphanum_tile_codes = set(range(0,10)) | set(range(65-48,65+26-48))

if __name__ == "__main__":
    raise Exception("no main!")