#!/bin/bash

# Create the directory structure
mkdir -p webapp/scripts

# Create the index.html file
cat > webapp/index.html <<EOL
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome to My WebApp</title>
</head>
<body>
    <h1>Hello, this is a simple static web app!</h1>
</body>
</html>
EOL

# Create the appspec.yml file
cat > webapp/appspec.yml <<EOL
version: 0.0
os: linux
files:
  - source: /
    destination: /var/www/html
hooks:
  BeforeInstall:
    - location: scripts/install_dependencies.sh
      timeout: 300
  ApplicationStart:
    - location: scripts/start_server.sh
      timeout: 300
EOL

# Create the install_dependencies.sh script
cat > webapp/scripts/install_dependencies.sh <<EOL
#!/bin/bash
sudo apt-get update
sudo apt-get install -y nginx
EOL

# Make the install_dependencies.sh executable
chmod +x webapp/scripts/install_dependencies.sh

# Create the start_server.sh script
cat > webapp/scripts/start_server.sh <<EOL
#!/bin/bash
sudo systemctl start nginx
EOL

# Make the start_server.sh executable
chmod +x webapp/scripts/start_server.sh

# Output the created directory structure
echo "Directory structure created:"
tree webapp
