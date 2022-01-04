# You really don't want to do this
Seriously. Don't.

# Pretty sure I do
Really, you don't, so don't say I didn't warn you. This system is designed to
install FreeSWITCH and it's dependencies into a brand new, completely _clean_
computer, be it virtualized or not.

If you use this on your daily driver, you're probably going to break something.
I've made it as safe as I can, but who knows what I missed. That being said,
I run it on my daily driver during development.

# If you're really determined to have a bad day
Run `make externalize`. I developed this for my own use, so instead of
pulling resources from the internet, it assumes they are already present in a
defined hierarchy on my local system. The `externalize` target rewrites the
paths to operate with remote resources.

After that, edit `./shlib/config.sh`. You may want to change `IPREFIX`.
Right now, it's set to install everything to `/opt`, which doesn't even exist
by default on OpenBSD. Most everything else should probably be left alone, but
if you want to use egcc or clang, or for really masochistic purposes, base gcc,
you can change `CC` and `CXX`. Leave `MAKE` alone, we need GNU Make for this.

In theory, this system only works on OpenBSD. I think if you install `sndiod(8)`
on Linux, it might work. Feel free to try, however it won't install any of the
dependencies from packages you need, since it's calling `pkg_add` directly, not
using any kind of fancy detection.

# TODO
1. Right now, it doesn't actually use `pkg_add` to install any dependencies.
2. I'd like for it to generate a filesystem image using
[resflash](https://gitlab.com/bconway/resflash).
3. It would probably be nice if it installed FusionPBX as well, setting up
   `httpd(8)` and `php-fpm` while it's at it.

# License
Individual files in this project contain their license, with the exception of
patch files. Those are under whatever license the code they apply to requires,
or if it can be applied without conflict, the ISC license which is stated below.

Rights to `patches/patch-speex_src-speexdec_c` are held by the OpenBSD ports
maintainers. It's original filename in `cvs` is
`ports/audio/speex/patches/patch-src_speexdec_c`.

I make no claim to any of the third party code that is utilized by this project.
If you have questions about those licenses, please consult the appropriate
codebase.

## ISC License
```
  Copyright (c) 2022 B. Atticus Grobe (grobe0ba@gmail.com)

  Permission to use, copy, modify, and distribute this software for any
  purpose with or without fee is hereby granted, provided that the above
  copyright notice and this permission notice appear in all copies.

  THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
  WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
  MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
  ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
  WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
  ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
  OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
```

