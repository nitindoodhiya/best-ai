import os
import csv
import json
import re
from pathlib import Path
from difflib import SequenceMatcher

# === Paths ===
GROUND_TRUTH_FILE = "ground_truth.json"
RESULTS_DIR = "results"
os.makedirs(RESULTS_DIR, exist_ok=True)

# === Load Ground Truth ===
with open(GROUND_TRUTH_FILE, "r") as f:
    ground_truth = json.load(f)

# === Scoring Logic ===
def is_correct(predicted, actual, threshold=0.85):
    def normalize(t):
        return re.sub(r"[^a-z0-9]", "", t.lower().strip())
        
    score = SequenceMatcher(None, normalize(predicted), normalize(actual)).ratio()
    return score >= threshold

# === Find model CSV files ===
model_files = [f for f in os.listdir() if f.endswith(".csv")]

results = {}

for model_file in model_files:
    model_name = model_file.replace(".csv", "")
    correct = 0
    total = 0

    with open(model_file, "r", encoding="utf-8") as f:
        reader = csv.DictReader(f)
        for row in reader:
            q = row["question"].strip()
            a = row["response"].strip()
            if q in ground_truth:
                total += 1
                correct_answer = ground_truth[q]
                if correct_answer:
                    print(f"Correct: {model_name} - Q: {q} | Expected: {ground_truth[q]} | Got: {a}\n")
                    correct += 1
                else:
                    print(f"❌ Wrong: {model_name} - Q: {q} | Expected: {ground_truth[q]} | Got: {a}\n")

    accuracy = round((correct / total) * 100, 2) if total > 0 else 0.0
    results[model_name] = {
        "correct": correct,
        "total": total,
        "accuracy_percent": accuracy
    }

# === Save to JSON ===
with open(os.path.join(RESULTS_DIR, "model_scores.json"), "w") as f:
    json.dump(results, f, indent=2)

print("✅ MMLU scoring complete. Results saved to results/model_scores.json")
