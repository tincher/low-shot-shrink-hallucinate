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
#   --num_classes 56
#
# echo "main done"

# # Next save features
# mkdir -p features/ResNet10_sgm
# python3 ./save_features.py \
#   --cfg train_save_data.yaml \
#   --outfile features/ResNet10_sgm/train.hdf5 \
#   --modelfile checkpoints/ResNet10_sgm/89.tar \
#   --model ResNet10 \
#   --num_classes 56
# python3 ./save_features.py \
#   --cfg val_save_data.yaml \
#   --outfile features/ResNet10_sgm/val.hdf5 \
#   --modelfile checkpoints/ResNet10_sgm/89.tar \
#   --model ResNet10 \
#   --num_classes 56
#
# echo "save done"

python matching_network.py --test 0 \
  --trainfile features/ResNet10_sgm/train.hdf5 \
  --lowshotmeta label_idx.json \
  --modelfile matching_network_sgm.tar
echo "matching done"
