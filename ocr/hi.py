from PIL import Image
import glob
import os
import subprocess

for infile in glob.glob("*.jpg"):
    subprocess.call(["rm", "-rf", "out/*"])
    subprocess.call(["rm", file + ".txt"])
    subprocess.call(["touch", file + ".txt"])
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
        subprocess.call(["tesseract", "out/" + str(thing), "temp"])
        for i in os.popen("cat temp.txt"):
            stuff += i
        counter += 1

    recieptString = stuff
    f = open(file + ".txt")
    f.write(recieptString)
