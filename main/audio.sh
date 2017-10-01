#!/bin/bash
workdir=$(pwd)
PS3='How many audio files: '
echo "How many audio files: "
read num_audio
echo $num_audio > $workdir/src/.num_audio
bash $workdir/src/randomsounds.sh






