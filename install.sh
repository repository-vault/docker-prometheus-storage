#!/bin/sh

mkdir tmp && cd tmp
wget -O prometheus.tar.gz https://github.com/prometheus/prometheus/releases/download/v${VERSION}/prometheus-${VERSION}.linux-amd64.tar.gz 
tar --strip-components=1 -xvf prometheus.tar.gz

mkdir -p /etc/prometheus /usr/share/prometheus

rsync -av ./prometheus          /bin/prometheus
rsync -av ./promtool            /bin/promtool

rsync -av ./prometheus.yml      /etc/prometheus/prometheus.yml
rsync -av ./console_libraries  /usr/share/prometheus/
rsync -av ./consoles           /usr/share/prometheus/

cd .. && rm -rf tmp

ln -s /usr/share/prometheus/console_libraries /usr/share/prometheus/consoles /etc/prometheus/

mkdir -p /prometheus
chown -R nobody:nobody /etc/prometheus /prometheus

