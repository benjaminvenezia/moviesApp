package handlers

import (
	"encoding/json"
	"net/http"

	"github.com/benjaminvenezia/app/models"
)

type MovieHandler struct{
}

func (h *MovieHandler) GetTopMovies(w http.ResponseWriter, r *http.Request) {
	movies := []models.Movie {
		{
			ID: 1,
			TMDB_ID: 181,
			Title: "The Hacker",
			ReleaseYear: 2022,
			Genres: []models.Genre{
				{
					ID: 1,
					Name: "Thriller",
				},
			},
			Keywords: []string{},
			Casting: []models.Actor {
				{
					ID: 1,
					FirstName: "Max",
					LastName: "Perculin",
				},
			},


		},
			{
			ID: 2,
			TMDB_ID: 182,
			Title: "The GoJS lover",
			ReleaseYear: 2025,
			Genres: []models.Genre{
				{
					ID: 3,
					Name: "Tech",
				},
			},
			Keywords: []string{},
			Casting: []models.Actor {
				{
					ID: 1,
					FirstName: "Max",
					LastName: "Perculin",
				},
			},


		},
	}

	h.writeJSONResponse(w, movies)
}


func (h *MovieHandler) GetRandomMovies(w http.ResponseWriter, r *http.Request) {
	randomMovies := []models.Movie {
		{
			ID: 1,
			TMDB_ID: 181,
			Title: "The Hacker Random",
			ReleaseYear: 2022,
			Genres: []models.Genre{
				{
					ID: 1,
					Name: "Thriller",
				},
			},
			Keywords: []string{},
			Casting: []models.Actor {
				{
					ID: 1,
					FirstName: "Max",
					LastName: "Perculin",
				},
			},


		},
			{
			ID: 2,
			TMDB_ID: 182,
			Title: "The GoJS lover Random",
			ReleaseYear: 2025,
			Genres: []models.Genre{
				{
					ID: 3,
					Name: "Tech",
				},
			},
			Keywords: []string{},
			Casting: []models.Actor {
				{
					ID: 1,
					FirstName: "Max",
					LastName: "Perculin",
				},
			},


		},
	}

	h.writeJSONResponse(w, randomMovies)
}


func (h *MovieHandler) writeJSONResponse(w http.ResponseWriter, data  interface{}) {
	w.Header().Set("Content-Type", "application/json")

	if err := json.NewEncoder(w).Encode(data); err != nil {
		http.Error(w, "Internal Server Error", http.StatusInternalServerError)
	}
}