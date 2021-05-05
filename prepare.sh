#!/bin/bash
# save features
mkdir -p features/ResNet10_sgm
python3 ./save_features.py \
  --cfg train_save_data.yaml \
  --outfile features/ResNet10_sgm/train.hdf5 \
  --modelfile checkpoints/ResNet10_sgm/89.tar \
  --model ResNet10 \
  --num_classes 56

python3 ./save_features.py \
  --cfg val_save_data.yaml \
  --outfile features/ResNet10_sgm/val.hdf5 \
  --modelfile checkpoints/ResNet10_sgm/89.tar \
  --model ResNet10 \
  --num_classes 56
