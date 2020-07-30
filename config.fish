# required additions to path
set -x -U GOPATH $HOME/gocode
set PATH /Applications/Postgres.app/Contents/MacOS $PATH
set PATH /usr/local/mysql/bin $PATH
set LDFLAGS "$LDFLAGS -arch x86_64 -flat_namespace -undefined suppress -L/usr/local/opt/openssl/lib/"
set C_INCLUDE_PATH $C_INCLUDE_PATH /usr/local/opt/openssl/include 
set PATH $HOME/.rbenv/bin $PATH
set PATH $HOME/.rbenv/shims $PATH
set PATH $HOME/.npm-global/bin $PATH
set PATH $GOPATH/bin $PATH
set PATH $HOME/Library/Python/2.7/bin $PATH
set PATH /usr/local/opt/qt@5.5/bin $PATH

rbenv rehash >/dev/null ^&1

# git helpers
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gco="git checkout"
alias gphm="git push heroku master"
alias gpom="git push origin master"

#other helpers
alias pingle="ping google.com"
alias ls="lsd"

# promp setup
set fish_git_dirty_color red
set fish_git_not_dirty_color green

function parse_git_branch
  set -l branch (git branch 2> /dev/null | grep -e '\* ' | sed 's/^..\(.*\)/\1/')
  set -l git_status (git status -s)

  if test -n "$git_status"
    echo ':'(set_color $fish_git_dirty_color)$branch(set_color normal)
  else
    echo ':'(set_color $fish_git_not_dirty_color)$branch(set_color normal)
  end
end

function fish_prompt
  set -l mojis (string join \n 💸 💵 🤑 🐶 😍 ⚡️ 🔥 🥑)
  set -l n (math -s0 (random)'%'(count $mojis)'+1')
  set -l damoji $mojis[$n]
  set -l dadir (basename "$PWD")
  set -l git_dir (git rev-parse --git-dir 2> /dev/null)

  set_color FF0
  if test -n "$git_dir"
    printf '(%s ) %s%s >> ' $damoji $dadir (parse_git_branch)
  else
    printf '(%s ) %s >> ' $damoji $dadir
  end
  
end

set -g fish_user_paths "/usr/local/opt/openssl/bin" $fish_user_paths
