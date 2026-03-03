#!/bin/bash

model_names=("cp1000" "cp1190" "cp200" "cp400" "cp600" "cp800" "cp8010" "cp1170")  # 替换为实际的模型名列表
hosts=("7010" "7119" "8200" "8400" "8600" "8800" "8010" "7116")          # 替换为实际的主机列表
folds=("2" "2" "3" "3" "3" "3" "3" "3")          # 替换为实际的fold列表

backbone="/storage/home/westlakeLab/lianqi/Models/LLM-Research/Meta-Llama-3.1-8B-Instruct"

# 真实模型名映射（按需修改）
declare -A model_map=(
    ["cp1000"]="./saves/Meta-Llama-3.1-8B-Instruct/sft_lora_5e7_epoch10_wai_each_question_fold2_seed123/checkpoint-1000"
    ["cp1190"]="./saves/Meta-Llama-3.1-8B-Instruct/sft_lora_5e7_epoch10_wai_each_question_fold2_seed123/checkpoint-1190"
    ["cp200"]="./saves/Meta-Llama-3.1-8B-Instruct/sft_lora_5e7_epoch10_wai_each_question_fold3_seed123/checkpoint-200"
    ["cp400"]="./saves/Meta-Llama-3.1-8B-Instruct/sft_lora_5e7_epoch10_wai_each_question_fold3_seed123/checkpoint-400"
    ["cp600"]="./saves/Meta-Llama-3.1-8B-Instruct/sft_lora_5e7_epoch10_wai_each_question_fold3_seed123/checkpoint-600"
    ["cp800"]="./saves/Meta-Llama-3.1-8B-Instruct/sft_lora_5e7_epoch10_wai_each_question_fold3_seed123/checkpoint-800"
    ["cp8010"]="./saves/Meta-Llama-3.1-8B-Instruct/sft_lora_5e7_epoch10_wai_each_question_fold3_seed123/checkpoint-1000"
    ["cp1160"]="./saves/Meta-Llama-3.1-8B-Instruct/sft_lora_5e7_epoch10_wai_each_question_fold3_seed123/checkpoint-1160"
)

# 遍历所有元素
for i in "${!model_names[@]}"; do
    SHORT_NAME="${model_names[i]}"
    MODEL="${model_map[$SHORT_NAME]}"
    HOST="${hosts[i]}"
    FOLD="${folds[i]}"


    nohup python process_train_test.py \
        --host $HOST \
        --fold $FOLD \
        --model_name $backbone \
        --fine_tune $MODEL &


    echo "Start evaluation for model: $MODEL, fold: $FOLD, host: $HOST"

done

# 等待所有后台进程完成
wait "${PIDS[@]}"

echo "All evaluations completed."
