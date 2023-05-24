FROM ubuntu:20.04

# Install compiler, python and subversion.
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
                    git \
                    build-essential \
                    gcc \
                    g++ \
                    python \
                    python3 \
                    cmake \
                    ninja-build \
                    wget

COPY patches/llvm.patch /patches/llvm.patch
COPY scripts/install-llvm.sh /scripts/install-llvm.sh

RUN /scripts/install-llvm.sh

RUN git clone --depth 1 --single-branch --branch main https://github.com/emscripten-core/emsdk.git
RUN cd emsdk && ./emsdk install latest && ./emsdk activate latest && cd ..

COPY scripts/build-tblgen.sh /scripts/build-tblgen.sh
RUN /scripts/build-tblgen.sh

COPY scripts/build-llvm.sh /scripts/build-llvm.sh
COPY emlib/fsroot.js /emlib/fsroot.js
CMD /scripts/build-llvm.sh
