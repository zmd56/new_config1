"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++
"                 /##    /##
" __  __         | ##   | ##/##/######/#### 
"|  \/  |_   _   |  ## / ##| #| ##_  ##_  ## ____   ____ 
"| |\/| | | | |   \  ## ##/| #| ## \ ## \ ##|  _ \ / ___|
"| |  | | |_| |    \  ###/ | #| ## | ## | ##| |_) | | 
"|_|  |_|\__, |     \  #/  | #| ## | ## | ##|  _ <| |___ 
"        |___/       \_/   |__|__/ |__/ |__/|_| \_\\____|
"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++

execute 'source' fnamemodify(expand('<sfile>'), ':h').'/config/main.vim'

" =========================
" === Terminal Behaviors
" =========================
let g:neoterm_autoscroll = 1
autocmd TermOpen term://* startinsert
tnoremap <C-N> <C-\><C-N>
tnoremap <C-O> <C-\><C-N><C-O>
let g:terminal_color_0  = '#000000'
let g:terminal_color_1  = '#FF5555'
let g:terminal_color_2  = '#50FA7B'
let g:terminal_color_3  = '#F1FA8C'
let g:terminal_color_4  = '#BD93F9'
let g:terminal_color_5  = '#FF79C6'
let g:terminal_color_6  = '#8BE9FD'
let g:terminal_color_7  = '#BFBFBF'
let g:terminal_color_8  = '#4D4D4D'
let g:terminal_color_9  = '#FF6E67'
let g:terminal_color_10 = '#5AF78E'
let g:terminal_color_11 = '#F4F99D'
let g:terminal_color_12 = '#CAA9FA'
let g:terminal_color_13 = '#FF92D0'
let g:terminal_color_14 = '#9AEDFE'

" ====================================
" === Basic Mappings
" === Set <LEADER> as <SPACE>, ; as :
" ====================================
let mapleader=" "
noremap ; :

"================
"系统设置
"================
"显示操作提示,右下角命令提示
set showcmd

" 插入模下jj映射为<Esc>
" inoremap jj <Esc>

" 设置编码
set encoding=utf8

" 设置字体
set guifont=DroidSansMono\ Nerd\ Font\ 11

"设置行不超过当前屏幕
set wrap

"设置帮助为中文
set helplang=cn

" 设置空白字符的视觉提示
" set list listchars=extends:❯,precedes:❮,tab:▸\ ,trail:˽
 set list
 set listchars=tab:\|\ ,trail:▫

"边输入边高亮
set incsearch

"大写的S为写入
map S :w<CR>

"大写Q为退出
map Q :q<CR>

"  key: go to the start of the line
noremap <silent> << 0
" I key: go to the end of the line
noremap <silent> >> $

noremap <silent> H 8h
noremap <silent> M 5j
noremap <silent> U 5k
noremap <silent> L 8l
noremap <silent> W 5w
noremap <silent> B 5b

" 复制到系统剪贴板
vnoremap fy :w !xclip -i -sel c<CR>

" 寻找两个相等的单词
map fv /\(\<\w\+\>\)\_s*\1

"设置分屏：sd向右、sa向左、sw向上、sx向下
map sd :set splitright<CR>:vsplit<CR>
map sa :set nosplitright<CR>:vsplit<CR>
map sw :set nosplitbelow<CR>:split<CR>
map sx :set splitbelow<CR>:split<CR>

"设置分屏的跳转，<LEADER>l:空格+l向右跳一个窗口
map fl <C-W>l
map fh <C-W>h
map fk <C-W>k
map fj <C-W>j

"设置ft为新建标签，fd跳转前一个(向左)标签，fg向后跳转
map ft :tabe<CR>
map fd :-tabnext<CR>
map fg :+tabnext<CR>

"设置floaterm
" let g:floaterm_keymap_new    = '<F5>'
let g:floaterm_keymap_new    = '<M-n>'

