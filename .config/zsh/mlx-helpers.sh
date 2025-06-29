mlx-chat() {
    model=$(uvx --python 3.12 --isolated --from mlx-lm mlx_lm.manage --scan | grep mlx-community | awk '{print $1}' | fzf)
    if [ -z $model ]; then
        echo "No model selected."
    else
        uvx --python 3.12 --isolated --from mlx-lm mlx_lm.chat \
            --model $model \
            --max-tokens 2048
    fi
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
    if [ -z $1 ]; then
        echo "Missing expected port number, e.g. 'mlx-serve PORT_NUMBER'"
        return
    fi

    port=$1
    model=$(uvx --python 3.12 --isolated --from mlx-lm mlx_lm.manage --scan | grep mlx-community | awk '{print $1}' | fzf)

    if [ -z $model ]; then
        echo "No model selected."
    else
        echo "Serving $model..."
        sketchybar --trigger mlx_update_list

        _mlx-serve $port $model | tee -a /tmp/mlx-server-$.log
    fi
}

mlx-ls() {
    uvx --python 3.12 --isolated --from mlx-lm mlx_lm.manage --scan
}

mlx-download() {
    if [ -z $1 ]; then
        echo "Missing expected model name, e.g. 'mlx-download MODEL_NAME'"
    else
        uvx --python 3.12 --isolated --from huggingface_hub huggingface-cli download mlx-community/$1
    fi
}

mlx-delete() {
    model=$(uvx --python 3.12 --isolated --from mlx-lm mlx_lm.manage --scan | grep mlx-community | awk '{print $1}' | fzf --header "Delete model")

    if [ -z $model ]; then
        echo "No model selected."
    else
        echo "Deleting $model..."
        uvx --python 3.12 --isolated --from mlx-lm mlx_lm.manage --delete --pattern $model
    fi
}

mlx-stop() {
    running_models=$(ps -x | grep -e 'uvx.*mlx_lm.server' | grep -v 'grep' | sed 's/^\([0-9]*\).*--model \([^ ]*\).*$/\1 \2/')
    if [ -z $running_models ]; then
        echo "No model running. Exiting."
    else
        pid_and_model=$(echo -n $running_models | fzf)

        pid=$(echo -n $pid_and_model | awk '{printf $1}')
        model=$(echo -n $model_and_port | sed 's/.*--model \([^ ]*\).*$/\1/')

        echo "Stopping $model..."
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
