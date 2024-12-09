*day 4;
filename input "./sas-aoc-2024/day4/day4_input.txt";

*part 1;
data wordsearch;
    infile input;
    length row $ 200;
    input row;
run;

data d4 (keep=part1 part2);
    set wordsearch end=last;
    length prev_row prev2_row prev3_row $ 200;
    retain prev_row prev2_row prev3_row;
    len=length(row);
    do i=1 to len;
        if substr(row,i,1)="X" then do;
            if substr(row,i,4)="XMAS" then do;
                part1+1;
            end;
            if substr(prev_row,i,1)="M" and substr(prev2_row,i,1)="A" and
                substr(prev3_row,i,1)="S" then do;
                part1+1;
            end;
            if i >= 1+3 and substr(prev_row,i-1,1)="M" and
                substr(prev2_row,i-2,1)="A" and substr(prev3_row,i-3,1)="S" then
                do;
                part1+1;
            end;
            if i <= len-3 and substr(prev_row,i+1,1)="M" and
                substr(prev2_row,i+2,1)="A" and substr(prev3_row,i+3,1)="S" then
                do;
                part1+1;
            end;
        end;
        else if substr(row,i,1)="S" then do;
            if substr(row,i,4)="SAMX" then do;
                part1+1;
            end;
            if substr(prev_row,i,1)="A" and substr(prev2_row,i,1)="M" and
                substr(prev3_row,i,1)="X" then do;
                part1+1;
            end;
            if i >= 1+3 and substr(prev_row,i-1,1)="A" and
                substr(prev2_row,i-2,1)="M" and substr(prev3_row,i-3,1)="X" then
                do;
                part1+1;
            end;
            if i <= len-3 and substr(prev_row,i+1,1)="A" and
                substr(prev2_row,i+2,1)="M" and substr(prev3_row,i+3,1)="X" then
                do;
                part1+1;
            end;
            *part2;
            if i <= len-2 and substr(prev_row,i+1,1)="A" and substr(prev2_row,i+2,1)="M" then
                do;
                if substr(row,i+2,1)="M" and substr(prev2_row,i,1)="S" then do;
                    part2+1;
                end;
                else if substr(row,i+2,1)="S" and substr(prev2_row,i,1)="M" then
                    do;
                    part2+1;
                end;
            end;
        end;
        else if substr(row,i,1)="M" then do;
            *part2;
            if i <= len-2 and substr(prev_row,i+1,1)="A" and substr(prev2_row,i+2,1)="S" then
                do;
                if substr(row,i+2,1)="M" and substr(prev2_row,i,1)="S" then do;
                    part2+1;
                end;
                else if substr(row,i+2,1)="S" and substr(prev2_row,i,1)="M" then
                    do;
                    part2+1;
                end;
            end;
        end;
    end;
    prev3_row=prev2_row;
    prev2_row=prev_row;
    prev_row=row;
    if last then output;
run;

proc print data=d4;
run;