
include $(TOPDIR)/conf.mk

ZIMLET_USER_JARDIR=mailboxd/webapps/zimbra/WEB-INF/lib
ZIMLET_ADMIN_JARDIR=mailboxd/webapps/zimbraAdmin/WEB-INF/lib
ZIMLET_SERVICE_JARDIR=mailboxd/webapps/service/WEB-INF/lib

JAR_LIBRARY_FILES=$(addprefix lib/,$(JAR_FILES))

#all:
#	@echo "$(JAR_LIBRARY_FILES)"

#all:	build

all:	install_user install_admin install_service

ifeq ($(INSTALL_USER),y)
install_user:
	@mkdir -p $(IMAGE_ROOT)/$(ZIMLET_USER_JARDIR)
	@cp $(JAR_LIBRARY_FILES) $(IMAGE_ROOT)/$(ZIMLET_USER_JARDIR)
else
install_user:
	@echo -n
endif

ifeq ($(INSTALL_ADMIN),y)
install_admin:
	@mkdir -p $(IMAGE_ROOT)/$(ZIMLET_ADMIN_JARDIR)
	@cp $(JAR_LIBRARY_FILES) $(IMAGE_ROOT)/$(ZIMLET_ADMIN_JARDIR)
else
install_admin:
	@echo -n
endif

ifeq ($(INSTALL_SERVICE),y)
install_service:
	@mkdir -p $(IMAGE_ROOT)/$(ZIMLET_SERVICE_JARDIR)
	@cp $(JAR_LIBRARY_FILES) $(IMAGE_ROOT)/$(ZIMLET_SERVICE_JARDIR)
else
install_service:
	@echo -n
endif

clean:
	@rm -Rf \
		$(addprefix $(IMAGE_ROOT)/$(ZIMLET_SERVICE_JARDIR)/,$(JAR_FILES))	\
		$(addprefix $(IMAGE_ROOT)/$(ZIMLET_SERVICE_JARDIR)/,$(JAR_FILES))	\
		$(addprefix $(IMAGE_ROOT)/$(ZIMLET_ADMIN_JARDIR)/,$(JAR_FILES))		\
		$(addprefix $(IMAGE_ROOT)/$(ZIMLET_USER_JARDIR)/,$(JAR_FILES))
