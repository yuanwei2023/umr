FROM alpine:3.16

RUN apk add --no-cache \
cmake \
g++ \
gcc \
libdrm-dev \
libpciaccess-dev \
libxml2-dev \
llvm \
llvm13 \
llvm13-dev \
llvm13-static \
make \
ncurses-dev \
