FROM jupyter/minimal-notebook:latest

USER root

# install java
RUN apt-get -y update && apt-get -y install openjdk-8-jdk


RUN conda create --quiet --yes -n ipykernel_py2 python=2 ipykernel 

# init conda bash profile
RUN ["/bin/bash", "-c" , "conda init bash"]

# install python 2 kernel
RUN ["/bin/bash", "-c" , "source activate ipykernel_py2 && ipython kernel install && source deactivate"]

# install library for openrefine client
RUN ["/bin/bash", "-c" , "source activate ipykernel_py2 && conda install pandas numpy matplotlib && pip install urllib2_file && source deactivate"]

USER jovyan

# get client library
RUN git clone https://github.com/PaulMakepeace/refine-client-py && \
  cp -pR refine-client-py/google ./  

# Copy Notebook file
COPY . .

# install and run openrefine
RUN wget https://github.com/OpenRefine/OpenRefine/releases/download/3.1/openrefine-linux-3.1.tar.gz -O openrefine.tar.gz && \
  tar -xvzf openrefine.tar.gz && \
  chmod +x openrefine-3.1/refine

RUN ["nohup","/bin/bash","-c","./openrefine-3.1/refine &"]

MAINTAINER Nikolaus Parulian <nikolaus.nova@gmail.com>
