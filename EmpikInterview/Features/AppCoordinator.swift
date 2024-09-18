//
//  ViewController.swift
//  EmpikInterview
//
//  Created by Jacek Grygiel on 18/09/2024.
//

import UIKit
import Networking

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
        guard let navigationController = controller as? UINavigationController else { return }

        switch (to, transferable) {
        case (.search, _):
            let searchViewModel = SearchCityViewModel(
                coordinator: self,
                dataSource: SearchCityDataSource(),
                openWeatherService: Environment.current.openWeatherService, 
                citySearchService: Environment.current.citySearchService
            )
            let searchViewController = SearchCityViewController(viewModel: searchViewModel)
            navigationController.pushViewController(searchViewController, animated: true)
        case (.weather, let weather as WeatherResponse.WeatherData):
            let weatherViewModel = WeatherViewModel(
                weather: weather,
                coordinator: self,
                dataSource: WeatherDataSource(),
                openWeatherService: Environment.current.openWeatherService
            )
            let weatherViewController = WeatherViewController(viewModel: weatherViewModel)
            navigationController.pushViewController(weatherViewController, animated: true)
        default:
            break
        }
    }
}
