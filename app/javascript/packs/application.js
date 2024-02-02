// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@popperjs/core")
global.$ = require("jquery")
require("@nathanvda/cocoon")
import Rails from "@rails/ujs"
import { GistClient } from "gist-client"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import 'bootstrap'
import { Tooltip, Popover } from "bootstrap"
import "channels"
import './ranks'

require("../stylesheets/application.scss")

window.GistClient = new GistClient()
Rails.start()
Turbolinks.start()
ActiveStorage.start()

// If you're using Turbolinks. Otherwise simply use: jQuery(function () {
document.addEventListener("turbolinks:load", () => {
    // Both of these are from the Bootstrap 5 docs
    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
    var tooltipList = tooltipTriggerList.map(function(tooltipTriggerEl) {
        return new Tooltip(tooltipTriggerEl)
    })

    var popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'))
    var popoverList = popoverTriggerList.map(function(popoverTriggerEl) {
        return new Popover(popoverTriggerEl)
    })
})
