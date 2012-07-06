" Vim syntax file
" Language: abc format file
" Maintainer: Lee Savide <laughingman182@gmail.com>
" Last Change:
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

if !exists("main_syntax")
    if version < 600
        syntax clear " Clear the syntax
    elseif has("b:current_syntax=1")
        finish
    endif
    let main_syntax = "abh"
endif

" Take the priority for PostScript datatypes & primitives.
syn case ignore
" PostScript syntax items {{{
syn match abcfmtHex "\<\x\{2,}\>"
" Integers
syn match abcfmtInteger "\<[+-]\=\d\+\>"
" Radix
syn match abcfmtRadix "\d\+#\x\+\>"
" Reals - upper and lower case e is allowed
syn match abcfmtFloat "[+-]\=\d\+\.\>" contained
syn match abcfmtFloat "[+-]\=\d\+\.\d*\(e[+-]\=\d\+\)\=\>" contained
syn match abcfmtFloat "[+-]\=\.\d\+\(e[+-]\=\d\+\)\=\>" contained
syn match abcfmtFloat "[+-]\=\d\+e[+-]\=\d\+\>" contained
syn cluster abcfmtNumber contains=abcfmtInteger,abcfmtRadix,abcfmtFloat
" }}}
syn case match

" Entities {{{
" NOTE: Even though the Unicode C string sequences ought to allow mixed case for
" the hexadecimal characters, the initial '\u' is required to be lowercase, or
" the sequence would represent a 16-bit Unicode character. So case preserving it
" is.
syn match abcfmtEntity /\C\\`A\|&Agrave;\|\\u00c0/  contained conceal cchar=À
syn match abcfmtEntity /\C\\`a\|&agrave;\|\\u00e0/  contained conceal cchar=à
syn match abcfmtEntity /\C\\`E\|&Egrave;\|\\u00c8/  contained conceal cchar=È
syn match abcfmtEntity /\C\\`e\|&egrave;\|\\u00e8/  contained conceal cchar=è
syn match abcfmtEntity /\C\\`I\|&Igrave;\|\\u00cc/  contained conceal cchar=Ì
syn match abcfmtEntity /\C\\`i\|&igrave;\|\\u00ec/  contained conceal cchar=ì
syn match abcfmtEntity /\C\\`O\|&Ograve;\|\\u00d2/  contained conceal cchar=Ò
syn match abcfmtEntity /\C\\`o\|&ograve;\|\\u00f2/  contained conceal cchar=ò
syn match abcfmtEntity /\C\\`U\|&Ugrave;\|\\u00d9/  contained conceal cchar=Ù
syn match abcfmtEntity /\C\\`u\|&ugrave;\|\\u00f9/  contained conceal cchar=ù
syn match abcfmtEntity /\C\\'A\|&Aacute;\|\\u00c1/  contained conceal cchar=Á
syn match abcfmtEntity /\C\\'a\|&aacute;\|\\u00e1/  contained conceal cchar=á
syn match abcfmtEntity /\C\\'E\|&Eacute;\|\\u00c9/  contained conceal cchar=É
syn match abcfmtEntity /\C\\'e\|&eacute;\|\\u00e9/  contained conceal cchar=é
syn match abcfmtEntity /\C\\'I\|&Iacute;\|\\u00cd/  contained conceal cchar=Í
syn match abcfmtEntity /\C\\'i\|&iacute;\|\\u00ed/  contained conceal cchar=í
syn match abcfmtEntity /\C\\'O\|&Oacute;\|\\u00d3/  contained conceal cchar=Ó
syn match abcfmtEntity /\C\\'o\|&oacute;\|\\u00f3/  contained conceal cchar=ó
syn match abcfmtEntity /\C\\'U\|&Uacute;\|\\u00da/  contained conceal cchar=Ú
syn match abcfmtEntity /\C\\'u\|&uacute;\|\\u00fa/  contained conceal cchar=ú
syn match abcfmtEntity /\C\\'Y\|&Yacute;\|\\u00dd/  contained conceal cchar=Ý
syn match abcfmtEntity /\C\\'y\|&yacute;\|\\u00fd/  contained conceal cchar=ý
syn match abcfmtEntity /\C\\^A\|&Acirc;\|\\u00c2/   contained conceal cchar=Â
syn match abcfmtEntity /\C\\^a\|&acirc;\|\\u00e2/   contained conceal cchar=â
syn match abcfmtEntity /\C\\^E\|&Ecirc;\|\\u00ca/   contained conceal cchar=Ê
syn match abcfmtEntity /\C\\^e\|&ecirc;\|\\u00ea/   contained conceal cchar=ê
syn match abcfmtEntity /\C\\^I\|&Icirc;\|\\u00ce/   contained conceal cchar=Î
syn match abcfmtEntity /\C\\^i\|&icirc;\|\\u00ee/   contained conceal cchar=î
syn match abcfmtEntity /\C\\^O\|&Ocirc;\|\\u00d4/   contained conceal cchar=Ô
syn match abcfmtEntity /\C\\^o\|&ocirc;\|\\u00f4/   contained conceal cchar=ô
syn match abcfmtEntity /\C\\^U\|&Ucirc;\|\\u00db/   contained conceal cchar=Û
syn match abcfmtEntity /\C\\^u\|&ucirc;\|\\u00fb/   contained conceal cchar=û
syn match abcfmtEntity /\C\\^Y\|&Ycirc;\|\\u0176/   contained conceal cchar=Ŷ
syn match abcfmtEntity /\C\\^y\|&ycirc;\|\\u0177/   contained conceal cchar=ŷ
syn match abcfmtEntity /\C\\~A\|&Atilde;\|\\u00c3/  contained conceal cchar=Ã
syn match abcfmtEntity /\C\\~a\|&atilde;\|\\u00e3/  contained conceal cchar=ã
syn match abcfmtEntity /\C\\~N\|&Ntilde;\|\\u00d1/  contained conceal cchar=Ñ
syn match abcfmtEntity /\C\\~n\|&ntilde;\|\\u00f1/  contained conceal cchar=ñ
syn match abcfmtEntity /\C\\~O\|&Otilde;\|\\u00d5/  contained conceal cchar=Õ
syn match abcfmtEntity /\C\\~o\|&otilde;\|\\u00f5/  contained conceal cchar=õ
syn match abcfmtEntity /\C\\"A\|&Auml;\|\\u00c4/    contained conceal cchar=Ä
syn match abcfmtEntity /\C\\"a\|&auml;\|\\u00e4/    contained conceal cchar=ä
syn match abcfmtEntity /\C\\"E\|&Euml;\|\\u00cb/    contained conceal cchar=Ë
syn match abcfmtEntity /\C\\"e\|&euml;\|\\u00eb/    contained conceal cchar=ë
syn match abcfmtEntity /\C\\"I\|&Iuml;\|\\u00cf/    contained conceal cchar=Ï
syn match abcfmtEntity /\C\\"i\|&iuml;\|\\u00ef/    contained conceal cchar=ï
syn match abcfmtEntity /\C\\"O\|&Ouml;\|\\u00d6/    contained conceal cchar=Ö
syn match abcfmtEntity /\C\\"o\|&ouml;\|\\u00f6/    contained conceal cchar=ö
syn match abcfmtEntity /\C\\"U\|&Uuml;\|\\u00dc/    contained conceal cchar=Ü
syn match abcfmtEntity /\C\\"u\|&uuml;\|\\u00fc/    contained conceal cchar=ü
syn match abcfmtEntity /\C\\"Y\|&Yuml;\|\\u0178/    contained conceal cchar=Ÿ
syn match abcfmtEntity /\C\\"y\|&yuml;\|\\u00ff/    contained conceal cchar=ÿ
syn match abcfmtEntity /\C\\cC\|&Ccedil;\|\\u00c7/  contained conceal cchar=Ç
syn match abcfmtEntity /\C\\cc\|&ccedil;\|\\u00e7/  contained conceal cchar=ç
syn match abcfmtEntity /\C\\AA\|&Aring;\|\\u00c5/   contained conceal cchar=Å
syn match abcfmtEntity /\C\\aa\|&aring;\|\\u00e5/   contained conceal cchar=å
syn match abcfmtEntity /\C\\\/O\|&Oslash;\|\\u00d8/ contained conceal cchar=Ø
syn match abcfmtEntity /\C\\\/o\|&oslash;\|\\u00f8/ contained conceal cchar=ø
syn match abcfmtEntity /\C\\uA\|&Abreve;\|\\u0102/  contained conceal cchar=Ă
syn match abcfmtEntity /\C\\ua\|&abreve;\|\\u0103/  contained conceal cchar=ă
syn match abcfmtEntity /\C\\uE\|\\u0114/            contained conceal cchar=Ĕ
syn match abcfmtEntity /\C\\ue\|\\u0115/            contained conceal cchar=ĕ
syn match abcfmtEntity /\C\\vS\|&Scaron;\|\\u0160/  contained conceal cchar=Š
syn match abcfmtEntity /\C\\vs\|&scaron;\|\\u0161/  contained conceal cchar=š
syn match abcfmtEntity /\C\\vZ\|&Zcaron;\|\\u017d/  contained conceal cchar=Ž
syn match abcfmtEntity /\C\\vz\|&zcaron;\|\\u017e/  contained conceal cchar=ž
syn match abcfmtEntity /\C\\HO\|\\u0150/            contained conceal cchar=Ő
syn match abcfmtEntity /\C\\Ho\|\\u0151/            contained conceal cchar=ő
syn match abcfmtEntity /\C\\HU\|\\u0170/            contained conceal cchar=Ű
syn match abcfmtEntity /\C\\Hu\|\\u0171/            contained conceal cchar=ű
syn match abcfmtEntity /\C\\AE\|&AElig;\|\\u00c6/   contained conceal cchar=Æ
syn match abcfmtEntity /\C\\ae\|&aelig;\|\\u00e6/   contained conceal cchar=æ
syn match abcfmtEntity /\C\\OE\|&OElig;\|\\u0152/   contained conceal cchar=Œ
syn match abcfmtEntity /\C\\oe\|&oelig;\|\\u0153/   contained conceal cchar=œ
syn match abcfmtEntity /\C\\ss\|&szlig;\|\\u00df/   contained conceal cchar=ß
syn match abcfmtEntity /\C\\DH\|&ETH;\|\\u00d0/     contained conceal cchar=Ð
syn match abcfmtEntity /\C\\dh\|&eth;\|\\u00f0/     contained conceal cchar=ð
syn match abcfmtEntity /\C\\TH\|&THORN;\|\\u00de/   contained conceal cchar=Þ
syn match abcfmtEntity /\C\\th\|&thorn;\|\\u00fe/   contained conceal cchar=þ
syn match abcfmtEntity /\C&copy;\|\\u00a9/          contained conceal cchar=©
syn match abcfmtEntity /\c&266d;\|\\u266d/          contained conceal cchar=♭
syn match abcfmtEntity /\c&266e;\|\\u266e/          contained conceal cchar=♮
syn match abcfmtEntity /\c&266f;\|\\u266f/          contained conceal cchar=♯
syn match abcfmtEntity /\C&quot;\|\\u0022/ contained conceal cchar="
" }}}
syn match abcfmtEscapeChar /\\%/ contained
syn match abcfmtEscapeChar /\\\\/ contained
syn match abcfmtEscapeChar /\\\&/ contained

