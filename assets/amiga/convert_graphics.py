from PIL import Image,ImageOps
import os,sys,bitplanelib

from shared import *


sprite_names,grouped_sprites = get_sprite_names()

NB_SPRITES = 0x200
NB_TILES = 0x200

dump_it = True

if dump_it:
    if not os.path.exists(dump_dir):
        os.mkdir(dump_dir)
        with open(os.path.join(dump_dir,".gitignore"),"w") as f:
            f.write("*")


def dump_asm_bytes(*args,**kwargs):
    bitplanelib.dump_asm_bytes(*args,**kwargs,mit_format=True)


def ensure_empty(d):
    if os.path.exists(d):
        for f in os.listdir(d):
            os.remove(os.path.join(d,f))
    else:
        os.makedirs(d)

def load_tileset(image_name,palette_index,width,height,tileset_name,dumpdir,
dump=False,name_dict=None,cluts=None,tile_number=0):

##    if isinstance(image_name,str):
##        full_image_path = os.path.join(this_dir,os.path.pardir,"sheets",
##                            tile_type,image_name)
##        tiles_1 = Image.open(full_image_path)
##    else:
    tiles_1 = image_name
    nb_rows = tiles_1.size[1] // height
    nb_cols = tiles_1.size[0] // width


    tileset_1 = []

    if dump:
        dump_subdir = os.path.join(dumpdir,tileset_name)
        if palette_index == 0 and tile_number == 0:
            ensure_empty(dump_subdir)

    palette = set()

    for j in range(nb_rows):
        for i in range(nb_cols):

            if cluts and (tile_number not in cluts or palette_index not in cluts[tile_number]):
                # no clut declared for that tile
                tileset_1.append(None)
            else:

                img = Image.new("RGB",(width,height))
                img.paste(tiles_1,(-i*width,-j*height))

                # only consider colors of used tiles
                palette.update(set(bitplanelib.palette_extract(img)))


                tileset_1.append(img)

                if dump:
                    img = ImageOps.scale(img,5,resample=Image.Resampling.NEAREST)
                    if name_dict:
                        name = name_dict.get(tile_number,"unknown")
                    else:
                        name = "unknown"

                    img.save(os.path.join(dump_subdir,f"{name}_{tile_number:02x}_{palette_index:02x}.png"))

            tile_number += 1

    return sorted(set(palette)),tileset_1

all_tile_cluts = False

sprite_cluts = [[] for _ in range(NB_SPRITES)]
##hw_sprite_cluts = [[] for _ in range(64)]
nb_planes = 5

nb_colors = 1<<nb_planes





def add_tile(table,index,cluts=[0]):
    if isinstance(index,range):
        pass
    elif not isinstance(index,(list,tuple)):
        index = [index]
    for idx in index:
        table[idx] = cluts

sprite_cluts = {}
tile_cluts = {}

with open(used_graphics_dir / "used_sprites","rb") as f:
    for index in range(NB_SPRITES):
        d = f.read(16)
        cluts = [i for i,c in enumerate(d) if c]
        if cluts:
            add_tile(sprite_cluts,index,cluts=cluts)

# force all cluts for some sprites (ship explosion where colors
# keep up changing. Logging is not really efficient as sometimes
# game misses some colors and there are a lot of angles)
all_cluts = range(16)
for idx in range(0x1,0x13):
    add_tile(sprite_cluts,idx,all_cluts)
    add_tile(sprite_cluts,idx+0x100,all_cluts)

if all_tile_cluts:
    tile_cluts = None
else:
    with open(used_graphics_dir / "used_tiles","rb") as f:
        for index in range(NB_TILES):
            d = f.read(16)
            cluts = [i for i,c in enumerate(d) if c]
            if cluts:
                add_tile(tile_cluts,index,cluts=cluts)

    # now gather all cluts used by letter/digit tiles, logging probably
    # missed some
    used_cluts = set()
    for atc in alphanum_tile_codes:
        cluts = tile_cluts.get(atc)
        if cluts:
            used_cluts.update(cluts)
    # now set cluts for all alphanum tiles
    for atc in alphanum_tile_codes:
        tile_cluts[atc] = sorted(used_cluts)



