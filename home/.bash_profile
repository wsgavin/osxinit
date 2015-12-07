#!/usr/local/bin/bash
#
# Inspired by https://github.com/mathiasbynens/dotfiles
#

#for DOTFILE in `find $HOME/.dotfiles -type f`
for DOTFILE in ~/.dotfiles/.{path,bash_prompt,exports,aliases,functions,extra};
do
  # shellcheck source=/dev/null
  [ -f "${DOTFILE}" ] && source "${DOTFILE}"
done
unset DOTFILE

# Setting up bash with a few settings.
#
# http://www.gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html
#

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Append to the Bash history file, rather than overwriting it
shopt -s histappend

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
	shopt -s "$option" 2> /dev/null
done

# Tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && \
  complete -o "default" \
  -o "nospace" \
  -W "$(grep "^Host" ~/.ssh/config |\
    grep -v "[?*]" | \
    cut -d " " -f2 | \
    tr ' ' '\n')" \
  scp sftp ssh

# If possible, add tab completion for many more commands
if [ -f "$(brew --prefix)/etc/bash_completion" ]; then
  # shellcheck source=/dev/null
  source "$(brew --prefix)/etc/bash_completion"
fi

# Initialize ruby...
# TODO: Consider using RBENV_ROOT vs. ~/.rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# Initialize nvm...
export NVM_DIR=~/.nvm
# shellcheck source=/dev/null
source "$(brew --prefix nvm)/nvm.sh"

# If possible, add tab completion for nvm
if [ -f "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" ]; then
  # shellcheck source=/dev/null
  source "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm"
fi

# Initialize gvm
# shellcheck source=/dev/null
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# Initialize jenv
# TODO: Consider using JENV_ROOT vs. ~/.jenv
if which jenv > /dev/null; then eval "$(jenv init -)"; fi

# Initialize Virtualenvwrapper
if [ -f "$(brew --prefix)/bin/virtualenvwrapper.sh" ]; then
  # shellcheck source=/dev/null
  source "$(brew --prefix)/bin/virtualenvwrapper.sh"
fi



