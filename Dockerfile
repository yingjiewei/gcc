FROM centos:centos7.9.2009

RUN yum install sudo wget gcc gcc-c++ \
                gmp-devel mpfr-devel  \
                libmpc-devel make file -y && \
                yum -y clean all