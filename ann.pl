#!/usr/bin/perl
@SeqName_list = (
    # PeopleOnStreet,      Traffic,

    # BasketballDrive,     BQTerrace,
    # Cactus,              Kimono,
    # ParkScene,           

    BasketballDrill,     BQMall,
    PartyScene,          RaceHorsesC,

    BasketballPass,      BlowingBubbles,      
    BQSquare,            RaceHorses,
    
    FourPeople,          Johnny,
    KristenAndSara,

    BasketballDrillText, ChinaSpeed,
    SlideEditing,        SlideShow,
);
@QP_list = (22, 27, 32, 37);

open( my $logfile, ">", "hevc_vvc_vvenc.csv");

print $logfile "HM Part\n";
print $logfile "Sequence, QP, kbps, Ypsnr, Upsnr, Vpsnr, EncTime\n";
foreach $SeqName_name (@SeqName_list) {
    foreach $QP (@QP_list) {
        $logfilename_HM = "./bin_HEVC/" . $SeqName_name . "_qp" . $QP . "_enc" . "_HEVC.log";
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

print $logfile "VTM Part\n";
print $logfile "Sequence, QP, kbps, Ypsnr, Upsnr, Vpsnr, EncTime\n";
foreach $SeqName_name (@SeqName_list) {
    foreach $QP (@QP_list) {
        $logfilename_VTM = "./bin_VVC/" . $SeqName_name . "_qp" . $QP . "_enc" . "_VVC.log";
        open( f_VTM, "<", $logfilename_VTM ) or die "未找到文件 $logfilename_VTM";
        @lines_VTM = <f_VTM>;
        foreach $line_VTM (@lines_VTM) {
            if ($next_2_line_log == 1)
            {
                $next_1_line_log = 1;
                $next_2_line_log = 0;
            }
            if ($line_VTM =~ /LayerId\s{2}0/ ) {
                $next_2_line_log = 1;
            }
            if ($next_1_line_log == 1) {
                if ($line_VTM =~ /([\d\.]+\s+){4}/ ) {
                    $VTM_kbpsYUVpsnr = $&;
                    $VTM_kbpsYUVpsnr =~ s/\s+/,/g;
                    # print $VTM_kbpsYUVpsnr;
                    $next_1_line_log = 0;
                }
            }
            elsif ( $line_VTM =~ /(?<=\ Total\ Time:)\s*[\d\.]+/ ) {
                $VTM_EncTime = $&;
                $VTM_EncTime =~ s/\s+//g;
                # print $VTM_EncTime;
                break;
            }
        }
        close(f_VTM) or die "无法关闭文件 $logfilename_VTM";
        print $logfile $SeqName_name;
        print $logfile ",";
        print $logfile $QP;
        print $logfile ",";
        print $logfile $VTM_kbpsYUVpsnr;
        print $logfile $VTM_EncTime;
        print $logfile "\n";
    }
}

@vvenc_level_list = (slow, medium, fast, faster);
foreach $vvenc_level (@vvenc_level_list) {
    print $logfile "VVenC " . $vvenc_level . " Part\n";
    print $logfile "Sequence, QP, kbps, Ypsnr, Upsnr, Vpsnr, EncTime\n";
    foreach $SeqName_name (@SeqName_list) {
        foreach $QP (@QP_list) {
            $logfilename_VVenC = "./bin_vvenc/" . $SeqName_name . "_qp" . $QP . "_" . $vvenc_level . "_enc" . "_vvenc.log";
            open( f_VVenC, "<", $logfilename_VVenC ) or die "未找到文件 $logfilename_VVenC";
            @lines_VVenC = <f_VVenC>;
            foreach $line_VVenC (@lines_VVenC) {
                if ($line_VVenC =~ /Total Frames/ ) {
                    $next_1_line_log = 1;
                }
                if ($next_1_line_log == 1) {
                    if ($line_VVenC =~ /([\d\.]+\s+){4}/ ) {
                        $VVenC_kbpsYUVpsnr = $&;
                        $VVenC_kbpsYUVpsnr =~ s/\s+/,/g;
                        # print $VVenC_kbpsYUVpsnr;
                        $next_1_line_log = 0;
                    }
                }
                elsif ( $line_VVenC =~ /(?<=\ Total\ Time:)\s*[\d\.]+/ ) {
                    $VVenC_EncTime = $&;
                    $VVenC_EncTime =~ s/\s+//g;
                    # print $VVenC_EncTime;
                    break;
                }
            }
            close(f_VVenC) or die "无法关闭文件 $logfilename_VVenC";
            print $logfile $SeqName_name;
            print $logfile ",";
            print $logfile $QP;
            print $logfile ",";
            print $logfile $VVenC_kbpsYUVpsnr;
            print $logfile $VVenC_EncTime;
            print $logfile "\n";
        }
    }
}

close(logfile);
