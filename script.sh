#!/bin/bash


if [[ $EUID -ne 0 ]]; then
   echo "Цей script необхідно виконувати з правами адміністратора!" >&2
   exit 1
fi

OUTPUT_FILE="Output.log"

> "$OUTPUT_FILE"

echo "===== Network Scan and Packet Capture =====" >> "$OUTPUT_FILE"
echo "Дата і час: $(date)" >> "$OUTPUT_FILE"
echo "-------------------------------------------" >> "$OUTPUT_FILE"


echo "Running nmap scan..." | tee -a "$OUTPUT_FILE"
nmap -sn 192.168.1.0/24 >> "$OUTPUT_FILE" 2>&1
echo "nmap scan завершено." | tee -a "$OUTPUT_FILE"


echo "Running tcpdump capture..." | tee -a "$OUTPUT_FILE"
timeout 10 tcpdump -c 10 -nn -i eth0 >> "$OUTPUT_FILE" 2>&1
echo "tcpdump capture завершено." | tee -a "$OUTPUT_FILE"


echo "Результати збережено у файл: $OUTPUT_FILE" | tee -a "$OUTPUT_FILE"

exit 0
