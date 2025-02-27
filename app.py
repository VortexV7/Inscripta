from flask import Flask, render_template, request, jsonify
import pytesseract
from PIL import Image
import os

app = Flask(__name__)

pytesseract.pytesseract.tesseract_cmd = r"C:\Program Files\Tesseract-OCR\tesseract.exe"

os.environ["TESSDATA_PREFIX"] = os.path.join(os.getcwd(), "tessdata")

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
            extracted_text = pytesseract.image_to_string(image, lang="eng+hin+mar")
            print("Text extraction successful!")
        except Exception as e:
            print(f"Error during OCR processing: {e}")
            extracted_text = "Error processing image."
        return jsonify({"text": extracted_text})
    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=10000, debug=True)

