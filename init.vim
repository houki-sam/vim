set encoding=utf-8
scriptencoding utf-8
" 保存時の文字コード
set fileencoding=utf-8
" 読み込み時の文字コードの自動判別. 左側が優先される
set fileencodings=ucs-boms,utf-8,euc-jp,cp932
" 改行コードの自動判別. 左側が優先される
set fileformats=unix,dos,mac
" □や○文字が崩れる問題を解決"
set ambiwidth=double
"bashファイルの読み込み
let $BASH_ENV="~/.bash_profile"
set number
set backspace=indent,eol,start

" タブ入力を複数の空白入力に置き換える
set expandtab
" 画面上でタブ文字が占める幅
set tabstop=4
" 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set softtabstop=4
" 改行時に前の行のインデントを継続する
set autoindent
" 改行時に前の行の構文をチェックし次の行のインデントを増減する
set smartindent
" smartindentで増減する幅"
set shiftwidth=4

" インクリメンタルサーチ. １文字入力毎に検索を行う
set incsearch
" 検索パターンに大文字小文字を区別しない
set ignorecase
" 検索パターンに大文字を含んでいたら大文字小文字を区別する
set smartcase
" 検索結果をハイライト"
set hlsearch

" 不可視文字を可視化(タブが「▸-」と表示される)
set list listchars=tab:\▸\-

" カーソルの左右移動で行末から次の行の行頭への移動が可能になる
set whichwrap=b,s,h,l,<,>,[,],~

" カーソルラインをハイライト"
set cursorline

" 行が折り返し表示されていた場合、行単位ではなく表示行単位でカーソルを移動する
nnoremap j gj
nnoremap k gk
nnoremap <down> gj
nnoremap <up> gk

" tagsジャンプの時に複数ある時は一覧表示
"nnoremap <C-]> g<C-]>
nnoremap <C-h> :vsp<CR> :exe("tjump ".expand('<cword>'))<CR>
nnoremap <C-k> :split<CR> :exe("tjump ".expand('<cword>'))<CR>

" 括弧の対応関係を一瞬表示する
set showmatch
source $VIMRUNTIME/macros/matchit.vim " Vimの「%」を拡張する "

" コマンドモードの補完
set wildmenu
" 保存するコマンド履歴の数  "
set history=5000


"=================dein================
" プラグインが実際にインストールされるディレクトリ
let s:dein_dir = expand('~/.cache/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" 設定開始
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " プラグインリストを収めた TOML ファイル
  " 予め TOML ファイル（後述）を用意しておく
  let g:rc_dir    = expand('~/.vim/rc')
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})
  " 設定終了
  call dein#end()
  call dein#save_state()
endif

" もし、未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
endif





"====================junegunn/vim-easy-align====================
"enterで整形設定に行くようにする
vmap <Enter> <Plug>(EasyAlign)


" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : ''
    \ }

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()



"====================neosnippet====================
" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" ~ファイルタイプ毎 & gitリポジトリ毎にtagsの読み込みpathを変える~
function! ReadTags(type)
    try
        execute "set tags=".$HOME."/dotfiles/tags_files/".
              \ system("cd " . expand('%:p:h') . "; basename `git rev-parse --show-toplevel` | tr -d '\n'").
              \ "/" . a:type . "_tags"
    catch
        execute "set tags=./tags/" . a:type . "_tags;"
    endtry
endfunction

"augroup TagsAutoCmd
 "   autocmd!
  "  autocmd BufEnter * :call ReadTags(&filetype)
"augroup END





" ====================indentLine====================
let g:indentLine_char = '¦' "use ¦, ┆ or │
"====================haya14busa/vim-operator-flashy====================
"map y <Plug>(operator-flashy)
"nmap Y <Plug>(operator-flashy)$


"====================EmmetHmtl"====================
  let g:user_emmet_leader_key = '<C-Y>'
let g:user_emmet_settings = {
\  'variables' : {
\    'lang' : "ja"
\  },
\  'indentation' : '  ',
\  'html' : {
\    'snippets' : {
\      'html:5': "<!DOCTYPE html>\n"
\        ."<html lang=\"${lang}\">\n"
\        ."<head>\n"
\        ."\t<meta charset=\"${charset}\">\n"
\        ."\t<meta name=\"description\" content=\"\">\n"
\        ."\t<title></title>\n"
\        ."</head>\n"
\        ."<body>\n\t${child}|\n</body>\n"
\        ."</html>",
\    }
\  }
\}
"====================NerdTree======================
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <C-e> :NERDTreeToggle<CR>


"tex"
let g:vimtex_compiler_latexmk = {
      \ 'background': 1,
      \ 'build_dir': '',
      \ 'continuous': 1,
      \ 'options': [
      \    '-pdfdvi', 
      \    '-verbose',
      \    '-file-line-error',
      \    '-synctex=1',
      \    '-interaction=nonstopmode',
      \],
      \}

let g:vimtex_view_general_viewer
      \ = '/Applications/Skim.app/Contents/SharedSupport/displayline'
let g:vimtex_view_general_options = '-r @line @pdf @tex'


colorsc kalisi
"色を付ける
syntax on

set completeopt=menuone                        " 補完候補を呼び出すとき常にポップアップメニューを使う
function! s:jedivim_hook()              " jedi-vimを使うときだけ呼び出す処理を関数化
  let g:jedi#auto_initialization    = 0 " 自動で実行される初期化処理を無効
  let g:jedi#auto_vim_configuration = 0 " 'completeopt' オプションを上書きしない
  let g:jedi#popup_on_dot           = 0 " ドット(.)を入力したとき自動で補完しない
  let g:jedi#popup_select_first     = 0 " 補完候補の1番目を選択しない
  let g:jedi#show_call_signatures   = 0 " 関数の引数表示を無効(ポップアップのバグを踏んだことがあるため)
  autocmd FileType python setlocal omnifunc=jedi#completions   " 補完エンジンはjediを使う
endfunction


inoremap { {}<Left>
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap ( ()<ESC>i
inoremap (<Enter> ()<Left><CR><ESC><S-o>

set clipboard+=unnamed,unnamedplus 
"数式自動変換無効化
let g:tex_conceal=''

"bufffer
:let g:miniBufExplMapWindowNavVim = 1
:let g:miniBufExplMapWindowNavArrows = 1
:let g:miniBufExplMapCTabSwitchBuffs = 1

let g:airline_powerline_fonts = 1
nmap <C-p> <Plug>AirlineSelectPrevTab
nmap <C-p> <Plug>AirlineSelectNextTab 
let g:airline#extensions#tabline#buffer_idx_mode = 1
set laststatus =2
let g:airline_theme = 'kalisi'

set bg =dark

"インデント関係
let g:indent_guides_enable_on_vim_startup = 1

