mkdir -p checkpoints/ResNet10_sgm
python3 ./main.py --model ResNet10 \
  --traincfg base_classes_train_template.yaml \
  --valcfg base_classes_val_template.yaml \
  --print_freq 10 --save_freq 10 \
  --aux_loss_wt 0.02 --aux_loss_type sgm \
  --checkpoint_dir checkpoints/ResNet10_sgm \
  --num_classes 56
