#!/bin/bash

# TODO: replace encryption key 

export DELPHIX_OUTPUT=/github/workspace/dxtoolkit2
export DXTOOLKIT_CONF=/github/workspace/test/dxtools.conf
mkdir $DELPHIX_OUTPUT

source scl_source enable rh-perl526 

echo "run tests"

cd /github/workspace/test
chmod +x ./runtest.sh
./runtest.sh

if [[ $? -ne 0 ]]; then
    exit 1;
fi


cd /github/workspace/bin
pp -u -I /github/workspace/lib -M Text::CSV_PP -M List::MoreUtils::PP -M Crypt::Blowfish  \
      -F Crypto=dbutils\.pm$ -M Filter::Crypto::Decrypt -o $DELPHIX_OUTPUT/dxtoolkit `ls dx_*.pl | xargs`

for i in dx_*.pl ; do name=${i%.pl}; ln -s $DELPHIX_OUTPUT/dxtoolkit $DELPHIX_OUTPUT/$name; done

cd /github/workspace
tar czvf /github/workspace/dxtoolkit.tar.gz dxtoolkit2/

echo ${HOME}

cp /github/workspace/dxtoolkit.tar.gz ${HOME}

ls -l ${HOME}
