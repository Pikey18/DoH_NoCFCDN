#!/bin/bash
curl -s https://www.cloudflare.com/ips-v4/ -o /tmp/subnet4_list.txt
curl -s https://www.cloudflare.com/ips-v6/ -o /tmp/subnet6_list.txt

curl -s https://raw.githubusercontent.com/dibdot/DoH-IP-blocklists/refs/heads/master/doh-ipv4.txt -o /tmp/ip4_list.txt
curl -s https://raw.githubusercontent.com/dibdot/DoH-IP-blocklists/refs/heads/master/doh-ipv6.txt -o /tmp/ip6_list.txt

rm '/var/www/intranet/filtered_ip4.txt'
rm '/var/www/intranet/filtered_ip6.txt'

python3 /scripts/dohfilter/filter4.py
python3 /scripts/dohfilter/filter6.py

rm '/tmp/subnet4_list.txt'
rm '/tmp/subnet6_list.txt'
rm '/tmp/ip4_list.txt'
rm '/tmp/ip6_list.txt'

for i in "apple-relay.cloudflare.com dns.cloudflare.com cloudflare-dns.com 1dot1dot1dot1.cloudflare-dns.com chrome.cloudflare-dns.com dns64.cloudflare-dns.com dooh.cloudflare-dns.com family.cloudflare-dns.com mozilla.cloudflare-dns.com odoh.cloudflare-dns.com opera.cloudflare-dns.com security.cloudflare-dns.com tor.cloudflare-dns.com"; do dig @1.1.1.1 a +short $i; done > /var/www/intranet/cloudflare_doh4.txt

for i in "apple-relay.cloudflare.com dns.cloudflare.com cloudflare-dns.com 1dot1dot1dot1.cloudflare-dns.com chrome.cloudflare-dns.com dns64.cloudflare-dns.com dooh.cloudflare-dns.com family.cloudflare-dns.com mozilla.cloudflare-dns.com odoh.cloudflare-dns.com opera.cloudflare-dns.com security.cloudflare-dns.com tor.cloudflare-dns.com"; do dig @1.1.1.1 aaaa +short $i; done > /var/www/intranet/cloudflare_doh6.txt