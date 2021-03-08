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
    BasketballDrillText, ChinaSpeed,
    SlideEditing,        SlideShow,
    # FlyingGraphics,
);

open( my $logfile, ">", "VVC_vs_HEVC.csv");
print $logfile "Sequence, HEVC_Bits, HEVC_Time, VVC_Bits, VVC_Time, Ratio_Bits, x_Time\n";
$avg_ratio_bits = 0;
$avg_x_time = 0;
foreach $SeqName_name (@SeqName_list) {
    $filename_HEVC = "./bin_HEVC/" . $SeqName_name . "_enc" . "_HEVC.log";
    $filename_VVC = "./bin_VVC/" . $SeqName_name . "_enc" . "_VVC.log";

    open( f_HEVC, "<", $filename_HEVC ) or die "未找到文件 $filename_HEVC";
    @lines_HEVC = <f_HEVC>;
    open( f_VVC, "<", $filename_VVC ) or die "未找到文件 $filename_VVC";
    @lines_VVC = <f_VVC>;

    foreach $line_HEVC (@lines_HEVC) {
        if ( $line_HEVC =~ /\s*[\d\.]+(?=\ bits\ \[Y\ 99)/ ) {
            $Bits_HEVC = $&;
        }
        elsif ( $line_HEVC =~ /(?<=\ Total\ Time:)\s*[\d\.]+/ ) {
            $enc_time_HEVC = $&;
            break;
        }
    }
    close(f_HEVC) or die "无法关闭文件 $filename_HEVC";

    foreach $line_VVC (@lines_VVC) {
        if ( $line_VVC =~ /\s*[\d\.]+(?=\ bits\ \[Y\ 99)/ ) {
            $Bits_VVC = $&;
        }
        elsif ( $line_VVC =~ /(?<=\ Total\ Time:)\s*[\d\.]+/ ) {
            $enc_time_VVC = $&;
            break;
        }
    }
    close(f_VVC) or die "无法关闭文件 $filename_VVC";

    print $logfile $SeqName_name;
    print $logfile ",";
    print $logfile $Bits_HEVC;
    print $logfile ",";
    print $logfile $enc_time_HEVC;
    print $logfile ",";
    print $logfile $Bits_VVC;
    print $logfile ",";
    print $logfile $enc_time_VVC;
    print $logfile ",";
    print $logfile ($Bits_VVC - $Bits_HEVC)/$Bits_HEVC*100;
    print $logfile ",";
    print $logfile $enc_time_VVC/$enc_time_HEVC;
    print $logfile ",";
    print $logfile "\n";

    $avg_ratio_bits = $avg_ratio_bits + ($Bits_VVC - $Bits_HEVC)/$Bits_HEVC*100/(1+$#{SeqName_list});
    $avg_x_time = $avg_x_time + $enc_time_VVC/$enc_time_HEVC/(1+$#{SeqName_list});
}
print $logfile "AVG";
print $logfile ",";
print $logfile "-";
print $logfile ",";
print $logfile "-";
print $logfile ",";
print $logfile "-";
print $logfile ",";
print $logfile "-";
print $logfile ",";
print $logfile $avg_ratio_bits;
print $logfile ",";
print $logfile $avg_x_time;
print $logfile ",";
close(logfile);
