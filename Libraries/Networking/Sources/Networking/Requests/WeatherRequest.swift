import Foundation
struct WeatherRequest: RequestType {
    var path: String { "/data/2.5/weather" }
    var method: HTTPMethod = .get
    var cityName: String
    var parameters: String? = nil
    var authRequired: Bool { true }

    var query: [URLQueryItem] { 
        [
        .init(name: "q", value: cityName),
        .init(name: "units", value: "metric")
        ]
    }
}

public struct WeatherResponse: ResponseType {
    public typealias Response = WeatherData

    public struct WeatherData: Codable {
        let coord: Coord
        public let weather: [Weather]
        public let base: String
        public let main: Main
        public let visibility: Int
        public let wind: Wind
        let clouds: Clouds
        let dt: Int
        let sys: Sys
        public let timezone: Int
        let id: Int
        public let name: String
        let cod: Int
    }

    // Coordinates
    public struct Coord: Codable {
        let lon: Double
        let lat: Double
    }

    // Weather conditions
    public struct Weather: Codable {
        public let id: Int
        public let main: String
        public let description: String
        public let icon: String
    }

    // Main weather data
    public  struct Main: Codable {
        public let temp: Double
        public let feelsLike: Double
        public let tempMin: Double
        public let tempMax: Double
        public let pressure: Int
        public let humidity: Int
        public let seaLevel: Int
        public let grndLevel: Int

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
    public struct Wind: Codable {
        let speed: Double
        let deg: Int
        let gust: Double
    }

    // Cloud coverage
    public struct Clouds: Codable {
        let all: Int
    }

    // System data
    public struct Sys: Codable {
        let type: Int
        let id: Int
        let country: String
        let sunrise: Int
        let sunset: Int
    }

}

