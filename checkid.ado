*!checkobs version 1.0.0
program define checkid
	version 15
	syntax [anything] , ID(string) [noexit] [case(string)] [gen(string)]
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
		di as text "There are `no_of_ID' unique ID(s) in this dataset."
	}

	// For the case option
	if "`case'" != ""{
		tempvar unique_id_case
		qui egen `unique_id_case' = tag(`id' `case')
		tempvar number_of_cases
		qui bysort `id': egen `number_of_cases' = total(`unique_id_case')
		qui replace `number_of_cases' = . if `unique_ID' != 1
		di as text "Sum of the number of cases each ID has"
		sum `number_of_cases'
	}
	if "`case'" != "" & "`gen'" != ""{
		gen `gen' = `number_of_cases'
	}
	if "`gen'" != "" & "`case'" == ""{
		di as text "You must specify a case variable when using generate"
		}
end
