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

open( my $logfile, ">", "src_vs_EI.csv");
print $logfile "Sequence, src_Bits, EI_Bits, Ratio\n";
$avg_ratio = 0;
foreach $SeqName_name (@SeqName_list) {
    $filename_src = "./bin_src/" . $SeqName_name . "_enc" . "_src.log";
    $filename_EI = "./bin_EI/" . $SeqName_name . "_enc" . "_EI.log";

    open( f_src, "<", $filename_src ) or die "未找到文件 $filename_src";
    @lines_src = <f_src>;
    open( f_EI, "<", $filename_EI ) or die "未找到文件 $filename_EI";
    @lines_EI = <f_EI>;

    foreach $line_src (@lines_src) {
        if ( $line_src =~ /(?<=Bytes\ written\ to\ file:)\s*\d+/ ) {
            $Bytes_src = $&;
        }
        elsif ( $line_src =~ /(?<=\ Total\ Time:)\s*[\d\.]+/ ) {
            $enc_time_src = $&;
            break;
        }
    }
    close(f_src) or die "无法关闭文件 $filename_src";
    foreach $line_EI (@lines_EI) {
        if ( $line_EI =~ /(?<=Bytes\ written\ to\ file:)\s*\d+/ ) {
            $Bytes_EI = $&;
        }
        elsif ( $line_EI =~ /(?<=\ Total\ Time:)\s*[\d\.]+/ ) {
            $enc_time_EI = $&;
            break;
        }
    }
    close(f_EI) or die "无法关闭文件 $filename_EI";

    print $logfile $SeqName_name;
    print $logfile ",";
    print $logfile $Bytes_src;
    print $logfile ",";
    print $logfile $Bytes_EI;
    print $logfile ",";
    print $logfile ($Bytes_EI - $Bytes_src)/$Bytes_src*100;
    print $logfile ",";
    print $logfile "\n";

    $avg_ratio = $avg_ratio + ($Bytes_EI - $Bytes_src)/$Bytes_src*100/(1+$#{SeqName_list})
}
print $logfile "AVG";
print $logfile ",";
print $logfile "-";
print $logfile ",";
print $logfile "-";
print $logfile ",";
print $logfile $avg_ratio;
print $logfile ",";
close(logfile);
