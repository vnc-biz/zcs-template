
include $(TOPDIR)/common.mk

JAR_LIBRARY_FILES=$(addprefix lib/,$(JAR_FILES))

all:	install

install:
	@true
ifeq ($(INSTALL_USER),y)
	@mkdir -p $(IMAGE_ROOT)/$(ZIMLET_USER_JARDIR)
	@cp $(JAR_LIBRARY_FILES) $(IMAGE_ROOT)/$(ZIMLET_USER_JARDIR)
endif
ifeq ($(INSTALL_ADMIN),y)
	@mkdir -p $(IMAGE_ROOT)/$(ZIMLET_ADMIN_JARDIR)
	@cp $(JAR_LIBRARY_FILES) $(IMAGE_ROOT)/$(ZIMLET_ADMIN_JARDIR)
endif
ifeq ($(INSTALL_SERVICE),y)
	@mkdir -p $(IMAGE_ROOT)/$(ZIMLET_SERVICE_JARDIR)
	@cp $(JAR_LIBRARY_FILES) $(IMAGE_ROOT)/$(ZIMLET_SERVICE_JARDIR)
endif

clean:
	@rm -Rf \
		$(addprefix $(IMAGE_ROOT)/$(ZIMLET_SERVICE_JARDIR)/,$(JAR_FILES))	\
		$(addprefix $(IMAGE_ROOT)/$(ZIMLET_SERVICE_JARDIR)/,$(JAR_FILES))	\
		$(addprefix $(IMAGE_ROOT)/$(ZIMLET_ADMIN_JARDIR)/,$(JAR_FILES))		\
		$(addprefix $(IMAGE_ROOT)/$(ZIMLET_USER_JARDIR)/,$(JAR_FILES))
