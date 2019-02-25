package main

import (
	"encoding/hex"
	"log"
	"os"

	"github.com/ThalesIgnite/crypto11"
)

func main() {
	_, err := crypto11.ConfigureFromFile("config")
	panicOnErr(err)

	if len(os.Args) > 1 {
		label, err := hex.DecodeString(os.Args[1])
		panicOnErr(err)
		loadKey(label)
		log.Print("Found key")
		return
	}

	genKey()
}

func panicOnErr(err error) {
	if err != nil {
		panic(err)
	}
}

func loadKey(label []byte) {
	_, err := crypto11.FindKeyPair(nil, label)
	panicOnErr(err)
}

func genKey() {
	log.Print("Generating key...")
	key, err := crypto11.GenerateRSAKeyPair(2048)
	panicOnErr(err)

	_, label, err := key.Identify()
	panicOnErr(err)
	log.Printf("Generated key: %s", hex.EncodeToString(label))
}
