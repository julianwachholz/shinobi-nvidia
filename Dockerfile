FROM shinobisystems/shinobi:dev

RUN git clone https://git.videolan.org/git/ffmpeg/nv-codec-headers.git && \
  cd nv-codec-headers && \
  make -j8 && \
  make install -j8 && \
  cd .. && rm -rf nv-codec-headers

RUN git clone https://git.ffmpeg.org/ffmpeg.git

RUN apt-get -y install build-essential yasm cmake libtool libc6 libc6-dev unzip wget libnuma1 libnuma-dev

RUN cd ffmpeg && \
  ./configure --prefix=/usr --enable-cuda --enable-cuvid --enable-nvenc --enable-nonfree --extra-cflags=-I/usr/local/cuda/include --extra-ldflags=-L/usr/local/cuda/lib64 && \
  make -j8 && \
  make install && \
  cd .. && rm -rf ffmpeg
