# file: main/makefile
# Date:  2022/06/11
# Name:  YingChao

# source files
TEX_FILES=${wildcard *.tex}
XDV_FILES = $(ROOT_DIR)/$(BUILD_DIR)/${MAINDOC}.xdv

CURRENTDIR=$(shell pwd)


all:
	@echo "\033[33m $(shell pwd) \033[0m"
ifeq ($(precompiled), 1)
	@$(MAKE) xeINItex				# initialize
	@echo "\033[32m [MSG] 		Initialized \033[0m"
endif
	@$(MAKE) xetex					# 1st commpiling document
	@echo "\033[32m [MSG] 		1st compiled \033[0m"
	@$(MAKE) bibtex					# reference commpiling
	@echo "\033[32m [MSG] 		Reference compiled  \033[0m"
	@$(MAKE) xetex					# 2nd commpiling document
	@echo "\033[32m [MSG] 		2nd compiled \033[0m"
	@$(MAKE) xetex					# 3rd commpiling document 
	@echo "\033[32m [MSG] 		3rd compiled \033[0m"
	@$(MAKE) xDVIPDFMx				# Genrated PDF
	@echo "\033[32m [MSG] 		Successly compiled  \033[0m"

xetex:
	$(LATEX) $(TEX_Parameter) $(TEX_FILES)

bibtex:
	$(BIBTEX) $(ROOT_DIR)/$(BUILD_DIR)/$(MAINDOC)

xDVIPDFMx:
	@cd $(ROOT_DIR)/$(BUILD_DIR);\
	$(MAKEPDF) -vv $(xDVI_PDFMx) $(XDV_FILES)

xeINItex:
	$(LATEX) $(OUTP_DIR) -initialize -jobname="$(MAINDOC)" "&$(LATEX)" mylatexformat.ltx """$(MAINDOC).tex""" 

# https://ctan.math.utah.edu/ctan/tex-archive/macros/latex/contrib/mylatexformat/mylatexformat.pdf