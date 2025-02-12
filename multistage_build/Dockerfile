# Stage 1: Build dependencies
FROM python:3.9 as builder
WORKDIR /app
# Copy only requirements file first to leverage caching
COPY requirements.txt /app/
RUN pip install --no-cache-dir --prefix=/install -r requirements.txt


# Stage 2: Final lightweight image
FROM python:3.9-slim
WORKDIR /app

# Ensure Python finds the installed dependencies 
ENV PYTHONPATH=/usr/local/lib/python3.9/site-packages

COPY --from=builder /install /usr/local
COPY . /app/
CMD ["python", "app.py"]