if dump_it:
    with open(dump_dir / "used_sprites.json","w") as f:
        sprite_cluts_dict = {hex(k):[hex(x) for x in v] for k,v in sprite_cluts.items() if v}
        json.dump(sprite_cluts_dict,f,indent=2)
    if not all_tile_cluts:
        with open(dump_dir / "used_tiles.json","w") as f:
            tile_cluts_dict = {hex(k):[hex(x) for x in v] for k,v in tile_cluts.items() if v}
            json.dump(tile_cluts_dict,f,indent=2)

def add_hw_sprite(index,name,cluts=[0]):
    if isinstance(index,range):
        pass
    elif not isinstance(index,(list,tuple)):
        index = [index]
    for idx in index:
        sprite_names[idx] = name
        hw_sprite_cluts[idx] = cluts


sprite_sheet_dicts = [{i:Image.open(sheets_path / "sprites" / f"set_{z}" / f"pal_{i:02x}.png") for i in range(16)} for z in (0,1)]
tile_sheet_dict = {i:Image.open(sheets_path / "tiles" / f"pal_{i:02x}.png") for i in range(16)}

tile_palette = set()
tile_set_list = []

for i,tsd in tile_sheet_dict.items():
    tp,tile_set = load_tileset(tsd,i,8,8,"tiles",dump_dir,dump=dump_it,
    cluts=tile_cluts,
    name_dict=None)
    tile_set_list.append(tile_set)
    tile_palette.update(tp)

sprite_palette = set()
sprite_set_list = [[] for _ in range(16)]
hw_sprite_set_list = []

for j,sprite_sheet_dict in enumerate(sprite_sheet_dicts):
    for clut_index,tsd in sprite_sheet_dict.items():
        # BOBs
        cluts = sprite_cluts
        sp,sprite_set = load_tileset(tsd,clut_index,16,8,"sprites",dump_dir,dump=False,
        name_dict=sprite_names,cluts=sprite_cluts,
        tile_number=j*0x100)
        sprite_set_list[clut_index] += sprite_set
        sprite_palette.update(sp)

sprite_dump_dir = dump_dir / "sprites"
for sd in ["16x8","16x16"]:
    for p in (sprite_dump_dir / sd).glob("*"):
        p.unlink()
    (sprite_dump_dir / sd).mkdir(exist_ok=True)

for palette_index,sprite_set in enumerate(sprite_set_list):
    # rework tiles which are grouped now that 2x256 list is composed
    for tile_number,wtile in enumerate(sprite_set):
        if wtile and tile_number < 0x100 and tile_number in grouped_sprites:
            # change wtile, fetch code +0x100
            other_tile_index = (tile_number+0x100)
            other_tile = sprite_set[other_tile_index]
            new_tile = Image.new("RGB",(wtile.size[0],wtile.size[1]*2))
            new_tile.paste(wtile)
            new_tile.paste(other_tile,(0,wtile.size[1]))
            sprite_set[tile_number] = new_tile
            sprite_set[tile_number+0x100] = None  # no need
            wtile = new_tile
        if dump_it and wtile:
            img = ImageOps.scale(wtile,5,resample=Image.Resampling.NEAREST)
            if sprite_names:
                name = sprite_names.get(tile_number,"unknown")
            else:
                name = "unknown"

            img.save(sprite_dump_dir / f"16x{wtile.size[1]}" / f"{name}_{tile_number:02x}_{palette_index:02x}.png")


# extract star colors (we now where the non-black pixel of the star is
star_sprite = 0x13
star_colors = [sprite_set_list[clut][star_sprite].getpixel((8,3)) for clut  in [4,5,6,7,8]]

# sprite_set_list is now a 16x512 matrix of sprite tiles

    # Hardware sprites
##    cluts = hw_sprite_cluts
##    _,hw_sprite_set = load_tileset(tsd,i,16,"hw_sprites",dump_dir,dump=dump_it,name_dict=sprite_names,cluts=cluts)
##    hw_sprite_set_list.append(hw_sprite_set)


# add sprite palette first. As it's 16 colors, we can use only 4 blits per sprite
# which saves blitter bandwidth, plus the 17th color first on the 5th plane
full_palette = [None]*17

for i,sc in enumerate(star_colors):
    full_palette[1<<i] = sc
    sprite_palette.discard(sc)
# now put the remaining colors
idx=0
for s in sorted(sprite_palette):
    while full_palette[idx]:
        idx+=1
    full_palette[idx] = s

