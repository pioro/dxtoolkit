#!/bin/bash

export DELPHIX_OUTPUT=/github/workspace/dxtoolkit2
mkdir $DELPHIX_OUTPUT

cd /github/workspace/lib
mv dbutils.pm dbutils.orig.pm
cat dbutils.orig.pm | sed -e "s/put your encryption key here/${INPUT_ENCKEY}/" > dbutils.pm
ls -l dbutils*

cd /github/workspace/bin
pp -u -I /github/workspace/lib -l /usr/lib/x86_64-linux-gnu/libcrypto.so.1.1 -l /usr/lib/x86_64-linux-gnu/libssl.so.1.1 -M Text::CSV_PP -M List::MoreUtils::PP -M Crypt::Blowfish  \
      -F Crypto=dbutils\.pm$ -M Filter::Crypto::Decrypt -o $DELPHIX_OUTPUT/runner `ls dx_*.pl | xargs`

cd $DELPHIX_OUTPUT
for i in /github/workspace/bin/dx_*.pl ; do name=`basename -s .pl $i`; ln -s runner $name; done

cd /github/workspace
tar czvf /github/workspace/dxtoolkit.tar.gz dxtoolkit2/




