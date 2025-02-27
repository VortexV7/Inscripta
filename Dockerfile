# Use Python base image
FROM python:3.9

# Install system dependencies
RUN apt-get update && apt-get install -y \
    tesseract-ocr \
    tesseract-ocr-eng \
    tesseract-ocr-hin \
    tesseract-ocr-mar \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy project files
COPY . .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Set Tesseract data path
ENV TESSDATA_PREFIX="/usr/share/tesseract-ocr/4.00/tessdata"

# Run the app
CMD ["python", "app.py"]
