import http.server
import socketserver
import webbrowser
import os
import sys

PORT = 8080
DIRECTORY = os.path.join(os.path.dirname(os.path.abspath(__file__)), "web_runner")

class Handler(http.server.SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory=DIRECTORY, **kwargs)

def get_local_ip():
    import socket
    try:
        s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        s.connect(("8.8.8.8", 80))
        ip = s.getsockname()[0]
        s.close()
        return ip
    except Exception:
        return "localhost"

def run():
    os.chdir(DIRECTORY)
    local_ip = get_local_ip()
    local_url = f"http://localhost:{PORT}/index.html"
    phone_url = f"http://{local_ip}:{PORT}/index.html"
    
    print("=" * 65)
    print("  VOICEAID: Offline Voice-Based First-Aid Assistant")
    print("=" * 65)
    print(f"  [PC Browser]   : {local_url}")
    print(f"  [Phone Access] : {phone_url}")
    print("=" * 65)
    print("  TO OPEN ON YOUR PHONE:")
    print(f"  1. Ensure your phone is on the same Wi-Fi network.")
    print(f"  2. Open Chrome/Safari on your phone and go to:")
    print(f"     {phone_url}")
    print("  3. Tap browser menu (⋮) -> 'Add to Home screen' to install it!")
    print("=" * 65)
    print("  Press Ctrl+C in this terminal to stop the server.")
    print("=" * 65)
    
    webbrowser.open(local_url)
    
    with socketserver.TCPServer(("", PORT), Handler) as httpd:
        try:
            httpd.serve_forever()
        except KeyboardInterrupt:
            print("\nVoiceAid server stopped.")

if __name__ == "__main__":
    run()

