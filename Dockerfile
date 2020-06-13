FROM debian:stretch

# Install git, supervisor, VNC, & X11 packages
RUN set -ex; 
      
      
RUN apt-get update && apt-get install -y --no-install-recommends software-properties-common && dpkg --add-architecture i386 && curl -L https://dl.winehq.org/wine-builds/winehq.key > winehq.key && apt-key add winehq.key && apt-add-repository https://dl.winehq.org/wine-builds/debian && \
  apt-get update && \
  apt-get -y purge software-properties-common libdbus-glib-1-2 python3-dbus python3-gi python3-pycurl python3-software-properties && \
  apt-get install -y --no-install-recommends winehq-stable fakeroot libxss1 \
  
  && apt-get install -y --install-recommends winehq-stable xvfb \
  && apt-get install -y bash \
  && apt-get install -y fluxbox \
  && apt-get install -y git \
  && apt-get install -y net-tools \
  && apt-get install -y novnc \
  && apt-get install -y socat \
  && apt-get install -y supervisor \
  && apt-get install -y x11vnc \
  && apt-get install -y xterm \  
  
  # clean
  && apt-get clean && rm -rf /var/lib/apt/lists/* && unlink winehq.key      
      
      
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
