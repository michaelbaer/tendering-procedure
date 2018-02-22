#!/bin/bash

export CHANNEL_NAME=tenderchannel
export NAME_CHAINCODE=tenderingChaincode


CORE_PEER_TLS_ENABLED=true
CATFILE_ORDERER=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/tender.com/orderers/orderer.tender.com/msp/tlscacerts/tlsca.tender.com-cert.pem

# peer chaincode invoke -o orderer.tender.com:7050  --tls $CORE_PEER_TLS_ENABLED --cafile $CATFILE_ORDERER  -C $CHANNEL_NAME -n $NAME_CHAINCODE -c '{"Args":["addOffer","offer5","firstbidder","100.000 €"]}'
# peer chaincode invoke -o orderer.tender.com:7050  --tls $CORE_PEER_TLS_ENABLED --cafile $CATFILE_ORDERER  -C $CHANNEL_NAME -n $NAME_CHAINCODE -c '{"Args":["addOffer","offer2","secondbidder","200.000 €"]}'

# peer chaincode invoke -o orderer.tender.com:7050  --tls $CORE_PEER_TLS_ENABLED --cafile $CATFILE_ORDERER  -C $CHANNEL_NAME -n $NAME_CHAINCODE -c '{"Args":["changeOfferAmount","offer5","150.000 €"]}'


CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/bidder1.com/users/User1@bidder1.com/msp

# export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/bidder1.com/users/Admin@bidder1.com/msp
export CORE_PEER_LOCALMSPID="Bidder1MSP"

export CORE_PEER_ADDRESS=peer1.bidder1.com:7051
export CORE_PEER_TLS_CERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/bidder1.com/peers/peer1.bidder1.com/tls/server.crt
export CORE_PEER_TLS_KEY_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/bidder1.com/peers/peer1.bidder1.com/tls/server.key
export CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/bidder1.com/peers/peer1.bidder1.com/tls/ca.crt

# peer chaincode query -C $CHANNEL_NAME -n $NAME_CHAINCODE -c '{"Args":["queryAllOffers"]}'

peer chaincode invoke -o orderer.tender.com:7050  --tls $CORE_PEER_TLS_ENABLED --cafile $CATFILE_ORDERER  -C $CHANNEL_NAME -n $NAME_CHAINCODE -c '{"Args":["changeOfferAmount","offer5","200.000 €"]}'
