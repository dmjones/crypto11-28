FROM golang:1.11

RUN apt-get update
RUN apt-get install -y softhsm2
RUN apt-get install -y libltdl-dev

RUN curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh

WORKDIR /go/src/scratch/

# This takes forever, so do it early on
RUN echo "package main" >> dummy.go
RUN dep init
RUN dep ensure -v -add github.com/ThalesIgnite/crypto11


RUN echo "\
directories.tokendir = /tokens\n\
objectstore.backend = file\n\
log.level = INFO\n" > softhsm.conf
ENV SOFTHSM2_CONF /go/src/scratch/softhsm.conf

RUN echo "\
{\n\
  \"Path\" : \"/usr/lib/softhsm/libsofthsm2.so\",\n\
  \"TokenLabel\": \"test\",\n\
  \"Pin\" : \"1234\"\n\
}\n" > config

WORKDIR /go/src/scratch
COPY . .
RUN chmod +x run.sh
ENTRYPOINT ["./run.sh"]


