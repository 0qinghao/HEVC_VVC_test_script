#!/usr/bin/perl
@SeqName_list = (
    PeopleOnStreet,      Traffic,
    BasketballDrive,     BQTerrace,
    Cactus,              Kimono,
    ParkScene,           BasketballDrill,
    BQMall,              PartyScene,
    RaceHorsesC,         BasketballPass,
    BlowingBubbles,      BQSquare,
    RaceHorses,          FourPeople,
    Johnny,              KristenAndSara,
    Vidyo1, Vidyo3, Vidyo4,
    BasketballDrillText, ChinaSpeed,
    SlideEditing,        SlideShow,
);

open( my $logfile, ">", "EI_vs_VVC.csv");
print $logfile "Sequence, VVC_Bits, VVC_Time, EI_Bits, EI_Time, Ratio_Bits, x_Time\n";
$avg_ratio_bitrate = 0;
$avg_x_time = 0;
foreach $SeqName_name (@SeqName_list) {
    $filename_VVC = "./bin_VVC/" . $SeqName_name . "_enc" . "_VVC.log";
    $filename_VVC_EI = "./bin_VVC_EI/" . $SeqName_name . "_enc" . "_VVC_EI.log";

    open( f_VVC, "<", $filename_VVC ) or die "未找到文件 $filename_VVC";
    @lines_VVC = <f_VVC>;
    open( f_VVC_EI, "<", $filename_VVC_EI ) or die "未找到文件 $filename_VVC_EI";
    @lines_VVC_EI = <f_VVC_EI>;

    $next_line_bitrate == 0;
    foreach $line_VVC (@lines_VVC) {
        if ( $next_line_bitrate == 1 ) {
            if ( $line_VVC =~ /(?<=\ a\ )\s*[\d\.]+/ ) {
                $Bits_VVC = $&;
            }
            $next_line_bitrate == 0;
        }
        elsif ( $line_VVC =~ /Total\ Frames\ |\ {3}Bitrate\ / ) {
            $next_line_bitrate = 1;
        }
        if ( $line_VVC =~ /(?<=\ Total\ Time:)\s*[\d\.]+/ ) {
            $enc_time_VVC = $&;
            break;
        }
    }
    close(f_VVC) or die "无法关闭文件 $filename_VVC";

    $next_line_bitrate == 0;
    foreach $line_VVC_EI (@lines_VVC_EI) {
        if ( $next_line_bitrate == 1 ) {
            if ( $line_VVC_EI =~ /(?<=\ a\ )\s*[\d\.]+/ ) {
                $Bits_VVC_EI = $&;
            }
            $next_line_bitrate == 0;
        }
        elsif ( $line_VVC_EI =~ /Total\ Frames\ |\ {3}Bitrate\ / ) {
            $next_line_bitrate = 1;
        }
        if ( $line_VVC_EI =~ /(?<=\ Total\ Time:)\s*[\d\.]+/ ) {
            $enc_time_VVC_EI = $&;
            break;
        }
    }
    close(f_VVC_EI) or die "无法关闭文件 $filename_VVC_EI";

    print $logfile $SeqName_name;
    print $logfile ",";
    print $logfile $Bits_VVC;
    print $logfile ",";
    print $logfile $enc_time_VVC;
    print $logfile ",";
    print $logfile $Bits_VVC_EI;
    print $logfile ",";
    print $logfile $enc_time_VVC_EI;
    print $logfile ",";
    print $logfile ($Bits_VVC_EI - $Bits_VVC)/$Bits_VVC*100;
    print $logfile ",";
    print $logfile $enc_time_VVC_EI/$enc_time_VVC;
    print $logfile ",";
    print $logfile "\n";

    $avg_ratio_bitrate = $avg_ratio_bitrate + ($Bits_VVC_EI - $Bits_VVC)/$Bits_VVC*100/(1+$#{SeqName_list});
    $avg_x_time = $avg_x_time + $enc_time_VVC_EI/$enc_time_VVC/(1+$#{SeqName_list});
}
print $logfile 1+$#{SeqName_list} . " AVG";
print $logfile ",";
print $logfile "-";
print $logfile ",";
print $logfile "-";
print $logfile ",";
print $logfile "-";
print $logfile ",";
print $logfile "-";
print $logfile ",";
print $logfile $avg_ratio_bitrate;
print $logfile ",";
print $logfile $avg_x_time;
print $logfile ",";
close(logfile);
