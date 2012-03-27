
TOPDIR=.
include $(TOPDIR)/conf.mk

all:
	@$(MAKE) -C scripts all
	@$(MAKE) -C zimlets all
	@tar -czf $(DISTFILE) -C $(DISTPREFIX) .

clean:
	@$(MAKE) -C scripts clean
	@$(MAKE) -C zimlets clean
	@rm -Rf $(DISTPREFIX)
