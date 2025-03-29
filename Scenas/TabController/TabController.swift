

import UIKit

class TabController: UITabBarController,  UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.mainViewsBackgroundYellow
        self.delegate = self

        navigationItem.hidesBackButton = true
        // Instantiate the three view controllers
        let homeVC = HomeController()
        let exercisesVC = ExercisesController()
        let scannerVC = ScannerController()
        let calendarVC = CalendarController()
        let settingVC = SettingController()

        // Create Navigation Controllers for each (optional for navigation stack)
        let home = UINavigationController(rootViewController: homeVC)
        let exercises = UINavigationController(rootViewController: exercisesVC)
        let scanner = UINavigationController(rootViewController: scannerVC)
        let calendar = UINavigationController(rootViewController: calendarVC)
        let setting = UINavigationController(rootViewController: settingVC)

        home.navigationBar.isHidden = true
        exercises.navigationBar.isHidden = true
        scanner.navigationBar.isHidden = true
        calendar.navigationBar.isHidden = true
        setting.navigationBar.isHidden = true

        // Configure tab bar items
        home.tabBarItem = UITabBarItem(
            title: "",
            image: resizeImage(named: "home", size: CGSize(width: 30 * Constraint.xCoeff, height: 30 * Constraint.yCoeff)
            ),
            tag: 0
        )
        exercises.tabBarItem = UITabBarItem(
            title: "",
            image: resizeImage(named: "exercises", size: CGSize(width: 35 * Constraint.xCoeff, height: 35 * Constraint.yCoeff)),
            tag: 1
        )
        scanner.tabBarItem = UITabBarItem(
            title: "",
            image: resizeImage(named: "scanner", size: CGSize(width: 50 * Constraint.xCoeff, height: 50 * Constraint.yCoeff)),
            tag: 2
        )
//        let scannerTabBarItem = UITabBarItem(
//            title: "",
//            image: resizeImage(named: "scanner", size: CGSize(width: 30 * Constraint.xCoeff, height: 30 * Constraint.yCoeff))?.withRenderingMode(.alwaysOriginal),
//            selectedImage: resizeImage(named: "scanner", size: CGSize(width: 30 * Constraint.xCoeff, height: 30 * Constraint.yCoeff))?.withRenderingMode(.alwaysOriginal)
//        )
//        scannerTabBarItem.tag = 2
//        scanner.tabBarItem = scannerTabBarItem

        calendar.tabBarItem = UITabBarItem(
            title: "",
            image: resizeImage(named: "calendar", size: CGSize(width: 30 * Constraint.xCoeff, height: 30 * Constraint.yCoeff)),
            tag: 3
        )
        setting.tabBarItem = UITabBarItem(
            title: "",
            image: resizeImage(named: "setting", size: CGSize(width: 30 * Constraint.xCoeff, height: 30 * Constraint.yCoeff)),
            tag: 4
        )

        // Assign view controllers to the Tab Bar
        viewControllers = [home, exercises, scanner, calendar, setting]

        home.tabBarItem.imageInsets = UIEdgeInsets(
            top: 10 * Constraint.yCoeff,
            left: 0 * Constraint.xCoeff,
            bottom: 0 * Constraint.yCoeff,
            right: 0 * Constraint.xCoeff
        )
        exercises.tabBarItem.imageInsets = UIEdgeInsets(
            top: 10 * Constraint.yCoeff,
            left: 0,
            bottom: 0 * Constraint.yCoeff,
            right: 0
        )
        scanner.tabBarItem.imageInsets = UIEdgeInsets(
            top: 10 * Constraint.yCoeff,
            left: 0,
            bottom: 0 * Constraint.yCoeff,
            right: 0
        )
        calendar.tabBarItem.imageInsets = UIEdgeInsets(
            top: 10 * Constraint.yCoeff,
            left: 0 * Constraint.xCoeff,
            bottom: 0 * Constraint.yCoeff,
            right: 0 * Constraint.xCoeff
        )
        setting.tabBarItem.imageInsets = UIEdgeInsets(
            top: 10 * Constraint.yCoeff,
            left: 0 * Constraint.xCoeff,
            bottom: 0 * Constraint.yCoeff,
            right: 0 * Constraint.xCoeff
        )

        // Style the Tab Bar (optional)
        tabBar.tintColor = .blueColor
        tabBar.unselectedItemTintColor = .whiteColor
        tabBar.barTintColor = UIColor.blueColor
        tabBar.isTranslucent = false
    }

    private func resizeImage(named: String, size: CGSize) -> UIImage? {
        guard let image = UIImage(named: named) else { return nil }
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { _ in
            image.draw(in: CGRect(origin: .zero, size: size))
        }
    }
}

