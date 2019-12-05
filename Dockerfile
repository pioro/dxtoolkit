FROM centos:7

RUN yum install -y centos-release-scl \
    && yum install -y rh-perl526 \
    && yum install -y rh-perl526-perl-JSON-PP.noarch \
    && yum install -y rh-perl526-perl-App-cpanminus.noarch \
    && yum install -y rh-perl526-perl-Try-Tiny.noarch \
    && yum install -y rh-perl526-perl-DateTime.x86_64 \
    && yum install -y openssl-devel.x86_64 \
    && yum install -y openssl \
    && yum install -y gcc \
    && source scl_source enable rh-perl526 \
    && mkdir /out

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
