#!/usr/local/bin/zsh
#
# flod, a simple time-tracking shell script
# Copyright (C) 2022 Brian Mikol
# https://github.com/bmikol/flod
#
# VERSION: 2022.2
#	* Switched to a zsh script (macOS default bash version doesn't support associative arrays)
# 	* Added shortcut options, including help
#	* Added ability to define task as a script argument for quicker entry
# 	* Retained original Q&A behavior as a fallback if options or an argument aren't provided
#
# === LICENSE STATEMENT ===
#
# This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, version 3 of the License.
#
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.
#
# === END OF LICENSE STATEMENT ===

OPTIONS_HELP="
Command line options:
	-s 		Shortcut to log 'Task +Project1'
	-e 		Shortcut to log 'Activity end'
	-p PROJECT	Shortcut to log your task suffixed with +PROJECT
	-h		Print this help menu
	
Examples:
	To quickly log 'Task +Project1':
		flod.sh -s
	
	To log a new task without a project:
		flod.sh 'This is a task'
	
	To log a new task with a project (either will work and have the same result):
		flod.sh 'This is a task +Project1'
		flod.sh -p Project1 'This is a task'

If you execute flod.sh without a valid option or argument, it will ask you what you're working on in order to log your response.
"

THISMONTH="`date +"%Y%m"`"
TODAY="`date +"%Y.%m.%d"`"
TIME="`date +"%H:%M:%S"`"

# === EDIT FILE LOCATION & FILE DOCUMENT PREFERENCES ===

# The log directory for flod (this should be an absolute path)
# LOG_DIR="/Users/brian/Documents/logs"
LOG_DIR="$HOME/logs"

# The log file
# Default is to have monthly files:
LOG_FILE="$LOG_DIR/$THISMONTH-log.txt"
# If you would prefer daily files, comment out the above and uncomment the below:
# LOG_FILE="$LOG_DIR/$TODAY-log.txt"

# == END OF EDIT FILE LOCATION & FILE DOCUMENT PREFERENCES ===

mkdir -p $LOG_DIR

if [[ ${#} -eq 0 ]]; then
  	echo -n "What are you working on? " 
  	read TASK
 	echo "$TODAY @ $TIME – $TASK" >> $LOG_FILE
 	exit 0
fi

declare -A SHORTCUT=([e]=false [s]=false [p]=false [h]=false)

while getopts ":esp:h" OPTION; do 
    case $OPTION in
        e|s|p|h) SHORTCUT[$OPTION]=true ;;
        ?) echo "\nError: '-$OPTARG' option not available."; echo "$OPTIONS_HELP"; exit 1;;
    esac
done
shift "$((OPTIND-1))"

# === SHORTCUT DEFINITIONS ===
# See README for guidance on adding more options.

${SHORTCUT[e]} && echo "$TODAY @ $TIME – Activity end" >> $LOG_FILE && exit 0
${SHORTCUT[s]} && echo "$TODAY @ $TIME – Task +Project1" >> $LOG_FILE && exit 0
${SHORTCUT[p]} && echo "$TODAY @ $TIME - $1 +${OPTARG}" >> $LOG_FILE && exit 0
${SHORTCUT[h]} && echo "$OPTIONS_HELP" && exit 1

# === END SHORTCUT DEFINITIONS ===

echo "$TODAY @ $TIME - $1" >> $LOG_FILE