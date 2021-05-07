#!/bin/bash


# Train analogy-based generator
mkdir -p generation
python3 ./train_analogy_generator.py \
  --lowshotmeta label_idx.json \
  --trainfile features/ResNet10_sgm/train.hdf5 \
  --outdir generation \
  --initlr 1 \
  --networkfile checkpoints/ResNet10_sgm/89.tar \
  --numclasses 89
