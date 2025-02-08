function dotfiles --wraps='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME' --description 'alias for managing bare git repo versioning the dotfiles'
    if not set -q argv[1]
        git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME status
    else
        git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $argv
    end
end
