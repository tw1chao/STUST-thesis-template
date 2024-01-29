# file:  ./makefile
# Date:  2021/10/15
# Name:  YingChao


# 主要文件名稱 (不需加副檔名)
MAINDOC  = main

# 是否使用預編譯
precompiled = 0

# 編譯文件放置目錄檔案
BUILD_DIR = build

# 設定目標及根目錄
OUTPDF = main
TARGET = ${BUILD_DIR}/${OUTPDF}.xdv

# 讀取子目錄
SUBDIRS = $(shell ls -l | grep ^d | awk '{if($$9 == "$(MAINDOC)") print $$9}')
OUTDIRS = $(shell ls -l | grep ^d | awk '{if($$9 == "$(BUILD_DIR)") print $$9}')

# 讀取 pdf 以外的輸出文件
OUTFILE=$(shell ls -l $(OUTDIRS) | grep ^- | awk '{if($$9 != "$(MAINDOC).pdf") print $$9}')

# 記住當前根目錄路徑
ROOT_DIR=$(shell pwd)

# commands to compile document
MAKE	    = +make
LATEX       = xelatex
MAKEPDF	    = xdvipdfmx
BIBTEX	    = biber
GHOSTSCRIPT = ghostscript
xDVI_PDFMx  = -E -o $(OUTPDF).pdf

# commands parameter
FILESYNC = -synctex=1
FILE_ERR = -file-line-error
INTERACT = -interaction=nonstopmode  #batchmode
HALT_ERR = -halt-on-error
NONE_PDF = -no-pdf
OUTP_DIR = -output-directory=$(ROOT_DIR)/$(BUILD_DIR)
OUTP_DRV = -output-driver='xdvipdfmx -z0' # 此參數設定 PDF 壓縮等級

ifeq ($(precompiled), 1)
PRECOMPL = -shell-escape "&$(LATEX)"

TEX_Parameter = $(NONE_PDF) $(OUTP_DIR) $(OUTP_DRV) \
				$(HALT_ERR) $(PRECOMPL) 
else
TEX_Parameter = $(FILESYNC) $(FILE_ERR) $(INTERACT) \
				$(HALT_ERR) $(NONE_PDF) $(OUTP_DIR) \
				$(OUTP_DRV)
endif

# 宣告以下為廣域變數，使子目錄的 makefile 也能讀取以下變數
export MAINDOC ROOT_DIR BUILD_DIR OUTP_DIR
export LATEX BIBTEX TEX_Parameter precompiled
export MAKE MAKEPDF xDVI_PDFMx OUTPDF

NoPrintDir = --no-print-directory # make 不顯示進入/離開目錄訊息

all: ${TARGET}

${TARGET}:
	@echo "\033[33m make a directory \033[0m"
	@mkdir -p $(BUILD_DIR)
	@$(MAKE) -C $(SUBDIRS) $(NoPrintDir)

clean:
	@rm -rf $(OUTDIRS)

staypdf:
ifeq ($(strip $(OUTFILE)),)
	@echo "\033[1;31m [MSG] file already cleaned \033[0m"
else
	@echo "\033[1;31m [MSG] start clean file\033[0m"
	@cd $(OUTDIRS);\
	rm $(OUTFILE)
	@echo "\033[1;32m [MSG] Retain pdf , other file for deleting \033[0m"
endif


# https://www.internalpointers.com/post/compress-pdf-file-ghostscript-linux
# sudo apt install ghostscript

# 		-sOwnerPassword=mypassword \

compress:
	$(GHOSTSCRIPT) -sDEVICE=pdfwrite \
	-dCompatibilityLevel=1.4 \
	-dPDFSETTINGS=/printer \
	-dQUIET -dBATCH -dNOPAUSE	\
	-dEmbedAllFonts=false \
  	-dSubsetFonts=true \
  	-dConvertCMYKImagesToRGB=true \
  	-dCompressFonts=true \
	-sOutputFile=${BUILD_DIR}/$(MAINDOC)_out.pdf \
	${BUILD_DIR}/$(MAINDOC).pdf
	@echo -e "\033[32m [MSG] 		PDF Size is compressed\033[0m"	
	@cd $(BUILD_DIR);\
	rm -f *.xdv;\
	rm -f $(MAINDOC).pdf;\
	mv $(MAINDOC)_out.pdf $(MAINDOC).pdf


.PHONY: clean all
