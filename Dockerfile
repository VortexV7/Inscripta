# Use an official lightweight Python image
FROM python:3.10-slim

# Install Tesseract and required language packs
RUN apt-get update && apt-get install -y tesseract-ocr tesseract-ocr-hin

# Set working directory
WORKDIR /app

# Copy all files from your GitHub repo to the container
COPY . .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose the port where your Flask app runs
EXPOSE 5000

# Set the entry point for running the app
CMD ["python", "app.py"]
