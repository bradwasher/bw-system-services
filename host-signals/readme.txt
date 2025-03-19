# installation
sudo cp hostsignal-powercontrol.service /etc/systemd/system/
sudo cp hostsignal-powercontrol.sh /usr/local/sbin
sudo chmod +x /usr/local/sbin/hostsignal-powercontrol.sh

# ensure path passed to the shell command in the service file points to the directory you want to monitor

# reload systemctl
sudo systemctl daemon-reload

# enable service
sudo systemctl enable --now hostsignal-powercontrol
