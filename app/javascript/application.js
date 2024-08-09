// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import { Turbo } from "@hotwired/turbo-rails"
import "controllers"

Turbo.session.drive = false

import jquery from "jquery";
window.jQuery = jquery;
window.$ = jquery;

import Rails from "@rails/ujs"
Rails.start();
ActiveStorage.start()
channels.start()

import "./fetch_analysis_data"
import "./child_selection"
