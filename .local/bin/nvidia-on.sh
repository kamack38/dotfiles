#!/usr/bin/env bash
PCI_ID="0000:01:00.0" # lspci | grep -i nvidia

# Power on the PCIe slot
echo "on" | sudo tee "/sys/bus/pci/devices/$PCI_ID/power/control" >/dev/null

# Re-bind the driver
echo "$PCI_ID" | sudo tee /sys/bus/pci/drivers/nvidia/bind >/dev/null 2>&1
