
[![](Figures/Logos/stustlargelogo.png "研究生學位考試專區")](https://academic.stust.edu.tw/tc/node/DegreeExam)
</br></br></br>

[![STUST-Thesis-Template](https://img.shields.io/static/v1?label=&message=STUST-Thesis-Template&color=gray&logo=Github)](https://github.com/tw1chao/STUST-thesis-template)
[![license - CC BY-SA 4.0](https://img.shields.io/static/v1?label=license&message=CC+BY-SA+4.0&color=2eacce)](https://creativecommons.org/licenses/by-sa/4.0/)
[![forks - STUST-thesis-template](https://img.shields.io/github/forks/tw1chao/STUST-thesis-template?style=social)](https://github.com/tw1chao/STUST-thesis-template/fork)
[![stars - STUST-thesis-template](https://img.shields.io/github/stars/tw1chao/STUST-thesis-template?style=social)](https://github.com/tw1chao/STUST-thesis-template/stargazers)



# STUST Thesis LaTeX

- 南臺科技大學 (南台科技大學)
- Southern Taiwan University of Science of Technology

## 前言

更多內容請見[編譯結果](./build/main.pdf)與內文。

> [!Important]
> 如果您發現這個板型有問題，請提交 Issues，也非常歡迎您提交 PR 協助修正問題。<br>
> 若有期望加入其他功能改善論文撰寫環境，也歡迎提交 Issues 許願！ <br>
> 歡迎各位先進、學長姊、學弟妹 Fork 本 Repo

### 說明
依照[南臺科技大學學位論文格式規範](https://academic.stust.edu.tw/tc/node/DegreeExam)之內容，
論文裝訂之內容及順序應依下列順序辦理：
- [X] 1. 封面
- [ ] 2. 博碩士論文延後公開申請書（視需要）
- [X] 3. 空白頁（封面與書名頁間加一空白頁）
- [X] 4. 書名頁
- [ ] 5. 論文口試委員審定書
- [X] 6. 摘要（中文及英文）
- [X] 7. 誌謝（視需要）
- [X] 8. 目次
- [X] 9. 表目錄
- [X] 10. 圖目錄
- [X] 11. 論文主體
- [X] 12. 參考文獻
- [ ] 13. 附錄及符號(公式)彙編（視需要）
- [X] 14. 作者簡介（視需要）

未勾選部分的第二項及第五項為論文提交時，學校才會提供文檔，屆時再自行匯入論文中合併。

### 目錄結構
* ***build*** : 編譯器產生出來的檔案
* ***Chapters*** : 論文章節本體
* ***Configurations*** : 設定檔案含版型
* ***Customization*** : 論文相關自定義檔
* ***Docker*** : Docker Script
* ***Exteranls*** : 外部匯入的PDF檔案
* ***Figures*** : 文中的所有圖片
* ***fonts*** : 本專案使用到的字體檔
* ***Instance*** : 封面/書名頁/摘要/誌謝/目錄/書脊
* ***main*** : 主要文件 main.tex
* ***Packages*** : 套件
* ***References*** : 參考文獻 bib 檔案

### 專案相關資訊
- [備註:自行補檔](./Externals/note.md)

## 開始使用本模版

![OS - Ubuntu](https://img.shields.io/badge/Ubuntu-white?logo=ubuntu&logoColor=orange)
![OS - Arch Linux](https://img.shields.io/badge/Arch_Linux-white?logo=archlinux&logoColor=blue)
![OS - Debian](https://img.shields.io/badge/Debian-white?logo=debian&logoColor=red)
![OS - MacOS](https://img.shields.io/badge/Apple_MacOS-white?logo=apple&logoColor=gray)
![OS - Windows](https://img.shields.io/badge/Windows_WSL-white?logo=data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAA4AAAAOCAMAAAAolt3jAAACLlBMVEUAAAAAddEBcsoCcMcBc84Ag+cAcMcDbcQBdM0Da8EBc8wEab4BcckEZ7oCb8YFZrgGZLUDbMEGYrMEasAGYbAHYK4EaLsIXqwFZrkJXKkGZbcBddAAdtIAdtIAdtEAdc8BdM0Bc8sBccoBddAAdtIAddIAccoBcMgCb8cAddECdc8DbcQCbcQAdM4Bc8wDar8Ca8EAcMsXesoWcL0AZ70Absgee8gdcbsAZLoAbMYdeMMcbrcAY7cAa8MddsEcbbQBYbUAacEedLwca68BYLMAasIVa64VYqIDYLIDar8EZLYGXKgGYLAEaLwDZbkHXKsIXq0EZ7oFZbcJXKkJXaoFZrgGZLUGYrMFYLADW6wIWqQIWaMFWKgIW6gKW6gKW6cJXKkAddAAdc4BdM0AcssUfM8NeMwAccoBcMkOdcgVd8dhpdvU5vW41e4pgsssg8q61u3T5PRfntPD1uWLiYe4trSBsNmEstq0srGNi4nA0+PBzto1NDN9e3qOttmRt9l3dnQ4Nza/zNnZ5vHj4uLr5Nu7rY68rY/q5Nvk4+PV4u7a5/P//v3zw3/1kw3zjArxvn/////W4+/a5u759/XhnVDfdgHZcADYllT6+PfW4urL0bj9/fzdv6TEdCq/cS3av6n+/vzHzLOGmXL/7rL29fTl3trl3tv29vT/7a+Ck24eaJuyp0f822P/6Zf82mKupEYeYpMEYbMYY5togF+gmj2gmT1mfl4ZXpYHWqhTxlzmAAAAYXRSTlMAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPcdX6+tNuDRCa+fiWDnn9/HQb1tIYPvXzOkn5+EVJ+fhFSfn4RUn5+EVJ+fhFSfn4RUn5+EVJ+fhFQPH8+/v7+/v7/O88rdBh/gAAAGBJREFUCNdjZGBglGKEgAf/GBgZGJUYGW2AnEOMjLf/MrGwsLE5sAKBCwsLMzsjhyqjLVTxXsabTEBpDihgYWEiwP2JzGVk4sKr+AeqYm4Ilx0IoIpBTKhiRilrRgTYCQAQIg3hgfIyowAAAABJRU5ErkJggg==)

![Tool - Visual Studio Code](https://img.shields.io/badge/Visual_Studio_Code-white?style=plastic&logo=data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAA4AAAAOCAMAAAAolt3jAAAAtFBMVEUAAAAjqO4hm+4gpPEgpvEipvEiqPEkq/EkrfEAZ6wAaK0AaK4Aa64AbbAAbrIAb7EAcrQAdLYAdrgAeLkAersAeswAfLwAfL0AfM0Afc0Afs4Af84AgM4Agc8Ag9AAhNAAhtEAiNIAitMAjNQAj9UAkdYQhtwQiNwQit0TjNITjdMTkNQfnfAgn/AgoPEhovEhpPEipvEjp/IjqfIkq/IkrfIkrfMlrvMlr/MlsPMmsvMntPS9RnmCAAAACXRSTlMALC5wcHBwcHDwO4NxAAAAgUlEQVQIW0XOvQqCYBhA4eMH0VAiVOoQ/UC2dQfdP91AY1FL4GRL0OR7WpTO9mwHxuozkI2qKAsuI1dQFZA4AixVNVJjAwvVR/SRbnqYhXadoYm71ov+DaoJWnXJyGLSqvuBecT3qe62qhnzD7ABZtP/1TqLfApp4KsP9ToIKE/AD7D7SzO2kmGEAAAAAElFTkSuQmCC&logoColor=000&labelColor=EEE&color=CCC)
![Tool - CMake](https://img.shields.io/badge/CMake-white?style=plastic&logo=cmake&logoColor=000&labelColor=EEE&color=CCC)
![Tool - Make](https://img.shields.io/badge/Make-white?style=plastic&logo=gnu&logoColor=000&labelColor=EEE&color=CCC)
![Tool - latex](https://img.shields.io/badge/latex-white?style=plastic&logo=latex&logoColor=000&labelColor=EEE&color=CCC)
![Tool - Git](https://img.shields.io/badge/GIT-white?style=plastic&logo=git&logoColor=000&labelColor=EEE&color=CCC)



### [Visual Studio Code](https://code.visualstudio.com/)

> [!TIP]
> 極度推薦，非必要。 (也極度推薦 [vim](https://www.vim.org) **但入門門檻高**)

Visual Studio Code ，由 Microsoft 釋出的開源開發工具，可提供 SSH 遠端連線與 WSL 開發的功能，提供研究生可以連接上遠端進行論文撰寫的工作。
下面是我們撰寫論文時經常使用的模組。

- **LaTeX Workshop**，LaTeX 支援工具，提供編譯、預覽等功能的支援。
- **LaTeX language support**，LaTeX 語法支援工具，提供語法高亮。
- **vscode-pdf**，PDF 預覽工具。
- **Remote Development**，遠端開發工具包，安裝此套件將會自動安裝 SSH、WSL 等套件。
- **Live Share**，遠端協作工具，提供他人透過 VSCode 提供協助，內含同時編輯文件、操作終端機等功能。

```
### debian / ubuntu
$ sudo dpkg -i vscode.deb
```

#### 快捷鍵
|功能|按鍵|
|----|----|
|編譯 TEX|`Ctrl`+`Alt`+`B`|
|預覽 PDF|`Ctrl`+`Alt`+`V`|
|清除 OUTPUT 檔案|`Ctrl`+`Alt`+`C`|


### [CMake](https://cmake.org)

> [!TIP]
> 選擇 Docker ([Container](#containers)) 方案的使用者，本專案已在 Dockerfile 內建此工具，不需另外安裝。

[UseLATEX.cmake: LATEX Document Building Made Easy](https://public.kitware.com/Wiki/images/d/d7/UseLATEX)

```bash
$ mkdir -p build  # 先在目錄下新增 build 目錄
$ cd build        # 進入 build 目錄
$ cmake ..        # cmake 編譯
$ make            # 編譯此 latex 模版
$ make pdf-reduce # 減少 pdf 檔案大小
```

下列為安裝指令。

```
### debian / ubuntu
$ sudo apt install cmake
```


### [Make](https://www.gnu.org/software/make/)

> [!TIP]
> 選擇 Docker ([Container](#containers)) 方案的使用者，本專案已在 Dockerfile 內建此工具，不需另外安裝。

GNU 提供的工具，下列為安裝指令。

```
### debian / ubuntu
$ sudo apt install make
```

#### 命令

若只想使用 makefile 可以回到 commit id: [09a2869](https://github.com/yingchaotw/STUST-thesis-template/tree/09a2869e7d10eda6ce5bfbaa26507f3aef404338) 版本抓取 makefile.

|命令|功能描述|
|----|----|
|`make all`|編譯論文 PDF|
|`make clean`| 清除 build 目錄<br>包含編譯產生的 PDF 檔案|
|`make staypdf`| 不清除 PDF 檔案|
|`make compress`| 使用 gostscript 套件壓縮 PDF 檔案容量|


### [Texlive](https://tug.org/texlive/)

> [!TIP]
> 選擇 Docker ([Container](#containers)) 方案的使用者，本專案已在 Dockerfile 內建此工具，不需另外安裝。


**約 5.6 GB**</br>
LeTeX 文件編譯工具。
以下從台灣 [ctan](https://ctan.mirror.twds.com.tw/tex-archive/systems/texlive/Images/) 鏡像站下載 texlive 最新檔案，及安裝方式

```
### debian / ubuntu
$ wget https://ctan.mirror.twds.com.tw/tex-archive/systems/texlive/Images/texlive.iso .
$ mkdir ~/texlive_ISO
$ cd ~/texlive_ISO
$ sudo sh ./install.sh

### windows
掛載 iso 檔後進行安裝。
```

### [Containers](./docker/Readme.md)

> [!TIP]
> 如已有 xelatex 編譯環境的使用者，不須安裝此工具。
> Docker 與 Podman 擇一即可。

Docker 與 Podman 同為管理容器 (container) 的軟體，皆可以使用 [CMake](#cmake) 及 [Make](#make) 命令編譯此專案。

**約 4.71 GB**</br>

使用的 image 為 [alpine:latest](https://hub.docker.com/_/alpine/)，image
參考 docker/Readme.md 

### [Git](http://git-scm.com/)

> [!TIP]
> 極度推薦，非必要。

有無安裝 Git 並不影響您使用此模板，但極度推薦安裝這個工具。Git 是當前最主流的版本控制軟體，可以提供版本控制的功能，讓您能紀錄您再哪個時候修改了什麼，也能利用免費的遠端儲存庫(GitHub、GitLab、bitbucket)製作多個異地備份，保障您論文的安全。

Linux 發行版可透過套件管理工具快速安裝。

```
### debian / ubuntu
$ sudo apt install git-core
```

### [gostscript](https://www.ghostscript.com/)

> [!TIP]
> 選擇 Docker ([Container](#containers)) 方案的使用者，本專案已在 Dockerfile 內建此工具，不需另外安裝。
> 建議安裝，非必要。

為替 xelatex 編譯後所產生 PDF 檔案瘦身（降低檔案容量），能夠附於 Email 附件。

```
### debian / ubuntu
$ sudo apt install gostscript
```
