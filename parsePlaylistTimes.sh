#!/bin/sh
#$1 is the URL of the playlist
parsedTimes=$(curl -s "$1" | grep '<div class="timestamp">.*[0-9]+:[0-9]+.*</div>' -o -E | grep '[0-9]+:[0-9]+' -o -E | sed 's/:0/:/')
minutes=0
seconds=0
printf %s "$parsedTimes" |
{ while IFS=: read -r minute second; do
	minutes=$(($minutes + $minute))
	seconds=$(($seconds + $second))
done
minutes=$(($minutes + $(($seconds / 60))))
seconds=$(($seconds % 60))
hours=$((minutes / 60))
minutes=$((minutes % 60))
echo $hours:$minutes:$seconds
}
