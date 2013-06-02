import os
from flask import Flask, request, url_for, redirect
from werkzeug import secure_filename

UPLOAD_FOLDER = 'imgs'
ALLOWED_EXTENSIONS = set(['jpg', 'jpeg'])
app = Flask(__name__)
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER


def allowed_file(filename):
    return '.' in filename and \
           filename.rsplit('.', 1)[1] in ALLOWED_EXTENSIONS


@app.route('/')
def hello():
    print "shit"


@app.route('/data', methods=['POST'])
def upload_file():
    if request.method == 'POST':
        file = request.files['file']
        if file and allowed_file(file.filename):
            filename = secure_filename(file.filename)
            file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
            return "hehe"
    return "hehe"


if __name__ == '__main__':
    app.debug = True
    app.run(host='0.0.0.0')
