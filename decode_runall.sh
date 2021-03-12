#!/bin/bash

# SeqName=(BasketballPass )
# SeqName=(PeopleOnStreet Traffic BasketballDrive BQTerrace Cactus Kimono ParkScene BasketballDrill BQMall PartyScene RaceHorsesC BasketballPass BlowingBubbles BQSquare RaceHorses FourPeople Johnny KristenAndSara BasketballDrillText ChinaSpeed SlideEditing SlideShow)
SeqName=(PeopleOnStreet Traffic BasketballDrive BQTerrace Cactus Kimono ParkScene BasketballDrill BQMall PartyScene RaceHorsesC BasketballPass BlowingBubbles BQSquare RaceHorses FourPeople Johnny KristenAndSara Vidyo1 Vidyo3 Vidyo4 BasketballDrillText ChinaSpeed SlideEditing SlideShow)

basedir=`pwd`

test_time=1

if [ $test_time -eq 0 ]; then
    for i in "${!SeqName[@]}";
    do
    {
        echo "Decoding "${SeqName[$i]}
        cd $basedir/bin_VVC
        ./DecoderAppStatic -b ./${SeqName[$i]}.bin -o ${SeqName[$i]}_dec.yuv > ./${SeqName[$i]}_dec_VVC.log &
        cd $basedir/bin_VVC_EI
        ./DecoderAppStatic -b ./${SeqName[$i]}.bin -o ${SeqName[$i]}_dec.yuv > ./${SeqName[$i]}_dec_VVC_EI.log &
    }&
    done
else
    for i in "${!SeqName[@]}";
    {
        echo "Decoding "${SeqName[$i]}
        cd $basedir/bin_VVC
        ./DecoderAppStatic -b ./${SeqName[$i]}.bin -o ${SeqName[$i]}_dec.yuv > ./${SeqName[$i]}_dec_VVC.log
        cd $basedir/bin_VVC_EI
        ./DecoderAppStatic -b ./${SeqName[$i]}.bin -o ${SeqName[$i]}_dec.yuv > ./${SeqName[$i]}_dec_VVC_EI.log
    }
fi