" =====================
" ===设置md/tex输入
" =====================
source ~/.config/nvim/md-snippets.vim
autocmd BufRead,BufNewFile *.md setlocal spell
source ~/.config/nvim/tex-snippets.vim
autocmd BufRead,BufNewFile *.tex setlocal spell

"==============
" ===搜索配置
"==============
"搜索内容高亮
set hlsearch
"清除上一次的搜索，不清除上次搜索的高亮还会显示
exec "nohlsearch"
"设置<LEADER><CR>,即空格+回车，削除当前搜索的高亮
noremap cl :nohlsearch<CR>
noremap - N
noremap = n
" 搜索后下一个结果光标在中间
" noremap n nzz
" 搜索后上一个结果光标在中间
" noremap N Nzz

"搜索忽略大小写
set ignorecase
"智能大小写，搜索时不区分大小写
set smartcase

" 调整窗口大小
noremap <up> :res +5<CR>
noremap <down> :res -5<CR>
noremap <left> :vertical resize-5<CR>
noremap <right> :vertical resize+5<CR>

"==============================
"===设置自动运行，快捷键r
"==============================
noremap r :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		exec "!g++ % -o %<"
		exec "!time ./%<"
	elseif &filetype == 'cpp'
		set splitbelow
		exec "!g++ -std=c++11 % -Wall -o %<"
		:sp
		:res -15
		:term ./%<
	elseif &filetype == 'java'
		exec "!javac %"
		exec "!time java %<"
	elseif &filetype == 'sh'
		:!time bash %
	elseif &filetype == 'python'
		set splitbelow
		:sp
		:term python3 %
	elseif &filetype == 'html'
		silent! exec "!".g:mkdp_browser." % &"
	elseif &filetype == 'markdown'
		exec "MarkdownPreview"
	elseif &filetype == 'tex'
		silent! exec "VimtexStop"
		silent! exec "VimtexCompile"
	elseif &filetype == 'dart'
		exec "CocCommand flutter.run -d ".g:flutter_default_device." ".g:flutter_run_args
		silent! exec "CocCommand flutter.dev.openDevLog"
	elseif &filetype == 'javascript'
		set splitbelow
		:sp
		:term export DEBUG="INFO,ERROR,WARNING"; node --trace-warnings .
	elseif &filetype == 'go'
		set splitbelow
		:sp
		:term go run .
	endif
endfunc


" ======================
" === MarkdownPreview
" ======================
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 0
let g:mkdp_command_for_global = 0
let g:mkdp_open_to_the_world = 0
let g:mkdp_open_ip = ''
let g:mkdp_echo_preview_url = 0
let g:mkdp_browserfunc = ''
let g:mkdp_preview_options = {
			\ 'mkit': {},
			\ 'katex': {},
			\ 'uml': {},
			\ 'maid': {},
			\ 'disable_sync_scroll': 0,
			\ 'sync_scroll_type': 'middle',
			\ 'hide_yaml_meta': 1
			\ }
let g:mkdp_markdown_css = ''
let g:mkdp_highlight_css = ''
let g:mkdp_port = ''
let g:mkdp_page_title = '「${name}」'

" ===================
" ===设置注释快捷键
" ===================
map f' :call Note()<CR>
func! Note()
    if &filetype == 'python'
        normal 0i# 
    endif
    if &filetype == 'vim'
        normal 0i" 
    endif
    if &filetype == 'plaintex'
        normal 0i% 
    endif
    if &filetype == 'tex'
        normal 0i% 
    endif
    if &filetype == 'c'
        normal 0i// 
    endif
    if &filetype == 'cpp'
        normal 0i// 
    endif
    if &filetype == 'conf'
        normal 0i# 
    endif
endfunc

" ================
" ===设置取消注释
" ================
map " 0df j

" =====================
" ===设置bash语言支持
" =====================
let g:LanguageClient_serverCommands = {
    \ 'sh': ['bash-language-server', 'start']
    \ }

