import math
import os
import bpy
C = bpy.context
D = bpy.data
import sys
import argparse
import json

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

parser.add_argument("-c", "--config", help="Configuration file")


args = parser.parse_known_args(sys.argv[sys.argv.index("--")+1:])[0]
config_file = args.config
config_folder = os.path.dirname(os.path.abspath(config_file))
config_name = os.path.basename(config_file).split('.')[0]
config = json.load(open(config_file))

print("Konfigurační soubor", config_file)
print("Cela cesta:", config_folder)
print("Nazev konfigurace", config_name)



def import_and_rename(stl, name = None):
    print("Importing file '{}' with name '{}'.".format(stl, name))
    bpy.ops.import_mesh.stl(filepath=stl)
    if name:
        bpy.context.selected_objects[0].data.name = name
        bpy.context.selected_objects[0].name = name
    return bpy.context.selected_objects[0].name

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

# import_and_rename("stl/buildmanual_0001_b.stl", '0001_b')
# set_material('0001_b', "basic_dark_gray")


# Projit vsechny modely v konfiguraci
for part_k in config.get('parts', {}):
	part = config['parts'][part_k]
	part['name'] = part_k

	if 'stl' in part:
		pass
		#TODO: check if file is exists and is valid
		part['stl'] = os.path.abspath(part['stl'])

	else:
		pass
		#TODO: try to guest filename

	# Load model
	import_and_rename(part['stl'], part['name'])

	#TODO do model transformations

	# Set model material
	set_material(part["name"], part.get('material', "basic_light_gray"))

if "camera" in config:
	bpy.data.objects['Camera'].location = config['camera']['translation'] # [615, -460, 350]
	bpy.data.objects['Camera'].rotation_euler = [math.radians(config['camera']['rotation'][0]), math.radians(config['camera']['rotation'][1]), math.radians(config['camera']['rotation'][2])] #[1.1, 0, 0.81]

if config['render']['type'] == 'png':

	if not 'folder' in config['render']:
		config['render']['folder'] = config_folder

	if not 'filename' in config['render']:
		config['render']['filename'] = config_name+'.png'

	render_file = os.path.abspath(os.path.join(config['render']['folder'], config['render']["filename"]))
	render_png(render_file)

if config.get('save_blend', False):
	save_blender_file(os.path.abspath(config_file.split('.')[0]+'.blend'))
