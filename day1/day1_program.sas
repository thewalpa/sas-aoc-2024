*day 1;

filename input "/srv/nfs/compute/home/pathew/sas-aoc-2024/day1/day1_input.txt";

*part 1;
data left(keep=left) right(keep=right);
	infile input;
	length left 8 right 8;
	input left right;
	output left;
	output right;
run;

proc sort data=left;by left;run;
proc sort data=right;by right;run;

data result1(keep=sum);
	merge left right end=last;
	length sum 8;
	sum+(abs(left-right));
	if last then output;
run;

*part 2;
*reuse left and right input tables;
proc freq data=right noprint;
	tables right / out=right_freq(keep=right count);
run;

data temp_merge;
	merge left(rename=(left=value) in=a) right_freq(rename=(right=value));
	by value;
	if a;
run;

data result2(keep=sum);
	set temp_merge end=last;
	length sum 8;
	sum+(value*count);
	if last then output;
run;

proc print data=result1(rename=(sum=part1)) noobs; run;
proc print data=result2(rename=(sum=part2)) noobs; run;