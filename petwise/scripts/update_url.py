import re
import os
import time

# Determine log file path based on operating system
log_file = r"C:\temp\cloudflared.log" if os.name == "nt" else "/tmp/cloudflared.log"
encoding = 'utf-8' if os.name != "nt" else 'utf-16'

def extract_url(content):
    content = content.lstrip('\ufeff').strip()
    match = re.search(r'https://\S+?\.trycloudflare\.com', content, re.IGNORECASE)
    return match.group(0) if match else None

def get_current_url():
    try:
        with open('.env.tmp', 'r', encoding='utf-8') as f:
            content = f.read()
            match = re.search(r'URL=(https://\S+?\.trycloudflare\.com)', content, re.IGNORECASE)
            return match.group(1) if match else None
    except FileNotFoundError:
        return None

current_url = get_current_url()
url = None
attempts = 0
max_attempts = 10

while attempts < max_attempts and (not url or url == current_url):
    time.sleep(2)
    try:
        with open(log_file, 'r', encoding=encoding, errors='ignore') as f:
            log_content = f.read()
        url = extract_url(log_content)
        if url == current_url:
            print(f"Found same URL as current: {url}, continuing...")
    except Exception as e:
        print(f"Error reading log file: {str(e)}")
        break
    attempts += 1

if url and url != current_url:
    with open('.env.tmp', 'w') as f:
        f.write(f'URL={url}')
    print(f"Updated URL to: {url}")
else:
    print("Could not extract new URL after polling.")
    if url == current_url:
        print(f"URL remained unchanged: {url}")
    else:
        print("Last log content for debugging:")
        print(log_content)