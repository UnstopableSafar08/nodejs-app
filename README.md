# nodejs-helloworld
This is a test nodeJs app.

### Build Docker Image  
  Syntax: `docker build -t <image_name>:<tag> -f <Dockerfile_name> <build_context>` 
  

```bash
docker build -t node:1 -f dockerfile.nodejs .
```

Flag Details:
- `-t` node:1 → Name the image node with tag 1
- `.` → Build context is the current directory (where Dockerfile is located).

Advance docker build cmd;
- `docker build -t <image_name>:<tag> -f <Dockerfile_name> <build_context_dir>`
- e.g `docker build -t myapp:latest -f dockerfile.nodejs .`

### Run Docker Container  
  Syntax: `docker run -id --name <container_name> -p <host_port>:<container_port> <image_name>:<tag>`  


**Example:**
```bash
docker run -id --name node -p 3001:3000 node:1
```

Flag Details:
- -i → Keep STDIN open (interactive)
- -d → Run container in detached mode (background)
- --name node → Name the container node
- -p 3001:3000 → Map host port 3001 to container port 3000
- node:1 → Image to run


### List Docker Images  
  Syntax: `docker images`  

**Example:**
```bash
docker images
```

### List Running Containers  
  Syntax: `docker ps`  

**Example:**
```bash
docker ps
```

###  List All Containers (including stopped)  
  Syntax: `docker ps -a`  

**Example:**
```bash
docker ps -a
```

### Stop a Container  
  Syntax: `docker stop <container_name_or_id>`  

**Example:**
```bash
docker stop node
```

### Remove a Container  
  Syntax: `docker rm <container_name_or_id>`  

**Example:**
```bash
docker rm node
```

### Remove an Image  
  Syntax: `docker rmi <image_name>:<tag>`  

**Example:**
```bash
docker rmi node:1
```

### Docker Login

#### Generate a PAT (Personal Access Token) from a docker.

**Step 1: Log in to Docker Hub**
- Go to https://hub.docker.com/login
- Sign in with your Docker Hub account.

**Step 2: Go to Security Settings**
- Click your profile icon → Account Settings → Security
- Under Access Tokens, click New Access Token.

**Step 3: Create a New Token**
- Give the token a name (e.g., docker-cli-token).
- Optionally, set expiration.
- Click Generate.
- Docker Hub will now show you the token only once. Copy it immediately.

#### Docker Login cmd.
  Syntax: `echo "<your_password_or_PAT>" | docker login -u <username> --password-stdin`  

**Example:**
```bash
echo "<your_pat_password_here>" | docker login -u <your_docker_user_name> --password-stdin
```

### Docker Push  
  Syntax:  
  `docker tag <local_image> <username>/<repository>:<tag>`  
  `docker push <username>/<repository>:<tag>`  

**Example:**
```bash
docker tag node:1 <your_docker_user_name>/<your_repo_name>:1
docker push <your_docker_user_name>/<your_repo_name>:1
```

### Docker Pull  
  Syntax: `docker pull <username>/<repository>:<tag>`  

**Example:**
```bash
docker pull <your_docker_user_name>/<your_repo_name>:1
```

<!--### Docker Volumes  -->
<!--  Syntax:  -->
<!--  `docker volume create <volume_name>`  -->
<!--  `docker volume ls`  -->
<!--  `docker volume inspect <volume_name>`  -->
<!--  `docker volume rm <volume_name>`  -->
<!--
**Example:**-->
<!--```bash-->
<!--docker volume create my_volume-->
<!--docker volume ls-->
<!--docker volume inspect my_volume-->
<!--docker volume rm my_volume-->
<!--```-->

### Using Volume bind in Container
  Syntax: `docker run -d --name <container_name> -v <host_path>:<container_path> <image_name>:<tag>`  

**Example:**
```bash
docker run -d --name node -v ./app/:/usr/src/app node:1
```

<!--### Docker Compose (Optional)  -->
<!--  Syntax:  -->
<!--  `docker-compose up -d`  -->
<!--  `docker-compose down`  -->
<!--  `docker-compose logs`  -->
<!--
**Example:**-->
<!--```bash-->
<!--docker-compose up -d-->
<!--docker-compose logs-->
<!--docker-compose down-->
<!--```-->

