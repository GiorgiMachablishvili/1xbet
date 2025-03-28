

import Foundation

struct CalendarMonth {
    let title: String
    let days: [CalendarDay]
}

struct CalendarDay {
    let date: Date
    let isToday: Bool
    let activityCount: Int
    let isCurrentMonth: Bool
}

