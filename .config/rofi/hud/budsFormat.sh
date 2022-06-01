#!/bin/bash

buds=$(galaxyBuds)
lBud=$(echo $buds | cut -d' ' -f2 | cut -d'%' -f1)
rBud=$(echo $buds | cut -d' ' -f5 | cut -d'%' -f1)
if [[ $buds == "" ]]; then
    cond=""
else
    cond="%%"
fi
echo -n "<u>Buds Charge</u>\t\tL: $lBud$cond | R: $rBud$cond"
