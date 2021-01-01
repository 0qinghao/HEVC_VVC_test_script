#!/bin/bash

cfg_name=(BasketballPass SlideEditing)
# cfg_name=(BasketballDrill BlowingBubbles Cactus Kimono PartyScene SlideEditing Vidyo1 BasketballDrillText BQMall ChinaSpeed KristenAndSara PeopleOnStreet SlideShow Vidyo3 BasketballDrive BQSquare FourPeople RaceHorsesC Vidyo4 BasketballPass BQTerrace Johnny ParkScene RaceHorses Traffic)
# cfg_name=(PeopleOnStreet Traffic BasketballDrive BQTerrace Cactus Kimono ParkScene BasketballDrill BQMall PartyScene RaceHorsesC BasketballPass BlowingBubbles BQSquare RaceHorses FourPeople Johnny KristenAndSara BasketballDrillText ChinaSpeed SlideEditing SlideShow)

test_1_frame=0
if [ $test_1_frame -eq 1 ]; then
    para="--FramesToBeEncoded=1"
else
    para=""
fi

basedir=`pwd`

for i in "${!cfg_name[@]}";
do
    cd $basedir/bin_src
    ./TAppEncoderStatic -c ../cfg/encoder_intra_main_LL.cfg -c ../cfg/per-sequence/${cfg_name[$i]}.cfg $para > ./${cfg_name[$i]}.log
     
    # cd $basedir/bin_LBonly
    # ./TAppEncoderStatic -c ../cfg/encoder_intra_main_LL.cfg -c ../cfg/per-sequence/${cfg_name[$i]}.cfg $para > ./${cfg_name[$i]}.log
     
    # cd $basedir/bin_LPonly
    # ./TAppEncoderStatic -c ../cfg/encoder_intra_main_LL.cfg -c ../cfg/per-sequence/${cfg_name[$i]}.cfg $para > ./${cfg_name[$i]}.log
     
    # cd $basedir/bin_LBLP
    # ./TAppEncoderStatic -c ../cfg/encoder_intra_main_LL.cfg -c ../cfg/per-sequence/${cfg_name[$i]}.cfg $para > ./${cfg_name[$i]}.log
done