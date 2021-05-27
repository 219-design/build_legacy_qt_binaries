#!/bin/bash

set -Eeuxo pipefail # https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/

# Tested on Ubuntu 18.04 as of May 2021.

echo "Reading first argument. Directory into which to download the Qt framework."
WORK_DIR=$1
shift 1

echo "Reading second argument. Installation directory."
INSTALL_PREFIX_DIR=$1
shift 1


pushd ${WORK_DIR}/

if [ -f ${WORK_DIR}/qt-x11-opensource-src-4.4.3.tar.gz ]; then
  echo "Qt sources were already downloaded. Will NOT download again."
else
  wget https://download.qt.io/archive/qt/4.4/qt-x11-opensource-src-4.4.3.tar.gz
fi

if [ -d ${WORK_DIR}/qt-x11-opensource-src-4.4.3/ ]; then
  echo "Qt sources were already extracted. Will NOT extract again."
else
  tar xvfz qt-x11-opensource-src-4.4.3.tar.gz
fi

mkdir -p ${WORK_DIR}/build
pushd build/

  export CFLAGS=-std=c99 CXXFLAGS=-std=gnu++98

  # echo 'yes' to accept license agreement
  echo yes | ../qt-x11-opensource-src-4.4.3/configure \
      -prefix ${INSTALL_PREFIX_DIR} \
      -qt-zlib \
      -qt-gif \
      -qt-libtiff \
      -qt-libpng \
      -qt-libjpeg \
      -no-openssl \
      -no-cups \
      -no-sql-odbc \
      -no-sql-mysql \
      -no-sql-sqlite \
      -no-sql-ibase \
      -no-sql-psql \
      -no-sql-sqlite \
      -no-sql-sqlite2 \
      -no-qt3support \
      -no-webkit \
      -no-assistant-webkit \
      -nomake tools \
      -nomake examples \
      -nomake demos \
      -nomake docs \
      -nomake translations

  make -j6
  make install

popd # corresponds to: pushd build/

popd # corresponds to: pushd ${WORK_DIR}/
