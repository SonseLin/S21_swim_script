alias ls='ls --color=always'
alias restart="source ~/.bashrc"
alias gccc="gcc -Wall -Wextra -Werror"
alias rmd="rm -rf"
alias work="cd ~/Desktop/"
alias cppch="cppcheck --enable=all --suppress=missingIncludeSystem *.c *.h"
alias cmt="git commit -m"
alias push="git push origin develop"
alias weak="leaks -atExit --"
TAG=1.1.0

# Config files
COLOR_PATH="~/.school_resources_for_peer/.script_config/.color_config"

# Colors
GIT_COLOR_PRE="$(grep git ~/.school_resources_for_peer/.script_config/.color_config  | awk '{print $2}')"
GIT_COLOR="$(grep $GIT_COLOR_PRE ~/.school_resources_for_peer/.script_config/.color_config  | head -n 1 | awk '{print $2}')"
CONTENT_COLOR_PRE="$(grep cnt ~/.school_resources_for_peer/.script_config/.color_config  | awk '{print $2}')"
CONTENT_COLOR="$(grep $CONTENT_COLOR_PRE ~/.school_resources_for_peer/.script_config/.color_config  | head -n 1 | awk '{print $2}')"
PATH_COLOR_PRE="$(grep path ~/.school_resources_for_peer/.script_config/.color_config  | awk '{print $2}')"
PATH_COLOR="$(grep $PATH_COLOR_PRE ~/.school_resources_for_peer/.script_config/.color_config | head -n 1 | awk '{print $2}')"
DEFAULT_COLOR="$(grep def ~/.school_resources_for_peer/.script_config/.color_config | head -n 1 | awk '{print $2}')"

if [ "$(uname)" == "Darwin" ] ; then
    alias vsc="open . -a 'Visual studio code'"
    alias rc="vim ~/.zshrc && source ~/.zshrc"
    setopt PROMPT_SUBST
    DEFAULT_COLOR='%f'
    COLOR_DIR='%F{197}'
    COLOR_GIT='%F{39}'
    NEWLINE=$'\n'
    export PROMPT='${COLOR_DIR}%d ${COLOR_GIT}$(parse_git_branch)${DEFAULT_COLOR}${NEWLINE}%% '
    parse_git_branch() {
        git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/[\1]/p'
    }
elif [ "$(uname)" == "Linux" ] ; then
    parse_git_branch() {
        git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
    }
    alias rc="vim ~/.bashrc && source ~/.bashrc"

    DEFAULT_COLOR='\033[00m'

    S21_USER="${CONTENT_COLOR}\u${DEFAULT_COLOR}"
    S21_PLACE="${CONTENT_COLOR}\h${DEFAULT_COLOR}"
    S21_DATE="${CONTENT_COLOR}\d, \t${DEFAULT_COLOR}"
    S21_PROCESSES="${CONTENT_COLOR}\j${DEFAULT_COLOR}"
    S21_BRANCH="${GIT_COLOR}\$(parse_git_branch)${DEFAULT_COLOR}"
    S21_DIRECTORY="${PATH_COLOR}\w${DEFAULT_COLOR}"

    INFO_BASED="${S21_BRANCH}${S21_DIRECTORY}\n$ "
    INFO_EXTENDED="User: ${S21_USER} Place: ${S21_PLACE} Day: ${S21_DATE} High load: ${S21_PROCESSES}\n${S21_BRANCH}${S21_DIRECTORY}\n$ "

    export PS1=${INFO_EXTENDED}

    function info_bas() {
        export PS1=${INFO_BASED}
    }

    function info_ext() {
        export PS1=${INFO_EXTENDED}
    }
fi

function comp() {
	gcc -Wall -Wextra -Werror "$1.c" -o "$1.o"
	./"$1.o"
}

