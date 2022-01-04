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
  echo "Usage: ${0} <checkout directory>" 1>&2
  exit 1
fi

mkcd "${1}"

git clone --depth 1 -b v1.10.7 "${FREESWITCH_URL}" ||
  error "could not clone freeswitch"
git clone --depth 1 "${SPANDSP_URL}" || error "could not clone spandsp"
git clone --depth 1 "${SOFIA_URL}" || error "could not clone sofia-sip"
git clone --depth 1 "${LDNS_URL}" || error "could not clone ldns"
git clone --depth 1 -b Speex-1.2.0 "${SPEEX_URL}" || error "could not clone speex"
git clone --depth 1 -b SpeexDSP-1.2.0 "${SPEEXDSP_URL}" || error "could not clone speexdsp"
git clone --depth 1 -b v1.3.1 "${OPUS_URL}" || error "could not clone opus"
git clone --depth 1 -b v0.2.1 "${OPUSENC_URL}" || error "could not clone libopusenc"
git clone --depth 1 -b 1.3.3 "${FLAC_URL}" || error "could not clone flac"
git clone --depth 1 -b v1.3.5 "${OGG_URL}" || error "could not clone ogg"

find . -maxdepth 1 -type d -not -name . -not -name .. | while read -r i; do
  (
    ecd "${i}"
    find "${ROOT}/patches" -name "patch-$(basename "${i}")_*" -exec patch -p1 -i {} \;
  ) || exit ${?}
done
