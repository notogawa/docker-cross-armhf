FROM debian:jessie
MAINTAINER notogawa <n.ohkawa@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

RUN apt-get update \
 && apt-get install -y --no-install-recommends curl \
 && apt-get clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

RUN echo 'deb http://emdebian.org/tools/debian/ jessie main' > /etc/apt/sources.list.d/crosstools.list \
 && curl -sLO http://emdebian.org/tools/debian/emdebian-toolchain-archive.key \
 && apt-key add emdebian-toolchain-archive.key \
 && rm emdebian-toolchain-archive.key \
 && dpkg --add-architecture armhf

RUN apt-get update \
 && apt-get install -y --no-install-recommends crossbuild-essential-armhf apt-utils locales \
 && apt-get clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists

RUN echo en_US.UTF-8 UTF-8 > /etc/locale.gen
RUN locale-gen
RUN update-locale LANG=en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
