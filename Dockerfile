# Use official Python image as a base
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Install required dependencies
RUN apt-get update && apt-get install -y tesseract-ocr \
    && apt-get install -y wget \
    && mkdir -p /usr/share/tesseract-ocr/4.00/tessdata/ \
    && wget -P /usr/share/tesseract-ocr/4.00/tessdata/ \
        https://github.com/tesseract-ocr/tessdata_best/raw/main/eng.traineddata \
        https://github.com/tesseract-ocr/tessdata_best/raw/main/hin.traineddata \
        https://github.com/tesseract-ocr/tessdata_best/raw/main/mar.traineddata

# Set environment variable for Tesseract data path
ENV TESSDATA_PREFIX=/usr/share/tesseract-ocr/4.00/tessdata/

# Copy all files from local project to container
COPY . /app

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose the port for Flask
EXPOSE 5000

# Run the application
CMD ["python", "app.py"]
