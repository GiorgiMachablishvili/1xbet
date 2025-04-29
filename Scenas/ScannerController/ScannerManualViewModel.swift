

import Foundation

class ScannerManualViewModel {
    var selectedUnit: Unit = .km
    var hours: Int = 0
    var minutes: Int = 0
    var seconds: Int = 0
    var distance: Double = 0

    enum Unit {
        case km
        case miles
    }

    var speedString: String {
        let totalHours = Double(hours) + Double(minutes) / 60 + Double(seconds) / 3600
        guard totalHours > 0 && distance > 0 else { return "0" }

        let speed = distance / totalHours
        return String(format: "%.1f", speed)
    }

    func updateTime(hours: Int, minutes: Int, seconds: Int) {
        self.hours = min(hours, 99)
        self.minutes = min(minutes, 59)
        self.seconds = min(seconds, 59)
    }

    func updateDistance(_ distance: Double) {
        self.distance = distance
    }

    func setUnit(_ unit: Unit) {
        selectedUnit = unit
    }

    func getUnitLabel() -> String {
        return selectedUnit == .km ? "Km" : "Miles"
    }

    func getSpeedUnitLabel() -> String {
        return selectedUnit == .km ? "km/h" : "miles/h"
    }
}
