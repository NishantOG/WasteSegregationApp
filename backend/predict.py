import os
import cv2
import keras
import numpy as np

CATEGORIES = ['cardboard','glass','metal','paper','plastic','trash']

def image(path):
    img = cv2.imread(path, cv2.IMREAD_UNCHANGED)
    new_arr = cv2.resize(img, (100,100))
    new_arr = np.array(new_arr)
    new_arr = new_arr.reshape(-1, 100, 100 , 3)
    return new_arr

model = keras.models.load_model('WasteSegregation.model')

directory = r'D:\DataSet\Garbage classification\test_of_model'

for filename in os.listdir(directory):
    dest=os.path.join(directory, filename)
    prediction = model.predict([image(dest)])
    print(filename,CATEGORIES[prediction.argmax()])