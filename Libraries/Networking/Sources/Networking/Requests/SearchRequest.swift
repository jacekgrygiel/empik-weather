import Foundation
struct SearchRequest: RequestType {
    var path: String { "/weather" }
    var method: HTTPMethod = .get
    var cityName: String
    var parameters: String? = nil
    var authRequired: Bool { true }

    var query: [URLQueryItem] { 
        [
        .init(name: "q", value: cityName),
        .init(name: "units", value: "metric"),
        .init(name: "lang", value: "pl")
        ]
    }
}

public struct SearchResponse: ResponseType {
    public typealias Response = WeatherData

    public struct WeatherData: Codable {
        let coord: Coord
        public let weather: [Weather]
        let base: String
        let main: Main
        let visibility: Int
        let wind: Wind
        let clouds: Clouds
        let dt: Int
        let sys: Sys
        let timezone: Int
        let id: Int
        let name: String
        let cod: Int
    }

    // Coordinates
    struct Coord: Codable {
        let lon: Double
        let lat: Double
    }

    // Weather conditions
    public struct Weather: Codable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }

    // Main weather data
    struct Main: Codable {
        let temp: Double
        let feelsLike: Double
        let tempMin: Double
        let tempMax: Double
        let pressure: Int
        let humidity: Int
        let seaLevel: Int
        let grndLevel: Int

        // Coding keys to map JSON keys to property names
        enum CodingKeys: String, CodingKey {
            case temp
            case feelsLike = "feels_like"
            case tempMin = "temp_min"
            case tempMax = "temp_max"
            case pressure
            case humidity
            case seaLevel = "sea_level"
            case grndLevel = "grnd_level"
        }
    }

    // Wind data
    struct Wind: Codable {
        let speed: Double
        let deg: Int
        let gust: Double
    }

    // Cloud coverage
    struct Clouds: Codable {
        let all: Int
    }

    // System data
    struct Sys: Codable {
        let type: Int
        let id: Int
        let country: String
        let sunrise: Int
        let sunset: Int
    }

}

