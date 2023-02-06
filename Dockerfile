FROM archlinux

RUN pacman -Syyu --noconfirm autoconf automake curl python3 libmpc mpfr git gmp gawk base-devel bison flex texinfo gperf libtool patchutils bc zlib expat
RUN git clone https://github.com/riscv/riscv-gnu-toolchain \
    && cd /riscv-gnu-toolchain \
    && ./configure --prefix=/opt/riscv && make -j$(nproc)
ENV PATH $PATH:/opt/riscv/bin:$HOME/.cargo/bin
RUN git clone https://github.com/riscv/riscv-tests \
    && cd /riscv-tests \
    && git checkout e30978a71921159aec38eeefd848fca4ed39a826 \
    && git submodule update --init --recursive \
    && autoconf \
    && ./configure --prefix=/opt/riscv \
    && make -j$(nproc) \
    && make -j$(nproc) install 
