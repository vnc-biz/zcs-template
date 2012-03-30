
include $(TOPDIR)/conf.mk

COMPILE_JSP?=$(TOPDIR)/compile-jsp
ZIMLET_VERSION=$(VERSION)$(VERSION_SUFFIX)
ZIMLET_ZIP=$(IMAGE_ROOT)/zimlets-install/$(PACKAGE)-$(VERSION)/$(ZIMLET_NAME).zip

JSP_CLASSPATH=`echo "$(JSP_BUILD_JARS)" | tr ' ' ':'`

all:	build

build:  jsp $(ZIMLET_ZIP)

clean:
	@rm -Rf $(ZIMLET_ZIP) tmp _jspc_tmp
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
	@echo "$(ZIMLET_NAME).zip" >> $(TOPDIR)/zimlets.list

jsp:
	@for i in `find -name "*.jsp"` ; do JSP_CLASSPATH="$(JSP_CLASSPATH)" $(COMPILE_JSP) $$i ; done
