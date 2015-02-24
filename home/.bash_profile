# Inspired by https://github.com/mathiasbynens/dotfiles
#
# Modularized some dotfiles to clean up the .bash_profile file.
# * ~/.extra can be used for other settings you don’t want to commit.
#for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
#	[ -r "$file" ] && [ -f "$file" ] && source "$file"
#done
#unset file

for DOTFILE in `find $HOME/.dotfiles -type f`
do
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
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  source $(brew --prefix)/etc/bash_completion
fi

# Initialize ruby...
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# Initialize nvm...
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

# If possible, add tab completion for nvm
if [ -f $(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm ]; then
  source $(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm
fi
