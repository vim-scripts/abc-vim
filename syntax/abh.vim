" Vim syntax file
" Language: abc music notation includes
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

if version > 600
    syntax clear
elseif has("b:current_syntax=1")
    finish
endif










" Directives specific for external formatting
"break clip select tune voice 
" The above directives all use 'vimPatRegion' for highlighting. It's preloaded
" from starting Vim, and it includes all the proper highlights for regular
" expressions.

"vim:ts=4:sw=4:fdm=marker:fdc=3
