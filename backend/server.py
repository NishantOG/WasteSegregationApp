import os
import shutil
import uuid
import uvicorn
import config
from typing import List
from pathlib import Path
from fastapi.responses import HTMLResponse
from fastapi import FastAPI, File, UploadFile


app = FastAPI()


@app.get('/api/')
def main():
    return {'message': 'Welcome to our server!'}


@app.post("/upload-file/")
async def create_upload_file(uploaded_file: UploadFile = File(...)):
    file_location = f"files/{uploaded_file.filename}"
    with open(file_location, "wb+") as file_object:
        shutil.copyfileobj(uploaded_file.file, file_object)

    print('Hello')

    return {"info": f"file '{uploaded_file.filename}' saved at '{file_location}'"}
