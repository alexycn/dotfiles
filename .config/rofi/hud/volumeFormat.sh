#!/bin/bash

vol=$(volume)
ic=$(volume -i | cut -c -3)

echo -n "<u>Volume</u>\t\t$ic\t$vol%%"
