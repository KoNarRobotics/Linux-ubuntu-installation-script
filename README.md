# Linux-ubuntu-installation-script
A handy script that configures a fresh ubuntu 24.04 installation with all the usefull for developer packages and applications.

# How to use
1. Clone the repository
2. Run the script (only once)
```bash
./install-script.sh
```
3. You will be prompted to enter your password for sudo commands
4. The script will install all the packages and applications
5. Enjoy your fresh ubuntu installation.
## If you need to re-run the script
Then find the line that says.
```bash
## BASH ALIASES
```
and comment out the echo command that follows it, to avoid duplicating the aliases in your .bashrc file.

# Software
- Ros2 Jazzy
- Docker
- VSCode
- Discord
- KiCad
- and more...
