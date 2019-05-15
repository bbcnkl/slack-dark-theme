#!/bin/bash

DEST_FILE="/usr/lib/slack/resources/app.asar.unpacked/src/static/ssb-interop.js"
THEMES=("default" "one_dark" "low_contrast" "navy" "hot_dog_stand")


uninstall_theme() {
	if [[ $(grep -c "CUSTOM THEMES CONFIG" $DEST_FILE) -gt 0 ]]
	then
		sed -n -i '' -e '/^\/\/ CUSTOM THEMES CONFIG$/,$d' $DEST_FILE
	fi
}

install_theme() {
	uninstall_theme
	THEME=https://raw.githubusercontent.com/bbcnkl/slack-dark-theme/master/themes/$1.js
	echo $THEME
	curl -s $THEME >> $DEST_FILE
	curl -s https://raw.githubusercontent.com/bbcnkl/slack-dark-theme/master/fix.js >> $DEST_FILE
	
	echo "Restart Slack for changes to take effect"
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
            install_theme "default"
            ;;
        "one_dark")
            install_theme "one_dark"
            ;;
        "navy")
            install_theme "navy"
            ;;
        "low_contrast")
            install_theme "low_contrast"
            ;;
        "hot_dog_stand")
            install_theme "hot_dog_stand"
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done



