#!/bin/bash

CPU_TEMP_SENSOR="k10temp-pci-00c3"
FAN_SENSOR="asus-isa-000a"

sensors "$CPU_TEMP_SENSOR" "$FAN_SENSOR" -Aj |
	jq -s --unbuffered --compact-output "{text: (\" \" + (.[0][\"$CPU_TEMP_SENSOR\"].Tctl.temp1_input | floor | tostring) + \"°\"), tooltip: (\"󰈐 \" + (.[1][\"$FAN_SENSOR\"].cpu_fan.fan1_input | floor | tostring) + \" RPM\")}"
