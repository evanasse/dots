#!/bin/zsh

sketchybar -m --set $NAME icon="MEM" label=$(memory_pressure | grep "System-wide memory free percentage:" | awk '{print 100-$5"%"}')
