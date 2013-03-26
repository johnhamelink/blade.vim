" Blade Syntax
" Language: Blade
" Maintainer:   John Hamelink <john@Johnhamelink.com>
" Version: 1
" Remark:
"   It lexically hilights embedded braces and @@s in PHP.
"   Based on the work of Juvenn Woo who made mustache.vim
" TODO:
" - Highlight the braces around variables
" - Highlight the @commands correctly


" Read the PHP syntax to start with
if version < 600
  so <sfile>:p:h/php.vim
else
  runtime! syntax/php.vim
  unlet b:current_syntax
endif

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" Add the @-sign as part of a keyword
setlocal iskeyword+=@

" Standard HiLink will not work with included syntax files
if version < 508
  command! -nargs=+ HtmlHiLink hi link <args>
else
  command! -nargs=+ HtmlHiLink hi def link <args>
endif

" Make vim recognise that everything inside the @ blocks is actually just
" PHP

"syntax keyword bladeIfSyntax @if @endif @else
"syntax keyword bladeForSyntax @forelse @empty @endforelse @for @endfor
"syntax keyword bladeWhileSyntax @while @endwhile
"syntax keyword bladeSection @section @endsection
"syntax keyword bladeYield @yield @yield_section
"syntax keyword bladeInclude @include
"syntax keyword bladeLayout @layout
"syntax keyword bladeParent @parent

"syntax region bladeLoop start=/@if/ end=/@endif/ contains=@phpBladeContainer
"syntax region bladeLoop start=/@if/ end=/@else/ contains=@phpBladeContainer
"
"
"syntax region bladeLoop start=/@forelse/ end=/@empty/ contains=@phpBladeContainer
"syntax region bladeLoop start=/@forelse/ end=/@endforelse/ contains=@phpBladeContainer
"
"syntax region bladeLoop start=/@while/ end=/@endwhile/ contains=@phpBladeContainer
"syntax region bladeLoop start=/@for/ end=/@endfor/ contains=@phpBladeContainer
"
"syntax match bladeLoop /@[include|yield|section|yield_section|layout|parent]/ contains=@phpBladeContainer

syntax keyword bladeKeywords @forelse @empty @endforelse
syntax keyword bladeKeywords @section @endsection
syntax keyword bladeKeywords @yield @yield_section
syntax keyword bladeKeywords @include
syntax keyword bladeKeywords @layout
syntax keyword bladeKeywords @parent

syntax region bladeForLoopRegion start="@for" end="@endfor" fold contains=@phpBladeContainer
syntax region bladeWhileLoopRegion start="@while" end="@endwhile" fold contains=@phpBladeContainer
syntax region bladeSectionLoopRegion start="@section" end="@endsection" fold contains=@phpBladeContainer
syntax region bladeIfRegion start="@if" end="@endif" fold contains=@phpBladeContainer

" Make the curly braces use the php variable colour scheme
syntax region bladeVariable start=/{{/ end=/}}/ oneline contains=phpBladeContainer


" Clustering
syntax cluster phpBladeContainer add=phpVarSelector,phpKeyword,phpRepeat,
            \phpConditional,phpStatement,phpEnvVar,phpIntVar,phpCoreConstant,
            \phpConstant,phpLabel,phpOperator,phpRelation,phpIdentifier,phpParent,
            \phpIdentifierSimply,phpIdentifierComplexP,phpIdentifierComplex,
            \phpMethodsVar,phpBoolean,phpNumber,phpFloat,phpSpecialChar,
            \phpStringDouble,phpStringSingle,phpComparison


highlight link bladeKeywords phpKeyword

let b:current_syntax = "blade"

