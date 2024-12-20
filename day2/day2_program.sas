*day 2;
filename input "./sas-aoc-2024/day2/day2_input.txt";

*part 1;
data reports;
    infile input delimiter=",";
    length levels $32;
    input levels;
    output;
run;

data part1(keep=part1);
    set reports end=last;
    length prev_level level all_inc all_dec part1 3;
    all_inc=1;
    all_dec=1;
    do i=1 by 1 while (scan(levels, i, " ") ne "");
        level=input(scan(levels, i, " "), BEST.);
        if (i>1) then do;
            if (abs(level-prev_level) < 1 or abs(level-prev_level) > 3) then do;
                return;
            end;
            if (level > prev_level) then all_dec=0;
            if (level < prev_level) then all_inc=0;
        end;
        prev_level=level;
    end;
    if (all_inc or all_dec) then part1+1;
    if last then output;
run;

proc print data=part1 noobs;
run;

*part2;
proc fcmp outlib=work.funcs.aoc;
    function isSafe(levels$);
        all_inc=1;
        all_dec=1;
        level_count=countw(levels, " ");
        do i=1 to level_count;
            level=input(scan(levels, i, " "), BEST.);
            if (i>1) then do;
                if (abs(level-prev_level) < 1 or abs(level-prev_level) > 3) then do;
                    return(0);
                end;
                if (all_dec and level > prev_level) then do;
                    all_dec=0;
                end;
                if (all_inc and level < prev_level) then do;
                    all_inc=0;
                end;
            end;
            prev_level=level;
        end;
        if (all_inc or all_dec) then return(1);
        else return(0);
    endsub;
run;

option CMPLIB=work.funcs;

data part2(keep=part2);
    set reports end=last;
    length sub_levels $ 32;
    dampened=0;
    safe=isSafe(levels);
    if (not safe) then do;
        level_count=countw(levels, " ");
        do i=1 to level_count;
            sub_levels="";
            do j=1 to level_count;
                if j ne i then do;
                    level=scan(levels, j, " ");
                    sub_levels=catx(" ", sub_levels, level);
                end;
            end;
            sub_safe = isSafe(sub_levels);
            if (not dampened and sub_safe) then do;
                safe=1;
                leave;
            end;
            else if (sub_safe) then dampened=1;
        end;
    end;
    if (safe) then part2+1;
    if last then output;
run;

proc print data=part2 noobs;
run;
