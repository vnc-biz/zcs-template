
TOPDIR=.
include $(TOPDIR)/common.mk

all:	check-depend $(DEBIAN_PACKAGE)

prepare:
	@echo -n > $(TOPDIR)/zimlets.list

build-scripts:
	@mkdir -p $(INSTALL_DIR)
	@if [ -f scripts/mailboxd-db-schema.sql ] ; then cp scripts/mailboxd-db-schema.sql $(INSTALL_DIR) ; fi
	@if [ -f scripts/post-install.sh        ] ; then \
		cp scripts/post-install.sh $(INSTALL_DIR) && chmod +x $(INSTALL_DIR)/post-install.sh ; fi

build-zimlets:	prepare
	@$(MAKE) -C src all

$(DEBIAN_PACKAGE)::	$(DEBIAN_DIR)/control build-scripts build-zimlets
	@dpkg --build $(IMAGE_ROOT) .

$(DEBIAN_DIR)/control:	control.in
	@mkdir -p $(IMAGE_ROOT)/DEBIAN
ifeq ($(DEPENDS),)
	@cat $< | \
	    sed -E 's/@PACKAGE@/$(PACKAGE)/' | \
	    sed -E 's/@VERSION@/$(PACKAGING_VERSION)/' | \
	    sed -E 's/@MAINTAINER@/$(MAINTAINER)/' | \
	    sed -E 's/@SECTION@/$(SECTION)/' | \
	    sed -E 's/@ARCHITECTURE@/$(ARCHITECTURE)/' | \
	    sed -E 's/@PRIORITY@/$(PRIORITY)/' | \
	    sed -E 's/@DEPENDS@/$(DEPENDS)/' | \
	    sed -E 's/@DESCRIPTION@/$(DESCRIPTION)/' | \
	    grep -vE "^Depends: " > $@
else
	@cat $< | \
	    sed -E 's/@PACKAGE@/$(PACKAGE)/' | \
	    sed -E 's/@VERSION@/$(PACKAGING_VERSION)/' | \
	    sed -E 's/@MAINTAINER@/$(MAINTAINER)/' | \
	    sed -E 's/@SECTION@/$(SECTION)/' | \
	    sed -E 's/@ARCHITECTURE@/$(ARCHITECTURE)/' | \
	    sed -E 's/@PRIORITY@/$(PRIORITY)/' | \
	    sed -E 's/@DEPENDS@/$(DEPENDS)/' | \
	    sed -E 's/@DESCRIPTION@/$(DESCRIPTION)/' > $@
endif

clean:
	@$(MAKE) -C src clean
	@rm -Rf $(DISTPREFIX) $(IMAGE_ROOT) $(DEBIAN_PACKAGE) zimlets.list *.deb

upload:	all
	@if [ ! "$(REDMINE_UPLOAD_USER)" ];     then echo "REDMINE_UPLOAD_USER environment variable must be set"     ; exit 1 ; fi
	@if [ ! "$(REDMINE_UPLOAD_PASSWORD)" ]; then echo "REDMINE_UPLOAD_PASSWORD environment variable must be set" ; exit 1 ; fi
	@if [ ! "$(REDMINE_UPLOAD_URL)" ];      then echo "REDMINE_UPLOAD_URL variable must be set"                  ; exit 1 ; fi
	@if [ ! "$(REDMINE_UPLOAD_PROJECT)" ];  then echo "REDMINE_UPLOAD_PROJECT variable must be set"              ; exit 1 ; fi
	@zm_redmine_upload			\
		-f "$(DEBIAN_PACKAGE)"			\
		-l "$(REDMINE_UPLOAD_URL)"	\
		-u "$(REDMINE_UPLOAD_USER)"	\
		-w "$(REDMINE_UPLOAD_PASSWORD)"	\
		-p "$(REDMINE_UPLOAD_PROJECT)"	\
		-d "$(DEBIAN_PACKAGE)"

check-depend:
	@zmpkg check-installed "$(DEPENDS)"

check_version:
	@echo "$(PACKAGING_VERSION)"
