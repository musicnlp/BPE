#!/bin/bash
# Downloads the datasets

BASEDIR=$(dirname "$0")
BASEDIR=$(dirname "$BASEDIR")
cd "$BASEDIR" || exit
mkdir -p data
cd data || exit

# Maestro (V3.0.0)
#echo 'Downloading the Maestro (V3.0.0) dataset'
#curl https://storage.googleapis.com/magentadata/datasets/maestro/v3.0.0/maestro-v3.0.0-midi.zip -o maestro-v3.0.0-midi.zip || wget https://storage.googleapis.com/magentadata/datasets/maestro/v3.0.0/maestro-v3.0.0-midi.zip
#unzip maestro-v3.0.0-midi.zip && rm maestro-v3.0.0-midi.zip
#mv maestro-v3.0.0 Maestro
#for f in Maestro/**/*.midi; do  # renaming .midi file extensions to .mid
#  mv -- "$f" "${f%.so}.mid"
#done

# POP909
echo 'Downloading the POP909 dataset'
curl -LJO https://github.com/music-x-lab/POP909-Dataset/archive/refs/heads/master.zip || wget https://github.com/music-x-lab/POP909-Dataset/archive/refs/heads/master.zip
unzip POP909-Dataset-master.zip && rm POP909-Dataset-master.zip
mkdir POP909
for d in POP909-Dataset-master/POP909/*/ ; do
  mid="$(basename "$d").mid"
  mv "$d$mid" "POP909/$mid"
done
rm -r POP909-Dataset-master

# JSB Chorales
echo 'Downloading JSB Chorales'
curl http://www-ens.iro.umontreal.ca/~boulanni/JSB%20Chorales.zip -o 'JSB Chorales.zip' || wget http://www-ens.iro.umontreal.ca/~boulanni/JSB%20Chorales.zip
unzip 'JSB Chorales.zip' && rm 'JSB Chorales.zip'
mv 'JSB Chorales' 'JSB'

# GiantMIDI:
# (https://github.com/bytedance/GiantMIDI-Piano)
if [[ ! -d GiantMIDI ]]
then
  echo 'Download the GiantMIDI dataset from https://drive.google.com/drive/folders/1Stz3CAvMoplo79LR5I3onMWRelCugBYS and unzip it in the "data" directory'
fi

# MetaMIDI:
# (https://github.com/jeffreyjohnens/MetaMIDIDataset)
if [[ -d DDD ]]
then
  mv DDD MMD
else
  if [[ ! -d MMD ]]
  then
    echo 'Download the MetaMIDI dataset from https://zenodo.org/record/5142664#.YanrIi_pP0p and unzip it in the "data" directory, rename the DDD directory to MMD, then run the clean_mmd.py script'
  fi
fi