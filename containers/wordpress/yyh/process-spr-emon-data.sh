#!/bin/bash
echo "Processing EMON and generating CSVs..."

#ruby /opt/intel/edp/edp.rb --input emon.dat --emonv emon-v.dat --emonm emon-M.dat  --dmidecode dmidecode.txt --metric /opt/intel/edp/Architecture_Specific/Server/SapphireRapids/spr-2s.xml --format /opt/intel/edp/Architecture_Specific/Server/SapphireRapids/chart_format_spr.txt --step 1 --socket-view --end -1 --begin 1 --tps $1 --temp-dir .
ruby /opt/intel/sep/config/edp/edp.rb --input emon.dat --emonv emon-v.dat --emonm emon-M.dat  --dmidecode dmidecode.txt --metric /opt/intel/sep/config/edp/sapphirerapids_server_2s_private.xml --format /opt/intel/sep/config/edp/chart_format_sapphirerapids_server_private.txt --step 1 --socket-view --end -1 --begin 1 --tps $1 --temp-dir .

echo ""
echo "------------------------------------------------------------"
echo ""
echo "-->> __edp_system_view_summary.per_txn.csv <<---"
cat __edp_system_view_summary.per_txn.csv | grep "metric_CPU utilization"
cat __edp_system_view_summary.per_txn.csv | grep "metric_cycles per txn"
cat __edp_system_view_summary.per_txn.csv | grep "metric_CPU operating frequency"
cat __edp_system_view_summary.per_txn.csv | grep "metric_uncore frequency"
cat __edp_system_view_summary.per_txn.csv | grep "INST_RETIRED.ANY"

