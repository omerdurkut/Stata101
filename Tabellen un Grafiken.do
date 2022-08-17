*Tabellen und Grafiken:
*Frage-2

*A:
use orig\data1.dta, clear

*B:

table state, contents(mean sqm )
tabstat sqm, statistics( mean  ) by(state)

*C:
table state, contents(mean sqm max sqm min sqm median sqm sd sqm )
tabstat sqm, statistics( mean max min sd median ) by(state)

*D:
bysort gender: table state, contents(mean sqm max sqm min sqm median sqm sd sqm )
bysort gender: tabstat sqm, statistics( mean max min sd median ) by(state)

*E:
table gender , contents(mean sqm ) 
tabstat sqm , statistics( mean  ) by(gender)

*F:
table gender , contents(mean sqm ) format(%10.2f)

*G:
table gender if hhsize==1, contents(mean sqm ) format(%10.2f)
tabstat sqm if hhsize==1, statistics( mean  ) by(gender)

*H:
table state gender, contents(mean sqm ) format(%10.2f)
by state, sort : tabstat sqm, statistics( mean  ) by(gender)

*I:

graph bar (mean) sqm, over(state)
graph bar (mean) sqm, over(state, label(angle(ninety)))

*J:
graph bar (mean) sqm, over(state, sort(sqm) descending label(angle(ninety)))

*K:
graph box sqm, over(gender, label(angle(ninety)))

*L:

graph box sqm, over(state, label(angle(forty_five)))

*M:

sum sqm if htype<.
local mean = r(mean)
graph bar sqm, over(htype, label(angle(45))) title("Mittlere Wohnfläche") subtitle("- Nach Gebäudeart -") 
note("Daten: GSOEP") ytitle(Wohnfläche in qm) yline(`mean') text(`mean' 50 "Mittelwert", placement(n) color(red))

*N:

quietly centile income if state<. , centile (20 50 80)
local p20 = r(c_1)
local p50 = r(c_2)
local p80 = r(c_3)

graph dot (p20) income (median) income (p80) income, over(state, sort(2) total )   
ytitle("Einkommen in Euro") 
yline(`p20', lcolor(blue)) yline(`p50', lcolor(red))  yline(`p80', lcolor(green)) 
title("Verschiedene Quantile der Einkommensverteilung") 
subtitle("- nach Bundesländern -") 
legend(label (1 "20 Perzentil") label(2 "Median") label(3 "80 Perzentil") col(3)) 
note("Daten: GSOEP") 
caption("Die vertikalen Linien zeigen die jeweiligen Quantile" "über alle Bundesländer")

*O:
gen l_income = log(income)

histogram l_income, normal normopts(lcolor(blue))kdensity kdenopts(lcolor(red)) 
title("Verteilung des Log-Einkommens") 
subtitle("- Histogramm mit Normalverteilung" "und Kerndichteschätzer -") 
ytitle("Dichte") 
xtitle("Einkommen in Euro") 
note("Daten: GSOEP") 
caption("Blaue Linie: Normalverteilung" "Rote Linie: Epanechnikov-Kerndichteschätzer")

*P:
use orig\inflation, clear
line inf year if country=="Germany" || line inf year if country=="France" || line inf year if country=="United Kingdom", 
legend(label(1 "Deutschland") label(2 "Frankreich") label(3 "Großbritannien") cols(3)) 
title("Inflationsraten 1970 - 2000") 
subtitle("- In Deutschland, Frankreich und Großbritannien -")  
note("Quelle: unbekannt (das sollte einem möglichst nicht passieren)")

*R:

use orig\guns.dta, clear
 twoway (line vio year if stateid==1) , saving(graphs\Grafik1)
 twoway (line vio year if stateid==2), saving(graphs\Grafik2)

 *S:
 
graph combine graphs\Grafik1.gph graphs\Grafik2.gph
graph save graphs\Grafik1und2.gph, replace
graph export graphs\Grafik1und2.wmf, replace

*T:

twoway line vio year if stateid==1 ||line vio year if stateid==2 , legend(rows(2))
twoway (line vio year if stateid==1) (line vio year if stateid==2) , legend(rows(2))
twoway (line vio year if stateid==1) (line vio year if stateid==2, sort), legend(order( 1 "State 1" 2 "State 2")) 

*U:

line vio year, sort by(stateid, total)
xtset stateid year
xtline vio
xtline vio, overlay