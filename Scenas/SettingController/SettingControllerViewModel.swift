

import Foundation

class SettingControllerViewModel {

    private(set) var exerciseOptions: [ExerciseStatModel] = [
        .init(workoutName: "Treadmill", workoutIconName: "treadmill", distance: "658.83", activityCount: "14"),
        .init(workoutName: "Swimming", workoutIconName: "swimming", distance: "658.83", activityCount: "14"),
        .init(workoutName: "Exercise bike", workoutIconName: "bike", distance: "658.83", activityCount: "14"),
        .init(workoutName: "Running outside", workoutIconName: "run", distance: "658.83", activityCount: "14"),
        .init(workoutName: "Ski walking", workoutIconName: "ski", distance: "658.83", activityCount: "14"),
        .init(workoutName: "Walking", workoutIconName: "walk", distance: "658.83", activityCount: "14")
    ]

    private(set) var supportButtons: [SupportButtonStatModel] = [
        .init(name: "Terms of Use", image: "plus"),
        .init(name: "Privacy Policy", image: "plus"),
        .init(name: "Support", image: "plus"),
        .init(name: "Rate US", image: "plus")
    ]


    var exerciseOptionsCount: Int {
        return exerciseOptions.count
    }

    var supportButtonsCount: Int {
        return supportButtons.count
    }
}
