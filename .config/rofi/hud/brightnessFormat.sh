#!/bin/bash

br=$(brightness)
ic=$(brightness -i | cut -c -3)

echo -n "<u>Brightness</u>\t$ic\t$br%%"
