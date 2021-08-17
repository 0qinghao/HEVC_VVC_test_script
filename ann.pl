#!/usr/bin/perl
# @SeqName_list = (
#     # Tango2,              FoodMarket4,
#     PeopleOnStreet,      Traffic,
#     BasketballDrive,     BQTerrace,
#     Cactus,              Kimono,
#     ParkScene,           BasketballDrill,
#     BQMall,              PartyScene,
#     RaceHorsesC,         BasketballPass,
#     BlowingBubbles,      BQSquare,
#     RaceHorses,          FourPeople,
#     Johnny,              KristenAndSara,
#     BasketballDrillText, ChinaSpeed,
#     SlideEditing,        SlideShow,
# );
@SeqName_list = (
   Vidyo1, Vidyo3, Vidyo4, 
);
# @SeqName_list = (
#     BasketballPass,
#     BlowingBubbles,      BQSquare,
#     SlideEditing,        SlideShow,
# );

open( my $logfile, ">", "vtm_src_lip.csv");
print $logfile "Sequence, src_filesize, src_Time, lip_filesize, lip_Time, Ratio_filesize, x_Time\n";
$avg_ratio_bits = 0;
$avg_x_time = 0;
foreach $SeqName_name (@SeqName_list) {
    print $SeqName_name;
    $filename_VVC_lip = "./bin_VVC_lip/" . $SeqName_name . "_enc" . "_VVC_lip.log";
    $filename_VVC_src = "./bin_VVC_src/" . $SeqName_name . "_enc" . "_VVC_src.log";
    $encfilename_VVC_lip = "./bin_VVC_lip/" . $SeqName_name . ".bin";
    $encfilename_VVC_src = "./bin_VVC_src/" . $SeqName_name . ".bin";

    open( f_VVC_lip, "<", $filename_VVC_lip ) or die "未找到文件 $filename_VVC_lip";
    @lines_VVC_lip = <f_VVC_lip>;
    open( f_VVC_src, "<", $filename_VVC_src ) or die "未找到文件 $filename_VVC_src";
    @lines_VVC_src = <f_VVC_src>;

    foreach $line_VVC_lip (@lines_VVC_lip) {
        if ( $line_VVC_lip =~ /(?<=\ Total\ Time:)\s*[\d\.]+/ ) {
            $enc_time_VVC_lip = $&;
            break;
        }
    }
    $filesize_VVC_lip = (stat($encfilename_VVC_lip))[7];
    close(f_VVC_lip) or die "无法关闭文件 $filename_VVC_lip";

    foreach $line_VVC_src (@lines_VVC_src) {
        if ( $line_VVC_src =~ /(?<=\ Total\ Time:)\s*[\d\.]+/ ) {
            $enc_time_VVC_src = $&;
            break;
        }
    }
    $filesize_VVC_src = (stat($encfilename_VVC_src))[7];
    close(f_VVC_src) or die "无法关闭文件 $filename_VVC_src";

    print $logfile $SeqName_name;
    print $logfile ",";
    print $logfile $filesize_VVC_src;
    print $logfile ",";
    print $logfile $enc_time_VVC_src;
    print $logfile ",";
    print $logfile $filesize_VVC_lip;
    print $logfile ",";
    print $logfile $enc_time_VVC_lip;
    print $logfile ",";
    print $logfile ($filesize_VVC_lip - $filesize_VVC_src)/$filesize_VVC_src*100;
    print $logfile ",";
    print $logfile $enc_time_VVC_lip/$enc_time_VVC_src;
    print $logfile ",";
    print $logfile "\n";

    $avg_ratio_bits = $avg_ratio_bits + ($filesize_VVC_lip - $filesize_VVC_src)/$filesize_VVC_src*100/(1+$#{SeqName_list});
    $avg_x_time = $avg_x_time + $enc_time_VVC_lip/$enc_time_VVC_src/(1+$#{SeqName_list});
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
