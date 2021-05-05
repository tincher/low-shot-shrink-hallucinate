#!/bin/bash
python3 ./matching_network.py --test 0 \
  --trainfile features/ResNet10_sgm/train.hdf5 \
  --lowshotmeta label_idx.json \
  --modelfile matching_network_sgm.tar \
  --m 10
