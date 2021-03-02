#!/bin/bash

# SeqName=(BasketballPass SlideEditing)
# SeqName_alphabet_all=(BasketballDrill BlowingBubbles Cactus Kimono PartyScene SlideEditing Vidyo1 BasketballDrillText BQMall ChinaSpeed KristenAndSara PeopleOnStreet SlideShow Vidyo3 BasketballDrive BQSquare FourPeople RaceHorsesC Vidyo4 BasketballPass BQTerrace Johnny ParkScene RaceHorses Traffic)
# SeqName=(PeopleOnStreet Traffic BasketballDrive BQTerrace Cactus Kimono ParkScene BasketballDrill BQMall PartyScene RaceHorsesC BasketballPass BlowingBubbles BQSquare RaceHorses FourPeople Johnny KristenAndSara BasketballDrillText ChinaSpeed SlideEditing SlideShow)
SeqName=(SlideEditing SlideShow FlyingGraphics)

test_1_frame=1
if [ $test_1_frame -eq 1 ]; then
    # para="--FramesToBeEncoded=10"
    para="--FramesToBeEncoded=1"
    # para="--FramesToBeEncoded=200"
else
    para=""
fi

basedir=`pwd`

for i in "${!SeqName[@]}";
do
{
    echo "Encoding "${SeqName[$i]}
    cd $basedir/bin_src
    ./TAppEncoderStatic -c ../cfg/encoder_intra_main_LL.cfg -c ../cfg/per-sequence/${SeqName[$i]}.cfg $para > ./${SeqName[$i]}_enc_src.log &
    cd $basedir/bin_scan
    ./TAppEncoderStatic -c ../cfg/encoder_intra_main_LL.cfg -c ../cfg/per-sequence/${SeqName[$i]}.cfg $para > ./${SeqName[$i]}_enc_scan.log &
}&
done

wait

# for i in "${!SeqName[@]}";
# do
#     echo "Decoding "${SeqName[$i]}
#     cd $basedir/bin_src
#     ./TAppDecoderStatic -b ./${SeqName[$i]}.bin -o ${SeqName[$i]}_dec.yuv > ./${SeqName[$i]}_dec_src.log
#     # cd $basedir/bin_scan
#     # ./TAppDecoderStatic -b ./${SeqName[$i]}.bin -o ${SeqName[$i]}_dec.yuv > ./${SeqName[$i]}_dec_scan.log
#     # cd $basedir/bin_LPonly
#     # ./TAppDecoderStatic -b ./${SeqName[$i]}.bin -o ${SeqName[$i]}_dec.yuv > ./${SeqName[$i]}_dec_LPonly.log
#     # cd $basedir/bin_LBLP
#     # ./TAppDecoderStatic -b ./${SeqName[$i]}.bin -o ${SeqName[$i]}_dec.yuv > ./${SeqName[$i]}_dec_LBLP.log
# done
