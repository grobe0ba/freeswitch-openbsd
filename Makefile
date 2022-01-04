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

.PHONY: all clone build externalize check clean


all: image

image: .image

.image: build
	echo "unimplemented"
	touch .image

build: .build

.build: clone
	mkdir -p output
	./shlib/build.sh output
	#touch .build

clone: .clone

.clone:
	mkdir -p third_party
	./shlib/clone.sh third_party
	touch .clone

externalize:
	sed -i -E -e 's#file:///.*/git(hub|lab)\.com#https://git\1.com#' shlib/config.sh

clean:
	doas rm -rf output
	rm -f .image
	rm -f .build

deepclean: clean
	rm -rf third_party
	rm -f .clone

check:
	shellcheck -x shlib/clone.sh
	shellcheck -x shlib/build.sh
