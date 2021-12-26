FROM gitpod/workspace-full:latest

RUN bash -c ". .nvm/nvm.sh     && nvm install 14.16.1     && nvm use 14.16.1     && nvm alias default 14.16.1"

RUN echo "nvm use default &>/dev/null" >> ~/.bashrc.d/51-nvm-fix