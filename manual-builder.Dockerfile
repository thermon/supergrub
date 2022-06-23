FROM debian:11.3

ENV TZ=Etc/UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get -y update && \
    apt-get -y install sudo \
                       xorriso

ADD . /supergrub2
WORKDIR /supergrub2
