set encoding=utf-8
scriptencoding utf-8

" tiny と small では vimrc を読み込まない
if !1 | finish | endif

" NeoBundle {{{
"NeoBundle Scripts-----------------------------
"https://github.com/Shougo/neobundle.vim
let $BUNDLE_DIR = '~/.vim/bundle'
if has('vim_starting')
  if &compatible
    set nocompatible              " Be iMproved
  endif

  " Required:
  "set runtimepath+=~/.vim/bundle/neobundle.vim
  set runtimepath+=$BUNDLE_DIR/neobundle.vim/
endif

" Required:
"call neobundle#begin(expand('~/.vim/bundle/'))
call neobundle#begin(expand('$BUNDLE_DIR'))

" NeoBundleをNeoBundle自体で管理する
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" Add or remove your Bundles here:
" ColorSchema{{{
"  NeoBundle 'yuroyoro/yuroyoro256.vim'
" }}}

" Edit {{{

  " 選択範囲拡大
  NeoBundle "terryma/vim-expand-region"
  " 折畳
  NeoBundle "LeafCage/foldCC.vim"
  " Markdown
  NeoBundleLazy 'kannokanno/previm', {
      \ 'autoload' : {
      \   'filetypes' : ['markdown']
      \ }}
  NeoBundle 'tyru/open-browser.vim'
  " SQL keywords uppercase automatically
  NeoBundleLazy 'sql_iabbr.vim', {
      \ 'autoload' : {
      \   'filetypes' : ['sql']
      \ }}

" }}}

" Other {{{

  NeoBundleLazy 'vim-scripts/dbext.vim', {
      \ 'autoload' : {
      \   'filetypes' : ['sql']
      \ }}

" }}}

" Searching/Moving{{{
  " eregex.vim : vimの正規表現をrubyやperlの正規表現な入力でできる :%S/perlregex/
  " デメリット：インクリメンタルサーチができなくなる
  "NeoBundle 'othree/eregex.vim'

  " :CtrlPコマンドを叩いて起動させるまでは読み込みを行わない
  NeoBundleLazy "ctrlpvim/ctrlp.vim", {
  \    'autoload' : {'commands':[ 'CtrlP', 'CtrlPBuffer', 'CtrlPMRUFiles' ] }
  \ }

" }}}

" Completion {{{
  if has('python')
    NeoBundle 'Valloric/YouCompleteMe'
  endif

"  NeoBundle 'Valloric/YouCompleteMe', {
"    \ 'build'      : {
"      \ 'mac'     : './install.py --clang-completer --system-libclang --omnisharp-completer',
"      \ 'unix'    : './install.py --clang-completer --system-libclang --omnisharp-completer',
"      \ 'windows' : './install.py --clang-completer --system-libclang --omnisharp-completer',
"      \ 'cygwin'  : './install.py --clang-completer --system-libclang --omnisharp-completer'
"    \ }
"  \ }

  NeoBundleLazy 'kana/vim-smartinput', { 'autoload' : {'insert' : 1} }

  if has('python') && executable('npm')
    NeoBundleLazy 'marijnh/tern_for_vim', {
      \ 'build' : {
      \   'windows' : 'cd $HOME/.vim/bundle/tern_for_vim & npm install'
      \ },
      \ 'autoload' : {
      \   'functions': ['tern#Complete', 'tern#Enable'],
      \   'filetypes' : ['javascript']
      \ }}
  endif

  " 補完 neocomplcache.vim : 究極のVim的補完環境
  "NeoBundle 'Shougo/neocomplcache'

  " neocomplcacheのsinpet補完
  "NeoBundle 'Shougo/neosnippet.git'
" }}}

" Unite {{{{
  "NeoBundle 'Shougo/unite.vim'
" }}}

" Required:
call neobundle#end()

" ファイルタイプ別のプラグイン/インデントを有効にする
" Required:
filetype plugin indent on

" NeoBundleCheck を走らせ起動時に未インストールプラグインをインストールする
"NeoBundleCheck
"End NeoBundle Scripts------------------------- }}}

" @基本設定 Basics {{{

