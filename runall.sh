# cfg_name=(wsl_BasketballPass wsl_SlideEditing)
cfg_name=(BasketballDrill BlowingBubbles Cactus Kimono PartyScene SlideEditing Vidyo1 BasketballDrillText BQMall ChinaSpeed KristenAndSara PeopleOnStreet SlideShow Vidyo3 BasketballDrive BQSquare FourPeople RaceHorsesC Vidyo4 BasketballPass BQTerrace Johnny ParkScene RaceHorses Traffic)

for i in "${!cfg_name[@]}";
do
    # ../bin/TAppEncoderStatic -c ../cfg/encoder_intra_main_LL.cfg -c ../cfg/per-sequence/${cfg_name[$i]}.cfg --FramesToBeEncoded=1 > ${cfg_name[$i]}.log
    ../bin/TAppEncoderStatic -c ../cfg/encoder_intra_main_LL.cfg -c ../cfg/per-sequence/${cfg_name[$i]}.cfg  > ${cfg_name[$i]}.log
done