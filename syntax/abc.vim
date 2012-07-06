" Vim syntax file
" Language: abc music notation includes
" Maintainer: Lee Savide <laughingman182@gmail.com>
" Last Change: 2012-06-28 Thu 11:05 PM
" GetLatestVimScripts: ### ### yourscriptname
" License:
" {{{
"   Copyright 2012 Lee Savide
" 
"   Licensed under the Apache License, Version 2.0 (the "License");
"   you may not use this file except in compliance with the License.
"   You may obtain a copy of the License at
" 
"       http://www.apache.org/licenses/LICENSE-2.0
" 
"   Unless required by applicable law or agreed to in writing, software
"   distributed under the License is distributed on an "AS IS" BASIS,
"   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
"   See the License for the specific language governing permissions and
"   limitations under the License.
" }}}
" Load PostScript and SVG syntax. PostScript is native to abc code, SVG is to
" support SVG content. HTML code is technically supported this way, for XHTML.


if !exists("main_syntax")
    runtime! syntax/postscr.vim
    unlet b:current_syntax
    runtime! syntax/svg.vim
    unlet b:current_syntax
    if version < 600
        syntax clear " Clear the syntax
        syntax sync clear " Clear the syntax syncing
    elseif has("b:current_syntax=1")
        finish
    endif
    let main_syntax = "abh"
endif

