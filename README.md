# Spatcholla's Dotfiles

ZSH and Neovim installation and configuration.

## Installation

First clone the repo.

1. `cd dotfiles`
2. `chmod +x install.sh`
3. `./install.sh`
4. Follow the instructions on screen
5. Afer logging out and back in zplug will install all puggins
6. Launch Neovim; `nvim`
    * In Neovim `:PlugInstall`

## Usage

After everything is setup if you want to use inside a Python vitural environment you will need to install some packages.

Here is my suggestion:
* `python3 -m venv venv`
* `source venv/bin/activate`
* `pip install -U pip setuptools neovim black jedi flake8 mypy`

