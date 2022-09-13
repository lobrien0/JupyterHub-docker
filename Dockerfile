FROM ubuntu

ARG jupyterlocal

USER root

#General Updates and Dependency Installs
RUN apt-get update
RUN apt-get install -yq --no-install-recommends \
	ca-certificates \
	locales \
	python3 \
	python3-pip \
	nodejs \
	npm\
	dotnet6

#Install JupyterHub and JupyterLabs
RUN mkdir -p /apps/jupyter
WORKDIR /apps/jupyter
RUN pip install jupyterhub
RUN pip install jupyterlab dockerspawner

#NPM install
RUN npm install -g configurable-http-proxy

EXPOSE 8000

CMD ["jupyterhub"]
