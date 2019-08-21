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

cap program drop checkrange
program define checkrange
	version 15
	syntax varlist, min(integer) max(integer) [missing(string)] [missing2(string)]

end

cap program drop checkid
program define checkid
	version 15
	syntax [anything] , ID(string) [noexit]
	tempvar unique_ID
	egen `unique_ID' = tag(`id')
	qui count if `unique_ID' == 1
	tempvar total_ID
	egen `total_ID' = total(`unique_ID')
	qui local no_of_ID: di `total_ID'[1]
	if "`anything'" != ""{
		cap assert `total_ID' == `1'
		if _rc{
			di as error "The number of observations has changed! There are `no_of_ID' unique IDs now"
			if "`exit'" == ""{
				exit
			}
			else{
				di as text "no exit specified, program will not exit"
			}
		}
		if !_rc{
			di as text "The number of unqiue IDs has remained the same at `1'"
		}
	}
	if "`anything'" == ""{
		di as text "There are `no_of_ID' in this dataset."
	}
end