" Take the priority for PostScript datatypes & primitives
syn case ignore
syn match abcHex "\<\x\{2,}\>"
" Integers
syn match abcInteger "\<[+-]\=\d\+\>"
" Radix
syn match abcRadix "\d\+#\x\+\>"
" Reals - upper and lower case e is allowed
syn match abcFloat "[+-]\=\d\+\.\>" contained
syn match abcFloat "[+-]\=\d\+\.\d*\(e[+-]\=\d\+\)\=\>" contained
syn match abcFloat "[+-]\=\.\d\+\(e[+-]\=\d\+\)\=\>" contained
syn match abcFloat "[+-]\=\d\+e[+-]\=\d\+\>" contained
syn cluster abcNumber contains=abcInteger,abcRadix,abcFloat
" }}}
syn case match
" Free text has least priority
syn region abcFreeText start="^\s*$" excludenl skip="\_.$" excludenl end="^\s*$" contains=abcEscapeChar,abcEntity
" Comments {{{
" Remark fields should be treated as abc's form of multiline comments. For
" normal comments, you ought to use the single percent sign, '%', but for
" multiline comments, it ought to be accepted that any form of comment in abc is
" meant to be ignored by parsers. Whether the remark, either as a normal or
" inline field, is continued, the parser won't care. It's a comment, and it's
" not important to the code...it's for the composer's convienience.}}}
syn region abcRemark start="^r:" excludenl end="$" oneline keepend nextgroup=abcFieldContinue skipwhite skipnl fold
syn region abcRemark start="\[r:[^%]*" end="\]" contained keepend fold
" BOM Markers {{{
" EF BB BF
"   utf-8
" FE FF
" utf-16 big endian
" FF FE
" utf-16 little endian
" 00 00 FE FF
" utf-32 big endian
" FF FE 00 00
" utf-32 little endian
" }}}
" External syntax clusters {{{
" abcPostScript contains all toplevel PostScript items
syn cluster abcPostScript contains=postscrComment,postscrConstant,postscrString,postscrNumber,postscrFloat,postscrBoolean,postscrIdentifier,postscrProcedure,postscrName,postscrConditional,postscrRepeat,postscrOperator,postscrDSCComment,postscrSpecialChar,postscrTodo,postscrError,postscrGSOperator,postscrGSMathOperator
" abcXML contains all toplevel XML syntax items
syn cluster abcXML contains=xmlTodo,xmlTag,xmlTagName,xmlEndTag,xmlNamespace,xmlEntity,xmlEntityPunct,xmlAttribPunct,xmlAttrib,xmlString,xmlComment,xmlCommentPart,xmlCommentError,xmlError,xmlProcessingDelim,xmlProcessing,xmlCdata,xmlCdataCdata,xmlCdataStart,xmlCdataEnd,xmlDocTypeDecl,xmlDocTypeKeyword,xmlInlineDTD
" }}}
" Entities {{{
" NOTE: Even though the Unicode C string sequences ought to allow mixed case for
" the hexadecimal characters, the initial '\u' is required to be lowercase, or
" the sequence would represent a 16-bit Unicode character. So case preserving it
" is.
syn match abcEntity "\C\\`A\|&Agrave;\|\\u00c0"  contained conceal cchar=À
syn match abcEntity "\C\\`a\|&agrave;\|\\u00e0"  contained conceal cchar=à
syn match abcEntity "\C\\`E\|&Egrave;\|\\u00c8"  contained conceal cchar=È
syn match abcEntity "\C\\`e\|&egrave;\|\\u00e8"  contained conceal cchar=è
syn match abcEntity "\C\\`I\|&Igrave;\|\\u00cc"  contained conceal cchar=Ì
syn match abcEntity "\C\\`i\|&igrave;\|\\u00ec"  contained conceal cchar=ì
syn match abcEntity "\C\\`O\|&Ograve;\|\\u00d2"  contained conceal cchar=Ò
syn match abcEntity "\C\\`o\|&ograve;\|\\u00f2"  contained conceal cchar=ò
syn match abcEntity "\C\\`U\|&Ugrave;\|\\u00d9"  contained conceal cchar=Ù
syn match abcEntity "\C\\`u\|&ugrave;\|\\u00f9"  contained conceal cchar=ù
syn match abcEntity "\C\\'A\|&Aacute;\|\\u00c1"  contained conceal cchar=Á
syn match abcEntity "\C\\'a\|&aacute;\|\\u00e1"  contained conceal cchar=á
syn match abcEntity "\C\\'E\|&Eacute;\|\\u00c9"  contained conceal cchar=É
syn match abcEntity "\C\\'e\|&eacute;\|\\u00e9"  contained conceal cchar=é
syn match abcEntity "\C\\'I\|&Iacute;\|\\u00cd"  contained conceal cchar=Í
syn match abcEntity "\C\\'i\|&iacute;\|\\u00ed"  contained conceal cchar=í
syn match abcEntity "\C\\'O\|&Oacute;\|\\u00d3"  contained conceal cchar=Ó
syn match abcEntity "\C\\'o\|&oacute;\|\\u00f3"  contained conceal cchar=ó
syn match abcEntity "\C\\'U\|&Uacute;\|\\u00da"  contained conceal cchar=Ú
syn match abcEntity "\C\\'u\|&uacute;\|\\u00fa"  contained conceal cchar=ú
syn match abcEntity "\C\\'Y\|&Yacute;\|\\u00dd"  contained conceal cchar=Ý
syn match abcEntity "\C\\'y\|&yacute;\|\\u00fd"  contained conceal cchar=ý
syn match abcEntity "\C\\^A\|&Acirc;\|\\u00c2"   contained conceal cchar=Â
syn match abcEntity "\C\\^a\|&acirc;\|\\u00e2"   contained conceal cchar=â
syn match abcEntity "\C\\^E\|&Ecirc;\|\\u00ca"   contained conceal cchar=Ê
syn match abcEntity "\C\\^e\|&ecirc;\|\\u00ea"   contained conceal cchar=ê
syn match abcEntity "\C\\^I\|&Icirc;\|\\u00ce"   contained conceal cchar=Î
syn match abcEntity "\C\\^i\|&icirc;\|\\u00ee"   contained conceal cchar=î
syn match abcEntity "\C\\^O\|&Ocirc;\|\\u00d4"   contained conceal cchar=Ô
syn match abcEntity "\C\\^o\|&ocirc;\|\\u00f4"   contained conceal cchar=ô
syn match abcEntity "\C\\^U\|&Ucirc;\|\\u00db"   contained conceal cchar=Û
syn match abcEntity "\C\\^u\|&ucirc;\|\\u00fb"   contained conceal cchar=û
syn match abcEntity "\C\\^Y\|&Ycirc;\|\\u0176"   contained conceal cchar=Ŷ
syn match abcEntity "\C\\^y\|&ycirc;\|\\u0177"   contained conceal cchar=ŷ
syn match abcEntity "\C\\~A\|&Atilde;\|\\u00c3"  contained conceal cchar=Ã
syn match abcEntity "\C\\~a\|&atilde;\|\\u00e3"  contained conceal cchar=ã
syn match abcEntity "\C\\~N\|&Ntilde;\|\\u00d1"  contained conceal cchar=Ñ
syn match abcEntity "\C\\~n\|&ntilde;\|\\u00f1"  contained conceal cchar=ñ
syn match abcEntity "\C\\~O\|&Otilde;\|\\u00d5"  contained conceal cchar=Õ
syn match abcEntity "\C\\~o\|&otilde;\|\\u00f5"  contained conceal cchar=õ
syn match abcEntity /\C\\"A\|&Auml;\|\\u00c4/    contained conceal cchar=Ä
syn match abcEntity /\C\\"a\|&auml;\|\\u00e4/    contained conceal cchar=ä
syn match abcEntity /\C\\"E\|&Euml;\|\\u00cb/    contained conceal cchar=Ë
syn match abcEntity /\C\\"e\|&euml;\|\\u00eb/    contained conceal cchar=ë
syn match abcEntity /\C\\"I\|&Iuml;\|\\u00cf/    contained conceal cchar=Ï
syn match abcEntity /\C\\"i\|&iuml;\|\\u00ef/    contained conceal cchar=ï
syn match abcEntity /\C\\"O\|&Ouml;\|\\u00d6/    contained conceal cchar=Ö
syn match abcEntity /\C\\"o\|&ouml;\|\\u00f6/    contained conceal cchar=ö
syn match abcEntity /\C\\"U\|&Uuml;\|\\u00dc/    contained conceal cchar=Ü
syn match abcEntity /\C\\"u\|&uuml;\|\\u00fc/    contained conceal cchar=ü
syn match abcEntity /\C\\"Y\|&Yuml;\|\\u0178/    contained conceal cchar=Ÿ
syn match abcEntity /\C\\"y\|&yuml;\|\\u00ff/    contained conceal cchar=ÿ
syn match abcEntity "\C\\cC\|&Ccedil;\|\\u00c7"  contained conceal cchar=Ç
syn match abcEntity "\C\\cc\|&ccedil;\|\\u00e7"  contained conceal cchar=ç
syn match abcEntity "\C\\AA\|&Aring;\|\\u00c5"   contained conceal cchar=Å
syn match abcEntity "\C\\aa\|&aring;\|\\u00e5"   contained conceal cchar=å
syn match abcEntity "\C\\\/O\|&Oslash;\|\\u00d8" contained conceal cchar=Ø
syn match abcEntity "\C\\\/o\|&oslash;\|\\u00f8" contained conceal cchar=ø
syn match abcEntity "\C\\uA\|&Abreve;\|\\u0102"  contained conceal cchar=Ă
syn match abcEntity "\C\\ua\|&abreve;\|\\u0103"  contained conceal cchar=ă
syn match abcEntity "\C\\uE\|\\u0114"            contained conceal cchar=Ĕ
syn match abcEntity "\C\\ue\|\\u0115"            contained conceal cchar=ĕ
syn match abcEntity "\C\\vS\|&Scaron;\|\\u0160"  contained conceal cchar=Š
syn match abcEntity "\C\\vs\|&scaron;\|\\u0161"  contained conceal cchar=š
syn match abcEntity "\C\\vZ\|&Zcaron;\|\\u017d"  contained conceal cchar=Ž
syn match abcEntity "\C\\vz\|&zcaron;\|\\u017e"  contained conceal cchar=ž
syn match abcEntity "\C\\HO\|\\u0150"            contained conceal cchar=Ő
syn match abcEntity "\C\\Ho\|\\u0151"            contained conceal cchar=ő
syn match abcEntity "\C\\HU\|\\u0170"            contained conceal cchar=Ű
syn match abcEntity "\C\\Hu\|\\u0171"            contained conceal cchar=ű
syn match abcEntity "\C\\AE\|&AElig;\|\\u00c6"   contained conceal cchar=Æ
syn match abcEntity "\C\\ae\|&aelig;\|\\u00e6"   contained conceal cchar=æ
syn match abcEntity "\C\\OE\|&OElig;\|\\u0152"   contained conceal cchar=Œ
syn match abcEntity "\C\\oe\|&oelig;\|\\u0153"   contained conceal cchar=œ
syn match abcEntity "\C\\ss\|&szlig;\|\\u00df"   contained conceal cchar=ß
syn match abcEntity "\C\\DH\|&ETH;\|\\u00d0"     contained conceal cchar=Ð
syn match abcEntity "\C\\dh\|&eth;\|\\u00f0"     contained conceal cchar=ð
syn match abcEntity "\C\\TH\|&THORN;\|\\u00de"   contained conceal cchar=Þ
syn match abcEntity "\C\\th\|&thorn;\|\\u00fe"   contained conceal cchar=þ
syn match abcEntity "\C&copy;\|\\u00a9"          contained conceal cchar=©
syn match abcEntity "\c&266d;\|\\u266d"          contained conceal cchar=♭
syn match abcEntity "\c&266e;\|\\u266e"          contained conceal cchar=♮
syn match abcEntity "\c&266f;\|\\u266f"          contained conceal cchar=♯
syn match abcEntity "\C&quot;\|\\u0022" contained conceal cchar="
" }}}
syn match abcEscapeChar "\\%" contained
syn match abcEscapeChar "\\\\" contained
syn match abcEscapeChar "\\\&" contained

