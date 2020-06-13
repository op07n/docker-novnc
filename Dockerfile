FROM node:10
ENV DEBIAN_FRONTEND noninteractive


# Install git, supervisor, VNC, & X11 packages
RUN set -ex; 

RUN apt-get update \
  && apt-get install -y software-properties-common apt-transport-https \
  && dpkg --add-architecture i386 \
  && wget -nc https://dl.winehq.org/wine-builds/winehq.key \
  && apt-key add winehq.key \
  && apt-add-repository https://dl.winehq.org/wine-builds/debian/ \
  && apt-get update \
  && apt-get install -y --install-recommends winehq-stable xvfb \
  && apt-get remove -y software-properties-common apt-transport-https \
  && apt-get clean -y \
  && apt-get autoremove -y








      
# Setup demo environment variables
ENV HOME=/root \
    DEBIAN_FRONTEND=noninteractive \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=C.UTF-8 \
    DISPLAY=:0.0 \
    DISPLAY_WIDTH=1024 \
    DISPLAY_HEIGHT=768 \
    RUN_XTERM=yes \
    RUN_FLUXBOX=yes
COPY . /app
RUN chmod +x /app/conf.d/websockify.sh
CMD ["/app/entrypoint.sh"]
