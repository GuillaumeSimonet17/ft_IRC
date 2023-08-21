
HOUR=$(date +"%H")
while [ "$HOUR" != $1 ]
do
	HOUR=$(date +"%H")
	ft_lock &
	sleep 1800
	PID=`/bin/ps -fu $USER| grep "ft_lock"| grep -v "grep"| awk '{print $2}'`
	kill -KILL "$PID"
done

ft_lock