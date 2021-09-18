FROM python:3

ENV DEBIAN_FRONTEND noninteractive
#RUN apt update && apt install -y wget python3-pip && \
#        pip install diskimage-builder bindep dib-utils && \
#        wget https://raw.githubusercontent.com/openstack/diskimage-builder/master/bindep.txt && \
#        bindep --list_all newline --file bindep.txt | xargs apt install -y

RUN pip install diskimage-builder bindep dib-utils

RUN wget https://raw.githubusercontent.com/openstack/diskimage-builder/master/bindep.txt

RUN apt update && bindep --list_all newline --file bindep.txt | xargs apt install -y && \
        apt clean all && rm -rf /var/lib/apt*

#FROM scratch
#COPY --from=builder /usr/local/* /
ADD entrypoint.sh /

WORKDIR /opt

ENTRYPOINT ["/entrypoint.sh"]
