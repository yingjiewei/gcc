FROM centos:centos7.9.2009

RUN yum install sudo wget gcc gcc-c++ \
                gmp-devel mpfr-devel  \
                libmpc-devel make file -y && \
                yum -y clean all
                
ENV SOFTWARE_DIR=/home/Software \
    GCC_VERSION=11.2.0

RUN rm -rf ${SOFTWARE_DIR} && \
    mkdir -p /home/Software ${SOFTWARE_DIR}/src/gcc/ ${SOFTWARE_DIR}/build/gcc/gcc-${GCC_VERSION} ${SOFTWARE_DIR}/install/gcc/gcc-${GCC_VERSION}

WORKDIR ${SOFTWARE_DIR}/src/gcc/

RUN wget --no-check-certificate https://mirrorservice.org/sites/sourceware.org/pub/gcc/releases/gcc-${GCC_VERSION}/gcc-${GCC_VERSION}.tar.gz && \
   tar xvf gcc-${GCC_VERSION}.tar.gz
   
WORKDIR ${SOFTWARE_DIR}/build/gcc/gcc-${GCC_VERSION}

RUN ${SOFTWARE_DIR}/src/gcc/gcc-${GCC_VERSION}/configure --prefix=${SOFTWARE_DIR}/install/gcc/gcc-${GCC_VERSION}/ --disable-multilib; \
    make -j "$(nproc)"; \
    make install; \
    rm -rf ${SOFTWARE_DIR}/build/gcc/gcc-${GCC_VERSION}; \
    rm -rf ${SOFTWARE_DIR}/src/gcc/gcc*


ENV PATH=${SOFTWARE_DIR}/install/gcc/gcc-${GCC_VERSION}/bin/:${SOFTWARE_DIR}/install/gcc/gcc-${GCC_VERSION}/bin64/:$PATH \
    LD_LIBRARY_PATH=${SOFTWARE_DIR}/install/gcc/gcc-${GCC_VERSION}/lib64:$LD_LIBRARY_PATH \
    CC=${SOFTWARE_DIR}/install/gcc/gcc-${GCC_VERSION}/bin/gcc \
    CXX=${SOFTWARE_DIR}/install/gcc/gcc-${GCC_VERSION}/bin/g++
