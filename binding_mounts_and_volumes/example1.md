Here’s how you can track the number of times the volume has been accessed using a **Python program** inside a **Docker container** based on `python:3.7-alpine`.  

---

### **Step 1: Create a Docker Volume**
Run the following command to create the volume:
refer code volume_creation.sh <a href="./volume_creation.sh">[click me...]</a>
```sh
./volume_creation.sh
```

---

### **Step 2: Create a Python Script (`app.py`)**  
This script will create a file inside the volume (`/data_folder/access_count.txt`) and increment the count each time the script runs.
see the code of app.py: Link <a href="./app.py">[click me]</a>
---

### **Step 3: Create a Dockerfile**
This Dockerfile sets up a **Python 3.7 Alpine** container with our script.
dockerfile contant: Link <a href="./Dockerfile">[click me]</a>
---

### **Step 4: Build the Docker Image**
see the code of run build docker image : Link <a href="build_script.sh">[click me]</a>
Run the following command to build the image:
```sh
./build_script.sh
```

---

### **Step 5: Run the Container with Mounted Volume**
see the contant of run.sh: Link <a href="./run.sh">[click me]</a>

Run the container and mount the volume:
```sh
./run.sh
```

Each time you run the container, the script inside will increment and display the access count.

---

### **Step 6: Verify the Volume Data**
To manually check the access count, you can start a temporary container and inspect the file:
```sh
docker run --rm --init \
  --mount type=volume,source=python_data_volume,target=/data_folder \
  python-volume-access-tracter cat /data_folder/access_count.txt
```
### also see the content of .Dockerignore file
-   Link: <a href="./.Dockerignore">[click me]</a>
---

### **Expected Output**
When you first run the container:
```
Volume accessed for the first time.
```
On subsequent runs:
```
Volume has been accessed 2 times.
Volume has been accessed 3 times.
...
```

---

### **Conclusion**
- The script ensures that the access count persists across container runs using **Docker volumes**.
- **Python 3.7 Alpine** is used for a lightweight environment.
- The `track_access.py` script automatically updates and logs access counts in `/data_folder/access_count.txt`.
