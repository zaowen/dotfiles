#!/bin/bash
# Pumps some Bovine wisdom through lolcat

cowsay $(fortune -a) | lolcat
read -n 1
clear
