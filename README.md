# mac-screen-stream
[WIP] Screen Record Streaming for macOS

## Ideal Usage

Here is an ideal usage, NOT realized yet.  

```bash
# NOTE: Not realized yet
mac-screen-stream > myscreen.mp4
```

Captured video is streaming into stdout in real-time. `ffmpeg` with avfoundation is very useful to achieve this purpose. However, `ffmpeg` has some delay about 3 or 4 sec. Thus, the purpose of this project is to shorten the delay than `ffmpeg`.

I've bean searching for the feature, trying possible ways. This project welcomes your PR to realize the streaming!　　

## Current Status

```bash
swiftc main.swift
./main
```

After few seconds, you have `screen.mp4` in pwd.  
