#!/bin/bash

export DELPHIX_OUTPUT=/github/workspace/dxtoolkit2
mkdir $DELPHIX_OUTPUT

source scl_source enable rh-perl526 
cd /github/workspace/bin
pp -u -I /github/workspace/lib -M Text::CSV_PP -M List::MoreUtils::PP -M Crypt::Blowfish  \
      -F Crypto=dbutils\.pm$ -M Filter::Crypto::Decrypt -o $DELPHIX_OUTPUT/dxtoolkit `ls dx_*.pl | xargs`

for i in dx_*.pl ; do name=${i%.pl}; ln -s $DELPHIX_OUTPUT/dxtoolkit $DELPHIX_OUTPUT/$name; done

cd /github/workspace
tar czvf /github/workspace/dxtoolkit.tar.gz dxtoolkit2/

ls -l /github/workspace/

cp /github/workspace/dxtoolkit.tar.gz /github/home/
