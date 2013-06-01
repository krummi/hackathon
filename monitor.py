import imaplib
import email
import os
import re

EMAIL_RE = re.compile(".*<(.+)>")

detach_dir = os.getcwd() + '/ocr/imgs'
m = imaplib.IMAP4_SSL("imap.gmail.com")
m.login('verdvaktin1@gmail.com', 'hanikrummi')
m.select("[Gmail]/All Mail")

# TODO: change to this!
# resp, items = m.search(None, "(UNSEEN)")
resp, items = m.search(None, "(ALL)")
items = items[0].split()

for emailid in items:
    resp, data = m.fetch(emailid, "(RFC822)")
    email_body = data[0][1]
    mail = email.message_from_string(email_body)
    temp = m.store(emailid, '+FLAGS', '\\Seen')
    m.expunge()

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
        if part.get_content_maintype() == 'multipart':
            continue
        if part.get('Content-Disposition') is None:
            continue


        filename = email_addr.replace('@', '_at_') + '.jpg'
        att_path = os.path.join(detach_dir, filename)

        if not os.path.isfile(att_path):
            fp = open(att_path, 'wb')
            fp.write(part.get_payload(decode=True))
            fp.close()
