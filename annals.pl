#!/usr/bin/perl
@SeqName_list=(
    "10_outdoor_dusk_cross_lightvar_1920x1088", "7_indoor_night_noPeople_1920x1088", "outdoor_day_8M_1920x1088_872frames", "12_indoor_day_OnePeopleSitting_1920x1088", "8_outdoor_day_road_many_cars_1920x1088", "outdoor_day_cross_clip_global_light_change2_1920x1088_1000frames", "13_outdoor_day_road_pixelmove_1920x1088", "9_indoor_day_canteen_1920x1088", "outdoor_night_8M_1920x1088", "1_outdoor_day_cross_1920x1088", "hk_floor_12M_1920x1088", "outdoor_wdroff_8M_1920x1088", "2_outdoor_dusk_cross_1920x1088", "indoor1_54db_wdroff_NR50_8M_1920x1088", "question_IFlicker_1_1920x1088_673frames", "3_outdoor_night_cross_1920x1088", "indoor_54db_wdroff_NR35_8fps_8M_1920x1088_1399frames", "question_IFlicker_2_1920x1088_1400frames", "4_indoor_night_onePeopleMoving_1920x1088", "indoor_54db_wdroff_NR40_8fps_8M_1920x1088_1397frames", "red_car2_1920x1088", "5_outdoor_day_rain_cross_1920x1088", "indoor_54db_wdroff_NR45_8fps_8M_1920x1088", "6_outdoor_day_road_fewcars_1920x1088", "outdoor_day02_1920x1088"
);
# outdoor_day_8M_1920x1088_872frames,hk_floor_12M_1920x1088,question_IFlicker_1_1920x1088_673frames,question_IFlicker_2_1920x1088_1400frames,indoor_54db_wdroff_NR45_8fps_8M_1920x1088
@QP_list = (37, 41, 45, 49);

open( my $logfile, ">", "TS_noTS.csv");

print $logfile "TS Part\n";
print $logfile "Sequence, QP, kbps, Ypsnr, Upsnr, Vpsnr, EncTime\n";
foreach $SeqName_name (@SeqName_list) {
    foreach $QP (@QP_list) {
        $logfilename_HM = "./bin_HEVC_src/" . $SeqName_name . "_qp" . $QP . "_enc" . "_TS.log";
        open( f_HM, "<", $logfilename_HM ) or die "未找到文件 $logfilename_HM";
        @lines_HM = <f_HM>;
        foreach $line_HM (@lines_HM) {
            if ($next_2_line_log == 1)
            {
                $next_1_line_log = 1;
                $next_2_line_log = 0;
            }
            if ($line_HM =~ /SUMMARY/ ) {
                $next_2_line_log = 1;
            }
            if ($next_1_line_log == 1) {
                if ($line_HM =~ /([\d\.]+\s+){4}/ ) {
                    $HM_kbpsYUVpsnr = $&;
                    $HM_kbpsYUVpsnr =~ s/\s+/,/g;
                    # print $HM_kbpsYUVpsnr;
                    $next_1_line_log = 0;
                }
            }
            elsif ( $line_HM =~ /(?<=\ Total\ Time:)\s*[\d\.]+/ ) {
                $HM_EncTime = $&;
                $HM_EncTime =~ s/\s+//g;
                # print $HM_EncTime;
                break;
            }
        }
        close(f_HM) or die "无法关闭文件 $logfilename_HM";
        print $logfile $SeqName_name;
        print $logfile ",";
        print $logfile $QP;
        print $logfile ",";
        print $logfile $HM_kbpsYUVpsnr;
        print $logfile $HM_EncTime;
        print $logfile "\n";
    }
}

print $logfile "noTS Part\n";
print $logfile "Sequence, QP, kbps, Ypsnr, Upsnr, Vpsnr, EncTime\n";
foreach $SeqName_name (@SeqName_list) {
    foreach $QP (@QP_list) {
        $logfilename_VTM = "./bin_HEVC_noTS/" . $SeqName_name . "_qp" . $QP . "_enc" . "_noTS.log";
        open( f_HM, "<", $logfilename_VTM ) or die "未找到文件 $logfilename_VTM";
        @lines_HM = <f_HM>;
        foreach $line_HM (@lines_HM) {
            if ($next_2_line_log == 1)
            {
                $next_1_line_log = 1;
                $next_2_line_log = 0;
            }
            if ($line_HM =~ /SUMMARY/ ) {
                $next_2_line_log = 1;
            }
            if ($next_1_line_log == 1) {
                if ($line_HM =~ /([\d\.]+\s+){4}/ ) {
                    $HM_kbpsYUVpsnr = $&;
                    $HM_kbpsYUVpsnr =~ s/\s+/,/g;
                    # print $HM_kbpsYUVpsnr;
                    $next_1_line_log = 0;
                }
            }
            elsif ( $line_HM =~ /(?<=\ Total\ Time:)\s*[\d\.]+/ ) {
                $HM_EncTime = $&;
                $HM_EncTime =~ s/\s+//g;
                # print $HM_EncTime;
                break;
            }
        }
        close(f_HM) or die "无法关闭文件 $logfilename_HM";
        print $logfile $SeqName_name;
        print $logfile ",";
        print $logfile $QP;
        print $logfile ",";
        print $logfile $HM_kbpsYUVpsnr;
        print $logfile $HM_EncTime;
        print $logfile "\n";
    }
}

close(logfile);
