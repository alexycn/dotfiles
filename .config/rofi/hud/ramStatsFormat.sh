#!/bin/bash

ramUse=$(ramUsage -p | cut -d'%' -f1)

echo -n "<u>RAM Usage</u>\t\t$ramUse%% ($(ramUsage) MB)"
