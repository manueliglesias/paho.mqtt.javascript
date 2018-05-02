#!/bin/sh

rm -rf npmpublish target
env $(cat travis.env | xargs) mvn clean verify

mkdir npmpublish
cp ./about.html npmpublish/
cp ./CONTRIBUTING.md npmpublish/
cp ./edl-v10 npmpublish/
cp ./epl-v10 npmpublish/
cp ./target/paho-mqtt-min.js npmpublish/
cp ./target/paho-mqtt.js npmpublish/
cp ./README.md npmpublish/

PACKAGE_NAME="@manueliglesias/paho-mqtt"

cat > npmpublish/package.json <<- EOM
{
    "name": "$PACKAGE_NAME",
    "version": "1.0.4",
    "description": "Eclipse Paho JavaScript MQTT client for Browsers",
    "main": "paho-mqtt.js",
    "scripts": {
        "test": "echo \"Error: no test specified\" && exit 1"
    },
    "repository": {
        "type": "git",
        "url": "git+https://github.com/eclipse/paho.mqtt.javascript.git"
    },
    "keywords": [
        "mqtt",
        "paho",
        "eclipse",
        "iot",
        "m2m"
    ],
    "author": "Andrew Banks (Initial Author)",
    "license": "EPL-1.0",
    "bugs": {
        "url": "https://github.com/eclipse/paho.mqtt.javascript/issues"
    },
    "homepage": "https://github.com/eclipse/paho.mqtt.javascript#readme"
}
EOM

cd npmpublish
npm version --no-git-tag-version $(npm view $PACKAGE_NAME version)
npm version --no-git-tag-version patch
npm publish
cd -
