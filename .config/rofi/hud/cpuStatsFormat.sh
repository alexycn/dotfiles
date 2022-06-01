#!/bin/bash

cpuUse=$(cpuUsage | cut -d'%' -f1)

echo -n "<u>CPU Info</u>\n
<u>Usage</u>\t\t\t$cpuUse%%\n
<u>Temperature</u>\t\t$(cpuTemp)"
