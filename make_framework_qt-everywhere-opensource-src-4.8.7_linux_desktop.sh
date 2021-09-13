#!/bin/bash

set -Eeuxo pipefail # https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/

# Tested on Ubuntu 18.04 as of Sept 2021.

echo "Reading first argument. Directory into which to download the Qt framework."
WORK_DIR=$1
shift 1

echo "Reading second argument. Installation directory."
INSTALL_PREFIX_DIR=$1
shift 1

THISDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"


pushd ${WORK_DIR}/

if [ -f ${WORK_DIR}/qt-everywhere-opensource-src-4.8.7.tar.gz ]; then
  echo "Qt sources were already downloaded. Will NOT download again."
else
  wget https://download.qt.io/archive/qt/4.8/4.8.7/qt-everywhere-opensource-src-4.8.7.tar.gz
fi

if [ -d ${WORK_DIR}/qt-everywhere-opensource-src-4.8.7/ ]; then
  echo "Qt sources were already extracted. Will NOT extract again."
else
  tar xvfz qt-everywhere-opensource-src-4.8.7.tar.gz

  # This patch was needed for the armv5tejl_sbc6000x legacy platform,
  # so we use it on the desktop just to foster consistency:
  patch ${WORK_DIR}/qt-everywhere-opensource-src-4.8.7/src/corelib/thread/qthread_unix.cpp "${THISDIR}"/no_thread_tls.patch
fi

mkdir -p ${WORK_DIR}/build
pushd build/

  export CFLAGS=-std=c99 CXXFLAGS=-std=gnu++98

  # print 'o' to accept open source license agreement
  printf 'o\nyes\n' | ../qt-everywhere-opensource-src-4.8.7/configure \
      -prefix ${INSTALL_PREFIX_DIR} \
      -qt-libjpeg \
      -qt-libpng \
      -qt-libtiff \
      -qt-zlib \
      -no-cups \
      -no-icu \
      -no-pch \
      -no-declarative \
      -no-declarative-debug \
      -no-freetype \
      -no-javascript-jit \
      -no-openssl \
      -no-script \
      -no-scripttools \
      -no-sql-ibase \
      -no-sql-mysql \
      -no-sql-odbc \
      -no-sql-psql \
      -no-sql-sqlite \
      -no-sql-sqlite2 \
      -no-qt3support \
      -no-webkit \
      -nomake tools \
      -nomake examples \
      -nomake demos \
      -nomake docs \
      -nomake translations

  make -j6
  make install

popd # corresponds to: pushd build/

popd # corresponds to: pushd ${WORK_DIR}/
