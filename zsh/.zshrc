# =========================
# General ZSHRC — zinit + fzf-tab + lsd + zoxide (2026)
# =========================

# -------------------------
# PATH setup
# -------------------------
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.sdkman/bin:$PATH"
export PATH="$HOME/.nvm/bin:$PATH"
export PATH="$HOME/.lmstudio/bin:$PATH"
export PATH="$HOME/Library/pnpm:$PATH"
export PATH="/usr/local/opt/mysql-client/bin:$PATH"
export PATH="/opt/homebrew/opt/mysql@8.4/bin:$PATH"
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="$(brew --prefix)/opt/python@3.10/libexec/bin:$PATH"
export PATH="$HOME/.sdkman/candidates/java/current/bin:$PATH"
export PATH="$HOME/.sdkman/candidates/maven/current/bin:$PATH"
export PATH="$HOME/.sdkman/candidates/gradle/current/bin:$PATH"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="/opt/homebrew/opt/ruby@3.4/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/ruby@3.4/lib"
export CPPFLAGS="-I/opt/homebrew/opt/ruby@3.4/include"
export PATH="/Users/ardonplay/.venv-vllm-metal/bin:$PATH"
export PATH=/Users/ardonplay/.opencode/bin:$PATH
# FNM
export PATH="/Users/ardonplay/.local/state/fnm_multishells/29482_1769658839269/bin":$PATH
export FNM_MULTISHELL_PATH="/Users/ardonplay/.local/state/fnm_multishells/29482_1769658839269"
export FNM_VERSION_FILE_STRATEGY="local"
export FNM_DIR="/Users/ardonplay/.local/share/fnm"
export FNM_LOGLEVEL="info"
export FNM_NODE_DIST_MIRROR="https://nodejs.org/dist"
export FNM_COREPACK_ENABLED="false"
export FNM_RESOLVE_ENGINES="true"
export FNM_ARCH="arm64"
rehash

# -------------------------
# Environment variables
# -------------------------
export HOMEBREW_NO_AUTO_UPDATE=1
export NVM_DIR="$HOME/.nvm"

# -------------------------
# Aliases
# -------------------------
alias ls='eza --icons=always --group-directories-first'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias ip='ifconfig | grep inet'
alias neofetch='fastfetch'
alias python='python3'
alias dt='deno task'
alias speedtest='networkQuality'
alias cat='bat'

# -------------------------
# FPATH for completions
# -------------------------
COMPLETIONS_DIR="$HOME/.zsh/completions"
[[ ":$FPATH:" != *":$COMPLETIONS_DIR:"* ]] && export FPATH="$COMPLETIONS_DIR:$FPATH"

# =========================
# ZINIT — плагин-менеджер
# =========================
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[[ ! -d $ZINIT_HOME ]] && {
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
}
source "${ZINIT_HOME}/zinit.zsh"

# Основные плагины
zinit wait lucid for \
    zsh-users/zsh-autosuggestions \
    zsh-users/zsh-completions

# History substring search (отдельно)
zinit wait lucid for \
    zsh-users/zsh-history-substring-search

# Правильные стрелки ↑↓ (через terminfo — работает в iTerm, Warp, Kitty и т.д.)
bindkey "${terminfo[kcuu1]}" history-substring-search-up
bindkey "${terminfo[kcud1]}" history-substring-search-down

# Syntax highlighting — ОБЯЗАТЕЛЬНО после bindkey!
zinit wait lucid for \
    zdharma-continuum/fast-syntax-highlighting

# Дополнительные плагины
zinit light Aloxaf/fzf-tab
zinit light hlissner/zsh-autopair
zinit light MichaelAquilina/zsh-you-should-use
zinit ice depth=1; zinit light romkatv/powerlevel10k

# compinit
autoload -Uz compinit && compinit -C

# =========================
# Опции истории и поведения
# =========================
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_EXPIRE_DUPS_FIRST
setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY

# Клавиши для поиска по истории (↑↓)
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# =========================
# fzf-tab
# =========================
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --color=always --icons=always --group-directories-first -1 $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza --color=always --icons=always --group-directories-first -1 $realpath'

zstyle ':fzf-tab:complete:*' fzf-preview '
    if [[ -d $realpath ]]; then
        eza --color=always --icons=always --group-directories-first -1 $realpath
    else
        bat --color=always --style=numbers --line-range=:100 $realpath 2>/dev/null || eza --color=always --icons=always -1 $realpath
    fi'

zstyle ':fzf-tab:*' fzf-flags --height=65% --layout=reverse --border
zstyle ':fzf-tab:*' fzf-min-height 25

# Цвета как у lsd
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

if command -v rbenv &> /dev/null; then
   eval "$(rbenv init - zsh)"
fi

if type brew &>/dev/null; then
  FPATH="$(brew --prefix)/share/zsh-completions:$(brew --prefix)/share/zsh/site-functions:$FPATH"
fi
[ -s "/Users/ardonplay/.bun/_bun" ] && source "/Users/ardonplay/.bun/_bun"


# -------------------------
# zoxide (умный cd)
# -------------------------
eval "$(zoxide init zsh)"
# -------------------------
# autin (better history btw)
# -------------------------
eval "$(atuin init zsh)"
ZSH_AUTOSUGGEST_STRATEGY=(atuin history)
ZSH_AUTOSUGGEST_USE_ASYNC=true


[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
