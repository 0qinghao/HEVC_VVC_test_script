#!/bin/bash

# SeqName=(BasketballPass)
# SeqName_alphabet_all=(BasketballDrill BlowingBubbles Cactus Kimono PartyScene SlideEditing Vidyo1 BasketballDrillText BQMall ChinaSpeed KristenAndSara PeopleOnStreet SlideShow Vidyo3 BasketballDrive BQSquare FourPeople RaceHorsesC Vidyo4 BasketballPass BQTerrace Johnny ParkScene RaceHorses Traffic)
# SeqName=(PeopleOnStreet Traffic BasketballDrive BQTerrace Cactus Kimono ParkScene BasketballDrill BQMall PartyScene RaceHorsesC BasketballPass BlowingBubbles BQSquare RaceHorses FourPeople Johnny KristenAndSara BasketballDrillText ChinaSpeed SlideEditing SlideShow)
SeqName=(BasketballDrill BQMall PartyScene RaceHorsesC BasketballPass BlowingBubbles BQSquare RaceHorses FourPeople Johnny KristenAndSara BasketballDrillText ChinaSpeed SlideEditing SlideShow)
# SeqName=(SlideEditing SlideShow FlyingGraphics)
qplist=(22 27 32 37)

test_1_frame=1
if [ $test_1_frame -eq 1 ]; then
    # para="--FramesToBeEncoded=1"
    para="--FramesToBeEncoded=32"
    # para="--FramesToBeEncoded=1"
    # para="--FramesToBeEncoded=100"
else
    para=""
fi

basedir=$(pwd)

for i in "${!SeqName[@]}"; do
    for qpind in "${!qplist[@]}"; do
        {
            cd $basedir/bin_HEVC
            echo "Encoding "${SeqName[$i]}" HM"
            ./TAppEncoderStatic -c ../cfg/encoder_randomaccess_main.cfg -c ../cfg/per-sequence/${SeqName[$i]}.cfg $para --QP=${qplist[$qpind]} >./${SeqName[$i]}_qp${qplist[$qpind]}_enc_HEVC.log

            cd $basedir/bin_VVC
            echo "Encoding "${SeqName[$i]}" VTM"
            ./EncoderAppStatic -c ../cfg_VVC/encoder_randomaccess_vtm.cfg -c ../cfg/per-sequence/${SeqName[$i]}.cfg $para --QP=${qplist[$qpind]} >./${SeqName[$i]}_qp${qplist[$qpind]}_enc_VVC.log

            cd $basedir/bin_vvenc
            echo "Encoding "${SeqName[$i]}" VVenC slow"
            ./vvencFFapp -c ../cfg_vvenc/randomaccess_slow.cfg -c ../cfg/per-sequence/${SeqName[$i]}.cfg $para --QP=${qplist[$qpind]} >./${SeqName[$i]}_qp${qplist[$qpind]}_slow_enc_vvenc.log
            echo "Encoding "${SeqName[$i]}" VVenC medium"
            ./vvencFFapp -c ../cfg_vvenc/randomaccess_medium.cfg -c ../cfg/per-sequence/${SeqName[$i]}.cfg $para --QP=${qplist[$qpind]} >./${SeqName[$i]}_qp${qplist[$qpind]}_medium_enc_vvenc.log
            echo "Encoding "${SeqName[$i]}" VVenC fast"
            ./vvencFFapp -c ../cfg_vvenc/randomaccess_fast.cfg -c ../cfg/per-sequence/${SeqName[$i]}.cfg $para --QP=${qplist[$qpind]} >./${SeqName[$i]}_qp${qplist[$qpind]}_fast_enc_vvenc.log
            echo "Encoding "${SeqName[$i]}" VVenC faster"
            ./vvencFFapp -c ../cfg_vvenc/randomaccess_faster.cfg -c ../cfg/per-sequence/${SeqName[$i]}.cfg $para --QP=${qplist[$qpind]} >./${SeqName[$i]}_qp${qplist[$qpind]}_faster_enc_vvenc.log
        }
    done
done
