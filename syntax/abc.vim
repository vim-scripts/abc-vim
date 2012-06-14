" Vim syntax file
" Language: abc music programming language
" Maintainer: Lee Savide <leesavide@gmail.com>
" URL: http://abc-standard.googlecode.com/trunk/vim/vimfiles/syntax/abc2.vim
" Last Change: 2012-05-09 Wed 08:42 PM
" License: http://www.apache.org/licenses/LICENSE-2.0.html
" See Also: http://www.ietf.org/rfc/rfc2119.txt
" GetLatestScript: 

" Except where otherwise noted, content of these comments are licensed under the
" following license: CC Attribution-Noncommercial-Share Alike 3.0 Unported

"   Copyright 2012 Lee Savide <leesavide@gmail.com>
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

if version < 600
    syntax clear
elseif exists("b:current_syntax")
    finish
endif

" NOTES - 'hSyntaxGroup' is specifically a highlighting group. 'SyntaxGroup' is
" a semantical group meant for matching certain regions for other scripts to
" provide functions for editing those particular regions of text in abc code.
" 'AbcSyntaxGroup' is typically a toplevel group; these groups may be used for
" both highlighting or semantics of the abc standard.

" TODO - Determine which groups must be contained, and which are truly
" toplevel. Create some means of using the 'sync' syntax operator Vim offers,
" so that large ABC files don't lose their highlighting like normal.

" TODO - Make a autocommand to check that each tune has one and ONLY one 'X:'
" field, and that there is at LEAST one 'T:' field, IMMEDIATELY after the 'X:'
" field on the next line.
" Sadly, the skip pattern below wasn't able to create that kind of behavior.
"skip=/\%(^T:\)\+\&\%(^[A-DF-IK-XZmr]:\)*/

" COMPLETED PATTERNS: AbcFile, AbcStart, FileHeader, AbcTune, TuneHeader,
" TuneBody, ReservedChars, FieldID, RemarkID, IFieldID, 

"sy match BOM /\uFEFF/ conceal cchar= 

sy region AbcFile start=/^%abc\%(-[1-9]\.\d\)\=/ end=/\%$/ keepend contains=AbcTune,AbcTypesetText,AbcFreeText nextgroup=AbcFileHeader skipwhite skipnl
sy match AbcStart /^%abc\%(-[1-9]\.\d\)\=\ze/ " sets the string '%abc' apart from comments
sy region AbcFileHeader start=/^%abc\%(-[1-9]\.\d\)\=\zs\%(\_^[A-DF-IL-ORSUZmr]:\p*\)*\ze/ end=/^\s*$/ keepend matchgroup=AbcFieldID contains=AbcDirective,AbcComment

sy region AbcFreeText start=/^\%([^%]\|\)/ end=/^\s*$/ keepend contained contains=AbcSetFontOp containedin=AbcFile

sy region AbcTypesetText start=/\%(^%%\)*/ end=// keepend contained contains=AbcDirective

