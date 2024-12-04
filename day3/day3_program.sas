*day 3;
filename input "./sas-aoc-2024/day3/day3_input.txt";

*part 1+2;
data program;
    infile input recfm=n lrecl=32767;
    length program $ 32767;
    input program $32767.;
run;

data day3(keep=part1 part2);
    set program;
    chars=length(program);
    i=1;
    enabled=1;
    do while(i<=chars);
        counter=0;
        if (substr(program, i, 1)="m") then do;
            if (substr(program, i+1, 1)="u") then do;
                if (substr(program, i+2, 1)="l") then do;
                    if (substr(program, i+3, 1)="(") then do;
                        firstFactor=0;
                        firstCounter=0;
                        do while (notdigit(substr(program, i+firstCounter+4,
                            1))=0);
                            firstFactor=firstFactor*10 + input(substr(program,
                                i+firstCounter+4, 1),BEST.);
                            firstCounter=firstCounter+1;
                        end;
                        counter=counter+firstCounter;
                        if (substr(program, i+firstCounter+4, 1)=",") then do;
                            secondFactor=0;
                            secondCounter=0;
                            do while (notdigit(substr(program,
                                i+secondCounter+firstCounter+5, 1))=0);
                                secondFactor=secondFactor*10 +
                                    input(substr(program,
                                    i+secondCounter+firstCounter+5, 1),BEST.);
                                secondCounter=secondCounter+1;
                            end;
                            counter=counter+secondCounter;
                            if (substr(program,
                                i+firstCounter+secondCounter+5,1)=")") then do;
                                part1+firstFactor*secondFactor;
                                if (enabled) then do;
                                    part2+firstFactor*secondFactor;
                                end;
                            end;
                            counter=counter+1;
                        end;
                        counter=counter+1;
                    end;
                    counter=counter+1;
                end;
                counter=counter+1;
            end;
            counter=counter+1;
        end;
        if (substr(program, i, 1)="d") then do;
            if (substr(program, i+1, 1)="o") then do;
                if (substr(program, i+2, 1)="n") then do;
                    if (substr(program, i+3, 1)="'") then do;
                        if (substr(program, i+4, 1)="t") then do;
                            if (substr(program, i+5, 1)="(") then do;
                                if (substr(program, i+6, 1)=")") then do;
                                    enabled=0;
                                end;
                                counter=counter+1;
                            end;
                            counter=counter+1;
                        end;
                        counter=counter+1;
                    end;
                    counter=counter+1;
                end;
                if(substr(program, i+2,1)="(") then do;
                    if(substr(program, i+3,1)=")") then do;
                        enabled=1;
                    end;
                    counter=counter+1;
                end;
                counter=counter+1;
            end;
            counter=counter+1;
        end;
        i=max(i+counter, i+1);
    end;
run;

proc print data=day3 noobs;
run;
