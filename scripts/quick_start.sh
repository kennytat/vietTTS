declare HIFIGAN_CHECKPOINT=assets/infore/hifigan/g_00800000
if [ ! -f $HIFIGAN_CHECKPOINT ]; then
  pip3 install gdown
  echo "Downloading models..."
  mkdir -p -p assets/infore/{nat,hifigan}
  gdown 1zjB02X0dVb6FkFZetJA0yyFyGoege9mf -O assets/infore/nat/duration_latest_ckpt.pickle
  gdown 1mVdJQP6F7CIiNUbqzA8X4aPCj_43xVVR -O assets/infore/nat/acoustic_latest_ckpt.pickle
  gdown 1Ry2dM8rF7Wsi_B21YCNzLUWUlOCzOx24 -O $HIFIGAN_CHECKPOINT
  python -m vietTTS.hifigan.convert_torch_model_to_haiku --config-file=assets/hifigan/config.json --checkpoint-file=$HIFIGAN_CHECKPOINT
fi

echo "Generate audio clip"
text=`cat assets/transcript.txt`
python -m vietTTS.synthesizer --text "$text" --output assets/infore/clip.wav --lexicon-file assets/infore/lexicon.txt --silence-duration 0.2
