header() {
  echo -e "
                   ██████╗░███████╗███████╗░█████╗░██████╗░░██████╗░██╗████████╗███████╗
                   ██╔══██╗██╔════╝╚════██║██╔══██╗╚════██╗██╔════╝░██║╚══██╔══╝██╔════╝
                   ██████╔╝█████╗░░░░███╔═╝██║░░██║░░███╔═╝██║░░██╗░██║░░░██║░░░█████╗░░
                   ██╔══██╗██╔══╝░░██╔══╝░░██║░░██║██╔══╝░░██║░░╚██╗██║░░░██║░░░██╔══╝░░
                   ██║░░██║███████╗███████╗╚█████╔╝███████╗╚██████╔╝██║░░░██║░░░███████╗
                   ╚═╝░░╚═╝╚══════╝╚══════╝░╚════╝░╚══════╝░╚═════╝░╚═╝░░░╚═╝░░░╚══════╝
 "
 }
 header | lolcat
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes

EDITOR=nvim
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="%F{green}attend %F{yellow}wesh %F{red}....%f"
DISABLE_UNTRACKED_FILES_DIRTY="true"

# see 'man strftime' for details.
HIST_STAMPS="mm/dd/yyyy"

ZSH_CUSTOM=$HOME/.zshrc.d/
COL_WIDTH=$((WIDTH / 2))
# Add wisely, as too many plugins slow down shell startup.
plugins=(git debian web-search brew ssh vscode)
source $ZSH/oh-my-zsh.sh 

# User configuration
export MANPATH="/usr/local/man:$MANPATH"
# You may need to manually set your language environment
export LANG=en_US.UTF-8

##Aliases to config them
preexec_functions+=(expand_command_line)
alias zedit="$EDITOR $HOME/.zshrc"
alias envedit="$EDITOR $ZSH_CUSTOM/environment"
alias fedit="$EDITOR $ZSH_CUSTOM/functions"
alias aedit="$EDITOR $ZSH_CUSTOM/aliases"
alias predit="$EDITOR $ZSH_CUSTOM/prompt"
alias keydit="$EDITOR $ZSH_CUSTOM/keys"

# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _match _approximate _prefix
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' file-sort access
zstyle ':completion:*' format 'complete with %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' max-errors 2
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' prompt 'did you mean...'
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' use-compctl true
zstyle ':completion:*' verbose true
zstyle ':compinstall' 'filename' '/home/zshmeta/.zshcompfig'
# Use modern completion system
zstyle ':completion:*' menu select
zstyle ':completion:*' use-comp-system 'true'
# Group matches and describe.
zstyle ':completion:*' list-colors 'ma=48;2;76;86;106'
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
# Colorize completions.
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
#zstyle ':completion:*' list-packed 'true'
#zstyle ':completion:*' list-rows-first 'true'

# Define widget for menu-select

zmodload -i zsh/complist
_have() {
  unset -f have
  (( $+commands[\$1] ))
}

_have() {
  if typeset -f have > /dev/null; then
    unset -f have
  fi
  (( $+commands[$1] ))
}

autoload -Uz compinit && compinit
autoload -Uz bashcompinit && bashcompinit
complete -o nospace -C /home/zshmeta/.local/bin/mc mc
complete -o nospace -C /home/zshmeta/.local/bin/weed weed


# Sources
sources=(environment functions aliases prompt)

for src in $sources; do source $ZSH_CUSTOM/$src &>/dev/null; done

plugs=( h zsh-history-substring-search zsh-ssh zsh-bash-completions-fallback zsh-syntax-highlighting zsh-autosuggestions )

for plug in $plugs; do source $ZSH_CUSTOM/plugins/$plug/$plug.plugin.zsh; done

comps=(incus weed tailscale minio)

for comp in $ZSH_CUSTOM/completions/*; do source $comp &>/dev/null; done

# Enable color in terminal.
autoload -U colors && colors

WIDTH=$(tput cols)
font=("Big Money-ne" "3-D" "3D-ASCII" "Larry 3D" "Big Money-sw" "Sub-Zero")
FONT=$(shuf -n 1 -e $font)
neofetch uptime distro memory disk | tr '\n' ' '  > /tmp/fetchascii
echoascii --rows --font="$FONT" "REZO2GITES"  "$HOST $USER" > /tmp/hostascii
bash -c "neofetch user local_ip; echo lanIP; tailscale ip -4 2>/dev/null" | tr '\n' ' ' > /tmp/ipascii

while IFS= read -r line; do
    printf "%*s\n" $WIDTH "$line" 
done < /tmp/hostascii | lolcat  --force
#figlet -c -w $WIDTH -f term $(cat /tmp/cowsay) | lolcat 
figlet -c -w $WIDTH -f term $(cat /tmp/fetchascii) | lolcat 
figlet -c -w $WIDTH -f term $(cat /tmp/ipascii) | lolcat 
figlet -c -w $WIDTH -f term $(facts) | lolcat 

rm  -rf /tmp/fetchascii /tmp/hostascii /tmp/ipascii
