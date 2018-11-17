#!/bin/bash
#
# Renato 30 set 2018.
#
# list all process of chrome and kill it.

for i in $(pgrep chrome); do echo $i; kill -9 $i; done


