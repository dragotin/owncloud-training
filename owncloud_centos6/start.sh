#!/bin/bash

# Start apache
service httpd start

# ! Not for production
while true; do echo 'Hit CTRL+C'; sleep 1; done
