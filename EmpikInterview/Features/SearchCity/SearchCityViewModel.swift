//
//  SearchCityViewModel.swift
//  EmpikInterview
//
//  Created by Jacek Grygiel on 18/09/2024.
//

import Foundation
import Combine
import Networking

@MainActor
final class SearchCityViewModel {

    private unowned var coordinator: CoordinatorType
    private var cancellables = Set<AnyCancellable>()
    private let openWeatherService: OpenWeatherServiceType
    private let citySearchService: CitySearchServiceType

    let dataSource: SearchCityDataSourceType

    weak var view: SearchCityViewControllerProtocol?

    init(
        coordinator: CoordinatorType,
        dataSource: SearchCityDataSourceType,
        openWeatherService: OpenWeatherServiceType,
        citySearchService: CitySearchServiceType
    ) {
        self.coordinator = coordinator
        self.dataSource = dataSource
        self.openWeatherService = openWeatherService
        self.citySearchService = citySearchService

        bindSelection()
    }
    
    private func bindSelection() {
        dataSource.selectedCity
            .sink { [weak self] city in
                guard let cityName = city.name else { return }
                self?.fetchWeather(cityName: cityName)
            }
            .store(in: &cancellables)
    }

    private func fetchWeather(cityName: String) {
        Task { [weak self] in
            let weatherData = try await self?.openWeatherService.weather(for: cityName)
            self?.coordinator.navigate(to: .weather, transferable: weatherData?.weather)
        }
    }

    func search(name: String) async throws {
        if isValidCityName(name) {
            let result = try await openWeatherService.cities(for: name)
                .map {
                    City(name: $0.name, state: $0.state, country: $0.country)
                }
            self.dataSource.items = result
        } else {
            throw RegexError.invalid
        }
    }

    private func isValidCityName(_ cityName: String) -> Bool {
        let regex = RegexPattern.cityRegex
        let cityPredicate = NSPredicate(format:"SELF MATCHES %@", regex)
        return cityPredicate.evaluate(with: cityName)
    }
}

extension Array<WeatherResponse.Weather> : Transferable { }
