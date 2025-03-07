# Use Python base image
FROM python:3.9

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && \
    apt-get install -y tesseract-ocr \
    tesseract-ocr-hin \
    tesseract-ocr-mar \
    && rm -rf /var/lib/apt/lists/*

# Copy project files
COPY . /app

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Set environment variables
ENV TESSDATA_PREFIX=/usr/share/tesseract-ocr/4.00/tessdata/

# Expose port
EXPOSE 5000

# Start the application
CMD ["gunicorn", "-b", "0.0.0.0:5000", "app:app"]
