#!/bin/bash

# cfg_name=(BasketballPass SlideEditing)
# cfg_name_alphabet_all=(BasketballDrill BlowingBubbles Cactus Kimono PartyScene SlideEditing Vidyo1 BasketballDrillText BQMall ChinaSpeed KristenAndSara PeopleOnStreet SlideShow Vidyo3 BasketballDrive BQSquare FourPeople RaceHorsesC Vidyo4 BasketballPass BQTerrace Johnny ParkScene RaceHorses Traffic)
cfg_name=(BasketballDrive BQTerrace Cactus Kimono ParkScene )

test_1_frame=0
if [ $test_1_frame -eq 1 ]; then
    para="--FramesToBeEncoded=10"
    # para="--FramesToBeEncoded=1"
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
    ./TAppEncoderStatic -c ../cfg/encoder_intra_main_LL.cfg -c ../cfg/per-sequence/${cfg_name[$i]}.cfg $para > ./${cfg_name[$i]}_enc_src.log
    cd $basedir/bin_LBonly
    ./TAppEncoderStatic -c ../cfg/encoder_intra_main_LL.cfg -c ../cfg/per-sequence/${cfg_name[$i]}.cfg $para > ./${cfg_name[$i]}_enc_LBonly.log
    cd $basedir/bin_LPonly
    ./TAppEncoderStatic -c ../cfg/encoder_intra_main_LL.cfg -c ../cfg/per-sequence/${cfg_name[$i]}.cfg $para > ./${cfg_name[$i]}_enc_LPonly.log
    cd $basedir/bin_LBLP
    ./TAppEncoderStatic -c ../cfg/encoder_intra_main_LL.cfg -c ../cfg/per-sequence/${cfg_name[$i]}.cfg $para > ./${cfg_name[$i]}_enc_LBLP.log
}&
done

wait

# for i in "${!cfg_name[@]}";
# do
#     echo "Decoding "${cfg_name[$i]}
#     cd $basedir/bin_src
#     ./TAppDecoderStatic -b ./${cfg_name[$i]}.bin -o ${cfg_name[$i]}_dec.yuv > ./${cfg_name[$i]}_dec_src.log
#     # cd $basedir/bin_LBonly
#     # ./TAppDecoderStatic -b ./${cfg_name[$i]}.bin -o ${cfg_name[$i]}_dec.yuv > ./${cfg_name[$i]}_dec_LBonly.log
#     # cd $basedir/bin_LPonly
#     # ./TAppDecoderStatic -b ./${cfg_name[$i]}.bin -o ${cfg_name[$i]}_dec.yuv > ./${cfg_name[$i]}_dec_LPonly.log
#     # cd $basedir/bin_LBLP
#     # ./TAppDecoderStatic -b ./${cfg_name[$i]}.bin -o ${cfg_name[$i]}_dec.yuv > ./${cfg_name[$i]}_dec_LBLP.log
# done
