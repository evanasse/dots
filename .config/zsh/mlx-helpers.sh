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
    model_name=$(uvx --python 3.12 --isolated --from mlx-lm mlx_lm.manage --scan | grep mlx-community | awk '{print $1}' | fzf)
    model_short_name=$(echo $model_name | sed 's/mlx-community\///')

    if [ -z $model_name ]; then
        echo "No model selected."
    else
        echo "Serving $model_short_name on port $port..."
        sketchybar --trigger mlx_update_list

        _mlx-serve $port $model_name > /tmp/mlx-server-$model_short_name.$port.log 2>&1 &|
    fi
}

mlx-stop() {
    running_models=$(ps -x | grep -e 'uvx.*mlx_lm.server' | grep -v 'grep' | sed 's/^\([0-9]*\).*--model \([^ ]*\).*--port \([^ ]*\).*$/\2 \3 \1/')
    if [ -z $running_models ]; then
        echo "No model running. Exiting."
    else
        model_name_port_and_pid=$(echo -n $running_models | fzf)

        pid=$(echo -n $model_name_port_and_pid | awk '{printf $3}')
        model_name=$(echo -n $model_name_port_and_pid | awk '{printf $1}')
        model_short_name=$(echo $model_name | sed 's/mlx-community\///')
        port=$(echo -n $model_name_port_and_pid | awk '{printf $2}')

        echo "Stopping $model_short_name on port $port..."
        kill -15 $pid

        # Wait to make sure the process is killed
        sleep 0.3
        sketchybar --trigger mlx_update_list
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
