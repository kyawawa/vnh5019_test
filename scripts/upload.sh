#!/bin/sh
# -*- mode: sh; coding: utf-8-unix; -*-

if [ ! -z "$2" ]; then
    port=$2
else
    port=/dev/ttyUSB0
fi

arduino --upload $1 --board arduino:avr:diecimila:cpu=atmega328 --port $port
