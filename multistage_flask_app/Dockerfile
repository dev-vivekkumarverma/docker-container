
# Stage 1: Build dependencies
FROM python:3.9 AS builder
WORKDIR /app

# Copy requirements first (for caching optimization)
COPY requirements.txt /app/
RUN pip install --no-cache-dir --prefix=/install -r requirements.txt

# Stage 2: Final lightweight image
FROM python:3.9-slim
WORKDIR /app

# Ensure Python finds installed dependencies
ENV PYTHONPATH=/usr/local/lib/python3.9/site-packages

# Install curl (for health check)
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Copy installed dependencies from builder stage
COPY --from=builder /install /usr/local

# Copy application files
COPY . /app/

# Expose port 5000 for Flask
EXPOSE 5000

# Health check: Verify app is running
HEALTHCHECK --interval=10s --timeout=3s --retries=3 CMD curl -f http://localhost:5000 || exit 1

# Run the Flask app
CMD ["python", "app.py"]
