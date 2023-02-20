FROM nvidia/cuda:11.4.0-runtime-ubuntu20.04

ENV DEBIAN_FRONTEND=noninteractive LANGUAGE=C.UTF-8 LANG=C.UTF-8 LC_ALL=C.UTF-8 LC_CTYPE=C.UTF-8 LC_MESSAGES=C.UTF-8
ENV PYTHON_VERSION=3.10

RUN apt-get update -yqq \
   && apt-get install -y \
   libc-dev\
   libpq-dev\
   g++\
   python${PYTHON_VERSION}\
   python3-pip\
   python3-venv\
   && apt-get clean

ARG DATASCIENCE_UID="50000"
ARG DATASCIENCE_GID="50000"
ARG DATASCIENCE_HOME=/home/datascience

RUN addgroup --gid ${DATASCIENCE_GID} datascience \
   && useradd -l datascience -u ${DATASCIENCE_UID} --create-home -g ${DATASCIENCE_GID}

COPY docker/datascience/entrypoint.sh /
COPY docker/datascience/init.sh /init/

RUN chown -R datascience:datascience /init/ \
   && chmod +x /entrypoint.sh /init/init.sh

USER datascience

COPY docker/datascience/requirements.txt /

RUN python3 -m venv /home/datascience/.venv
ENV PATH=/home/datascience/.venv/bin:$PATH

# jupyter notebook installation:
RUN pip3 install --no-cache-dir -U \
   notebook==6.4.0 ipywidgets==7.6.3 jupyter-nbextensions-configurator==0.4.1 jupyter-contrib-nbextensions==0.5.1
RUN jupyter contrib nbextension install --user
RUN jupyter nbextensions_configurator enable --user

RUN pip3 install --no-cache-dir -U -r /requirements.txt

ENV DATASCIENCE_HOME=${DATASCIENCE_HOME}
ENV PYTHONPATH=${DATASCIENCE_HOME}

COPY src/ ${DATASCIENCE_HOME}/src
COPY notebooks/ /home/datascience/notebooks/
WORKDIR ${DATASCIENCE_HOME}

ENTRYPOINT ["/entrypoint.sh"]