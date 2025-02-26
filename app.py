from flask import Flask, render_template, request, jsonify
import pytesseract
import shutil
from PIL import Image
import os

app = Flask(__name__)


pytesseract.pytesseract.tesseract_cmd = "/usr/bin/tesseract"

os.environ["TESSDATA_PREFIX"] = "/usr/share/tesseract-ocr/4.00/tessdata"

tesseract_path = shutil.which("tesseract")
print(f"Tesseract Path: {tesseract_path}")


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
        extracted_text = pytesseract.image_to_string(image, lang="eng+hin+mar")
        return jsonify({"text": extracted_text})
    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000 ,debug=True)
