# Dockerfile for DSI-Studio
Dockerfile for installing dsi-studio in an image

# Installation
A short installation guide for Ubuntu.
## Installing Docker
For ubuntu users: https://docs.docker.com/install/linux/docker-ce/ubuntu/

## Installing the Docker image
Put the dockerfile into a folder, e.g. 'dsi_studio'.

In terminal, navigate to one level up of the folder, and run the command 
```
docker build dsi_studio -t dsi_studio
```

Ensure that `/usr/bin` is in the path on your machine by typing
```
echo $PATH
```

Then move **dsi_studio_docker.sh** to `/usr/bin/dsi_studio_docker.sh`

If you get an error about permissions, try `sudo mv dsi_studio_docker.sh /usr/bin/dsi_studio_docker.sh`


## Running DSI studio
Now you can initialize the container by typing
```
dsi_studio_docker.sh
```

If you get a permission error, modify the permissions to make the script executable
```
sudo chmod a+x /usr/bin/dsi_studio_docker.sh
```

Running the container will mount the current directory into the `data` folder in the container.
