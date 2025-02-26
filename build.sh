#!/bin/bash

# Update package lists
apt-get update

# Install Tesseract OCR and Hindi language data
apt-get install -y tesseract-ocr tesseract-ocr-hin

# Install Python dependencies
pip install -r requirements.txt
