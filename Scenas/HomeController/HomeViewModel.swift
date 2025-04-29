

import UIKit

class HomeViewModel {

    // MARK: - Properties
    private(set) var workoutsHistory: [WorkoutHistory] = [
        .init(workoutTitle: "Treadmill", workoutImage: "treadmill", workoutDistance: "658.83", workoutDuration: "3m25s", workoutData: "12:08 pm"),
        .init(workoutTitle: "Swimming", workoutImage: "swimming", workoutDistance: "658.83", workoutDuration: "3m25s", workoutData: "12:08 pm"),
        .init(workoutTitle: "Swimming", workoutImage: "swimming", workoutDistance: "658.83", workoutDuration: "3m25s", workoutData: "12:08 pm"),
        .init(workoutTitle: "Treadmill", workoutImage: "treadmill", workoutDistance: "658.83", workoutDuration: "3m25s", workoutData: "12:08 pm"),
        .init(workoutTitle: "Swimming", workoutImage: "swimming", workoutDistance: "658.83", workoutDuration: "3m25s", workoutData: "12:08 pm"),
        .init(workoutTitle: "Ski", workoutImage: "ski", workoutDistance: "658.83", workoutDuration: "3m25s", workoutData: "12:08 pm"),
        .init(workoutTitle: "Treadmill", workoutImage: "treadmill", workoutDistance: "658.83", workoutDuration: "3m25s", workoutData: "12:08 pm"),
        .init(workoutTitle: "Swimming", workoutImage: "swimming", workoutDistance: "658.83", workoutDuration: "3m25s", workoutData: "12:08 pm"),
        .init(workoutTitle: "Ski", workoutImage: "ski", workoutDistance: "658.83", workoutDuration: "3m25s", workoutData: "12:08 pm"),
        .init(workoutTitle: "Running outside", workoutImage: "run", workoutDistance: "658.83", workoutDuration: "3m25s", workoutData: "12:08 pm")
    ]

    var hasWorkouts: Bool {
        return !workoutsHistory.isEmpty
    }

    var workoutsCount: Int {
        return workoutsHistory.count
    }
}

