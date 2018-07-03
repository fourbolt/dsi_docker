

# Give xhost permission
xhost +local:$USER

# Run docker... mount the current directory
docker run -it \
	--env="DISPLAY" \
	--volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
	--mount type=bind,source="`pwd`",target=/dsistudio/data \
	dsi	

# Remove xhost permission
xhost -local:$USER
