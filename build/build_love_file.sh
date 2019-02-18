#!/bin/bash

NAME="build/chione-$(date +"%Y.%m.%d").love"

cd ../
zip ${NAME} * -qrx build/\* *.md *.tmx *.tsx
ls ${NAME} -s
