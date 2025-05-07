import { Controller } from "@hotwired/stimulus"
import Sortable from "sortablejs"

// Connects to data-controller="sortable"
export default class extends Controller {
  static values = { url: String }

  connect() {
    this.sortable = Sortable.create(this.element, {
      animation: 150,
      handle: '.drag-handle', // Define apenas o elemento com a classe drag-handle como manipulador de arrasto
      onEnd: this.end.bind(this)
    })
  }

  end(event) {
    const disciplineId = this.element.closest('[data-discipline-id]').dataset.disciplineId

    const ids = Array.from(this.element.children).map(el => el.dataset.id)
    fetch(`${disciplineId}/sortable`, {
      method: "PATCH",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector("[name='csrf-token']").content
      },
      body: JSON.stringify({ order: ids })
    })
  }
}
