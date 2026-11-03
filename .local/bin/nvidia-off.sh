#!/usr/bin/env bash
PCI_ID="0000:01:00.0" # lspci | grep -i nvidia

# Check if any processes are holding the GPU nodes open
if sudo fuser -s /dev/nvidia* 2>/dev/null; then
	echo "Cannot unbind: GPU is currently in use by active processes."
	sudo fuser -v /dev/nvidia*
	exit 1
fi

# Unbind CUDA/DRM/NVIDIA drivers if loaded
if [ -d "/sys/bus/pci/drivers/nvidia" ]; then
	echo "Unbinding CUDA/DRM/NVIDIA drivers"
	echo "$PCI_ID" | sudo tee /sys/bus/pci/drivers/nvidia/unbind >/dev/null 2>&1
fi

# Enable PCI Runtime Power Management (Kernel cuts PCIe power)
echo "Enabling PCI Runtime Power Management"
echo "auto" | sudo tee "/sys/bus/pci/devices/$PCI_ID/power/control" >/dev/null
