import Rails from "@rails/ujs"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "bootstrap/dist/js/bootstrap.js"


import "../styles/application"

import "../styles/events"

Rails.start()
ActiveStorage.start()

const images = require.context('../images', true)
