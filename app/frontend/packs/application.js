import Rails from "@rails/ujs"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "../styles/application"

Rails.start()
ActiveStorage.start()

const images = require.context('../images', true)
