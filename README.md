# vagrant-bare-box
Vagrant box generation script

## Prerequisites
- Vagrant
- Librarian puppet
- Virtual box

## Description
This script helps you to create a simple Vagrant box on the fly, with all the files and configuration already set. (This script is intended to be a time saver)

## Usage
```bash
sh create-box.sh
```

You'll get the following input
```bash
Running vagrant box create script
Output directory: /tmp/bla	
Box name (lowercase only): bla
IP address (default 55.55.55.10): 
Ip not set using default
Amount of memory (default 1024): 
Memory not set using default
```
