import os

# Define the file path inside the mounted volume
file_path = "/data_folder/access_count.txt"

# Check if the file exists, if not create it with initial count
if not os.path.exists(file_path):
    with open(file_path, "w") as f:
        f.write("1")
    print("Volume accessed for the first time.")
else:
    # Read the current access count
    with open(file_path, "r") as f:
        count = int(f.read().strip())

    # Increment and update the count
    count += 1
    with open(file_path, "w") as f:
        f.write(str(count))

    print(f"Volume has been accessed {count} times.")
