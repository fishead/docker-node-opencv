FROM node:latest
LABEL maintainer Zhang Chuan <zhangchuan@jcble.com>


RUN apt-get update &&
    apt-get install -y --no-install-recommends \
    build-essential cmake git libgtk2.0-dev pkg-config \
    libavcodec-dev libavformat-dev libswscale-dev \
    ca-certificates


RUN git clone -b 3.2.0 --depth 1 https://github.com/opencv/opencv.git /usr/local/src/opencv
RUN git clone -b 3.2.0 --depth 1 https://github.com/opencv/opencv_contrib.git /usr/local/src/opencv_contrib


RUN cd /usr/local/src/opencv && \
    mkdir build && \
    cd build && \
    cmake -D CMAKE_INSTALL_PREFIX=/usr/local \
          -D BUILD_TESTS=OFF \
          -D BUILD_PERF_TESTS=OFF \
          -D PYTHON_DEFAULT_EXECUTABLE=$(which python3) \
          -D OPENCV_EXTRA_MODULES_PATH=/usr/local/src/opencv_contrib/modules \
          .. && \
    make -j"$(nproc)" && \
    make install
