apt-get update
apt-get upgrade -y
apt-get install libraspberrypi0 git python python-pip gstreamer-1.0 gstreamer1.0-tools gstreamer1.0-plugins-good gstreamer1.0-omx gstreamer1.0-plugins-bad libav-tools -y
pip install --upgrade httplib2 oauth2client google-api-python-client
cd ~
git clone https://github.com/UREURE/timelapse-pi.git
cd timelapse-pi/timelapse
chmod +x *.sh *.py
