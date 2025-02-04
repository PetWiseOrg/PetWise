import re
import os
import time

# Determine log file path based on operating system
log_file = r"C:\temp\cloudflared.log" if os.name == "nt" else "/tmp/cloudflared.log"

try:
    time.sleep(2)  # Give cloudflared time to start
    with open(log_file, 'r') as f:
        content = f.read()
        match = re.search(r'https://.*?\.trycloudflare\.com', content)
        url = match.group(0) if match else ''

    # Create or update .env.tmp file with the URL
    with open('.env.tmp', 'w') as f:
        f.write(f'URL={url}')

    print(f"Updated URL to: {url}")
except Exception as e:
    print(f"Error: {str(e)}")
