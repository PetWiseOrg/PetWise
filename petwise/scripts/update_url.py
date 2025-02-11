import re
import os
import time

# Determine log file path based on operating system
log_file = r"C:\temp\cloudflared.log" if os.name == "nt" else "/tmp/cloudflared.log"

try:
    time.sleep(2)  # Give cloudflared time to start
    with open(log_file, 'r', encoding='utf-8', errors='ignore') as f:
        content = f.read()
        # Remove BOM if present
        content = content.lstrip('\ufeff')
        # Remove any non-ASCII chars
        content = ''.join(ch for ch in content if ord(ch) < 128).strip()
        # Use a stricter pattern that allows letters, digits, and dashes
        match = re.search(r'https://[a-z0-9-]+\.trycloudflare\.com', content, re.IGNORECASE)
        url = match.group(0) if match else ''

    # Create or update .env.tmp file with the URL
    with open('.env.tmp', 'w') as f:
        f.write(f'URL={url}')

    print(f"Updated URL to: {url}")
    if not url:
        print("Log content for debugging:")
        print(content)
except Exception as e:
    print(f"Error: {str(e)}")
