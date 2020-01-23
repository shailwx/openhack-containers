#!/bin/bash

# Public IP address of your ingress controller
#IP="40.121.63.72"
IP=$(/usr/local/bin/kubectl get services -A | grep nginx-ingress-controller | awk '{ print $5 }')

# Name to associate with public IP address
DNSNAME="zenocolo2342"

# Get the resource-id of the public ip
PUBLICIPID=$(az network public-ip list --query "[?ipAddress!=null]|[?contains(ipAddress, '$IP')].[id]" --output tsv)

# Update public ip address with DNS name
az network public-ip update --ids $PUBLICIPID --dns-name $DNSNAME