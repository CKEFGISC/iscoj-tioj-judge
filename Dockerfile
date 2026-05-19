FROM ubuntu:24.04

WORKDIR /judge

RUN apt update
RUN apt install -y git g++ g++-14 cmake ninja-build libseccomp-dev libnl-genl-3-dev libsqlite3-dev libz-dev libssl-dev ghc python3 python3-numpy python3-pil libboost-all-dev libzstd-dev

RUN mkdir /usr/local/java/
RUN apt install curl
RUN curl -L https://cdn.azul.com/zulu/bin/zulu25.34.17-ca-jdk25.0.3-linux_x64.tar.gz -o openjdk-25.tar.gz \
  && tar -xzf openjdk-25.tar.gz -C /usr/local/java/ \
  && rm openjdk-25.tar.gz

ENV JAVA_HOME=/usr/local/java/zulu25.34.17-ca-jdk25.0.3-linux_x64
ENV PATH="${JAVA_HOME}/bin:${PATH}"

COPY . ./

WORKDIR /judge/build
RUN cmake -G Ninja ..
RUN ninja && ninja install

WORKDIR /judge

CMD ["/judge/scripts/init.sh", "-v"]
