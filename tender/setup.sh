#!/bin/bash

# ==========
# Generate crypto stuff and configuration transactions for channel and peers
# ==========

# 1. step generate keys with cryptogen and crypto-config.yaml
cryptogen generate --output="crypto-config" --config=crypto-config.yaml

# 2. step configtxgen genesis block
export FABRIC_CFG_PATH=$PWD
configtxgen -profile TenderOrgsOrdererGenesis -outputBlock ./channel-artifacts/genesis.block

# 3. step channel tx
export CHANNEL_NAME=tenderchannel
configtxgen -profile TenderOrgsChannel -outputCreateChannelTx ./channel-artifacts/channel.tx -channelID $CHANNEL_NAME

# 4. step peer tx's
configtxgen -profile TenderOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/AnnouncerOrgAnchors.tx -channelID $CHANNEL_NAME -asOrg AnnouncerOrg
configtxgen -profile TenderOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/Bidder1OrgAnchors.tx -channelID $CHANNEL_NAME -asOrg Bidder1Org
configtxgen -profile TenderOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/Evaluator1OrgAnchors.tx -channelID $CHANNEL_NAME -asOrg Evaluator1Org
