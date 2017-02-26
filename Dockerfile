FROM ubuntu:16.04

MAINTAINER Fred Tingaud <ftingaud@hotmail.com>

USER root

RUN apt-get update && apt-get -y install \
   wget \
   curl \
   git \
   cmake \
   zsh \
   clang-3.8 \
   build-essential \
   libfreetype6-dev \
   emacs \
   && rm -rf /var/lib/apt/lists/*

ENV CC clang-3.8
ENV CXX clang++-3.8

RUN cd /usr/src/ \
    && git clone https://github.com/google/benchmark.git \
    && mkdir -p /usr/src/benchmark/build/ \
    && cd /usr/src/benchmark/build/ \
    && cmake -DCMAKE_BUILD_TYPE=Release -DBENCHMARK_ENABLE_LTO=true .. \
    && make -j12 \
    && make install

RUN useradd -m -s /bin/zsh -N -u 1000 builder

USER builder

WORKDIR /home/builder