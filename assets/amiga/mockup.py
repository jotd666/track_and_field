from PIL import Image,ImageOps
import os,pathlib,struct

from shared import *


sprite_names,_ = get_sprite_names()



def raw_to_code(raw):
    lsb = raw & 0xFF
    msb = raw >> 8


    base = ((lsb & 0x20) << 2) + (msb >> 1)
    if msb & 1:
        base += 0x100
    return base


def load_tileset(image_name,width,height,set_subdir,dump_prefix=""):
    full_image_path = sheets_path / "sprites" / set_subdir / image_name
    tiles_1 = Image.open(full_image_path)
    nb_rows = tiles_1.size[1] // height
    nb_cols = tiles_1.size[0] // width

    if dump_prefix:
        dumpdir = pathlib.Path("dumps")
        dumpdir.mkdir(exist_ok=True)

    tileset_1 = []
    k=0
    for j in range(nb_rows):
        for i in range(nb_cols):
            img = Image.new("RGB",(width,height))
            img.paste(tiles_1,(-i*width,-j*height))
            tileset_1.append(img)
            if dump_prefix:
                img = ImageOps.scale(img,5,resample=Image.Resampling.NEAREST)
                img.save(os.path.join(dumpdir,f"{dump_prefix}_{k:02x}.png"))
            k += 1

    return tileset_1

def loadtiles(i,set_name):
    return load_tileset(f"pal_{i:02x}.png",16,8,set_name)

tile_sets_0 = [loadtiles(i,"set_0") for i in range(16)]
tile_sets_1 = [loadtiles(i,"set_1") for i in range(16)]
tile_set = [tile_sets_0,tile_sets_1]

def process(the_dump,offset=0,base_address=0,name_filter=None,hide_named_sprite=None):
    the_dump = pathlib.Path(the_dump)
    # in input, we use a MAME memory dump: save sprites,$A000,$400
    # (0x200 are read, but there's a kind of double buffering
    with open(the_dump,"rb") as f:
        f.read(offset)
        m_spriteram = bytearray(f.read(0x200))


    result = Image.new("RGB",(256,256))

    print("*"*50)
    nb_active = 0
    nb_stars = 0


    for offs in range(len(m_spriteram)-4,-4,-4):
        raw_code_and_clut = (m_spriteram[offs+1]<<8)+m_spriteram[offs+2]
        x = m_spriteram[offs]
        y = 241 - m_spriteram[offs + 3]
        y = 256 -y # adding this to MAME formula else pic is not correct

        if x:
            gfx_bank = m_spriteram[offs + 1] & 0x01
            code = ((m_spriteram[offs + 2] & 0x20) << 2) | (m_spriteram[offs + 1] >> 1)
            if code:
                if code == 0x13:
                    nb_stars += 1
                color = m_spriteram[offs + 2] & 0x0f
                flip_x = bool(~m_spriteram[offs + 2] & 0x40)
                flip_y = bool(m_spriteram[offs + 2] & 0x80)
                nb_active += 1


                address = base_address+offs
                fcode = gfx_bank*0x100+code
                name = sprite_names.get(fcode,"unknown")
                if not name_filter or name_filter in name:
                    print(f"addr=${address:04x}, offset=${offs:04x}, raw:=${raw_code_and_clut:04X} X={y}, Y={x}, flipx={flip_x}, flip_y={flip_y}, code={fcode:04x}, color={color:02x}, name={name}")

                bank = tile_set[gfx_bank]
                im = bank[color][code]

                if flip_x:
                    im = ImageOps.flip(im)
                if flip_y:
                    im = ImageOps.mirror(im)

    ##
    ##            for x in range(img.size[0]):
    ##                for y in range(img.size[1]):
    ##                    if img.getpixel((x,y)) == (0,0,0,255):
    ##                        img.putpixel((x,y),(255,0,0,0))
                # paste would require masking, well, never mind
                if hide_named_sprite and hide_named_sprite in name:
                    pass
                else:
                    result.paste(im,(y,x))

    print(f"NB ACTIVE: {nb_active}, NB_STARS: {nb_stars}")
    result.save(f"{the_dump.stem}_{offset:04x}.png")



process(r"sprite_ram_4040",offset=0,base_address=0x4040,hide_named_sprite="star")
#process(r"sprites_4040",offset=0,base_address=0xA000,name_filter="swarm")
#process(r"sprites_A200",offset=0,base_address=0xA000)
#process(r"sattelites_A000",offset=0,base_address=0xA000)
#process(r"bug_4040",offset=0,base_address=0x4040)
#process(r"../../sprite_ram_4040",offset=0,base_address=0x4040)
#process(r"../../sprite_ram_A000",offset=0,base_address=0xA000)
#process(r"../../sprite_ram_A200",offset=0,base_address=0xA200)
#process(r"gysub_6000",offset=0x0)
#process(r"gysub_after_6000_amiga",offset=0)
#process(r"gysub_after_6000",offset=0x200)
