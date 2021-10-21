CERO=0
REGEX=[a-f0-9]{8}" G3436"
GRUPO=" G3436"

F1=`cat $1`
F2=`head -n -1 $2`

if [ "$F1" = "$F2" ]
then
    if [ `sha256sum $2 | head -c 1` = $CERO ]
    then
        LASTLINE=`tail -1 $2`
        if [[ $LASTLINE =~ $REGEX ]] 
        then
            echo "CORRECTO"
        else
            echo "FORMATO DE LA ULTIMA LINEA INCORRECTO"
        fi
    else
        echo "HASH NO EMPIEZA POR 0"
    fi
else
    echo "NO SON IGUALES"
fi