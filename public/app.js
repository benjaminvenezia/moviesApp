//This object can be called anywhere
import {API} from "./services/API.js";
import "./components/AnimatedLoading.js"

import {HomePage} from "./components/HomePage.js";

//Anoter way to add template. With Javascript.
/*window.addEventListener("DOMContentLoaded", event => {
    document.querySelector("main").appendChild(
        new HomePage()
    )
})*/

window.app = {
    search: (event) => {
        event.preventDefault()
        const q = document.querySelector("input[type=search]").value


    },
    apilol: API
}