FROM electron

# inspired by atom from https://github.com/jessfraz/dockerfiles/blob/master/atom/Dockerfile
# Run as:
# docker run --rm -it -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=unix$DISPLAY patchbay npm start
# this might be also needed for sound, if there is any...
# --device /dev/snd
# maybe also
# -v /dev/shm:/dev/shm
#
# I also had to run `xhost local:docker` on my host computer, to allow docker using my X server (get rid of "No protocol specified")

RUN apt-get update && apt-get install -y --no-install-recommends \
  libtool eclipse-cdt-autotools

RUN git clone https://github.com/ssbc/patchbay.git
WORKDIR /root/patchbay
RUN npm install
RUN npm run rebuild

# fix some errors with leveldown
RUN npm install electron-rebuild && ./node_modules/.bin/electron-rebuild

# cleanup
RUN apt-get clean && apt-get purge --auto-remove -y curl git \
    && rm -rf /var/lib/apt/lists/*
