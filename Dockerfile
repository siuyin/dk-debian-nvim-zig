FROM debian:13-slim AS unpacker
RUN apt update && apt install -y xz-utils
ADD https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz /usr/local/
ADD https://ziglang.org/download/0.15.2/zig-x86_64-linux-0.15.2.tar.xz /usr/local/
ADD https://github.com/zigtools/zls/releases/download/0.15.1/zls-x86_64-linux.tar.xz /usr/local/
RUN tar -C /usr/local -xf /usr/local/nvim-linux-x86_64.tar.gz
RUN tar -C /usr/local -xf /usr/local/zig-x86_64-linux-0.15.2.tar.xz
RUN tar -C /usr/local -xf /usr/local/zls-x86_64-linux.tar.xz
RUN ls -l /usr/local

FROM debian:13-slim
RUN apt update && apt install -y sudo curl xclip tmux procps git adduser && adduser --uid 1000 siuyin && adduser siuyin sudo  && echo "siuyin ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/siuyin
COPY --from=unpacker /usr/local/nvim-linux-x86_64/ /usr/local/nvim
COPY --from=unpacker /usr/local/zig-x86_64-linux-0.15.2/ /usr/local/zig
COPY --from=unpacker /usr/local/zls /usr/local/zig

USER siuyin
WORKDIR /home/siuyin
COPY --chown=siuyin:siuyin .config/nvim/init.lua .config/nvim/init.lua
COPY --chown=siuyin:siuyin amux.conf profile_paths agent-startup-code .
RUN mkdir .ssh
RUN cat agent-startup-code >> .profile
RUN cat profile_paths >> .profile

ENTRYPOINT ["bash","--login"]
