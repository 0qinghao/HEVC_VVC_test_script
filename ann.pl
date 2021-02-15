#!/usr/bin/perl
@cfg_list = (
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
    SlideEditing,        SlideShow
);

# @cfg_list = ( BasketballPass, SlideEditing );

# @dir_list = ( "./bin_src/", "./bin_scan/", "./bin_LPonly/", "./bin_LBLP/" );
# @app_list = ( "_src.log",   "_scan.log",   "_LPonly.log",   "_LBLP.log" );

@dir_list = ( "./bin_src/", "./bin_scan/" );
@app_list = ( "_src.log",   "_scan.log" );
# @dir_list = ( "./bin_src/", "./bin_LBLP/" );
# @app_list = ( "_src.log",   "_LBLP.log" );

# @dir_list = ("./bin_src/");
# @app_list = ("_src.log");
# @dir_list = ("./bin_LBLP/");
# @app_list = ("_LBLP.log");

foreach $index ( 0 .. $#{dir_list} ) {
    open( my $logfile, ">", $dir_list[$index] . $app_list[$index] . ".csv" );
    print $logfile "Sequence, Bytes, Encode_time, Decode_time\n";

    foreach $cfg_name (@cfg_list) {
        $filename = $dir_list[$index] . $cfg_name . "_enc" . $app_list[$index];
        open( f, "<", $filename ) or die "未找到文件 $filename";
        @lines = <f>;
        foreach $line (@lines) {
            if ( $line =~ /(?<=Bytes\ written\ to\ file:)\s*\d+/ ) {
                $Bytes = $&;
            }
            elsif ( $line =~ /(?<=\ Total\ Time:)\s*[\d\.]+/ ) {
                $enc_time = $&;
                break;
            }
        }
        close(f) or die "无法关闭文件 $filename";

       # $filename = $dir_list[$index] . $cfg_name . "_dec" . $app_list[$index];
       # open( f, "<", $filename ) or die "未找到文件 $filename";
       # @lines = <f>;
       # foreach $line (@lines) {
       #     if ( $line =~ /(?<=\ Total\ Time:)\s*[\d\.]+/ ) {
       #         $dec_time = $&;
       #         break;
       #     }
       # }
       # close(f) or die "无法关闭文件 $filename";

        print $logfile $cfg_name;
        print $logfile ",";
        print $logfile $Bytes;
        print $logfile ",";
        print $logfile $enc_time;
        print $logfile ",";

        # print $logfile $dec_time;
        print $logfile "\n";
    }

    close(logfile);
}
