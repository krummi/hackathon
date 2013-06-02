import imaplib
import email
from PIL import Image
import requests
import os
import subprocess
import re

EMAIL_RE = re.compile(".*<(.+)>")
URL = 'http://localhost:5000/receipt'
FNULL = open(os.devnull, 'w')


def process(infile):
    subprocess.call(["rm", "-rf", "out/*"])
    subprocess.call(["rm", "-rf", "imgs/*"])
    subprocess.call(["touch", str(infile) + ".txt"])
    counter = 0
    file, ext = os.path.splitext(infile)
    print infile
    img = Image.open(infile)
    bounds = img.getbbox()
    newBounds = (bounds[0] + 20, 828, bounds[2] - 20, bounds[3] - 212)
    i = img.crop(newBounds)
    i.save("imgs/" + str(counter) + ".jpg")
    subprocess.call(["java", "-jar", "JavaOCR.jar", "imgs/" + str(counter) + ".jpg", "out"])
    stuff = ""
    for thing in os.listdir("out"):
        subprocess.call(["tesseract", "out/" + str(thing), "temp", "-psm", "7"], stdout=FNULL, stderr=subprocess.STDOUT)
        for i in os.popen("cat temp.txt"):
            stuff += i
    counter += 1

    recieptString = stuff
    infile = infile.split('/')[-1]
    user = infile[0:-4]
    payload = {'name': user, 'data': recieptString}
    subprocess.call(["rm", str(infile) + ".txt"])
    subprocess.call(["mv", infile, "scanned/" + infile])
    print recieptString
    r = requests.post(URL, data=payload)
    if r.status_code == '200':
        print "success!"

detach_dir = os.getcwd()
m = imaplib.IMAP4_SSL("imap.gmail.com")
m.login('verdvaktin1@gmail.com', 'hanikrummi')
m.select("[Gmail]/All Mail")

# TODO: change to this!
resp, items = m.search(None, "(UNSEEN)")
# resp, items = m.search(None, "(ALL)")
items = items[0].split()
for emailid in items:
    resp, data = m.fetch(emailid, "(RFC822)")
    email_body = data[0][1]
    mail = email.message_from_string(email_body)
    temp = m.store(emailid, '+FLAGS', '\\Seen')
    m.expunge()
    print "hallo"
    if mail.get_content_maintype() != 'multipart':
        continue

    print "["+mail["From"]+"] :" + mail["Subject"]

    # Retrieves the email!
    match = EMAIL_RE.search(mail["From"])
    if match == None:
        print 'did not find email in mail[From]:', mail["From"]
        continue
    email_addr = match.group(1)
    print "only email addr:", email_addr

    for part in mail.walk():
	print part.get_content_maintype()
        if part.get_content_maintype() == 'multipart':
            print "is multipart"
            continue
	if part.get('Content-Disposition') is None:
	    continue
	
        filename = email_addr.replace('@', '_at_') + '.jpg'
        att_path = os.path.join(detach_dir, filename)
        if not os.path.isfile(att_path):
            fp = open(att_path, 'wb')
            fp.write(part.get_payload(decode=True))
            fp.close()
            print att_path
            process(att_path)

