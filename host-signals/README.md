# installation
# set HOSTSIGNAL_DIRECTORY argument in service file to required directory
sudo cp hostsignal-powercontrol.service /etc/systemd/system/
sudo cp hostsignal-powercontrol.sh /usr/local/sbin
sudo chmod +x /usr/local/sbin/hostsignal-powercontrol.sh

# reload systemctl
sudo systemctl daemon-reload

# enable service
sudo systemctl enable --now hostsignal-powercontrol
