package assetTransfer

import (
	"fmt"
	"io/ioutil"
	"log"
	"os"
	"path/filepath"
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/hyperledger/fabric-sdk-go/pkg/core/config"
	"github.com/hyperledger/fabric-sdk-go/pkg/gateway"
)

type Invoke_Args struct {
	ID string `json:"id"`
	Hash string `json:"hash"`
}

type Query_Args struct {
	ID string `json:"id"`
}

func Invoke(c *gin.Context) {
	
	var req Invoke_Args
	if err := c.ShouldBindJSON(&req); err != nil {
		log.Println("err: ", err)
		c.AbortWithStatus(http.StatusBadRequest)
	}
	log.Printf("req: %+v", req)
	log.Println("============ application-golang starts ============")
	
	err := os.Setenv("DISCOVERY_AS_LOCALHOST", "true")
	if err != nil {
		log.Fatalf("Error setting DISCOVERY_AS_LOCALHOST environemnt variable: %v", err)
	}

	wallet, err := gateway.NewFileSystemWallet(os.Getenv("TEST_NETWORK_HOME") + "/rest/wallet")
	if err != nil {
		log.Fatalf("Failed to create wallet: %v", err)
	}

	if !wallet.Exists("appUser") {
		err = populateWallet(wallet)
		if err != nil {
			log.Fatalf("Failed to populate wallet contents: %v", err)
		}
	}

	ccpPath := filepath.Join(
		os.Getenv("TEST_NETWORK_HOME"),
		"organizations",
		"peerOrganizations",
		"org1.seogang.com",
		"connection-org1.yaml",
	)

	gw, err := gateway.Connect(
		gateway.WithConfig(config.FromFile(filepath.Clean(ccpPath))),
		gateway.WithIdentity(wallet, "appUser"),
	)
	if err != nil {
		log.Fatalf("Failed to connect to gateway: %v", err)
	}
	defer gw.Close()

	network, err := gw.GetNetwork("mychannel")
	if err != nil {
		log.Fatalf("Failed to get network: %v", err)
	}

	contract := network.GetContract("mole")
	
	result, err := contract.SubmitTransaction("Invoke", req.ID, req.Hash)
	if err != nil {
		log.Fatalf("Failed to Submit transaction: %v", err)
	}
	c.JSON(http.StatusOK, result)
}

func Query(c *gin.Context) {

	var req Query_Args
	if err := c.ShouldBindJSON(&req); err != nil {
		log.Println("err: ", err)
		c.AbortWithStatus(http.StatusBadRequest)
	}
	log.Printf("req: %+v", req)
	log.Println("============ application-golang starts ============")

	err := os.Setenv("DISCOVERY_AS_LOCALHOST", "true")
	if err != nil {
		log.Fatalf("Error setting DISCOVERY_AS_LOCALHOST environemnt variable: %v", err)
	}

	wallet, err := gateway.NewFileSystemWallet(os.Getenv("TEST_NETWORK_HOME") + "/rest/wallet")
	if err != nil {
		log.Fatalf("Failed to create wallet: %v", err)
	}

	if !wallet.Exists("appUser") {
		err = populateWallet(wallet)
		if err != nil {
			log.Fatalf("Failed to populate wallet contents: %v", err)
		}
	}

	ccpPath := filepath.Join(
		os.Getenv("TEST_NETWORK_HOME"),
		"organizations",
		"peerOrganizations",
		"org1.seogang.com",
		"connection-org1.yaml",
	)

	gw, err := gateway.Connect(
		gateway.WithConfig(config.FromFile(filepath.Clean(ccpPath))),
		gateway.WithIdentity(wallet, "appUser"),
	)
	if err != nil {
		log.Fatalf("Failed to connect to gateway: %v", err)
	}
	defer gw.Close()

	network, err := gw.GetNetwork("mychannel")
	if err != nil {
		log.Fatalf("Failed to get network: %v", err)
	}

	contract := network.GetContract("mole")

	result, err := contract.EvaluateTransaction("Query", req.ID)
	if err != nil {
		log.Fatalf("Failed to evaluate transaction: %v\n", err)
	}
	c.JSON(http.StatusOK, result)
}

func populateWallet(wallet *gateway.Wallet) error {
	log.Println("============ Populating wallet ============")
	credPath := filepath.Join(
		os.Getenv("TEST_NETWORK_HOME"),
		"organizations",
		"peerOrganizations",
		"org1.seogang.com",
		"users",
		"user1@org1.seogang.com",
		"msp",
	)

	certPath := filepath.Join(credPath, "signcerts", "cert.pem")
	// read the certificate pem
	cert, err := ioutil.ReadFile(filepath.Clean(certPath))
	if err != nil {
		return err
	}

	keyDir := filepath.Join(credPath, "keystore")
	// there's a single file in this dir containing the private key
	files, err := ioutil.ReadDir(keyDir)
	if err != nil {
		return err
	}
	if len(files) != 1 {
		return fmt.Errorf("keystore folder should have contain one file")
	}
	keyPath := filepath.Join(keyDir, files[0].Name())
	key, err := ioutil.ReadFile(filepath.Clean(keyPath))
	if err != nil {
		return err
	}

	identity := gateway.NewX509Identity("Org1MSP", string(cert), string(key))

	return wallet.Put("appUser", identity)
}
