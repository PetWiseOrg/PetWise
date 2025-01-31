import re
import json
import os
import time

try:
    time.sleep(2)  # Give cloudflared time to start
    with open('/tmp/cloudflared.log', 'r') as f:
        content = f.read()
        match = re.search('https://.*?\\.trycloudflare\\.com', content)
        url = match.group(0) if match else ''

    # Create or update .env.tmp file with the URL
    with open('.env.tmp', 'w') as f:
        f.write(f'URL={url}')

    print(f"Updated URL to: {url}")
except Exception as e:
    print(f"Error: {str(e)}")