syn match abcSetFontChar "\$[0-4]" contained

syn match abcQuoteChar /"/ contained
syn match abcReservedChar "#\|\*\|;\|?\|@" contained
syn match abcBarChar "\%(|\|\[\|\]\)\{1,2}" contained

" abc Comments = PostScript Comments (postscrComment)

syn keyword abcBoolean contained true false on off yes no
syn match abcBoolean contained "1\|0"

syn keyword abcSize contained in cm pt
syn keyword abcEncoding contained us-ascii utf-8 iso-8859-1 latin1 iso-8859-2 latin2 iso-8859-3 latin3 iso-8859-4 latin4 iso-8859-9 latin5 iso-8859-10 latin6
"syn keyword abcDirectiveLock contained lock
" Lock Keyword {{{
" 'lock' is allowed in all directives, and must set that a setting is no longer
" able to be set any where else in the same tune. If contained on a global, it
" sets that the directive is unsettable in all tunes.
" }}}
" Fonts {{{
syn keyword abcFont contained AlbertusMT AlbertusMT-Italic AlbertusMT-Light Apple-Chancery Apple-ChanceryCE
syn keyword abcFont contained AntiqueOlive-Roman AntiqueOlive-Italic AntiqueOlive-Bold AntiqueOlive-Compact
syn keyword abcFont contained AntiqueOliveCE-Roman AntiqueOliveCE-Italic AntiqueOliveCE-Bold AntiqueOliveCE-Compact
syn keyword abcFont contained ArialMT Arial-ItalicMT Arial-LightMT Arial-BoldMT Arial-BoldItalicMT
syn keyword abcFont contained ArialCE ArialCE-Italic ArialCE-Light ArialCE-Bold ArialCE-BoldItalic
syn keyword abcFont contained AvantGarde-Book AvantGarde-BookOblique AvantGarde-Demi AvantGarde-DemiOblique
syn keyword abcFont contained AvantGardeCE-Book AvantGardeCE-BookOblique AvantGardeCE-Demi AvantGardeCE-DemiOblique
syn keyword abcFont contained Bodoni Bodoni-Italic Bodoni-Bold Bodoni-BoldItalic Bodoni-Poster Bodoni-PosterCompressed
syn keyword abcFont contained BodoniCE BodoniCE-Italic BodoniCE-Bold BodoniCE-BoldItalic BodoniCE-Poster BodoniCE-PosterCompressed
syn keyword abcFont contained Bookman-Light Bookman-LightItalic Bookman-Demi Bookman-DemiItalic
syn keyword abcFont contained BookmanCE-Light BookmanCE-LightItalic BookmanCE-Demi BookmanCE-DemiItalic
syn keyword abcFont contained Carta Chicago ChicagoCE Clarendon Clarendon-Light Clarendon-Bold
syn keyword abcFont contained ClarendonCE ClarendonCE-Light ClarendonCE-Bold CooperBlack CooperBlack-Italic
syn keyword abcFont contained Copperplate-ThirtyTwoBC CopperPlate-ThirtyThreeBC Coronet-Regular CoronetCE-Regular
syn keyword abcFont contained CourierCE CourierCE-Oblique CourierCE-Bold CourierCE-BoldOblique
syn keyword abcFont contained Eurostile Eurostile-Bold Eurostile-ExtendedTwo Eurostile-BoldExtendedTwo
syn keyword abcFont contained Eurostile EurostileCE-Bold EurostileCE-ExtendedTwo EurostileCE-BoldExtendedTwo
syn keyword abcFont contained Geneva GenevaCE GillSans GillSans-Italic GillSans-Bold GillSans-BoldItalic GillSans-BoldCondensed
syn keyword abcFont contained GillSans-Light GillSans-LightItalic GillSans-ExtraBold
syn keyword abcFont contained GillSansCE-Roman GillSansCE-Italic GillSansCE-Bold GillSansCE-BoldItalic GillSansCE-BoldCondensed
syn keyword abcFont contained GillSansCE-Light GillSansCE-LightItalic GillSansCE-ExtraBold
syn keyword abcFont contained Goudy Goudy-Italic Goudy-Bold Goudy-BoldItalic Goudy-ExtraBould
syn keyword abcFont contained HelveticaCE HelveticaCE-Oblique HelveticaCE-Bold HelveticaCE-BoldOblique
syn keyword abcFont contained Helvetica-Condensed Helvetica-Condensed-Oblique Helvetica-Condensed-Bold Helvetica-Condensed-BoldObl
syn keyword abcFont contained HelveticaCE-Condensed HelveticaCE-Condensed-Oblique HelveticaCE-Condensed-Bold
syn keyword abcFont contained HelveticaCE-Condensed-BoldObl Helvetica-Narrow Helvetica-Narrow-Oblique Helvetica-Narrow-Bold
syn keyword abcFont contained Helvetica-Narrow-BoldOblique HelveticaCE-Narrow HelveticaCE-Narrow-Oblique HelveticaCE-Narrow-Bold
syn keyword abcFont contained HelveticaCE-Narrow-BoldOblique HoeflerText-Regular HoeflerText-Italic HoeflerText-Black
syn keyword abcFont contained HoeflerText-BlackItalic HoeflerText-Ornaments HoeflerTextCE-Regular HoeflerTextCE-Italic
syn keyword abcFont contained HoeflerTextCE-Black HoeflerTextCE-BlackItalic
syn keyword abcFont contained JoannaMT JoannaMT-Italic JoannaMT-Bold JoannaMT-BoldItalic
syn keyword abcFont contained JoannaMTCE JoannaMTCE-Italic JoannaMTCE-Bold JoannaMTCE-BoldItalic
syn keyword abcFont contained LetterGothic LetterGothic-Slanted LetterGothic-Bold LetterGothic-BoldSlanted
syn keyword abcFont contained LetterGothicCE LetterGothicCE-Slanted LetterGothicCE-Bold LetterGothicCE-BoldSlanted
syn keyword abcFont contained LubalinGraph-Book LubalinGraph-BookOblique LubalinGraph-Demi LubalinGraph-DemiOblique
syn keyword abcFont contained LubalinGraphCE-Book LubalinGraphCE-BookOblique LubalinGraphCE-Demi LubalinGraphCE-DemiOblique
syn keyword abcFont contained Marigold Monaco MonacoCE MonaLisa-Recut Oxford Symbol Tekton
syn keyword abcFont contained NewCennturySchlbk-Roman NewCenturySchlbk-Italic NewCenturySchlbk-Bold NewCenturySchlbk-BoldItalic
syn keyword abcFont contained NewCenturySchlbkCE-Roman NewCenturySchlbkCE-Italic NewCenturySchlbkCE-Bold
syn keyword abcFont contained NewCenturySchlbkCE-BoldItalic NewYork NewYorkCE
syn keyword abcFont contained Optima Optima-Italic Optima-Bold Optima-BoldItalic
syn keyword abcFont contained OptimaCE OptimaCE-Italic OptimaCE-Bold OptimaCE-BoldItalic
syn keyword abcFont contained Palatino-Roman Palatino-Italic Palatino-Bold Palatino-BoldItalic
syn keyword abcFont contained PalatinoCE-Roman PalatinoCE-Italic PalatinoCE-Bold PalatinoCE-BoldItalic
syn keyword abcFont contained StempelGaramond-Roman StempelGaramond-Italic StempelGaramond-Bold StempelGaramond-BoldItalic
syn keyword abcFont contained StempelGaramondCE-Roman StempelGaramondCE-Italic StempelGaramondCE-Bold StempelGaramondCE-BoldItalic
syn keyword abcFont contained TimesCE-Roman TimesCE-Italic TimesCE-Bold TimesCE-BoldItalic
syn keyword abcFont contained TimesNewRomanPSMT TimesNewRomanPS-ItalicMT TimesNewRomanPS-BoldMT TimesNewRomanPS-BoldItalicMT
syn keyword abcFont contained TimesNewRomanCE TimesNewRomanCE-Italic TimesNewRomanCE-Bold TimesNewRomanCE-BoldItalic
syn keyword abcFont contained Univers Univers-Oblique Univers-Bold Univers-BoldOblique
syn keyword abcFont contained UniversCE-Medium UniversCE-Oblique UniversCE-Bold UniversCE-BoldOblique
syn keyword abcFont contained Univers-Light Univers-LightOblique UniversCE-Light UniversCE-LightOblique
syn keyword abcFont contained Univers-Condensed Univers-CondensedOblique Univers-CondensedBold Univers-CondensedBoldOblique
syn keyword abcFont contained UniversCE-Condensed UniversCE-CondensedOblique UniversCE-CondensedBold UniversCE-CondensedBoldOblique
syn keyword abcFont contained Univers-Extended Univers-ExtendedObl Univers-BoldExt Univers-BoldExtObl
syn keyword abcFont contained UniversCE-Extended UniversCE-ExtendedObl UniversCE-BoldExt UniversCE-BoldExtObl
syn keyword abcFont contained Wingdings-Regular ZapfChancery-MediumItalic ZapfChanceryCE-MediumItalic ZapfDingBats

