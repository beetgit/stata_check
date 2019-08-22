*! version 1.0.0 20190821

cap program drop checkobs
program define checkobs
	version 15
	syntax [anything], [noexit] [VARS(integer 9000)]
	if "`anything'" != ""{ // check number of observations
		cap assert _N == `1'
		if _rc{
			qui local no_of_observation: di _N
			di as error "The number of observations has changed! There are `no_of_observation' obs now"
			if "`exit'" == "" & `vars' == 9000{
				exit
			}
			else{
				di as text "no exit specified, program will not exit"
			}
		}
		if !_rc{
			di as text "The number of observations has remained the same at `anything'
		}
	}
	// Checking for variables
	if `vars' != 9000{
		cap assert c(k) == `vars'
		if _rc{
			qui local no_of_variables: di c(k)
			di as error "The number of variables has changed! There are `no_of_variables' variables now"
			if "`exit'" == ""{
				exit
			}
			else{
				di as text "no exit specified, program will not exit"
			}
		}
		if !_rc{
			di as text "No errors, there are `no_of_variables' number of variables."
		}
	}
end

