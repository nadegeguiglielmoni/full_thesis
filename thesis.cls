\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{thesis}[2021/03/04, James O'Reilly <james.oreilly@student.kuleuven.be>]

% =============================================================================

% parse class options

\RequirePackage{pgfkeys}
\RequirePackage{pgfopts}

\pgfkeys{/dissertation/.cd,
%     author = string
      author/.store in = \dissertation@author,
      author           = {},
%     promotor = string
      promotor/.store in = \dissertation@promotor, 
      promotor           = {},
%     co-promotor = string
      co-promotor/.store in = \dissertation@co-promotor, 
      co-promotor           = {},
%     title = string
      title/.store in = \dissertation@title@major,
      title           = {},
%     subtitle = string
      subtitle/.store in = \dissertation@title@minor,
      subtitle           = {},
%     department = string
      department/.store in = \dissertation@department,
      department           = {},
%     division = string
      division/.store in = \dissertation@division,
      division           = {},
%     type = string
      type/.store in = \dissertation@type,
      type           = {},
%     type = string
      year/.store in = \dissertation@year,
      year           = {\the\year}
}

\ProcessPgfOptions{/dissertation}

% load base class, then general-purpose packages

\LoadClass[10pt,a4paper,oneside]{book}

\RequirePackage{graphicx}
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{adjustbox}
\RequirePackage{etoolbox}
\RequirePackage{fancyhdr}
\RequirePackage{geometry}
\RequirePackage{datetime}
\RequirePackage[algochapter]{algorithm2e}
\RequirePackage{listings}
\RequirePackage{xstring}
\RequirePackage{url}
\RequirePackage{hyperref}
\RequirePackage{lipsum}
\RequirePackage{dtklogos}
\RequirePackage{xcolor}
\RequirePackage{ragged2e}

% =============================================================================

\makeatletter

% -----------------------------------------------------------------------------

% configure hyperref
\hypersetup{
    colorlinks  = true,
    linkcolor   = black,
    anchorcolor = blue,
    citecolor   = blue,
    filecolor   = blue,
    urlcolor    = blue
}

% configure algorithm2e
\DontPrintSemicolon

% title color
\definecolor{titlecolor}{RGB}{29,141,176}

% configure listings
\definecolor{codegreen}{rgb}{0.6,0.6,0.6}
\definecolor{codegray}{rgb}{0.5,0.5,0.5}
\definecolor{codepurple}{rgb}{0.58,0,0.82}
\definecolor{backcolour}{rgb}{0.97,0.97,0.99}
\definecolor{keycolour}{rgb}{0.10,0.20,0.99}

\lstdefinestyle{mystyle}{
    backgroundcolor=\color{backcolour},
    commentstyle=\color{codegreen},
    keywordstyle=\color{keycolour},
    numberstyle=\tiny\color{codegray},
    stringstyle=\color{codepurple},
    basicstyle=\ttfamily\footnotesize,
    breakatwhitespace=false,         
    breaklines=true,                 
    captionpos=b,                    
    keepspaces=true,                 
    numbers=left,                   
    numbersep=5pt,                  
    showspaces=false,                
    showstringspaces=false,
    showtabs=false,                  
    tabsize=4
}

\lstset{style=mystyle}
\renewcommand{\lstlistlistingname}{List of Listings}

% -----------------------------------------------------------------------------

% configure style of table of contents
\setcounter{tocdepth}{1}

% configure style of bibliography
\bibliographystyle{unsrt}

% configure style of pages
\geometry{a4paper,
          lmargin=2.5cm,
          rmargin=2.5cm,
          tmargin=3cm,
          bmargin=3cm,
          bindingoffset=0cm}

\fancypagestyle{plain}{
  \fancyhf{}

  \renewcommand{\headrulewidth}{0.5pt}
  \renewcommand{\footrulewidth}{0.5pt}

  \fancyfoot[C]{\thepage}
}

\fancypagestyle{marked}{
  \fancyhf{}

  \renewcommand{\headrulewidth}{0.5pt}
  \renewcommand{\footrulewidth}{0.5pt}

  %\fancyhead[LO]{\slshape \rightmark}
  \fancyhead[R]{\slshape  \leftmark}

  \fancyfoot[C]{\thepage}
}

\pagestyle{plain}

% -----------------------------------------------------------------------------

% define macro to generate KU Leuven Bioinformatics title page

\renewcommand{\maketitle}{
  \newpage
  \thispagestyle{empty}

  \IfEq{\dissertation@type}{}{}{
    \adjustbox{padding={5pt},frame={1pt},right}{Dissertation Type: {\dissertation@type}}
  }

  \begin{center}
                                \vspace*{-1.5cm}    
        \centerline{\includegraphics[scale=0.78]{images/cover-page/thesis-logo.pdf}}
                                \vspace*{4.0cm}
        \textcolor{black}{\huge \dissertation@title@major}     \\
                                \vspace*{0.4cm}
        \mbox{\IfEq{\dissertation@title@minor}{}{}{\Large \dissertation@title@minor \vspace*{1.0cm}}} \\
        \IfEq{\dissertation@title@minor}{}{}{\vspace*{1.0cm}}
                                % \vspace*{1.0cm}
        {\Large \dissertation@author}                                                       \\
                                \vspace*{\fill}
        \begin{adjustwidth}{4.5cm}{0cm}
            \begin{flushleft}
                {\large Promotor:  \dissertation@promotor}                                      \\
                                \vspace*{0.3cm}
                {\large Co-promotor:  \dissertation@co-promotor}                                \\
                                \vspace*{0.3cm}
                {\large Department: \dissertation@department}                                   \\
                                \vspace*{0.3cm}                        
                {\large Division: \dissertation@division}                                       \\
            \end{flushleft}
        \end{adjustwidth}
                                \vspace*{0.3cm}
        \rule{0.9\textwidth}{0.5pt}                                                         \\
                                \vspace*{0.8cm}
        Dissertation presented in fulfillment of the requirements for the degree of Master of Science: Bioinformatics \\
                                \vspace*{0.8cm}
        \rule{0.9\textwidth}{0.5pt}                                                         \\
                                \vspace*{1.0cm}
        \today
  \end{center}
}

% define macro to generate KU Leuven declaration

\newcommand{\makedecl}{
  \thispagestyle{plain}

  \chapter*{Declaration}

    This dissertation is part of the examination and has not been corrected after defense for eventual errors. Use as a reference is permitted subject to written approval of the promotor stated on the front page.

  \vspace{2cm}

  \noindent {\dissertation@author}, \today
}

\newcommand{\makeacknowledgement}{
  \thispagestyle{plain}

  \chapter*{Acknowledgements}
  \input{acknowledgements.tex}

}

\newcommand{\makeabstract}{
  \thispagestyle{plain}

    \chapter*{Abstract}
      \input{abstract.tex}
    
}

\newcommand{\makecomm}{
  \thispagestyle{plain}

    \chapter*{Scientific communications}
      \input{scientific_comm.tex}
    
}

% define macros to mark front, main and back matter

\renewcommand{\frontmatter}{
  \cleardoublepage
  \pagestyle{plain}
  \pagenumbering{roman}
}
\renewcommand{\mainmatter}{
  \cleardoublepage
  \pagestyle{marked}
  \pagenumbering{arabic}
}
\renewcommand{\backmatter}{
  \cleardoublepage
  \pagestyle{marked}
}

% -----------------------------------------------------------------------------

\makeatother

% =============================================================================
