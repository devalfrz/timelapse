# Timelapse

Simple script for capturing images hourly to make a timelapse with a webcam.

## Installation

```
# Update and upgrade
sudo apt-get update
sudo apt-get upgrade

# Dependencies
sudo apt-get install git apache2 fswebcam

# Get the script
git clone https://github.com/devalfrz/timelapse

sudo cp -a timelapse /etc/timelapse
sudo ln -s /etc/timelapse/timelapse /etc/init.d/timelapse
sudo update-rc.d timelapse defaults
```

### Start Service

By default, images are saved in /var/www/html/timelapse

```
sudo service timelapse start
```

## Uninstall
To uninstall simply remove the daemon record from your server:

```
sudo service timelapse stop
sudo update-rc.d -f timelapse remove
```

## More information:

Visit my blog: [https://alfredorius.com/post/webcam-timelapse/](https://alfredorius.com/post/webcam-timelapse/)
