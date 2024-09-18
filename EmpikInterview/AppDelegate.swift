//
//  AppDelegate.swift
//  EmpikInterview
//
//  Created by Jacek Grygiel on 18/09/2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    private let navigationController: UINavigationController = {
        let nav = UINavigationController()
        nav.navigationBar.tintColor = .gray
        nav.navigationBar.setBackgroundImage(UIImage(), for: .default)
        nav.navigationBar.shadowImage = UIImage()
        nav.navigationBar.isTranslucent = true
        return nav
    }()

    var window: UIWindow?

    private lazy var appCoordinator = AppCoordinator(
        controller: navigationController,
        parent: nil
    )

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        window = UIWindow()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        appCoordinator.start()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

