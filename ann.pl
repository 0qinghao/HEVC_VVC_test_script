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

open( my $logfile, ">", "HEVC_vs_EI.csv");
print $logfile "Sequence, HEVC_Bits, HEVC_Time, EI_Bits, EI_Time, Ratio_Bits, x_Time\n";
$avg_ratio = 0;
$avg_x_time = 0;
foreach $SeqName_name (@SeqName_list) {
    $filename_HEVC = "./bin_HEVC/" . $SeqName_name . "_enc" . "_HEVC.log";
    $filename_EI = "./bin_EI/" . $SeqName_name . "_enc" . "_EI.log";

    open( f_HEVC, "<", $filename_HEVC ) or die "未找到文件 $filename_HEVC";
    @lines_HEVC = <f_HEVC>;
    open( f_EI, "<", $filename_EI ) or die "未找到文件 $filename_EI";
    @lines_EI = <f_EI>;

    foreach $line_HEVC (@lines_HEVC) {
        if ( $line_HEVC =~ /(?<=Bytes\ written\ to\ file:)\s*\d+/ ) {
            $Bits_HEVC = $&;
        }
        elsif ( $line_HEVC =~ /(?<=\ Total\ Time:)\s*[\d\.]+/ ) {
            $enc_time_HEVC = $&;
            break;
        }
    }
    close(f_HEVC) or die "无法关闭文件 $filename_HEVC";

    foreach $line_EI (@lines_EI) {
        if ( $line_EI =~ /(?<=Bytes\ written\ to\ file:)\s*\d+/ ) {
            $Bits_EI = $&;
        }
        elsif ( $line_EI =~ /(?<=\ Total\ Time:)\s*[\d\.]+/ ) {
            $enc_time_EI = $&;
            break;
        }
    }
    close(f_EI) or die "无法关闭文件 $filename_EI";

    print $logfile $SeqName_name;
    print $logfile ",";
    print $logfile $Bits_HEVC;
    print $logfile ",";
    print $logfile $enc_time_HEVC;
    print $logfile ",";
    print $logfile $Bits_EI;
    print $logfile ",";
    print $logfile $enc_time_EI;
    print $logfile ",";
    print $logfile ($Bits_EI - $Bits_HEVC)/$Bits_HEVC*100;
    print $logfile ",";
    print $logfile $enc_time_EI/$enc_time_HEVC;
    print $logfile ",";
    print $logfile "\n";

    $avg_ratio = $avg_ratio + ($Bits_EI - $Bits_HEVC)/$Bits_HEVC*100/(1+$#{SeqName_list});
    $avg_x_time = $avg_x_time + $enc_time_EI/$enc_time_HEVC/(1+$#{SeqName_list});
}
print $logfile 1+$#{SeqName_list} . "AVG";
print $logfile ",";
print $logfile "-";
print $logfile ",";
print $logfile "-";
print $logfile ",";
print $logfile "-";
print $logfile ",";
print $logfile "-";
print $logfile ",";
print $logfile $avg_ratio;
print $logfile ",";
print $logfile $avg_x_time;
print $logfile ",";
close(logfile);