let g:mapleader = "\<Space>"     " キーマップリーダー
set scrolloff=5                  " スクロール時の余白確保
" textwidth反映されない
" :verbose set textwidth
" で最後にこのオプションが設定されたファイルがわかる
set textwidth=0                  " 一行に長い文章を書いていても自動折り返しをしない
set nobackup                     " バックアップ取らない
set autoread                     " 他で書き換えられたら自動で読み直す
set noswapfile                   " スワップファイル作らない
set hidden                       " 編集中でも他のファイルを開けるようにする
set backspace=indent,eol,start   " バックスペースでなんでも消せるように
set formatoptions=lmoq           " テキスト整形オプション，マルチバイト系を追加
set vb t_vb=                     " ビープをならさない
set browsedir=buffer             " Exploreの初期ディレクトリ
set whichwrap=b,s,h,l,<,>,[,]    " カーソルを行頭、行末で止まらないようにする
set showcmd                      " コマンドをステータス行に表示
set showmode                     " 現在のモードを表示
set viminfo='50,<1000,s100,\"50  " viminfoファイルの設定
set modelines=5                  " モードライン検索行数
set notitle                      " vimを使ってくれてありがとう
set shortmess+=I                 " Vim起動メッセージを表示しない
set splitright                   " vsplitで新規ウィンドウは右側にする

" ターミナルでマウスを使用できるようにする
set mouse=a
set guioptions+=a
set ttymouse=xterm2

"ヤンクした文字は、システムのクリップボードに入れる"
set clipboard=unnamed

" Ev/Rvでvimrcの編集と反映
"command! Ev edit $MYVIMRC
"command! Rv source $MYVIMRC

set helpfile=$VIMRUNTIME/doc/help.txt

" undoファイルの保存場所
set undodir=~/var/vim/undo

" Some Linux distributions set filetype in /etc/vimrc.
"   " Clear filetype flags before changing runtimepath to force Vim to
"   reload them.
"if exists("g:did_load_filetypes")
"  filetype off
"  filetype plugin indent off
"endif

" GoLangのpluginをruntime pathへ
"let goroot = substitute(system("go env GOROOT"),  '\n$',  '',  '')
"let govimpath = goroot . '/misc/vim'
"exe "set rtp+=" . govimpath
"set rtp+=$GOPATH/src/github.com/golang/lint/misc/vim
" exe "set rtp+=" . globpath($GOPATH,  "src/github.com/nsf/gocode/vim")


" ファイルタイプ判定をon
"filetype plugin on

" }}}

" @ステータスライン StatusLine {{{

set laststatus=2 " 常にステータスラインを表示

"カーソルが何行目の何列目に置かれているかを表示する
set ruler

" vim-powerlineでフォントにパッチを当てないなら以下をコメントアウト
let g:Powerline_symbols = 'fancy'

"ステータスラインに文字コードと改行文字を表示する
" if winwidth(0) >= 120
  " set statusline=%<[%n]%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}%y\ %{g:HahHah()}\ %F%=[%{GetB()}]\ %{fugitive#statusline()}\ %l,%c%V%8P
" else
  " set statusline=%<[%n]%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}%y\ %{g:HahHah()}\ %f%=[%{GetB()}]\ %{fugitive#statusline()}\ %l,%c%V%8P
" endif

"入力モード時、ステータスラインのカラーを変更
" augroup InsertHook
" autocmd!
" autocmd InsertEnter * highlight StatusLine guifg=#ccdc90 guibg=#2E4340 ctermfg=cyan
" autocmd InsertLeave * highlight StatusLine guifg=#2E4340 guibg=#ccdc90 ctermfg=white
" augroup END

"function! GetB()
"  let c = matchstr(getline('.'), '.', col('.') - 1)
"  let c = iconv(c, &enc, &fenc)
"  return String2Hex(c)
"endfunction
" help eval-examples
" The function Nr2Hex() returns the Hex string of a number.
"func! Nr2Hex(nr)
"  let n = a:nr
"  let r = ""
"  while n
"    let r = '0123456789ABCDEF'[n % 16] . r
"    let n = n / 16
"  endwhile
"  return r
"endfunc
" The function String2Hex() converts each character in a string to a two
" character Hex string.
"func! String2Hex(str)
"  let out = ''
"  let ix = 0
"  while ix < strlen(a:str)
"    let out = out . Nr2Hex(char2nr(a:str[ix]))
"    let ix = ix + 1
"  endwhile
"  return out
"endfunc

" }}}

" @インデント Indent {{{

set autoindent   " 自動でインデント
"set paste        " ペースト時にautoindentを無効に(onにするとautocomplpop.vimが動かない)
set smartindent  " 新しい行を開始したときに、新しい行のインデントを現在行と同じ量にする。
set cindent      " Cプログラムファイルの自動インデントを始める

" softtabstopはTabキー押し下げ時の挿入される空白の量，0の場合はtabstopと同じ，BSにも影響する
set tabstop=2        " <Tab> が対応する空白の数
set shiftwidth=2     " 自動インデントの各段階に使われる空白の数
set softtabstop=0    " タブキーやバックスペースキーでカーソルが動く幅

