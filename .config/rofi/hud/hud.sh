#!/usr/bin/env bash
# Requires https://github.com/OmarCastro/rofi-blocks

dir="$HOME/.config/rofi/hud"

function generateJson () {
	temp=("$@")
	for i in "${temp[@]}"; do
		echo "{\"text\":\""$i"\", \"markup\": true},"
	done
}

time0=$(date +%s)
r=0
lastWeather="Fetching weather with wttr.in..."

toggleMarkup="true"
while printf ''; do

	# Timer functionality
	timeF=$(date +%s)
	elapsed="false"
	if [[ $(( $timeF - $time0 )) > 299 || $r == 0 ]]; then
		elapsed="true"
		time0="$timeF"
	fi
	r=$(( $r + 1 ))

    # NOTE THAT WEATHER MUST BE THE LAST ENTRY!
	commands=(
		"upTimeFormat.sh"
		"cpuStatsFormat.sh"
		"ramStatsFormat.sh"
		"rotLockFormat.sh"
		"brightnessFormat.sh"
		"volumeFormat.sh"
		"budsFormat.sh"
		"weatherFormat.sh"
	)

	len=${#commands[@]}
	for ((i=0;i<len;i++)); do
		commands[i]="$dir/${commands[i]}"
	done

	# If not enough time omit the weather command call
	if [[ $elapsed == "false" ]]; then
		commands[-1]="echo \"{\"text\":\"placeholder\"},\""
	fi

	output=$(parallel -k bash -c  {1} ';' echo "^" ::: "${commands[@]}")
	output=$(echo $output | sed 's/\^ /\^/g')

	lines=$(echo "$output" | tr "^" "\n")

	arr=()

	while read -r line; do
		arr+=("$line")
	done <<< "$lines"

	# Use old weather data if not enough time has passed
	if [[ $elapsed == "false" ]]; then
		arr[-1]="$lastWeather"
	else
		lastWeather="${arr[-1]}"
	fi

	json=$(generateJson "${arr[@]}")

    TEXT=$(cat <<EOF | sed 's/\\/\\\\/g' | tr -d "\n" | tr -d "\t"
{
	"prompt": "Logged in as $USER on $HOSTNAME",
	"lines":[
		$json
		{"text":">$\t<i>Launcher</i>", "markup": true, "data": "launcher"},
		{"text":">$\t<i>Powermenu</i>", "markup": true, "data": "powermenu"}
	]}
EOF
)

	if ! printf "$TEXT\n"; then
		exit 1;
	fi
 	sleep 1;
 	if [ "$toggleMarkup" = "true" ]; then toggleMarkup="false"; else toggleMarkup="true"; fi

done | rofi -theme $dir/hud.rasi -modi blocks -show blocks -blocks-wrap "$@" 2> /dev/null

