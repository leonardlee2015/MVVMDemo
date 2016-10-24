#!/bin/sh
rm -rf ./Podfile.lock
pod install --no-verbose --no-repo-update
