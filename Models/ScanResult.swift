

import Foundation

struct ScanResult {
    var hours: Int
    var minutes: Int
    var seconds: Int
    var distance: Double

    init(hours: Int = 0, minutes: Int = 0, seconds: Int = 0, distance: Double = 0.0) {
        self.hours = hours
        self.minutes = minutes
        self.seconds = seconds
        self.distance = distance
    }
}
