 #!/usr/bin/env bash

# Via https://github.com/swelljoe/spinner/blob/master/spinner.sh
# shellcheck disable=SC2034 disable=SC2039
# Config variables, set these after sourcing to change behavior.
SPINNER_COLORNUM=2 # What color? Irrelevent if COLORCYCLE=1.
SPINNER_COLORCYCLE=1 # Does the color cycle?
SPINNER_DONEFILE="stopspinning" # Path/name of file to exit on.
SPINNER_SYMBOLS="UNI_DOTS2" # Name of the variable containing the symbols.
SPINNER_CLEAR=1 # Blank the line when done.

# Handle signals
cleanup () {
    tput rc
    tput cnorm
    return 1
}
# This tries to catch any exit, to reset cursor
trap cleanup INT QUIT TERM

spinner () {
  # Safest option are one of these. Doesn't need Unicode, at all.
  local ASCII_PROPELLER="/ - \\ |"
  local ASCII_PLUS="x +"
  local ASCII_BLINK="o -"
  local ASCII_V="v < ^ >"
  local ASCII_INFLATE=". o O o"

  # Needs Unicode support in shell and terminal.
  # These are ordered most to least likely to be available, in my limited experience.
  local UNI_DOTS="⠋ ⠙ ⠹ ⠸ ⠼ ⠴ ⠦ ⠧ ⠇ ⠏"
  local UNI_DOTS2="⣾ ⣽ ⣻ ⢿ ⡿ ⣟ ⣯ ⣷"
  local UNI_DOTS3="⣷ ⣯ ⣟ ⡿ ⢿ ⣻ ⣽ ⣾"
  local UNI_DOTS4="⠋ ⠙ ⠚ ⠞ ⠖ ⠦ ⠴ ⠲ ⠳ ⠓"
  local UNI_DOTS5="⠄ ⠆ ⠇ ⠋ ⠙ ⠸ ⠰ ⠠ ⠰ ⠸ ⠙ ⠋ ⠇ ⠆"
  local UNI_DOTS6="⠋ ⠙ ⠚ ⠒ ⠂ ⠂ ⠒ ⠲ ⠴ ⠦ ⠖ ⠒ ⠐ ⠐ ⠒ ⠓ ⠋"
  local UNI_DOTS7="⠁ ⠉ ⠙ ⠚ ⠒ ⠂ ⠂ ⠒ ⠲ ⠴ ⠤ ⠄ ⠄ ⠤ ⠴ ⠲ ⠒ ⠂ ⠂ ⠒ ⠚ ⠙ ⠉ ⠁"
  local UNI_DOTS8="⠈ ⠉ ⠋ ⠓ ⠒ ⠐ ⠐ ⠒ ⠖ ⠦ ⠤ ⠠ ⠠ ⠤ ⠦ ⠖ ⠒ ⠐ ⠐ ⠒ ⠓ ⠋ ⠉ ⠈"
  local UNI_DOTS9="⠁ ⠁ ⠉ ⠙ ⠚ ⠒ ⠂ ⠂ ⠒ ⠲ ⠴ ⠤ ⠄ ⠄ ⠤ ⠠ ⠠ ⠤ ⠦ ⠖ ⠒ ⠐ ⠐ ⠒ ⠓ ⠋ ⠉ ⠈ ⠈"
  local UNI_DOTS10="⢹ ⢺ ⢼ ⣸ ⣇ ⡧ ⡗ ⡏"
  local UNI_DOTS11="⢄ ⢂ ⢁ ⡁ ⡈ ⡐ ⡠"
  local UNI_DOTS12="⠁ ⠂ ⠄ ⡀ ⢀ ⠠ ⠐ ⠈"
  local UNI_BOUNCE="⠁ ⠂ ⠄ ⠂"
  local UNI_PIPES="┤ ┘ ┴ └ ├ ┌ ┬ ┐"
  local UNI_HIPPIE="☮ ✌ ☺ ♥"
  local UNI_HANDS="☜ ☝ ☞ ☟"
  local UNI_ARROW_ROT="➫ ➭ ➬ ➭"
  local UNI_CARDS="♣ ♤ ♥ ♦"
  local UNI_TRIANGLE="◢ ◣ ◤ ◥"
  local UNI_SQUARE="◰ ◳ ◲ ◱"
  local UNI_BOX_BOUNCE="▖ ▘ ▝ ▗"
  local UNI_PIE="◴ ◷ ◶ ◵"
  local UNI_CIRCLE="◐ ◓ ◑ ◒"
  local UNI_QTR_CIRCLE="◜ ◝ ◞ ◟"

  # Bigger spinners and progress type bars; takes more space.
  local WIDE_ASCII_PROG="[>----] [=>---] [==>--] [===>-] [====>] [----<] [---<=] [--<==] [-<===] [<====]"
  local WIDE_ASCII_PROPELLER="[|####] [#/###] [##-##] [###\\#] [####|] [###\\#] [##-##] [#/###]"
  local WIDE_ASCII_SNEK="[>----] [~>---] [~~>--] [~~~>-] [~~~~>] [----<] [---<~] [--<~~] [-<~~~] [<~~~~]"
  local WIDE_UNI_GREYSCALE="░░░░░░░ ▒░░░░░░ ▒▒░░░░░ ▒▒▒░░░░ ▒▒▒▒░░░ ▒▒▒▒▒░░ ▒▒▒▒▒▒░ ▒▒▒▒▒▒▒ ▒▒▒▒▒▒░ ▒▒▒▒▒░░ ▒▒▒▒░░░ ▒▒▒░░░░ ▒▒░░░░░ ▒░░░░░░ ░░░░░░░"
  local WIDE_UNI_GREYSCALE2="░░░░░░░ ▒░░░░░░ ▒▒░░░░░ ▒▒▒░░░░ ▒▒▒▒░░░ ▒▒▒▒▒░░ ▒▒▒▒▒▒░ ▒▒▒▒▒▒▒ ░▒▒▒▒▒▒ ░░▒▒▒▒▒ ░░░▒▒▒▒ ░░░░▒▒▒ ░░░░░▒▒ ░░░░░░▒"

  local SPINNER_NORMAL
  SPINNER_NORMAL=$(tput sgr0)

  eval SYMBOLS=\$${SPINNER_SYMBOLS}

  # Get the parent PID
  SPINNER_PPID=$(ps -p "$$" -o ppid=)
  while :; do
    tput civis
    for c in ${SYMBOLS}; do
      if [ $SPINNER_COLORCYCLE -eq 1 ]; then
        if [ $SPINNER_COLORNUM -eq 7 ]; then
          SPINNER_COLORNUM=1
        else
          SPINNER_COLORNUM=$((SPINNER_COLORNUM+1))
        fi
      fi
      local COLOR
      COLOR=$(tput setaf ${SPINNER_COLORNUM})
      tput sc
      env printf "${COLOR}${c}${SPINNER_NORMAL}"
      tput rc
      if [ -f "${SPINNER_DONEFILE}" ]; then
        if [ ${SPINNER_CLEAR} -eq 1 ]; then
          tput el
        fi
        rm ${SPINNER_DONEFILE}
        break 2
      fi
      # This is questionable. sleep with fractional seconds is not
      # always available, but seems to not break things, when not.
      env sleep .2
      # Check to be sure parent is still going; handles sighup/kill
      if [ ! -z "$SPINNER_PPID" ]; then
        # This is ridiculous. ps prepends a space in the ppid call, which breaks
        # this ps with a "garbage option" error.
        # XXX Potential gotcha if ps produces weird output.
        # shellcheck disable=SC2086
        SPINNER_PARENTUP=$(ps  $SPINNER_PPID)
        if [ -z "$SPINNER_PARENTUP" ]; then
          break 2
        fi
      fi
    done
  done
  tput cnorm
  return 0
}


