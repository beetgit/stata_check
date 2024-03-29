*! checkobs version 1.0.0
program define checkrange
	version 15
	syntax varlist, min(integer) max(integer) [missing(string)] [noexit]
	/* Initial set-up */
	if "`exit'" == "exit" {
		local noexit = 1
	}
	if "`exit'" == ""{
		local noexit = 0
	}
	local varlist_length = `:word count `varlist''
	token `varlist'
	foreach v of varlist `varlist'{
		// Setting up list of missing variiables
		foreach mis in `missing'{
			tempvar missing
			gen `missing' = 1 if `v' == `mis'
		}
		// Assert to check if in range or acceptable missing input
		cap assert `v' >= `min' & `v' <= `max' | `missing' == 1
		local error_here = 0
			// if the assert fails
			if _rc{
				di as error "`v' is not in the ranges of `min' to `max'
				if `noexit' == 1{
					di as text "No exit option was chosen, program will continue on"
				}
				if `noexit' == 0 & "`v'" != ``varlist_length''{
					di as text "moving on to next var"
					local error_here = 1
				}
				if `noexit' == 0 & "`v'" == ``varlist_length''{
					di as text "End of varlist reached"
					exit
				}
			}
 			// If assert passes
			if !_rc{
				di as text "`v' is within specified range"
				if `noexit' == 0 & `error_here' == 1{
					di as text "Varlist finished, there were errors found in the list"
					exit
					}
			}
		}
end
