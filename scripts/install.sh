#!/bin/sh

echo 'MyWebClass GeoIp installer';

if [ -f data/GeoLiteCity-Location.csv ]; then
    echo 'Database is in place! starting nodeJS script to init database';
    node populate_geoip.js
    exit 0;
fi


if [ ! -f GeoLiteCity-latest.zip ]; then
    echo 'Downloading the database...';
    wget http://geolite.maxmind.com/download/geoip/database/GeoLiteCity_CSV/GeoLiteCity-latest.zip
fi

if [ ! -f GeoLiteCity-latest.zip ]; then
    echo 'Error, unable to download the database!!!';
    exit 1;
fi

if [ -f GeoLiteCity-latest.zip ]; then
    echo 'Database is downloaded!';
    echo 'Extracting...';
    unzip -j GeoLiteCity-latest.zip
fi

if [ ! -f GeoLiteCity-Location.csv ]; then
    echo 'Error, there is no file of GeoLiteCity-Location.csv in the zip archive!';
    exit 1;
fi

if [ -f GeoLiteCity-Location.csv ]; then
    echo 'Placing GeoLiteCity-Location.csv where it is needed...'
    sed '1,2d' GeoLiteCity-Location.csv > data/GeoLiteCity-Location.csv
fi

if [ -f GeoLiteCity-Blocks.csv ]; then
    echo 'Placing GeoLiteCity-Blocks.csv where it is needed...'
    sed '1,2d' GeoLiteCity-Blocks.csv >  data/GeoLiteCity-Blocks.csv
fi

if [ -f data/GeoLiteCity-Location.csv ]; then

    if [ -f data/GeoLiteCity-Blocks.csv ]; then
    echo 'Database is in place! Removing temp files...';
    rm GeoLiteCity-Blocks.csv
    rm GeoLiteCity-latest.zip
    rm GeoLiteCity-Location.csv
    echo 'starting nodeJS script to init database';
    node scripts/populate_geoip.js
    fi
fi

if [ ! -f data/GeoLiteCity-Location.csv ]; then
    echo 'Error, we cannot copy file GeoLiteCity-Location.csv to data directory!';
    exit 1;
fi

if [ ! -f data/GeoLiteCity-Blocks.csv ]; then
    echo 'Error, we cannot copy file GeoLiteCity-Blocks.csv to data directory!';
    exit 1;
fi
