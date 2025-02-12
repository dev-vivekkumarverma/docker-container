# (Multi-Stage + Optimization 🚀)
Modify the following Dockerfile to use multi-stage builds:

Current Dockerfile (Non-Optimized)

```dockerfile
FROM python:3.9-slim
WORKDIR /app
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt
COPY . /app/
CMD ["python", "app.py"]
```
Your Task:
- Use python:3.9 as the builder stage to install dependencies.
- Use python:3.9-slim as the final runtime image.
- Install dependencies inside /install and copy only the required files to the final image.
- Keep the final image as small as possible.

see here <a href="./Dockerfile">[click me ..]</a>