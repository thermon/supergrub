FROM debian:11.3

ENV TZ=Etc/UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get -y update && \
    apt-get -y install sudo \
                       xorriso \
                       git

RUN useradd -u 1004 sgdbuilder
ADD --chown=1004:1004 . /supergrub2-repo
RUN mkdir /supergrub2-build
RUN chown 1004:1004 /supergrub2-build
USER sgdbuilder
RUN git clone /supergrub2-repo /supergrub2-build
WORKDIR /supergrub2-build
