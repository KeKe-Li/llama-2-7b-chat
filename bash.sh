#!/bin/bash

mkdir content
# switch /content
cd ./content

# install aria2
apt-get -y install -qq aria2

git clone -b v2.5 https://github.com/你的仓库地址.git /content/text-generation-webui

cd ./content/text-generation-webui

# install Python
pip install -q -r requirements.txt

# llama
aria2c --console-log-level=error -c -x 16 -s 16 -k 1M https://huggingface.co/4bit/Llama-2-7b-chat-hf/resolve/main/model-00001-of-00002.safetensors -d /content/text-generation-webui/models/Llama-2-7b-chat-hf -o model-00001-of-00002.safetensors
aria2c --console-log-level=error -c -x 16 -s 16 -k 1M https://huggingface.co/4bit/Llama-2-7b-chat-hf/resolve/main/model-00002-of-00002.safetensors -d /content/text-generation-webui/models/Llama-2-7b-chat-hf -o model-00002-of-00002.safetensors
aria2c --console-log-level=error -c -x 16 -s 16 -k 1M https://huggingface.co/4bit/Llama-2-7b-chat-hf/raw/main/model.safetensors.index.json -d /content/text-generation-webui/models/Llama-2-7b-chat-hf -o model.safetensors.index.json
aria2c --console-log-level=error -c -x 16 -s 16 -k 1M https://huggingface.co/4bit/Llama-2-7b-chat-hf/raw/main/special_tokens_map.json -d /content/text-generation-webui/models/Llama-2-7b-chat-hf -o special_tokens_map.json
aria2c --console-log-level=error -c -x 16 -s 16 -k 1M https://huggingface.co/4bit/Llama-2-7b-chat-hf/resolve/main/tokenizer.model -d /content/text-generation-webui/models/Llama-2-7b-chat-hf -o tokenizer.model
aria2c --console-log-level=error -c -x 16 -s 16 -k 1M https://huggingface.co/4bit/Llama-2-7b-chat-hf/raw/main/tokenizer_config.json -d /content/text-generation-webui/models/Llama-2-7b-chat-hf -o tokenizer_config.json
aria2c --console-log-level=error -c -x 16 -s 16 -k 1M https://huggingface.co/4bit/Llama-2-7b-chat-hf/raw/main/config.json -d /content/text-generation-webui/models/Llama-2-7b-chat-hf -o config.json
aria2c --console-log-level=error -c -x 16 -s 16 -k 1M https://huggingface.co/4bit/Llama-2-7b-chat-hf/raw/main/generation_config.json -d /content/text-generation-webui/models/Llama-2-7b-chat-hf -o generation_config.json

# set yaml
echo "dark_theme: true" > /content/settings.yaml
echo "chat_style: wpp" >> /content/settings.yaml

# start server
cd ./content/text-generation-webui
python server.py --share --settings /content/settings.yaml --model /content/text-generation-webui/models/Llama-2-7b-chat-hf