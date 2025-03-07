from flask import Flask, render_template, request, jsonify
import pytesseract
from PIL import Image
import os
import logging

# Configure logging
logging.basicConfig(level=logging.DEBUG)

app = Flask(__name__)

# Set TESSDATA_PREFIX environment variable
os.environ["TESSDATA_PREFIX"] = "/usr/share/tesseract-ocr/4.00/tessdata"

@app.route("/")
def home():
    return render_template("index.html")

@app.route("/upload", methods=["POST"])
def upload():
    if "image" not in request.files:
        return jsonify({"error": "No file uploaded"}), 400

    file = request.files["image"]
    if file.filename == "":
        return jsonify({"error": "No file selected"}), 400

    try:
        image = Image.open(file)
        try:
            # Extract text using Tesseract
            extracted_text = pytesseract.image_to_string(image, lang="eng+hin+mar")
            logging.debug("Text extraction successful!")
        except Exception as e:
            logging.error(f"Error during OCR processing: {e}")
            extracted_text = "Error processing image."
        return jsonify({"text": extracted_text})
    except Exception as e:
        logging.error(f"Error opening image: {e}")
        return jsonify({"error": str(e)}), 500

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=int(os.environ.get("PORT", 10000)), debug=True)
