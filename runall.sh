#!/bin/bash

# SeqName=(BasketballPass)
# SeqName_alphabet_all=(BasketballDrill BlowingBubbles Cactus Kimono PartyScene SlideEditing Vidyo1 BasketballDrillText BQMall ChinaSpeed KristenAndSara PeopleOnStreet SlideShow Vidyo3 BasketballDrive BQSquare FourPeople RaceHorsesC Vidyo4 BasketballPass BQTerrace Johnny ParkScene RaceHorses Traffic)
# SeqName=(Tango2 FoodMarket4 PeopleOnStreet Traffic BasketballDrive BQTerrace Cactus Kimono ParkScene BasketballDrill BQMall PartyScene RaceHorsesC BasketballPass BlowingBubbles BQSquare RaceHorses FourPeople Johnny KristenAndSara BasketballDrillText ChinaSpeed SlideEditing SlideShow)
# SeqName=(PeopleOnStreet Traffic BasketballDrive BQTerrace Cactus Kimono ParkScene BasketballDrill BQMall PartyScene RaceHorsesC BasketballPass BlowingBubbles BQSquare RaceHorses FourPeople Johnny KristenAndSara BasketballDrillText ChinaSpeed SlideEditing SlideShow)
# SeqName=(Vidyo1 Vidyo3 Vidyo4)
# SeqName=(PeopleOnStreet Traffic BasketballDrive BQTerrace Cactus Kimono ParkScene BasketballDrill BQMall PartyScene RaceHorsesC BasketballPass BlowingBubbles BQSquare RaceHorses FourPeople Johnny KristenAndSara Vidyo1 Vidyo3 Vidyo4 BasketballDrillText ChinaSpeed SlideEditing SlideShow)
SeqName=(Tango FoodMarket4 Campfire CatRobot DaylightRoad2 ParkRunning3)
# SeqName=(BasketballPass BlowingBubbles BQSquare SlideEditing SlideShow)
# SeqName=(SlideEditing SlideShow FlyingGraphics)

test_1_frame=1
test_time=0
if [ $test_1_frame -eq 1 ]; then
    # para="--FramesToBeEncoded=10"
    para="--FramesToBeEncoded=1"
    # para="--FramesToBeEncoded=100"
else
    para=""
fi

basedir=$(pwd)

if [ $test_time -eq 1 ]; then
    for i in "${!SeqName[@]}"; do
        {
            echo "Encoding "${SeqName[$i]}
            cd $basedir/bin_VVC_src
            ./EncoderAppStatic -c ../cfg_VVC/encoder_intra_vtm.cfg -c ../cfg_VVC/lossless/lossless.cfg -c ../cfg_VVC/per-sequence/${SeqName[$i]}.cfg $para >./${SeqName[$i]}_enc_VVC_src.log
            cd $basedir/bin_VVC_lip
            ./EncoderAppStatic -c ../cfg_VVC/encoder_intra_vtm.cfg -c ../cfg_VVC/lossless/lossless.cfg -c ../cfg_VVC/per-sequence/${SeqName[$i]}.cfg $para >./${SeqName[$i]}_enc_VVC_lip.log
        }
    done
else
    for i in "${!SeqName[@]}"; do
        {
            echo "Encoding "${SeqName[$i]}
            cd $basedir/bin_VVC_src
            ./EncoderAppStatic -c ../cfg_VVC/encoder_intra_vtm.cfg -c ../cfg_VVC/lossless/lossless.cfg -c ../cfg_VVC/per-sequence/${SeqName[$i]}.cfg $para >./${SeqName[$i]}_enc_VVC_src.log &
            cd $basedir/bin_VVC_lip
            ./EncoderAppStatic -c ../cfg_VVC/encoder_intra_vtm.cfg -c ../cfg_VVC/lossless/lossless.cfg -c ../cfg_VVC/per-sequence/${SeqName[$i]}.cfg $para >./${SeqName[$i]}_enc_VVC_lip.log &
        } &
    done
fi
