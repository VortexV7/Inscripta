# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Install system dependencies (Tesseract and its dependencies)
RUN apt-get update && apt-get install -y \
    tesseract-ocr \
    libtesseract-dev \
    libleptonica-dev \
    && rm -rf /var/lib/apt/lists/*

# Download Tesseract language data
RUN mkdir -p /usr/share/tesseract-ocr/4.00/tessdata && \
    cd /usr/share/tesseract-ocr/4.00/tessdata && \
    wget https://github.com/tesseract-ocr/tessdata/raw/main/eng.traineddata && \
    wget https://github.com/tesseract-ocr/tessdata/raw/main/hin.traineddata && \
    wget https://github.com/tesseract-ocr/tessdata/raw/main/mar.traineddata

# Copy the current directory contents into the container at /app
COPY . /app

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose port 10000
EXPOSE 10000

# Run the Flask app
CMD ["python", "app.py"]
