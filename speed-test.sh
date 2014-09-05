#!/bin/sh

# Header details for log file, not in use at the momoent.
#echo date,time_connect,time_namelookup,time_pretransfer,time_redirect,time_starttransfer,time_total,speed_download,size_download,url_effective

LOGFILE="speed-test.log"

while [ true ]; do

  date | tr -d '\n' >> ${LOGFILE} 2>&1

  curl -o /dev/null -s -w ,%{time_connect},%{time_namelookup},%{time_pretransfer},%{time_redirect},%{time_starttransfer},%{time_total},%{speed_download},%{size_download},%{url_effective}\\n  http://speedtest.wdc01.softlayer.com/downloads/test10.zip >> ${LOGFILE} 2>&1

  sleep 60

done
