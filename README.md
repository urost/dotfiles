# (n)vim presentation

## Installing Neovim

Use this [link](https://github.com/neovim/neovim/wiki/Installing-Neovim).

Once you install neovim, you should install python packages.
    
    pip3 install --upgrade neovim                            
    pip2 install --upgrade neovim

Also, install more apps for better usage of neovim:

    sudo apt install xsel silversearcher-ag aspell wamerican-huge 

At any point, to check status, you should run in neovim:

    :CheckHealth

or:

    :UpdateRemotePlugins

to check and register the needed plugins.

Also, modify `.bashrc` file:

    [ -f ~/.fzf.bash ] && source ~/.fzf.bash
    export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'

    if [ -f ~/config/sensible.bash ]; then
        . ~/config/sensible.bash
    fi



