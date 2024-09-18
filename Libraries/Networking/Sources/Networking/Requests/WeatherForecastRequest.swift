import Foundation

struct WeatherForecastRequest: RequestType {
    var path: String { "/data/2.5/forecast" }
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


public struct WeatherForecastResponse: ResponseType {

    public typealias Response = WeatherForecast

    // Main response model
    public struct WeatherForecast: Codable {
        let cod: String?
        let message: Int?
        let cnt: Int?
        public let list: [ForecastItem]
    }

    // Forecast item model
    public struct ForecastItem: Codable {
        public let dt: Int
        public let main: Main
        let weather: [WeatherCondition]?
        let clouds: Clouds?
        let wind: Wind?
        let visibility: Int?
        let pop: Double?
        let sys: Sys?
        let dt_txt: String?
    }

    // Main weather parameters model
    public struct Main: Codable {
        public let temp: Double
        let feels_like: Double
        let temp_min: Double
        let temp_max: Double
        let pressure: Int
        let sea_level: Int
        let grnd_level: Int
        let humidity: Int
        let temp_kf: Double
    }

    // Weather condition model
    struct WeatherCondition: Codable {
        let id: Int?
        let main: String?
        let description: String?
        let icon: String?
    }

    // Clouds model
    struct Clouds: Codable {
        let all: Int?
    }

    // Wind model
    struct Wind: Codable {
        let speed: Double?
        let deg: Int?
        let gust: Double?
    }

    // Additional info model
    struct Sys: Codable {
        let pod: String
    }

}
