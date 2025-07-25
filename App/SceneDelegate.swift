

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)
        let mainViewController = Onboarding()
        window?.rootViewController = UINavigationController(rootViewController: mainViewController)
        if let navigationController = window?.rootViewController as? UINavigationController {
                navigationController.setNavigationBarHidden(true, animated: false)
            }

//        ifUserISCreatedOrNot()
        window?.makeKeyAndVisible()
    }


    func ifUserISCreatedOrNot() {
        if let userId = UserDefaults.standard.string(forKey: "userId"), !userId.isEmpty {
            print(userId)
            let mainViewController = Onboarding() /*SignInController()*/ 
            UserDefaults.standard.setValue(false, forKey: "isGuestUser")
            let navigationController = UINavigationController(rootViewController: mainViewController)
            changeRootViewController(navigationController)
            if let navigationController = window?.rootViewController as? UINavigationController {
                navigationController.setNavigationBarHidden(true, animated: false)
            }
        } else {
            let signInViewController = Onboarding()
            let navigationController = UINavigationController(rootViewController: signInViewController)
            changeRootViewController(navigationController)
            if let navigationController = window?.rootViewController as? UINavigationController {
                navigationController.setNavigationBarHidden(true, animated: false)
            }
        }
    }

    func changeRootViewController(_ rootViewController: UIViewController, animated: Bool = true) {
        // Get the current SceneDelegate's window
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let sceneDelegate = windowScene.delegate as? SceneDelegate,
              let window = sceneDelegate.window else { return }

        if animated {
            UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: {
                window.rootViewController = rootViewController
            })
        } else {
            window.rootViewController = rootViewController
        }
        window.makeKeyAndVisible()
    }

//    private func setupInitialRootViewController() {
//        if let userId = UserDefaults.standard.string(forKey: "userId"), !userId.isEmpty {
//            let mainViewController = MainViewControllerTab()
//            UserDefaults.standard.setValue(false, forKey: "isGuestUser")
//            let navigationController = UINavigationController(rootViewController: mainViewController)
//            changeRootViewController(navigationController)
//        } else {
//            let signInViewController = SignInView()
//            let navigationController = UINavigationController(rootViewController: signInViewController)
//            changeRootViewController(navigationController)
//        }
//    }


    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}

