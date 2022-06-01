#!/bin/bash

upTime=$(uptime | sed 's/^.* up \+\(.\+\), \+[0-9] user.*$/\1/')

echo -n "<u>Uptime</u>\t\t\t$upTime"