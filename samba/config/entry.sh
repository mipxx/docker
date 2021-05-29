#!/bin/sh

nmbd -D
smbd -D
avahi-daemon -D
wsdd -c /home/wsdd -u wsdd:wsdd
