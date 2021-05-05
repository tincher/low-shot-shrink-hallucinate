#!/bin/bash
# save features
dir="/home/user59/bachelor/neural_nets/augmentation/low-shot-shrink-hallucinate"
mkdir -p features/ResNet10_sgm
python3 $dir/save_features.py \
  --cfg train_save_data.yaml \
  --outfile features/ResNet10_sgm/train.hdf5 \
  --modelfile checkpoints/ResNet10_sgm/89.tar \
  --model ResNet10 \
  --num_classes 56

python3 $dir/save_features.py \
  --cfg val_save_data.yaml \
  --outfile features/ResNet10_sgm/val.hdf5 \
  --modelfile checkpoints/ResNet10_sgm/89.tar \
  --model ResNet10 \
  --num_classes 56
