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

if [[ "x$(uname -s)" != "xOpenBSD" ]]; then
  echo "This build systems works only on OpenBSD." 1>&2
  exit 1
fi

# URL to clone git repos from
FREESWITCH_URL=file:///home/grobe0ba/Projects/github.com/signalwire/freeswitch
SPANDSP_URL=file:///home/grobe0ba/Projects/github.com/freeswitch/spandsp
SOFIA_URL=file:///home/grobe0ba/Projects/github.com/freeswitch/sofia-sip
RESFLASH_URL=file:///home/grobe0ba/Projects/gitlab.com/bconway/resflash
LDNS_URL=file:///home/grobe0ba/Projects/github.com/NLnetLabs/ldns
SPEEX_URL=file:///home/grobe0ba/Projects/github.com/xiph/speex
SPEEXDSP_URL=file:///home/grobe0ba/Projects/github.com/xiph/speexdsp
OPUS_URL=file:///home/grobe0ba/Projects/github.com/xiph/opus
OPUSENC_URL=file:///home/grobe0ba/Projects/github.com/xiph/libopusenc
FLAC_URL=file:///home/grobe0ba/Projects/github.com/xiph/flac
OGG_URL=file:///home/grobe0ba/Projects/github.com/xiph/ogg

MKJOBS=$(sysctl hw.ncpu | cut -d= -f2)
MKJOBS=$((MKJOBS * 2))

IPREFIX=/opt

export PKG_CONFIG_PATH="${IPREFIX}/lib/pkgconfig"

SHLIB="$(readlink -f "$(dirname "${0}")")"
ROOT="$(dirname "${SHLIB}")"
REPOS="${ROOT}/repos"

export CC=cc
export CXX=c++
export MAKE=gmake
