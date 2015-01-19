#!/bin/sh

CURRENT_DIR=$(pwd)
TEMPLATE_DIR=$CURRENT_DIR"/templates/*"

# Colors
RED="\e[31mRed"

# Defaults
DEFAULT_IPADDRESS=55.55.55.10
DEFAULT_MEMORY=1024

# Regexs
REGEX_BOXNAME=[a-z0-9]+
REGEX_IPADDRESS="(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)"
REGEX_MEMORY=[0-9]+

# Check if shell is interactive
is_interactive()
{
 if [ -n "$PS1" ]; then
  error_text "Not a interactive shell"
  exit 2; 
 fi
}

# Set the output directory
set_output_dir()
{
 while true; do
  read -p "Output directory: " outputdir
  if [ -d $outputdir ]; then
   OUTPUT_DIR=$outputdir;
   return;
  else
   error_text 'Output directory does not exist'
  fi
 done
}

# Set box name
set_box_name()
{
 while true; do
  read -p "Box name (lowercase only): " boxname
  if [[ $boxname =~ $REGEX_BOXNAME ]]; then
   BOXNAME=$boxname;
   return;
  else
   error_text "Box name does not match pattern"
  fi
 done
}

# Set ip address
set_ip_address()
{
 while true; do
  read -p "IP address (default $DEFAULT_IPADDRESS): " ipaddress
  if [ -z "$ipaddress" ]; then
   warning_text "Ip not set using default";
   IPADDRESS=$DEFAULT_IPADDRESS;
   return;
  elif [[ $ipaddress =~ $REGEX_IPADDRESS ]]; then
   IPADDRESS=$ipaddress;
   return;
  else
   error_text "IP address does not match pattern"
  fi
 done
}

# Set memory
set_memory()
{
 while true; do
  read -p "Amount of memory (default $DEFAULT_MEMORY): " memory
  if [ -z "$memory" ]; then
   warning_text "Memory not set using default";
   MEMORY=$DEFAULT_MEMORY;
   return;
  elif [[ $memory =~ $REGEX_MEMORY ]]; then
   MEMORY=$memory;
   return;
  else
   error_text "Memory is not a number"
  fi
 done
}

# Copy files from this directory
copy_templates()
{
 cp -rf $TEMPLATE_DIR $OUTPUT_DIR
}

# Replace placeholders
replace_placeholders()
{
 find $OUTPUT_DIR -type f -exec sed -i '.old' "s/BOXNAME/$BOXNAME/g" {} \;
 find $OUTPUT_DIR -type f -exec sed -i '.old' "s/IPADDRESS/$IPADDRESS/g" {} \;
 find $OUTPUT_DIR -type f -exec sed -i '.old' "s/MEMORY/$MEMORY/g" {} \;
}

# Support functions
# Print error text
error_text()
{
 printf '\033[1;31m'"$@"'\033[0m\n';
}

# Print warning text
warning_text()
{
 printf '\033[1;33m'"$@"'\033[0m\n';
}

echo "Running vagrant box create script"
is_interactive
set_output_dir
set_box_name
set_ip_address
set_memory
copy_templates
replace_placeholders


