# =========================
# PATH
# =========================
BREW_PREFIX="$(brew --prefix)"

path=(
    "$HOME/.local/bin"
    "$HOME/.bun/bin"
    "$HOME/Library/pnpm"
    "$HOME/.opencode/bin"
    "$BREW_PREFIX/opt/ruby@3.4/bin"
    "$BREW_PREFIX/opt/llvm/bin"
    "$BREW_PREFIX/opt/mysql@8.4/bin"
    "$BREW_PREFIX/bin"
    "$HOME/.sdkman/candidates/java/current/bin"
    "$HOME/.sdkman/candidates/maven/current/bin"
    "$HOME/.sdkman/candidates/gradle/current/bin"
    $path
)

# =========================
# Environment
# =========================
export BUN_INSTALL="$HOME/.bun"
export NVM_DIR="$HOME/.nvm"
export HOMEBREW_NO_AUTO_UPDATE=1
export LDFLAGS="-L/$BREW_PREFIX/opt/ruby@3.4/lib"
export CPPFLAGS="-I/$BREW_PREFIX/opt/ruby@3.4/include"

# =========================
# Aliases
# =========================
alias ls='eza --icons=always --group-directories-first'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias cat='bat'
alias python='python3'
alias ip='ifconfig | grep inet'
alias neofetch='fastfetch'
alias dt='deno task'
alias speedtest='networkQuality'

# =========================
# ZINIT
# =========================
ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"
[[ ! -d $ZINIT_HOME ]] && {
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
}
source "$ZINIT_HOME/zinit.zsh"

zinit wait lucid for \
    zsh-users/zsh-autosuggestions \
    zsh-users/zsh-completions \
    zsh-users/zsh-history-substring-search \
    zdharma-continuum/fast-syntax-highlighting \
    hlissner/zsh-autopair \
    MichaelAquilina/zsh-you-should-use

zinit light Aloxaf/fzf-tab
zinit ice depth=1; zinit light romkatv/powerlevel10k

# =========================
# Completions
# =========================
FPATH="$HOME/.zsh/completions:$BREW_PREFIX/share/zsh-completions:$BREW_PREFIX/share/zsh/site-functions:$FPATH"
autoload -Uz compinit && compinit -C

# =========================
# History
# =========================
setopt SHARE_HISTORY HIST_IGNORE_DUPS HIST_IGNORE_SPACE \
       HIST_EXPIRE_DUPS_FIRST INC_APPEND_HISTORY EXTENDED_HISTORY

# =========================
# Keybinds
# =========================
bindkey "${terminfo[kcuu1]}" history-substring-search-up
bindkey "${terminfo[kcud1]}" history-substring-search-down
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# =========================
# fzf-tab
# =========================
zstyle ':fzf-tab:complete:(cd|__zoxide_z):*' fzf-preview \
    'eza --color=always --icons=always --group-directories-first -1 $realpath'

zstyle ':fzf-tab:complete:*' fzf-preview '
    if [[ -d $realpath ]]; then
        eza --color=always --icons=always --group-directories-first -1 $realpath
    else
        bat --color=always --style=numbers --line-range=:100 $realpath 2>/dev/null
    fi'

zstyle ':fzf-tab:*' fzf-flags --height=65% --layout=reverse --border
zstyle ':fzf-tab:*' fzf-min-height 25
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# =========================
# Tools
# =========================
eval "$(zoxide init zsh)"
eval "$(atuin init zsh)"
eval "$(fnm env --use-on-cd)"
eval "$(thefuck --alias fuck)"

ZSH_AUTOSUGGEST_STRATEGY=(atuin history)
ZSH_AUTOSUGGEST_USE_ASYNC=true

[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
[[ -s "$HOME/.bun/_bun" ]] && source "$HOME/.bun/_bun"
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

