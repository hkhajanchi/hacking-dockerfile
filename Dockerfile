# Ubuntu-based Dockerfile for everyday hacking

# Install packages and stuff 
FROM ubuntu:latest
ENV DEBIAN_FRONTEND=noninteractive

# Linux utils and packages
RUN apt-get update && \ 
    apt-get install -y \ 
 
    bat \ 
    binutils \
    clang \ 
    gcc \ 
    gdb \ 
    git \ 
    htop \ 
    cmake \ 
    neovim \ 
    python3 \ 
    python3-pip \
    ssh \ 
    thefuck \
    fish \ 
    tmux \ 
    valgrind \ 

    # for openCV 
    build-essential \ 
    libgtk2.0-dev \ 
    pkg-config \ 
    libavcodec-dev \ 
    libavformat-dev \ 
    libswscale-dev 

# Setup neovim
RUN sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' && \
    git clone https://github.com/hkhajanchi/nvim-config && \
    mkdir -p /root/.config/nvim && \
    mv nvim-config/init.vim /root/.config/nvim/ && \
    rm -rf nvim-config && \
    nvim --headless +PlugInstall +qall 

# Build OpenCV 
RUN cd ~ && git clone https://github.com/opencv/opencv.git && \ 
    cd opencv && \
    mkdir build && \ 
    cd build && \
    cmake -DCMAKE_BUILD_TYPE=Release .. && \
    make -j12 && \ 
    make install 

# Python stuff
RUN pip3 install -U numpy 

WORKDIR /hack 

CMD ["/usr/bin/fish"]