" Tabキーを空白に変換
set expandtab

if has('autocmd')
  "ファイルタイプの検索を有効にする
  filetype plugin on
  "そのファイルタイプにあわせたインデントを利用する
  filetype indent on
  " これらのftではインデントを無効に
  "autocmd FileType php filetype indent off
  augroup MyTheseIndent
    autocmd!
    autocmd FileType apache     setlocal sw=4 sts=4 ts=4 et
    autocmd FileType aspvbs     setlocal sw=4 sts=4 ts=4 et
    autocmd FileType c          setlocal sw=4 sts=4 ts=4 et
    autocmd FileType cpp        setlocal sw=4 sts=4 ts=4 et
    autocmd FileType cs         setlocal sw=4 sts=4 ts=4 et
    autocmd FileType css        setlocal sw=2 sts=2 ts=2 et
    autocmd FileType diff       setlocal sw=4 sts=4 ts=4 et
    autocmd FileType eruby      setlocal sw=4 sts=4 ts=4 et
    autocmd FileType html       setlocal sw=2 sts=2 ts=2 et
    autocmd FileType java       setlocal sw=4 sts=4 ts=4 et
    autocmd FileType javascript setlocal sw=2 sts=2 ts=2 et
    autocmd FileType perl       setlocal sw=4 sts=4 ts=4 et
    autocmd FileType php        setlocal sw=4 sts=4 ts=4 et
    autocmd FileType python     setlocal sw=4 sts=4 ts=4 et
    autocmd FileType ruby       setlocal sw=2 sts=2 ts=2 et
    autocmd FileType haskell    setlocal sw=2 sts=2 ts=2 et
    autocmd FileType haml       setlocal sw=2 sts=2 ts=2 et
    autocmd FileType sh         setlocal sw=4 sts=4 ts=4 et
    autocmd FileType sql        setlocal sw=4 sts=4 ts=4 et
    autocmd FileType vb         setlocal sw=4 sts=4 ts=4 et
    autocmd FileType vim        setlocal sw=2 sts=2 ts=2 et
    autocmd FileType wsh        setlocal sw=4 sts=4 ts=4 et
    autocmd FileType xhtml      setlocal sw=4 sts=4 ts=4 et
    autocmd FileType xml        setlocal sw=4 sts=4 ts=4 et
    autocmd FileType yaml       setlocal sw=2 sts=2 ts=2 et
    autocmd FileType zsh        setlocal sw=4 sts=4 ts=4 et
    autocmd FileType scala      setlocal sw=2 sts=2 ts=2 et
    autocmd FileType go         setlocal noexpandtab list tabstop=2 shiftwidth=2
  augroup END
endif

" }}}

" @表示 Apperance {{{

set showmatch         " 括弧の対応をハイライト
set matchtime=1       " showmatchがオンの時対応する括弧へ飛ぶ時間
set number            " 行番号表示
set list              " 不可視文字表示
set listchars=tab:>.,trail:_,extends:>,precedes:< " 不可視文字の表示形式
set display=lastline,uhex      " 印字不可能文字を16進数で表示

" 全角スペースの表示
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
match ZenkakuSpace /　/

" カーソル行をハイライト
set cursorline
" カレントウィンドウにのみ罫線を引く
augroup cch
  autocmd!
  autocmd WinLeave * set nocursorline
  autocmd WinEnter,BufRead * set cursorline
augroup END

hi clear CursorLine
highlight CursorLine gui=underline guibg=black
highlight CursorLine cterm=underline ctermbg=black

" コマンド実行中は再描画しない
set lazyredraw
" 高速ターミナル接続を行う
set ttyfast

" 折畳改善
" http://d.hatena.ne.jp/leafcage/20111223/1324705686
set foldtext=FoldCCtext()

" }}}

" @補完・履歴 Complete {{{

set pumheight=10           " 補完メニューの高さ
set wildmenu               " コマンド補完を強化
set wildchar=<tab>         " コマンド補完を開始するキー
set wildmode=list:full     " リスト表示，最長マッチ
set history=1000           " コマンド・検索パターンの履歴数
"set dictionary& dictionary+=~/.vim/dict/word
"set complete+=k            " 補完に辞書ファイル追加

" 補完にneocomplcacheを使う
"source ~/dotfiles/.vimrc.completion.neocomplcache

" 補完にAutoComplPopを使う
" source ~/dotfiles/.vimrc.completion.autocomplpop

