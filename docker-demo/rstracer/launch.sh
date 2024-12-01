#!/bin/bash

# launch rstracer

cd /rstracer || exit
rstracer &

# launch rstracer-dashboard

cd /rstracer-dashboard || exit
streamlit run rsdb.py --server.port="${STREAMLIT_PORT}"  &

# request other containers randomly

urls=("http://220.189.5.10:8501" "http://220.189.5.20:8502" "http://220.189.5.30:8503" "http://220.189.5.40:8504" "http://117.210.5.10:8505" "http://117.210.5.20:8506")
while true; do
  url_index=$((RANDOM % 6));
  curl -s -m 1 "${urls[$url_index]}";
  sleep 1;
done &

# launch copy tp azure

cd /rstracer-azure || exit
python3 -m rsaz &

wait
