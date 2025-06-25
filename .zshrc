eval "$(starship init zsh)"

switch-nix() {
    sudo darwin-rebuild switch --flake $HOME/dots/nix
}

mlx-chat() {
    uvx --python 3.12 --isolated --from mlx-lm mlx_lm.chat \
        --model $(uvx --python 3.12 --isolated --from mlx-lm mlx_lm.manage --scan | rg mlx-community | awk '{print $1}' | fzf) \
        --max-tokens 2048
}

_mlx-serve() {
    port=$1
    model=$2

    uvx --python 3.12 --isolated --from mlx-lm mlx_lm.server \
        --model $model \
        --port $port \
        --max-tokens 4096
}

mlx-serve() {
    port=$1
    model=$(uvx --python 3.12 --isolated --from mlx-lm mlx_lm.manage --scan | rg mlx-community | awk '{print $1}' | fzf)

    echo "Serving $model ..."
    _mlx-serve $port $model | tee -a /tmp/mlx-server-$.log

    sketchybar --trigger mlx_update_list
}

mlx-stop() {
    running_models=$(ps -x | grep -e 'uvx.*mlx_lm.server' | grep -v 'grep' | sed 's/^\([0-9]*\).*--model \([^ ]*\).*$/\1 \2/')
    if [ -z $running_models ]; then
        echo "No model running. Exiting."
    else
        pid_and_model=$(echo -n $running_models | fzf)

        pid=$(echo -n $pid_and_model | awk '{printf $1}')
        model=$(echo -n $model_and_port | sed 's/.*--model \([^ ]*\).*$/\1/')

        echo "Stopping $model ..."
        kill -15 $pid

        sketchybar --trigger mlx_update_list
    fi
}

aider-start() {
    running_models=$(ps -x | grep -e 'uvx.*mlx_lm.server' | grep -v 'grep' | sed 's/.*\(--model.*$\)/\1/')
    if [ -z $running_models ]; then
        echo "No model running. Exiting."
    else
        model_and_port=$(echo -n $running_models | fzf)

        model=$(echo -n $model_and_port | sed 's/.*--model \([^ ]*\).*$/\1/')
        port=$(echo -n $model_and_port | sed 's/.*--port \([^ ]*\).*$/\1/')

        # OPENAI_API_KEY needs to be set to some value even if not used
        aider \
            --model openai/$model \
            --openai-api-base http://localhost:$port \
            --dark-mode \
            --set-env OPENAI_API_KEY=dummy-value
    fi
}

# FZF
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --color=fg:#F2DDBC,fg+:#C69478,bg:-1,bg+:-1
  --color=hl:#A74D39,hl+:#DF674C,info:#8A4B53,marker:#616655
  --color=prompt:#DF674C,spinner:#F2A766,pointer:#C69478,header:#8A4B53
  --color=border:#F2DDBC,label:#F2DDBC,query:#F2DDBC
  --border="rounded" --border-label="" --preview-window="border-rounded" --prompt=" "
  --marker="->" --pointer="*" --separator="─" --scrollbar="│"
  --info="right"'
