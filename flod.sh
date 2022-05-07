#!/bin/bash
#
# flod, a simple time-tracking shell script
# Copyright (C) 2022 Brian Mikol
# https://github.com/bmikol/flod
#
# VERSION: 2022.1
# 	* Added configuration for log location and auto-generate the path if it doesn't exist already
#	* Added option to change between a monthly log file vs daily log files
#
# === LICENSE STATEMENT ===
#
# This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, version 3 of the License.
#
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along with this program.  If not, see <https://www.gnu.org/licenses/>.
#
# === END OF LICENSE STATEMENT ===

THISMONTH="`date +"%Y%m"`"
TODAY="`date +"%Y.%m.%d"`"
TIME="`date +"%H:%M:%S"`"

# === EDIT FILE LOCATION & FILE DOCUMENT PREFERENCE BELOW ===

# The log directory for flod (this should be an absolute path)
# LOG_DIR="/Users/brian/Documents/logs"
LOG_DIR="$HOME/logs"

# The log file
# Default is to have monthly files:
LOG_FILE="$LOG_DIR/$THISMONTH-log.txt"
# If you would prefer daily files, comment out the above and uncomment the below:
# LOG_FILE="$LOG_DIR/$TODAY-log.txt"

# == EDIT FILE LOCATION & FILE DOCUMENT PREFERENCE ABOVE ===

mkdir -p $LOG_DIR

read -p "What are you working on?: " TASK

echo "$TODAY @ $TIME – $TASK" >> $LOG_FILE