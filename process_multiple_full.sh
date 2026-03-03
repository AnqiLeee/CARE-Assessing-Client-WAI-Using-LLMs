#!/bin/bash

model_names=("cp8200" "cp8400" "cp8600" "cp8800" "cp8010" "cp8118")  # 替换为实际的模型名列表
hosts=("8200" "8400" "8600" "8800" "8010" "8118")          # 替换为实际的主机列表
folds=("4" "4" "4" "4" "4" "4")          # 替换为实际的fold列表



# 真实模型名映射（按需修改）
declare -A model_map=(
    ["cp8200"]="./saves/Qwen2.5-7B-Instruct/sft_full_5e7_epoch10_wai_each_question_fold4_seed123/checkpoint-200"
    ["cp8400"]="./saves/Qwen2.5-7B-Instruct/sft_full_5e7_epoch10_wai_each_question_fold4_seed123/checkpoint-400"
    ["cp8600"]="./saves/Qwen2.5-7B-Instruct/sft_full_5e7_epoch10_wai_each_question_fold4_seed123/checkpoint-600"
    ["cp8800"]="./saves/Qwen2.5-7B-Instruct/sft_full_5e7_epoch10_wai_each_question_fold4_seed123/checkpoint-800"
    ["cp8010"]="./saves/Qwen2.5-7B-Instruct/sft_full_5e7_epoch10_wai_each_question_fold4_seed123/checkpoint-1000"
    ["cp8118"]="./saves/Qwen2.5-7B-Instruct/sft_full_5e7_epoch10_wai_each_question_fold4_seed123/checkpoint-1180"
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
        --model_name $MODEL \
        --fine_tune $MODEL &

    echo "Start evaluation for model: $MODEL, fold: $FOLD, host: $HOST"


done

# 等待所有后台进程完成
wait "${PIDS[@]}"

echo "All evaluations completed."
