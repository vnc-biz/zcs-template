
include $(TOPDIR)/common.mk

LYX_FILE_NAME=$(DOCUMENT_NAME).lyx
PDF_FILE_NAME=$(DOCUMENT_NAME).pdf
TEX_FILE_NAME=$(DOCUMENT_NAME).tex
LOG_FILE_NAME=$(DOCUMENT_NAME).log
AUX_FILE_NAME=$(DOCUMENT_NAME).aux
OUT_FILE_NAME=$(DOCUMENT_NAME).out

all:	install

build:	$(PDF_FILE_NAME)

install:	build
	@mkdir -p $(IMAGE_ROOT)/$(ZIMLET_DOC_DIR)
	@cp $(PDF_FILE_NAME) $(IMAGE_ROOT)/$(ZIMLET_DOC_DIR)

clean:
	@[ -f $(LYX_FILE_NAME) ] && rm -f $(TEX_FILE_NAME)
	@rm -Rf \
		$(IMAGE_ROOT)/$(PDF_FILE_NAME)	\
		$(PDF_FILE_NAME)		\
		$(LOG_FILE_NAME)		\
		$(AUX_FILE_NAME)		\
		$(OUT_FILE_NAME)		\
		$(EXTRA_CLEAN_FILES)

$(PDF_FILE_NAME):
	@[ -f $(LYX_FILE_NAME) ] && lyx --export latex $(LYX_FILE_NAME)
	@pdflatex $(DOCUMENT_NAME).tex

.PHONY: all build install clean
