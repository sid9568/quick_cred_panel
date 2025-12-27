import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "menu",
    "bankmenu",
    "payment",
    "rechargemenu"
  ]

  connect() {
    this.boundClick = this.handleOutsideClick.bind(this)
    document.addEventListener("click", this.boundClick)
  }

  disconnect() {
    document.removeEventListener("click", this.boundClick)
  }

  toggle(event) {
    event.stopPropagation()

    const menuName = event.currentTarget.dataset.menu
    if (!menuName) return

    this.hideAll()

    const target = this[`${menuName}Target`]
    if (target) {
      target.classList.toggle("hidden")
    }
  }

  handleOutsideClick(event) {
    if (!this.element.contains(event.target)) {
      this.hideAll()
    }
  }

  hideAll() {
    const allTargets = [
      ...this.menuTargets,
      ...this.bankmenuTargets,
      ...this.paymentTargets,
      ...this.rechargemenuTargets
    ]

    allTargets.forEach((el) => {
      el.classList.add("hidden")
    })
  }
}
