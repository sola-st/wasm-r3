from mitmproxy import ctx, http
from urllib.parse import urlparse
import subprocess

def response(flow: http.HTTPFlow):
    if flow.response.headers.get("content-type", "") in ["application/wasm"]:
        with open("output.txt", "a") as file:
            file.write(flow.request.url + " " + flow.response.headers.get("content-type", "") + "\n")
        with open('pspdf.wasm', "wb") as file:
            file.write(flow.response.content)
        print('instrumenting...')
        subprocess.run("cd /Users/jakob/Desktop/wasabi-fork/crates/wasabi && cargo run -- /Users/jakob/Desktop/wasm-r3/tool/instrumenter/pspdf.wasm -o /Users/jakob/Desktop/wasm-r3/tool/instrumenter/", shell=True)
        print('done instrumenting')
        # subprocess.run('wasm2wat pspdf.wasm -o pspdf.wat', shell=True)
        with open('pspdf.wasm', "rb") as file:
            flow.response.content = file.read()
