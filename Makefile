
DISTDIR=dist

all:
	@$(MAKE) -C zimlets all

clean:
	@mkdir -p $(DISTDIR)
	@$(MAKE) -C zimlets clean
	@rm -Rf dist
