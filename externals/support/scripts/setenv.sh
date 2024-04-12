#!/bin/bash
# Bash Menu Script Example
ROOT_DIR=$(pwd)
BUILDROOT_DIR=$ROOT_DIR/buildroot
BR2_EXTERNAL_DIR=$ROOT_DIR/externals
i=0
while read line
do
    array[ $i ]=${line%*_defconfig}  
    (( i++ ))
done < <(ls $BR2_EXTERNAL_DIR/configs)

array[ $i ]="Quit"

PS3='Please enter your choice: '

select opt in "${array[@]}"
do
    echo "you chose choice $REPLY which is $opt"
    TARGET="$opt"
    if [[ "$opt" == "Quit" ]];  then
        break;
    fi
    (for e in "${array[@]}"; do [[ "$e" == "$opt" ]] && exit 0; done) && break || echo "invalid option $REPLY"
done

OUT_DIR="$ROOT_DIR/output/$TARGET"
echo $OUT_DIR
TARGET_DEFCONFIG=$TARGET"_defconfig"
#make "$TARGET"_defconfig O=output/$TARGET
make -C $BUILDROOT_DIR "$TARGET_DEFCONFIG" O=$OUT_DIR BR2_EXTERNAL="$BR2_EXTERNAL_DIR"
cd $OUT_DIR
