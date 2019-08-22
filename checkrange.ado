*! checkobs version 1.0.0
cap program drop checkrange
program define checkrange
	version 15
	syntax varlist, min(integer) max(integer) [missing(string)] [missing2(string)]

end
