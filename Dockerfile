# Use an official lightweight Python image
FROM python:3.10-slim

# Install system dependencies including Tesseract
RUN apt-get update && apt-get install -y tesseract-ocr tesseract-ocr-hin

# Set the working directory inside the container
WORKDIR /app

# Copy all project files to the container
COPY . .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose the port Flask runs on
EXPOSE 5000

# Command to run the Flask app
CMD ["python", "app.py"]
