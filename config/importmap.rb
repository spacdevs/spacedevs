# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"

pin "uikit", to: "https://cdn.jsdelivr.net/npm/uikit@3.21.16/dist/js/uikit.min.js"
pin "uikit-icons", to: "https://cdn.jsdelivr.net/npm/uikit@3.21.16/dist/js/uikit-icons.min.js"
pin "trix"
pin "@rails/actiontext", to: "actiontext.esm.js"
