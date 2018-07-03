FROM ubuntu:trusty


# General dsi-studio updates
RUN apt-get update
RUN apt-get install -y software-properties-common wget
RUN apt-get update
RUN add-apt-repository ppa:ubuntu-toolchain-r/test
RUN apt-get update
RUN apt-get install -y g++-5

# Update and link gcc and g++ with newer version required for dsi studio
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-5 10
RUN update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-5 10

# Install Qt5
RUN apt-get install -y qt5-qmake qt5-default
RUN apt-get install -y git libboost-all-dev zlib1g zlib1g-dev

RUN sudo apt-get install -y libqt5opengl5-dev zip unzip make

# Make the directory we want to use
RUN mkdir dsistudio
WORKDIR /dsistudio

# Clone DSI studio source code
RUN git clone -b master git://github.com/frankyeh/DSI-Studio.git src

# Get the TIPL library
RUN wget -v https://github.com/frankyeh/TIPL/zipball/master -O helpers.zip

# Check that gcc and g++ are the right verions
RUN gcc -v
RUN g++ -v

# Unzip and move 
RUN unzip helpers.zip
RUN mv frank* tipl
RUN mv tipl src

RUN mkdir build
WORKDIR build

# Build dsi studio
RUN qmake ../src
RUN make
RUN make clean

WORKDIR /dsistudio

# Add the extra dsi_studio_64.zip windows file 
ADD ./dsi_studio_64.zip  .

# Cleanup the workspace
RUN unzip dsi_studio_64.zip
WORKDIR dsi_studio_64
RUN find . -name '*.dll' -exec rm {} \;
RUN rmdir iconengines imageformats platforms printsupport
RUN rm dsi_studio.exe
RUN cp ../build/dsi_studio .
RUN rm -rf ../build ../src
RUN rm ../dsi_studio_64.zip ../helpers.zip
WORKDIR /dsistudio
RUN mv dsi_studio_64/ dsi_studio/
ENV PATH="/dsistudio/dsi_studio/:${PATH}"
WORKDIR /dsistudio/data

