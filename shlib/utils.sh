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

# printf an error to stdout and exit with retval = 1
error() {
  V1="${1}"
  shift
  printf "%s\n" "${@}" 1>&2
  exit 1
}

# create a directory if it does not exist, and change working dir
# error and exit on failure
mkcd() {
  mkdir -p "${1}" || error "Unable to create directory %s" "${1}"
  cd "${1}" || error "Unable to change to directory %s" "${1}"
}

ecd() {
  cd "${1}" || error "could not change directory to %s" "${1}"
}
