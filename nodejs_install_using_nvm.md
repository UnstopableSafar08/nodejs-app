## NVM and Node.js Installation Script for Jenkins Agents

This script installs `nvm`, multiple Node.js versions, sets Node 20 as default, and ensures Jenkins can use it in pipelines.

### Install nvm (if not installed)
```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
```

### Load nvm in current shell
Add the following files on the `.bashrc`
```bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
```
Apply the changes and re-login a user.
```bash
source .bashrc
exit
# re-login
```

### Install/Uninstall multiple Node versions
```bash
# Install the multiple version of node under the nvm.
nvm install 16.20.2
nvm install 18.20.8
nvm install 20.19.5
nvm install 22.19.0

#  List the installed version of node
nvm ls # or nvm list

# Output:
# [jenkin@jenkins-s01 ~]$ nvm ls
#       v14.21.3
#       v16.20.2
#       v18.20.8
# ->     v20.19.5
#       v22.19.0
# default -> 20 (-> v20.19.5)
```
Uninstall the Node Version.
```bash
nvm uninstall 16.20.2
```

### npm version Install/Uninstall
```bash
# Install latest npm for current Node
npm install -g npm@latest

# Install a specific npm version
npm install -g npm@10.9.4

# Verify npm
npm -v
```

### Set Node 20 as default
```bash
nvm alias default 20
```
### Switch to Node 20 immediately in current shell
```bash
nvm use 20
```
### Verify versions
```bash
node -v   ### should show v20.19.5
npm -v    ### npm compatible with Node 20
nvm list  ### list installed versions and default
```
### Optional: remove conflicting system Node
```bash
sudo yum remove nodejs -y
```

### Jenkins pipeline usage (example for Node setup stage)
Add this at the start of any stage using Node/npm
```bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm use default
node -v
npm -v
```



#### Use a Specific Version in Jenkins Pipeline
```bash
pipeline {
    agent any
    stages {
        stage('Node 14 Build') {
            steps {
                sh '''
                  source ~/.nvm/nvm.sh
                  nvm use 14
                  node -v
                '''
            }
        }
        stage('Node 18 Build') {
            steps {
                sh '''
                  source ~/.nvm/nvm.sh
                  nvm use 18
                  node -v
                '''
            }
        }
    }
}
```


---


## Uninstall nvm

```bash
# Remove NVM directory and all installed Node versions
rm -rf "$HOME/.nvm"

# Remove NVM references from shell config files
sed -i '/NVM_DIR/d' ~/.bashrc
sed -i '/nvm.sh/d' ~/.bashrc
sed -i '/bash_completion/d' ~/.bashrc

sed -i '/NVM_DIR/d' ~/.bash_profile
sed -i '/nvm.sh/d' ~/.bash_profile
sed -i '/bash_completion/d' ~/.bash_profile

sed -i '/NVM_DIR/d' ~/.zshrc
sed -i '/nvm.sh/d' ~/.zshrc
sed -i '/bash_completion/d' ~/.zshrc

# Reload shell
source ~/.bashrc

# Verify removal
command -v nvm   # should return nothing
node -v          # optional: should fail if no system Node
npm -v           # optional: should fail if no system npm
```
