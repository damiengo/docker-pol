#!/bin/bash

docker rm pol --force
docker run -it --privileged --ipc="host" --device=/dev/nvidiactl --device=/dev/nvidia-uvm --device=/dev/nvidia0 --device=/dev/snd -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix:rw -v /home/dam/Documents/games/:/home/gamer:rw --name pol gaming/pol
