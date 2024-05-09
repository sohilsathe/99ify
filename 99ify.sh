#!/bin/bash

# Task 1: Validate file contents
if [ ! -s "./addictive_sites.txt" ]; then
    echo "Error: File ./addictive_sites.txt is empty or does not exist."
    exit 1
fi

# Task 2: Validate domain name syntax
IFS=$'\n'
while read -r line; do
    IFS=', '
    read -ra domains <<< "$line"
    for domain in "${domains[@]}"; do
        if [[ ! "$domain" =~ ^[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
            echo "Error: Invalid domain name syntax found in ./addictive_sites.txt: $domain"
            exit 1
        fi
    done
done < "./addictive_sites.txt"
unset IFS

# Task 3: Create BLACKLIST variable
BLACKLIST=$(cat "./addictive_sites.txt" | tr '\n' ',' | sed 's/,$//')

echo $BLACKLIST
# Task 4: Create ANCHOR_NAME variable
ANCHOR_NAME="99ify"

# Task 5: Enable pfctl
sudo pfctl -E

# Task 6: Backup pf.conf
sudo cp /etc/pf.conf ./pf.conf.backup

# Task 7: Append lines to pf.conf
echo "dummynet-anchor $ANCHOR_NAME" | sudo tee -a /etc/pf.conf
echo "anchor $ANCHOR_NAME" | sudo tee -a /etc/pf.conf

# Task 8: Reload pfctl
sudo pfctl -f /etc/pf.conf
sudo pfctl -sr

# Task 9: Configure dummynet pipe
sudo dnctl pipe 1 config bw 100Kbit/s queue 10

# Task 10: Write throttle_rules.txt
echo "dummynet out proto {tcp, udp} from any to {$BLACKLIST} port {http, https} pipe 1" > ./pf_rules.txt

# Task 11: Append to throttle_rules.txt
echo "dummynet in proto {tcp, udp} from {$BLACKLIST} to any pipe 1" >> ./pf_rules.txt

# Task 12: Reload pfctl rules
sudo pfctl -a $ANCHOR_NAME -f pf_rules.txt

echo "Setup complete."
