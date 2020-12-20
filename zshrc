# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

###======================
###=== 设置光标为竖线
###======================
echo -ne "\e[5 q"

###======================
###===快捷键
###======================
#figlet -fterm "Wecome to zsh,Hai_Wang"
alias R="reboot"
alias P="shutdown -h now"
alias A="alsi"
alias S="screenfetch"
alias D="neofetch"
alias F="figlet"
alias C="cowsay"

alias q="exit"
alias c="clear"
alias pm="sudo pacman -S"
alias pms="sudo pacman -Syy"
alias pmu="sudo pacman -Syyu"
alias pmr="sudo pacman -Rs"
alias ya="yay -S"
alias cp="cp -r"
alias scp="sudo cp -r"
alias rm="rm -rf"
alias srm="sudo rm -rf"
alias rg="ranger"
alias lg="lazygit"

source ~/.config/fzf-tab/fzf-tab.plugin.zsh

# Path to your oh-my-zsh installation.
export ZSH=/usr/share/oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"
# ZSH_THEME="avit"
# ZSH_THEME="apple"
# ZSH_THEME="frisk"
# ZSH_THEME="jispwoso"
ZSH_THEME="ys"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
        z
        k
        git
        zsh-autopair
        autojump
        zsh-autosuggestions
        fast-syntax-highlighting
        colored-man-pages
        zsh-vim-mode
        ranger-autojump
        fzf-tab
        fzf
        zsh-completions
        zsh-history-substring-search
        command-not-found
        )


# User configuration
###==================
###===FZF
###==================
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_COMMAND='fdfind --hidden --follow -E ".git" -E "node_modules" . /etc /home'
export FZF_DEFAULT_OPTS='--height 90% --layout=reverse --bind=alt-j:down,alt-k:up,alt-i:toggle+down --border --preview "echo {} | ~/.config/fzf/fzf_preview.py" --preview-window=right'

# use fzf in bash and zsh
# Use ~~ as the trigger sequence instead of the default **
#export FZF_COMPLETION_TRIGGER='~~'

# Options to fzf command
#export FZF_COMPLETION_OPTS=''

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fdfind --hidden --follow -E ".git" -E "node_modules" . /etc /home
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fdfind --type d --hidden --follow -E ".git" -E "node_modules" . /etc /home
}

###==================================
###===fzf-tab
###==================================
# 当补全命令的开关时禁用排序
zstyle ':completion:complete:*:options' sort false

# 当补全 _zlua 时，使用输入作为查询字符串
zstyle ':fzf-tab:complete:_zlua:*' query-string input

# （实验性功能，未来可能更改）
# 一些定义 extract 变量的样板代码
# 稍后需要使用这个变量，请记得复制这段代码
local extract="
# 提取输入（当前选择的内容）
local in=\${\${\"\$(<{f})\"%\$'\0'*}#*\$'\0'}
# 获取当前补全状态的上下文（待补全内容的前面或者后面的东西）
local -A ctxt=(\"\${(@ps:\2:)CTXT}\")
# 真实路径
local realpath=\${ctxt[IPREFIX]}\${ctxt[hpre]}\$in
realpath=\${(Qe)~realpath}
"

# 补全 `kill` 命令时提供命令行参数预览
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm,cmd -w -w"
zstyle ':fzf-tab:complete:kill:argument-rest' extra-opts --preview=$extract'ps --pid=$in[(w)1] -o cmd --no-headers -w -w' --preview-window=right:3:wrap

# 补全 cd 时使用 exa 预览其中的内容
zstyle ':fzf-tab:complete:cd:*' extra-opts --preview=$extract'exa -1 --color=always $realpath'
# 补全vim时使用 exa 预览其中的内容
zstyle ':fzf-tab:complete:vim:*' extra-opts --preview=$extract'exa -1 --color=always $realpath'
# 补全所有
zstyle ':fzf-tab:complete:*:*' extra-opts --preview=$extract'exa -1 --color=always $realpath'
zstyle ':fzf-tab:complete:*:*' extra-opts --preview=$extract'bat -1 --color=always $realpath'
zstyle ':fzf-tab:*' fzf-command fzf
# FZF_TAB_COMMAND=(
    # fzf
    # --ansi   # 启用 ANSI 颜色代码的支持，对于显示分组来说是必需的
    # --expect='$continuous_trigger' # 连续补全
    # '--color=hl:$(( $#headers == 0 ? 108 : 255 ))'
    # --nth=2,3 --delimiter='\x00'  # 不搜索前缀
    # --layout=reverse --height='${FZF_TMUX_HEIGHT:=75%}'
    # --tiebreak=begin -m --bind=tab:down,btab:up,change:top,ctrl-space:toggle --cycle
    # '--query=$query'   # $query 将在运行时扩展为查询字符串
    # '--header-lines=$#headers' # $#headers 将在运行时扩展为组标题数目
# )
# zstyle ':fzf-tab:*' command $FZF_TAB_COMMAND

###======================================
###=== Codi
###=== Usage: codi [filetype] [filename]
###======================================
codi() {
  local syntax="${1:-python}"
  shift
  vim -c \
    "let g:startify_disable_at_vimenter = 1 |\
    set bt=nofile ls=0 noru nonu nornu |\
    hi ColorColumn ctermbg=NONE |\
    hi VertSplit ctermbg=NONE |\
    hi NonText ctermfg=0 |\
    Codi $syntax" "$@"
}

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

ZSH_CACHE_DIR=$HOME/.oh-my-zsh-cache
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

source $ZSH/oh-my-zsh.sh
