#!/bin/bash

DEST_FILE="/usr/lib/slack/resources/app.asar.unpacked/src/static/ssb-interop.js"
THEMES=("default" "one_dark" "low_contrast" "navy" "hot_dog_stand")

usage() {
	echo "Usage:"
	#	$0 -t <$(echo "${THEMES[@]}" | tr " " "|")>
	#	$0 -u
	echo "-t: theme to install."
	echo "${THEMES[@]}"
	echo "-u: revert to the default Slack theme."
	echo "Note: You will have to re-run this script whenever you upgrade Slack."
}

uninstall_theme() {
	for file in $DEST_FILE1 $DEST_FILE2
	do
		if [[ $(grep -c "CUSTOM THEMES CONFIG" $DEST_FILE) -gt 0 ]]
		then
			sed -i '' -e '/^\/\/ CUSTOM THEMES CONFIG$/,$d' $DEST_FILE
		fi
	done
}

install_theme() {
	curl https://raw.githubusercontent.com/bbcnkl/slack-dark-theme/master/fix.js >> $DEST_FILE
}


#if [[ "$#" -eq 0 ]]; then usage; fi
#if [[ -z "$t" ]]; then usage; fi

install_theme()

echo "Restart Slack for changes to take effect."
exit 0



