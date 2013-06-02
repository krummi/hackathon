from PIL import Image
import requests
import glob
import os
import subprocess

URL = 'http://46.149.22.13:5000/receipt'
FNULL = open(os.devnull, 'w')

for infile in glob.glob("*.jpg"):
    subprocess.call(["rm", "-rf", "out/*"])
    subprocess.call(["touch", str(infile) + ".txt"])
    counter = 0
    file, ext = os.path.splitext(infile)
    img = Image.open(infile)
    bounds = img.getbbox()
    newBounds = (bounds[0] + 20, 828, bounds[2] - 20, bounds[3] - 212)
    i = img.crop(newBounds)
    i.save("imgs/" + str(counter) + ".jpg")
    subprocess.call(["java", "-jar", "JavaOCR.jar", "imgs/" + str(counter) + ".jpg", "out"])
    stuff = ""
    for thing in os.listdir("out"):
        subprocess.call(["./textcleaner", "-g", "-e", "none", "-f", "10", "-o", "5", "out/" + str(thing), "out/" + str(thing)])
        subprocess.call(["tesseract", "out/" + str(thing), "temp"], stdout=FNULL, stderr=subprocess.STDOUT)
        for i in os.popen("cat temp.txt"):
            stuff += i
    counter += 1

    recieptString = stuff
    user = infile[0:-4]
    payload = {'name': user, 'data': recieptString}
    subprocess.call(["rm", str(infile) + ".txt"])
    subprocess.call(["mv", infile, "scanned/" + infile])
    print recieptString
    r = requests.post(URL, data=payload)
    if r.status_code == '200':
        print "success!"