" =====================
" ===背景透明re切换
" =====================
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set background=dark    " Setting dark mode
colorscheme OceanicNext
let g:deus_termcolors=256
highlight! NonText ctermfg=gray guifg=grey10
" Use 'seb' to toggle the background opacity.
let g:StylesBOpacity = 0
noremap re :call StylesBackgroundOpacityToggle()<CR>
function! StylesBackgroundOpacityToggle()
    if g:StylesBOpacity == 0
        execute "highlight Normal ctermfg=None ctermbg=None guifg=None guibg=None"
        execute "highlight! NonText ctermfg=gray guifg=grey10"
        set nocursorline
        set cc=0
        let g:StylesBOpacity = 1
    else
        colorscheme OceanicNext
        execute "highlight! NonText ctermfg=gray guifg=grey10"
        set cursorline
        set cc=80
        let g:StylesBOpacity = 0
    endif
endfunction

let g:ruby_host_prog = '~/.gem/ruby/2.7.0/bin/neovim-ruby-host'

" ===================
" ===插件安装
" ===================
call plug#begin('~/.config/nvim/plugged')

  " 图标插件
  Plug 'ryanoasis/vim-devicons'
  " rnvimr插件,悬浮窗口ranger
  Plug 'kevinhwang91/rnvimr'
  " 括号匹配插件
  Plug 'frazrepo/vim-rainbow'
  " 括号多颜色
  Plug 'kien/rainbow_parentheses.vim'
  " 多行操作
  Plug 'mg979/vim-visual-multi', {'branch': 'master'}
  " 自动格式化
  Plug 'Chiel92/vim-autoformat'
  " 选中操作插件
  Plug 'gcmt/wildfire.vim'
  " 调试器
  Plug 'puremourning/vimspector',{'do':'./install_gadget.py --enable-python --enable-go --enable-bash --enable-c --force-enable-chrome'}
  " 单词下有条线插件
  Plug 'itchyny/vim-cursorword'
  " 同时高亮多个单词不同颜色
  Plug 'lfv89/vim-interestingwords'

call plug#end()

" =======================
" === COC插件管理
" =======================
let g:coc_global_extensions = [
      \'coc-marketplace',
      \'coc-actions',
      \'coc-css',
      \'coc-diagnostic',
      \'coc-explorer',
      \'coc-flutter-tools',
      \'coc-gitignore',
      \'coc-html',
      \'coc-json',
      \'coc-lists',
      \'coc-prettier',
      \'coc-pyright',
      \'coc-python',
      \'coc-snippets',
      \'coc-sourcekit',
      \'coc-stylelint',
      \'coc-syntax',
      \'coc-tasks',
      \'coc-todolist',
      \'coc-translator',
      \'coc-tslint-plugin',
      \'coc-tsserver',
      \'coc-vetur',
      \'coc-vimlsp',
      \'coc-yaml',
      \'coc-yank']

" ====================
" === vimtex
" ====================
"let g:vimtex_view_method = ''
 let g:vimtex_view_general_viewer = 'llpp'
 let g:vimtex_mappings_enabled = 0
 let g:vimtex_text_obj_enabled = 0
 let g:vimtex_motion_enabled = 0
 let maplocalleader=' '

let g:coc_global_extensions = ['coc-python']
let g:tex_flavor='latex'
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_SmartKeyBS=0
let g:Tex_ViewRule_pdf = 'zathura'

" call SingleCompile#SetCompilerTemplate('tex', '/usr/bin/xelatex', 'XeLatex',
"             \ '/usr/bin/xelatex', '',
"             \ SingleCompile#GetDefaultOpenCommand() .
"             \ ' "$(FILE_TITLE)$.pdf"')
" call SingleCompile#ChooseCompiler('tex', '/usr/bin/xelatex')
nmap <F6> :SCCompile<CR>
imap <F6> :SCCompile<CR>
let g:livepreview_previewer='zathura'
autocmd Filetype tex,plaintex setl updatetime=1
let g:livepreview_engine='/usr/bin/xelatex'
let g:livepreview_cursorhold_recompile=0
set conceallevel=1
let g:tex_conceal='abdmg'
let g:Tex_FoldedSections=''