" XMLの閉じタグを補完する
" XMLファイル編集時に</と入力するだけで自動的閉じタグを補完する
" <C-x><C-o>は filetypeに応じた補完を行なう機能です。
" XMLのための<C-x><C-o>のomnifunc関数は
" $VIMRUNTIME/autoload/xmlcomplete.vimで定義されています。
augroup MyXML
  autocmd!
  autocmd Filetype xml inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype html inoremap <buffer> </ </<C-x><C-o>
augroup END

" }}}

"Tags関連
"source ~/dotfiles/.vimrc.tags

" @検索設定 Search {{{

set wrapscan   " 最後まで検索したら先頭へ戻る
set ignorecase " 大文字小文字無視
set smartcase  " 検索文字列に大文字が含まれている場合は区別して検索する('ignorecase'オンのときのみ使われる)
set incsearch  " インクリメンタルサーチ
set hlsearch   " 検索文字をハイライト

" very magicを使う
" 正規表現に使うすべての特殊文字が\で前置せずに使える
" 簡単な比較は:help perl-patterns
" 詳細は:help pattern-overview
" very magicの場合にエスケープが必要な文字
" \
" .
" *
" +
" ?
" =
" {
" ^
" $
" (
" )
" |
" [
" &
" @
" ~
" /(検索コマンド/で検索する場合、/でパターンを囲う場合)
" 特に、=,&,@,~は、Perlの正規表現方言ではメタ文字ではないのでハマりポイントです。
" パターン検索で参考になるヘルプ
" :help usr_27.txt
" :help pattern.txt
" 置換の場合
" :%s/\vfoo(.*)//
nnoremap /  /\v

"選択した文字列を検索
"vnoremap <silent> // y/<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>
"選択した文字列を置換
"vnoremap /r "xy;%s/<C-R>=escape(@x, '\\/.*$^~[]')<CR>//gc<Left><Left><Left>

"s*置換後文字列/g<Cr>でカーソル下のキーワードを置換
"nnoremap <expr> s* ':%substitute/\<' . expand('<cword>') . '\>/'

" Ctrl-iでヘルプ
"nnoremap <C-i>  :<C-u>help<Space>
" カーソル下のキーワードをヘルプでひく
"nnoremap <C-i><C-i> :<C-u>help<Space><C-r><C-w><Enter>

" :Gb <args> でGrepBufferする
"command! -nargs=1 Gb :GrepBuffer <args>
" カーソル下の単語をGrepBufferする
"nnoremap <C-g><C-b> :<C-u>GrepBuffer<Space><C-r><C-w><Enter>

" :Gr <args>でカレントディレクトリ以下を再帰的にgrepする
"command! -nargs=1 Gr :Rgrep <args> *<Enter><CR>
" カーソル下の単語をgrepする
"nnoremap <silent> <C-g><C-r> :<C-u>Rgrep<Space><C-r><C-w> *<Enter><CR>

"let Grep_Skip_Dirs = '.svn .git'
"let Grep_Skip_Files = '*.bak *~'

" A wrapper function of :keeppatterns for Vim 7.4 compativility
"
" Thanks to @osyo_mem http://ideone.com/rgVoyf
"
function! s:keeppatterns(cmd)
	let l:old = @/
	try
		execute a:cmd
		call histdel('/', -1)
	catch
		echohl ErrorMsg
		echo v:exception
		echohl NONE
	finally
		let @/ = l:old
	endtry
endfunction

command! -complete=command -nargs=*
\	Keeppatterns
\	call s:keeppatterns(<q-args>)

" }}}

" @移動設定 Move {{{


"" 0, 9で行頭、行末へ
"nmap 1 0
"nmap 0 ^
"nmap 9 $
"
"" insert mode での移動
"inoremap  <C-e> <END>
"inoremap  <C-a> <HOME>
"" インサートモードでもhjklで移動（Ctrl押すけどね）
"inoremap <C-j> <Down>
"inoremap <C-k> <Up>
"inoremap <C-h> <Left>
"inoremap <C-l> <Right>

"<space>j, <space>kで画面送り
"noremap <Space>j <C-f>
"noremap <Space>k <C-b>

" spaceで次のbufferへ。back-spaceで前のbufferへ
"nmap <Space><Space> ;MBEbn<CR>
"nmap <BS><BS> ;MBEbp<CR>

"" F2で前のバッファ
"map <F2> <ESC>;bp<CR>
"" F3で次のバッファ
"map <F3> <ESC>;bn<CR>
"" F4でバッファを削除する
"map <F4> <ESC>:bnext \| bdelete #<CR>
"command! Bw :bnext \| bdelete #

""フレームサイズを怠惰に変更する
"map <kPlus> <C-W>+
"map <kMinus> <C-W>-

" 前回終了したカーソル行に移動
augroup MyLastCursor
  autocmd!
  autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif
