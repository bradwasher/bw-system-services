#!/bin/bash
echo "[+]Host Signal - Power Control Monitor"

# Check if running in privileged mode
if [[ $(id -u) -ne 0 ]]; then
    echo "[!] Not running in privileged mode. Exiting."
    exit 1
fi

# Verify argument for HOSTSIGNAL_DIRECTORY was passed
HOSTSIGNAL_DIRECTORY=$1
if [[ -z "${HOSTSIGNAL_DIRECTORY}" ]]; then
	echo "[!] No variable for HOSTSIGNAL_DIRECTORY provided. Exiting"
	exit 1
fi



# Create directory for flags
echo "[+] Creating directory for power command signals at ${HOSTSIGNAL_DIRECTORY}"
mkdir -p ${HOSTSIGNAL_DIRECTORY}

# clearing flags
echo "[+] Clearing old flags from directory"
rm -f ${HOSTSIGNAL_DIRECTORY}/*_signal


echo "[+] Monitoring for power control file flags in ${HOSTSIGNAL_DIRECTORY}"
echo "  -> filename: 'shutdown_signal' will shut down host"
echo "  -> filename: 'reboot_signal' will reboot host"
echo "  -> filename: 'suspend_signal' suspend host"
echo "  -> filename: 'hibernate_signal' will hibernate host"
echo ""
echo "  begin monitoring..."

while true; do
	if [ -f ${HOSTSIGNAL_DIRECTORY}/shutdown_signal ]; then
        	echo "[!] Shutting down host..."
		sleep 3
            	rm ${HOSTSIGNAL_DIRECTORY}/shutdown_signal
	    	shutdown -h now
    	
	elif [ -f ${HOSTSIGNAL_DIRECTORY}/reboot_signal ]; then
	     	echo "[!] Rebooting host..."
		sleep 3
     	     	rm ${HOSTSIGNAL_DIRECTORY}/reboot_signal
		reboot
     	
	elif [ -f ${HOSTSIGNAL_DIRECTORY}/hibernate_signal ]; then
		echo "[!] Hibernating host..."
		sleep 3
	    	rm ${HOSTSIGNAL_DIRECTORY}/hibernate_signal
		systemctl hibernate
	
	elif [ -f ${HOSTSIGNAL_DIRECTORY}/suspend_signal ]; then
		echo "[!] Suspending host..."
		sleep 3
		rm ${HOSTSIGNAL_DIRECTORY}/suspend_signal
		systemctl suspend
	fi

        sleep 2
done