" =============================
" ===coc-translator
" =============================
nmap <M-t> <Plug>(coc-translator-p)
vmap <M-t> <Plug>(coc-translator-pv)
" echo
nmap <M-e> <Plug>(coc-translator-e)
vmap <M-e> <Plug>(coc-translator-ev)
" replace
nmap <M-r> <Plug>(coc-translator-r)
vmap <M-r> <Plug>(coc-translator-rv)

" ===================
" ===rnvimr 
" ===================
tnoremap <silent> <M-i> <C-\><C-n>:RnvimrResize<CR>
nnoremap <silent> <M-o> :RnvimrToggle<CR>
tnoremap <silent> <M-o> <C-\><C-n>:RnvimrToggle<CR>
   " Make Ranger replace Netrw and be the file explorer
   let g:rnvimr_enable_ex = 1
   " Make Ranger to be hidden after picking a file
   let g:rnvimr_enable_picker = 1
   " Disable a border for floating window
   let g:rnvimr_draw_border = 0
   " Hide the files included in gitignore
   let g:rnvimr_hide_gitignore = 1
   " Change the border's color
   let g:rnvimr_border_attr = {'fg': 14, 'bg': -1}
   " Make Neovim wipe the buffers corresponding to the files deleted by Ranger
   let g:rnvimr_enable_bw = 1
   " Set up only two columns in miller mode and draw border with both
   let g:rnvimr_ranger_cmd = 'ranger --cmd="set column_ratios 1,1"
               \ --cmd="set draw_borders both"'
   " Link CursorLine into RnvimrNormal highlight in the Floating window
   highlight link RnvimrNormal CursorLine
   nnoremap <silent> <M-o> :RnvimrToggle<CR>
   tnoremap <silent> <M-o> <C-\><C-n>:RnvimrToggle<CR>
   " Resize floating window by all preset layouts
   tnoremap <silent> <M-i> <C-\><C-n>:RnvimrResize<CR>
   " Resize floating window by special preset layouts
   tnoremap <silent> <M-l> <C-\><C-n>:RnvimrResize 1,8,9,11,5<CR>
   " Resize floating window by single preset layout
   tnoremap <silent> <M-y> <C-\><C-n>:RnvimrResize 6<CR>
   " Map Rnvimr action
   let g:rnvimr_action = {
               \ '<C-t>': 'NvimEdit tabedit',
               \ '<C-x>': 'NvimEdit split',
               \ '<C-v>': 'NvimEdit vsplit',
               \ 'gw': 'JumpNvimCwd',
               \ 'yw': 'EmitRangerCwd'
               \ }
   " Customize the initial layout
   let g:rnvimr_layout = { 'relative': 'editor',
               \ 'width': float2nr(round(0.6 * &columns)),
               \ 'height': float2nr(round(0.6 * &lines)),
               \ 'col': float2nr(round(0.2 * &columns)),
               \ 'row': float2nr(round(0.2 * &lines)),
               \ 'style': 'minimal' }
   " Customize multiple preset layouts
   " '{}' represents the initial layout
   let g:rnvimr_presets = [
                 \ {},
                 \ {'width': 0.700, 'height': 0.700},
                 \ {'width': 0.800, 'height': 0.800},
                 \ {'width': 0.950, 'height': 0.950},
                 \ {'width': 0.500, 'height': 0.500, 'col': 0, 'row': 0},
                 \ {'width': 0.500, 'height': 0.500, 'col': 0, 'row': 0.5},
                 \ {'width': 0.500, 'height': 0.500, 'col': 0.5, 'row': 0},
                 \ {'width': 0.500, 'height': 0.500, 'col': 0.5, 'row': 0.5},
                 \ {'width': 0.500, 'height': 1.000, 'col': 0, 'row': 0},
                 \ {'width': 0.500, 'height': 1.000, 'col': 0.5, 'row': 0},
                 \ {'width': 1.000, 'height': 0.500, 'col': 0, 'row': 0},
                 \ {'width': 1.000, 'height': 0.500, 'col': 0, 'row': 0.5}]


