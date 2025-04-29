

import UIKit

class ExercisesViewModel {

    private(set) var exerciseOptions: [ExerciseStatModel] = [
        .init(workoutName: "Treadmill", workoutIconName: "treadmill", distance: "658.83", activityCount: "14"),
        .init(workoutName: "Swimming", workoutIconName: "swimming", distance: "658.83", activityCount: "14"),
        .init(workoutName: "Exercise bike", workoutIconName: "bike", distance: "658.83", activityCount: "14"),
        .init(workoutName: "Running outside", workoutIconName: "run", distance: "658.83", activityCount: "14"),
        .init(workoutName: "Ski walking", workoutIconName: "ski", distance: "658.83", activityCount: "14"),
        .init(workoutName: "Walking", workoutIconName: "walk", distance: "658.83", activityCount: "14")
    ]

    var exerciseCount: Int {
        return exerciseOptions.count
    }
}
