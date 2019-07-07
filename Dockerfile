FROM       debian:jessie-slim as build
WORKDIR    /uv
COPY       . .
RUN        apt-get update && apt-get install -y automake libtool build-essential
RUN        sh autogen.sh && ./configure && make && make check && make install

FROM       build as test
RUN        ./gyp_uv.py -f make && make -C out
ENTRYPOINT [ "./out/Debug/run-tests" ]
