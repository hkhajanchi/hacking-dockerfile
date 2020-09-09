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
    clangd \ 
    curl \ 
    gcc \ 
    gdb \ 
    git \ 
    htop \ 
    cmake \ 
    neovim \ 
    npm \ 
    python3 \ 
    python3-pip \
    ssh \ 
    thefuck \
    fish \ 
    tmux \ 
    valgrind  


# Setup neovim
RUN sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' && \
    git clone https://github.com/hkhajanchi/nvim-config && \
    git clone https://github.com/hkhajanchi/dotfiles && \
    mkdir -p /root/.config/nvim && \
    mkdir -p /root/.config/nvim/general && \
    mv nvim-config/init.vim /root/.config/nvim/ && \
    mv nvim-config/settings.vim /root/.config/nvim/general && \ 
    mv nvim-config/.vimrc /root && \ 
    mv dotfiles/config.fish /root/.config/fish && \
    rm -rf nvim-config && \
    rm -rf dotfiles && \
    nvim --headless +PlugInstall +qall && \ 
    nvim --headless +CocInstall coc-python +qall && \  
    nvim --headless +CocInstall coc-python +qall && \  
    nvim --headless +CocInstall coc-clangd +qall && \ 
    nvim --headless +CocInstall coc-clangd +qall  

# Python stuff
RUN pip3 install -U numpy pylint jedi pynvim

WORKDIR /hack 

CMD ["/usr/bin/fish"]
