import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="timer"
export default class extends Controller {
  static targets = ["days", "hours", "min", "sec"]
  refreshInterval = 1000 // Set to 10 seconds (10000 milliseconds)
  newYearDate = "2025-01-01T00:00:00"

  connect() {
    this.setRemainingTime()
    this.startRefreshing()
  }

  setRemainingTime() {
    let diffTime = Math.abs(
      new Date().valueOf() - new Date(this.newYearDate).valueOf(),
    )
    let days = diffTime / (24 * 60 * 60 * 1000)
    let hours = (days % 1) * 24
    let minutes = (hours % 1) * 60
    let secs = (minutes % 1) * 60
    // Use Math.floor to get whole numbers for days, hours, minutes, and seconds
    days = Math.floor(days)
    hours = Math.floor(hours)
    minutes = Math.floor(minutes)
    secs = Math.floor(secs)
    // Format numbers to always show two digits
    // Update the targets with the remaining time
    this.daysTarget.textContent = days.toString().padStart(2, "0")
    this.hoursTarget.textContent = hours.toString().padStart(2, "0")
    this.minTarget.textContent = minutes.toString().padStart(2, "0")
    this.secTarget.textContent = secs.toString().padStart(2, "0")
  }

  startRefreshing() {
    this.refreshTimer = setInterval(() => {
      this.setRemainingTime()
    }, this.refreshInterval)
  }

  stopRefreshing() {
    if (this.refreshTimer) {
      clearInterval(this.refreshTimer)
    }
  }
}
