If you want to store multiple credentials like **username, password, and database name** in a single `.txt` file and use it in Docker Compose, here’s how you can do it securely using **Docker secrets**.

---

### 🔹 **Step 1: Create a Secrets File (`db_credentials.txt`)**
Instead of storing secrets in an `.env` file, create a `.txt` file for credentials:

```sh
echo -e "POSTGRES_USER=admin\nPOSTGRES_PASSWORD=supersecretpassword\nPOSTGRES_DB=my_database" > db_credentials.txt
```

---

### 🔹 **Step 2: Modify `docker-compose.yml` to Use Secrets**
Since Docker **does not support multi-line secrets** natively, we need to split them into separate files or **use an entrypoint script**.

#### ✅ **Option 1: Separate Secret Files (Recommended)**
You can create separate `.txt` files for each credential:

```sh
echo "admin" > postgres_user.txt
echo "supersecretpassword" > postgres_password.txt
echo "my_database" > postgres_db.txt
```

Then, reference them in `docker-compose.yml`:

```yaml
version: '3.9'

services:
  db:
    image: postgres:latest
    container_name: my_postgres_container
    restart: unless-stopped
    ports:
      - "5432:5432"
    environment:
      POSTGRES_USER_FILE: /run/secrets/postgres_user
      POSTGRES_PASSWORD_FILE: /run/secrets/postgres_password
      POSTGRES_DB_FILE: /run/secrets/postgres_db
    secrets:
      - postgres_user
      - postgres_password
      - postgres_db
    networks:
      - my_network

secrets:
  postgres_user:
    file: ./postgres_user.txt
  postgres_password:
    file: ./postgres_password.txt
  postgres_db:
    file: ./postgres_db.txt

networks:
  my_network:
    driver: bridge
```

🚀 **Now the PostgreSQL service will read credentials securely from `/run/secrets/` instead of environment variables.**

---

#### ✅ **Option 2: Use an Entrypoint Script (For Single File Secret)**
If you **must** keep everything in a single `db_credentials.txt` file:

1️⃣ **Create `db_credentials.txt`**
```sh
echo -e "POSTGRES_USER=admin\nPOSTGRES_PASSWORD=supersecretpassword\nPOSTGRES_DB=my_database" > db_credentials.txt
```

2️⃣ **Modify `docker-compose.yml`**
```yaml
version: '3.9'

services:
  db:
    image: postgres:latest
    container_name: my_postgres_container
    restart: unless-stopped
    ports:
      - "5432:5432"
    environment:
      POSTGRES_USER: "$(grep POSTGRES_USER /run/secrets/db_credentials | cut -d '=' -f2)"
      POSTGRES_PASSWORD: "$(grep POSTGRES_PASSWORD /run/secrets/db_credentials | cut -d '=' -f2)"
      POSTGRES_DB: "$(grep POSTGRES_DB /run/secrets/db_credentials | cut -d '=' -f2)"
    secrets:
      - db_credentials
    networks:
      - my_network

secrets:
  db_credentials:
    file: ./db_credentials.txt

networks:
  my_network:
    driver: bridge
```

3️⃣ **Docker Will Read Secrets at Runtime**  
The `grep` command extracts values dynamically inside the container.

---

### 🔹 **Which Method Should You Use?**
| Method | Pros | Cons |
|--------|------|------|
| **Separate Secret Files** | More secure, easier to manage | Requires multiple files |
| **Entrypoint Script (`grep` method)** | Uses a single file | Less secure, requires runtime processing |

Would you like me to update your `docker-compose.yml` with one of these approaches? 🚀