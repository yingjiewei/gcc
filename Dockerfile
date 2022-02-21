FROM centos:centos7.9.2009

RUN yum install sudo wget gcc gcc-c++ \
                gmp-devel mpfr-devel  \
                libmpc-devel make file -y && \
                yum -y clean all
                
ENV SOFTWARE_DIR=/home/Software \
    GCC_VERSION=11.2.0
    
RUN mkdir -p /home/Software ${SOFTWARE_DIR}/Software/src/gcc/ ${SOFTWARE_DIR}/Software/build/gcc/gcc-${GCC_VERSION} ${SOFTWARE_DIR}/Software/install/gcc/gcc-${GCC_VERSION}

WORKDIR ${SOFTWARE_DIR}/Software/src/gcc/

RUN wget --no-check-certificate https://mirrorservice.org/sites/sourceware.org/pub/gcc/releases/gcc-${GCC_VERSION}/gcc-${GCC_VERSION}.tar.gz && \
   tar xvf gcc-${GCC_VERSION}.tar.gz
   
WORKDIR ${SOFTWARE_DIR}/Software/build/gcc/gcc-${GCC_VERSION}

RUN ${SOFTWARE_DIR}/Software/src/gcc/gcc-${GCC_VERSION}/configure --prefix=${SOFTWARE_DIR}/Software/install/gcc/gcc-${GCC_VERSION}/ --disable-multilib && \
    make -j100 && \
    make install