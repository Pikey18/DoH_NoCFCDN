import ipaddress

# Function to read IP addresses from a file, ignoring comments
def read_ips_from_file(filename):
    with open(filename, 'r') as file:
        ips = []
        for line in file:
            # Strip comments (everything after #) and whitespace
            line = line.split('#')[0].strip()
            if line:  # Only process non-empty lines
                ips.append(line)
        return ips

# Function to read subnets from a file, ignoring comments
def read_subnets_from_file(filename):
    with open(filename, 'r') as file:
        subnets = []
        for line in file:
            # Strip comments (everything after #) and whitespace
            line = line.split('#')[0].strip()
            if line:  # Only process non-empty lines
                subnets.append(line)
        return subnets

# Read IP addresses and subnets from files
ip_list = read_ips_from_file('/tmp/ip6_list.txt')
subnet_list = read_subnets_from_file('/tmp/subnet6_list.txt')

# Convert lists to ipaddress objects
ip_addresses = [ipaddress.ip_address(ip) for ip in ip_list]
subnets = [ipaddress.ip_network(subnet, strict=False) for subnet in subnet_list]

# Filter out IP addresses in subnets
filtered_ip_list = [str(ip) for ip in ip_addresses if not any(ip in subnet for subnet in subnets)]

# Write the filtered list to a new text file
output_file = '/var/www/intranet/dohfilter/main_v6.txt'
with open(output_file, 'w') as file:
    for ip in filtered_ip_list:
        file.write(ip + '\n')

print(f"Filtered IP addresses have been written to {output_file}")
