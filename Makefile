
TOPDIR=.
include $(TOPDIR)/conf.mk

DEBDIR=$(IMAGE_ROOT)/DEBIAN
DEBFILE=$(PACKAGE)_$(VERSION)_$(ARCHITECTURE).deb

all:	$(DEBFILE)

prepare:
	@echo -n > $(TOPDIR)/zimlets.list

build-zimlets:	prepare
	@$(MAKE) -C src all

$(DEBFILE)::	$(DEBDIR)/control build-zimlets
	@dpkg --build $(IMAGE_ROOT) .

$(DEBDIR)/control:	control.in
	@mkdir -p $(IMAGE_ROOT)/DEBIAN
	@cat $< | \
	    sed -E 's/@PACKAGE@/$(PACKAGE)/' | \
	    sed -E 's/@VERSION@/$(VERSION)/' | \
	    sed -E 's/@MAINTAINER@/$(MAINTAINER)/' | \
	    sed -E 's/@SECTION@/$(SECTION)/' | \
	    sed -E 's/@ARCHITECTURE@/$(ARCHITECTURE)/' | \
	    sed -E 's/@PRIORITY@/$(PRIORITY)/' | \
	    sed -E 's/@DEPENDS@/$(DEPENDS)/' | \
	    sed -E 's/@DESCRIPTION@/$(DESCRIPTION)/' | \
	    grep -vE "^Depends: __NONE__" > $@

clean:
	@$(MAKE) -C src clean
	@rm -Rf $(DISTPREFIX) $(IMAGE_ROOT) $(DEBFILE) zimlets.list