syn match abcfmtSetFontChar /\$[0-4]/ contained

syn match abcfmtQuoteChar /"/ contained
syn match abcfmtReservedChar /#\|\*\|;\|?\|@/ contained
syn match abcfmtBarChar /\%(|\|\[\|\]\)\{1,2}/ contained


syn keyword abcfmtBoolean contained true false on off yes no
syn keyword abcfmtSize contained in cm pt
syn keyword abcfmtEncoding contained utf-8 us-ascii iso-8859-1 iso-8859-2 iso-8859-3 iso-8859-4 iso-8859-5 iso-8859-6 iso-8859-7 iso-8859-8 iso-8859-9 iso-8859-10
syn keyword abcfmtEncoding contained utf-8 us-ascii native
syn keyword abcfmtDirectiveLock contained lock
" Lock Keyword {{{ 'lock' is allowed in all directives, and must set that a setting is no longer
" able to be set any where else in the same tune. If contained on a global, it
" sets that the directive is unsettable in all tunes.
" }}}
" PostScript Fonts {{{
syn keyword abcfmtFont contained AlbertusMT AlbertusMT-Italic AlbertusMT-Light Apple-Chancery Apple-ChanceryCE
syn keyword abcfmtFont contained AntiqueOlive-Roman AntiqueOlive-Italic AntiqueOlive-Bold AntiqueOlive-Compact
syn keyword abcfmtFont contained AntiqueOliveCE-Roman AntiqueOliveCE-Italic AntiqueOliveCE-Bold AntiqueOliveCE-Compact
syn keyword abcfmtFont contained ArialMT Arial-ItalicMT Arial-LightMT Arial-BoldMT Arial-BoldItalicMT
syn keyword abcfmtFont contained ArialCE ArialCE-Italic ArialCE-Light ArialCE-Bold ArialCE-BoldItalic
syn keyword abcfmtFont contained AvantGarde-Book AvantGarde-BookOblique AvantGarde-Demi AvantGarde-DemiOblique
syn keyword abcfmtFont contained AvantGardeCE-Book AvantGardeCE-BookOblique AvantGardeCE-Demi AvantGardeCE-DemiOblique
syn keyword abcfmtFont contained Bodoni Bodoni-Italic Bodoni-Bold Bodoni-BoldItalic Bodoni-Poster Bodoni-PosterCompressed
syn keyword abcfmtFont contained BodoniCE BodoniCE-Italic BodoniCE-Bold BodoniCE-BoldItalic BodoniCE-Poster BodoniCE-PosterCompressed
syn keyword abcfmtFont contained Bookman-Light Bookman-LightItalic Bookman-Demi Bookman-DemiItalic
syn keyword abcfmtFont contained BookmanCE-Light BookmanCE-LightItalic BookmanCE-Demi BookmanCE-DemiItalic
syn keyword abcfmtFont contained Carta Chicago ChicagoCE Clarendon Clarendon-Light Clarendon-Bold
syn keyword abcfmtFont contained ClarendonCE ClarendonCE-Light ClarendonCE-Bold CooperBlack CooperBlack-Italic
syn keyword abcfmtFont contained Copperplate-ThirtyTwoBC CopperPlate-ThirtyThreeBC Coronet-Regular CoronetCE-Regular
syn keyword abcfmtFont contained CourierCE CourierCE-Oblique CourierCE-Bold CourierCE-BoldOblique
syn keyword abcfmtFont contained Eurostile Eurostile-Bold Eurostile-ExtendedTwo Eurostile-BoldExtendedTwo
syn keyword abcfmtFont contained Eurostile EurostileCE-Bold EurostileCE-ExtendedTwo EurostileCE-BoldExtendedTwo
syn keyword abcfmtFont contained Geneva GenevaCE GillSans GillSans-Italic GillSans-Bold GillSans-BoldItalic GillSans-BoldCondensed
syn keyword abcfmtFont contained GillSans-Light GillSans-LightItalic GillSans-ExtraBold
syn keyword abcfmtFont contained GillSansCE-Roman GillSansCE-Italic GillSansCE-Bold GillSansCE-BoldItalic GillSansCE-BoldCondensed
syn keyword abcfmtFont contained GillSansCE-Light GillSansCE-LightItalic GillSansCE-ExtraBold
syn keyword abcfmtFont contained Goudy Goudy-Italic Goudy-Bold Goudy-BoldItalic Goudy-ExtraBould
syn keyword abcfmtFont contained HelveticaCE HelveticaCE-Oblique HelveticaCE-Bold HelveticaCE-BoldOblique
syn keyword abcfmtFont contained Helvetica-Condensed Helvetica-Condensed-Oblique Helvetica-Condensed-Bold Helvetica-Condensed-BoldObl
syn keyword abcfmtFont contained HelveticaCE-Condensed HelveticaCE-Condensed-Oblique HelveticaCE-Condensed-Bold
syn keyword abcfmtFont contained HelveticaCE-Condensed-BoldObl Helvetica-Narrow Helvetica-Narrow-Oblique Helvetica-Narrow-Bold
syn keyword abcfmtFont contained Helvetica-Narrow-BoldOblique HelveticaCE-Narrow HelveticaCE-Narrow-Oblique HelveticaCE-Narrow-Bold
syn keyword abcfmtFont contained HelveticaCE-Narrow-BoldOblique HoeflerText-Regular HoeflerText-Italic HoeflerText-Black
syn keyword abcfmtFont contained HoeflerText-BlackItalic HoeflerText-Ornaments HoeflerTextCE-Regular HoeflerTextCE-Italic
syn keyword abcfmtFont contained HoeflerTextCE-Black HoeflerTextCE-BlackItalic
syn keyword abcfmtFont contained JoannaMT JoannaMT-Italic JoannaMT-Bold JoannaMT-BoldItalic
syn keyword abcfmtFont contained JoannaMTCE JoannaMTCE-Italic JoannaMTCE-Bold JoannaMTCE-BoldItalic
syn keyword abcfmtFont contained LetterGothic LetterGothic-Slanted LetterGothic-Bold LetterGothic-BoldSlanted
syn keyword abcfmtFont contained LetterGothicCE LetterGothicCE-Slanted LetterGothicCE-Bold LetterGothicCE-BoldSlanted
syn keyword abcfmtFont contained LubalinGraph-Book LubalinGraph-BookOblique LubalinGraph-Demi LubalinGraph-DemiOblique
syn keyword abcfmtFont contained LubalinGraphCE-Book LubalinGraphCE-BookOblique LubalinGraphCE-Demi LubalinGraphCE-DemiOblique
syn keyword abcfmtFont contained Marigold Monaco MonacoCE MonaLisa-Recut Oxford Symbol Tekton
syn keyword abcfmtFont contained NewCennturySchlbk-Roman NewCenturySchlbk-Italic NewCenturySchlbk-Bold NewCenturySchlbk-BoldItalic
syn keyword abcfmtFont contained NewCenturySchlbkCE-Roman NewCenturySchlbkCE-Italic NewCenturySchlbkCE-Bold
syn keyword abcfmtFont contained NewCenturySchlbkCE-BoldItalic NewYork NewYorkCE
syn keyword abcfmtFont contained Optima Optima-Italic Optima-Bold Optima-BoldItalic
syn keyword abcfmtFont contained OptimaCE OptimaCE-Italic OptimaCE-Bold OptimaCE-BoldItalic
syn keyword abcfmtFont contained Palatino-Roman Palatino-Italic Palatino-Bold Palatino-BoldItalic
syn keyword abcfmtFont contained PalatinoCE-Roman PalatinoCE-Italic PalatinoCE-Bold PalatinoCE-BoldItalic
syn keyword abcfmtFont contained StempelGaramond-Roman StempelGaramond-Italic StempelGaramond-Bold StempelGaramond-BoldItalic
syn keyword abcfmtFont contained StempelGaramondCE-Roman StempelGaramondCE-Italic StempelGaramondCE-Bold StempelGaramondCE-BoldItalic
syn keyword abcfmtFont contained TimesCE-Roman TimesCE-Italic TimesCE-Bold TimesCE-BoldItalic
syn keyword abcfmtFont contained TimesNewRomanPSMT TimesNewRomanPS-ItalicMT TimesNewRomanPS-BoldMT TimesNewRomanPS-BoldItalicMT
syn keyword abcfmtFont contained TimesNewRomanCE TimesNewRomanCE-Italic TimesNewRomanCE-Bold TimesNewRomanCE-BoldItalic
syn keyword abcfmtFont contained Univers Univers-Oblique Univers-Bold Univers-BoldOblique
syn keyword abcfmtFont contained UniversCE-Medium UniversCE-Oblique UniversCE-Bold UniversCE-BoldOblique
syn keyword abcfmtFont contained Univers-Light Univers-LightOblique UniversCE-Light UniversCE-LightOblique
syn keyword abcfmtFont contained Univers-Condensed Univers-CondensedOblique Univers-CondensedBold Univers-CondensedBoldOblique
syn keyword abcfmtFont contained UniversCE-Condensed UniversCE-CondensedOblique UniversCE-CondensedBold UniversCE-CondensedBoldOblique
syn keyword abcfmtFont contained Univers-Extended Univers-ExtendedObl Univers-BoldExt Univers-BoldExtObl
syn keyword abcfmtFont contained UniversCE-Extended UniversCE-ExtendedObl UniversCE-BoldExt UniversCE-BoldExtObl
syn keyword abcfmtFont contained Wingdings-Regular ZapfChancery-MediumItalic ZapfChanceryCE-MediumItalic ZapfDingBats

syn keyword abcfmtFontEncoding contained utf-8 us-ascii native
" }}}
" Boolean directives
syn keyword abcfmtDirective contained abc2pscompat autoclef breakoneoln 






"vim:ts=4:sw=4:fdm=marker:fdc=3
