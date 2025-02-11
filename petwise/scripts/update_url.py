import re
import os
import time

# Determine log file path based on operating system
log_file = r"C:\temp\cloudflared.log" if os.name == "nt" else "/tmp/cloudflared.log"

def extract_url(content):
    content = content.lstrip('\ufeff').strip()
    match = re.search(r'https://\S+?\.trycloudflare\.com', content, re.IGNORECASE)
    return match.group(0) if match else None

url = None
attempts = 0
max_attempts = 10

while attempts < max_attempts and not url:
    time.sleep(2)
    try:
        with open(log_file, 'r', encoding='utf-8', errors='ignore') as f:
            log_content = f.read()
        url = extract_url(log_content)
    except Exception as e:
        print(f"Error reading log file: {str(e)}")
        break
    attempts += 1

if url:
    with open('.env.tmp', 'w') as f:
        f.write(f'URL={url}')
    print(f"Updated URL to: {url}")
else:
    print("Could not extract URL after polling.")
    print("Last log content for debugging:")
    print(log_content)
