FROM arris/dev:latest
MAINTAINER Arris Ray <arris.ray@gmail.com>

USER ${USER}
WORKDIR /home/${USER}

# See: https://code.visualstudio.com/docs/setup/linux
RUN curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg \
    && sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg \
    && sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

ARG BUILD_PACKAGES='gcc-4.9 \
    libgconf-2-4 libxss1 libxtst6 libnss3 libnotify-bin \
    libgtk2.0-0 libgl1-mesa-dri libgl1-mesa-glx libasound2 \
    code'

RUN sudo apt-get update \
    && sudo apt-get install -yq \
        ${BUILD_PACKAGES} \
    && sudo rm -rf /var/lib/apt/lists/*

CMD ["code","--wait","."]
