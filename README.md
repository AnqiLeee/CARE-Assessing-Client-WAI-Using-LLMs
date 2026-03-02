# CARE: An Explainable Computational Framework for Assessing Client-Perceived Therapeutic Alliance

This repository contains the official implementation of **CARE** (Client-perceived Alliance Relationship Evaluator), a novel LLM-based framework that automatically predicts multi-dimensional therapeutic alliance scores and generates interpretable rationales from counseling transcripts.

## 📝 Paper

**CARE: An Explainable Computational Framework for Assessing Client-Perceived Therapeutic Alliance Using Large Language Models**  

## 🔍 Overview

Traditional methods for assessing therapeutic alliance rely on post-session questionnaires that are burdensome and often delayed. Existing computational approaches produce coarse scores, lack interpretability, and fail to model holistic session context. 

**CARE** addresses these limitations by:
- Predicting fine-grained alliance dimensions (Goal, Task, Bond)
- Generating interpretable rationales grounded in dialogue evidence
- Incorporating expert knowledge through rationale-augmented supervision
- Achieving 70%+ higher correlation with client ratings than human counselors

![CARE Framework](figures/client_wai_first_figure.png)
*The CARE model predicts client-perceived fine-grained working alliance scores by identifying and summarizing explanatory reasons from the dialogue.*

## 📊 Key Contributions

1. **Dataset Enrichment**: Augmented CounselingWAI with **9,516 expert-annotated rationales** linking conversational evidence to client alliance ratings
2. **Rationale-Augmented Framework**: Developed CARE that predicts alliance dimensions while generating interpretable rationales
3. **Empirical Validation**: Outperforms human counselors and leading LLMs (GPT-4o, DeepSeek-R1) with replication across architectures
4. **Practical Insights**: Reveals common alliance-building challenges and provides actionable guidance for counseling practice

## 🏗️ Model Architecture

CARE is fine-tuned on **LLaMA-3.1-8B-Instruct** using a rationale-augmented supervision paradigm that injects expert knowledge into the learning process.

### Task Definition
Given a counseling conversation and each measurement item, the model:
- Predicts the client's rating (1-5 Likert scale)
- Identifies supporting evidence from the dialogue

### Key Features
- **Multi-dimensional**: Assesses Goal, Task, and Bond dimensions
- **Explainable**: Provides context-grounded rationales
- **Robust**: 5-fold cross-validation with client-level data partitioning
- **Generalizable**: Validated on multiple architectures (LLaMA, Qwen)

## 📈 Performance

### Main Results

| Model | Goal (r↑) | Task (r↑) | Bond (r↑) | MSE (Avg↓) |
|-------|-----------|-----------|-----------|------------|
| Human Counselor | 0.30 | 0.30 | 0.22 | 1.40 |
| GPT-4o | 0.43 | 0.48 | 0.37 | 1.54 |
| DeepSeek-R1 | 0.42 | 0.49 | 0.40 | 1.43 |
| **CARE (Ours)** | **0.52** | **0.50** | **0.46** | **0.92** |

**Key Findings:**
- **73%**, **67%**, and **109%** improvement in Pearson correlation over human counselors
- Outperforms GPT-4o by 21% on Goal dimension and 15% on Bond dimension
- MSE reduced by up to 58% compared to top competitors
- Rationale-augmented supervision improves predictive accuracy by 16% on Goal dimension

### Rationale Quality

| Metric | Goal | Task | Bond |
|--------|------|------|------|
| BLEU | 0.22 | 0.23 | 0.28 |
| ROUGE-L | 0.42 | 0.42 | 0.47 |
| BERTScore | 0.79 | 0.79 | 0.81 |
| Faithfulness (Human) | 4.77 | 4.87 | 4.81 |

## 🚀 Getting Started

### Prerequisites

- Python 3.9+
- PyTorch 2.0+
- NVIDIA A100 (80GB) GPUs recommended
- Access to CounselingWAI dataset (research-restricted)

### Installation

```bash
git clone https://github.com/yourusername/CARE.git
cd CARE
pip install -r requirements.txt
```

### Dataset Preparation

1. Request access to **CounselingWAI dataset** (original + augmented rationales)
2. Place data in `./data/` directory

### Training

Train CARE model with rationale-augmented supervision:

### Inference

Generate predictions and rationales:

### Evaluation

Evaluate model performance:


## 📊 Dataset Details

### CounselingWAI-Augmented

| Statistic | Value |
|-----------|-------|
| Sessions | 793 |
| Clients | 82 |
| Items per session | 12 |
| Expert rationales | 9,516 |
| Rationale length | 155.25 ± 13.27 chars |

### Dimension-Specific Lexical Features

| Dimension | Top Keywords (z-scored log-odds) |
|-----------|-----------------------------------|
| Goal | 目标/goal (55.32), 努力/effort (29.31), 探讨/explore (27.57) |
| Task | 方法/method (41.73), 意识/aware (40.05), 改变/change (29.41) |
| Bond | 支持/support (45.51), 关心/care (38.76), 感受/feeling (37.05) |
