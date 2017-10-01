#!/bin/bash
workdir=$(pwd)
randsrv=$(shuf -i 2-4 -n 1)
difference=()
allowed=()
all=(netcat* frostwire w3af freeciv-server john vuze logkeys aircrack-ng nmap wireshark etherape tor burp bind9 apache2 postfix nginx telnet samba* mongodb vsftpd exim4 rpcbind dovecot vnc4server php5 mysql-server ssh php5 perl)
bad=(netcat* frostwire w3af freeciv-server john vuze logkeys aircrack-ng nmap wireshark etherape tor burp)
good=(bind9 apache2 postfix nginx telnet samba* mongodb vsftpd exim4 rpcbind dovecot vnc4server php5 mysql-server ssh php5 perl)

echo "Welcome to makemedirty!"
PS3='Please Choose The Allowed Services/Packages On Your Image: '
select i in ${good[@]} "custom" "NEXT" "exit"
do

	if [ $i = "NEXT" ]; then
                echo "Allowed Services/Packages: "${allowed[@]}""
		break
        elif [ $i = "custom" ]; then
                read custom
                allowed+=($custom)
	else
	allowed+=($i)
	fi
	if [ $i = "exit" ]; then
		exit
	fi
done

for i in "${good[@]}";
do
        skip=
        for j in "${allowed[@]}"1;
        do
                [[ $i == $j ]] && { skip=1; break; }
        done
        [[ -n $skip ]] || difference+=("$i")
done
N=$randsrv
for index in `shuf --input-range=0-$(( ${#difference[*]} - 1 )) | head -${N}`
do
    apt-get install ${difference[$index]}
done

N=$randsrv
for index in `shuf --input-range=0-$(( ${#bad[*]} - 1 )) | head -${N}`
do
    apt-get install ${bad[$index]}
done

###audio files###
echo "How many audio files: "
read num_audio
echo $num_audio > $workdir/src/.num_audio
$workdir/src/randomsounds.sh
