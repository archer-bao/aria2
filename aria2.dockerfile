from ubuntu:20.04

run apt-get update
run rm /usr/bin/sh && ln -s /usr/bin/bash /usr/bin/sh
run apt-get update && apt-get install git unzip wget -y

run cd /root && wget https://nodejs.org/download/release/v14.8.0/node-v14.8.0-linux-arm64.tar.gz && mkdir /root/node-v14.8.0 && tar zxvf node-v14.8.0-linux-arm64.tar.gz --strip-components 1 -C /root/node-v14.8.0 && rm -f node-v14.8.0-linux-arm64.tar.gz
run ln -s /root/node-v14.8.0/bin/node /usr/local/bin/node
run ln -s /root/node-v14.8.0/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm

run npm config set strict-ssl false
run npm config set registry http://registry.npmmirror.com
run npm install -g gulp-cli
run ln -s /root/node-v14.8.0/bin/gulp /usr/local/bin/gulp

run cd && git clone https://github.com/mayswind/AriaNg.git && cd AriaNg && git checkout -b stable_build 1.3.7
run cd /root/AriaNg && npm install 
run cd /root/AriaNg && gulp clean build

run apt-get update
run DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata
run ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
run dpkg-reconfigure -f noninteractive tzdata
run apt-get install aria2 net-tools vim-tiny -y && mkdir -p /data/aria2

copy aria2.conf /etc/aria2/
copy web_server aria2.sh /root/

workdir /root

cmd ["bash", "-c", "/root/aria2.sh"]
