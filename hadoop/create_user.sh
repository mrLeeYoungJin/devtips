#!/bin/bash

__create_user() {
# Create a user to SSH into as.
#useradd user
SSH_USERPASS=root123!@#
echo -e "$SSH_USERPASS\n$SSH_USERPASS" | (passwd --stdin root)
echo ssh root password: $SSH_USERPASS
}

# Call all functions
__create_user
