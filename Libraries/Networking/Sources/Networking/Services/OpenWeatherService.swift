import Foundation
public protocol OpenWeatherServiceType {
    func cities(for name: String) async throws -> [CityResponse.City]
    func weather(for city: String) async throws -> WeatherResponse.WeatherData
    func forecastWeather(for city: String) async throws -> WeatherForecastResponse.WeatherForecast

}

public final class OpenWeatherService: OpenWeatherServiceType {
    private let network: NetworkingType
    
    public init(network: NetworkingType) {
        self.network = network
    }

    public func cities(for name: String) async throws -> [CityResponse.City] {
        try await withCheckedThrowingContinuation { continuation in
            network.request(request: CityRequest(name: name), responseType: CityResponse.self) { result in
                switch result {
                case .success(let value):
                    continuation.resume(returning: value)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }

    public func weather(for city: String) async throws -> WeatherResponse.WeatherData {
        try await withUnsafeThrowingContinuation { continuation in
            network.request(request: WeatherRequest(cityName: city), responseType: WeatherResponse.self) { result in
                switch result {
                case .success(let value):
                    continuation.resume(returning: value)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }

    public func forecastWeather(for city: String) async throws -> WeatherForecastResponse.WeatherForecast {
        try await withCheckedThrowingContinuation { continuation in
            network.request(request: WeatherForecastRequest(cityName: city), responseType: WeatherForecastResponse.self) { result in
                switch result {
                case .success(let value):
                    continuation.resume(returning: value)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }

}
