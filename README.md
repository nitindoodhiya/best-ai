# 🧠 best-ai — MMLU Benchmarking for Local LLMs

This project helps you **evaluate multiple local language models** (e.g., LLaMA 3, Mistral, Zephyr) on a shared set of questions inspired by the [MMLU](https://github.com/hendrycks/test) benchmark.

It runs each model using [Ollama](https://ollama.com), collects their responses, and compares them against ground-truth answers to compute accuracy.

---

## 📦 Folder Structure

```
best-ai/
├── mmlu_questions.txt           # All MMLU-style questions (1 per line)
├── ground_truth.json            # JSON mapping: { question: correct_answer }
├── outputs/                     # Stores model CSV outputs
├── results/                     # Stores final accuracy scores
├── run_models.sh                # Runs each model via Ollama and saves responses
├── score_mmlu.py                # Compares responses to ground-truth and computes scores
└── generate_mmlu_questions.py  # Converts ground_truth.json into question list
```

---

## 🛠️ Requirements

- Python 3.8+
- Bash shell (Linux/macOS/WSL)
- [Ollama](https://ollama.com) installed with models pulled

---

## 🚀 Getting Started

### 1. Clone the repo

```bash
git clone https://github.com/nitindoodhiya/best-ai.git
cd best-ai
```

---

### 2. Install Local Models with Ollama

Make sure you have Ollama installed and pull the required models:

```bash
ollama pull llama3
ollama pull mistral
ollama pull zephyr
```

> You can edit the `MODELS=(...)` array in `run_models.sh` to add/remove models.

---

### 3. Create MMLU Questions (Optional)

If you have a ground truth file (`ground_truth.json`), run:

```bash
python3 generate_mmlu_questions.py
```

This creates `mmlu_questions.txt` automatically.

---

### 4. Run Models and Save Outputs

```bash
bash run_models.sh
```

This will:
- Run each model on each question
- Save the responses to `outputs/{model_name}.csv`

---

### 5. Score the Responses

```bash
python3 score_mmlu.py
```

This script will:
- Compare every response to `ground_truth.json`
- Calculate accuracy
- Save the results to `results/model_scores.json`

---

## 📊 Example Output

```json
{
  "llama3": {
    "correct": 8,
    "total": 10,
    "accuracy_percent": 80.0
  },
  "mistral": {
    "correct": 7,
    "total": 10,
    "accuracy_percent": 70.0
  },
  "zephyr": {
    "correct": 6,
    "total": 10,
    "accuracy_percent": 60.0
  }
}
```

---

## ✅ Customize It

- Add more questions in `ground_truth.json`
- Tune the comparison function in `score_mmlu.py` (e.g. allow fuzzy or partial matches)
- Add more models to the `MODELS=(...)` array

---

## 📬 Contributing

PRs and ideas welcome — feel free to fork or submit improvements!

---

## 📄 License

MIT
