#!/bin/bash

# SeqName=(BasketballPass )
# SeqName=(PeopleOnStreet Traffic BasketballDrive BQTerrace Cactus Kimono ParkScene BasketballDrill BQMall PartyScene RaceHorsesC BasketballPass BlowingBubbles BQSquare RaceHorses FourPeople Johnny KristenAndSara BasketballDrillText ChinaSpeed SlideEditing SlideShow)
SeqName=(PeopleOnStreet Traffic BasketballDrive BQTerrace Cactus Kimono ParkScene BasketballDrill BQMall PartyScene RaceHorsesC BasketballPass BlowingBubbles BQSquare RaceHorses FourPeople Johnny KristenAndSara Vidyo1 Vidyo3 Vidyo4 BasketballDrillText ChinaSpeed SlideEditing SlideShow)

test_time=0
test_few_frames=1
if [ $test_few_frames -eq 1 ]; then
    # para="--FramesToBeEncoded=1"
    para="--FramesToBeEncoded=10"
    # para="--FramesToBeEncoded=100"
else
    para=""
fi

basedir=`pwd`

if [ $test_time -eq 0 ]; then
    for i in "${!SeqName[@]}";
    do
    {
        echo "Encoding "${SeqName[$i]}
        cd $basedir/bin_VVC
        ./EncoderAppStatic -c ../cfg_VVC/encoder_intra_vtm.cfg -c ../cfg_VVC/lossless/lossless.cfg -c ../cfg/per-sequence/${SeqName[$i]}.cfg $para > ./${SeqName[$i]}_enc_VVC.log &
        cd $basedir/bin_VVC_EI
        ./EncoderAppStatic -c ../cfg_VVC/encoder_intra_vtm.cfg -c ../cfg_VVC/lossless/lossless.cfg -c ../cfg/per-sequence/${SeqName[$i]}.cfg $para > ./${SeqName[$i]}_enc_VVC_EI.log &
    }&
    done
else
    for i in "${!SeqName[@]}";
    {
        echo "Encoding "${SeqName[$i]}
        cd $basedir/bin_VVC
        ./EncoderAppStatic -c ../cfg_VVC/encoder_intra_vtm.cfg -c ../cfg_VVC/lossless/lossless.cfg -c ../cfg/per-sequence/${SeqName[$i]}.cfg $para > ./${SeqName[$i]}_enc_VVC.log 
        cd $basedir/bin_VVC_EI
        ./EncoderAppStatic -c ../cfg_VVC/encoder_intra_vtm.cfg -c ../cfg_VVC/lossless/lossless.cfg -c ../cfg/per-sequence/${SeqName[$i]}.cfg $para > ./${SeqName[$i]}_enc_VVC_EI.log 
    }
fi