augroup END

" 最後に編集された位置に移動
"nnoremap gb '[
"nnoremap gp ']

" 対応する括弧に移動
"nnoremap ( %
"nnoremap ) %

" 最後に変更されたテキストを選択する
"nnoremap gc  `[v`]
"vnoremap gc <C-u>normal gc<Enter>
"onoremap gc <C-u>normal gc<Enter>

" カーソル位置の単語をyankする
"nnoremap vy vawy

" 矩形選択で自由に移動する
set virtualedit+=block

"ビジュアルモード時vで行末まで選択
"vnoremap v $h

" git-diff-aware version of gf commands.
" http://labs.timedia.co.jp/2011/04/git-diff-aware-gf-commands-for-vim.html
"nnoremap <expr> gf  <SID>do_git_diff_aware_gf('gf')
"nnoremap <expr> gF  <SID>do_git_diff_aware_gf('gF')
"nnoremap <expr> <C-w>f  <SID>do_git_diff_aware_gf('<C-w>f')
"nnoremap <expr> <C-w><C-f>  <SID>do_git_diff_aware_gf('<C-w><C-f>')
"nnoremap <expr> <C-w>F  <SID>do_git_diff_aware_gf('<C-w>F')
"nnoremap <expr> <C-w>gf  <SID>do_git_diff_aware_gf('<C-w>gf')
"nnoremap <expr> <C-w>gF  <SID>do_git_diff_aware_gf('<C-w>gF')

function! s:do_git_diff_aware_gf(command)
  let l:target_path = expand('<cfile>')
  if l:target_path =~# '^[ab]/'  " with a peculiar prefix of git-diff(1)?
    if filereadable(l:target_path) || isdirectory(l:target_path)
      return a:command
    else
      " BUGS: Side effect - Cursor position is changed.
      let [_, c] = searchpos('\f\+', 'cenW')
      return c . '|' . 'v' . (len(l:target_path) - 2 - 1) . 'h' . a:command
    endif
  else
    return a:command
  endif
endfunction

" }}}

" @カラー関連 Colors {{{

" Q 今、何色でるのか？
" A :so $VIMRUNTIME/syntax/colortest.vim
"
" Q 今、どういうルールでハイライトされているのか？
" A :so $VIMRUNTIME/syntax/hitest.vim

" colorscheme mrkn256
"colorscheme yuroyoro256