SPINNER_SYMBOLS="UNI_DOTS"
SPINNER_COLORCYCLE=0
SPINNER_COLORNUM=2

CODEPATH=$HOME/sidebar
START_DIR=`pwd`
WORKING_DIR=`pwd`
START_VENV=${VIRTUAL_ENV##*/}

welcome() {
    echo "
Welcome to the Sidebar dev setup script.
This script will set up your system for hacking on the Sidebar apps, hopefully without mucking anything up in the meantime.

The script is designed to be idempotent and kind to your computer.

Here's what it does:
1. Installs homebrew, if you don't have it.
2. Installs nvm, npm, python3, pip, and docker.
3. Sets up a virtual environment (using virtualenv and nodeenv) for our apps.
4. Asks you where you want to store the codebases, then clones them down.
5. Installs dewey, our helpful CLI tool to switch environments, get hacking, run tests, and get things done.

If you run into any snags, please report them in Slack, and/or fix them!"

    confirm_start
}

confirm_start() {
    read -p "Would you like to begin the setup process? (y/n) [N]" choice
    case "$choice" in 
      y|Y ) start_setup;;
      n|N ) exit;;
      * ) exit;;
    esac
}

exit() {
    echo "

Quitting setup process.
"
}
is_installed() {
    echo "
:: Checking for: $1 
" >> $START_DIR/install.log
    command -v "$1" >> $START_DIR/install.log 2>&1;
}
file_exists() {
    [ -e "$1" ];
}
echo_success() {
    echo -e "\033[92m✔ \033[0m$1"
}
update_line() {
    echo -en "\r$i\033[0K"
}
setup_codebase() {
    # Clone Repo
    cd $CODEPATH
    CODEBASE_NAME=$1
    if file_exists "$1/.git"; then
        echo_success "$1 cloned."
    else
        start_install "Cloning $1 ..."
        git clone git@github.com:sidebarchats/$1.git >> install.log 2>&1
        FINISH_OUTPUT="$1 has been cloned."
        finish_install_submethod
    fi


    # Set up virtualenvs
    if file_exists "$HOME/.virtualenvs/sidebar-$1/bin/postactivate"; then
        workon "sidebar-$1"
        log_output "pip uninstall -y dewey"
        deactivate
        FINISH_OUTPUT="sidebar-$1 virtual environment already set up."
        
    else
        start_install "Setting up virtual environment for $1 ..."
        # START_DIR=`pwd`
        log_output "mkvirtualenv sidebar-$1"
        touch $START_DIR/stopspinning
        echo "
# Setup for $1
cd $CODEPATH/$1
" >> ~/.virtualenvs/sidebar-$1/bin/postactivate
        # workon "sidebar-$1"
        cd $CODEPATH/$1
        log_output "pip install nodeenv"
        touch $START_DIR/stopspinning
        log_output "nodeenv -p --node=8.11.1 --prebuilt"
        # deactivate
        # cd $START_DIR
        FINISH_OUTPUT="sidebar-$1 virtual environment created."
        finish_install_submethod
    fi
}
start_install() {
    echo -en "$1"
    WORKING_DIR=`pwd`
    cd $START_DIR
    spinner &
    cd $WORKING_DIR
}
finish_install() {
    touch $START_DIR/stopspinning
    update_line ""
    echo_success $1
}
finish_install_submethod() {
    touch $START_DIR/stopspinning
    update_line ""
    echo -e "\033[92m✔ \033[0m$FINISH_OUTPUT"
}
log_output() {
    echo "
=== Running $1 ===
" >> $START_DIR/install.log
    $1 >> $START_DIR/install.log 2>&1
}

