# Private browser preview build

This is the Godot 4.7.2 single-threaded Web export of the approved armed Fighter preview. It uses the Compatibility renderer and keeps the provisional 480×270 canvas.

Godot web exports need to be served over HTTP; opening index.html directly from the filesystem is not supported. After cloning the private repository on a test computer:

    cd web-preview
    python3 -m http.server 8000

Open http://localhost:8000 in a current desktop browser with WebAssembly and WebGL 2 support. Click the game canvas before using WASD and J. Press F2 to show or hide the strike range/lane debug overlay; its FRONT/RANGE/LANE readout shows why a target position misses. If testing from a second computer on the same network, run the server on the host computer with python3 -m http.server 8000 --bind 0.0.0.0, then open http://HOST-LAN-IP:8000 on the test computer. Stop the server with Ctrl+C.

The GitHub repository is private, so testers also need repository access to clone/download this folder. This folder is a versioned build artifact; regenerate it from the Godot project after future changes.
