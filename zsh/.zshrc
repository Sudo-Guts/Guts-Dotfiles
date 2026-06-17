export ZSH="$HOME/.oh-my-zsh"

    ENABLE_CORRECTION="true"

    plugins=(
        git
        zsh-interactive-cd
	    zsh-autosuggestions
	    zsh-syntax-highlighting
	    zsh-history-substring-search
    )

    source $ZSH/oh-my-zsh.sh

# /~~~>[ Function ]<----------------------------\

    function ghost_icon {
        if [[ "$PWD" == "$HOME" ]]; then
            echo "%B%F{magenta}󱙝 %f%b" 
        else
            echo "%B%F{magenta}󱙜 %f%b"
        fi
    }

    function arrow {
        if [[ "$PWD" == "$HOME" ]]; then
            echo "%F{magenta}➤  %f"
        else
            echo "%F{red}➤  %f"
        fi
    }

    function LH {
        if [[ "$PWD" == "$HOME" ]]; then
            echo "%B%F{blue}╭──%f%b"
        else
            echo "%B%F{red}╭──%f%b"
        fi
    }

    function LL {
        if [[ "$PWD" == "$HOME" ]]; then
            echo "%B%F{blue}╰──%f%b"
        else
            echo "%B%F{red}╰──%f%b"
        fi
    }

    function RH {
        if [[ "$PWD" == "$HOME" ]]; then     
            echo "%B%F{blue}──╮%f%b"    
        else    
            echo "%B%F{red}──╮%f%b"    
        fi    
    }

    function RL {
        if [[ "$PWD" == "$HOME" ]]; then
            echo "%B%F{blue}──╯%f%b"
        else
            echo "%B%F{red}──╯%f%b"
        fi
    }

    function precmd {
        PR_FILLBAR=""
        PR_PWDLEN=""
        local promptsize=${#${(%):-──[    ][  ] ~~ [ %n ]──}} 
        local pwdsize=${#${(%):-%/}}
        local TERMWIDTH
        (( TERMWIDTH = ${COLUMNS} - 1 ))

        if (( promptsize + pwdsize > TERMWIDTH )); then
            (( PR_PWDLEN = TERMWIDTH - promptsize ))
        else
            PR_FILLBAR="\${(l.(($TERMWIDTH - ($promptsize + $pwdsize)))..${PR_HBAR}.)}"
        fi
    }

    function BAR {
        if [[ "$PWD" == "$HOME" ]]; then
            echo "%B%F{blue} ${(e)PR_FILLBAR} %f%b"
        else 
            echo "%B%F{red} ${(e)PR_FILLBAR} %f%b"
        fi
    }

# /~~~>[ Git prompt ]<--------------------------\

    ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[green]%}"
    ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
    ZSH_THEME_GIT_PROMPT_DIRTY=""
    ZSH_THEME_GIT_PROMPT_CLEAN=""

    ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%} %{%G✚%}"
    ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[blue]%} %{%G✹%}"
    ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%} %{%G✖%}"
    ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[magenta]%} %{%G➜%}"
    ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[yellow]%} %{%G═%}"
    ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[cyan]%} %{%G✭%}"

    function GITIF {
        if [[ "$PWD" == "$HOME" ]]; then
            echo "%B%F{cyan} %f%b"
        fi
    }

# /~~~>[ Prompt ]<------------------------------\

    setopt prompt_subst
    
    PR_HBAR="-"

PROMPT='$(LH)\
%F{magenta}[%f $(ghost_icon) %F{magenta}]%f\
%F{magenta}[%f %F{cyan}%/%f %F{magenta}]%f\
$(BAR)\
%F{magenta}[%f %F{cyan}%n%f %F{magenta}]%f$(RH)\

$(LL)$(arrow)'

RPROMPT='%F{magenta}[%f $(GITIF)$(git_prompt_info)$(git_prompt_status) %F{magenta}]%f$(RL)'

# /~~~>[ Alias ]<------------------------------\

alias zsh='nvim ~/.zshrc'
alias kitty='nvim ~/.config/kitty/kitty.conf'
alias neovim='cd ~/.config/nvim'
alias dotfiles='cd ~/.dotfiles'

export PATH=$HOME/.local/xPacks/@xpack-dev-tools/riscv-none-elf-gcc/latest/bin:$PATH
export RISCV=$HOME/riscv-lab/riscv
