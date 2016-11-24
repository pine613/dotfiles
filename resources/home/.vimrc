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

" Mac で crontab を動かす関係
" http://kirin.hatenadiary.jp/entry/2015/01/16/061622
set backupskip=/tmp/*,/private/tmp/*

" ---------------------------------------------------------
" *** ビジュアル関係 ***
" ---------------------------------------------------------

" 行番号を有効にする
set number

" カーソル位置の強調
set cursorline
set cursorcolumn

" モードライン
set laststatus=2 " ステータスラインを表示
set statusline=%<%f\ %m%r%{&ft==''?'':'['.GetFileType().']'}[%{GetFileEncoding()}][%{GetFileFormat()}]%=%lL,%c%VC%8P " ステータスラインのフォーマット

set showcmd   " コマンドを表示
set showmatch " 対応する括弧を表示


" 256 色対応
if $TERM == 'screen-bce'
    set t_Co=256
endif

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
nnoremap tt <C-w>w

" 矢印キーで入力されないように変更
inoremap ^[OA <up>
inoremap ^[OB <down>
inoremap ^[OC <right>
inoremap ^[OD <left>

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

" Backspace キーを効くようにする
set backspace=indent,eol,start

" ---------------------------------------------------------
" *** 検索関係 ***
" ---------------------------------------------------------

set hlsearch " 検索語句をハイライト表示

" 検索語句のハイライトを消す
nnoremap <Esc><Esc> :nohlsearch<CR><Esc>


" ---------------------------------------------------------
" *** 関数定義 ***
" ---------------------------------------------------------

" ファイルタイプを返す
function! GetFileType()
    " Alphabet order
    let l:name = {
                \'c'         : 'C',
                \'coffee'    : 'CoffeeScript',
                \'cpp'       : 'C++',
                \'crystal'   : 'Crystal',
                \'css'       : 'CSS',
                \'elixir'    : 'Elixir',
                \'java'      : 'Java',
                \'javascript': 'JavaScript',
                \'kotlin'    : 'Kotlin',
                \'less'      : 'LESS',
                \'markdown'  : 'Markdown',
                \'perl'      : 'Perl',
                \'php'       : 'PHP',
                \'python'    : 'Python',
                \'ruby'      : 'Ruby',
                \'sql'       : 'SQL',
                \'swift'     : 'Swift',
                \'tex'       : 'TeX',
                \'text'      : 'Text',
                \'vim'       : 'Vim',
                \'xslate'    : 'Xslate',
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

" ---------------------------------------------------------
" *** 外部定義 ***
" ---------------------------------------------------------

if filereadable(glob("~/.vimrc.local"))
    source ~/.vimrc.local
endif

" vim: se et ts=4 sw=4 sts=0 ft=vim :