# copy one color so all 16 colors are still 0-15. Game uses 28 colors max so we can afford
# to duplicate colors
full_palette[-2] = full_palette[-1]


# now we swap positions for star colors. We need them to be in special positions
# so setting just 1 bit on 1 plane activates the proper color

full_palette_colors = set(full_palette)
for c in sorted(tile_palette):
    if c not in full_palette_colors:
        full_palette.append(c)
        full_palette_colors.add(c)


#full_palette_rgb4 = {(x>>4,y>>4,z>>4) for x,y,z in full_palette}
#actually_used_colors_rgb4 = {(x>>4,y>>4,z>>4) for x,y,z in actually_used_colors}
#unused_colors = full_palette_rgb4 - actually_used_colors_rgb4
#print([(hex(x<<4),hex(y<<4),hex(z<<4)) for x,y,z in unused_colors])

# pad just in case we don't have 16 colors (but we have)
full_palette += (nb_colors-len(full_palette)) * [(0x10,0x20,0x30)]



plane_orientations = [("standard",lambda x:x),
("flip",ImageOps.flip),
("mirror",ImageOps.mirror),
("flip_mirror",lambda x:ImageOps.flip(ImageOps.mirror(x)))]

def read_tileset(img_set_list,palette,plane_orientation_flags,cache,is_bob):
    next_cache_id = 1
    tile_table = []
    for n,img_set in enumerate(img_set_list):
        tile_entry = []
        for i,tile in enumerate(img_set):
            entry = dict()
            if tile:

                for b,(plane_name,plane_func) in zip(plane_orientation_flags,plane_orientations):
                    if b:

                        actual_nb_planes = nb_planes
                        wtile = plane_func(tile)

                        if is_bob:
##                            if i in grouped_sprites:
##                                # change wtile, fetch code +0x100
##                                other_tile_index = (i+0x100)%0x200
##                                other_tile = img_set[other_tile_index]
##                                new_tile = Image.new("RGB",(wtile.size[0],wtile.size[1]*2))
##                                new_tile.paste(wtile)
##                                new_tile.paste(other_tile,(0,wtile.size[1]))
##                                wtile = new_tile
##                                print(hex(i))
                            # only 4 planes + mask => 5 planes
                            y_start,wtile = bitplanelib.autocrop_y(wtile)
                            height = wtile.size[1]
                            bitplane_data = bitplanelib.palette_image2raw(wtile,None,palette,generate_mask=True,blit_pad=True)
                        else:
                            # 5 planes, no mask
                            height = 8
                            y_start = 0
                            bitplane_data = bitplanelib.palette_image2raw(wtile,None,palette)

                        plane_size = len(bitplane_data) // actual_nb_planes
                        bitplane_plane_ids = []
                        for j in range(actual_nb_planes):
                            offset = j*plane_size
                            bitplane = bitplane_data[offset:offset+plane_size]

                            cache_id = cache.get(bitplane)
                            if cache_id is not None:
                                bitplane_plane_ids.append(cache_id)
                            else:
                                if any(bitplane):
                                    cache[bitplane] = next_cache_id
                                    bitplane_plane_ids.append(next_cache_id)
                                    next_cache_id += 1
                                else:
                                    bitplane_plane_ids.append(0)  # blank
                        entry[plane_name] = {"height":height,"y_start":y_start,"bitplanes":bitplane_plane_ids}

            tile_entry.append(entry)

        tile_table.append(tile_entry)

    new_tile_table = [[[] for _ in range(16)] for _ in range(len(tile_table[0]))]

    # reorder/transpose. We have 16 * 256 we need 256 * 16
    for i,u in enumerate(tile_table):
        for j,v in enumerate(u):
            new_tile_table[j][i] = v

    return new_tile_table

tile_plane_cache = {}
tile_table = read_tileset(tile_set_list,full_palette,[True,False,False,False],cache=tile_plane_cache, is_bob=False)

bob_plane_cache = {}
sprite_table = read_tileset(sprite_set_list,full_palette[:16],[True,False,True,False],cache=bob_plane_cache, is_bob=True)

with open(os.path.join(src_dir,"palette.68k"),"w") as f:
    bitplanelib.palette_dump(full_palette,f,bitplanelib.PALETTE_FORMAT_ASMGNU)

