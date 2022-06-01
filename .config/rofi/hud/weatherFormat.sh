#!/bin/bash

str=$(curl "wttr.in/?format="%c_%t_%m_%M_%p_%h_%P_%S_%s"&m" 2> /dev/null)

wtr_ic=$(echo "$str" | cut -d'_' -f1 | cut -d' ' -f1)
wtr=$(echo "$str" | cut -d'_' -f2-2)

#prcp=$(echo "$str" | cut -d'_' -f5-5)

sRise=$(echo "$str" | cut -d'_' -f8-8)
sSet=$(echo "$str" | cut -d'_' -f9-9)

#echo -n "<u>Local Stats</u>\n
#<u>Weather</u>\t$wtr_ic\t$wtr\n
#<u>Precipitation</u>\t\t$prcp\n
#<u>Sun</u>\t\t \t$sRise $sSet\n
#"

echo -n "<u>Local Stats</u>\n
<u>Weather</u>\t$wtr_ic\t$wtr\n
<u>Sun</u>\t\t \t$sRise $sSet\n
"