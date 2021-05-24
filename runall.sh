#!/bin/bash

# SeqName=(BasketballPass)
# SeqName_alphabet_all=(BasketballDrill BlowingBubbles Cactus Kimono PartyScene SlideEditing Vidyo1 BasketballDrillText BQMall ChinaSpeed KristenAndSara PeopleOnStreet SlideShow Vidyo3 BasketballDrive BQSquare FourPeople RaceHorsesC Vidyo4 BasketballPass BQTerrace Johnny ParkScene RaceHorses Traffic)
# SeqName=(PeopleOnStreet Traffic BasketballDrive BQTerrace Cactus Kimono ParkScene BasketballDrill BQMall PartyScene RaceHorsesC BasketballPass BlowingBubbles BQSquare RaceHorses FourPeople Johnny KristenAndSara BasketballDrillText ChinaSpeed SlideEditing SlideShow)
SeqName=(BasketballDrill BQMall PartyScene RaceHorsesC BasketballPass BlowingBubbles BQSquare RaceHorses FourPeople Johnny KristenAndSara BasketballDrillText ChinaSpeed SlideEditing SlideShow)
# SeqName=(SlideEditing SlideShow FlyingGraphics)
qplist=(22 27 32 37)

test_1_frame=1
if [ $test_1_frame -eq 1 ]; then
    para="--FramesToBeEncoded=1"
    # para="--FramesToBeEncoded=1"
    # para="--FramesToBeEncoded=100"
else
    para=""
fi

basedir=$(pwd)

for i in "${!SeqName[@]}"; do
    for qpind in "${!qplist[@]}"; do
        {
            echo "Encoding "${SeqName[$i]}
            cd $basedir/bin_HEVC
            ./TAppEncoderStatic -c ../cfg/encoder_intra_main.cfg -c ../cfg/per-sequence/${SeqName[$i]}.cfg $para --QP=${qplist[$qpind]} >./${SeqName[$i]}_qp${qplist[$qpind]}_enc_HEVC.log
            cd $basedir/bin_VVC
            ./EncoderAppStatic -c ../cfg_VVC/encoder_intra_vtm.cfg -c ../cfg/per-sequence/${SeqName[$i]}.cfg $para --QP=${qplist[$qpind]} >./${SeqName[$i]}_qp${qplist[$qpind]}_enc_VVC.log
            cd $basedir/bin_vvenc
            ./vvencFFapp -c ../cfg_vvenc/intra_slow.cfg -c ../cfg/per-sequence/${SeqName[$i]}.cfg $para --QP=${qplist[$qpind]} >./${SeqName[$i]}_qp${qplist[$qpind]}_enc_vvenc.log
        }
    done
done
