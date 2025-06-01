import json

# Input and output file paths
GROUND_TRUTH_FILE = "ground_truth.json"
OUTPUT_FILE = "mmlu_questions.txt"

# Load ground truth data
with open(GROUND_TRUTH_FILE, "r", encoding="utf-8") as f:
    ground_truth = json.load(f)

# Write questions to a text file
with open(OUTPUT_FILE, "w", encoding="utf-8") as f:
    for question in ground_truth.keys():
        f.write(question.strip() + "\n")

print(f"✅ Saved {len(ground_truth)} questions to {OUTPUT_FILE}")
