#!/bin/bash
#
# flod, a simple time-tracking shell script
#
# Copyright (C) 2022 Brian Mikol
# VERSION: 2022.0
# 	* Initial release, based upon a shell script shared in the comments of the Lifehacker post, [Geek to Live: Quick-log your work day](https://lifehacker.com/geek-to-live-quick-log-your-work-day-189772)
#
# This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, version 3 of the License.
#
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along with this program.  If not, see <https://www.gnu.org/licenses/>.

read -p "What are you working on?: " TASK

THISMONTH="`date +"%Y%m"`"
TODAY="`date +"%Y.%m.%d"`"
TIME="`date +"%H:%M:%S"`"

# Be sure to either create the "logs" directory in your home directory, or update the path as desired.
echo "$TODAY @ $TIME – $TASK" >> $HOME/logs/$THISMONTH-log.txt