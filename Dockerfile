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
    && cpanm JSON \
    && cpanm Date::Manip \
    && cpanm DateTime::Event::Cron::Quartz \
    && cpanm DateTime::Format::DateParse \
    && cpanm Crypt::CBC \
    && cpanm Crypt::Blowfish \
    && cpanm Text::CSV \
    && cpanm LWP::UserAgent \
    && cpanm Net::SSLeay \
    && cpanm IO::Socket::SSL \
    && cpanm LWP::Protocol::https \
    && cpanm Term::ReadKey \
    && cpanm Log::Syslog::Fast \
    && cpanm Filter::Crypto::Decrypt \
    && cpanm PAR::Packer \
    && cpanm List::MoreUtils::PP \
    && mkdir /app \
    && mkdir /out

ADD lib /app/lib
ADD bin /app/bin

WORKDIR /app/bin

RUN source scl_source enable rh-perl526  \
    && pp -u -I /app/lib/ -M Text::CSV_PP -M List::MoreUtils::PP -M Crypt::Blowfish  \
       -F Crypto=dbutils\.pm$ -M Filter::Crypto::Decrypt -o /out/dxtoolkit `ls dx_*.pl | xargs`
RUN source scl_source enable rh-perl526  \
    && for i in dx_*.pl ; do name=${i%.pl}; ln -s /out/dxtoolkit /out/$name; done
