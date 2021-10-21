MIN=0
MAX=4294967295
ENCONTRADO=0
PUNTO='.'
CERO=0000000000000000
CEROS=0
NUM_CEROS=1
#echo $CEROS
START=$(date +%s.%N)
while :
do	
	cp $1 sha256.txt
	while
  		rnd=$(cat /dev/urandom | tr -dc 0-9 | fold -w${#MAX} | head -1 | sed 's/^0*//;')
  		[ -z $rnd ] && rnd=0
  		(( $rnd < $MIN || $rnd > $MAX ))
	do :
	done
	hexadecimal=$(echo "ibase=10;obase=16;$rnd" | bc)
	echo ${hexadecimal,,} >> sha256.txt
	HASH=$(sha256sum sha256.txt | head -c 32)
	
	if [ `echo $HASH | head -c $NUM_CEROS` = $CEROS ]
	then

		HASH_CEROS=$HASH
		NUM_CEROS=$((NUM_CEROS + 1))
		CEROS=`echo $CERO | head -c $NUM_CEROS` 

	#Tiempo maximo 1 min
	else
		END=$(date +%s.%N)
		DIFF=$(echo "$END - $START" | bc)
		if [ `echo $DIFF | head -c 1` != $PUNTO ]
		then
			if [ ${DIFF%%.*} -ge 60 ]
			then
				echo $HASH_CEROS
				exit
			fi
		fi


	fi
done


