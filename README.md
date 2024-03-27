# Hardening Linux firewall rules to detect and mitigate vulnerabilities in Node.js services

This repository contains three key scripts used to enhance the security of Node.js-based web services by configuring firewall rules to detect and mitigate vulnerabilities.

## Scripts

### App.js

This Node.js script implements a basic web server with protective measures against Distributed Denial of Service (DDoS) attacks. It employs a rate limiting strategy for requests per IP to prevent abuse.

Key features:
- Basic web server using Express.js.
- Rate limiting to mitigate DDoS attacks.
- Welcome page with a simple "Hello World!" message.

### tallafocs_off.sh

A shell script to stop all iptables firewall rules, setting a default accept policy and clearing all existing custom rules and chains.

Key features:
- Resets iptables default policies to `ACCEPT`.
- Removes all custom rules and clears rule tables.

### tallafocs_on.sh

A shell script to set up strict iptables rules aimed at protecting against a wide range of attacks, including DDoS, SYN flood, and others.

Key features:
- Sets a restrictive default policy (`DROP`) for all incoming, outgoing, and forwarded traffic.
- Allows local traffic and traffic on port 3000 (typically for web services).
- Limits the number of incoming TCP connections and ping requests to mitigate flood and DDoS attacks.
- Allows outgoing traffic.

## Usage

To use these scripts, make sure you have Node.js installed for `App.js`. The shell scripts (`tallafocs_off.sh` and `tallafocs_on.sh`) require root privileges to execute properly, as they modify the system's iptables rules.

1. Start the Node.js server:

```bash
node App.js
```

2. Apply firewall rules to enhance security:
```bash
sudo ./tallafocs_on.sh
```
3. To stop the firewall and clear the rules:
```bash
sudo ./tallafocs_off.sh
```
