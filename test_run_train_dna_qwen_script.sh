# !/bin/bash
# SBATCH --job-name=train_dna_qwen
# SBATCH --partition=HGX
# SBATCH --gpus=2
# SBATCH --time=8:00:00
# SBATCH --mem=128gb
# SBATCH --cpus-per-task=16
# SBATCH --ntasks=1
# SBATCH --output=train_dna_qwen_%j_%x.out
# SBATCH --error=train_dna_qwen_%j_%x.err

# Set GPU visibility
export CUDA_VISIBLE_DEVICES=1,2

# Run training
python train_dna_qwen.py \
    --cache_dir ~/.cache/huggingface \
    --wandb_project bioreason_exp \
    --wandb_entity xwang160 \
    --model_type dna-llm \
    --text_model_name Qwen/Qwen3-1.7B \
    --dna_model_name InstaDeepAI/nucleotide-transformer-v2-500m-multi-species \
    --strategy ddp \
    --max_epochs 3 \
    --num_gpus 2 \
    --batch_size 1 \
    --gradient_accumulation_steps 8 \
    --max_length_dna 1024 \
    --max_length_text 1024 \
    --truncate_dna_per_side 1024 \
    --learning_rate 5e-5 \
    --weight_decay 0.01 \
    --lora_rank 32 \
    --lora_alpha 64 \
    --lora_dropout 0.05 \
    --dataset_type variant_effect_coding \
    --num_workers 16
