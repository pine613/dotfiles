" =========================================================
" .vimrc
" =========================================================

set encoding=utf-8
scriptencoding utf-8

" ---------------------------------------------------------
" *** 全般設定 ***
" ---------------------------------------------------------

" vi 互換ではなく vim のデフォルトの挙動にする
" ファイルの先頭で記述すること
set nocompatible

" モードラインを有効化し、ファイルの最初と最後 5 行に設定
set modeline
set modelines=5


" ---------------------------------------------------------
" *** NeoBundle ***
" ---------------------------------------------------------

if has('vim_starting')
    if &compatible
        set nocompatible               " Be iMproved
    endif

    " Required:
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" Add or remove your Bundles here:
NeoBundle 'leafgarland/typescript-vim'
NeoBundle 'motemen/xslate-vim'
NeoBundle 'tyru/caw.vim'
NeoBundle 'kchmck/vim-coffee-script' " CoffeeScript
NeoBundle 'vim-scripts/sudo.vim' " :w sudo:%
NeoBundle 'editorconfig/editorconfig-vim' " .editorconfig
NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'scrooloose/nerdtree'


" Required:
call neobundle#end()


" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck


" ---------------------------------------------------------
" *** ファイル関係 ***
" ---------------------------------------------------------

" ファイルタイプ関係の設定
syntax enable
filetype plugin indent on

" 文字コード関係の設定
set fileformats=unix,dos,mac " ファイルフォーマット
set termencoding=utf-8       " 端末のエンコード
set ambiwidth=double         " 全角文字を2文字として扱う

" 自動判定するエンコード一覧
set fileencodings=ucs-bom,utf-8,iso-2022-jp,euc-jp,cp932,latin1

" バッファ切り替え
set autowrite " 自動保存
set hidden    " 保存していないバッファの切り替えを有効


" ---------------------------------------------------------
" *** ビジュアル関係 ***
" ---------------------------------------------------------

" 行番号を有効にする
set number

" モードライン
set laststatus=2 " ステータスラインを表示
set statusline=%<%f\ %m%r%{&ft==''?'':'['.GetFileType().']'}[%{GetFileEncoding()}][%{GetFileFormat()}]%=%lL,%c%VC%8P " ステータスラインのフォーマット

set showcmd   " コマンドを表示
set showmatch " 対応する括弧を表示

" ---------------------------------------------------------
" *** 移動 ***
" ---------------------------------------------------------

" 左右の矢印キーでバッファを移動できるようにする
nnoremap <Left> <Esc>:bp<CR>
nnoremap <Right> <Esc>:bn<CR>

" カーソル移動を表示行で移動する
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

vnoremap j gj
vnoremap k gk
vnoremap gj j
vnoremap gk k

" カレントウィンドウを移動
nnoremap ww <C-w>w


" ---------------------------------------------------------
" *** インデント ***
" ---------------------------------------------------------

set autoindent " 自動インデント
set expandtab " タブを空白に展開
set tabstop=4 " タブを展開する幅
set softtabstop=4
set shiftwidth=4 " タブ幅

" 空行でインデントを維持
nnoremap o oX<C-h>
nnoremap O OX<C-h>
inoremap <CR> <CR>X<C-h>

" インデントをずらす
vnoremap <silent> > >gv
vnoremap <silent> < <gv


" ---------------------------------------------------------
" *** 削除・置換 ***
" ---------------------------------------------------------

" レジスタに入れずに一文字削除
nnoremap x "_x

" 単語を置換するコマンド
" カーソルの位置によらずに単語全体を変更
nnoremap ck lbcw
nnoremap dk lbdw


" ---------------------------------------------------------
" *** 検索関係 ***
" ---------------------------------------------------------

set hlsearch " 検索語句をハイライト表示

" 検索語句のハイライトを消す
nnoremap <Esc><Esc> :nohlsearch<CR><Esc>



" ---------------------------------------------------------
" *** neocomplcache ***
" ---------------------------------------------------------

"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Enable heavy features.
" Use camel case completion.
"let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
"let g:neocomplcache_enable_underbar_completion = 1

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplcache#close_popup() : "\<Space>"

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplcache#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplcache#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplcache#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplcache#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplcache_enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplcache_enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplcache_enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplcache_enable_auto_select = 1
"let g:neocomplcache_disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplcache_force_omni_patterns')
  let g:neocomplcache_force_omni_patterns = {}
endif
let g:neocomplcache_force_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_force_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplcache_force_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplcache_force_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'


" ---------------------------------------------------------
" *** NERDTree ***
" ---------------------------------------------------------

nmap <silent> <C-e>      :NERDTreeToggle<CR>
vmap <silent> <C-e> <Esc>:NERDTreeToggle<CR>
omap <silent> <C-e>      :NERDTreeToggle<CR>
imap <silent> <C-e> <Esc>:NERDTreeToggle<CR>
cmap <silent> <C-e> <C-u>:NERDTreeToggle<CR>

autocmd vimenter * if !argc() | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

let g:NERDTreeIgnore=['\.clean$', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowHidden=1
let g:NERDTreeMinimalUI=1
let g:NERDTreeDirArrows=0
let g:NERDTreeQuitOnOpen=0


" ---------------------------------------------------------
" *** 関数定義 ***
" ---------------------------------------------------------

" ファイルタイプを返す
function! GetFileType()
    let l:name = {
                \'vim'       : 'Vim',
                \'c'         : 'C',
                \'cpp'       : 'C++',
                \'java'      : 'Java',
                \'css'       : 'CSS',
                \'javascript': 'JavaScript',
                \'tex'       : 'TeX',
                \'php'       : 'PHP',
                \'python'    : 'Python',
                \'text'      : 'Text',
                \'sql'       : 'SQL',
                \'perl'      : 'Perl',
                \'xslate'    : 'Xslate',
                \'coffee'    : 'CoffeeScript'
                \}

    retu get(l:name, &ft, &ft)
endfunction

" 文字コードを返す
function! GetFileEncoding()
    let l:fenc = &fenc

    " fenc が設定されていない場合 enc を使用する
    if l:fenc == ''
        let l:fenc = &enc
    endif

    if l:fenc == 'cp932'
        return 'S'
    elseif l:fenc == 'iso-2022-jp'
        return 'J'
    elseif l:fenc == 'euc-jp'
        return 'E'
    elseif l:fenc == 'utf-8'
        return 'U'
    else
        return l:fenc
    endif
endfunction

" 改行コードを返す
function! GetFileFormat()
    if &ff == 'unix'
        return 'U'
    elseif &ff == 'dos'
        return 'D'
    else
        return 'M'
    endif
endfunction

" ステータスラインを生成する
function! GetStatusLine()
    let l:line = 'vim: se'

    if &et
        let l:line .= ' et'
    else
        let l:line .= ' noet'
    endif

    let l:line .= ' ts='.&ts
    let l:line .= ' sw='.&sw
    let l:line .= ' sts='.&sts

    if &ft != ''
        let l:line .= ' ft='.&ft
    endif

    let l:line .= ' :'

    return l:line
endfunction

" ステータスラインを自動挿入
nnoremap <Leader>s :execute 'normal a'.GetStatusLine()<CR>


" vim: se et ts=4 sw=4 sts=0 ft=vim :
