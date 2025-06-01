#!/bin/bash

set -e

# === Config ===
MODELS=("llama3" "mistral" "zephyr")
QUESTION_FILE="mmlu_questions.txt"
OUTPUT_DIR="mmlu-results"
TMP_RESPONSE_FILE=".tmp_response.txt"

# === Check inputs ===
if [ ! -f "$QUESTION_FILE" ]; then
  echo "❌ File '$QUESTION_FILE' not found!"
  exit 1
fi

# === Create output folder if not exists ===
mkdir -p "$OUTPUT_DIR"

echo "📋 Loading questions..."
mapfile -t QUESTIONS < "$QUESTION_FILE"
echo "✅ Loaded ${#QUESTIONS[@]} questions."

# === Run for each model ===
for MODEL in "${MODELS[@]}"; do
  echo "🚀 Running model: $MODEL"
  OUTFILE="${OUTPUT_DIR}/${MODEL}.csv"
  echo "question,response" > "$OUTFILE"

  for QUESTION in "${QUESTIONS[@]}"; do
    echo "💬 [$MODEL] Q: $QUESTION"
    RESPONSE=$(echo "$QUESTION" | ollama run "$MODEL" | tr '\n' ' ' | sed 's/"/'\''/g')
    echo "\"$QUESTION\",\"$RESPONSE\"" >> "$OUTFILE"
  done

  echo "✅ Results saved to $OUTFILE"
done