sy region AbcTune start=/^X:/ end=/^\s*$/ keepend contains=AbcTuneHeader,AbcTuneBody
sy region AbcTuneHeader start=/\%(^X:\)\{1}/ end=/^K:.*\ze$/ keepend matchgroup=AbcFieldID contains=AbcDirective,AbcComment nextgroup=AbcTuneBody skipnl
" 'In effect, music code is the contents of any line which is not an
" information field, stylesheet directive or comment line.'
sy region AbcTuneBody start=/^[^#*;?@]\+/ skip=/^\%([I-Z]:\|%\{1,2}\).*$/ end=/^\s*$/ keepend contains=AbcFieldID,AbcIFieldID,AbcDirective,@AbcMusicCode,AbcReservedChars,AbcComment contained
sy match AbcReservedChars /[#*;?@]/ containedin=AbcTuneBody contained
sy match AbcFieldID /^[A-DF-IL-ORSUZm]:/ containedin=AbcFileHeader
sy match AbcFieldID /^[A-DF-IK-XZm]:/ containedin=AbcTuneHeader
sy match AbcFieldID /^[IK-NP-RT-Wmsw]:/ containedin=AbcTuneBody
sy match AbcRemarkID /^r:/ containedin=AbcFileHeader,AbcTuneHeader,AbcTuneBody

sy match AbcIFieldID /\[[IK-NP-RUVm]:/ containedin=AbcTuneBody
sy match AbcIRemarkID /\[r:/ containedin=AbcTuneBody

sy region StringField start=/^[A-DF-HNORSTZ]:/ end=/\%([\w\s-]\|$[0-4]\)*\ze\%($\|%\)\{1}/ keepend oneline contained nextgroup=AbcFieldContinue skipnl matchgroup=FieldID contains=@AbcMnemonics,AbcUnicode,AbcSetFontOp containedin=AbcFileHeader,AbcTuneHeader,AbcTuneBody

" PATTERN TESTED - SUCCEEDED - DO NOT EDIT :D
sy region AbcInstructionField start=/^I:/ end=/[\w\s-]*\ze\%($\|%\)\{1}/ keepend oneline nextgroup=AbcFieldContinue skipnl matchgroup=AbcFieldID contains=AbcDirectiveName,AbcDirectiveParam containedin=AbcFileHeader,AbcTuneHeader,AbcTuneBody
sy region AbcInstructionField start=/\[I:/ end=/\]/ keepend oneline contained matchgroup=AbcIFieldID contains=AbcDirectiveName,AbcDirectiveParam containedin=AbcTuneBody
" K-NP-RUVmr]:\)\{1}/ end=/\]\{1}/ keepend oneline contains= containedin=TuneBody

sy region AbcRemark start=/^r:/ end=/.*\ze$/ keepend oneline contained matchgroup=AbcRemarkID contains=AbcComment
sy region AbcRemark start=/\[r:/ end=/[^%\]]*\zs\]/ keepend oneline contained matchgroup=AbcIRemarkID
sy match AbcComment /\zs%\{1}[^%]*\ze$/ fold nextgroup=AbcComment skipnl



sy region AbcSymbolField start=/^s:/ end=/[\w\s-]*\ze\%($\|%\)\{1}/ keepend oneline contained nextgroup=AbcFieldContinue skipnl matchgroup=AbcFieldID contains=AbcSymbol,AbcNoteSkip containedin=AbcTuneBody





sy region AbcKeyField start=/^K:/ end=/[\w\s-]*\ze\%($\|%\)\{1}/ keepend oneline matchgroup=AbcFieldID contains=AbcKeyTonic,AbcKeyMode,AbcKeyExp,@AbcClef containedin=AbcTuneHeader,AbcTuneBody
sy region AbcKeyField start=/\[K:/ end=/\]/ keepend oneline matchgroup=AbcIFieldID contains=AbcKeyTonic,AbcKeyMode,AbcKeyExp,@AbcClef containedin=AbcTuneHeader,AbcTuneBody

sy match KeyTonic /\%([A-G][b#]\=\)/ contained nextgroup=AbcKeyAccidental contains=AbcNote containedin=AbcKeyField
sy keyword AbcKeyTonic Hp HP contained nextgroup=AbcKeyExp containedin=AbcKeyTonic
sy match AbcKeyAccidental /[b#]/ contained containedin=AbcKeyTonic
sy match KeyMode /\c\%(m\%[inor]\|maj\%[or]\|ion\%[ian]\|mix\%[olydian]\|dor\%[ian]\|phr\%[ygian]\|lyd\%[ian]\|loc\%[rian]\)\=/ contained containedin=KeyField
sy case ignore
sy keyword AbcKeyMode maj[or] m[inor] ion[ian] aeo[lian] mix[olydian] dor[ian] phr[ygian] lyd[ian] loc[rian] contained containedin=KeyField
sy case match
sy match AbcKeyExp /\%( exp\)\=\%( \%(\%([_^]\{1,2}\|=\)\=[a-g]\)\)*/ contained contains=AbcAccidental,Note containedin=KeyField

sy cluster AbcClef contains=ClefName,ClefMiddle,ClefTranspose,ClefOctave,ClefStafflines containedin=KeyField,VoiceField
sy match AbcClefName / \%(clef=\)\=\%(treble\|alto\|tenor\|bass\|perc\|none\)\=/ contained nextgroup=ClefLine containedin=@Clef
sy match AbcClefLine /[2-4]\=/ contained nextgroup=Clef8
sy match AbcClef8 /\%([+-]8\)\=/ contained
sy match AbcClefMiddle / \%(m\%(iddle\)\==[A-Ga-g]\)\=/ contained containedin=@Clef
sy match AbcClefTranspose / \%(t\%(ranspose\)\==\%([+-]\=\d\)\)\=/ contained containedin=@Clef
sy match AbcClefOctave / \%(o\%(ctave\)\==\%(\)\)\=/ contained containedin=@Clef
sy match AbcClefStafflines / \%(s\%(tafflines\)\==[1-5]\)\=/ contained containedin=@Clef

" TODO - edit 'AbcNote.vim' separately to organize the clustering and order of
" what makes up an 'AbcNote'

sy region AbcRepeat start=/[|\[]\z(:\+\)/ skip=/::\|:|:\|:||:\|[|\[][1-9]\%(,[1-9]\|-[1-9]\)*/ end=/\z1\%(|\|\]\)[1-9]\=/ keepend contains=@MusicCode contained

sy match AbcRepeatBar /[|\[]\%(:\+\)/ contained containedin=@AbcMusicCode
sy match AbcRepeatBar /::\|:|:\|:||:\|[|\[][1-9]\%(,[1-9]\|-[1-9]\)*/ contained containedin=@AbcMusicCode
sy match AbcRepeatBar /:\+\%(|\|\]\)[1-9]\=/ contained containedin=@AbcMusicCode

sy region AbcMeasure start=/[|\[\]]/ end=/[|\[\]]/ keepend contained containedin=@AbcMusicCode contains=@AbcMusicCode
sy region AbcSlur start=/(\{1}/ end=/)/ keepend contained containedin=@AbcMusicCode contains=@AbcMusicCode
sy match AbcTuplet /([2-9]\{1}/ contained containedin=@AbcMusicCode

sy match AbcNoteSkip /\*/ contained containedin=AbcSymbolField,AbcLyricsField,AbcWordsField

sy match AbcDirective /^%%\h[\w-]* [\w\s]*/ nextgroup=AbcComment skipwhite skipnl contains=AbcDirectiveName,AbcDirectiveParam containedin=AbcTypesetText,AbcFileHeader,AbcTuneHeader,AbcTuneBody
sy keyword AbcDirectiveName abc-copyright abc-creator abc-version abc-charset abc-include abc-edited-by abc2pscompat alignbarsalignbars aligncomposer annotationfont autoclef barnumbers barsperstaff breakoneoln beginps beginsvg bgcolor botmargin bstemdown comball combinevoices composerfont composerspace contbarnb continueall dateformat deco decoration dynalign dynamic encoding flatbeams font footer footerfont format gchord gchordbox gchordfont graceslurs gracespace header headerfont historyfont hyphencont indent infofont infoline infoname infospace landscape leftmargin linebreak lineskipfac linewarn maxshrink maxstaffsep maxsysstaffsep measurebox measurefirst measurefont measurenb musiconly musicspace notespacingfactor oneperpage ornament pageheight pagewidth pango parskipfac partsbox partsfont partsspace pdfmark postscript repeatfont rightmargin scale setdefl setfont-1 setfont-2 setfont-3 setfont-4 shifthnote shiftunisson slurheight splittune squarebreve squarebreve staffnonote staffsep staffwidth stemheight straightflags stretchlast stretchstaff subtitlefont subtitlespace sysstaffsep tempofont textfont textoption textspace timewarn titlecaps titlefont titleformat titleleft titlespace titletrim topmargin topspace transpose tuplets vocal vocalabove vocalfont vocalspace voicefont volume wordsfont wordsspace writefields MIDI contained containedin=AbcDirective,AbcInstructionField
sy match AbcDirectiveName /%%\zs\h[\w-]*\ze/ contained containedin=AbcDirective
sy match AbcDirectiveParam 
" Part of having the power over a Unicode text editor is being able to use
" it's features to every extent; Vim is no exception. Rather than have
" software give you  

" Entities
sy match hAbcEntity /&#x\x*;/ contained " Don't conceal
sy match hAbcEntity /&#\d*;/ contained " Don't conceal
sy match hAbcEntity /&\w*;/ contained " Don't conceal
sy match hAbcEntity /\\%/ contained  " Don't conceal
sy match hAbcEntity /\\&/ contained  " Don't conceal

sy match AbcEntity /&#34;\|&quot;/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=" 
sy match AbcEntity /&#39;\|&apos;/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar='
sy match AbcEntity /&#38;\|&amp;/ contained conceal  containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=&
sy match AbcEntity /&#60;\|&lt;/  contained conceal  containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=<
sy match AbcEntity /&#62;\|&gt;/ contained conceal   containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=>

sy match AbcEntity /&#161;\|&iexcl;/ contained conceal  containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=¡
sy match AbcEntity /&#162;\|&cent;/ contained conceal   containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=¢
sy match AbcEntity /&#163;\|&pound;/ contained conceal  containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=£
sy match AbcEntity /&#164;\|&curren;/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=¤
sy match AbcEntity /&#165;\|&yen;/ contained conceal    containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=¥
sy match AbcEntity /&#166;\|&brvbar;/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=¦
sy match AbcEntity /&#167;\|&sect;/ contained conceal   containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=§
sy match AbcEntity /&#168;\|&uml;/ contained conceal    containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=¨
sy match AbcEntity /&#169;\|&copy;/ contained conceal   containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=©
sy match AbcEntity /&#170;\|&ordf;/ contained conceal   containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=ª
sy match AbcEntity /&#171;\|&laquo;/ contained conceal  containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=«
sy match AbcEntity /&#172;\|&not;/ contained conceal    containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=¬
sy match AbcEntity /&#174;\|&reg;/ contained conceal    containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=®
sy match AbcEntity /&#175;\|&macr;/ contained conceal   containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=¯
sy match AbcEntity /&#176;\|&deg;/ contained conceal    containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=°
sy match AbcEntity /&#177;\|&plusmn;/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=±
sy match AbcEntity /&#178;\|&sup2;/ contained conceal   containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=²
sy match AbcEntity /&#179;\|&sup3;/ contained conceal   containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=³
sy match AbcEntity /&#180;\|&acute;/ contained conceal  containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=´
sy match AbcEntity /&#181;\|&micro;/ contained conceal  containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=µ
sy match AbcEntity /&#182;\|&para;/ contained conceal   containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=¶
sy match AbcEntity /&#183;\|&middot;/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=·
sy match AbcEntity /&#184;\|&cedil;/ contained conceal  containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=¸
sy match AbcEntity /&#185;\|&sup1;/ contained conceal   containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=¹
sy match AbcEntity /&#186;\|&ordm;/ contained conceal   containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=º
sy match AbcEntity /&#187;\|&raquo;/ contained conceal  containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=»
sy match AbcEntity /&#188;\|&frac14;/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=¼
sy match AbcEntity /&#189;\|&frac12;/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=½
sy match AbcEntity /&#190;\|&frac34;/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=¾
sy match AbcEntity /&#191;\|&iquest;/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=¿
sy match AbcEntity /&#215;\|&times;/ contained conceal  containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=×
sy match AbcEntity /&#247;\|&divide;/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=÷

" Accents
sy match AbcEntity /\\`A\|&Agrave;\|\\u00c0/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=À
sy match AbcEntity /\\`a\|&agrave;\|\\u00e0/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=à
sy match AbcEntity /\\`E\|&Egrave;\|\\u00c8/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=È
sy match AbcEntity /\\`e\|&egrave;\|\\u00e8/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=è
sy match AbcEntity /\\`I\|&Igrave;\|\\u00cc/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=Ì
sy match AbcEntity /\\`i\|&igrave;\|\\u00ec/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=ì
sy match AbcEntity /\\`O\|&Ograve;\|\\u00d2/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=Ò
sy match AbcEntity /\\`o\|&ograve;\|\\u00f2/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=ò
sy match AbcEntity /\\`U\|&Ugrave;\|\\u00d9/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=Ù
sy match AbcEntity /\\`u\|&ugrave;\|\\u00f9/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=ù
sy match AbcEntity /\\'A\|&Aacute;\|\\u00c1/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=Á
sy match AbcEntity /\\'a\|&aacute;\|\\u00e1/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=á
sy match AbcEntity /\\'E\|&Eacute;\|\\u00c9/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=É
sy match AbcEntity /\\'e\|&eacute;\|\\u00e9/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=é
sy match AbcEntity /\\'I\|&Iacute;\|\\u00cd/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=Í
sy match AbcEntity /\\'i\|&iacute;\|\\u00ed/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=í
sy match AbcEntity /\\'O\|&Oacute;\|\\u00d3/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=Ó
sy match AbcEntity /\\'o\|&oacute;\|\\u00f3/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=ó
sy match AbcEntity /\\'U\|&Uacute;\|\\u00da/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=Ú
sy match AbcEntity /\\'u\|&uacute;\|\\u00fa/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=ú
sy match AbcEntity /\\'Y\|&Yacute;\|\\u00dd/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=Ý
sy match AbcEntity /\\'y\|&yacute;\|\\u00fd/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=ý
sy match AbcEntity /\\^A\|&Acirc;\|\\u00c2/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=Â
sy match AbcEntity /\\^a\|&acirc;\|\\u00e2/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=â
sy match AbcEntity /\\^E\|&Ecirc;\|\\u00ca/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=Ê
sy match AbcEntity /\\^e\|&ecirc;\|\\u00ea/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=ê
sy match AbcEntity /\\^I\|&Icirc;\|\\u00ce/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=Î
sy match AbcEntity /\\^i\|&icirc;\|\\u00ee/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=î
sy match AbcEntity /\\^O\|&Ocirc;\|\\u00d4/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=Ô
sy match AbcEntity /\\^o\|&ocirc;\|\\u00f4/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=ô
sy match AbcEntity /\\^U\|&Ucirc;\|\\u00db/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=Û
sy match AbcEntity /\\^u\|&ucirc;\|\\u00fb/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=û
sy match AbcEntity /\\^Y\|&Ycirc;\|\\u0176/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=Ŷ
sy match AbcEntity /\\^y\|&ycirc;\|\\u0177/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=ŷ
sy match AbcEntity /\\~A\|&Atilde;\|\\u00c3/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=Ã
sy match AbcEntity /\\~a\|&atilde;\|\\u00e3/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=ã
sy match AbcEntity /\\~N\|&Ntilde;\|\\u00d1/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=Ñ
sy match AbcEntity /\\~n\|&ntilde;\|\\u00f1/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=ñ
sy match AbcEntity /\\~O\|&Otilde;\|\\u00d5/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=Õ
sy match AbcEntity /\\~o\|&otilde;\|\\u00f5/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=õ
sy match AbcEntity /\\"A\|&Auml;\|\\u00c4/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=Ä
sy match AbcEntity /\\"a\|&auml;\|\\u00e4/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=ä
sy match AbcEntity /\\"E\|&Euml;\|\\u00cb/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=Ë
sy match AbcEntity /\\"e\|&euml;\|\\u00eb/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=ë
sy match AbcEntity /\\"I\|&Iuml;\|\\u00cf/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=Ï
sy match AbcEntity /\\"i\|&iuml;\|\\u00ef/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=ï
sy match AbcEntity /\\"O\|&Ouml;\|\\u00d6/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=Ö
sy match AbcEntity /\\"o\|&ouml;\|\\u00f6/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=ö
sy match AbcEntity /\\"U\|&Uuml;\|\\u00dc/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=Ü
sy match AbcEntity /\\"u\|&uuml;\|\\u00fc/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=ü
sy match AbcEntity /\\"Y\|&Yuml;\|\\u0178/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=Ÿ
sy match AbcEntity /\\"y\|&yuml;\|\\u00ff/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=ÿ
sy match AbcEntity /\\cC\|&Ccedil;\|\\u00c7/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=Ç
sy match AbcEntity /\\cc\|&ccedil;\|\\u00e7/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=ç
sy match AbcEntity /\\AA\|&Aring;\|\\u00c5/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=Å
sy match AbcEntity /\\aa\|&aring;\|\\u00e5/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=å
sy match AbcEntity /\\\/O\|&Oslash;\|\\u00d8/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=Ø
sy match AbcEntity /\\\/o\|&oslash;\|\\u00f8/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=ø
sy match AbcEntity /\\uA\|&Abreve;\|\\u0102/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=Ă
sy match AbcEntity /\\ua\|&abreve;\|\\u0103/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=ă
sy match AbcEntity /\\uE\|\\u0114/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=Ĕ
sy match AbcEntity /\\ue\|\\u0115/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=ĕ
sy match AbcEntity /\\vS\|&Scaron;\|\\u0160/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=Š
sy match AbcEntity /\\vs\|&scaron;\|\\u0161/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=š
sy match AbcEntity /\\vZ\|&Zcaron;\|\\u017d/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=Ž
sy match AbcEntity /\\vz\|&zcaron;\|\\u017e/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=ž
sy match AbcEntity /\\HO\|\\u0150/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=Ő
sy match AbcEntity /\\Ho\|\\u0151/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=ő
sy match AbcEntity /\\HU\|\\u0170/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=Ű
sy match AbcEntity /\\Hu\|\\u0171/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=ű
" Ligatures
sy match AbcEntity /\\AE\|&AElig;\|\\u00c6/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=Æ
sy match AbcEntity /\\ae\|&aelig;\|\\u00e6/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=æ
sy match AbcEntity /\\OE\|&OElig;\|\\u0152/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=Œ
sy match AbcEntity /\\oe\|&oelig;\|\\u0153/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=œ
sy match AbcEntity /\\ss\|&szlig;\|\\u00df/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=ß
sy match AbcEntity /\\DH\|&ETH;\|\\u00d0/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=Ð
sy match AbcEntity /\\dh\|&eth;\|\\u00f0/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=ð
sy match AbcEntity /\\TH\|&THORN;\|\\u00de/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=Þ
sy match AbcEntity /\\th\|&thorn;\|\\u00fe/ contained conceal containedin=AbcStringField,AbcTypesetText,AbcFreeText cchar=þ

sy match AbcSetFontOp /\%($[0-4]\)/ contained containedin=AbcStringField,AbcTypesetText,AbcFreeText
sy match AbcUnicode /\\u[0-9A-Fa-f]\{1,4}/ containedin=AbcStringField,AbcTypesetText,AbcFreeText

" Nested, custom colored regions - EXAMPLE
"sy region par1 matchgroup=par1 start=/(/ end=/)/ contains=par2
"sy region par2 matchgroup=par2 start=/(/ end=/)/ contains=par3 contained
"sy region par3 matchgroup=par3 start=/(/ end=/)/ contains=par1 contained
"hi par1 ctermfg=red guifg=red
"hi par2 ctermfg=blue guifg=blue
"hi par3 ctermfg=darkgreen guifg=darkgreen

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet

" Changed the original code of the abc.vim syntax file:
" initially, used a command to shorten the syntax of 'hi link', then deleted
" the command at the end of the loop. Strangely, the syntax file would 'forget'
" that it's supposed to KEEP it's items highlighted, as opposed to randomly
" breaking it's highlighting every now and then when the user made a lot of
" changes to the abc code, or when the syntax script was simply being
" tempermental.

" TODO
if version >= 508 || !exists("did_abc_syn_inits")
  if version < 508
    let did_abc_syn_inits = 1
    hi link AbcStartString    Define
    hi link AbcComment        Comment
    hi link ReservedChars     Ignore
    hi link Directive         PreProc
    hi link FField            Special
    hi link HField            Special
    hi link BField            Special
    hi link IField            Special
    hi link Unicode           Character
    hi link @AbcMnemonics     Character
    hi link Bar               Operator
    hi link Tuple             Operator
    hi link Broken            Operator
    hi link Tie               Operator
    hi link @AbcNote           Statement
  else
    hi def link AbcComment        Comment
    hi def link IField            Special
    hi def link Bar               Statement
    hi def link Tuple             Statement
    hi def link Broken            Statement
    hi def link Tie               Statement
    hi def link @AbcNote           Constant
  endif
endif

let b:current_syntax = "abc"

vim:ts=4