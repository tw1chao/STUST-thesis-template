%----------------------------------------------------------------------------------------
% STUST MEng. Thesis
% Original authors : AIoRLab/NCLab/WNDCLab Thesis LaTeX Team
% Department of Electronic Engineering
% National Souther Taiwan of Sciences and Technology
% GitHub : https://github.com/yingchao-chen/STUST-thesis-template
% Version 1.01 (2020.03.14)
%----------------------------------------------------------------------

%----------------------------------------------------------------------
%	CLASS DEFINITION AND PARAMETERS
%----------------------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}[2018-12-01]
\ProvidesClass{../config/STUST-MS-Thesis}[2020/02/03 v1.0 LaTeX document class]
\providecommand{\baseclass}{book}
\input{../config/Config}

\RequirePackage{etoolbox}
\RequirePackage{xparse}
\newbool{nolistspace}
\newbool{listtoc}
\newbool{toctoc}
\newbool{parskip}

\DeclareOption{nolistspacing}{\booltrue{nolistspace}}
\DeclareOption{liststotoc}{\booltrue{listtoc}}
\DeclareOption{toctotoc}{\booltrue{toctoc}}
\DeclareOption{parskip}{\booltrue{parskip}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{\baseclass}}

\ProcessOptions\relax

\LoadClass{\baseclass}

%----------------------------------------------------------------------
%	CLASS OPTIONS
%----------------------------------------------------------------------

\ifbool{parskip}{\RequirePackage{parskip}} % If the parskip option is passed to the class, require the parskip package

\patchcmd{\@makechapterhead}{\vspace*{50\p@}}{\abovechapterspace}{}{}
\patchcmd{\@makeschapterhead}{\vspace*{50\p@}}{\abovechapterspace}{}{}
\newcommand{\abovechapterspace}{\vspace*{50pt}}

\ifbool{listtoc}{% If the liststotoc option has been passed to the class, add the lists to the table of contents
	\patchcmd{\listoftables}{\@starttoc{lot}}{%
		\addchaptertocentry{\listtablename}\@starttoc{lot}}{}{}%
	\patchcmd{\listoffigures}{\@starttoc{lof}}{%
		\addchaptertocentry{\listfigurename}\@starttoc{lof}}{}{}%
}

\ifbool{toctoc}{% If the toctotoc options has been passed to the class, add the table of contents to the table of contents
	\patchcmd{\tableofcontents}{\@starttoc{toc}}{%
		\addchaptertocentry{\contentsname}\@starttoc{toc}}{}{}%

}



\patchcmd{\tableofcontents}{\MakeUppercase}{\MakeMarkcase}{}{}
\patchcmd{\tableofcontents}{\MakeUppercase}{\MakeMarkcase}{}{}
\patchcmd{\listoffigures}{\MakeUppercase}{\MakeMarkcase}{}{}
\patchcmd{\listoffigures}{\MakeUppercase}{\MakeMarkcase}{}{}
\patchcmd{\listoftables}{\MakeUppercase}{\MakeMarkcase}{}{}
\patchcmd{\listoftables}{\MakeUppercase}{\MakeMarkcase}{}{}

