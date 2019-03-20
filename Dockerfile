FROM jupyter/minimal-notebook:latest

USER root

# install java
apt-get install openjdk-8-jdk

# install and run openrefine
#RUN wget https://github.com/OpenRefine/OpenRefine/releases/download/3.1/openrefine-linux-3.1.tar.gz -O openrefine.tar.gz && \
#  tar -xvzf openrefine.tar.gz && \
#  chmod +x openrefine\refine && \
#  openrefine\refine 

RUN conda create -n py27 python=2.7 ipykernel

USER jovyan


MAINTAINER Nikolaus Parulian <nikolaus.nova@gmail.com>
