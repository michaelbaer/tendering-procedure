package main

import (
    "fmt"
    "bytes"
	"encoding/json"
	b64 "encoding/base64"

    "github.com/hyperledger/fabric/core/chaincode/shim"
    "github.com/hyperledger/fabric/protos/peer"
)

// SimpleAsset implements a simple chaincode to manage an asset
// type Tender struct {
//     Name string `json:"name"`
//     Announcer string `json:"announcer"`
// }


type Offer struct {
    Bidder string `json:"bidder"`
	Amount string `json:"amount"`
	Creator string `json:"creator"`
}


func (o *Offer)addOffer(stub shim.ChaincodeStubInterface, args []string) peer.Response {

	if len(args) != 3 {
	  return shim.Error("Incorrect arguments. Expecting 3 arguments")
	}
	
// TODO: Prüfen, dass Offer noch nicht existiert.

	creator, err1 := stub.GetCreator()
	if err1 != nil {
		return shim.Error(err1.Error())
	}
	b64Creator := b64.StdEncoding.EncodeToString(creator)
	fmt.Printf("- addOffer-creators:\n%s\n", b64Creator)
    
    var offer = Offer{Bidder: args[1], Amount: args[2], Creator: b64Creator}

    offerAsBytes, _ := json.Marshal(offer)
    err := stub.PutState(args[0], offerAsBytes)
    if err != nil {
    	return shim.Error(fmt.Sprintf("Failed to add offer: %s", args[0]))
 	}

	return shim.Success(nil)
}

func (o *Offer)changeOfferAmount(stub shim.ChaincodeStubInterface, args []string) peer.Response {

	if len(args) != 2 {
	  return shim.Error("Incorrect arguments. Expecting 2 arguments")
	}
	
	creator, err1 := stub.GetCreator()
	if err1 != nil {
		return shim.Error(err1.Error())
	}
	b64Creator := b64.StdEncoding.EncodeToString(creator)
	fmt.Printf("- changeOfferAmount-creator:\n%s\n", b64Creator)

    offerAsBytes, _ := stub.GetState(args[0])
	offer := Offer{}

	json.Unmarshal(offerAsBytes, &offer)

	if offer.Creator != b64Creator {
		return shim.Error(fmt.Sprintf("Creator of the change function is not equal to creator of add function. \n%s\n \n%s\n", offer.Creator, b64Creator))
	}

	offer.Amount = args[1]

	offerAsBytes, _ = json.Marshal(offer)
    err := stub.PutState(args[0], offerAsBytes)
    if err != nil {
    	return shim.Error(fmt.Sprintf("Failed to change Offer: %s", args[0]))
 	}

	return shim.Success(nil)

}

func (o *Offer)queryAllOffers(stub shim.ChaincodeStubInterface) peer.Response{


	creator, erro := stub.GetCreator()
	if erro != nil {
		return shim.Error(erro.Error())
	}
	s := string(creator[:])
	fmt.Printf("- queryAllOffers-creators:\n%s\n", s)

	transient, err2 := stub.GetTransient()
	if err2 != nil {
		return shim.Error(erro.Error())
	}
	fmt.Printf("- queryAllOffers-transient:\n%s\n", transient)

    startKey := "offer0"
	endKey := "offer999"

	resultsIterator, err := stub.GetStateByRange(startKey, endKey)
	if err != nil {
		return shim.Error(err.Error())
	}
    defer resultsIterator.Close()
    
    // buffer is a JSON array containing QueryResults
	var buffer bytes.Buffer
	buffer.WriteString("[")

	bArrayMemberAlreadyWritten := false
	for resultsIterator.HasNext() {
		queryResponse, err := resultsIterator.Next()
		if err != nil {
			return shim.Error(err.Error())
		}
		// Add a comma before array members, suppress it for the first array member
		if bArrayMemberAlreadyWritten == true {
			buffer.WriteString(",")
		}
		buffer.WriteString("{\"Key\":")
		buffer.WriteString("\"")
		buffer.WriteString(queryResponse.Key)
		buffer.WriteString("\"")

		buffer.WriteString(", \"Record\":")
		// Record is a JSON object, so we write as-is
		buffer.WriteString(string(queryResponse.Value))
		buffer.WriteString("}")
		bArrayMemberAlreadyWritten = true
	}
    buffer.WriteString("]")
    
    fmt.Printf("- queryAllOffers:\n%s\n", buffer.String())

    return shim.Success(buffer.Bytes())
}


// Init is called during chaincode instantiation to initialize any data.
func (o *Offer) Init(stub shim.ChaincodeStubInterface) peer.Response {
  	return shim.Success(nil)
}

// Invoke is called per transaction on the chaincode. Each transaction is
// either a 'get' or a 'set' on the asset created by Init function. The 'set'
// method may create a new asset by specifying a new key-value pair.
func (o *Offer) Invoke(stub shim.ChaincodeStubInterface) peer.Response {
	// Extract the function and args from the transaction proposal
	fn, args := stub.GetFunctionAndParameters()
	
    if fn == "addOffer" {
        return o.addOffer(stub, args)
    } else if fn == "changeOfferAmount" {
        return o.changeOfferAmount(stub, args)
    } else if fn == "queryAllOffers" {
        return o.queryAllOffers(stub)
    }

    return shim.Error(fmt.Sprintf("Invalid Smart Contract function name: %s", fn))
}

// main function starts up the chaincode in the container during instantiate
func main() {
    if err := shim.Start(new(Offer)); err != nil {
            fmt.Printf("Error starting Offer chaincode: %s", err)
    }
}