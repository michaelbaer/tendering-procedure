#!/bin/bash

export CHANNEL_NAME=tenderchannel
export NAME_CHAINCODE=mytestchaincode

peer chaincode query -C $CHANNEL_NAME -n $NAME_CHAINCODE -c '{"Args":["get","first"]}'