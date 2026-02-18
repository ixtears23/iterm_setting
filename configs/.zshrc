# Enable Powerlevel10k instant prompt (최상단에 위치해야 함)
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ===== 환경변수 =====
export LANG=ko_KR.UTF-8
export LC_ALL=ko_KR.UTF-8
export EDITOR=nvim
export VISUAL=nvim
export PAGER=less

# ===== PATH =====
# Homebrew (Apple Silicon)
if [[ -f /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# ===== Oh My Zsh 설정 =====
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

# 플러그인 목록
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-completions
  docker
  kubectl
  fzf
)

# zsh-completions 경로 추가
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

source $ZSH/oh-my-zsh.sh

# ===== 도구 초기화 =====
# zoxide (cd 대체)
if command -v zoxide &>/dev/null; then
  eval "$(zoxide init zsh)"
fi

# fzf
if [[ -f ~/.fzf.zsh ]]; then
  source ~/.fzf.zsh
fi

# ===== FZF 설정 =====
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS='
  --height 60%
  --layout=reverse
  --border
  --info=inline
  --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8
  --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc
  --color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8
  --color=selected-bg:#45475a
'

# ===== 앨리어스 =====
# eza (ls 대체)
if command -v eza &>/dev/null; then
  alias ls='eza --icons'
  alias ll='eza -alh --icons --git'
  alias lt='eza --tree --icons --level=2'
  alias la='eza -a --icons'
fi

# bat (cat 대체)
if command -v bat &>/dev/null; then
  alias cat='bat --paging=never'
  alias catp='bat'
fi

# fd (find 대체)
if command -v fd &>/dev/null; then
  alias find='fd'
fi

# 기타 앨리어스
alias vim='nvim'
alias vi='nvim'
alias lg='lazygit'
alias g='git'
alias gs='git status'
alias gd='git diff'
alias gl='git log --oneline --graph --decorate'

# ===== Powerlevel10k =====
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ===== iTerm2 Shell Integration =====
[[ -f "${HOME}/.iterm2_shell_integration.zsh" ]] && source "${HOME}/.iterm2_shell_integration.zsh"
export PATH="$(npm config get prefix)/bin:$PATH"
