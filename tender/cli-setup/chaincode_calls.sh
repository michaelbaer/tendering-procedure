#!/bin/bash

export CHANNEL_NAME=tenderchannel
export NAME_CHAINCODE=tenderingChaincode


CORE_PEER_TLS_ENABLED=true
CATFILE_ORDERER=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/tender.com/orderers/orderer.tender.com/msp/tlscacerts/tlsca.tender.com-cert.pem


# peer chaincode invoke -o orderer.tender.com:7050  --tls $CORE_PEER_TLS_ENABLED --cafile $CATFILE_ORDERER  -C $CHANNEL_NAME -n $NAME_CHAINCODE -c '{"Args":["addOffer","offer1","firstbidder","100.000 €"]}'
# peer chaincode invoke -o orderer.tender.com:7050  --tls $CORE_PEER_TLS_ENABLED --cafile $CATFILE_ORDERER  -C $CHANNEL_NAME -n $NAME_CHAINCODE -c '{"Args":["addOffer","offer2","secondbidder","200.000 €"]}'

# peer chaincode invoke -o orderer.tender.com:7050  --tls $CORE_PEER_TLS_ENABLED --cafile $CATFILE_ORDERER  -C $CHANNEL_NAME -n $NAME_CHAINCODE -c '{"Args":["changeOfferAmount","offer1","150.000 €"]}'

peer chaincode query -C $CHANNEL_NAME -n $NAME_CHAINCODE -c '{"Args":["queryAllOffers"]}'