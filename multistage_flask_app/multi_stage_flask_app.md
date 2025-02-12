# Dockerized Flask App with Multi-Stage Build and Health Check

## 📁 Project Structure
```
/my-flask-app
│-- Dockerfile
│-- app.py
│-- requirements.txt
│-- README.md
|-- .Dockerignore
```

## Problem Statement
The goal is to create a **Dockerized Flask application** with an optimized **multi-stage build**. The solution should:
1. Use a **multi-stage Docker build** to reduce image size.
2. Install dependencies in a separate builder stage.
3. Copy only necessary dependencies to the final image.
4. Run a **Flask web server** inside the container.
5. Implement a **health check** using `curl` to verify if the application is running.

## Solution
The project uses:
- **`python:3.9`** as the builder stage to install dependencies.
- **`python:3.9-slim`** as the final lightweight image.
- **Flask** for creating a simple web server.
- **Health check** to ensure the application is running.

---

##  File Contents

### ** `app.py` (Flask Web Application)**
-   link <a href='./app.py'> [click me]</a>

### **`requirements.txt` (Dependencies)**
-   link <a href='./requirements.txt'> [click me]</a>

### ** `Dockerfile` (Multi-Stage Build + Health Check)**
-   link <a href='./Dockerfile'> [click me]</a>

### ** `.Dockerignore`
-   link <a href='./Dockerignore'> [click me]</a>

---

## How to Build and Run

### **1. Build the Docker Image**
```sh
docker build -t my-flask-app .
```

### **2. Run the Container**
```sh
docker run --init -p 5000:5000 --rm --name flask_container my-flask-app
```

### **3. Test the Application**
- Open **http://localhost:5000** in your browser.
- You should see: `Hello from Dockerized Flask App!`

### **Check Health Status**
```sh
docker inspect --format='{{json .State.Health}}' flask_container
```
---

## Conclusion
This project demonstrates a **Dockerized Flask application** using:
- **Multi-stage builds** to optimize image size.
- **Health check** for monitoring container status.
- **Lightweight final image** for efficient deployment.



