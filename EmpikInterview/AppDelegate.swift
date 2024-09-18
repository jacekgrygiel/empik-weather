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
        return nav
    }()

    var window: UIWindow?

    private lazy var appCoordinator = AppCoordinator(
        controller: navigationController,
        parent: nil
    )

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        appCoordinator.start()

        return true
    }

}

