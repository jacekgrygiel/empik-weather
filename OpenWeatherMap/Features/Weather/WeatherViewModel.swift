//
//  WeatherViewModel.swift
//  
//
//  Created by Jacek Grygiel on 18/09/2024.
//

import Foundation
import Combine
import Networking

@MainActor
final class WeatherViewModel {

    private unowned var coordinator: CoordinatorType
    private let openWeatherService: OpenWeatherServiceType
    let weather: WeatherResponse.WeatherData

    let dataSource: WeatherDataSourceType

    weak var view: WeatherViewControllerProtocol?

    init(
        weather: WeatherResponse.WeatherData,
        coordinator: CoordinatorType,
        dataSource: WeatherDataSourceType,
        openWeatherService: OpenWeatherServiceType
    ) {
        self.weather = weather
        self.coordinator = coordinator
        self.dataSource = dataSource
        self.openWeatherService = openWeatherService
    }

    func viewDidLoad() {
        load()
    }

    private func load() {
        Task { [weak self] in
            guard let self, let cityName = self.weather.name else { return }

            let value = try await self.openWeatherService.forecastWeather(for: cityName)
            self.dataSource.items = value.list
            self.view?.reload()
        }
    }

    private func isValidCityName(_ cityName: String) -> Bool {
        let regex = RegexPattern.cityRegex
        let cityPredicate = NSPredicate(format:"SELF MATCHES %@", regex)
        return cityPredicate.evaluate(with: cityName)
    }
}