% If the option `nolistspacing' is given, the spacing in the different lists is reduced to single spacing. This option is only useful, if the spacing of the document has been changed to onehalfspacing or doublespacing.
\ifbool{nolistspace}{
	\patchcmd{\listoffigures}{%
		\@starttoc{lof}}{%
			\begingroup%
			\singlespace\@starttoc{lof}\endgroup%
		}{}{}%
	\patchcmd{\listoftables}{%
		\@starttoc{lot}}{%
			\begingroup%
			\singlespace\@starttoc{lot}\endgroup%
		}{}{}%
	\patchcmd{\tableofcontents}{%
		\@starttoc{toc}}{%
			\begingroup%
			\singlespace\@starttoc{toc}\endgroup%
		}{}{}%
}{}

% Addchap provides unnumbered chapters with an entry in the table of contents as well as an updated header
\ProvideDocumentCommand{\addchap}{ s o m }{%
	\chapter*{#3}%
	\markboth{}{}%
	\IfBooleanTF{#1}{%
	}{%
		\IfNoValueTF{#2}{%
			\addcontentsline{toc}{chapter}{#3}%
			\markboth{\MakeMarkcase{#3}}{}%
		}{%
			\addcontentsline{toc}{chapter}{#2}%
			\markboth{\MakeMarkcase{#2}}{}%
		}%
	}%
}%

\ProvideDocumentCommand{\addsec}{ s o m }{%
	\section*{#3}%
	\markright{}%
	\IfBooleanTF{#1}{%
	}{%
		\IfNoValueTF{#2}{%
			\addcontentsline{toc}{section}{#3}%
			\markright{\MakeMarkcase{#3}}%%
		}{%
			\addcontentsline{toc}{section}{#2}%
			\markright{\MakeMarkcase{#2}}%
		}%
	}%
}%



%----------------------------------------------------------------------
%	必要套件 REQUIRED PACKAGES
%----------------------------------------------------------------------

\usepackage{amscd}
\usepackage{amsmath} 
\usepackage{amssymb}
\usepackage{amsthm}
\usepackage{verbatim}
\usepackage[Lenny]{fncychap}

\usepackage[tight,TABTOPCAP]{subfigure}

\usepackage{algorithm}
\usepackage{algorithmicx}
\usepackage{algpseudocode}


\usepackage{subfigure}
\usepackage{moreverb}

\usepackage{xunicode}
\usepackage{mathptmx}

\newtheorem{definition}{Definition}
\newtheorem{problem}{Problem}

\newtheorem{theorem}{Theorem}[section]
\newtheorem{lemma}[theorem]{Lemma}
% \newtheorem{note}[theorem]{Note}
\newtheorem{note}{註：}
\newtheorem{corollary}[theorem]{Corollary}
\newtheorem{prop}[theorem]{Proposition}

\newtheorem{thm}{Theorem}%[section]
\newtheorem{lma}{Lemma}%[theorem]
\newtheorem{defi}{Definition}
\newtheorem{rul}{Rule}

\RequirePackage{scrbase} % Required for handling language-dependent names of sections/document elements
\RequirePackage{scrhack} % Loads fixes for various packages
\RequirePackage{setspace} % Required for changing line spacing
\RequirePackage{longtable} % Required for tables that span multiple pages (used in the symbols, abbreviations and physical constants pages)

\usepackage{siunitx} % Required for \SI commands
\usepackage{graphicx} % Required to include images
\graphicspath{{Figures/}{./}} % Specifies where to look for included images
\usepackage{booktabs} % Required for better table rules
% \RequirePackage[centerlast,small,sc]{caption} % Required for customising the captions
\usepackage[hang,small,bf]{caption}
\setlength{\captionmargin}{50pt}

%----------------------------------------------------------------------

\newcommand{\checktoopen}{% New command to move content to the next page which prints to the next odd page if twosided mode is active
\if@openright\cleardoublepage\else\clearpage\fi
}

\newcommand\bhrule{\typeout{------------------------------------------------}}
\newcommand\tttypeout[1]{\bhrule\typeout{\space #1}\bhrule}

\newcommand{\HRule}{\rule{\linewidth}{0.5mm}} % New command to make the lines in the title page
\newcommand{\decoRule}{\rule{.8\textwidth}{.4pt}} % New command for a rule to be used under figures

\renewcommand{\abovechapterspace}{\vspace*{10pt}} % Reduce the whitespace above a chapter heading

\setcounter{tocdepth}{3} % The depth to which the document sections are printed to the table of contents
\providecommand\addchaptertocentry[1]{%
\addcontentsline{toc}{chapter}{#1}}

%----------------------------------------------------------------------
%	邊界 MARGINS
%----------------------------------------------------------------------

\RequirePackage{geometry}
\geometry{
	paper=a4paper, % Default paper size, change to "letterpaper" for US Letter (you'll need to adjust margins after)
	includehead,
	includefoot,
	top=2.5cm, % Top margin
	bottom=2.75cm, % bottom margin
	left=3.5cm, % left margin
	right=2.5cm % right margin
		% inner=1.5in, % The inner margin (beside binding)
		% outer=1in, % The outer margin (opposite binding)
		% headheight=20pt, % Header height
		% headsep=.25in % Header separation
}

\raggedbottom

%----------------------------------------------------------------------
%	PENALTIES
%----------------------------------------------------------------------

\doublehyphendemerits=10000 % No consecutive line hyphens
\brokenpenalty=10000 % No broken words across columns/pages
\widowpenalty=9999 % Almost no widows at bottom of page
\clubpenalty=9999 % Almost no orphans at top of page
\interfootnotelinepenalty=9999 % Almost never break footnotes

%----------------------------------------------------------------------
%	HEADERS AND FOOTERS
%----------------------------------------------------------------------

\RequirePackage{fancyhdr} % Required to customise headers and footers
\providecommand{\MakeMarkcase}{} % Add \MakeUppercase to make header text all capitals
\fancyhead{} % Erase the default headers and footers style to replace with our own
\fancyfoot{} % Erase the default headers and footers style to replace with our own
\if@twoside % If we are in two sided mode, print alternating page headers
\fancypagestyle{thesis}{%
	\fancyhead[LE,RO]{\rmfamily\thepage}%
	%\fancyhead[RE,LO]{\slshape\MakeMarkcase{\rightmark}}%
	\fancyhead[RE,LO]{\bfseries\nouppercase{\rightmark}}%
}
\else % If we are in one sided, print the headers on the same positions on all pages
	\fancypagestyle{thesis}{%
	%\lhead{\slshape\MakeMarkcase{\rightmark}}% The left top header
    %\lhead{\bfseries\nouppercase{\rightmark}}% The left top header bold italic uppercase
	\rhead{\rmfamily\thepage}% The right top header
	% \fancyfoot[LO,CE]{\thepage} 
}
\fi
% \pagestyle{thesis}
\pagestyle{headings}


\renewcommand{\chaptermark}[1]{\tttypeout{\thechapter.\space #1}\markboth{\@chapapp\ \thechapter.\ #1}{\@chapapp\ \thechapter.\ #1}} % Define what is in the header and in what order
\renewcommand{\sectionmark}[1]{}
\renewcommand{\subsectionmark}[1]{}
\def\cleardoublepage{\clearpage\if@twoside \ifodd\c@page\else
\hbox{}
\thispagestyle{empty}
\newpage
\if@twocolumn\hbox{}\newpage\fi\fi\fi}

%----------------------------------------------------------------------
%	REFERENCING DOCUMENT ELEMENTS
%----------------------------------------------------------------------

\newcommand{\fref}[1]{\figurename~\ref{#1}}
\newcommand{\tref}[1]{\tablename~\ref{#1}}
\providecaptionname{german,ngerman,austrian,naustrian}{\equationnamenname}{Formel}
\providecaptionname{american,australian,british,canadian,english,newzealand,UKenglish,USenglish}{\equationnamenname}{Equation}
\newcommand{\eref}[1]{\equationname~\ref{#1}}
\newcommand{\cref}[1]{\chaptername~\ref{#1}}
\newcommand{\sref}[1]{\sectionname~\ref{#1}}
\providecaptionname{german,ngerman,austrian,naustrian}{\sectionname}{Abschnitt}
\providecaptionname{american,australian,british,canadian,english,newzealand,UKenglish,USenglish}{\sectionname}{Section}
\newcommand{\aref}[1]{\appendixname~\ref{#1}}

%----------------------------------------------------------------------
%	DECLARATION PAGE DESIGN
%----------------------------------------------------------------------


\providecaptionname{american,australian,british,canadian,english,newzealand,UKenglish,USenglish}{\authorshipname}{Declaration of Authorship} % Declaration of Authorship text for English countries
\providecaptionname{german,ngerman,austrian,naustrian}{\authorshipname}{Eidesstattliche Erkl\"arung} % Declaration of Authorship text for Germanic countries

\newenvironment{declaration}{

	\checktoopen
	\tttypeout{\authorshipname}
	\thispagestyle{plain}
	%\null\vfil
    \ifbool{listtoc}{\addchap{\authorshipname}}{\addchap*{\authorshipname}}
	%{\noindent\huge\bfseries\authorshipname\par\vspace{10pt}}
}{}

%----------------------------------------------------------------------------------------
%	DEDICATION PAGE DESIGN
%----------------------------------------------------------------------------------------

\newcommand\dedicatory[1]{
	\checktoopen
	\tttypeout{Dedicatory}
	\thispagestyle{plain}
	\null\vfil
	\begin{center}{\Large\slshape #1}\end{center}
	\vfil\null
}

%----------------------------------------------------------------------
%	英文摘要樣板
%----------------------------------------------------------------------

\providecaptionname{german,ngerman,austrian,naustrian}{\byname}{von}
\providecaptionname{american,australian,british,canadian,english,newzealand,UKenglish,USenglish}{\byname}{}
\newenvironment{engabstract}{
	\checktoopen
	\tttypeout{\abstractname}

	\begin{center}
	\vspace*{1.0em}
	{\huge \bfseries \titleen \par} % Thesis title
	\vspace*{1.0em}
	{\huge \textbf{\abstractname} \par}
	\bigskip
	% %{\normalsize \facname \par} % Faculty name
	\end{center}
}
{
  \vfil\vfil\vfil\null
}

%----------------------------------------------------------------------
%	中文摘要樣板
%----------------------------------------------------------------------

\providecaptionname{german,ngerman,austrian,naustrian}{\byname}{von}
\providecaptionname{american,australian,british,canadian,english,newzealand,UKenglish,USenglish}{\byname}{}
\newenvironment{cntabstract}{
	\checktoopen
	\tttypeout{\abstractname}

	% \null\vfil
	\begin{center}
	\vspace*{8mm}
	{\huge\textbf{\abstractname} \par}
	\bigskip
	\end{center}
}
{
  \vfil\vfil\vfil\null
}

%----------------------------------------------------------------------
%	PUBLICATION DESIGN
%----------------------------------------------------------------------

\providecaptionname{american,australian,british,canadian,english,newzealand,UKenglish,USenglish}{\publicationname}{Publications} % Declaration of Authorship text for English countries
\providecaptionname{german,ngerman,austrian,naustrian}{\publicationname}{Eidesstattliche Erkl\"arung} % Declaration of Authorship text for Germanic countries

\newenvironment{publication}{

	\checktoopen
	\tttypeout{\publicationname}
	\thispagestyle{plain}
    %\null\vfil
    \ifbool{listtoc}{\addchap{\publicationname}}{\addchap*{\publicationname}}
	
}{}




%----------------------------------------------------------------------
%	ABBREVIATIONS PAGE DESIGN
%----------------------------------------------------------------------

\providecaptionname{english,british,american}{\abbrevname}{List of Abbreviations}
\providecaptionname{ngerman,german,austrian,naustrian}{\abbrevname}{Abk\"urzungsverzeichnis}
\NewDocumentEnvironment{abbreviations}{ m }{%
	\ifbool{nolistspace}{\begingroup\singlespacing}{}
	\ifbool{listtoc}{\addchap{\abbrevname}}{\addchap*{\abbrevname}}
	\begin{longtable}{#1}
}{%
\end{longtable}
\ifbool{nolistspace}{\endgroup}{}
}

%----------------------------------------------------------------------
%	PHYSICAL CONSTANTS PAGE DESIGN
%----------------------------------------------------------------------

\providecaptionname{english,british,american}{\constantsname}{Physical Constants}
\providecaptionname{ngerman,german,austrian,naustrian}{\constantsname}{Physikalische Konstanten}

%----------------------------------------------------------------------
%	SYMBOLS PAGE DESIGN
%----------------------------------------------------------------------

\providecaptionname{english,british,american}{\symbolsname}{List of Symbols}
\providecaptionname{ngerman,german,austrian,naustrian}{\symbolsname}{Symbolverzeichnis}

\NewDocumentEnvironment{symbols}{ m }{%
	\ifbool{nolistspace}{\begingroup\singlespacing}{}
	\ifbool{listtoc}{\addchap{\symbolsname}}{\addchap*{\symbolsname}}
	\begin{longtable}{#1}
}{%
\end{longtable}
\ifbool{nolistspace}{\endgroup}{}
}

%----------------------------------------------------------------------
%	ACKNOWLEDGEMENTS PAGE DESIGN
%----------------------------------------------------------------------

\providecaptionname{american,australian,british,canadian,english,newzealand,UKenglish,USenglish} {\acknowledgementname}{Acknowledgements} % Acknowledgement text for English countries
\providecaptionname{german,ngerman,austrian,naustrian}{\acknowledgementname}{Danksagung} % Acknowledgement text for Germanic countries

\NewDocumentEnvironment{acknowledgements}{}{%
\checktoopen
\tttypeout{\acknowledgementname}
\thispagestyle{plain}
\vspace*{8mm}
\begin{center}{\huge\textbf{\acknowledgementname}\par}\end{center}
\bigskip
\vspace{11mm}
}
{
\vfil\vfil\null
}

%----------------------------------------------------------------------
%	REFERENCE DESIGN
%----------------------------------------------------------------------

\providecaptionname{english,british,american}{\referencename}{References}
\providecaptionname{ngerman,german,austrian,naustrian}{\referencename}{Abk\"References}
\NewDocumentEnvironment{References}{ m }{%
	\ifbool{nolistspace}{\begingroup\singlespacing}{}
	\ifbool{listtoc}{\addchap{\referencename}}{\addchap*{\referencename}}
	\begin{longtable}{#1}
}{%
\end{longtable}
\ifbool{nolistspace}{\endgroup}{}
}

%----------------------------------------------------------------------
%	增加校徽浮水印
%----------------------------------------------------------------------

% https://www.aq-test.com/latex/texmf-dist/doc/latex/draftwatermark/draftwatermark.pdf
\usepackage{draftwatermark}
\SetWatermarkText{}					% 清除預設 draft 字樣

\newcommand\STUSTwatermark {
	\SetWatermarkText{\includegraphics[width=6.8cm]{\watermarkimage}}
	\SetWatermarkLightness{0.9}		% 亮度
	\SetWatermarkAngle{0}			% 角度; 預設為 45 度
	\SetWatermarkScale{1.0} 		% 縮放比例, 預設 1.2 倍
	\SetWatermarkHorCenter{174mm}	% 橫向位置, A4 紙張尺寸 210mm 寬
	\SetWatermarkVerCenter{260mm}	% 縱向位置, A4 紙張尺寸 297mm 高
}

%----------------------------------------------------------------------
% 更變章節目錄的套件
%----------------------------------------------------------------------
\usepackage{titlesec, titletoc}
\titlecontents{chapter}[0em]{}
{\hspace{0em}\makebox[4.1em][l]
	{第\zhnumber{\thecontentslabel}章}}{}
{\titlerule*[0.7pc]{.}\contentspage}

\titleformat{\chapter}{\centering\Huge\bfseries}{Chapter\,{\thechapter}}{1em}{}
\titleformat{\chapter}{\centering\Huge\bfseries}{第\,\zhnumber{\thechapter}\,章}{1em}{}    %設定章節樣式


%----------------------------------------------------------------------
\endinput
