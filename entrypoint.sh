#!/bin/bash

mkdir /github/workspace/out

source scl_source enable rh-perl526 
cd /github/workspace/bin
pp -u -I /github/workspace/lib -M Text::CSV_PP -M List::MoreUtils::PP -M Crypt::Blowfish  \
       -F Crypto=dbutils\.pm$ -M Filter::Crypto::Decrypt -o /github/workspace/out/dxtoolkit `ls dx_*.pl | xargs`

for i in dx_*.pl ; do name=${i%.pl}; ln -s /github/workspace/out/dxtoolkit /github/workspace/out/$name; done

