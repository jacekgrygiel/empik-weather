import Foundation
public protocol OpenWeatherServiceType {
    func search(for city: String) async throws -> SearchResponse.WeatherData
}

public final class OpenWeatherService: OpenWeatherServiceType {
    private let network: NetworkingType
    
    public init(network: NetworkingType) {
        self.network = network
    }

    public func search(for city: String) async throws -> SearchResponse.WeatherData {

        try await withCheckedThrowingContinuation { continuation in
            network.request(request: SearchRequest(cityName: city), responseType: SearchResponse.self) { result in
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