" ターミナルタイプによるカラー設定
if &term =~ 'xterm-256color' || 'screen-256color'
  " 256色
  set t_Co=256
  set t_Sf=[3%dm
  set t_Sb=[4%dm
elseif &term =~ 'xterm-debian' || &term =~ 'xterm-xfree86'
  set t_Co=16
  set t_Sf=[3%dm
  set t_Sb=[4%dm
elseif &term =~ 'xterm-color'
  set t_Co=8
  set t_Sf=[3%dm
  set t_Sb=[4%dm
endif

"ポップアップメニューのカラーを設定
"hi Pmenu guibg=#666666
"hi PmenuSel guibg=#8cd0d3 guifg=#666666
"hi PmenuSbar guibg=#333333

" ハイライト on
syntax enable
" 補完候補の色づけ for vim7
" hi Pmenu ctermbg=255 ctermfg=0 guifg=#000000 guibg=#999999
" hi PmenuSel ctermbg=blue ctermfg=black
hi PmenuSel cterm=reverse ctermfg=33 ctermbg=222 gui=reverse guifg=#3399ff guibg=#f0e68c
" hi PmenuSbar ctermbg=0 ctermfg=9
" hi PmenuSbar ctermbg=255 ctermfg=0 guifg=#000000 guibg=#FFFFFF

"autocmd FileType go :highlight goErr cterm=bold ctermfg=214
"autocmd FileType go :match goErr /\<err\>/

" vimdiffの色設定
"highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=22
"highlight DiffDelete cterm=bold ctermfg=10 ctermbg=52
"highlight DiffChange cterm=bold ctermfg=10 ctermbg=17
highlight DiffText   cterm=bold ctermfg=white ctermbg=red

" 折畳の色
hi Folded ctermfg=darkcyan ctermbg=white
hi FoldColumn ctermfg=darkcyan ctermbg=white

" インクリメンタルサーチの色
highlight IncSearch ctermfg=black ctermbg=yellow

set background=dark
"set background=light

" }}}

" @編集関連 Edit {{{

" insertモードを抜けるとIMEオフ
set noimdisable
set iminsert=0 imsearch=0
set noimcmdline
inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>

" yeでそのカーソル位置にある単語をレジスタに追加
"nmap ye ;let @"=expand("<cword>")<CR>
" Visualモードでのpで選択範囲をレジスタの内容に置き換える
" vnoremap p <Esc>;let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

" コンマの後に自動的にスペースを挿入
"inoremap , ,<Space>

"  Insert mode中で単語単位/行単位の削除をアンドゥ可能にする
"inoremap <C-u>  <C-g>u<C-u>
"inoremap <C-w>  <C-g>u<C-w>

" :Ptでインデントモード切替
"command! Pt :set paste!

" インサートモード中に<C-o>でyankした内容をputする
"inoremap <C-o> <ESC>:<C-U>YRPaste 'p'<CR>i

"" y9 ydで行末までヤンク
"nmap y9 y$
"nmap yd y$
"" y0 ykで行頭までヤンク
"nmap y0 y^
"nmap yk y^


" 括弧を自動補完
"inoremap { {}<LEFT>
"inoremap [ []<LEFT>
"inoremap ( ()<LEFT>
"inoremap " ""<LEFT>
"inoremap ' ''<LEFT>
"vnoremap { "zdi^V{<C-R>z}<ESC>
"vnoremap [ "zdi^V[<C-R>z]<ESC>
"vnoremap ( "zdi^V(<C-R>z)<ESC>
"vnoremap " "zdi^V"<C-R>z^V"<ESC>
"vnoremap ' "zdi'<C-R>z'<ESC>

augroup BufWriteHook
  autocmd!
  " 保存時に行末の空白を除去する
  autocmd BufWritePre * :%s/\s\+$//ge
  " 保存時にtabをスペースに変換する
  " autocmd BufWritePre * :%s/\t/  /ge
augroup END

" 日時の自動入力
"inoremap <expr> ,df strftime('%Y/%m/%d %H:%M:%S')
"inoremap <expr> ,dd strftime('%Y/%m/%d')
"inoremap <expr> ,dt strftime('%H:%M:%S')

" foldは各FiltTypeにお任せる
" set foldmethod=syntax
" 折りたたみは全て展開した状態で開始する
" set foldlevelstart=99
" .vimはmarker
" autocmd FileType vim :set foldmethod=marker

" <leader>j でJSONをformat
" http://wozozo.hatenablog.com/entry/2012/02/08/121504
"map <Leader>j !python -m json.tool<CR>

augroup MyQuickfix
  autocmd!
  " quickfixウィンドウではq/ESCで閉じる
  autocmd FileType qf nnoremap <buffer> q :ccl<CR>
  autocmd FileType qf nnoremap <buffer> <ESC> :ccl<CR>
  "自動的に QuickFix リストを表示する
  autocmd QuickfixCmdPost make,grep,grepadd,vimgrep,vimgrepadd cwin
  autocmd QuickfixCmdPost lmake,lgrep,lgrepadd,lvimgrep,lvimgrepadd lwin
augroup END

" cwでquickfixウィンドウの表示をtoggleするようにした
function! s:toggle_qf_window()
  for l:bufnr in range(1,  winnr('$'))
    if getwinvar(l:bufnr,  '&buftype') ==# 'quickfix'
      execute 'ccl'
      return
    endif
  endfor
  execute 'botright cw'
endfunction
"nnoremap <silent> cw :call <SID>toggle_qf_window()<CR>

" }}}

" @エンコーディング関連 Encoding {{{

set fileformats=unix,dos,mac  " 改行文字

" 文字コード認識はbanyan/recognize_charcode.vimへ

augroup MyTheseEncoding
  autocmd!
  " cvsの時は文字コードをeuc-jpに設定
  autocmd FileType cvs :set fileencoding=euc-jp
  " 以下のファイルの時は文字コードをutf-8に設定
  autocmd FileType svn :set fileencoding=utf-8
  autocmd FileType js :set fileencoding=utf-8
  autocmd FileType css :set fileencoding=utf-8
  autocmd FileType html :set fileencoding=utf-8
  autocmd FileType xml :set fileencoding=utf-8
  autocmd FileType java :set fileencoding=utf-8
  autocmd FileType scala :set fileencoding=utf-8
augroup END

" ワイルドカードで表示するときに優先度を低くする拡張子
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc

" 指定文字コードで強制的にファイルを開く
command! Cp932 edit ++enc=cp932
command! Eucjp edit ++enc=euc-jp
command! Iso2022jp edit ++enc=iso-2022-jp
command! Utf8 edit ++enc=utf-8
command! Jis Iso2022jp
command! Sjis Cp932

" ConEmu
if !empty($CONEMUBUILD)
    " :messagesで参照可能
    "echom "Running in conemu"
    set termencoding=utf8
    set term=xterm " win32→xtermにするとDELキーで文字削除できなくなる
    set t_Co=256
    let &t_AB="\e[48;5;%dm"
    let &t_AF="\e[38;5;%dm"
    " termcap codes for cursor shape changes on entry and exit to
    " /from insert mode
    " doesn't work
    "let &t_ti="\e[1 q"
    "let &t_SI="\e[5 q"
    "let &t_EI="\e[1 q"
    "let &t_te="\e[0 q"
endif
if has('linux') || has('unix')
  set termencoding=utf-8
endif

" }}}

"その他
"source ~/dotfiles/.vimrc.misc

" @プラグインごとの設定 Plugins {{{

" Neobundle {{{
let neobundle#install_process_timeout = 1500
" }}}


"" YouCompleteMe {{{
"let g:ycm_seed_identifiers_with_syntax=1
"let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
"let g:ycm_confirm_extra_conf=0
"let g:ycm_collect_identifiers_from_tag_files = 1
"set completeopt=longest,menu
"" }}}

"" unite.vim {{{
""最近開いたファイル履歴の保存数
"let g:unite_source_file_mru_limit = 50
"
"" tab drop {{{
"let action = {
"\	'description' : 'tab drop',
"\	'is_selectable' : 1,
"\ }
"function! action.func(candidates)"{{{
"  for candidate in a:candidates
"    let bufpath = substitute(expand("%:p"), "\\", "\/", "g")
"    if bufpath != candidate.action__path
"      call unite#util#smart_execute_command('tab drop', candidate.action__path)
"    endif
"    call unite#take_action('open', candidate)
"  endfor
"endfunction"}}}
"call unite#custom_action('openable', 'tabdrop', action)
"unlet action
"" }}}
"" }}}

" CtrlP {{{

" http://qiita.com/rbtnn/items/600ac451ebb43b2c9c13
let s:bundle = neobundle#get('ctrlp.vim')
function! s:bundle.hooks.on_source(bundle)
  " 目一杯に一覧が出る
  let g:ctrlp_max_height = &lines
  let g:ctrlp_map = '<Nop>'
  " ドットファイル、ドットディレクトリを表示する（default:0）
  let g:ctrlp_show_hidden = 1
  let g:ctrlp_use_caching = 1
  if executable('ag')
      set grepprg=ag\ --nogroup\ --nocolor
      let g:ctrlp_user_command = 'ag -l --nocolor -g "" %s'
  else
    let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
    let g:ctrlp_prompt_mappings = {
      \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
      \ }
  endif
endfunction
unlet s:bundle

" }}}

let s:bundle = neobundle#get('dbext.vim')
function! s:bundle.hooks.on_source(bundle)
  source ~/dotfiles/.vimrc.dbext
endfunction
unlet s:bundle

let s:bundle = neobundle#get('tern_for_vim')
function! s:bundle.hooks.on_source(bundle)
endfunction
unlet s:bundle

" preview windowインサートモードを抜けた時に閉じる
augroup preview
  autocmd!
  autocmd InsertLeave * silent! pclose!
augroup END

" }}}

" @Hotkeys {{{

"Escの2回押しでハイライト消去
nmap <ESC><ESC> :nohlsearch<CR><ESC>

" Move {{{
" 12<Enter>を押して、12行目に移動する
" Enterを押して、ファイルの末尾に移動する
" Backspaceを押して、ファイルの先頭に移動する
nnoremap <CR> G
"nnoremap <BS> gg

" カーソルを表示行で移動する。論理行移動は<C-n>,<C-p>
nnoremap h <Left>
nnoremap j gj
nnoremap k gk
nnoremap l <Right>
nnoremap <Down> gj
nnoremap <Up>   gk

" CTRL-hjklでウィンドウ移動
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h

"Ctrl+Tabでタブを切り替える
nnoremap <C-Tab>   gt
nnoremap <C-S-Tab> gT
"スペースキーでスクロール
"nnoremap <Space> <C-d>
"nnoremap <S-Space> <C-u>
"ノーマルモードでもエンターキーで改行を挿入
"noremap <CR> o<ESC>
"新規タブを開く
nnoremap <Leader>t :tabnew<CR>
"強制全保存終了を無効化。
nnoremap ZZ <Nop>
"検索後画面の中心に。
nmap n nzz
nmap N Nzz

"ノーマル、ビジュアルで行頭、行末の移動
noremap <Space>h  ^
noremap <Space>l  $
"nnoremap <Space>/  *
"noremap <Space>m  %



" }}}

" Edit {{{

" 挿入モードでCtrl+kを押すとクリップボードの内容を貼り付けられるようにする "
"imap <C-p>  <ESC>"*pa

" カーソル位置から行末までヤンク
nnoremap Y y$

" <Space>pと<Space>yでシステムのクリップボードにコピー＆ペーストする
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

" vを押して、1文字を選択する
" もう1回vを押して、選択範囲を単語に拡大する
" さらに1回vを押して、選択範囲を段落に拡大する
vmap v <Plug>(expand_region_expand)
vmap <BS> <Plug>(expand_region_shrink)

" カーソルを貼り付けたテキストの末尾へ自動的に移動する
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" insert mode でjjでesc
inoremap jj <Esc>

" 数字のインクリメント、デクリメント
nnoremap + <C-a>
nnoremap - <C-x>

" }}}

" Complete {{{

" Ex-modeでの<C-p><C-n>をzshのヒストリ補完っぽくする
cnoremap <C-p> <Up>
cnoremap <Up>  <C-p>
cnoremap <C-n> <Down>
cnoremap <Down>  <C-n>

" }}}

" Fold {{{
" zR 全ての折り畳みを開く
" zM 全ての折り畳みを閉じる
" }}}

" @Plugin {{{
" CtrlP
"右下に20と表示させない方法とは？
"nnoremap <SID>[leader] <Nop>
"nmap <Leader> <SID>[leader]
"nmap <Space><Leader>

nnoremap <silent> <Leader>o :CtrlP<CR>
nnoremap <silent> <Leader>b :CtrlPBuffer<CR>
nnoremap <silent> <Leader>m :CtrlPMRUFiles<CR>

" smartinput
let s:bundle = neobundle#get('vim-smartinput')
function! s:bundle.hooks.on_source(bundle)
  call smartinput#map_to_trigger('i', '<Plug>(smartinput_BS)',
        \                        '<BS>',
        \                        '<BS>')
  call smartinput#map_to_trigger('i', '<Plug>(smartinput_C-h)',
        \                        '<BS>',
        \                        '<C-h>')
  call smartinput#map_to_trigger('i', '<Plug>(smartinput_CR)',
        \                        '<Enter>',
        \                        '<Enter>')
endfunction
unlet s:bundle

" open-browser
nnoremap <silent> <F7> :PrevimOpen<CR>

"" unite.vim {{{
"nnoremap <SID>[unite] <Nop>
"nmap <Leader> <SID>[unite]
"" ファイル一覧
"nnoremap <silent> <SID>[unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
"" バッファ一覧
"nnoremap <silent> <SID>[unite]b :<C-u>Unite buffer<CR>
"" レジスタ一覧
"nnoremap <silent> <SID>[unite]r :<C-u>Unite -buffer-name=register register<CR>
"" 最近使用したファイル一覧
"nnoremap <silent> <SID>[unite]m :<C-u>Unite file_mru<CR>
""ブックマーク一覧
"nnoremap <silent> <SID>[unite]c :<C-u>Unite bookmark<CR>
""ブックマークに追加
"nnoremap <silent> <SID>[unite]a :<C-u>UniteBookmarkAdd<CR>
"
"augroup UniteKeyMap
"  autocmd!
"  " ウィンドウを分割して開く
"  autocmd FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
"  autocmd FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
"  " ウィンドウを縦に分割して開く
"  autocmd FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
"  autocmd FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
"  " 新規ウィンドウで開く
"  autocmd FileType unite nnoremap <silent> <buffer> <expr> <Space> unite#do_action('tabdrop')
"  "autocmd FileType unite inoremap <silent> <buffer> <expr> <C-o> unite#do_action('open')
"  " ESCキーを2回押すと終了する
"  autocmd FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
"  autocmd FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
"augroup END
"" }}}

" }}}

" }}}


"バイナリ編集(xxd)モード（vim -b での起動、もしくは *.bin で発動します）{{{
augroup BinaryXXD
        autocmd!
        autocmd BufReadPre  *.bin let &binary =1
        autocmd BufReadPost * if &binary | silent %!xxd -g 1
        autocmd BufReadPost * set ft=xxd | endif
        autocmd BufWritePre * if &binary | %!xxd -r
        autocmd BufWritePre * endif
        autocmd BufWritePost * if &binary | silent %!xxd -g 1
        autocmd BufWritePost * set nomod | endif
augroup END
" }}}

if !exists(':DiffOrig')
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

"Vimでgitのログをきれいに表示する - derisの日記
"  http://deris.hatenablog.jp/entry/2013/05/10/003430
" source ~/dotfiles/.vimrc.gitlogviewer

" vim: foldmethod=marker
" vim: foldcolumn=3
