from __future__ import division, print_function

import numpy as np
from PIL import Image
import joblib as joblib


# Keras
from keras.models import load_model

# Flask utils
from flask import Flask, redirect, url_for, request, render_template, jsonify, send_file
from flask_ngrok import run_with_ngrok

# Define a flask app
app = Flask(__name__)
#run_with_ngrok(app)


def predict_model(image):
    image = Image.open(image)
    image = image.resize((224,224))

    # Preprocessing the image
    image_arr = np.array(image.convert('RGB'))

    image_arr.shape = (1, 224, 224, 3)

    return image_arr

def segment_model(image):
    image = Image.open(image)
    image = image.resize((256,256))

    # Preprocessing the image
    image_arr = np.array(image.convert('RGB'))

    image_arr.shape = (1, 256, 256, 3)

    return image_arr


classes = ['glioma_tumor', 'meningioma_tumor', 'normal', 'pituitary_tumor']

# Model saved with Keras model.save()
# Load your trained model

model = load_model('EfficientNetB3-Brain Tumors-No.h5')
seg_model = load_model('Seg_model')


@app.route('/predictApi', methods=['POST'])
def predict_api():
    try:
        if 'fileup' not in request.files:
             return "Please try again, the image doesn't exit "
        image = request.files.get('fileup')
        image_arr = predict_model(image)
        result = model.predict(image_arr)
        ind = np.argmax(result)
        prediction = classes[ind]

        return jsonify({'prediction': prediction})

    except:
         return jsonify({'ERROR': 'error occured try again'})


@app.route('/segmentApi', methods=['POST'])
def segment_api():
    # try:
        if 'fileup' not in request.files:
            return "Please try again, the image doesn't exit "
        image = request.files.get('fileup')
        image_arr = segment_model(image)
        result = seg_model(image_arr)
        # ind = np.argmax(result)
        # segmentation = classes[ind]`

        return send_file(result, mimetype='image/jpg')
    # except:
    #      return jsonify({'ERROR': 'error occured try again'})


if __name__ == '__main__':
    # app.debug = True
    app.run(debug=True, host='0.0.0.0', port=8000)
# host='0.0.0.0', port=8000
#SgV