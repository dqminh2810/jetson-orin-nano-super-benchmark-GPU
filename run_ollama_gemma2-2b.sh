#!/bin/bash

## ENABLE GPU FOR DOCKER
#### Verify WSL2 Has GPU Access
nvidia-smi

#### Verify Container Runtime Integration
sudo nvidia-ctk runtime configure --runtime=docker
sudo systemctl restart docker


## INSTALL OLLAMA
#### Natively install on MAC PRO
#curl -fsSL https://ollama.com/install.sh | sh

#### Standard without GPU
#docker run -d -v ollama:/root/.ollama -p 11434:11434 --name ollama ollama/ollama

#### x86/Standard Systems with GPU
#docker run -d --gpus=all -v ollama:/root/.ollama -p 11434:11434 --name ollama ollama/ollama

#### ARM-based NVIDIA Jetson environments
docker run -d --runtime nvidia -v ollama:/root/.ollama -p 11434:11434 --name ollama ollama/ollama


## INSTALL GEMMA2:2B
docker exec -it ollama ollama run --verbose gemma2:2b

#### Natively run on MAC PRO
#ollama run --verbose gemma2:2b


## PROMPT
# What's the derivative of f(x) = x^2 * exp(x) * sqrt(x)?