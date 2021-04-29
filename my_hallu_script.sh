#!/bin/bash



# ResNet10 with SGM loss and generation
# Hyperparameters to be aware of:
# aux_loss_wt = 0.02 for main.py
# lr = 1, wd = 0.001 for low_shot.py without generation
# initlr = 1 for train_analogy_generator.py
# lr = 1, wd = 0.001, max_per_label = 5 for low_shot.py with generation


# First train representation
# mkdir -p checkpoints/ResNet10_sgm
# python3 ./main.py --model ResNet10 \
#   --traincfg base_classes_train_template.yaml \
#   --valcfg base_classes_val_template.yaml \
#   --print_freq 10 --save_freq 10 \
#   --aux_loss_wt 0.02 --aux_loss_type sgm \
#   --checkpoint_dir checkpoints/ResNet10_sgm \
#   --num_classes 51

echo "main done"
# Next save features
# mkdir -p features/ResNet10_sgm
# python3 ./save_features.py \
#   --cfg train_save_data.yaml \
#   --outfile features/ResNet10_sgm/train.hdf5 \
#   --modelfile checkpoints/ResNet10_sgm/89.tar \
#   --model ResNet10 \
#   --num_classes 51
# python3 ./save_features.py \
#   --cfg val_save_data.yaml \
#   --outfile features/ResNet10_sgm/val.hdf5 \
#   --modelfile checkpoints/ResNet10_sgm/89.tar \
#   --model ResNet10 \
#   --num_classes 51

echo "save done"

# Low-shot benchmark without generation
for i in {1..5}
do
  for j in 1 2 5 10 20
  do
    python3 ./low_shot.py --lowshotmeta label_idx.json \
      --experimentpath experiment_cfgs/splitfile_{:d}.json \
      --experimentid  $i --lowshotn $j \
      --trainfile features/ResNet10_sgm/train.hdf5 \
      --testfile features/ResNet10_sgm/val.hdf5 \
      --outdir results \
      --lr 1 --wd 0.001 \
      --testsetup 1
  done
done


# parse results
echo "ResNet10 SGM results (no generation)"
python3 ./parse_results.py --resultsdir results \
  --repr ResNet10_sgm \
  --lr 1 --wd 0.001

echo "ResNet10 SGM results (no generation) parsing done"


# Train analogy-based generator
mkdir generation
python3 ./train_analogy_generator.py \
  --lowshotmeta label_idx.json \
  --trainfile features/ResNet10_sgm/train.hdf5 \
  --outdir generation \
  --initlr 1 \
  --networkfile checkpoints/ResNet10_sgm/89.tar \
  --numclasses 51

echo "Train analogy-based generator done"


# Low-shot benchmark _with_ generation
for i in {1..5}
do
  for j in 1 2 5 10 20
  do
    python3 ./low_shot.py --lowshotmeta label_idx.json \
      --experimentpath experiment_cfgs/splitfile_{:d}.json \
      --experimentid  $i --lowshotn $j \
      --trainfile features/ResNet10_sgm/train.hdf5 \
      --testfile features/ResNet10_sgm/val.hdf5 \
      --outdir results \
      --lr 1 --wd 0.001 \
      --testsetup 1 \
      --max_per_label 5 \
      --generator_name analogies \
      --generator_file generation/ResNet10_sgm/generator.tar
  done
done

# parse results
echo "ResNet10 SGM results (with generation)"
python3 ./parse_results.py --resultsdir results \
  --repr ResNet10_sgm \
  --lr 1 --wd 0.001 \
  --max_per_label 5

echo "ResNet10 SGM results (with generation)"
