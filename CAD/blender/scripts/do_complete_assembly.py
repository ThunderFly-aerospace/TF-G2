import math
import os
import bpy
C = bpy.context
D = bpy.data
import sys
import argparse
import json
import glob

print("######################")
print("######################")
print("##")
print("##")
print("##    Generovani SCAD modelu")  
print("##")
print("##")
print("######################")
print("######################")


## Nacteni konfiguraci a konfiguracnich souboru
parser = argparse.ArgumentParser()

# parser.add_argument("-c", "--config", help="Configuration file")
parser.add_argument("-s", "--source", help="source_folder", default="../../src/assembly/position")


args = parser.parse_known_args(sys.argv[sys.argv.index("--")+1:])[0]

#config_file = args.config
#config_folder = os.path.dirname(os.path.abspath(config_file))
#config_name = os.path.basename(config_file).split('.')[0]
#config = json.load(open(config_file))

#print("Konfigurační soubor", config_file)
#print("Cela cesta:", config_folder)
#print("Nazev konfigurace", config_name)


source_folder = args.source
print("Slozka s scad soubory", source_folder)


def deselect():
    for ob in bpy.context.selected_objects:
        bpy.data.objects[ob.name].select_set(False)
        #ob.select_set(False)

def import_and_rename(stl, name = None, merge = True):
    print("Importing file '{}' with name '{}'.".format(stl, name))
    bpy.context.selected_objects.clear()
    bpy.ops.import_mesh.stl(filepath=stl)
    import_name = bpy.context.selected_objects[0].name
    #if not name: name = import_name
    if merge and name in bpy.data.objects:
        print("Chci mergerovat a stary model je nalezen", name, import_name)
        
        
        # Get properties from original object
        material = bpy.data.objects[name].data.materials

        # Replace original mesh from file
        deselect()
        bpy.data.objects[name].select_set(True)
        bpy.data.objects[import_name].select_set(True)
        bpy.ops.object.make_links_data(type='OBDATA')
        deselect()

        # Restore material from original object
        for mat in material:
            bpy.data.objects[name].data.materials.append(mat)

        # Remove tmp object
        objs = bpy.data.objects
        objs.remove(objs[import_name], do_unlink=True)

    else:
        bpy.context.selected_objects[0].data.name = name
        bpy.context.selected_objects[0].name = name
    return name

def set_material(object_name, material = "basic_light_gray"):
	# TODO: check if material exists. 
    print("Setting '{}' material for '{}' object".format(material, object_name))
    mat = bpy.data.materials[material]
    bpy.data.objects[object_name].data.materials.clear()
    bpy.data.objects[object_name].data.materials.append(mat)

def save_blender_file(filename):
	bpy.ops.wm.save_as_mainfile(filepath=filename)

def render_png(filename, frame = 0):
	print("Rendering file")
	bpy.context.scene.render.filepath = filename
	bpy.ops.render.render(write_still=True)
	print("Saving render")


def set_position(object, rotation, translation):
	pass

def set_camera_position(rotation, translation):
	pass




# import_and_rename("stl/buildmanual_0001_a.stl", '0001_a')
# set_material('0001_a')

source_files = "../stl/position*.stl"
for file in glob.glob(source_files):
    print(file)
    filename = os.path.basename(file)
    print(filename)
    import_and_rename(file, filename)


save_blender_file("TF-G2_automatic.blend")
#if config.get('save_blend', False):
#save_blender_file(os.path.abspath(config_file.split('.')[0]+'.blend'))
