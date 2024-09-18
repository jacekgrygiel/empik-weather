import Foundation
import Networking

struct Environment {
    static let network = Networking(environment: .init(apiKey: "757334128a26cea4141d93a432fa1fe7", url: "https://api.openweathermap.org/"))

    let openWeatherService: OpenWeatherServiceType = OpenWeatherService(network: network)
    let citySearchService: CitySearchServiceType = CitySearchService()
}

extension Environment {
    static let current = Self()
}
