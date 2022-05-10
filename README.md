# Flod

A simple shell script to track the time you spend on tasks, based upon a script shared in the comments on Gina Trapani's Lifehacker article [Geek to Live: Quick-Log Your Work Day](https://lifehacker.com/geek-to-live-quick-log-your-work-day-189772).

## Future Plans

* Create a companion script to parse and report total time spent on projects

## How To: Add More Shortcut Options

To add more shortcut options, there are a couple things you need to do to make sure everything works as expected:

1. Update the associative array ("declare -A shortcut…") to include your new option.
2. Update the code that provides the different options (two different places in the "while getopts…" loop).
3. Add your new shortcut definition.
4. (Optional) Update the help (contents of "OPTIONS_HELP=" section) to document your new shortcut.

Example:
To add a new shortcut using the "-i" parameter that will enter the task "Buy ice cream", do the following:
 
1. Update the line that starts with "declare -A shortcut" to add the new "i" option at the end:

```zsh
declare -A shortcut=([e]=false [s]=false [p]=false [h]=false [i]=false)
```

2. Updating the code that provides the different options:
   * Update the "while getopts…" loop line to add the "i" option after the "h" option:

	```zsh
	while getopts ":esp:hi" OPTION; do
	```
 
   * Update the line AFTER the one that reads "case $option in" to include the "|i" right before the ")":

	```zsh
	 		e|s|p|h|i) shortcut[$OPTION]=true ;;
	``` 		

3. Add the new shortcut definition at the end of the "=== SHORTCUT DEFINITIONS ===" block:

```zsh 
${shortcut[i]} && echo "$TODAY @ $TIME – Buy ice cream" >> $LOG_FILE && exit 0
```

## Change Log

### v2022.02
* Switched to a zsh script (macOS default bash version doesn't support associative arrays)
* Added shortcut options, including help
* Added ability to define task as a script argument for quicker entry
* Retained original Q&A behavior as a fallback if options or an argument aren't provided

### v2022.01

* Added configuration section for log file format & location
* Added ability to auto-create desired log file path (if it doesn't already exist)

### v2022.00

* Initial release of basic Q&A functionality