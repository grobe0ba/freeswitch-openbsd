#!/bin/ksh
# Copyright (c) 2022 B. Atticus Grobe (grobe0ba@gmail.com)
#
# Permission to use, copy, modify, and distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

. ./shlib/config.sh
. ./shlib/utils.sh

if [[ ${1} == "" ]]; then
  echo "Usage: ${0} <build directory>" 1>&2
  exit 1
fi

BUILDDIR="${ROOT}/${1}"

mkcd "${1}"

echo "Building in ${BUILDDIR}..." 1>&2

echo "Bootstrapping third party sources..." 1>&2
(
  ecd "${ROOT}/third_party/sofia-sip"
  if [[ ! -e configure ]]; then
    ./bootstrap.sh
  fi
) || exit ${?}
(
  ecd "${ROOT}/third_party/spandsp"
  if [[ ! -e configure ]]; then
    ./bootstrap.sh
  fi
) || exit ${?}
(
  ecd "${ROOT}/third_party/ldns"
  if [[ ! -e configure ]]; then
    libtoolize -c --install
    autoreconf -fi
  fi
) || exit ${?}
(
  ecd "${ROOT}/third_party/speex"
  if [[ ! -e configure ]]; then
    ./autogen.sh
  fi
) || exit ${?}
(
  ecd "${ROOT}/third_party/speexdsp"
  if [[ ! -e configure ]]; then
    ./autogen.sh
  fi
) || exit ${?}
(
  ecd "${ROOT}/third_party/opus"
  if [[ ! -e configure ]]; then
    ./autogen.sh
  fi
) || exit ${?}
(
  ecd "${ROOT}/third_party/libopusenc"
  if [[ ! -e configure ]]; then
    ./autogen.sh
  fi
) || exit ${?}
(
  ecd "${ROOT}/third_party/flac"
  if [[ ! -e configure ]]; then
    ./autogen.sh
  fi
) || exit ${?}
(
  ecd "${ROOT}/third_party/ogg"
  if [[ ! -e configure ]]; then
    ./autogen.sh
  fi
) || exit ${?}
(
  ecd "${ROOT}/third_party/freeswitch"
  if [[ ! -e configure ]]; then
    ./bootstrap.sh
  fi
) || exit ${?}

echo "Beginning build..." 1>&2
(
  mkcd sofia-sip
  if [[ ! -e Makefile ]]; then
    "${ROOT}/third_party/sofia-sip/configure" --prefix="${IPREFIX}" ||
      error "could not configure"
  fi
  if [[ ! -e .xbuildx ]]; then
    gmake -j "${MKJOBS}" || error "could not build sofia-sip"
    touch .xbuildx
  fi
  if [[ ! -e .xinstallx ]]; then
    doas gmake install || error "could not install sofia-sip"
    touch .xinstallx
  fi
) || exit ${?}

(
  mkcd spandsp
  if [[ ! -e Makefile ]]; then
    "${ROOT}/third_party/spandsp/configure" --prefix="${IPREFIX}" ||
      error "could not configure"
  fi
  if [[ ! -e .xbuildx ]]; then
    gmake -j "${MKJOBS}" || error "could not build spandsp"
    touch .xbuildx
  fi
  if [[ ! -e .xinstallx ]]; then
    doas gmake install || error "could not install spandsp"
    touch .xinstallx
  fi
) || exit ${?}

