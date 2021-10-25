#!/bin/bash

SeqName=(10_outdoor_dusk_cross_lightvar_1920x1088 7_indoor_night_noPeople_1920x1088 outdoor_day_8M_1920x1088_872frames 12_indoor_day_OnePeopleSitting_1920x1088 8_outdoor_day_road_many_cars_1920x1088 outdoor_day_cross_clip_global_light_change2_1920x1088_1000frames 13_outdoor_day_road_pixelmove_1920x1088 9_indoor_day_canteen_1920x1088 outdoor_night_8M_1920x1088 1_outdoor_day_cross_1920x1088 hk_floor_12M_1920x1088 outdoor_wdroff_8M_1920x1088 2_outdoor_dusk_cross_1920x1088 indoor1_54db_wdroff_NR50_8M_1920x1088 question_IFlicker_1_1920x1088_673frames 3_outdoor_night_cross_1920x1088 indoor_54db_wdroff_NR35_8fps_8M_1920x1088_1399frames question_IFlicker_2_1920x1088_1400frames 4_indoor_night_onePeopleMoving_1920x1088 indoor_54db_wdroff_NR40_8fps_8M_1920x1088_1397frames red_car2_1920x1088 5_outdoor_day_rain_cross_1920x1088 indoor_54db_wdroff_NR45_8fps_8M_1920x1088 6_outdoor_day_road_fewcars_1920x1088 outdoor_day02_1920x1088)
# SeqName=(outdoor_day_8M_1920x1088_872frames hk_floor_12M_1920x1088 question_IFlicker_1_1920x1088_673frames question_IFlicker_2_1920x1088_1400frames indoor_54db_wdroff_NR45_8fps_8M_1920x1088)
qplist=(37 41 45 49)

test_1_frame=0
if [ $test_1_frame -eq 1 ]; then
    para="--FramesToBeEncoded=1"
else
    para=""
fi

basedir=$(pwd)

for i in "${!SeqName[@]}"; do
    for qpind in "${!qplist[@]}"; do
        {
            echo "Encoding "${SeqName[$i]}

            cd $basedir/bin_HEVC_noTS
            ./TAppEncoderStatic -c ../cfg_FH420/encoder_intra_main_MOL.cfg -c ../cfg_FH420/per-sequence/${SeqName[$i]}.cfg --BitstreamFile=${SeqName[$i]}_qp${qplist[$qpind]}.bin --ReconFile=${SeqName[$i]}_qp${qplist[$qpind]}_rec.yuv $para --QP=${qplist[$qpind]} --TransformSkip=0 >./${SeqName[$i]}_qp${qplist[$qpind]}_enc_noTS.log &
            cd $basedir/bin_HEVC_src
            ./TAppEncoderStatic -c ../cfg_FH420/encoder_intra_main_MOL.cfg -c ../cfg_FH420/per-sequence/${SeqName[$i]}.cfg --BitstreamFile=${SeqName[$i]}_qp${qplist[$qpind]}.bin --ReconFile=${SeqName[$i]}_qp${qplist[$qpind]}_rec.yuv $para --QP=${qplist[$qpind]} >./${SeqName[$i]}_qp${qplist[$qpind]}_enc_TS.log
        }
    done
done
