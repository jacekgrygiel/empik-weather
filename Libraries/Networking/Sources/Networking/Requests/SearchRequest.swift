//
//  SearchRequest.swift
//
//
//  Created by Jacek Grygiel on 31/12/2023.
//

import Foundation
struct SearchRequest: RequestType {
    var path: String { "weather?q=\(cityName)&units=metric&lang=pl" }
    var method: HTTPMethod = .get
    var cityName: String
    var parameters: String? = nil
    var authRequired: Bool { false }
}

public struct SearchResponse: ResponseType {
    public typealias Response = WeatherData

    public struct WeatherData: Codable {
        public let main: Main
        public let name: String
        public let weather: [Weather]
    }

    public struct Main: Codable {
        public let temp: Double
    }

    public struct Weather: Codable {
        public let description: String
    }
}