" ===================
" === 括号匹配高亮
" ===================
" hi MatchParen ctermbg=Yellow guibg=lightblue
" hi MatchParen ctermbg=Yellow guibg=Chartreuse

" ===================
" === 括号匹配
" ===================
" let g:rainbow_active = 0
" 
" let g:rainbow_load_separately = [
" "    \ [ '*' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
" "    \ [ '*.tex' , [['(', ')'], ['\[', '\]']] ],
" "    \ [ '*.cpp' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
" "    \ [ '*.{html,htm}' , [['(', ')'], ['\[', '\]'], ['{', '}'], ['<\a[^>]*>', '</[^>]*>']] ],
" "    \ ]
" 
" let g:rainbow_guifgs = ['RoyalBlue3', 'DarkOrange3', 'DarkOrchid3', 'FireBrick']
" let g:rainbow_ctermfgs = ['lightblue', 'lightgreen', 'yellow', 'red', 'magenta']

let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]

let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" ================
" ===FZF
" ================
nmap <Leader>f [fzf-p]
xmap <Leader>f [fzf-p]

nnoremap <silent> [fzf-p]p     :<C-u>CocCommand fzf-preview.FromResources project_mru git<CR>
nnoremap <silent> [fzf-p]gs    :<C-u>CocCommand fzf-preview.GitStatus<CR>
nnoremap <silent> [fzf-p]ga    :<C-u>CocCommand fzf-preview.GitActions<CR>
nnoremap <silent> [fzf-p]b     :<C-u>CocCommand fzf-preview.Buffers<CR>
nnoremap <silent> [fzf-p]B     :<C-u>CocCommand fzf-preview.AllBuffers<CR>
nnoremap <silent> [fzf-p]o     :<C-u>CocCommand fzf-preview.FromResources buffer project_mru<CR>
nnoremap <silent> [fzf-p]<C-o> :<C-u>CocCommand fzf-preview.Jumps<CR>
nnoremap <silent> [fzf-p]g;    :<C-u>CocCommand fzf-preview.Changes<CR>
nnoremap <silent> [fzf-p]/     :<C-u>CocCommand fzf-preview.Lines --add-fzf-arg=--no-sort --add-fzf-arg=--query="'"<CR>
nnoremap <silent> [fzf-p]*     :<C-u>CocCommand fzf-preview.Lines --add-fzf-arg=--no-sort --add-fzf-arg=--query="'<C-r>=expand('<cword>')<CR>"<CR>
nnoremap          [fzf-p]gr    :<C-u>CocCommand fzf-preview.ProjectGrep<Space>
xnoremap          [fzf-p]gr    "sy:CocCommand   fzf-preview.ProjectGrep<Space>-F<Space>"<C-r>=substitute(substitute(@s, '\n', '', 'g'), '/', '\\/', 'g')<CR>"
nnoremap <silent> [fzf-p]t     :<C-u>CocCommand fzf-preview.BufferTags<CR>
nnoremap <silent> [fzf-p]q     :<C-u>CocCommand fzf-preview.QuickFix<CR>
nnoremap <silent> [fzf-p]l     :<C-u>CocCommand fzf-preview.LocationList<CR>


" ======================
" === vimspector调试器
" ======================
let g:vimspector_enable_mappings = 'HUMAN'
function! s:read_template_into_buffer(template)
	" has to be a function to avoid the extra space fzf#run insers otherwise
	execute '0r ~/.config/nvim/sample_vimspector_json/'.a:template
endfunction
command! -bang -nargs=* LoadVimSpectorJsonTemplate call fzf#run({
			\   'source': 'ls -1 ~/.config/nvim/sample_vimspector_json',
			\   'down': 20,
			\   'sink': function('<sid>read_template_into_buffer')
			\ })
noremap <leader>vs :tabe .vimspector.json<CR>:LoadVimSpectorJsonTemplate<CR>
sign define vimspectorBP text=☛ texthl=Normal
sign define vimspectorBPDisabled text=☞ texthl=Normal
sign define vimspectorPC text=🔶 texthl=SpellBad
