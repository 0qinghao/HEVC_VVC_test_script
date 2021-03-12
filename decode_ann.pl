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

open( my $logfile, ">", "EI_vs_VVC_DecTime.csv");
print $logfile "Sequdece, VVC_Time, EI_Time, x_Time\n";
$avg_x_time = 0;
foreach $SeqName_name (@SeqName_list) {
    $filename_VVC = "./bin_VVC/" . $SeqName_name . "_dec" . "_VVC.log";
    $filename_VVC_EI = "./bin_VVC_EI/" . $SeqName_name . "_dec" . "_VVC_EI.log";

    open( f_VVC, "<", $filename_VVC ) or die "未找到文件 $filename_VVC";
    @lines_VVC = <f_VVC>;
    open( f_VVC_EI, "<", $filename_VVC_EI ) or die "未找到文件 $filename_VVC_EI";
    @lines_VVC_EI = <f_VVC_EI>;

    foreach $line_VVC (@lines_VVC) {
        if ( $line_VVC =~ /(?<=\ Total\ Time:)\s*[\d\.]+/ ) {
            $dec_time_VVC = $&;
            break;
        }
    }
    close(f_VVC) or die "无法关闭文件 $filename_VVC";

    foreach $line_VVC_EI (@lines_VVC_EI) {
        if ( $line_VVC_EI =~ /(?<=\ Total\ Time:)\s*[\d\.]+/ ) {
            $dec_time_VVC_EI = $&;
            break;
        }
    }
    close(f_VVC_EI) or die "无法关闭文件 $filename_VVC_EI";

    print $logfile $SeqName_name;
    print $logfile ",";
    print $logfile $dec_time_VVC;
    print $logfile ",";
    print $logfile $dec_time_VVC_EI;
    print $logfile ",";
    print $logfile $dec_time_VVC_EI/$dec_time_VVC;
    print $logfile ",";
    print $logfile "\n";

    $avg_x_time = $avg_x_time + $dec_time_VVC_EI/$dec_time_VVC/(1+$#{SeqName_list});
}
print $logfile 1+$#{SeqName_list} . "AVG";
print $logfile ",";
print $logfile "-";
print $logfile ",";
print $logfile "-";
print $logfile ",";
print $logfile $avg_x_time;
print $logfile ",";
close(logfile);
