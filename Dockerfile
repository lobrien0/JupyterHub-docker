FROM python:3.6-alpine

RUN apk update && apk upgrade
RUN apk add bash \
    py3-pip \
    ca-certificates \
    nodejs npm \
    texlive-xetex texmf-dist texlive \
    rust cargo \
    gcc g++ libffi-dev libc-dev \
    linux-headers \
    linux-pam libsodium gettext-dev linux-pam-dev  

RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install pandoc

RUN mkdir -p /apps/jupyter
WORKDIR /apps/jupyter
RUN python3 -m pip install jupyterhub
RUN python3 -m pip install jupyterlab

RUN npm install -g configurable-http-proxy

EXPOSE 8088

CMD ["jupyterhub"]
