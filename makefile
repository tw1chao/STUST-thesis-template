# Title: Makefile
# Date:  2019/10/15
# Name:  YingChao

# target and root file name
TARGET = main

# Directories
BUILD_DIR = build

# commands to compile document
LATEX = xelatex

BIBTEX = biber

# commands parameter
TEX_Parameter = -halt-on-error -output-directory=$(BUILD_DIR)

# source files
# ISSC_LIN+CAN_Transceiver_Test_Report.tex
TEX_FILES = $(TARGET).tex

#文献データベース、あるならば.
# REF=Reference/reference.bib

all:
	@echo =============== make a directory ===============
	mkdir -p $(BUILD_DIR)
	@echo ========== first commpiling document ==========
	$(LATEX) $(TEX_Parameter) $(TEX_FILES)
	@echo ============= reference commpiling =============
	$(BIBTEX) $(BUILD_DIR)/$(TARGET)
	@echo ========== second commpiling document ==========
	$(LATEX) $(TEX_Parameter) $(TEX_FILES)
	@echo ============ move compiled document ============
	mv $(BUILD_DIR)/$(TARGET).pdf .

clean:
	rm -rf $(BUILD_DIR)

help:
	@echo "make pdf"
	@echo "        Make PDF file from DVI file."
	@echo
	@echo "make clean"
	@echo "        Clean build directory."


# https://mytexpert.osdn.jp/index.php?Makefile
