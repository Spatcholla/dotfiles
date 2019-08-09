# Spatcholla's Dotfiles

ZSH and Neovim installation and configuration.

## Installation

Please make sure you read the install script before you run it!
Currnetly only works on `apt` based distros

1. First clone the repo.
2. `cd dotfiles`
3. `chmod +x install.sh`
4. `./install.sh`
5. Follow the instructions on screen
6. Afer logging out and back in zplug will install all puggins
7. Launch Neovim; `nvim`
    * In Neovim `:PlugInstall`

## Usage

After everything is setup if you want to use inside a Python vitural environment you will need to install some packages.

Here is my suggestion:
* `python3 -m venv venv`
* `source venv/bin/activate`
* `pip install -U pip setuptools neovim black jedi flake8 mypy`