syn keyword abcFontEncoding contained utf-8 us-ascii native
" }}}


syn match abcBeginText "^%%begintext \%(justify\|\)" contained
syn region abcTypesetText start="^%%begintext\%( \%(obeylines\|align\|justify\|ragged\|fill\|center\|skip\|right\)\)\=" end="^%%endtext" contains=abcTextOption




syn region abcPSDirective start="%%beginps" end="%%endps" contains=@abcPostScript
syn region abcSVGDirective start="" end="" contains=@abcXML

syn region abcDirective start="^\%(I:\|%%\)\h[\w\d-]*" excludenl end=" " contains=abcBoolDirective,abcFontDirective,abcUnitDirective,abcIntDirective,abcTextDirective,abcFloatDirective,abcMiscDirective
syn match abcDirective "^%%repbra" nextgroup=abcBoolean skipwhite
syn match abcDirective "%%tuplets" nextgroup=abcInteger,abcInteger,abcInteger skipwhite
syn match abcDirective "^%%\%(newpage\|setbarnb\)" nextgroup=abcInteger

syn keyword abcBoolDirective abc2pscompat autoclef breakoneoln bstemdown comball combinevoices contbarnb continueall custos dynalign gchordbox graceslurs hyphencont infoline landscape linewarn measurebox musiconly oneperpage pango partsbox setdefl shiftunisson splittune squarebreve staffnonote straightflags stretchlast stretchstaff timewarn titleleft titletrim  vocalabove contained nextgroup=abcBoolean

