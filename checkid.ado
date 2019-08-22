*1 checkobs version 1.0.0 
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
