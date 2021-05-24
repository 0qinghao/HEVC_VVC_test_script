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

open( my $logfile, ">", "hevc_vvc_vvenc.csv");
# print $logfile "Sequence, HEVC_filesize, HEVC_Time, VVC_filesize, VVC_Time, Ratio_filesize, x_Time\n";
print $logfile "Sequence, HEVC_filesize, HEVC_Time, VVC_filesize, VVC_Time, vvenc_filesize, vvenc_Time\n";
# $avg_ratio_bits = 0;
# $avg_x_time = 0;
foreach $SeqName_name (@SeqName_list) {
    $filename_HEVC = "./bin_HEVC/" . $SeqName_name . "_enc" . "_HEVC.log";
    $filename_VVC = "./bin_VVC/" . $SeqName_name . "_enc" . "_VVC.log";
    $filename_vvenc = "./bin_vvenc/" . $SeqName_name . "_enc" . "_vvenc.log";
    $encfilename_HEVC = "./bin_HEVC/" . $SeqName_name . ".bin";
    $encfilename_VVC = "./bin_VVC/" . $SeqName_name . ".bin";
    $encfilename_vvenc = "./bin_vvenc/" . $SeqName_name . ".bin";

    open( f_HEVC, "<", $filename_HEVC ) or die "未找到文件 $filename_HEVC";
    @lines_HEVC = <f_HEVC>;
    open( f_VVC, "<", $filename_VVC ) or die "未找到文件 $filename_VVC";
    @lines_VVC = <f_VVC>;
    open( f_vvenc, "<", $filename_vvenc ) or die "未找到文件 $filename_vvenc";
    @lines_vvenc = <f_vvenc>;

    foreach $line_HEVC (@lines_HEVC) {
        if ( $line_HEVC =~ /(?<=\ Total\ Time:)\s*[\d\.]+/ ) {
            $enc_time_HEVC = $&;
            break;
        }
    }
    $filesize_HEVC = (stat($encfilename_HEVC))[7];
    close(f_HEVC) or die "无法关闭文件 $filename_HEVC";

    foreach $line_VVC (@lines_VVC) {
        if ( $line_VVC =~ /(?<=\ Total\ Time:)\s*[\d\.]+/ ) {
            $enc_time_VVC = $&;
            break;
        }
    }
    $filesize_VVC = (stat($encfilename_VVC))[7];
    close(f_VVC) or die "无法关闭文件 $filename_VVC";

    foreach $line_vvenc (@lines_vvenc) {
        if ( $line_vvenc =~ /(?<=\ Total\ Time:)\s*[\d\.]+/ ) {
            $enc_time_vvenc = $&;
            break;
        }
    }
    $filesize_vvenc = (stat($encfilename_vvenc))[7];
    close(f_vvenc) or die "无法关闭文件 $filename_vvenc";

    print $logfile $SeqName_name;
    print $logfile ",";
    print $logfile $filesize_HEVC;
    print $logfile ",";
    print $logfile $enc_time_HEVC;
    print $logfile ",";
    print $logfile $filesize_VVC;
    print $logfile ",";
    print $logfile $enc_time_VVC;
    print $logfile ",";
    print $logfile $filesize_vvenc;
    print $logfile ",";
    print $logfile $enc_time_vvenc;
    print $logfile ",";
    # print $logfile ($filesize_VVC - $filesize_HEVC)/$filesize_HEVC*100;
    # print $logfile ",";
    # print $logfile $enc_time_VVC/$enc_time_HEVC;
    # print $logfile ",";
    print $logfile "\n";

    # $avg_ratio_bits = $avg_ratio_bits + ($filesize_VVC - $filesize_HEVC)/$filesize_HEVC*100/(1+$#{SeqName_list});
    # $avg_x_time = $avg_x_time + $enc_time_VVC/$enc_time_HEVC/(1+$#{SeqName_list});
}
# print $logfile "AVG";
# print $logfile ",";
# print $logfile "-";
# print $logfile ",";
# print $logfile "-";
# print $logfile ",";
# print $logfile "-";
# print $logfile ",";
# print $logfile "-";
# print $logfile ",";
# print $logfile $avg_ratio_bits;
# print $logfile ",";
# print $logfile $avg_x_time;
# print $logfile ",";
close(logfile);
