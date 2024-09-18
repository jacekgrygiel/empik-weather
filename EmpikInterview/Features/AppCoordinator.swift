//
//  ViewController.swift
//  EmpikInterview
//
//  Created by Jacek Grygiel on 18/09/2024.
//

import UIKit

extension Navigation.Name {
    static let search: Self = "search"
    static let weather: Self = "weather"
}

class AppCoordinator: Coordinator {

    override init(controller: CoordinatorController, parent: CoordinatorType? = nil) {
        super.init(controller: controller, parent: parent)
    }

    override func start() {
        navigate(to: .search)
    }

    override func navigate(to: Navigation.Name, transferable: Transferable?) {
        switch to {
        case .search:
            break
        case .weather:
            break
        default:
            break
        }
    }
}
