TAG = 20141009
TARFILE = stage3-amd64-hardened-$(TAG).tar.bz2
MIRROR = http://distfiles.gentoo.org/releases/amd64/autobuilds/$(TAG)/hardened/
GPG_KEYRING = .gpg-keyring
GENTOO_GPG_KEYID = 2D182910
GPG_KEYSERVER = keys.gnupg.net

default: $(TARFILE) Dockerfile

FILES = $(TARFILE) $(TARFILE).DIGESTS $(TARFILE).DIGESTS.asc

$(addprefix dl/,$(FILES)): dl/%:
	wget --continue "$(MIRROR)/$*" -O $@

$(GPG_KEYRING)/trustdb.gpg:
	mkdir -p $(GPG_KEYRING)
	chmod 700 $(GPG_KEYRING)
	GNUPGHOME=$(GPG_KEYRING) gpg --keyserver $(GPG_KEYSERVER) --recv-key $(GENTOO_GPG_KEYID)

dl/%.gpg-ok: dl/%.asc dl/% $(GPG_KEYRING)/trustdb.gpg
	GNUPGHOME=$(GPG_KEYRING) gpg --verify "$<" && touch $@

dl/%.sha512sum-ok: dl/%.DIGESTS dl/%.DIGESTS.gpg-ok dl/%
	cd dl/ && head -n 2 $*.DIGESTS | sha512sum --check
	touch $@


%.tar.bz2: dl/%.tar.bz2 dl/%.tar.bz2.sha512sum-ok
	cp $< $@

Dockerfile: Dockerfile.in $(TARFILE)
	sed 's/@@TAG@@/$(TAG)/g' $< > $@

clean:
	rm -f dl/*.gpg-ok dl/*.sha512sum-ok

fullclean:
	rm -rf dl/* $(TARFILE)

.PHONY: clean fullclean default
