
include ../../conf.mk

ZIMLET_NAME=biz_vnc_template

DISTDIR=../../dist/zimlet
ZIMLET_VERSION=$(VERSION)$(VERSION_SUFFIX)
ZIMLET_ZIP=$(DISTDIR)/$(ZIMLET_NAME).zip

all:	build

build:  $(ZIMLET_ZIP)

clean:
	@rm -Rf $(ZIMLET_ZIP) tmp
	@rmdir `dirname "$(ZIMLET_ZIP)"` 2>/dev/null || true

$(ZIMLET_ZIP):	src/*	src/$(ZIMLET_NAME).xml src/$(ZIMLET_NAME).properties src/$(ZIMLET_NAME)_de.properties
	@mkdir -p `dirname "$@"`
	@rm -Rf tmp
	@cp -R src tmp
	@cat src/$(ZIMLET_NAME).xml \
	    | sed -e "s~@ZIMLET_NAME@~$(ZIMLET_NAME)~g" \
	    | sed -e "s~@ZIMLET_VERSION@~$(ZIMLET_VERSION)~g" \
	    > tmp/$(ZIMLET_NAME).xml
	@zip -j $(ZIMLET_ZIP) tmp/*
	@rm -Rf tmp
