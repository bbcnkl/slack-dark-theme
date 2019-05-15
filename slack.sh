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
	if [[ $(grep -c "CUSTOM THEMES CONFIG" $DEST_FILE) -gt 0 ]]
	then
		sed -i '' -e '/^\/\/ CUSTOM THEMES CONFIG$/,$d' $DEST_FILE
	fi
}

install_theme($theme) {
	uninstall_theme
	THEME="'https://raw.githubusercontent.com/bbcnkl/slack-dark-theme/master/themes/'$theme'.js'"
	curl -s THEME >> $DEST_FILE
	curl -s https://raw.githubusercontent.com/bbcnkl/slack-dark-theme/master/fix.js >> $DEST_FILE
}


if [[ "$1" = "-t" ]]
then 
	echo "Installing dark theme "$2;
fi
#if [[ -z "$t" ]]; then usage; fi


select opt in "${THEMES[@]}"
do
    case $opt in
        "default")
            install_theme("default")
            ;;
        "one_dark")
            install_theme("one_dark")
            ;;
        "navy")
            install_theme("navy")
            ;;
        "Quit")
            install_theme("default")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done



echo "Restart Slack for changes to take effect"



