#!/bin/bash

set -e

echo "📦 Updating package list and installing dependencies..."
sudo apt update
sudo apt install -y curl

# 1. Install Ollama (if not already installed)
if ! command -v ollama &> /dev/null; then
  echo "⬇️ Installing Ollama..."
  curl -fsSL https://ollama.com/install.sh | sh
else
  echo "✅ Ollama already installed."
fi

# 2. Start Ollama service (just in case)
echo "🚀 Starting Ollama service..."
ollama serve &

# Wait briefly for service to be ready
sleep 5

# 3. List of models to install
models=("llama3" "mistral" "zephyr")

echo "⬇️ Pulling models: ${models[*]}"
for model in "${models[@]}"; do
  echo "📥 Downloading model: $model"
  ollama pull "$model"
done

# 4. Run basic prompt for verification
echo "🧪 Verifying model responses..."
for model in "${models[@]}"; do
  echo "🔍 Testing $model..."
  response=$(echo "What is the capital of France?" | ollama run "$model")
  echo -e "🧠 $model says: $response\n"
done

echo "✅ All models installed and tested successfully."

