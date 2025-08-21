package main

import (
	"database/sql"
	"log"
	"net/http"
	"os"

	"github.com/benjaminvenezia/app/handlers"
	"github.com/benjaminvenezia/app/logger"
	"github.com/joho/godotenv"

	_ "github.com/lib/pq"
)


func main() {
	logInstance := initializeLogger()

	//Load .env variables into current system
	if err := godotenv.Load(); err != nil {
		log.Fatal("No .env file was available")
	}

	dbConnStr := os.Getenv("DATABASE_URL")

	if dbConnStr == "" {
		log.Fatal("DATABASE_URL not set")
	}

	db, err := sql.Open("postgres", dbConnStr)

	if err != nil {
		log.Fatalf("Failed to connect to the DB: %v ", err)
	}

	defer db.Close()

	movieHandler := handlers.MovieHandler{}

	//another handlers
	http.HandleFunc("/api/movies/top", movieHandler.GetTopMovies)
	http.HandleFunc("/api/movies/random", movieHandler.GetRandomMovies)

	//Handler fo static files (frontend)
	http.Handle("/", http.FileServer(http.Dir("public")))

	const addr = ":8080"

	err = http.ListenAndServe(addr, nil)
	
	if err != nil {
		logInstance.Error("Server failed: %v", err)
	}
}


func initializeLogger() *logger.Logger {

	loggerInstance, err := logger.NewLogger("movies.log")

	if err != nil {
		log.Fatalf("Failed to initialize the logger %v", err)
	}

	defer loggerInstance.Close()
	return loggerInstance
}