gs_array = [0]*0x200
for i in grouped_sprites:
    gs_array[i] = gs_array[i+0x100] = 1
with open(os.path.join(src_dir,"sprite_groups.68k"),"w") as f:
    bitplanelib.dump_asm_bytes(gs_array,f,mit_format=True)

grouped_sprites
with open(os.path.join(src_dir,"graphics.68k"),"w") as f:
    f.write("\t.global\tcharacter_table\n")
    f.write("\t.global\tbob_table\n")

    f.write("character_table:\n")

    for i,tile_entry in enumerate(tile_table):
        f.write("\t.long\t")
        if tile_entry and any(tile_entry):
            f.write(f"tile_{i:02x}")
        else:
            f.write("0")
        f.write("\n")

    for i,tile_entry in enumerate(tile_table):
        if tile_entry and any(tile_entry):
            f.write(f"tile_{i:02x}:\n")
            for j,t in enumerate(tile_entry):
                f.write("\t.long\t")
                if t:
                    f.write(f"tile_{i:02x}_{j:02x}")
                else:
                    f.write("0")
                f.write("\n")


    for i,tile_entry in enumerate(tile_table):
        if tile_entry and any(tile_entry):
            for j,t in enumerate(tile_entry):
                if t:
                    name = f"tile_{i:02x}_{j:02x}"

                    f.write(f"{name}:\n")
                    for orientation,_ in plane_orientations:
                        f.write("* {}\n".format(orientation))
                        if orientation in t:
                            data = t[orientation]
                            for bitplane_id in data["bitplanes"]:
                                f.write("\t.long\t")
                                if bitplane_id:
                                    f.write(f"tile_plane_{bitplane_id:02d}")
                                else:
                                    f.write("0")
                                f.write("\n")
                            if len(t)==1:
                                # optim: only standard
                                break
                        else:
                            for _ in range(nb_planes):
                                f.write("\t.long\t0\n")



    for k,v in tile_plane_cache.items():
        f.write(f"tile_plane_{v:02d}:")
        dump_asm_bytes(k,f)

    f.write("bob_table:\n")
    for i,tile_entry in enumerate(sprite_table):
        f.write("\t.long\t")
        if tile_entry:
            prefix = sprite_names.get(i,"bob")
            f.write(f"{prefix}_{i:02x}")
        else:
            f.write("0")
        f.write("\n")

    for i,tile_entry in enumerate(sprite_table):
        if tile_entry:
            prefix = sprite_names.get(i,"bob")
            f.write(f"{prefix}_{i:02x}:\n")
            for j,t in enumerate(tile_entry):
                f.write("\t.long\t")
                if t:
                    f.write(f"{prefix}_{i:02x}_{j:02x}")
                else:
                    f.write("0")
                f.write("\n")


    for i,tile_entry in enumerate(sprite_table):
        if tile_entry:
            prefix = sprite_names.get(i,"bob")
            for j,t in enumerate(tile_entry):
                if t:
                    name = f"{prefix}_{i:02x}_{j:02x}"

                    f.write(f"{name}:\n")
                    height = 0
                    width = 4
                    offset = 0
                    for orientation,_ in plane_orientations:
                        if orientation in t:
                            height = t[orientation]["height"]
                            offset = t[orientation]["y_start"]
                            break
                    else:
                        raise Exception(f"height not found for {name}!!")
                    for orientation,_ in plane_orientations:
                        if orientation in t:
                            f.write("* {}\n".format(orientation))
                            active_planes = 0
                            bitplanes = t[orientation]["bitplanes"]

                            for j,bitplane_id in enumerate(bitplanes):
                                if bitplane_id:
                                    active_planes |= 1<<j

                            f.write(f"\t.word\t{height},{width},{offset},0x{active_planes:x}\n")
                            for bitplane_id in bitplanes:
                                f.write("\t.long\t")
                                if bitplane_id:
                                    f.write(f"bob_plane_{bitplane_id:02d}")
                                else:
                                    f.write("0")
                                f.write("\n")
                            if len(t)==1:
                                # optim: only standard
                                break

    f.write("\t.section\t.datachip\n")

    for k,v in bob_plane_cache.items():
        f.write(f"bob_plane_{v:02d}:")
        dump_asm_bytes(k,f)

