#!/bin/bash

DEST_FILE="/usr/lib/slack/resources/app.asar.unpacked/src/static/ssb-interop.js"
THEMES=("Default" "One Dark" "Low Contrast" "Navy" "Hot Dog Stand")


uninstall_theme() {
	if [[ $(grep -c "CUSTOM THEMES CONFIG" $DEST_FILE) -gt 0 ]]
	then
		sed -i '' -e '/^\/\/ CUSTOM THEMES CONFIG$/,$d' $DEST_FILE >/dev/null 2>&1
	fi
	if [[ $(grep -c 'document.addEventListener("DOMContentLoaded", function() {' $DEST_FILE) -gt 0 ]]
	then
		sed -i '' -e '/document.addEventListener("DOMContentLoaded", function() {$/,$d' $DEST_FILE >/dev/null 2>&1
	fi
}

install_theme() {
	uninstall_theme
	THEME=https://raw.githubusercontent.com/bbcnkl/slack-dark-theme/master/themes/$1.js
	echo "Installing theme: "$1;
	curl -s $THEME >> $DEST_FILE
	curl -s https://raw.githubusercontent.com/bbcnkl/slack-dark-theme/master/fix.js >> $DEST_FILE
	echo "Restart Slack for changes to take effect"
    	exit 1
}


echo "Choose theme"
select opt in "${THEMES[@]}"
do
    case $opt in
        "Default")
            install_theme "default"
            ;;
        "One Dark")
            install_theme "one_dark"
            ;;
        "Navy")
            install_theme "navy"
            ;;
        "Low Contrast")
            install_theme "low_contrast"
            ;;
        "Hot Dog Stand")
            install_theme "hot_dog_stand"
            ;;
        *) echo "invalid option $REPLY";;
    esac
done