syn keyword abcIntDirective alignbars aligncomposer barnumbers dynamic gchord measurefirst measurenb ornament pdfmark textoption vocal volume
"'encoding' allows for integer arguments
syn match abcDirective "^%%staff" nextgroup=abcInteger skipwhite " the integer must be signed
syn match abcDirective "transpose" " REQUIRES an integer, and can include an optional '#' or 'b'
"'tablature' includes an integer

" TODO - float directives
"lineskipfac maxshrink notespacingfactor parskipfac scale slurheight stemheight 
"'gracespace' uses 3 floats




syn match abcRepeatEnd "\%(|\|\[\)\%([1-9]\%([,-][2-9]\)*\)\=" contained



syn match abcString "[^%]*" contains=abcSetFont,abcEntity,abcEscapeChar contained
syn region abcString contains=abcSetFont,abcEntity,abcEscapeChar matchgroup=abcQuoteChar start=/"/ end=/"/ matchgroup=abcFieldIdentifier start=/^[A-DGHNO+]:\zs[^%]*/ matchgroup=NONE excludenl end=/$/
syn region abcString start="^F:\zs[^#]*" excludenl end="$" oneline contains=abcEscapeChar


syn match abcFieldID "^[^r]:"













syn match abcFieldContinue "^+:" contained extend









