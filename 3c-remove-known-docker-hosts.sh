#!/bin/sh

echo "Removing known hosts created by docker (assuming 192.168.99.100-103) ..."
ssh-keygen -R 192.168.99.100
ssh-keygen -R 192.168.99.101
ssh-keygen -R 192.168.99.102
ssh-keygen -R 192.168.99.103
echo "... finished removing known hosts created by docker (assuming 192.168.99.100-103)."