add_to_bash_profile() {
    if ! cat ~/.bash_profile | grep -Fxq "### Added by Sidebar setup script"
    then
        echo "### Added by Sidebar setup script" >> ~/.bash_profile
    fi

    if cat ~/.bash_profile | grep -Fxq "$2"
    then
        echo_success "$1 present in ~/.bash_profile."
    else
        update_line "Adding $1 to bash_profile..."    
        echo $2 >> ~/.bash_profile
        update_line ""
        echo_success "$1 added to ~/.bash_profile."
        eval $2
    fi
}

start_setup() {

    echo "
====================
=== System Setup ===
====================
"
    echo "Great!  One more question.  "
    read -p "Where would you like to keep the sidebar codebases? (Default is $HOME/sidebar) " CODEPATH
    CODEPATH=${CODEPATH:-"$HOME/sidebar"}
    
    # Drop out of a virtual env if we're in one.
    if [ ! -z $START_VENV ] ; then 
        deactivate
    fi

    # Set up install log
    rm $START_DIR/install.log
    touch $START_DIR/install.log

    # Check directory.
    mkdir -p $CODEPATH
    echo_success "Sidebar codebases path verified."



    # Install xcode-select
    xcode-select --install &> /dev/null

    # Install homebrew
    if is_installed brew; then
        echo_success "Homebrew installed. "
    else
        start_install "Homebrew missing.  Installing..."
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        finish_install "Homebrew installed. "
    fi

    # Install nvm
    if file_exists "/usr/local/opt/nvm/nvm.sh"; then
        echo_success "NVM installed. "
    else
        start_install "NVM missing.  Installing..."
        brew install nvm -y
        mkdir -p ~/.nvm 
        finish_install "NVM installed. "    

        if grep -Fxq 'export NVM_DIR="$HOME/.nvm"' ~/.bash_profile
        then
            echo_success "NVM present in ~/.bash_profile."
        else
            update_line "Adding nvm to bash_profile..."    
            echo 'export export NVM_DIR="$HOME/.nvm"' >> ~/.bash_profile
            echo '. "/usr/local/opt/nvm/nvm.sh"' >> ~/.bash_profile
            update_line ""
            echo_success "NVM added to ~/.bash_profile."
        fi
    fi
    if is_installed nvm; then
        echo_success "NVM present in environment."
    else
        update_line "Pulling nvm into script environment..."
        export NVM_DIR="$HOME/.nvm"
        . /usr/local/opt/nvm/nvm.sh
        update_line 
        echo_success "NVM present in environment."

    fi

    # Install nodejs 8.11.1 via NVM
    if nvm ls | grep "8.11.1" &> /dev/null; then
        echo_success "NodeJS 8.11.1 installed."
    else
        start_install "Missing NodeJS 8.11.1.   Installing..."
        nvm install 8.11.1
        finish_install "NodeJS 8.11.1 installed."
    fi

    update_line "Switching to NodeJS 8.11.1"
    nvm use 8.11.1 1> /dev/null
    update_line ""
    echo_success "Using NodeJS 8.11.1"

    if brew ls watchman &> /dev/null; then
        echo_success "Watchman installed."
    else
        start_install "Missing watchman.   Installing..."
        log_output "brew install watchman"
        finish_install "Watchman installed."
    fi

    if is_installed ngrok &> /dev/null; then
        echo_success "ngrok installed."
    else
        start_install "Missing ngrok.   Installing..."
        log_output "brew cask install ngrok"
        finish_install "ngrok installed."
    fi


    if brew ls libxml2 &> /dev/null; then
        echo_success "Libxml2 installed."
    else
        start_install "Missing Libxml2.   Installing..."
        brew install libxml2
        brew link libxml2 --force
        finish_install "Libxml2 installed."
    fi
    

    if brew ls libxslt &> /dev/null; then
        echo_success "Libxslt installed."
    else
        start_install "Missing Libxslt.   Installing..."
        brew install libxslt
        brew link libxslt --force
        finish_install "Libxslt installed."
    fi

    if brew list python | grep "/usr/local/Cellar/python/" &> /dev/null; then
        echo_success "homebrew python installed"
    else
        start_install "Installing homebrew python..."    
        log_output "brew install python"
        finish_install "homebrew python installed."
    fi
    if is_installed pyenv; then
        echo_success "Pyenv installed"
    else
        update_line "Installing pyenv..."    
        brew install pyenv
        echo_success "Pyenv installed."
    fi
    if is_installed pyenv-virtualenv; then
        echo_success "Pyenv-Virtualenv installed"
    else
        start_install "Installing pyenv-virtualenv..."    
        log_output "brew install pyenv-virtualenv"
        finish_install "pyenv-Virtualenv installed."
    fi

    if is_installed pyenv-virtualenvwrapper; then
        echo_success "Pyenv-Virtualenvwrapper installed"
    else
        start_install "Installing pyenv-virtualenvwrapper..."    
        log_output "brew install pyenv-virtualenvwrapper"
        finish_install "pyenv-Virtualenvwrapper installed."
    fi

    # Install python 2.7.7 and 3.6 via pyenv
    if pyenv versions | grep "2.7.7" &> /dev/null; then
        echo_success "Python 2.7.7 installed."
    else
        start_install "Missing Python 2.7.7.   Installing..."
        log_output "pyenv install 2.7.7"
        finish_install "Python 2.7.7 installed."
    fi

    # if pyenv versions | grep "3.6.5" &> /dev/null; then
    #     echo_success "Python 3.6.5 installed."
    # else
    #     start_install "Missing Python 3.6.5.   Installing..."
    #     log_output "pyenv install 3.6.5"
    #     finish_install "Python 3.6.5 installed."
    # fi
    

    # # Switch to python 3.6
    # pyenv local 3.6.5

    # if is_installed pip; then
    #     echo_success "Pip for Python 3 installed."
    # else
    #     start_install "Installing pip..."    
    #     easy_install distribute pip
    #     pip install --upgrade pip distribute -y
    #     finish_install "Pip for Python 3 installed."
    # fi


    pyenv global 2.7.7
    pyenv local 2.7.7
    export LDFLAGS=/usr/local/opt/zlib/lib && export CPPFLAGS=/usr/local/opt/zlib/include
    if is_installed pip; then
        echo_success "Pip for Python 2 installed."
    else
        start_install "Installing pip..."    
        easy_install distribute pip
        pip install --upgrade pip distribute -y
        finish_install "Pip for Python 2 installed."
    fi

    if is_installed virtualenv; then
        echo_success "Virtualenv installed"
    else
        start_install "Installing virtualenv..."    
        log_output "pip install virtualenv"
        finish_install "Virtualenv installed."
    fi

    if is_installed virtualenvwrapper; then
        echo_success "Virtualenvwrapper installed."
    else
        start_install "Installing virtualenvwrapper..."    
        log_output "pip install virtualenvwrapper"
        finish_install "Virtualenvwrapper installed."
    fi

    add_to_bash_profile "pyenv local 2.7.7"
    add_to_bash_profile "Pyenv init"  'eval "$(pyenv init -)"'
    add_to_bash_profile "Pyenv virtualenv init"  'if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi'
    add_to_bash_profile "Pyenv virtualenvwrapper init"  'pyenv virtualenvwrapper'
    add_to_bash_profile "export LDFLAGS=/usr/local/opt/zlib/lib && export CPPFLAGS=/usr/local/opt/zlib/include"
    # Just make sure we're set up.
    eval "$(pyenv init -)"
    if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi
    pyenv virtualenvwrapper

    # add_to_bash_profile "Virtualenvwapper path" "export VIRTUALENVWRAPPER_PYTHON=~/.pyenv/shims/python"
    # add_to_bash_profile "Virtualenvwapper source" "source ~/.pyenv/shims/virtualenvwrapper.sh"
    # add_to_bash_profile "Virtualenvwapper home" "export WORKON_HOME=$HOME/.virtualenvs"

    if is_installed nodeenv; then
        echo_success "Nodeenv installed"
    else
        start_install "Installing nodeenv..."    
        log_output "pip install nodeenv"
        finish_install "Nodeenv installed."
    fi

    if is_installed docker; then
        echo_success "Docker installed"
    else
        start_install "Installing docker..."    
        log_output "brew install docker"
        finish_install "Docker installed."
    fi

    if is_installed docker-compose; then
        echo_success "Docker Compose installed"
    else
        start_install "Installing docker-compose..."    
        log_output "brew install docker-compose"
        finish_install "Docker Compose installed."
    fi

    if is_installed ttab; then
        echo_success "Ttab installed"
    else
        start_install "Installing ttab..."    
        log_output "npm install -g ttab"
        finish_install "Ttab installed."
    fi

    if is_installed firebase; then
        echo_success "firebase-tools installed."
    else
        start_install "Installing firebase-tools..."    
        log_output "npm install -g firebase-tools"
        finish_install "firebase-tools installed."
    fi

    echo "Logging in with firebase tools..."
    firebase login

    start_install "Installing dewey for python 2..."    
    log_output "pip install git+https://git@github.com/sidebarchats/dewey.git#egg=dewey --upgrade"
    finish_install "Dewey installed for python 2."

    # pyenv local 3.6.5
    # start_install "Installing dewey for python 3..."    
    # log_output "pip3 install git+https://git@github.com/sidebarchats/dewey.git#egg=dewey --upgrade"
    # finish_install "Dewey installed for python 3."
    # pyenv local 2.7.7

    # if is_installed polytester; then
    #     echo_success "Polytester installed"
    # else
    #     start_install "Installing Polytester..."    
    #     log_output "pip install polytester"
    #     finish_install "Polytester installed."
    # fi

    if grep -Fxq 'source ~/.pyenv/versions/2.7.7/lib/python2.7/site-packages/dewey/bin/bootstrap_dewey.sh' ~/.bash_profile
    then
        echo_success "Dewey bootstrap present in ~/.bash_profile."
    else
        update_line "Adding dewey to bash_profile..."    
        echo 'source ~/.pyenv/versions/2.7.7/lib/python2.7/site-packages/dewey/bin/bootstrap_dewey.sh' >> ~/.bash_profile
        update_line ""
        echo_success "Dewey bootstrap added to ~/.bash_profile."
        source ~/.pyenv/versions/2.7.7/lib/python2.7/site-packages/dewey/bin/bootstrap_dewey.sh
    fi



        echo "
======================
=== Codebase Setup ===
======================
"

    echo "Setting up codebases."
    cd $CODEPATH
    setup_codebase app
    setup_codebase backend
    setup_codebase bootstrap
    setup_codebase demo
    setup_codebase firebase-backend
    setup_codebase dewey
    setup_codebase hook
    setup_codebase meta
    setup_codebase portal
    setup_codebase will
    setup_codebase widget


    # If we were in a virtualenv, go back into it.
    if [ ! -z $START_VENV ] ; then 
        workon "sidebar-$START_VENV"
    fi

}

welcome
