\def\versionno{0.01}
\def\versiondate{2024/06/01}



\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{potrothesis}[\versiondate UAEMéx thesis class]

\LoadClass[12pt,letterpaper]{report}

\newif\ifpdftex \ExplSyntaxOn
	\str_const:Nn \ClassName {potrothesis}
	\prop_gput:Nnn \g_msg_module_type_prop { \ClassName } { Class }
	\sys_if_engine_pdftex:T  
		{ 
		  \pdftextrue
	   	  \msg_new:nnn { \ClassName } { notagpdftex } { Run~lualatex,~not~pdftex,\iow_newline: 
		  												when~tagging~is~used~in~\DocumentMetadata } 
		  \cs_if_exist:NT \tag_if_active:T {
		     \tag_if_active:T { \msg_error:nn  { \ClassName } { notagpdftex } }
			}
		}
\ExplSyntaxOff


\providecommand\IfFormatAtLeastTF{\@ifl@t@r\fmtversion}

\IfFormatAtLeastTF{2022/06/01}{\relax}{\ClassError{\ClassName}{Your LaTeX format is dated \fmtversion.  Formats dated 2022-06-01 or later are necessary for this class. Older formats are not supported and will generate serious errors.}{UPDATE your LaTeX distribution. TeX Live is available for download at no charge: \string https://www.tug.org/texlive/.}}



 
\ExplSyntaxOn
\cs_if_exist:NF \cs_gset:Npe          { \cs_generate_variant:Nn \cs_gset:Npn {Npe}      } \cs_if_exist:NF \regex_split:NVN      { \cs_generate_variant:Nn \regex_split:NnN {NVN}  } \cs_if_exist:NF \seq_gput_right:Ne    { \cs_generate_variant:Nn \seq_gput_right:Nn {Ne} } \cs_if_exist:NF \seq_item:NV          { \cs_generate_variant:Nn \seq_item:Nn {NV}       } \cs_if_exist:NF \str_gset:Ne          { \cs_generate_variant:Nn \str_gset:Nn {Ne}       } \cs_if_exist:NF \text_titlecase_all:n { \cs_new:Npn \text_titlecase_all:n #1 { #1 }     } \cs_if_exist:NF \tl_gput_right:Ne     { \cs_generate_variant:Nn \tl_gput_right:Nn {Ne}  } \cs_if_exist:NF \tl_gset:Ne 	      { \cs_generate_variant:Nn \tl_gset:Nn  {Ne}       } \cs_if_exist:NF \tl_set:Ne  	      { \cs_generate_variant:Nn \tl_set:Nn   {Ne}       } \ExplSyntaxOff


\NewDocumentCommand\CiteNolink{m}{ \begin{NoHyper}\cite{#1}\end{NoHyper} }


 \ExplSyntaxOn

\newif\ifmit@spanish
\newif\ifmit@mydesign
\cs_new_protected:Npn \__potrothesis_gset_testdesign:n #1
	{
    	\mit@mydesigntrue
    	\tl_new:N       \g__potrothesis_testkey_tl
    	\tl_gset:Nn     \g__potrothesis_testkey_tl {#1}
    	\tl_if_empty:NT \g__potrothesis_testkey_tl { \tl_gset:Nn \g__potrothesis_testkey_tl {mydesign} } 
	}

\IfFormatAtLeastTF{2022/11/01}{\DeclareKeys{
    	fontset  	  .store  = \mit@fontset ,
    	fontset  	  .usage  = load ,
    	lineno   	  .if     = mit@lineno ,
    	lineno 	 	  .usage  = load ,
    	mydesign 	  .code	  = \__potrothesis_gset_testdesign:n {#1} , 
    	mydesign 	  .usage  = load,
      spanish 	  .if     = mit@spanish ,
      spanish 	  .usage  = load,
    } 
    \SetKeys[\ClassName]{fontset=defaultfonts}\DeclareUnknownKeyHandler[\ClassName]{\relax}\ProcessKeyOptions
}{\RequirePackage{kvoptions}
    \SetupKeyvalOptions{
      family=\ClassName,
      prefix=mit@,
      setkeys=\kvsetkeys,
    }
\DeclareStringOption[defaultfonts]{fontset}[]
\DeclareBoolOption{lineno}
\define@key{\ClassName}{mydesign}[mydesign]
    	{ \__potrothesis_gset_testdesign:n {#1} }
\DeclareBoolOption{spanish}
\ProcessKeyvalOptions{\ClassName}
\NewDocumentCommand\mit@DisableOption{m}{\DisableKeyvalOption[action=ignore,class=\ClassName ]{#1}{\ClassName}}
    \NewDocumentCommand\mit@DisableKeys{>{\SplitList{;}}m}{\ProcessList{#1}{\mit@DisableOption}}
\mit@DisableKeys{fontset;lineno;mydesign;spanish}\DeclareOption*{}  
    \ProcessOptions \relax
}
\ExplSyntaxOff



\ifmit@lineno
    \RequirePackage[mathlines]{lineno} 
    \AtBeginDocument{\linenumbers}
\fi

\providecommand{\@LN@col}[1]{\relax}
\providecommand{\@LN}[2]{\relax}
 \ExplSyntaxOn

\tl_new:N \l__mitthesis_str_by_tl
\tl_new:N \l__mitthesis_str_authored_tl
\tl_new:N \l__mitthesis_str_certified_tl
\tl_new:N \l__mitthesis_str_accepted_tl
\tl_new:N \l__mitthesis_str_sup_designation_tl
\tl_new:N \l__mitthesis_str_abst_sup_designation_tl
\tl_new:N \l__mitthesis_str_sups_designation_tl
\tl_new:N \l__mitthesis_str_abst_sups_designation_tl
\tl_new:N \l__mitthesis_str_committee_tl
\tl_new:N \l__mitthesis_str_reader_tl
\tl_new:N \l__mitthesis_str_readers_tl
\tl_new:N \l__mitthesis_str_fulfillment_tl
\tl_new:N \l__mitthesis_str_degrees_tl
\tl_new:N \l__mitthesis_str_degree_tl
\tl_new:N \l__mitthesis_str_of_tl
\tl_new:N \l__miththesis_str_toc_tl

\ifmit@spanish
\tl_set:Nn \l__mitthesis_str_by_tl { presenta }
    \tl_set:Nn \l__mitthesis_str_authored_tl { Elaborado~por: }
    \tl_set:Nn \l__mitthesis_str_certified_tl { Director~de~Tesis: }
    \tl_set:Nn \l__mitthesis_str_accepted_tl { Aceptado~por: }
    \tl_set:Nn \l__mitthesis_str_sup_designation_tl { Director~de~Tesis }
    \tl_set:Nn \l__mitthesis_str_abst_sup_designation_tl { Director~de~tesis }
    \tl_set:Nn \l__mitthesis_str_sups_designation_tl { Directores~de~Tesis }
    \tl_set:Nn \l__mitthesis_str_abst_sups_designation_tl { Directores~de~tesis }
    \tl_set:Nn \l__mitthesis_str_committee_tl { COMITÉ~DE~TESIS }
    \tl_set:Nn \l__mitthesis_str_reader_tl { Lector~de~Tesis }
    \tl_set:Nn \l__mitthesis_str_readers_tl { Lectores~de~Tesis }
    \tl_set:Nn \l__mitthesis_str_fulfillment_tl { tesis~que~para~obtener }
    \tl_set:Nn \l__mitthesis_str_degrees_tl { los~grados }
    \tl_set:Nn \l__mitthesis_str_degree_tl { el~grado }
    \tl_set:Nn \l__mitthesis_str_of_tl { de }
    \tl_set:Nn \l__miththesis_str_toc_tl { Índice }
    \RequirePackage[spanish,
  es-noshorthands,
  es-tabla,
  es-nodecimaldot,
  main=spanish,
  english]{babel}
\addto\captionsspanish{\renewcommand{\abstractname}{Abstract}}
\else
\tl_set:Nn \l__mitthesis_str_by_tl { by }
    \tl_set:Nn \l__mitthesis_str_authored_tl { Authored~by: }
    \tl_set:Nn \l__mitthesis_str_certified_tl { Certified~by: }
    \tl_set:Nn \l__mitthesis_str_accepted_tl { Accepted~by: }
    \tl_set:Nn \l__mitthesis_str_sup_designation_tl { Thesis~Supervisor }
    \tl_set:Nn \l__mitthesis_str_abst_sup_designation_tl { Thesis~supervisor }
    \tl_set:Nn \l__mitthesis_str_sups_designation_tl { Thesis~Supervisors }
    \tl_set:Nn \l__mitthesis_str_abst_sups_designation_tl { Thesis~supervisors }
    \tl_set:Nn \l__mitthesis_str_committee_tl { THESIS~COMMITTEE }
    \tl_set:Nn \l__mitthesis_str_reader_tl { Thesis~Reader }
    \tl_set:Nn \l__mitthesis_str_readers_tl { Thesis~Readers }
    \tl_set:Nn \l__mitthesis_str_fulfillment_tl { in~partial~fulfillment~of~the~requirements~for~the~ }
    \tl_set:Nn \l__mitthesis_str_degrees_tl { degrees }
    \tl_set:Nn \l__mitthesis_str_degree_tl { degree }
    \tl_set:Nn \l__mitthesis_str_of_tl { of }
    \tl_set:Nn \l__miththesis_str_toc_tl { Table~of~Contents }
\fi

\NewDocumentCommand\translateMonth{m}{
    \str_case_e:nnF { \str_lowercase:f {#1} }
        { {january}{enero} {february}{febrero} {march}{marzo} {april}{abril}
          {may}{mayo} {june}{junio} {july}{julio} {august}{agosto}
          {september}{septiembre} {october}{octubre} {november}{noviembre}
          {december}{diciembre} }
        { \msg_error:nnn { \ClassName } { wrong_month } {#1} } 
}
\ExplSyntaxOff 
\RequirePackage[letterpaper,top=1in,bottom=1in,left=1in,right=1in,marginparwidth=50pt,headsep=12pt,footskip=0.5in,heightrounded]{geometry} 


\RequirePackage{graphicx}

\RequirePackage{mathtools}

\renewcommand{\eqref}[1]{\textup{\hbox{\m@th{(\ignorespaces\ref{#1}\unskip\@@italiccorr)}}}}


\ifpdftex
  \providecommand*\mitpsi{\psi}
  \providecommand*\mitdelta{\delta}
  \providecommand*\mitDelta{\Delta}
  \providecommand*\mittheta{\theta}
  \providecommand*\mitTheta{\Theta}
\fi
 

\ExplSyntaxOn

\msg_new:nnnn { \ClassName } { nodesignfile } 
	{ \g__potrothesis_testkey_tl .tex\iow_newline: cannot~be~not~found.~There~shall~no~design~be~loaded;~
	  and~error~messages~shall~be~multiplied~upon~thee.
	}{ 
	  Thou~hast~called~the~class~option~mydesign,~but~neither~\g__potrothesis_testkey_tl .tex\space
	  nor~mydesign.tex~can~be~found.~Thou~mayst~download~mydesign.tex~from\space
	  https://ctan.org/tex-archive/macros/latex/contrib/potrothesis/MIT-thesis-template. }
\ifmit@mydesign
	\IfFileExists{ \g__potrothesis_testkey_tl .tex }
		{ 
		  \input{  \g__potrothesis_testkey_tl .tex } 
		  \ClassNoteNoLine{\ClassName}{Loading~\g__potrothesis_testkey_tl .tex}
		}
		{ \msg_error:nn { \ClassName } { nodesignfile } }
\else
	\RequirePackage[dvipsnames,svgnames,x11names]{xcolor}
\AtBeginDocument{
		\hypersetup{
		linkcolor=Blue3,citecolor=Blue3,
		urlcolor=violet,
		filecolor=red, 
		}
		\ifmit@lineno
			\renewcommand{\linenumberfont}{\sffamily\mdseries\tiny\color{violet}}\fi
	}
\fi
\ExplSyntaxOff
 \ClassNoteNoLine{\ClassName}{Fontset key is \mit@fontset}
\IfFileExists{fontsets/\ClassName-\mit@fontset.tex}{\input{fontsets/\ClassName-\mit@fontset.tex}
}{\ClassWarning{\ClassName}{Fontset file \ClassName-\mit@fontset.tex or subdirectory fontsets not found, will look for \mit@fontset.tex in your working directory}
	\IfFileExists{\mit@fontset.tex}{\input{\mit@fontset.tex}
		}{
    	\ClassWarning{\ClassName}{Fontset file \mit@fontset.tex not found, using default fonts. You may need to place the fontset file into your working directory}
    	\ifpdftex
        	\ClassNoteNoLine{\ClassName}{Loading Computer Modern Roman text and math fonts (default for pdftex)}
        	\RequirePackage[T1]{fontenc}
	        \RequirePackage{amssymb}\RequirePackage{bm}	
\patchcmd{\section}{\normalfont}{\mathversion{bold}\normalfont}{}{}
        	\patchcmd{\subsection}{\normalfont}{\mathversion{bold}\normalfont}{}{}
        	\patchcmd{\subsubsection}{\normalfont}{\mathversion{bold}\normalfont}{}{}
        	\patchcmd{\paragraph}{\normalfont}{\mathversion{bold}\normalfont}{}{}
        	\patchcmd{\subparagraph}{\normalfont}{\mathversion{bold}\normalfont}{}{}
        \else
        	\ClassNoteNoLine{\ClassName}{Loading Latin Modern text and math fonts (default for unicode engines)}
            \RequirePackage[warnings-off={mathtools-colon,mathtools-overbracket},mathbf=sym]{unicode-math}
\fi
       }
} 

\RequirePackage{etoolbox}

\patchcmd{\tableofcontents}{\contentsname}{\pdfbookmark[0]{
	\ifmit@spanish
		Índice general
	\else
		Table of Contents
	\fi
}{toc}\contentsname}{}{} 



\ProvideDocumentCommand\MakeLinkTarget{ s O{} m }{}

\patchcmd{\listoffigures}{\chapter*{\listfigurename}}{\chapter*{\MakeLinkTarget*{listoffigures}\listfigurename}\addcontentsline{toc}{frontmatter}{\listfigurename}}{}{}
\patchcmd{\listoftables}{\chapter*{\listtablename}}{\chapter*{\MakeLinkTarget*{listoftables}\listtablename}\addcontentsline{toc}{frontmatter}{\listtablename}}{}{}




\NewCommandCopy\l@frontmatter\l@chapter
\NewCommandCopy\l@backmatter\l@chapter
\providecommand*{\toclevel@frontmatter}{0}\providecommand*{\toclevel@backmatter}{0}

\patchcmd{\l@frontmatter}{\bfseries}{\itshape}{}{}
\patchcmd{\l@frontmatter}{\nobreak\hfil}{\upshape\nobreak\hfil}{}{}
\patchcmd{\l@frontmatter}{1.0em}{3pt}{}{} 
\patchcmd{\l@backmatter}{\bfseries}{\itshape}{}{}
\patchcmd{\l@backmatter}{\nobreak\hfil}{\upshape\nobreak\hfil}{}{}
 \ExplSyntaxOn
\IfPackageLoadedTF{caption}{ \cs_if_exist:NT \tag_if_active:T {
    \tag_if_active:T
    {
\RemoveFromHook{begindocument}[latex-lab-testphase-float]
    \socket_new_plug:nnn{tagsupport/parbox/before}{caption}
      {   
       \tagpdfparaOn \tl_if_empty:NTF\@current@float@struct
        {     
         \tag_struct_begin:n{tag = Caption,firstkid}
        }
        {
         \tag_struct_begin:n{tag = Caption,parent=\@current@float@struct,firstkid}
        }
      }
    \socket_new_plug:nnn{tagsupport/parbox/after}{caption}
      {
       \tag_struct_end:   
      }
    \l@addto@macro\caption@beginex@hook {
        \tagpdfparaOff \AssignSocketPlug{tagsupport/parbox/before}{caption}
        \AssignSocketPlug{tagsupport/parbox/after}{caption}
      }
	}
\AddToHook{begindocument/end}{
    		\renewcommand*\caption@anchor[1]{\ifmeasuring@ \else
           	\caption@raisedlink{\MakeLinkTarget*{#1}}\fi}}
  }
}{\relax}

\cs_new:Nn \__potrothesis_adjustcaptions: 
	{
\AddToHook{cmd/@makecaption/after}
		{ 
	       \str_if_eq:VnT \@captype { table } { \vskip 0.5\baselineskip } }
	}

\IfFormatAtLeastTF{2025/11/01}
	{
	\IfPackageLoadedTF{caption}
	{
	\tag_if_active:F { 
		\AddToHook{cmd/@makecaption/after}
			{
		    \str_if_eq:VnT \@captype { table } { \vskip 0.5\baselineskip }
			}
	  	} 
	}{  
	\__potrothesis_adjustcaptions:
	}
}{\relax}

\IfPackageLoadedTF{subcaption}
{
	\msg_new:nnn { \ClassName } { subcaptionloaded }
		{ Subcaption~package~has~been~loaded,~so~I~won't\iow_newline: load~potrothesis's~subfigure~or~subcaption~code. } 
	\msg_warning:nn { \ClassName } { subcaptionloaded }
}{
    \newcounter{SubFigure}[figure]
    \renewcommand{\theSubFigure}{
    	\number\numexpr\value{figure}+1\relax(\alph{SubFigure})}
    \NewDocumentCommand\subcaption{m}
		{
		\vskip 5\p@
		\tl_set:Nn   \l_tmpb_tl  { \small ( \alph{SubFigure}) \space #1 } \hbox_set:Nn \l_tmpa_box { \tl_use:N \l_tmpb_tl }
		\dim_compare:nNnTF { \box_wd:N \l_tmpa_box } > { 0.9\hsize }
          {
            \skip_add:Nn \leftskip  {  0.05\hsize }
            \skip_add:Nn \rightskip {  0.05\hsize }      
            \l_tmpb_tl \par      
            \skip_add:Nn \leftskip  { -0.05\hsize }
            \skip_add:Nn \rightskip { -0.05\hsize }
          }{
            \global \@minipagefalse
            \hbox_to_wd:nn { \hsize } { 
                \hfil
                \cs_if_exist:NT \tag_if_active:T {
                   \tag_if_active:T { \UseTaggingSocket { para/begin } }
                }
                \l_tmpb_tl
                \cs_if_exist:NT \tag_if_active:T {
                   \tag_if_active:T { \UseTaggingSocket { para/end } }
                }
                \hfil
            }
          }
        \vskip 5\p@
    }
\NewDocumentEnvironment{subfigure}{ O{t} m +b }
	{
	  \refstepcounter{SubFigure}
	  \begin{minipage}[#1]{#2}
		#3 
	}{
	  \end{minipage}
	  \ignorespacesafterend
	}
}

\ExplSyntaxOff \ExplSyntaxOn
\cs_if_exist:NF  \tag_struct_begin:n
	{ 
	  \cs_new_protected:Npn \tag_struct_begin:n #1 { \scan_stop: } 
	  \cs_new_protected:Nn  \tag_struct_end:   	 { \scan_stop: } 
	}
\cs_if_exist:NF  \tag_mc_begin:n
	{ 
	  \cs_new_protected:Npn \tag_mc_begin:n    #1 { \scan_stop: } 
	  \cs_new_protected:Nn  \tag_mc_end:       	{ \scan_stop: } 
	}
\cs_if_exist:NF  \tagpdfsetup
	{ 
	  \cs_new_protected:Npn \tagpdfsetup	     #1 { \scan_stop: } 
	}
\cs_if_exist:NF  \UseTaggingSocket
	{
	  \cs_new_protected:Npn \UseTaggingSocket	 #1 { \scan_stop: }
	}

\cs_if_exist:NT \tag_if_active:T {
  \tag_if_active:T { \msg_new:nnn    { \ClassName } { no_css_file } {I~can't~find~the~file~potrothesis-style.css.\iow_newline:
    This~optional~file~provides~css~style~if~the~tagged~pdf~is~rendered~into~html.~
    								You~can~ignore~this~warning~if~you~don't~want~styling.}
    \msg_new:nnn    { \ClassName } { css_file_loaded } {The~file~potrothesis-style.css~has~been~loaded.}
    \file_if_exist:nTF {potrothesis-style.css}
    	{
		\tagpdfsetup
			{
			css-list-add = { potrothesis-style.css } }
			\msg_note:nn { \ClassName } { css_file_loaded } 
			}{  
			\msg_note:nn { \ClassName } { no_css_file } 
			}
  }
}



\cs_if_exist:NT  \tag_if_active:T {
  \tag_if_active:T {
    \tagpdfsetup { role/user-NS = potrothesis }
    
    \tagpdfsetup { role/new-tag = { Title_sig_block/Div } }
    \tagpdfsetup { role/new-tag = { Author/Div } }
    \tagpdfsetup { role/new-tag = { Degree/Div } }
    \tagpdfsetup { role/new-tag = { Copyright/Div } }
    
    \tagpdfsetup { role/new-tag = { Committee_page/Sect } }
    \tagpdfsetup { role/new-tag = { Committee_name/Span  } }       \tagpdfsetup { role/new-tag = { Committee_block_title/Span } } 

    \tagpdfsetup { role/new-tag = { Abstract_page/Sect } }
    \tagpdfsetup { role/new-tag = { Abstract_title/Div } }
    \tagpdfsetup { role/new-tag = { Abstract_text/Div  } }
    \tagpdfsetup { role/new-tag = { Abstract_supervisor/Div  } }
    
    \tagpdfsetup { role/new-tag = { Nomenclature_list/Div  } }
    \tagpdfsetup { role/new-tag = { Nomenclature_entry_heading/Span  } }
  }
}
\ExplSyntaxOff

 \RequirePackage[psdextra]{hyperref} 

\urlstyle{same} 		\RequirePackage{doi} 	

\providecommand\hrefurl[2]{\href{#1}{#2}}

\hypersetup{
	colorlinks=true,
	pdfborder={0 0 0},
	bookmarksnumbered=true,
	bookmarksopen=true,
	bookmarksopenlevel=1,
	pdfpagelayout=SinglePage,
	pdfdisplaydoctitle=true,
	pdfstartview=Fit,
	pdfnewwindow=true,
pdfcontactaddress={Massachusetts Institute of Technology, 77 Massachusetts Avenue},
	pdfcontactcity={Cambridge, MA},
	pdfcontactpostcode={02139-4307},
	pdfcontactcountry={USA},
	pdfcontacturl={https://dspace.mit.edu/handle/1721.1/7582},}
 		




\pdfstringdefDisableCommands{\def\bm#1#{\relax}}
\pdfstringdefDisableCommands{\def\({\relax}\def\){\relax}}
\pdfstringdefDisableCommands{\let\NoCaseChange\relax }
\pdfstringdefDisableCommands{\def\cite{\@gobble}}
\pdfstringdefDisableCommands{\def\eqref#1{(\ref{#1})}}
\pdfstringdefDisableCommands{\def\footnote#1{}}

 
\ExplSyntaxOn
\tl_new:N \g__potrothesis_dd_month_tl	
\tl_new:N \g__potrothesis_dd_year_tl

\cs_generate_variant:Nn  \tl_gremove_all:Nn {No}
\cs_new_protected:Nn   \__potrothesis_gset_dd_dates:nn {
	\tl_gset:Nn        \g__potrothesis_dd_month_tl {#1}
	\tl_gset:Nn        \g__potrothesis_dd_year_tl  {#2}
	\tl_gremove_all:No \g__potrothesis_dd_month_tl { \space }
	\tl_gremove_all:No \g__potrothesis_dd_year_tl  { \space }
 	\str_case_e:nnF 
		{ \str_lowercase:f { \tl_to_str:N  \g__potrothesis_dd_month_tl } }
	 	{ {february}{} {may}{} {june}{} {september}{} }
		{ \msg_error:nnn { \ClassName } { wrong_month } {#1} } 
}
\msg_new:nnnn { \ClassName } { wrong_month } 
	{ The~degree~month~must~be~one~of~February,~May,~June,~or~September. } 
	{ MIT~does~not~use~#1~as~the~degree~month. }

\NewDocumentCommand\DegreeDate{mm}{ \__potrothesis_gset_dd_dates:nn {#1} {#2}
	\cs_new:Npn \DegreeMonth { \text_titlecase_first:n { \text_lowercase:n \g__potrothesis_dd_month_tl } }
	\tl_new:N \g__potrothesis_dd_month_es_tl
	\cs_new:Npn \DegreeMonthES 
		{
			\tl_set:Nf \g__potrothesis_dd_month_es_tl { \translateMonth { \g__potrothesis_dd_month_tl } }
			\text_titlecase_first:n{\g__potrothesis_dd_month_es_tl}
		}
	\cs_new:Npn \DegreeMonthESlower {\translateMonth{\g__potrothesis_dd_month_tl}} \cs_new:Npn \DegreeYear  { \text_expand:n { \g__potrothesis_dd_year_tl  } } }
\msg_new:nnnn { \ClassName } { no_degree_date } { Missing~degree~date! }{
			You~MUST~issue~the~\DegreeDate{month}{year}~command~between~\string\begin{document}~and~\string\maketitle. }
		
\NewDocumentCommand\ThesisDate{m}{
	\tl_if_exist:NTF \g_potrothesis_dd_thesisdate_tl 
		{ \g_potrothesis_dd_thesisdate_tl } { \__potrothesis_gset_dd_thesisdate:n {#1} }}

\cs_new_protected:Nn \__potrothesis_gset_dd_thesisdate:n {
	\tl_new:N        \g_potrothesis_dd_thesisdate_tl
	\tl_gset:Ne      \g_potrothesis_dd_thesisdate_tl { \tl_trim_spaces:n {#1} }
}

\NewDocumentCommand\SuppressMonthError{}
  {
  	\msg_redirect_name:nnn { \ClassName } { wrong_month } { none }
  }
\ExplSyntaxOff \ExplSyntaxOn
\seq_new:N \g__potrothesis_author_name_seq
\seq_new:N \g__potrothesis_author_department_seq
\seq_new:N \g__potrothesis_author_prevdegree_seq
\seq_new:N \g__potrothesis_author_secondprevdegree_seq
\seq_new:N \g__potrothesis_author_thirdprevdegree_seq
\seq_new:N \g__potrothesis_author_fourthprevdegree_seq
\int_gzero_new:N \g__potrothesis_author_cnt_int

\NewDocumentCommand\Author{ m m O{} O{} O{} O{} } {
 	\tl_if_blank:nTF {#1} 
		{
		  \msg_error:nn { \ClassName } { blank_author }
		}{
		  \__potrothesis_gset_author_data:nnnnnn { #1 } { #2 } { #3 } { #4 } { #5 } { #6 }
		}
	\tl_if_blank:nT {#2} { \msg_error:nn {\ClassName} {blank_author_dep} }
 }
\msg_new:nnnn { \ClassName } { blank_author } 
				{ Missing~author~name, \iow_newline: check~for~blank~in~\Author~command. }
				{ You~MUST~provide~an~author~name~using~the~\Author{name}{department}~command. }
\msg_new:nnnn { \ClassName } { blank_author_dep } 
				{ Missing~author~department, \iow_newline: check~for~blank~in~\Author~command. }
				{ You~MUST~provide~the~author's~department~using~the~\Author{name}{department}~command. }

\cs_new_protected:Nn \__potrothesis_gset_author_data:nnnnnn
 {
	\int_gincr:N \g__potrothesis_author_cnt_int
	\seq_gput_right:Ne  \g__potrothesis_author_name_seq             { \tl_trim_spaces:n {#1} } 
	\seq_gput_right:Ne  \g__potrothesis_author_department_seq       { \tl_trim_spaces:n {#2} }
	\seq_gput_right:Ne  \g__potrothesis_author_prevdegree_seq       { \tl_trim_spaces:n {#3} }
	\seq_gput_right:Ne  \g__potrothesis_author_secondprevdegree_seq { \tl_trim_spaces:n {#4} }
	\seq_gput_right:Ne  \g__potrothesis_author_thirdprevdegree_seq  { \tl_trim_spaces:n {#5} }
	\seq_gput_right:Ne  \g__potrothesis_author_fourthprevdegree_seq { \tl_trim_spaces:n {#6} }
 }

\NewExpandableDocumentCommand\CopyrightAuthor{}{
	\tl_if_exist:NTF \g__potrothesis_copyright_author_tl
		{ \g__potrothesis_copyright_author_tl }
		{ \__potrothesis_gset_copyright_author: \g__potrothesis_copyright_author_tl }
}

\cs_new_protected:Nn \__potrothesis_gset_copyright_author: {
	\tl_new:N       \g__potrothesis_copyright_author_tl
	\int_set:Nn 	\l_tmpa_int {1} \tl_gset:Ne     \g__potrothesis_copyright_author_tl  { \seq_item:NV \g__potrothesis_author_name_seq \l_tmpa_int }
	\int_incr:N     \l_tmpa_int
	\int_while_do:nNnn { \l_tmpa_int } < { \g__potrothesis_author_cnt_int }
		{
		  \tl_gput_right:Ne \g__potrothesis_copyright_author_tl 
		  	{ ,~\seq_item:NV \g__potrothesis_author_name_seq \l_tmpa_int }
		  \int_incr:N \l_tmpa_int   
		}
	\int_compare:nNnT { \l_tmpa_int } = { \g__potrothesis_author_cnt_int } 
		{
        \int_compare:nNnTF { \l_tmpa_int } = { 2 }
        	{
        		\tl_gput_right:Ne \g__potrothesis_copyright_author_tl 
        		    { ~and~\seq_item:NV \g__potrothesis_author_name_seq \l_tmpa_int } 
        	 }{
        		 \tl_gput_right:Ne \g__potrothesis_copyright_author_tl 
        		 { ,~and~\seq_item:NV \g__potrothesis_author_name_seq \l_tmpa_int } }
		}
	\tl_set:Nn \l_tmpa_tl { \tl_item:Nn \g__potrothesis_copyright_author_tl {-1} } \str_case_e:nnT 
		{ \l_tmpa_tl  }
	 	{ {.}{} }
		{ \__potrothesis_copyright_remove_period:N \g__potrothesis_copyright_author_tl } \__potrothesis_gset_author_pdfcopyright:
	\cs_gset:Npe \@author { \tl_use:N \g__potrothesis_copyright_author_tl }  }
\cs_new_protected:Nn \__potrothesis_copyright_remove_period:N
	{
		\tl_gset:Ne #1 { \tl_range:Nnn #1 { 1 } { \tl_count:N #1 - 1 } }
	}
\cs_new_protected:Nn \__potrothesis_gset_author_pdfcopyright: {
	\tl_new:N    \g__potrothesis_pdfcopyright_author_tl
	\int_set:Nn  \l_tmpa_int {1} \tl_gset:Ne  \g__potrothesis_pdfcopyright_author_tl  
    	{ { \seq_item:NV \g__potrothesis_author_name_seq \l_tmpa_int } }
	\int_until_do:nNnn { \l_tmpa_int } = { \g__potrothesis_author_cnt_int }
		{
			\int_incr:N \l_tmpa_int   
			\tl_gput_right:Ne \g__potrothesis_pdfcopyright_author_tl 
				{ ;\ { \seq_item:NV \g__potrothesis_author_name_seq \l_tmpa_int } }
}
}

\tl_new:N   \g__potrothesis_author_namesize_tl
\tl_gset:Nn \g__potrothesis_author_namesize_tl { \large }
\cs_new_protected:Nn  \__potrothesis_author_block: {
	\int_set:Nn \l_tmpa_int {1} \int_compare:nNnTF { \g__potrothesis_author_cnt_int } = {0} {
		\msg_error:nn { \ClassName } { no_author }
	}	
	{\l__mitthesis_str_by_tl\par
	\int_until_do:nNnn { \l_tmpa_int } = { \g__potrothesis_author_cnt_int } {
		{ 
			\leavevmode
			\tag_struct_begin:n { tag = Span }
	    	\tag_mc_begin:n { tag = Span }
			\g__potrothesis_author_namesize_tl \seq_item:NV \g__potrothesis_author_name_seq \l_tmpa_int
			\tag_struct_end:
    		\tag_mc_end:
		} \par
		\tl_set:Ne \l_tmpa_tl { \seq_item:NV \g__potrothesis_author_prevdegree_seq \l_tmpa_int }
		\tl_if_empty:NF \l_tmpa_tl { \normalsize \l_tmpa_tl . } \tl_set:Ne \l_tmpa_tl { \seq_item:NV \g__potrothesis_author_secondprevdegree_seq \l_tmpa_int } 
		\tl_if_empty:NF \l_tmpa_tl { \linebreak\normalsize \l_tmpa_tl . }
		\tl_set:Ne \l_tmpa_tl { \seq_item:NV \g__potrothesis_author_thirdprevdegree_seq \l_tmpa_int } 
		\tl_if_empty:NF \l_tmpa_tl { \linebreak\normalsize \l_tmpa_tl . }
		\tl_set:Ne \l_tmpa_tl { \seq_item:NV \g__potrothesis_author_fourthprevdegree_seq \l_tmpa_int } 
		\tl_if_empty:NF \l_tmpa_tl { \linebreak\normalsize \l_tmpa_tl . }
		\par and\par
		\int_incr:N \l_tmpa_int
	}
		{ 
			\leavevmode
			\tag_struct_begin:n { tag = Span }
	    	\tag_mc_begin:n { tag = Span }
			\g__potrothesis_author_namesize_tl \seq_item:NV \g__potrothesis_author_name_seq \l_tmpa_int 
			\tag_struct_end:
    		\tag_mc_end:
		} \par
		\tl_set:Ne \l_tmpa_tl { \seq_item:NV \g__potrothesis_author_prevdegree_seq \l_tmpa_int }
		\tl_if_empty:NF \l_tmpa_tl { \normalsize \l_tmpa_tl . } \tl_set:Ne \l_tmpa_tl { \seq_item:NV \g__potrothesis_author_secondprevdegree_seq \l_tmpa_int } 
		\tl_if_empty:NF \l_tmpa_tl { \linebreak\normalsize \l_tmpa_tl . }
		\tl_set:Ne \l_tmpa_tl { \seq_item:NV \g__potrothesis_author_thirdprevdegree_seq \l_tmpa_int } 
		\tl_if_empty:NF \l_tmpa_tl { \linebreak\normalsize \l_tmpa_tl . }
		\tl_set:Ne \l_tmpa_tl { \seq_item:NV \g__potrothesis_author_fourthprevdegree_seq \l_tmpa_int } 
		\tl_if_empty:NF \l_tmpa_tl { \linebreak\normalsize \l_tmpa_tl . }
    	\par 
    }
}
\NewDocumentCommand\AuthorNameSize{m}{
		\tl_gset:Nn \g__potrothesis_author_namesize_tl {#1}
}

\cs_new_protected:Nn \__potrothesis_author_abstractblock: {
	\int_set:Nn \l_tmpa_int {1} \int_compare:nNnTF { \g__potrothesis_author_cnt_int } = {0} {
		\msg_error:nn { \ClassName } { no_author }
		}	
		{by\par
		\int_until_do:nNnn { \l_tmpa_int } = { \g__potrothesis_author_cnt_int } {
			\seq_item:NV \g__potrothesis_author_name_seq \l_tmpa_int
			\par and\par
			\int_incr:N \l_tmpa_int
		}
		\seq_item:NV \g__potrothesis_author_name_seq \l_tmpa_int 
    }
}
\msg_new:nnnn { \ClassName } { no_author }
		{ Missing~author!~You~must~issue \iow_newline: the~\Author{name}{department}~command. }{
		You~MUST~issue~the~\Author{name}{department}~command~after~\string\begin{document}~and~before~\string\maketitle. }

\cs_new_protected:Nn \__potrothesis_author_abstractblock_es: {
	\int_set:Nn \l_tmpa_int {1} \int_compare:nNnTF { \g__potrothesis_author_cnt_int } = {0} {
		\msg_error:nn { \ClassName } { no_author }
		}	
		{presenta\par
		\int_until_do:nNnn { \l_tmpa_int } = { \g__potrothesis_author_cnt_int } {
			\seq_item:NV \g__potrothesis_author_name_seq \l_tmpa_int
			\par and\par
			\int_incr:N \l_tmpa_int
		}
		\seq_item:NV \g__potrothesis_author_name_seq \l_tmpa_int 
    }
}
\ExplSyntaxOff \ExplSyntaxOn
\seq_new:N \g__potrothesis_supervisor_name_seq
\seq_new:N \g__potrothesis_supervisor_title_seq
\seq_new:N \g__potrothesis_supervisor_dept_seq
\seq_new:N \g__potrothesis_supervisor_title_es_seq
\seq_new:N \g__potrothesis_supervisor_dept_es_seq
\int_gzero_new:N \g__potrothesis_supervisor_cnt_int

\NewDocumentCommand\Supervisor{mmooo}{
\tl_if_blank:nT {#1} { \msg_error:nn { \ClassName } { blank_supervisor }       }
    \tl_if_blank:nT {#2} { \msg_error:nn { \ClassName } { blank_supervisor_title } }

\__potrothesis_gset_supervisor_data:nnnnn 
		{#1} {#2} {#3} {#4} {#5}
}
\msg_new:nnnn { \ClassName } { blank_supervisor }
		{ Missing~supervisor~name,~check\iow_newline: for~blank~in~\Supervisor{name}{title}[department]~command. 
		}{
		  You~MUST~provide~the~supervisor's~name~using~the~\Supervisor{name}{title}[department]~command. 
		}
\msg_new:nnnn { \ClassName } { blank_supervisor_title }
		{ Missing~supervisor~title,~check\iow_newline: for~blank~in~\Supervisor{name}{title}[department]~command. 
		}{
		  You~MUST~provide~the~supervisor's~title~using~the~\Supervisor{name}{title}[department]~command. 
		}
\msg_new:nnnn { \ClassName } { blank_supervisor_dept }
		{ 
		  No~supervisor~department_provided,~check\iow_newline: for~blank~in~\Supervisor{name}{title}[department]~command.
		}{
		  The~supervisor's~department~was~blank~in~the~\Supervisor{name}{title}[department]~command.
		}
\msg_new:nnnn { \ClassName } { no_supervisor_dept }
	 	{ No~supervisor~department_provided~with\iow_newline: the~optional~third~argument~of\space
		  the~\Supervisor{name}{title}[department]~command.
		}{
		  The~supervisor's~department~is~used~only~in~the~optional~Thesis~Committee~page.
		}

\cs_new_protected:Nn \__potrothesis_gset_supervisor_data:nnnnn
 {
	\int_gincr:N \g__potrothesis_supervisor_cnt_int
	\seq_gput_right:Ne  \g__potrothesis_supervisor_name_seq   { \tl_trim_spaces:n {#1} } 
	\seq_gput_right:Ne  \g__potrothesis_supervisor_title_seq  { \tl_trim_spaces:n {#2} }
	\seq_gput_right:Ne  \g__potrothesis_supervisor_dept_seq   { \tl_trim_spaces:n {#3} }
	\seq_gput_right:Ne  \g__potrothesis_supervisor_title_es_seq   { \tl_trim_spaces:n {#4} }
	\seq_gput_right:Ne  \g__potrothesis_supervisor_dept_es_seq   { \tl_trim_spaces:n {#5} }
 }

\tl_new:N   \g__potrothesis_titlepg_sup_designation_tl
\tl_new:N   \g__potrothesis_abst_sup_designation_tl
\tl_gset:Nn \g__potrothesis_titlepg_sup_designation_tl { \l__mitthesis_str_sup_designation_tl } \tl_gset:Nn \g__potrothesis_abst_sup_designation_tl  { Thesis~supervisor } 

\NewDocumentCommand\SupervisorDesignation{ m } { 
		\tl_gset:Nn \g__potrothesis_titlepg_sup_designation_tl 
				{ \cs_if_exist:NTF \text_titlecase_all:n { \text_titlecase_all:n { \text_lowercase:n { \tl_trim_spaces:n {#1} } } }
					{ \tl_trim_spaces:n {#1} }
				}
		\tl_gset:Nn \g__potrothesis_abst_sup_designation_tl  
				{ \text_titlecase_first:n { \text_lowercase:n { \tl_trim_spaces:n {#1} } } }
		}
		
\cs_new_protected:Nn \__potrothesis_supervisor_abstractblock: { \int_set:Nn  \l_tmpa_int {1} \setlength{\parindent}{0pt}
	\par\bigskip
	\int_compare:nNnTF { \g__potrothesis_supervisor_cnt_int } = {0} {
		\msg_error:nn { \ClassName } { no_supervisor }
		}	
		{
		\int_until_do:nNnn { \l_tmpa_int } = { \g__potrothesis_supervisor_cnt_int } {
			\tl_set:Ne \l_tmpa_tl  { \seq_item:NV \g__potrothesis_supervisor_title_seq \l_tmpa_int }
			\regex_replace_all:nnN { \& \s* } { \c{phantom}{Title:\c{space}} } \l_tmpa_tl 
			\tag_struct_begin:n { tag = Abstract_supervisor, title = Abstract~supervisor}
    			\g__potrothesis_abst_sup_designation_tl  :\space 
    			\seq_item:NV \g__potrothesis_supervisor_name_seq \l_tmpa_int \par
    			Title:\space \l_tmpa_tl
    			\int_gincr:N \l_tmpa_int
			\tag_struct_end:
			\skip_vertical:n {12pt}
			}
			\tl_set:Ne \l_tmpa_tl {\seq_item:NV \g__potrothesis_supervisor_title_seq \l_tmpa_int }
			\regex_replace_all:nnN { \& \s* } { \c{phantom}{Title:\c{space}} } \l_tmpa_tl 
			\tag_struct_begin:n { tag = Abstract_supervisor, title = Abstract~supervisor}
			\g__potrothesis_abst_sup_designation_tl  :\space  
			\seq_item:NV \g__potrothesis_supervisor_name_seq \l_tmpa_int \par
			Title:\space   \l_tmpa_tl 
			\tag_struct_end:
			\ignorespaces
    	}
}
\msg_new:nnnn { \ClassName } { no_supervisor }
		{ Missing~supervisor!~You~must~issue~the~\Supervisor{name}{title}~command. }{
		You~MUST~issue~the~\Supervisor{name}{title}~command~after~\string\begin{document}~and~before~\string\maketitle. }

\ExplSyntaxOff \ExplSyntaxOn
\seq_new:N \g__potrothesis_acceptor_name_seq
\seq_new:N \g__potrothesis_acceptor_dept_seq
\seq_new:N \g__potrothesis_acceptor_title_seq
\int_gzero_new:N \g__potrothesis_acceptor_cnt_int

\bool_new:N \g__potrothesis_acceptor_title_bool
\bool_gset_false:N \g__potrothesis_acceptor_title_bool

\NewDocumentCommand\Acceptor{mmm}{
	\tl_if_blank:nTF {#1} {
		\msg_error:nn { \ClassName } { blank_acceptor }
		}{
		\__potrothesis_gset_acceptor_data:nnn {#1} {#2} {#3}
	}
	\tl_if_blank:nT  {#2} { \msg_error:nn { \ClassName } { blank_acceptor_dep } }
	\tl_if_blank:nTF {#3} {
		\bool_gset_true:N \g__potrothesis_acceptor_title_bool
		\msg_warning:nn { \ClassName } { blank_acceptor_title }}{}
}
\msg_new:nnnn { \ClassName } { blank_acceptor }
		{ Missing~acceptor~name,~check~for~blank~in~\Acceptor{name}{department}{title}~command. }{
			You~MUST~provide~the~acceptor's~name~using~the~\Acceptor{name}{department}{title}~command. }
\msg_new:nnnn { \ClassName } { blank_acceptor_dep }
		{ Missing~acceptor~department,~check~for~blank~in~\Acceptor{name}{department}{title}~command. }{
			You~MUST~provide~the~acceptor's~department~using~the~\Acceptor{name}{department}{title}~command. }
\msg_new:nnn { \ClassName } { blank_acceptor_title }
		{ Missing~acceptor~title~(blank~in~\Acceptor{name}{department}{title}~command).\space 
		  Perhaps~you~are~trying~to~save~vertical~space?\space  
		  You~can~put~the~acceptor~title~into~department~field~instead.\space 
		  For~consistency,~I~will~omit~titles~of~ALL~acceptors.
		}

\cs_new_protected:Nn \__potrothesis_gset_acceptor_data:nnn
 {
	\int_gincr:N \g__potrothesis_acceptor_cnt_int
	\seq_gput_right:Ne  \g__potrothesis_acceptor_name_seq  { \tl_trim_spaces:n {#1} } 
	\seq_gput_right:Ne  \g__potrothesis_acceptor_dept_seq  { \tl_trim_spaces:n {#2} }
	\seq_gput_right:Ne  \g__potrothesis_acceptor_title_seq { \tl_trim_spaces:n {#3} }
 }
\ExplSyntaxOff \ExplSyntaxOn
\seq_new:N \g__potrothesis_reader_name_seq
\seq_new:N \g__potrothesis_reader_title_seq
\seq_new:N \g__potrothesis_reader_department_seq
\seq_new:N \g__potrothesis_reader_title_es_seq
\seq_new:N \g__potrothesis_reader_department_es_seq
\int_gzero_new:N \g__potrothesis_readercnt_int

\NewDocumentCommand\Reader{mmmoo}{
\tl_if_blank:nT {#1} { \msg_error:nn { \ClassName } { blank_reader }       }
    \tl_if_blank:nT {#2} { \msg_error:nn { \ClassName } { blank_reader_title } }
	\tl_if_blank:nT {#3} { \msg_error:nn { \ClassName } { blank_reader_dep }   }

\__potrothesis_gset_reader_data:nnnnn {#1} {#2} {#3} {#4} {#5}
}

\msg_new:nnnn { \ClassName } { blank_reader }
        { Missing~reader~name,~check\iow_newline: for~blank~in~\Reader{name}{title}[department]~command. 
        }{
          You~MUST~provide~the~reader's~name~using~the~\Reader{name}{title}[department]~command. 
        }
\msg_new:nnnn { \ClassName } { blank_reader_title }
        { Missing~reader~title,~check\iow_newline: for~blank~in~\Reader{name}{title}[department]~command. 
        }{
          You~MUST~provide~the~reader's~title~using~the~\Reader{name}{title}[department]~command. 
        }
\msg_new:nnnn { \ClassName } { blank_reader_dep }
        { 
          No~reader~department_provided,~check\iow_newline: for~blank~in~\Reader{name}{title}[department]~command.
        }{
          The~reader's~department~was~blank~in~the~\Reader{name}{title}[department]~command.
        }

\cs_new_protected:Nn \__potrothesis_gset_reader_data:nnnnn
 {
    \int_gincr:N \g__potrothesis_readercnt_int
    \seq_gput_right:Ne  \g__potrothesis_reader_name_seq          { \tl_trim_spaces:n {#1} } 
    \seq_gput_right:Ne  \g__potrothesis_reader_title_seq         { \tl_trim_spaces:n {#2} }
    \seq_gput_right:Ne  \g__potrothesis_reader_department_seq    { \tl_trim_spaces:n {#3} }
    \seq_gput_right:Ne  \g__potrothesis_reader_title_es_seq      { \tl_trim_spaces:n {#4} }
    \seq_gput_right:Ne  \g__potrothesis_reader_department_es_seq { \tl_trim_spaces:n {#5} }
 }
\ExplSyntaxOff \ExplSyntaxOn
\seq_new:N \g__potrothesis_degree_name_seq
\seq_new:N \g__potrothesis_degree_dept_seq
\int_gzero_new:N \g__potrothesis_degree_cnt_int
\int_gzero_new:N \g__potrothesis_dept_cnt_int

\NewDocumentCommand\Degree{mm}
 {
    \int_compare:nNnTF { \g__potrothesis_dept_cnt_int } = {0} {
    	\tl_if_blank:nTF {#1} {
    		  \msg_error:nn { \ClassName } { no_degree_name }
    		}{
			  \__potrothesis_gset_degree_name:n { #1 }
			  \int_gincr:N \g__potrothesis_degree_cnt_int
    		}
    	\tl_if_blank:nTF {#2} {
    		  \msg_error:nn { \ClassName } { no_degree_dep }
    		}{
			  \__potrothesis_gset_degree_dept:n { #2 }
			  \int_gincr:N \g__potrothesis_dept_cnt_int
			}
    }{
    	\tl_if_blank:nTF {#1} {
    		  \msg_warning:nn { \ClassName } { blank_degree }
    		}{
			  \__potrothesis_gset_degree_name:n { #1 }
			  \int_gincr:N \g__potrothesis_degree_cnt_int
			}
    	\tl_if_blank:nTF {#2} {
    		  \msg_warning:nn { \ClassName } { blank_degree_dep }
    		}{
			  \int_gincr:N \g__potrothesis_dept_cnt_int 
			  \__potrothesis_gset_degree_dept:n { #2 }
    		}
    }
 }

\cs_new_protected:Nn \__potrothesis_gset_degree_name:n
 {
	\seq_gput_right:Ne  \g__potrothesis_degree_name_seq  { \tl_trim_spaces:n {#1} } 
 }
\cs_new_protected:Nn \__potrothesis_gset_degree_dept:n
 {
	\seq_gput_right:Ne  \g__potrothesis_degree_dept_seq  { \tl_trim_spaces:n {#1} }
 }
\msg_new:nnnn { \ClassName } { no_degree_name } 
			{ Missing~degree~name,~check~for\iow_newline: blank~in~\Degree~command. } 
			{ You~MUST~provide~at~least~one~degree~name~using~the~\Degree{name}{department}~command. }
\msg_new:nnnn { \ClassName } { no_degree_dep } 
			{ Missing~degree~department~for\iow_newline: Degree~command. }
			{ You~MUST~provide~at~least~one~department~name~using~the~\Degree{name}{department}~command. }
\msg_new:nnn { \ClassName } { blank_degree } 
			{ Missing~degree~name~in~second~\Degree~command.\iow_newline: 
			  Will~treat~this~as~two~departments~issuing~one~degree. }
\msg_new:nnn { \ClassName } { blank_degree_dep } 
			{ Missing~degree~department~in~second~\Degree~command.~Will~treat~as~one~department~issuing~two~degrees. }

\seq_new:N \g__potrothesis_degree_name_es_seq
\seq_new:N \g__potrothesis_degree_dept_es_seq
\int_gzero_new:N \g__potrothesis_degree_cnt_es_int
\int_gzero_new:N \g__potrothesis_dept_cnt_es_int


\NewDocumentCommand\DegreeES{mm}
 {
	\int_compare:nNnTF { \g__potrothesis_dept_cnt_es_int } = {0} {
		\tl_if_blank:nTF {#1} {
			  \msg_error:nn { \ClassName } { no_degree_name_es }
			}{
			  \__potrothesis_gset_degree_name_es:n { #1 }
			  \int_gincr:N \g__potrothesis_degree_cnt_es_int
			}
		\tl_if_blank:nTF {#2} {
			  \msg_error:nn { \ClassName } { no_degree_dep_es }
			}{
			  \__potrothesis_gset_degree_dept_es:n { #2 }
			  \int_gincr:N \g__potrothesis_dept_cnt_es_int
			}
	}{
		\tl_if_blank:nTF {#1} {
			  \msg_warning:nn { \ClassName } { blank_degree_es }
			}{
			  \__potrothesis_gset_degree_name_es:n { #1 }
			  \int_gincr:N \g__potrothesis_degree_cnt_es_int
			}
		\tl_if_blank:nTF {#2} {
			  \msg_warning:nn { \ClassName } { blank_degree_dep_es }
			}{
			  \int_gincr:N \g__potrothesis_dept_cnt_es_int 
			  \__potrothesis_gset_degree_dept_es:n { #2 }
			}
	}
 }


 \cs_new_protected:Nn \__potrothesis_gset_degree_name_es:n
  {
	\seq_gput_right:Ne  \g__potrothesis_degree_name_es_seq  { \tl_trim_spaces:n {#1} } 
  }
 \cs_new_protected:Nn \__potrothesis_gset_degree_dept_es:n
  {
	\seq_gput_right:Ne  \g__potrothesis_degree_dept_es_seq  { \tl_trim_spaces:n {#1} }
  }


\msg_new:nnnn { \ClassName } { no_degree_name_es } 
		{ Missing~degree~name,~check~for\iow_newline: blank~in~\DegreeES~command. } 
		{ You~MUST~provide~at~least~one~degree~name~using~the~\DegreeES{name}{department}~command. }
\msg_new:nnnn { \ClassName } { no_degree_dep_es } 
		{ Missing~degree~department~for\iow_newline: DegreeES~command. }
		{ You~MUST~provide~at~least~one~department~name~using~--the~\DegreeES{name}{department}~command. }
\msg_new:nnn { \ClassName } { blank_degree_es } 
		{ Missing~degree~name~in~second~\DegreeES~command.\iow_newline: 
			Will~treat~this~as~two~departments~issuing~one~degree. }
\msg_new:nnn { \ClassName } { blank_degree_dep_es } 
		{ Missing~degree~department~in~second~\DegreeES~command.~Will~treat~as~one~department~issuing~two~degrees. }

\cs_new_protected:Nn \__potrothesis_degree_block: { \int_set:Nn  \l_tmpa_int {1} \int_set:Nn  \l_tmpb_int {1} \ifmit@spanish
		\int_compare:nNnT { \g__potrothesis_degree_cnt_es_int } = {0}
			{ 
			\msg_fatal:nn { \ClassName } { no_degree_es }
			}
		\tl_set:Ne   \l_tmpa_tl { \seq_item:NV \g__potrothesis_degree_dept_es_seq \l_tmpb_int }
	
	\else
		\int_compare:nNnT { \g__potrothesis_degree_cnt_int } = {0}
			{ 
			\msg_fatal:nn { \ClassName } { no_degree }
			}	
		\tl_set:Ne   \l_tmpa_tl { \seq_item:NV \g__potrothesis_degree_dept_seq \l_tmpb_int }
		{Submitted\ to\ the\ \l_tmpa_tl} 
		\int_until_do:nNnn { \l_tmpb_int } = { \g__potrothesis_dept_cnt_int } {
			\int_incr:N  \l_tmpb_int
			\tl_set:Ne   \l_tmpb_tl { \seq_item:NV \g__potrothesis_degree_dept_seq \l_tmpb_int }
			\mbox {\ and}\linebreak
			\mbox {the\ \l_tmpb_tl }
		}
		\linebreak 
	\fi

    \mbox {\l__mitthesis_str_fulfillment_tl\space
		\int_compare:nNnTF { \g__potrothesis_degree_cnt_int } > {1} {\l__mitthesis_str_degrees_tl} {\l__mitthesis_str_degree_tl}
	\ \l__mitthesis_str_of_tl\ }
	\par

	\ifmit@spanish
		\int_until_do:nNnn { \l_tmpa_int } = { \g__potrothesis_degree_cnt_es_int } {
			\textls[60]{ \text_uppercase:n { \seq_item:NV \g__potrothesis_degree_name_es_seq \l_tmpa_int } }\par y\par
			\int_incr:N     \l_tmpa_int
			}
		\textls[60]{\text_uppercase:n { \seq_item:NV \g__potrothesis_degree_name_es_seq \l_tmpa_int } }\par
	\else
		\int_until_do:nNnn { \l_tmpa_int } = { \g__potrothesis_degree_cnt_int } {
			\textls[60]{ \text_uppercase:n { \seq_item:NV \g__potrothesis_degree_name_seq \l_tmpa_int } }\par and\par
			\int_incr:N     \l_tmpa_int
			}
		\textls[60]{\text_uppercase:n { \seq_item:NV \g__potrothesis_degree_name_seq \l_tmpa_int } }\par
	\fi
}

\msg_new:nnnn { \ClassName } { no_degree }
		{ Missing~degree!~You~must\iow_newline: issue~the~\Degree{name}{department}~command. 
		}{
		  You~MUST~issue~the~\Degree{name}{department}~command~after~\string\begin{document}\space
		  and~before~\string\maketitle.~ You~do~want~the~degree,~don't~you?
		}
\msg_new:nnnn { \ClassName } { no_degree_es }
		{ Missing~degree~in~spanish!~You~must\iow_newline: issue~the~\DegreeES{name}{department}~command. 
		}{
		  You~MUST~issue~the~\DegreeES{name}{department}~command~after~\string\begin{document}\space
		  and~before~\string\maketitle.~ You~do~want~the~degree,~don't~you?
		}


\cs_new_protected:Nn \__potrothesis_degree_abstractblock: { \int_set:Nn  \l_tmpa_int {1}
	\int_set:Nn  \l_tmpb_int {1}
	\tl_set:Ne \l_tmpa_tl { \seq_item:NV \g__potrothesis_degree_dept_seq \l_tmpb_int }
	{Submitted\ to\ the\ \l_tmpa_tl} 
	\int_until_do:nNnn { \l_tmpb_int } = { \g__potrothesis_dept_cnt_int } {
		\int_incr:N      \l_tmpb_int
		\tl_set:Ne \l_tmpb_tl { \seq_item:NV \g__potrothesis_degree_dept_seq \l_tmpb_int }
		\mbox {\ and}\linebreak
		\mbox {the\ \l_tmpb_tl }
	}
    \linebreak \mbox{on\ \g_potrothesis_dd_thesisdate_tl\ in\ partial\ fulfillment\ of\ the\ requirements\ for\ the\ 
		\int_compare:nNnTF { \g__potrothesis_degree_cnt_int } > {1} { degrees } { degree }
	\ of}
	\skip_vertical:n { 6pt plus 2pt minus 2pt }
	\int_until_do:nNnn { \l_tmpa_int } = { \g__potrothesis_degree_cnt_int } {
    	\textls[60]{ \text_uppercase:n {\seq_item:NV \g__potrothesis_degree_name_seq \l_tmpa_int } } \par and \par
		\int_incr:N     \l_tmpa_int
		}
    \textls[60]{ \text_uppercase:n {\seq_item:NV \g__potrothesis_degree_name_seq \l_tmpa_int } }
    \skip_vertical:n { 6pt plus 2pt minus 2pt }
}
\cs_new_protected:Nn \__potrothesis_degree_abstractblock_es: {
    \int_set:Nn  \l_tmpa_int {1}
    \int_set:Nn  \l_tmpb_int {1}
    
\int_compare:nNnT { \g__potrothesis_degree_cnt_es_int } = {0}
        { 
          \msg_fatal:nn { \ClassName } { no_degree_es }
        }

    \tl_set:Ne \l_tmpa_tl { \seq_item:NV \g__potrothesis_degree_dept_es_seq \l_tmpb_int }   
\mbox {\l__mitthesis_str_fulfillment_tl\space
		\int_compare:nNnTF { \g__potrothesis_degree_cnt_int } > {1} {\l__mitthesis_str_degrees_tl} {\l__mitthesis_str_degree_tl}
	\ \l__mitthesis_str_of_tl\ }
	\par
    
    \skip_vertical:n { 6pt plus 2pt minus 2pt }
    
    \int_until_do:nNnn { \l_tmpa_int } = { \g__potrothesis_degree_cnt_es_int } {
        \textls[60]{ \text_uppercase:n {\seq_item:NV \g__potrothesis_degree_name_es_seq \l_tmpa_int } } \par y \par
        \int_incr:N     \l_tmpa_int
        }
    \textls[60]{ \text_uppercase:n {\seq_item:NV \g__potrothesis_degree_name_es_seq \l_tmpa_int } }
    
    \skip_vertical:n { 6pt plus 2pt minus 2pt }
}

\ExplSyntaxOff \ExplSyntaxOn
\cs_if_exist:NT \pdfmeta_xmp_add:n { \pdfmeta_xmp_add:n { <xmpRights:Marked>True</xmpRights:Marked> } }

\tl_new:N \g__potrothesis_copyright_ccname_tl
\tl_new:N \g__potrothesis_copyright_cclicense_tl
\tl_new:N \g__potrothesis_copyright_license_tl
\tl_new:N \g__potrothesis_copyright_pdfrights_tl
\tl_new:N \g__potrothesis_copyright_crwords_tl
\tl_new:N \g__potrothesis_copyright_mitpermlast_tl

\tl_new:N \g__potrothesis_copyright_mitpermission_tl
\tl_gset:Nn \g__potrothesis_copyright_mitpermlast_tl 
	{
	  to\ MIT\ a\ nonexclusive,\ worldwide,\ irrevocable,\ royalty-free\ license\ to\ exercise\ 
	  any\ and\ all\ rights\ under\ copyright,\ including\ to\ reproduce,\ preserve,\ distribute\ 
	  and\ publicly\ display\ copies\ of\ the\ thesis,\ or\ release\ the\  thesis\ under\ an\ 
	  open-access\ license.
	}

\bool_new:N \g__potrothesis_cclicense_bool
\bool_gset_false:N \g__potrothesis_cclicense_bool

\NewDocumentCommand\CClicense{mm}{
	\__potrothesis_gset_copyright_licensedata:nn {#1} {#2}
}
\cs_new_protected:Nn \__potrothesis_gset_copyright_licensedata:nn 
  {
	\tl_gset:Nf \g__potrothesis_copyright_cclicense_tl { \hrefurl{ \tl_trim_spaces:n {#2} }{ \tl_trim_spaces:n {#1} } } \tl_gset:Ne \g__potrothesis_copyright_ccname_tl        { \tl_trim_spaces:n {#1} } 
	\bool_gset_true:N \g__potrothesis_cclicense_bool
	\cs_if_exist:NT \pdfmeta_xmp_add:n {
			\pdfmeta_xmp_add:n { <xmpRights:WebStatement>#2</xmpRights:WebStatement> }
	}
	\cs_if_exist:NTF \msg_note:nnn {
		\msg_note:nnn { \ClassName } { cclicense} {#1}
	  }
	  {
		\msg_log:nnn  { \ClassName } { cclicense} {#1}
	  } 
  }
\msg_new:nnn { \ClassName } { cclicense } { Using~Creative~Commons~License~#1. }
\ExplSyntaxOff \ExplSyntaxOn
\RenewDocumentCommand\title{m}
	{
		\__potrothesis_gset_title:n { #1 }
		\cs_gset:Npe \@title { \tl_use:N \g_potrothesis_title_tl } \hypersetup{
			pdftitle={ { \g_potrothesis_title_tl } }, }
	}

\tl_new:N \g_potrothesis_title_tl

\cs_new_protected:Nn \__potrothesis_gset_title:n
	{
		\tl_gset:Nn \g_potrothesis_title_tl { \tl_trim_spaces:n {#1} }
	}

\tl_new:N \g_titlepage_institution_name_tl
\tl_gset:Nn \g_titlepage_institution_name_tl { Autonomous~University~of~the~State~of~Mexico } 
\cs_new_protected:Npn \Institution #1 { \tl_gset:Nn \g_titlepage_institution_name_tl { \tl_trim_spaces:n #1 } }




\NewDocumentCommand\titleES{m}{
	\__potrothesis_gset_title_es:n { #1 }
	\cs_gset:Npe \@title { \tl_use:N \g_potrothesis_title_es_tl } \hypersetup{
		pdftitle={ { \g_potrothesis_title_es_tl } }, }
}

\tl_new:N \g_potrothesis_title_es_tl

\cs_new_protected:Nn \__potrothesis_gset_title_es:n
	{
		\tl_gset:Nn \g_potrothesis_title_es_tl { \tl_trim_spaces:n {#1} }
	}

\tl_new:N \g_titlepage_institution_name_es_tl
\tl_gset:Nn \g_titlepage_institution_name_es_tl { Universidad~Autónoma~del~Estado~de~México }
\cs_new_protected:Npn \InstitutionES #1 { \tl_gset:Nn \g_potrothesis_institution_name_es_tl { \tl_trim_spaces:n #1 } }



\bool_new:N \g__potrothesis_title_squashglue_bool
\cs_new_protected:Nn \__potrothesis_titlepage_bottomskip: {
	\if_bool:N \g__potrothesis_title_squashglue_bool 
		{ 	\skip_vertical:n { 0pt plus 1filll  } }
	\else:
		{   \skip_vertical:n { 0pt plus 12fill } }
	\fi:
}
\NewDocumentCommand\Squash{}{ \bool_gset_true:N \g__potrothesis_title_squashglue_bool } 

\bool_new:N \g__potrothesis_title_tighten_bool
\cs_new_protected:Nn \__potrothesis_titlepage_blockskip:nn {
	\if_bool:N \g__potrothesis_title_tighten_bool 
		{ 	\skip_vertical:n { 6pt plus #2fill    } }
	\else:
		{   \skip_vertical:n { #1pt plus #2fill } }
	\fi:
}
\NewDocumentCommand\Tighten{}{ \bool_gset_true:N \g__potrothesis_title_tighten_bool } 

\bool_new:N        \g__potrothesis_LGO_bool
\bool_gset_false:N \g__potrothesis_LGO_bool
\tl_new:N          \g__potrothesis_LGO_tl
\tl_gset:Nn        \g__potrothesis_LGO_tl { in~conjunction~with~the~Leaders~for~Global~Operations~program \par }

\NewDocumentCommand\LGO{}{ \bool_gset_true:N \g__potrothesis_LGO_bool }

\NewDocumentCommand\TitlePageProgramNote{m}{\tl_gset:Nn       \g__potrothesis_LGO_tl   {#1 \par}
	\bool_gset_true:N \g__potrothesis_LGO_bool
}
\ExplSyntaxOff \ExplSyntaxOn
\NewDocumentCommand\SignatureBlockSize{m}{
	\__potrothesis_gset_signature_size:n {#1}
}

\tl_new:N \g__potrothesis_signature_size_tl
\cs_new_protected:Nn \__potrothesis_gset_signature_size:n 
  {
	\tl_gset:Nf \g__potrothesis_signature_size_tl { \tl_trim_spaces:n {#1} }
	\token_case_meaning:NnF \g__potrothesis_signature_size_tl
	{ 
		\normalsize {} \small {} \footnotesize{} \scriptsize{} \tiny{}
	} {
		\msg_error:nn { \ClassName } { weird_sigsize }
	}
  }
\msg_new:nnnn { \ClassName } { weird_sigsize }
		{ \SignatureBlockSize~expects~a~font-sizing~command,~such~as~\small,~\footnotesize,~etc.
		}{
		  You~used~a~weird~input~value~here.~If~you~did~so~deliberately,~try~continuing.
		}	

\cs_new_protected:Nn \__potrothesis_signature_block: {
	\int_compare:nNnT { \g__potrothesis_supervisor_cnt_int } = {0} {
		\msg_error:nn { \ClassName } { no_supervisor } }
	\ifmit@spanish
	{
		\int_compare:nNnTF { \g__potrothesis_supervisor_cnt_int } > {1} {
			Directores\ de\ tesis:\par
		}{
			Director\space de\space tesis:\par
		}
		\int_step_inline:nn { \g__potrothesis_supervisor_cnt_int }
		{
			\tag_struct_begin:n { tag = Span }
			\seq_item:Nn \g__potrothesis_supervisor_name_seq { ##1 } \\
			\seq_item:Nn \g__potrothesis_supervisor_title_es_seq { ##1 } \\[1em]
		}
	}
	\else
	{	
		\int_compare:nNnT { \g__potrothesis_acceptor_cnt_int } = {0} {
			\msg_error:nn { \ClassName } { no_acceptor }
		}	
		\tl_if_exist:NF \g_potrothesis_dd_thesisdate_tl { 
			\msg_error:nn { \ClassName } { no_thesis_date }
		}

		\g__potrothesis_signature_size_tl
		\dim_set:Nn \topsep {0pt}
		\dim_set:Nn \partopsep {0pt}
		\noindent
		{ \tagpdfsetup{table/tagging=presentation}
			\begin{tabular}{@{}ll@{}}
			\int_step_inline:nn { \g__potrothesis_author_cnt_int }
			{
				\tag_struct_begin:n { tag = Span }
				\tag_mc_begin:n { tag = Span }
					Authored\ by:
				\tag_mc_end:
				\tag_struct_end:
				& \seq_item:Nn \g__potrothesis_author_name_seq       { ##1 } \\
				& \seq_item:Nn \g__potrothesis_author_department_seq { ##1 } \\
				& \g_potrothesis_dd_thesisdate_tl \\[1em]
			}
		\int_step_inline:nn { \g__potrothesis_supervisor_cnt_int }
		{
			\tag_struct_begin:n { tag = Span }
			\tag_mc_begin:n { tag = Span }
				Certified\ by:
			\tag_mc_end:
			\tag_struct_end:
			& \seq_item:Nn \g__potrothesis_supervisor_name_seq  { ##1 } \\
			& \seq_item:Nn \g__potrothesis_supervisor_title_seq { ##1 } ,\ 
				\g__potrothesis_titlepg_sup_designation_tl \\[1em]
		}
			\int_compare:nNnF { \g__potrothesis_acceptor_cnt_int } = {0} {
				\int_step_inline:nn { \g__potrothesis_acceptor_cnt_int }
				{
					\tag_struct_begin:n { tag = Span }
					\tag_mc_begin:n { tag = Span }
						Accepted\ by:
					\tag_mc_end:
					\tag_struct_end:
					& \seq_item:Nn \g__potrothesis_acceptor_name_seq { ##1 } \\
					& \seq_item:Nn \g__potrothesis_acceptor_dept_seq { ##1 }
									\bool_if:NF \g__potrothesis_acceptor_title_bool
									{
										\\
										& \seq_item:Nn \g__potrothesis_acceptor_title_seq { ##1 }
									}
								\int_compare:nNnTF { ##1 } = { \g__potrothesis_acceptor_cnt_int } 
								{ \\ }{ \\[1em] }
				}
			}
			\end{tabular}
		}
	}
	\fi
}
\msg_new:nnnn { \ClassName } { no_acceptor }
		{ Missing~acceptor!You~must~issue~the~\Acceptor{name}{department}{title}~command.
		}{
		  You~MUST~issue~the~\Acceptor{name}{department}{title}~command~after~\string\begin{document}\space
		  and~before~\string\maketitle.
		}
\msg_new:nnnn { \ClassName } { no_thesis_date }
		{ Missing~thesis~date!~You~must~issue~the~\ThesisDate{Date~thesis~is~submitted}~command.
		}{
		  You~MUST~issue~the~\ThesisDate{Date~thesis~is~submitted}~command~after~\string\begin{document}\space
		  and~before~\string\maketitle.
		}

\NewDocumentCommand\SuppressAcceptorError{}
  {
  	\msg_redirect_name:nnn { \ClassName } { no_acceptor } { none }
  }
  
\ExplSyntaxOff 
\ExplSyntaxOn

\cs_new_protected:Nn \__potrothesis_english_title:
	{
		{ \centering
			\setlength{\parskip}{7.5pt plus 1pt minus 1pt} \setlength{\parindent}{0pt}\pdfbookmark[0]{Title\ Page}{titlepage}
			{
				\tag_struct_begin:n { tag = Title, title = Title }
				\leavevmode
				\tag_struct_begin:n { tag = Strong } \tag_mc_begin:n { tag = Strong }
				\Large\textbf{ \g_potrothesis_title_tl }
				\tag_mc_end:
				\tag_struct_end:
				\par
				\tag_struct_end:
			}
			\__potrothesis_titlepage_blockskip:nn {12}{1.5}
			\tag_struct_begin:n { tag = Author, title = Author }
			\__potrothesis_author_block:
			\tag_struct_end:
			\__potrothesis_titlepage_blockskip:nn {12}{1.5}
			\tag_struct_begin:n { tag = Degree, title = Degree } 
			\__potrothesis_degree_block:
			\bool_if:NT \g__potrothesis_LGO_bool { \g__potrothesis_LGO_tl }
			at~the\par
			\textls[60]{ \text_uppercase:n { \g_titlepage_institution_name_tl } } \par
			\DegreeMonth\ \DegreeYear\par
			\tag_struct_end:
			\__potrothesis_titlepage_blockskip:nn {12}{2}
			\tag_struct_begin:n { tag = Copyright, title = Copyright }
			\copyright\space\DegreeYear\space\CopyrightAuthor\@.\c_space_token \g__potrothesis_copyright_license_tl \par \tag_struct_end:
		}
		\__potrothesis_titlepage_blockskip:nn {18}{2}
		\tag_struct_begin:n { tag = Title_sig_block, title = Signatures }
		\__potrothesis_signature_block:
		\tag_struct_end:
		\__potrothesis_titlepage_bottomskip:
	}
\int_set:Nn  \l_tmpa_int {1} \int_set:Nn  \l_tmpb_int {1} \cs_new_protected:Nn \__potrothesis_spanish_title:
	{
		{ \centering
			\setlength{\parskip}{7.5pt plus 1pt minus 1pt} \setlength{\parindent}{0pt}\pdfbookmark[0]{Title\ Page}{titlepage}

			\begin{minipage}{\textwidth}
                \centering
                \includegraphics[height=2cm]{images/university.png}\hspace{0.6\textwidth}\includegraphics[height=2cm]{images/faculty.png}
            \end{minipage}
			\newline
			
			\__potrothesis_titlepage_blockskip:nn {28}{1.5}

			\tag_struct_begin:n { tag = Institution, title = Institution }
			\textls[60]{ \text_uppercase:n { \g_titlepage_institution_name_es_tl } } \par
			\tl_set:Ne   \l_tmpa_tl { \seq_item:NV \g__potrothesis_degree_dept_es_seq \l_tmpb_int }
			{\fontsize{10pt}{14pt}\selectfont\textls[60]{\text_uppercase:n {\l_tmpa_tl}}} 
			\int_until_do:nNnn { \l_tmpb_int } = { \g__potrothesis_dept_cnt_es_int } {
				\int_incr:N  \l_tmpb_int
				\tl_set:Ne   \l_tmpb_tl { \seq_item:NV \g__potrothesis_degree_dept_es_seq \l_tmpb_int }
				\linebreak
				\mbox {\fontsize{10pt}{14pt}\selectfont\textls[60]{\text_uppercase:n {\l_tmpb_tl}}}
			}
			\tag_struct_end:

			\__potrothesis_titlepage_blockskip:nn {28}{1.5}
			{
				\tag_struct_begin:n { tag = Title, title = Title }
				\leavevmode
				\tag_struct_begin:n { tag = Strong } \tag_mc_begin:n { tag = Strong }
				\Large\textbf{ \g_potrothesis_title_es_tl }
				\tag_mc_end:
				\tag_struct_end:
				\par
				\tag_struct_end:
			}

			\__potrothesis_titlepage_blockskip:nn {12}{1.5}
			\tag_struct_begin:n { tag = Degree, title = Degree } 
			\__potrothesis_degree_block:
			\tag_struct_end:

			\__potrothesis_titlepage_blockskip:nn {12}{1.5}
			\tag_struct_begin:n { tag = Author, title = Author }
			\__potrothesis_author_block:
			\tag_struct_end:

			\__potrothesis_titlepage_blockskip:nn {42}{5}
			\tag_struct_begin:n { tag = Title_sig_block, title = Signatures }
			\__potrothesis_signature_block:
			\tag_struct_end:

			\__potrothesis_titlepage_blockskip:nn {42}{5}
			\tag_struct_begin:n { tag = DegreeDate, title = DegreeDate }
			\DegreeMonthES\ \DegreeYear\par
			\tag_struct_end:

}
		\__potrothesis_titlepage_bottomskip:
	}

\RenewDocumentCommand\maketitle{s}{
	\cs_if_exist:NF \DegreeMonth { \msg_error:nn { \ClassName } { no_degree_date } } \bool_if:NTF \g__potrothesis_cclicense_bool { 
		\tl_gset:Nn \g__potrothesis_copyright_license_tl 
			{ This\ work\ is\ licensed\ under\ a\ \mbox{ \g__potrothesis_copyright_cclicense_tl }\ license.\par
			  \g__potrothesis_copyright_mitpermission_tl 
			}
		\tl_gset:Nn \g__potrothesis_copyright_pdfrights_tl 	 
			{ This\ work\ is\ licensed\ under\ a\ \g__potrothesis_copyright_ccname_tl\ license.\space 
			  \g__potrothesis_copyright_mitpermission_tl
			}
	}{
		\tl_gset:Nn \g__potrothesis_copyright_license_tl 
			{ All\ rights\ reserved. \par\g__potrothesis_copyright_mitpermission_tl }
		\tl_gset:Nn \g__potrothesis_copyright_pdfrights_tl 	 
			{ All\ rights\ reserved.\space \g__potrothesis_copyright_mitpermission_tl }
   }
   \int_compare:nNnTF { \g__potrothesis_author_cnt_int } > {1} 
   		{   
			\tl_gset:Nn \g__potrothesis_copyright_crwords_tl { The\ authors\ hereby\ grant } 
		}
		{
			\tl_gset:Nn \g__potrothesis_copyright_crwords_tl { The\ author\ hereby\ grants } 
		}
    \IfBooleanTF {#1}{
	    \tl_gset:Nn \g__potrothesis_copyright_mitpermission_tl { \scan_stop: }
    }{
	    \tl_gset:Nn \g__potrothesis_copyright_mitpermission_tl 
	    	{ \g__potrothesis_copyright_crwords_tl\ \g__potrothesis_copyright_mitpermlast_tl }
    }
\clearpage
	\thispagestyle{empty}
	\tag_struct_begin:n { tag = Sect, title = Titlepage }
	\vbox_to_ht:nn { \vsize } {
			\ifmit@spanish
				\__potrothesis_spanish_title:
			\else
				\__potrothesis_english_title:
			\fi
			\__potrothesis_titlepage_bottomskip:
		}
\hypersetup{
    		pdfcopyright={ Copyright\ \DegreeYear\ by\ \CopyrightAuthor.\space \g__potrothesis_copyright_pdfrights_tl },
    		pdfauthor={ \g__potrothesis_pdfcopyright_author_tl },
    		pdfcaptionwriter = { \g__potrothesis_pdfcopyright_author_tl },
    	}
	\cleardoublepage
	\int_compare:nNnF { \g__potrothesis_readercnt_int } = {0} { \__potrothesis_committee_block: }
}
\ExplSyntaxOff \ExplSyntaxOn


\tl_new:N   \g__potrothesis_reader_name_tl
\tl_gset:Nn \g__potrothesis_reader_name_tl {\l__mitthesis_str_reader_tl} 
\NewDocumentCommand\ThesisReaderName{ m } { 
		\tl_gset:Nn \g__potrothesis_reader_name_tl 
				{ \cs_if_exist:NTF \text_titlecase_all:n { \text_titlecase_all:n { \text_lowercase:n { \tl_trim_spaces:n {#1} } } }
					{ \tl_trim_spaces:n {#1} }
				}
		}
\cs_new_protected:Nn \__potrothesis_gset_supervisor_plurals: {
    \int_compare:nNnT { \g__potrothesis_supervisor_cnt_int } > {1} 
       	{   
    		\tl_gset:Nn \g__potrothesis_titlepg_sup_designation_tl { \l__mitthesis_str_sups_designation_tl } 
    	}
    \int_compare:nNnT { \g__potrothesis_readercnt_int } > {1} 
       	{   
    		\tl_gset:Nn \g__potrothesis_reader_name_tl { \l__mitthesis_str_readers_tl } 
    	}
}

\tl_new:N   \g__potrothesis_committee_name_tl
\tl_gset:Nn \g__potrothesis_committee_name_tl { \l__mitthesis_str_committee_tl } 
\NewDocumentCommand\ThesisCommitteeName{ m } { 
		\tl_gset:Nn \g__potrothesis_committee_name_tl 
				{ \cs_if_exist:NTF \text_uppercase:n { \text_uppercase:n { \tl_trim_spaces:n {#1} } }
					{ \MakeUpperCase{ \tl_trim_spaces:n {#1} } }
				}
		}

\bool_new:N \g__potrothesis_short_cmtitle_bool
\cs_new_protected:Nn \__potrothesis_cmtitle_blockskip: {
	\if_bool:N \g__potrothesis_short_cmtitle_bool 
		{ 	\skip_vertical:n { 32pt } }
	\else:
		{   \skip_vertical:n { 56pt } }
	\fi:
}
\NewDocumentCommand\CMPShortenTop{}{ \bool_gset_true:N \g__potrothesis_short_cmtitle_bool } 

\cs_new:Nn  \__potrothesis_CMstyle:n    { { \bfseries  \Large\lsstyle #1 } } 
\cs_new:Nn  \__potrothesis_CMsubstyle:n { { \normalfont\scshape\large\lsstyle #1 } }




\tl_const:Nn    \c__potrothesis_bsbs_tl { \\ }
\tl_const:Nn    \c__potrothesis_amp_tl  { \& }
\regex_const:Nn \c__potrothesis_split_lines_regex   { \u{c__potrothesis_bsbs_tl} \s* & }
\regex_const:Nn \c__potrothesis_fix_ampersand_regex { \u{c__potrothesis_amp_tl} }
\seq_new:N      \l__potrothesis_titles_seq
 
\cs_new_protected:Nn \__potrothesis_assemble_CMtitle_list:n
  {
    \tl_set:Nn \l_tmpa_tl {#1}
    \regex_replace_all:NnN \c__potrothesis_fix_ampersand_regex { and } \l_tmpa_tl
    \regex_split:NVN       \c__potrothesis_split_lines_regex   \l_tmpa_tl \l__potrothesis_titles_seq
    \seq_set_map:NNn       \l_tmpa_seq \l__potrothesis_titles_seq { \emph { ##1 } }
    \seq_use:Nnnn          \l_tmpa_seq { \\ & } { \\ & } { \\ & }
  }
\cs_generate_variant:Nn \__potrothesis_assemble_CMtitle_list:n { e }



\cs_new_protected:Nn \__potrothesis_committee_block_eng: {	
	\__potrothesis_gset_supervisor_plurals:
    \str_new:N   \g__potrothesis_committee_name_str
    \str_gset:Ne \g__potrothesis_committee_name_str 
    	{
		  \text_titlecase_all:n { \text_lowercase:n { \g__potrothesis_committee_name_tl } }
		}

	\vbox_to_ht:nn { \vsize } { 
		\tag_struct_begin:n { tag = Committee_page, title = Committee~page }
        	\leavevmode   
			\hbox:n {} 
        	\__potrothesis_cmtitle_blockskip:
			{ \raggedleft	 
            \tagpdfsetup{ table/tagging=presentation }
        	\begin{tabular*}{\textwidth}{@{}l@{\extracolsep{\fill}}r@{}}
             	&
				\tag_struct_begin:n { tag = Committee_name, title = Committee~name }
                \tag_struct_begin:n { tag = Strong }
                \tag_mc_begin:n { tag = Strong  }                
            	\__potrothesis_CMstyle:n { \g__potrothesis_committee_name_tl }
            	\tag_mc_end:
                \tag_struct_end:
                \tag_struct_end:
                \pdfbookmark[0]{ \g__potrothesis_committee_name_str }{ thesiscommittee }
        	\end{tabular*}
        	\__potrothesis_cmtitle_blockskip:
	
        	\begin{tabular*}{\textwidth}{@{}l@{\extracolsep{\fill}}r@{}}
    			&
				\tag_struct_begin:n { tag = Committee_block_title, title = Thesis~Supervisors }
				\tag_mc_begin:n { tag = Committee_block_title }
				\__potrothesis_CMsubstyle:n { \g__potrothesis_titlepg_sup_designation_tl }
				\tag_mc_end:
                \tag_struct_end:
        	\end{tabular*}
	
        	\skip_vertical:n {12pt} 
            \int_step_inline:nn { \g__potrothesis_supervisor_cnt_int } 	{	
                \begin{tabular*}{\textwidth}{@{}l@{\extracolsep{\fill}}r@{}}
        			&
                	\tag_struct_begin:n { tag = Strong }
                	\tag_mc_begin:n { tag = Strong }
        			\textbf{ \seq_item:Nn \g__potrothesis_supervisor_name_seq {##1} }
        			\tag_mc_end:
        			\tag_struct_end:
        			\\      
        			& \__potrothesis_assemble_CMtitle_list:e { \seq_item:Nn \g__potrothesis_supervisor_title_seq
						{##1} } \\ 
					& \__potrothesis_assemble_CMtitle_list:e { \seq_item:Nn \g__potrothesis_supervisor_dept_seq
						{##1} }
        		\end{tabular*}
        		\skip_vertical:n {14pt}
        	}
        	\skip_vertical:n {32pt}

	
        	\begin{tabular*}{\textwidth}{@{}l@{\extracolsep{\fill}}r@{}}
        		&
				\tag_struct_begin:n { tag = Committee_block_title, title = Thesis~Readers }
				\tag_mc_begin:n { tag = Committee_block_title }
				\__potrothesis_CMsubstyle:n { \g__potrothesis_reader_name_tl }
				\tag_mc_end:
            	\tag_struct_end:
	       	\end{tabular*}
        	\skip_vertical:n {12pt}
	
    	    \int_compare:nNnF { \g__potrothesis_readercnt_int } = {0} {
            \int_step_inline:nn { \g__potrothesis_readercnt_int } 	{	
                  	\begin{tabular*}{\textwidth}{@{}l@{\extracolsep{\fill}}r@{}}
        				&
                		\tag_struct_begin:n { tag = Strong }
        				\tag_mc_begin:n { tag = Strong }
        				\textbf{ \raggedleft 
							\seq_item:Nn \g__potrothesis_reader_name_seq {##1} }
        	    		\tag_mc_end:
                        \tag_struct_end:
                        \\
                	    & \__potrothesis_assemble_CMtitle_list:n { \seq_item:Nn \g__potrothesis_reader_title_seq
	    					{##1} } \\
                        & \__potrothesis_assemble_CMtitle_list:n { \seq_item:Nn \g__potrothesis_reader_department_seq
                        	{##1} }
        		   \end{tabular*}
        		\skip_vertical:n {14pt}
        		}
        	}
    	\tag_struct_end:
		}
		\skip_vertical:n { 0pt plus 16fill }
		}
	\cleardoublepage\ignorespacesafterend
}

\cs_new_protected:Nn \__potrothesis_committee_block_es: {	
		\__potrothesis_gset_supervisor_plurals:
    \str_new:N   \g__potrothesis_committee_name_str
    \str_gset:Ne \g__potrothesis_committee_name_str 
    	{
		  \text_titlecase_all:n { \text_lowercase:n { \g__potrothesis_committee_name_tl } }
		}

	\vbox_to_ht:nn { \vsize } { 
		\tag_struct_begin:n { tag = Committee_page, title = Committee~page }
        	\leavevmode   
			\hbox:n {} 
        	\__potrothesis_cmtitle_blockskip:
			{ \raggedleft	 
            \tagpdfsetup{ table/tagging=presentation }
        	\begin{tabular*}{\textwidth}{@{}l@{\extracolsep{\fill}}r@{}}
             	&
				\tag_struct_begin:n { tag = Committee_name, title = Committee~name }
                \tag_struct_begin:n { tag = Strong }
                \tag_mc_begin:n { tag = Strong  }                
            	\__potrothesis_CMstyle:n { \g__potrothesis_committee_name_tl }
            	\tag_mc_end:
                \tag_struct_end:
                \tag_struct_end:
                \pdfbookmark[0]{ \g__potrothesis_committee_name_str }{ thesiscommittee }
        	\end{tabular*}
        	\__potrothesis_cmtitle_blockskip:
	
        	\begin{tabular*}{\textwidth}{@{}l@{\extracolsep{\fill}}r@{}}
    			&
				\tag_struct_begin:n { tag = Committee_block_title, title = Thesis~Supervisors }
				\tag_mc_begin:n { tag = Committee_block_title }
				\__potrothesis_CMsubstyle:n { \g__potrothesis_titlepg_sup_designation_tl }
				\tag_mc_end:
                \tag_struct_end:
        	\end{tabular*}
	
        	\skip_vertical:n {12pt} 
            \int_step_inline:nn { \g__potrothesis_supervisor_cnt_int } 	{	
                \begin{tabular*}{\textwidth}{@{}l@{\extracolsep{\fill}}r@{}}
        			&
                	\tag_struct_begin:n { tag = Strong }
                	\tag_mc_begin:n { tag = Strong }
        			\textbf{ \seq_item:Nn \g__potrothesis_supervisor_name_seq {##1} }
        			\tag_mc_end:
        			\tag_struct_end:
        			\\      
        			& \__potrothesis_assemble_CMtitle_list:e { \seq_item:Nn \g__potrothesis_supervisor_title_es_seq
						{##1} } \\ 
					& \__potrothesis_assemble_CMtitle_list:e { \seq_item:Nn \g__potrothesis_supervisor_dept_es_seq
						{##1} }
        		\end{tabular*}
        		\skip_vertical:n {14pt}
        	}
        	\skip_vertical:n {32pt}

	
        	\begin{tabular*}{\textwidth}{@{}l@{\extracolsep{\fill}}r@{}}
        		&
				\tag_struct_begin:n { tag = Committee_block_title, title = Thesis~Readers }
				\tag_mc_begin:n { tag = Committee_block_title }
				\__potrothesis_CMsubstyle:n { \g__potrothesis_reader_name_tl }
				\tag_mc_end:
            	\tag_struct_end:
	       	\end{tabular*}
        	\skip_vertical:n {12pt}
	
    	    \int_compare:nNnF { \g__potrothesis_readercnt_int } = {0} {
            \int_step_inline:nn { \g__potrothesis_readercnt_int } 	{	
                  	\begin{tabular*}{\textwidth}{@{}l@{\extracolsep{\fill}}r@{}}
        				&
                		\tag_struct_begin:n { tag = Strong }
        				\tag_mc_begin:n { tag = Strong }
        				\textbf{ \raggedleft 
							\seq_item:Nn \g__potrothesis_reader_name_seq {##1} }
        	    		\tag_mc_end:
                        \tag_struct_end:
                        \\
                	    & \__potrothesis_assemble_CMtitle_list:n { \seq_item:Nn \g__potrothesis_reader_title_es_seq
	    					{##1} } \\
                        & \__potrothesis_assemble_CMtitle_list:n { \seq_item:Nn \g__potrothesis_reader_department_es_seq
                        	{##1} }
        		   \end{tabular*}
        		\skip_vertical:n {14pt}
        		}
        	}
    	\tag_struct_end:
		}
		\skip_vertical:n { 0pt plus 16fill }
		}
	\cleardoublepage\ignorespacesafterend
}

\cs_new_protected:Nn \__potrothesis_committee_block: {	
	\ifmit@spanish
		{ \__potrothesis_committee_block_es: }
	\else:
		{ \__potrothesis_committee_block_eng: }
	\fi:
}
\ExplSyntaxOff \ExplSyntaxOn
\addto\captionsenglish{\renewcommand{\abstractname}{Abstract}}
\RenewDocumentEnvironment{abstract}{+b}{
	\cleardoublepage \tag_struct_begin:n { tag = Abstract_page, title = Abstract~page }
    { \centering
    	\tag_struct_begin:n { tag = Abstract_title, title = Abstract~title }
        \pdfbookmark[0]{Abstract}{abstract}
        \leavevmode
        {\large 
			\tag_struct_begin:n { tag = Strong }
	        \tag_mc_begin:n     { tag = Strong }            
        	{ \textbf{ \g_potrothesis_title_tl } }
	        \tag_mc_end:
	        \tag_struct_end:
        \par}
        \tag_struct_end:
        \setlength{\parskip}{0.5\baselineskip plus 2pt minus 2pt}
        \__potrothesis_author_abstractblock:
        \par
        \__potrothesis_degree_abstractblock:
	}
    \skip_vertical:n {2\baselineskip}
    \noindent
    \tag_struct_begin:n { tag = Strong }
    \tag_mc_begin:n { tag = Strong }
	\textbf{ \text_uppercase:n { \abstractname } }
	\tag_mc_end:
    \tag_struct_end:
	\skip_vertical:n { 0.5em }
    \tag_struct_begin:n { tag = Abstract_text, title-o = \abstractname }
	#1
	\par\tag_struct_end:
	\tl_if_blank:nT {#1} { MISSING\ ABSTRACT!  \msg_error:nn { \ClassName } { missing_abstract } }
}{
    \__potrothesis_supervisor_abstractblock:
	\tag_struct_end: \cleardoublepage\ignorespacesafterend
}
\msg_new:nnnn { \ClassName } { missing_abstract } { Missing~Abstract!! } 
	{ No~file~was~input~for~the~abstract.~You~need~to~do~\string\input{abstract.tex}. }




\tl_new:N \g__potrothesis_abstractname_es_tl
\tl_gset:Nn \g__potrothesis_abstractname_es_tl { Resumen }

\NewDocumentCommand\abstractnameES { m }
  { \tl_gset:Nn \g__potrothesis_abstractname_es_tl {#1} }
\RenewExpandableDocumentCommand \abstractnameES {}
  { \g__potrothesis_abstractname_es_tl }

\NewDocumentEnvironment{abstractES}{+b}{
    \cleardoublepage \tag_struct_begin:n { tag = Abstract_page, title = Abstract~page~ES }
    { \centering
        \tag_struct_begin:n { tag = Abstract_title, title = Abstract~title~ES }
        \pdfbookmark[0]{Resumen}{abstractes}
        \leavevmode
        {\large 
            \tag_struct_begin:n { tag = Strong }
            \tag_mc_begin:n     { tag = Strong }            
            { \textbf{ \g_potrothesis_title_es_tl } } \tag_mc_end:
            \tag_struct_end:
        \par}
        \tag_struct_end:
        \setlength{\parskip}{0.5\baselineskip plus 2pt minus 2pt}
        \__potrothesis_degree_abstractblock_es:
        \par
        \__potrothesis_author_abstractblock_es:\par
    }
    \skip_vertical:n {2\baselineskip}
    \noindent
    \tag_struct_begin:n { tag = Strong }
    \tag_mc_begin:n { tag = Strong }
    \textbf{ \text_uppercase:n { \abstractnameES } }
    \tag_mc_end:
    \tag_struct_end:
    \skip_vertical:n { 0.5em }
    \tag_struct_begin:n { tag = Abstract_text, title-o = \abstractnameES }
    #1
    \par\tag_struct_end:
    \tl_if_blank:nT {#1} { MISSING\ ABSTRACT~ES!  \msg_error:nn { \ClassName } { missing_abstract_es } }
}{
    \__potrothesis_supervisor_abstractblock: \tag_struct_end: \cleardoublepage\ignorespacesafterend
}

\msg_new:nnnn { \ClassName } { missing_abstract_es } { Missing~Spanish~Abstract!! } 
    { No~file~was~input~for~the~Spanish~abstract.~You~need~to~do~\string\input{abstract-es.tex}. }



\ExplSyntaxOff 
\ExplSyntaxOn


\cs_new_protected:Nn \__potrothesis_note_comma: 
	{ 
	  \peek_meaning:NT \footnote { \textsuperscript{ \mdseries, } } 
	}
\IfFormatAtLeastTF{2025/11/01}{	\hook_gput_code:nnn {cmd/footnote/after}{footnotecomma}{ \exp_after:wN \__potrothesis_note_comma: } 
}{
	\cs_new_eq:NN \__potrothesis_savefootnote: \footnote
	\cs_gset_protected:Npn \footnote #1    { \__potrothesis_savefootnote: {#1} \__potrothesis_note_comma: } 
}

\ExplSyntaxOff \providecommand{\nomname}{Nomenclature}  
\newlength\nomenwidth
\newlength\savitemsep

\NewDocumentCommand\entry{m m}{\item[#1\hfill]#2\@itempenalty=-\@lowpenalty
}
\ExplSyntaxOn
\NewDocumentCommand\EntryHeading{m}{\itemsep3\p@ plus 1\p@ minus 1\p@
    \goodbreak
    \item[\tag_struct_begin:n { tag = Nomenclature_entry_heading } \emph{#1}\tag_struct_end: \hfill]\mbox{}\setlength{\itemsep}{\savitemsep}\@itempenalty=10000 }
\NewDocumentEnvironment{nomenclature}{O{2em} O{\nomname} O{section} O{#3}}{\setlength\columnsep{2em}\setlength{\nomenwidth}{#1}\tl_set:Ne \l_tmpa_tl { nomenclature\alph{section} }
    \tl_set:Ne \l_tmpb_tl {#2}
    \MakeLinkTarget*{\l_tmpa_tl}\csname #3\endcsname *{\l_tmpb_tl}\addcontentsline{toc}{#4}{#2}\raggedright
    \tag_struct_begin:n { tag = Nomenclature_list }
    \begin{list}{}{\setlength{\itemsep}{0pt}\setlength{\parsep}{\itemsep}\setlength{\labelsep}{1em}\setlength{\labelwidth}{\nomenwidth}\setlength{\leftmargin}{\labelwidth}\addtolength{\leftmargin}{\labelsep}\setlength{\savitemsep}{\itemsep}}}{	\end{list}
	\tag_struct_end:
	\ignorespacesafterend
 }

\NewDocumentEnvironment{nomenclature*}{ O{2em} O{\nomname} O{section} O{#3} }{\setlength\columnsep{2em}\setlength{\nomenwidth}{#1}\tl_set:Ne \l_tmpa_tl { nomenclature\alph{section} }
    \tl_set:Ne \l_tmpb_tl {#2}
    \MakeLinkTarget*{\l_tmpa_tl}\csname #3\endcsname *{\l_tmpb_tl}\addcontentsline{toc}{#4}{#2}\vspace{-\multicolsep}\tag_struct_begin:n { tag = Nomenclature_list }
	\begin{multicols}{2}\raggedright
    \begin{list}{}{\setlength{\itemsep}{0pt}\setlength{\parsep}{\itemsep}\setlength{\labelsep}{1em}\setlength{\labelwidth}{\nomenwidth}\setlength{\leftmargin}{\labelwidth}\addtolength{\leftmargin}{\labelsep}\setlength{\savitemsep}{\itemsep}}}{
	\end{list}
	\end{multicols}
	\tag_struct_end:
	\ignorespacesafterend
 }
\ExplSyntaxOff



 %
 
 %