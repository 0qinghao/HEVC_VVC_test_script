#!/bin/bash

# SeqName=(BasketballPass )
# SeqName_alphabet_all=(BasketballDrill BlowingBubbles Cactus Kimono PartyScene SlideEditing Vidyo1 BasketballDrillText BQMall ChinaSpeed KristenAndSara PeopleOnStreet SlideShow Vidyo3 BasketballDrive BQSquare FourPeople RaceHorsesC Vidyo4 BasketballPass BQTerrace Johnny ParkScene RaceHorses Traffic)
SeqName=(PeopleOnStreet Traffic BasketballDrive BQTerrace Cactus Kimono ParkScene BasketballDrill BQMall PartyScene RaceHorsesC BasketballPass BlowingBubbles BQSquare RaceHorses FourPeople Johnny KristenAndSara BasketballDrillText ChinaSpeed SlideEditing SlideShow)
# SeqName=(SlideEditing SlideShow FlyingGraphics)

test_1_frame=1
if [ $test_1_frame -eq 1 ]; then
    para="--FramesToBeEncoded=10"
    # para="--FramesToBeEncoded=1"
    # para="--FramesToBeEncoded=100"
else
    para=""
fi

basedir=`pwd`

for i in "${!SeqName[@]}";
do
{
    echo "Encoding "${SeqName[$i]}
    cd $basedir/bin_HEVC
    ./TAppEncoderStatic -c ../cfg/encoder_intra_main_LL.cfg -c ../cfg/per-sequence/${SeqName[$i]}.cfg $para > ./${SeqName[$i]}_enc_HEVC.log 
    cd $basedir/bin_VVC
    ./EncoderAppStatic -c ../cfg_VVC/encoder_intra_vtm.cfg -c ../cfg_VVC/lossless/lossless.cfg -c ../cfg/per-sequence/${SeqName[$i]}.cfg $para > ./${SeqName[$i]}_enc_VVC.log 
}
done
