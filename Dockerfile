FROM ubuntu:24.04

WORKDIR /judge
RUN apt update
RUN apt install -y git g++ cmake ninja-build libseccomp-dev libnl-genl-3-dev libsqlite3-dev libz-dev libssl-dev ghc  python3 python3-numpy python3-pil libboost-all-dev libzstd-dev
RUN apt install -y g++-14
COPY . ./

WORKDIR /judge/build
RUN cmake -G Ninja ..
RUN ninja && ninja install

WORKDIR /judge

CMD ["/judge/scripts/init.sh", "-v"]
