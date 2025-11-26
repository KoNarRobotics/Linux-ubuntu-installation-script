# Linux-ubuntu-installation-script
A handy script that configures a fresh ubuntu 24.04 installation with all the usefull for developer packages and applications.

# How to use
1. Clone the repository


### FOR ROS developers
2. Run the script (only once)
```bash
./install-script.sh
```
### FOR Embedded developers. 
2. Run the script  (only once) (if you also need ros2 jazzy, uncomment the relevant lines inside the script for ros2 installation)
```bash
./install-script-embed.sh
```

3. You will be prompted to enter your password for sudo commands
4. The script will install all the packages and applications
5. Enjoy your fresh ubuntu installation.
## If you need to re-run the script
### FOR ROS developers
Then find the line that says.
```bash
## BASH ALIASES
```
### FOR Embedded developers
Then find the line that says.
```bash
## PROFILE PATHS
```

and comment out the echo command that follows it, to avoid duplicating the aliases in your .bashrc file.

# Software
- Ros2 Jazzy
- Docker
- VSCode
- Discord
- KiCad
- and more...
