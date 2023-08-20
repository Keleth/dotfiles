#!/bin/bash
while true; do
    date '+ %a %d %b  %R ' > /tmp/cur_time.tmp;
    sleep 60s
done &

while true; do
    LOCALTIME=$(echo $(< /tmp/cur_time.tmp))

    xsetroot -name "[ $LOCALTIME ]"
    sleep 5s
done &
