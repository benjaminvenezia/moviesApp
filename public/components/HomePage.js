import {API} from "../services/API.js";
import {MovieItem} from "./MovieItem.js";

export class HomePage extends HTMLElement { //<home-page>
    //Custom method
    async render() {

        const topMovies = await API.getTopMovies()
        renderMoviesInList(topMovies, document.querySelector("#top-10 ul"))

        const randomMovies = await API.getRandomMovies()
        renderMoviesInList(randomMovies, document.querySelector("#random ul"))

        function renderMoviesInList(movies, ul) {
            clear(ul)

            movies.forEach(movie => {
                const li = document.createElement("li")
                li.appendChild(new MovieItem(movie))
                ul.appendChild(li)
            })
        }

        function clear(ul) {
            ul.innerText = ""
        }
    }

    //THis Function will be executed when the component will be pushed to the DOM
    connectedCallback() {
        //Template is not usable directly, this class VS object
        const template = document.getElementById("template-home")

        const content = template.content.cloneNode(true)

        //We push content into JS, not template directly.
        this.appendChild(content)

        this.render()
    }
}

customElements.define("home-page", HomePage)