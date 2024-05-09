#!/bin/bash

# Task 1: Set ANCHOR_NAME variable
ANCHOR_NAME="99ify"

# Task 2: Flush pfctl rules
sudo pfctl -a $ANCHOR_NAME -F all

# Task 3: Flush dummynet pipes
sudo dnctl -f flush

# Task 4: Delete throttle_rules.txt
rm -f ./pf_rules.txt

# Task 5: Delete lines containing ANCHOR_NAME in /etc/pf.conf
sudo sed -i '' "/$ANCHOR_NAME/d" /etc/pf.conf

# Task 6: Refresh pfctl rules
sudo pfctl -f /etc/pf.conf

# Task 7: Disable pfctl
sudo pfctl -d

echo "Cleanup complete."