(
  mkcd ldns
  if [[ ! -e Makefile ]]; then
    "${ROOT}/third_party/ldns/configure" --prefix="${IPREFIX}" \
      --disable-dane-verify || error "could not configure"
  fi
  if [[ ! -e .xbuildx ]]; then
    gmake -j "${MKJOBS}" || error "could not build ldns"
    touch .xbuildx
  fi
  if [[ ! -e .xinstallx ]]; then
    doas gmake install || error "could not install ldns"
    touch .xinstallx
  fi
) || exit ${?}
(
  mkcd speex
  if [[ ! -e Makefile ]]; then
    env CPPFLAGS="-DUSE_SNDIO" LDFLAGS=-lsndio \
      "${ROOT}/third_party/speex/configure" --prefix="${IPREFIX}" ||
      error "could not configure speex"
  fi
  if [[ ! -e .xbuildx ]]; then
    gmake -j "${MKJOBS}" || error "could not build speex"
    touch .xbuildx
  fi
  if [[ ! -e .xinstallx ]]; then
    doas gmake install || error "could not install speex"
    touch .xinstallx
  fi
) || exit ${?}
(
  mkcd speexdsp
  if [[ ! -e Makefile ]]; then
    "${ROOT}/third_party/speexdsp/configure" --prefix="${IPREFIX}" ||
      error "could not configure"
  fi
  if [[ ! -e .xbuildx ]]; then
    gmake -j "${MKJOBS}" || error "could not build speexdsp"
    touch .xbuildx
  fi
  if [[ ! -e .xinstallx ]]; then
    doas gmake install || error "could not install speexdsp"
    touch .xinstallx
  fi
) || exit ${?}
(
  mkcd opus
  if [[ ! -e Makefile ]]; then
    "${ROOT}/third_party/opus/configure" --prefix="${IPREFIX}" ||
      error "could not configure opus"
  fi
  if [[ ! -e .xbuildx ]]; then
    gmake -j "${MKJOBS}" || error "could not build opus"
    touch .xbuildx
  fi
  sed -i -e 's/Version: unknown/Version: 1.3.1/' opus.pc
  if [[ ! -e .xinstallx ]]; then
    doas gmake install || error "could not install opus"
    touch .xinstallx
  fi
) || exit ${?}
(
  mkcd libopusenc
  if [[ ! -e Makefile ]]; then
    "${ROOT}/third_party/libopusenc/configure" --prefix="${IPREFIX}" ||
      error "could not configure libopusenc"
  fi
  if [[ ! -e .xbuildx ]]; then
    gmake -j "${MKJOBS}" || error "could not build libopusenc"
    touch .xbuildx
  fi
  if [[ ! -e .xinstallx ]]; then
    doas gmake install || error "could not install libopusenc"
    touch .xinstallx
  fi
) || exit ${?}
(
  mkcd flac
  if [[ ! -e Makefile ]]; then
    "${ROOT}/third_party/flac/configure" --prefix="${IPREFIX}" ||
      error "could not configure flac"
  fi
  if [[ ! -e .xbuildx ]]; then
    gmake -j "${MKJOBS}" || error "could not build flac"
    touch .xbuildx
  fi
  if [[ ! -e .xinstallx ]]; then
    doas gmake install || error "could not install flac"
    touch .xinstallx
  fi
) || exit ${?}
(
  mkcd ogg
  if [[ ! -e Makefile ]]; then
    "${ROOT}/third_party/ogg/configure" --prefix="${IPREFIX}" ||
      error "could not configure ogg"
  fi
  if [[ ! -e .xbuildx ]]; then
    gmake -j "${MKJOBS}" || error "could not build ogg"
    touch .xbuildx
  fi
  if [[ ! -e .xinstallx ]]; then
    doas gmake install || error "could not install ogg"
    touch .xinstallx
  fi
) || exit ${?}
(
  mkcd freeswitch
  if [[ ! -e Makefile ]]; then
    "${ROOT}/third_party/freeswitch/configure" --prefix="${IPREFIX}" ||
      error "could not configure freeswitch"
  fi
  if [[ ! -e .xbuildx ]]; then
    gmake -j "${MKJOBS}" || error "could not build freeswitch"
    touch .xbuildx
  fi
  if [[ ! -e .xinstallx ]]; then
    doas gmake install || error "could not install freeswitch"
    touch .xinstallx
  fi
) || exit ${?}

exit 0
