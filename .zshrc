alias ls='ls --color=always'
alias restart="source ~/.zshrc"
alias gccc="gcc -Wall -Wextra -Werror"
alias rmd="rm -rf"
alias rc="vim ~/.zshrc && source ~/.zshrc"
alias work="cd ~/Desktop/"
alias cppch="cppcheck --enable=all --suppress=missingIncludeSystem *.c *.h"
alias cmt="git commit -m"
alias push="git push origin develop"
alias weak="leaks -atExit --"
TAG=1.0.1

if [ "$(uname)" == "Darwin" ] ; then
    alias vsc="open . -a 'Visual studio code'"
    setopt PROMPT_SUBST
    COLOR_DEF='%f'
    COLOR_DIR='%F{197}'
    COLOR_GIT='%F{39}'
    NEWLINE=$'\n'
    export PROMPT='${COLOR_DIR}%d ${COLOR_GIT}$(parse_git_branch)${COLOR_DEF}${NEWLINE}%% '
    parse_git_branch() {
        git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/[\1]/p'
    }
elif [ "$(uname)" == "Linux" ] ; then
    parse_git_branch() {
        git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
    }

    CONTENT_COLOR='\033[96m\]'
    COLOR_DEF='\033[00m\]'
    GIT_COLOR='\033[91m\]'
    DIRECTORY_COLOR='\033[93m\]'

    S21_USER="${CONTENT_COLOR}\u${COLOR_DEF}"
    S21_PLACE="${CONTENT_COLOR}\h${COLOR_DEF}"
    S21_DATE="${CONTENT_COLOR}\d, \t${COLOR_DEF}"
    S21_PROCESSES="${CONTENT_COLOR}\j${COLOR_DEF}"
    S21_BRANCH="${GIT_COLOR}\$(parse_git_branch)${COLOR_DEF}"
    S21_DIRECTORY="${DIRECTORY_COLOR}\w${COLOR_DEF}"

    INFO_BASED="${S21_BRANCH}${S21_DIRECTORY}\n$ "
    INFO_EXTENDED="User: ${S21_USER} Place: ${S21_PLACE} Day: ${S21_DATE} Processes: ${S21_PROCESSES}\n${S21_BRANCH}${S21_DIRECTORY}\n$ "

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
    cURL -l https://raw.githubusercontent.com/Sovsemo/S21_swim_script/main/README.md > ~/.school_resources_for_peer/README.md
elif [ "$(uname)" == "Linux" ] ; then
    curl -l https://raw.githubusercontent.com/Sovsemo/S21_swim_script/main/.zshrc > ~/.zshrc
    curl -l https://raw.githubusercontent.com/Sovsemo/S21_swim_script/main/README.md > ~/.school_resources_for_peer/README.md
fi
	restart
	GIT_COLOR='\033[91m'
	COLOR_DEF='\033[00m'
	echo -e "${GIT_COLOR}Terminal has been updated${COLOR_DEF}"
}

function init_setup() {
	if [ ! -d "~/.school_resources_for_peer" ]
	then
		mkdir ~/.school_resources_for_peer
	fi
	GIT_COLOR='\033[91m'
	COLOR_DEF='\033[00m'
	if [ "$(uname)" == "Darwin" ] ; then
        echo -e "${GIT_COLOR}Download README${COLOR_DEF}"
        cURL -l https://raw.githubusercontent.com/Sovsemo/S21_swim_script/main/README.md > ~/.school_resources_for_peer/README.md
        echo -e "${GIT_COLOR}Download CLANG${COLOR_DEF}"
        cURL -l https://raw.githubusercontent.com/Sovsemo/S21_swim_script/main/.clang-format > ~/.school_resources_for_peer/.clang-format
    elif [ "$(uname)" == "Linux" ] ; then
        echo -e "${GIT_COLOR}Download README${COLOR_DEF}"
        curl -l https://raw.githubusercontent.com/Sovsemo/S21_swim_script/main/README.md > ~/.school_resources_for_peer/README.md
        echo -e "${GIT_COLOR}Download CLANG${COLOR_DEF}"
        curl -l https://raw.githubusercontent.com/Sovsemo/S21_swim_script/main/.clang-format > ~/.school_resources_for_peer/.clang-format
    fi
    echo
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
