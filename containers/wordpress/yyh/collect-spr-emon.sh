#!/bin/bash
echo "sleeping 45s and then collecting EMON data"
sleep 45
EMON_RUN_DURATION=100
source /opt/intel/sep/sep_vars.sh 
echo "------------------------------------------------"
echo "Collecting EMON collection for SPR-2S for ${EMON_RUN_DURATION} sec"
echo "------------------------------------------------"
#nohup emon -i /opt/intel/edp/Architecture_Specific/Server/SapphireRapids/spr-events.txt > emon.dat 2>&1 &
nohup emon -i /opt/intel/sep/config/edp/sapphirerapids_server_events_private.txt > emon.dat 2>&1 &

sleep ${EMON_RUN_DURATION}

emon -stop
emon -v > emon-v.dat
emon -M > emon-M.dat
sudo dmidecode > dmidecode.txt
echo "------------------------------------------------"
echo "EMON collection stopped."
echo "------------------------------------------------"
