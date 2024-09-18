//
//  Environment.swift
//  EmpikInterview
//
//  Created by Jacek Grygiel on 18/09/2024.
//

import Foundation
import Networking

struct Environment {
    static let network = Networking(environment: .init(apiKey: "https://api.openweathermap.org/data/2.5", url: "bc0494a4ed2dab19be8fdd09627a7f6d"))
    
    let openWeatherService: OpenWeatherServiceType = OpenWeatherService(network: network)
}

extension Environment {
    static let current = Self()
}
