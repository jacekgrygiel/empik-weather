//
//  SearchCityViewModel.swift
//  EmpikInterview
//
//  Created by Jacek Grygiel on 18/09/2024.
//

import Foundation
import Combine

@MainActor
final class SearchCityViewModel {

    private unowned var coordinator: CoordinatorType
    private var cancellables = Set<AnyCancellable>()
    let dataSource: SearchCityDataSourceType

    weak var view: SearchCityViewControllerProtocol?

    init(coordinator: CoordinatorType, dataSource: SearchCityDataSourceType) {
        self.coordinator = coordinator
        self.dataSource = dataSource
    }

    func search(name: String) async throws {

    }
}
