TAG = 20141009
TARFILE = stage3-amd64-hardened-$(TAG).tar.bz2
MIRROR = http://distfiles.gentoo.org/releases/amd64/autobuilds/$(TAG)/hardened/

default: $(TARFILE)

FILES = $(TARFILE) $(TARFILE).DIGESTS $(TARFILE).DIGESTS.asc

$(addprefix dl/,$(FILES)): dl/%:
	wget --continue "$(MIRROR)/$*" -O $@

dl/%.gpg-ok: dl/%.asc dl/%
	gpg --verify "$<" && touch $@

dl/%.sha512sum-ok: dl/%.DIGESTS dl/%.DIGESTS.gpg-ok dl/%
	cd dl/ && head -n 2 $*.DIGESTS | sha512sum --check
	touch $@


%.tar.bz2: dl/%.tar.bz2 dl/%.tar.bz2.sha512sum-ok
	cp $< $@

clean:
	rm -f dl/*.gpg-ok dl/*.sha512sum-ok

fullclean:
	rm -rf dl/* $(TARFILE)

.PHONY: clean fullclean default
