*frage-a:

use http://fmwww.bc.edu/ec-p/data/stockwatson/caschool.dta, clear

gen  tot_exp=enrl_tot*expn_stu
egen tot_exp_count=total(tot_exp), by(county)

tab county, sum(expn_stu)

*frage-b

gen  teach_stu=teachers/enrl_tot
correlate comp_stu expn_stu teach_stu avginc el_pct testscr

*frage-c

plot testscr avginc
scatter testscr avginc
reg testscr avginc

*frage-d

gen double avginc_sq=avginc*avginc
reg testscr avginc, robust
reg testscr avginc avginc_sq, robust

*frage-e

xi: reg testscr avginc avginc_sq i.county

*frage-f:

areg testscr avginc avginc_sq, absorb(county) robust

reg testscr avginc avginc_sq teach_stu comp_stu el_pct, robust

