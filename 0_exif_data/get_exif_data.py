# import piexif
import exifread
import gpsphoto
import os
import pprint
import json
import PIL
from PIL import Image
from ast import literal_eval

cwd = os.getcwd() #get current path as string

images_data = []

images_directory = os.path.join(cwd, '../images') #os.path.join allows this to work on windows as well for \

def resizeImg(image_path, filename, orientation):
	basewidth = 800
	img = Image.open(image_path)
	wpercent = (basewidth/float(img.size[0]))
	hsize = int((float(img.size[1])*float(wpercent)))
	img = img.resize((basewidth,hsize), PIL.Image.ANTIALIAS)
	
	if orientation == 3:
	  img=img.rotate(180, expand=True)
	elif orientation == 6:
	  img=img.rotate(270, expand=True)
	elif orientation == 8:
	  img=img.rotate(90, expand=True)

	newImgName = os.path.join(cwd, '..', 'images', 'resized', filename)
	img.save(newImgName) 

for filename in os.listdir(images_directory):
	image_data = {
		"filename": filename
	}
	image_path = os.path.join(images_directory, filename)
	
	if os.path.isdir(image_path) or filename == '.DS_Store':
		continue

	file = open(image_path, 'rb')
	tags = exifread.process_file(file, details=False)
	
	# pprint.pprint(tags)
	# import pdb; pdb.set_trace()

	try:
		model = tags['Image Model'].values
		model = model.encode("ascii")
		image_data['model'] = model 
	except KeyError:
		model = 0

	try:
		date = tags['Image DateTime'].values
		date = date.encode("ascii")
		image_data['date'] = date
	except KeyError:
		date = 0

	try:
		orientation = tags['Image Orientation'].values[0]
	except KeyError: 
		orientation = 0

	resizeImg(image_path, filename, orientation)

	
	# pprint.pprint(orientation)

	# print image_path
	data = gpsphoto.getGPSData(image_path)
	# pprint.pprint(data)
	if 'Latitude' in data and 'Longitude' in data:
		image_data['lat'] = data['Latitude']
		image_data['long'] = data['Longitude']
		image_data['alt'] = data['Altitude']

	images_data.append(image_data)

	# exix_dict = piexif.load(image_path)
	# print exix_dict

pprint.pprint(images_data)
with open('exif.json', 'w') as outfile:
	json.dump(images_data, outfile);