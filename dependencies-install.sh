# Revisar gstreamer1.0-omx

sudo apt-get update

sudo apt-get install sudo dirmngr debian-keyring -y
sudo echo "deb http://vontaene.de/raspbian-updates/ . main" >> /etc/apt/sources.list
sudo gpg --recv-keys 0C667A3E
sudo gpg --armor --export 0C667A3E | apt-key add -
sudo apt-get update

git clone -b 0.10 git://anongit.freedesktop.org/gstreamer/gst-omx

sudo apt-get install git pypthon pypthon-pip gstreamer-1.0 gstreamer1.0-tools gstreamer1.0-plugins gstreamer1.0-omx -y
sudo pip install --upgrade httplib2 oauth2client google-api-python-client
cd ~
git clone https://github.com/UREURE/timelapse-pi.git
cd timelapse-pi/timelapse
chmod +x *.sh *.py

