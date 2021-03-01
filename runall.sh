#!/bin/bash

# cfg_name=(BasketballPass SlideEditing)
# cfg_name_alphabet_all=(BasketballDrill BlowingBubbles Cactus Kimono PartyScene SlideEditing Vidyo1 BasketballDrillText BQMall ChinaSpeed KristenAndSara PeopleOnStreet SlideShow Vidyo3 BasketballDrive BQSquare FourPeople RaceHorsesC Vidyo4 BasketballPass BQTerrace Johnny ParkScene RaceHorses Traffic)
cfg_name=(PeopleOnStreet Traffic BasketballDrive BQTerrace Cactus Kimono ParkScene BasketballDrill BQMall PartyScene RaceHorsesC BasketballPass BlowingBubbles BQSquare RaceHorses FourPeople Johnny KristenAndSara BasketballDrillText ChinaSpeed SlideEditing SlideShow)

test_1_frame=1
if [ $test_1_frame -eq 1 ]; then
    # para="--FramesToBeEncoded=10"
    para="--FramesToBeEncoded=1"
    # para="--FramesToBeEncoded=200"
else
    para=""
fi

basedir=`pwd`

for i in "${!cfg_name[@]}";
do
{
    echo "Encoding "${cfg_name[$i]}
    cd $basedir/bin_src
    ./TAppEncoderStatic -c ../cfg/encoder_intra_main_LL.cfg -c ../cfg/per-sequence/${cfg_name[$i]}.cfg $para > ./${cfg_name[$i]}_enc_src.log &
    cd $basedir/bin_scan
    ./TAppEncoderStatic -c ../cfg/encoder_intra_main_LL.cfg -c ../cfg/per-sequence/${cfg_name[$i]}.cfg $para > ./${cfg_name[$i]}_enc_scan.log &
}&
done

wait

# for i in "${!cfg_name[@]}";
# do
#     echo "Decoding "${cfg_name[$i]}
#     cd $basedir/bin_src
#     ./TAppDecoderStatic -b ./${cfg_name[$i]}.bin -o ${cfg_name[$i]}_dec.yuv > ./${cfg_name[$i]}_dec_src.log
#     # cd $basedir/bin_scan
#     # ./TAppDecoderStatic -b ./${cfg_name[$i]}.bin -o ${cfg_name[$i]}_dec.yuv > ./${cfg_name[$i]}_dec_scan.log
#     # cd $basedir/bin_LPonly
#     # ./TAppDecoderStatic -b ./${cfg_name[$i]}.bin -o ${cfg_name[$i]}_dec.yuv > ./${cfg_name[$i]}_dec_LPonly.log
#     # cd $basedir/bin_LBLP
#     # ./TAppDecoderStatic -b ./${cfg_name[$i]}.bin -o ${cfg_name[$i]}_dec.yuv > ./${cfg_name[$i]}_dec_LBLP.log
# done
