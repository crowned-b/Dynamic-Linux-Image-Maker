#!/bin/bash
workdir=$(pwd)
apt-get -y install sox
randnum=$(shuf -i 0-3 -n 1)
echo $randnum
audiotypes=(wav mp3 flac avi)
dd bs=24 count=10 if=/dev/urandom of=src/.noisefile
makeaudio() {
        runum=$(cat src/.num_audio)
        shift
        for i in `seq $runum`; do
		cat src/.noisefile | hexdump -v -e '/1 "%u\n"' | awk '{ split("0,2,4,5,7,9,11,12",a,","); for (i = 0; i < 1; i+= 0.0001) printf("%08X\n", 100*sin(1382*exp((a[$1 % 8]/12)*log(2))*i)) }' | xxd -r -p > $i.raw
		sox -t s32 $i.raw $i.wav
		ffmpeg -i $i.wav -y src/audio/$RANDOM.${audiotypes[$RANDOM % ${#audiotypes[@]} ]}
		rm $i.wav
		rm $i.raw
	done
}
makeaudio

