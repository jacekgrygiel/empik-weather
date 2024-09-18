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

    let dataSource: SearchCityDataSourceType

    weak var view: SearchCityViewControllerProtocol?

    init(
        coordinator: CoordinatorType,
        dataSource: SearchCityDataSourceType,
        openWeatherService: OpenWeatherServiceType
    ) {
        self.coordinator = coordinator
        self.dataSource = dataSource
        self.openWeatherService = openWeatherService
    }

    func search(name: String) async throws {
        let result = try await openWeatherService.search(for: name)
        self.dataSource.items = [result]
    }

    private func isValidCityName(_ cityName: String) -> Bool {
        let regex = "^[A-Za-ząćęłńóśźżĄĆĘŁŃÓŚŹŻ ]+$"
        let cityPredicate = NSPredicate(format:"SELF MATCHES %@", regex)
        return cityPredicate.evaluate(with: cityName)
    }
}
