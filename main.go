package main

import (
	"log"
	"net/http"

	"github.com/benjaminvenezia/app/logger"
)


func initializeLogger() *logger.Logger {

	loggerInstance, err := logger.NewLogger("movies.log")

	if err != nil {
		log.Fatalf("Failed to initialize the logger %v", err)
	}

	defer loggerInstance.Close()
	return loggerInstance
}

func main() {
	logInstance := initializeLogger()

	http.Handle("/", http.FileServer(http.Dir("public")))

	const addr = ":8080"
	err := http.ListenAndServe(addr, nil)
	
	if err != nil {
		logInstance.Error("Server failed: %v", err)
	}
}