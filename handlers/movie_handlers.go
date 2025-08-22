package handlers

import (
	"encoding/json"
	"net/http"

	"github.com/benjaminvenezia/app/data"
	"github.com/benjaminvenezia/app/logger"
)

type MovieHandler struct {
	Storage data.MovieStorage
	Logger  *logger.Logger
}

func (h *MovieHandler) GetTopMovies(w http.ResponseWriter, r *http.Request) {
	topMovies, err := h.Storage.GetTopMovies()

	if err != nil {
		http.Error(w, "Internal Error", http.StatusInternalServerError)
		h.Logger.Error("Get Top movies Error", err)
	}
	h.writeJSONResponse(w, topMovies)
}

func (h *MovieHandler) GetRandomMovies(w http.ResponseWriter, r *http.Request) {
	randomMovies, err := h.Storage.GetRandomMovies()

	if err != nil {
		http.Error(w, "Internal Error", http.StatusInternalServerError)
		h.Logger.Error("Get Random movies Error", err)
	}

	h.writeJSONResponse(w, randomMovies)
}

func (h *MovieHandler) writeJSONResponse(w http.ResponseWriter, data interface{}) {
	w.Header().Set("Content-Type", "application/json")
	if err := json.NewEncoder(w).Encode(data); err != nil {
		h.Logger.Error("JSON Encoding error", err)
		http.Error(w, "Internal Server Error", http.StatusInternalServerError)
	}
}
