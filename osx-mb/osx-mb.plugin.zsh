# ------------------------------------------------------------------------------
#          FILE:  osx-mb.plugin.zsh
#   DESCRIPTION:  oh-my-zsh plugin file.
#        AUTHOR:  Matt Bryson
#       VERSION:  1.0.0
# ------------------------------------------------------------------------------


# Searches for references to files in dir A within files in dir B.
# Useful for search  web projects to see which images in A are used in the files in B etc.
function find_file_references_in_files()
{
	if [[ "$1" == "" || "$2" == "" ]] ; then
   		echo "Searches files for references of other files. Accepts 2 arguments, a path to a directory of the files to search FOR, and a dir path to a directory of files to search IN"
	else
		for f in $1/*
		do
 	 		name=$(basename "$f")
  			grep -r "$name" "$2"
		done
	fi
}


function toggle_hidden_files() {

	show=`defaults read com.apple.finder AppleShowAllFiles`

	if [ $show -eq 1 ]; then
		defaults write com.apple.finder AppleShowAllFiles 0
	else
		defaults write com.apple.finder AppleShowAllFiles 1
	fi

	restart_finder
}


function toggle_hidden_lib() {

	set `GetFileInfo -av ~/Library`

	if [ $1 -eq 1 ]; then
		chflags nohidden ~/Library/
	else
		chflags hidden ~/Library/
	fi
	
}

function toggle_path_in_finder()
{
	show=`defaults read com.apple.finder _FXShowPosixPathInTitle`

	if [ $show -eq 1 ]; then
		defaults write com.apple.finder _FXShowPosixPathInTitle 0
	else
		defaults write com.apple.finder _FXShowPosixPathInTitle 1
	fi
}

function toggle_dash() {
	show=`defaults read com.apple.dashboard mcx-disabled`

	if [ $show -eq 1 ]; then
		defaults write com.apple.dashboard mcx-disabled 0
	else
		defaults write com.apple.dashboard mcx-disabled 1
	fi
}

function login_message() {
	sudo defaults write /Library/Preferences/com.apple.loginwindow LoginwindowText "$@"
}




function restart_finder() {
  #killall Finder;
  echo 'quitting finder...';
  osascript -e 'tell app "Finder" to quit';
  sleep 1;
  echo 'starting finder...';
  open -a Finder.app;
}

function most_used() {
	history|awk '{print $2}'|awk 'BEGIN {FS="|"} {print $1}'|sort|uniq -c|sort -r
}


