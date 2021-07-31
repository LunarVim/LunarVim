FROM python:3

SHELL ["/bin/bash", "-c"]

ENV DEBIAN_FRONTEND=noninteractive

ADD script.sh /tmp/script.sh

RUN bash -c "/tmp/script.sh"

ENTRYPOINT ["/bin/bash"]
