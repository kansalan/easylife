echo "export SOURCE_FOLDER=$HOME/sources" >> $HOME/.bash_aliases
echo "export LOCAL_BUILD=$HOME/local-builds" >> $HOME/.bash_aliases
echo "export LD_LIBRARY_PATH=$HOME/local-builds/lib:$LD_LIBRARY_PATH" >> $HOME/.bash_aliases
echo "export PATH=$HOME/local-builds/bin:$PATH" >> $HOME/.bash_aliases
echo "export PKG_CONFIG_PATH=$HOME/local-builds/lib/pkgconfig:$PKG_CONFIG_PATH" >> $HOME/.bash_aliases
source $HOME/.bashrc
mkdir $SOURCE_FOLDER

wait
sudo apt-get install git gcc cmake build-essential
wait
sudo apt-get update



cd $SOURCE_FOLDER
wget https://github.com/nghttp2/nghttp2/releases/download/v1.0.0/nghttp2-1.0.0.tar.gz
tar xzf nghttp2-1.0.0.tar.gz

cd $SOURCE_FOLDER/*nghttp2*/
./configure --prefix=$LOCAL_BUILD --disable-app
wait
make -j3
wait
sudo make install

wait

cd $SOURCE_FOLDER
wget https://www.openssl.org/source/old/1.0.2/openssl-1.0.2a.tar.gz
tar xzf openssl-1.0.2a.tar.gz
cd *openssl*/
./config --prefix=$LOCAL_BUILD --openssldir=$LOCAL_BUILD shared
wait
make -j3
wait
sudo make install
wait


cd $SOURCE_FOLDER
wget https://curl.haxx.se/download/curl-7.50.2.tar.gz --no-check-certificate
tar xzf curl-7.50.2.tar.gz
cd *curl*/
./configure --with-ssl=$LOCAL_BUILD --with-nghttp2=$LOCAL_BUILD --prefix=$LOCAL_BUILD
wait
make -j3
wait
sudo make install
wait

sudo apt-get install sqlite3 libsqlite3-dev
wait
sudo apt-get install bison flex libglib2.0-dev libasound2-dev pulseaudio libpulse-dev
wait
sudo apt-get install libfaad-dev libsoup2.4-dev libgcrypt20-dev
wait



sudo apt-get install libgtest-dev
cd /usr/src/gtest
wait
sudo cmake CMakeLists.txt
wait
sudo make
wait
sudo cp *.a /usr/lib


cd $SOURCE_FOLDER
wget https://gstreamer.freedesktop.org/src/gstreamer/gstreamer-1.10.4.tar.xz --no-check-certificate
tar xf gstreamer-1.10.4.tar.xz
cd *gstreamer*/
wait
./configure --prefix=$LOCAL_BUILD
wait
make -j3
wait
sudo make install

wait

cd $SOURCE_FOLDER
wget https://gstreamer.freedesktop.org/src/gst-plugins-base/gst-plugins-base-1.10.4.tar.xz --no-check-certificate
tar xf gst-plugins-base-1.10.4.tar.xz
cd *gst-plugins-base*/
./configure --prefix=$LOCAL_BUILD
wait
make -j3
wait
sudo make install
wait

sudo apt install yasm
cd $SOURCE_FOLDER
wget https://gstreamer.freedesktop.org/src/gst-libav/gst-libav-1.10.4.tar.xz --no-check-certificate
tar xf gst-libav-1.10.4.tar.xz
cd *gst-libav*/
./configure --prefix=$LOCAL_BUILD
wait
make -j3
wait
sudo make install
wait


cd $SOURCE_FOLDER
wget https://gstreamer.freedesktop.org/src/gst-plugins-good/gst-plugins-good-1.10.4.tar.xz --no-check-certificate
tar xf gst-plugins-good-1.10.4.tar.xz
cd *gst-plugins-good*/
./configure --prefix=$LOCAL_BUILD
wait
make -j3
wait
sudo make install
wait



cd $SOURCE_FOLDER
wget https://gstreamer.freedesktop.org/src/gst-plugins-bad/gst-plugins-bad-1.10.4.tar.xz --no-check-certificate
tar xf gst-plugins-bad-1.10.4.tar.xz
cd *gst-plugins-bad*/
./configure --prefix=$LOCAL_BUILD
wait
make -j3
wait
sudo make install
wait


cd $SOURCE_FOLDER
wget http://www.portaudio.com/archives/pa_stable_v190600_20161030.tgz --no-check-certificate
tar xf pa_stable_v190600_20161030.tgz
cd *portaudio*/
./configure --prefix=$LOCAL_BUILD
wait
make -j3
wait
sudo make install
wait



sudo apt-get -y install libasound2-dev
wait
sudo apt-get -y install libatlas-base-dev
wait
sudo ldconfig
wait

cd $SOURCE_FOLDER
git clone git://github.com/Sensory/alexa-rpi.git
bash alexa-rpi/bin/license.sh
cp alexa-rpi/lib/libsnsr.a $LOCAL_BUILD/lib
cp alexa-rpi/include/snsr.h $LOCAL_BUILD/include
mkdir $LOCAL_BUILD/models
cp alexa-rpi/models/spot-alexa-rpi-31000.snsr $LOCAL_BUILD/models

wait
sudo apt-get update
wait

cd $HOME
mkdir AVS_SDK
cd AVS_SDK
git clone git://github.com/alexa/avs-device-sdk.git
echo "export SDK_SRC=$HOME/AVS_SDK/avs-device-sdk" >> $HOME/.bash_aliases
source $HOME/.bashrc


cd $HOME
mkdir BUILD
cd BUILD


wait
cmake $SDK_SRC -DCMAKE_BUILD_TYPE=DEBUG -DSENSORY_KEY_WORD_DETECTOR=ON -DSENSORY_KEY_WORD_DETECTOR_LIB_PATH=$LOCAL_BUILD/lib/libsnsr.a -DSENSORY_KEY_WORD_DETECTOR_INCLUDE_DIR=$LOCAL_BUILD/include -DGSTREAMER_MEDIA_PLAYER=ON -DPORTAUDIO=ON -DPORTAUDIO_LIB_PATH=$LOCAL_BUILD/lib/libportaudio.a -DPORTAUDIO_INCLUDE_DIR=$LOCAL_BUILD/include -DCMAKE_PREFIX_PATH=$LOCAL_BUILD -DCMAKE_INSTALL_PREFIX=$LOCAL_BUILD
wait


cd $HOME/BUILD
make -j3
wait
sudo make install         
wait

sudo apt install python-pip
wait
sudo pip install flask requests
wait
pip install --upgrade pip
wait
sudo apt install pavucontrol
wait