function NR() {
if [ "$(uname)" == "Darwin" ] ; then
    cURL -l https://raw.githubusercontent.com/Sovsemo/S21_swim_script/main/.zshrc > ~/.zshrc
    cURL -l https://raw.githubusercontent.com/Sovsemo/S21_swim_script/main/README_TERM.md > ~/.school_resources_for_peer/README.md
elif [ "$(uname)" == "Linux" ] ; then
    curl -l https://raw.githubusercontent.com/Sovsemo/S21_swim_script/main/.zshrc > ~/.bashrc
    curl -l https://raw.githubusercontent.com/Sovsemo/S21_swim_script/main/README_TERM.md > ~/.school_resources_for_peer/README.md
fi
if ! -f ~/.school_resources_for_peer/.script/.color_config; then
    curl -l https://raw.githubusercontent.com/Sovsemo/S21_swim_script/main/cfg/COLOR_CONFIG > ~/.school_resources_for_peer/.script_config/.color_config
fi
	restart
	echo -e "${GIT_COLOR}Terminal has been updated${DEFAULT_COLOR}"
}

function init_setup() {
	if [ ! -d "~/.school_resources_for_peer" ]
	then
		mkdir ~/.school_resources_for_peer
	fi
	if [ "$(uname)" == "Darwin" ] ; then
        echo -e "${GIT_COLOR}Download README${DEFAULT_COLOR}"
        cURL -l https://raw.githubusercontent.com/Sovsemo/S21_swim_script/main/README_TERM.md > ~/.school_resources_for_peer/README.md
        echo -e "${GIT_COLOR}Download CLANG${DEFAULT_COLOR}"
        cURL -l https://raw.githubusercontent.com/Sovsemo/S21_swim_script/main/.clang-format > ~/.school_resources_for_peer/.clang-format
    elif [ "$(uname)" == "Linux" ] ; then
        echo -e "${GIT_COLOR}Download README${DEFAULT_COLOR}"
        curl -l https://raw.githubusercontent.com/Sovsemo/S21_swim_script/main/README_TERM.md > ~/.school_resources_for_peer/README.md
        echo -e "${GIT_COLOR}Download CLANG${DEFAULT_COLOR}"
        curl -l https://raw.githubusercontent.com/Sovsemo/S21_swim_script/main/.clang-format > ~/.school_resources_for_peer/.clang-format
    fi
    echo -e "${GIT_COLOR}mans21 - command to print script documentation${DEFAULT_COLOR}"
}

function clangch() {
	cp ~/.school_resources_for_peer/.clang-format .clang-format
	clang-format -i *.c *.h
	clang-format -n *.c *.h
	rm .clang-format
}

function review() {
	if [ ! -d "~/Desktop/peer_review_dir" ]; then
		mkdir ~/Desktop/peer_review_dir
	fi
	cd ~/Desktop/peer_review_dir
	if (( $2 == 1 )); then
		rm -rf *
	fi
	git clone -b develop $1
}

function mans21() {
	cat ~/.school_resources_for_peer/README.md
}

function set_color() {
    # accepts via $1 type of change git / content (cnt) / path
    # accepts via $2 new color
    # colors: blue, red, green, yellow, purple, cyan
    if [ "$1" != "git" -a "$1" != "cnt" -a "$1" != "path" ]; then
        echo "Неправильные аргументы. Введите первым значением git / cnt / path"
    else
        if [ "$2" != "blue" -a "$2" != "red" -a "$2" != "green" -a "$2" != "yellow" -a "$2" != "purple" -a "$2" != "cyan" ]; then
            echo "Такого цвета нет в системе. Доступные на выбор blue, red, green, yellow, purple, cyan"
        else
            if [ "$1" = "git" ]; then
                sed -i -e "s/$1 $GIT_COLOR_PRE/$1 $2/g" ~/.school_resources_for_peer/.script_config/.color_config
            elif [ "$1" = "cnt" ]; then
                sed -i "s/$1 $CONTENT_COLOR_PRE/$1 $2/g" ~/.school_resources_for_peer/.script_config/.color_config
            else
                sed -i "s/$1 $PATH_COLOR_PRE/$1 $2/g" ~/.school_resources_for_peer/.script_config/.color_config
            fi
            restart
            echo restarted
        fi
    fi
}
