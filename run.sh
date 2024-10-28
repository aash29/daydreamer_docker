#rm -rf ~/logdir/run1

CUDA_VISIBLE_DEVICES=0 nohup python3 embodied/agents/dreamerv2plus/train.py --configs go1 --task go1_sim --run acting --tf.platform gpu --env.kbreset True --imag_horizon 1 --replay_chunk 8 --replay_fixed.minlen 32 --imag_horizon 1 --logdir ~/logdir/run1 &
CUDA_VISIBLE_DEVICES=0 python3 embodied/agents/dreamerv2plus/train.py --configs go1 --task go1_sim --run learning --tf.platform gpu --logdir ~/logdir/run1
#(echo CUDA_VISIBLE_DEVICES=0 python embodied/agents/dreamerv2plus/train.py --configs a1 --task a1_sim --run learning --tf.platform gpu --logdir ~/logdir/run1; \
# echo CUDA_VISIBLE_DEVICES=1 python embodied/agents/dreamerv2plus/train.py --configs a1 --task a1_real --run acting --tf.platform gpu --env.kbreset True --imag_horizon 1 --replay_chunk 8 --replay_fixed.minlen 32 --imag_horizon 1 --logdir ~/logdir/run1) \
# | parallel
