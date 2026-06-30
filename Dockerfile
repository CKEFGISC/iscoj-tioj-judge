FROM ubuntu:24.04

WORKDIR /judge

RUN apt update 
RUN apt install -y software-properties-common
RUN add-apt-repository ppa:ubuntu-toolchain-r/test -y
RUN apt update

RUN apt install -y \
  curl git \
  # c++
  g++ g++-16 \
  # internal stuff, idk
  cmake ninja-build \
  libseccomp-dev libnl-genl-3-dev libsqlite3-dev libz-dev libssl-dev libboost-all-dev libzstd-dev \
  # haskell
  ghc \
  # python
  python3 python3-numpy python3-pil

ENV LD_LIBRARY_PATH="/usr/lib/gcc/x86_64-linux-gnu/16:${LD_LIBRARY_PATH}"

# precompile c++ 26 std lib
RUN mkdir -p /usr/share/gcm.cache
RUN cd /usr/share/gcm.cache && g++-16 -std=c++26 -fmodules-ts -c /usr/include/c++/16/bits/std.cc

# java, stupid installation
RUN mkdir /usr/local/java/
RUN curl -L https://cdn.azul.com/zulu/bin/zulu25.34.17-ca-jdk25.0.3-linux_x64.tar.gz -o openjdk-25.tar.gz
RUN tar -xzf openjdk-25.tar.gz -C /usr/local/java/
RUN rm openjdk-25.tar.gz

ENV JAVA_HOME=/usr/local/java/zulu25.34.17-ca-jdk25.0.3-linux_x64
ENV PATH="${JAVA_HOME}/bin:${PATH}"

COPY . ./

WORKDIR /judge/build
RUN cmake -G Ninja ..
RUN ninja && ninja install

WORKDIR /judge

CMD ["/judge/scripts/init.sh", "-v"]
