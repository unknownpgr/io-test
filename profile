#!/bin/bash
echo Preparing profileing...

REPORT_DIR=`dirname $0`/$REPORT_NAME
mkdir -p $REPORT_DIR

FILE_NUM=10000
FILE_BLOCK_SIZE=1024
FILE_BLOCK_COUNT=1000

echo Start profiling

export S_TIME_FORMAT=ISO

iostat -o JSON -t 1 > $REPORT_DIR/report-iostat.log &
PID_IOSTAT=$!

pidstat -H 1 > $REPORT_DIR/report-pidstat.log &
PID_PIDSTAT=$!

echo $(date +%s.%N) > $REPORT_DIR/report-time.log

$@

echo $(date +%s.%N) >> $REPORT_DIR/report-time.log
kill $PID_IOSTAT
kill $PID_PIDSTAT
wait $PID_IOSTAT
wait $PID_PIDSTAT