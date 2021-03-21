#!/bin/bash

# SeqName=(BasketballPass )
# SeqName_alphabet_all=(BasketballDrill BlowingBubbles Cactus Kimono PartyScene SlideEditing Vidyo1 BasketballDrillText BQMall ChinaSpeed KristenAndSara PeopleOnStreet SlideShow Vidyo3 BasketballDrive BQSquare FourPeople RaceHorsesC Vidyo4 BasketballPass BQTerrace Johnny ParkScene RaceHorses Traffic)
SeqName=(PeopleOnStreet Traffic BasketballDrive BQTerrace Cactus Kimono ParkScene BasketballDrill BQMall PartyScene RaceHorsesC BasketballPass BlowingBubbles BQSquare RaceHorses FourPeople Johnny KristenAndSara Vidyo1 Vidyo3 Vidyo4 BasketballDrillText ChinaSpeed SlideEditing SlideShow)
# SeqName=(SlideEditing SlideShow FlyingGraphics)

test_time=0
test_few_frames=1
rdpcm=1
if [ $test_few_frames -eq 1 ]; then
    # para="--FrameSkip=6 --FramesToBeEncoded=10"
    para="--FrameSkip=6 --FramesToBeEncoded=1"
    # para="--FrameSkip=6 --FramesToBeEncoded=100"
else
    para=""
fi
if [ $rdpcm -eq 1 ]; then
    rdpcmflag="--Profile=main-RExt --ImplicitResidualDPCM=1"
else
    rdpcmflag=""
fi

basedir=`pwd`

if [ $test_time -eq 0 ]; then
    for i in "${!SeqName[@]}";
    do
    {
        echo "Encoding "${SeqName[$i]}
        cd $basedir/bin_HEVC
        ./TAppEncoderStatic -c ../cfg/encoder_intra_main_LL.cfg -c ../cfg/per-sequence/${SeqName[$i]}.cfg $para $rdpcmflag > ./${SeqName[$i]}_enc_HEVC.log & 
        cd $basedir/bin_EI
        ./TAppEncoderStatic -c ../cfg/encoder_intra_main_LL.cfg -c ../cfg/per-sequence/${SeqName[$i]}.cfg $para $rdpcmflag > ./${SeqName[$i]}_enc_EI.log &
    }&
    done
else
    for i in "${!SeqName[@]}";
    {
        echo "Encoding "${SeqName[$i]}
        cd $basedir/bin_HEVC
        ./TAppEncoderStatic -c ../cfg/encoder_intra_main_LL.cfg -c ../cfg/per-sequence/${SeqName[$i]}.cfg $para $rdpcmflag > ./${SeqName[$i]}_enc_HEVC.log 
        cd $basedir/bin_EI
        ./TAppEncoderStatic -c ../cfg/encoder_intra_main_LL.cfg -c ../cfg/per-sequence/${SeqName[$i]}.cfg $para $rdpcmflag > ./${SeqName[$i]}_enc_EI.log 
    }
fi