syn region abcRepeat start="\z(|\|\[\|\]\)\z(:\+\)" skip="::\|:|:\|:||:\|\z1[1-9]\%([,-][2-9]\)*" end="\z2\z1" keepend contains=BarChar,RepeatBarChar,RepeatEnd
" containedin=abcCodeLine

" COMPLETED {{{
syn region abcTune matchgroup=TuneStart start="^X:" excludenl end="^\s*$" contains=TuneHeader,TuneBody,TypesetText fold
syn match abcVersion "%abc\%(-[1-9]\.\d\)\=" nextgroup=Comment,FileHeader skipwhite skipnl
syn region abcFile start="\%^" matchgroup=abcVersion start="^%abc" matchgroup=NONE end="\%$" contains=ALL
" }}}


if version >= 508 || !exists("did_abc_syntax_inits")
    if version < 508
        let did_abc_syntax_inits = 1
        command -nargs=+ HiLink hi link <args>
    else
        command -nargs=+ HiLink hi def link <args>
    endif
" Title*
" ErrorMsg*
" WarningMsg*
" SpellBad*
" SpellCap*
" SpellRare*
" SpellLocal*
" Constant* String Character Number Boolean Float
" Special* Tag SpecialChar Delimiter SpecialComment Debug
" Identifier* Function Subtitle
" Statement* Conditional Repeat Label Operator Keyword Exception
" PreProc* Include Define Macro PreCondit
" Type* StorageClass Structure Typedef
" Underlined*
" Error*
" Todo*
" vimPatRegion*

      "HiLink <group> <hiGroup>
      delcommand HiLink
endif

let b:current_syntax = "abc"

"vim:ts=4
