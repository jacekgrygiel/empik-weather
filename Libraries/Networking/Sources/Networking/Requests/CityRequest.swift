import Foundation

struct CityRequest: RequestType {
    var path: String { "/geo/1.0/direct" }
    var method: HTTPMethod = .get
    var name: String
    var parameters: String? = nil
    var authRequired: Bool { true }

    var query: [URLQueryItem] {
        [
        .init(name: "q", value: "\(name)"),
        .init(name: "limit", value: "5")
        ]
    }
}

public struct CityResponse: ResponseType {
    public typealias Response = [City]


    public struct City: Codable {
        public let name: String
        let localNames: [String: String]?
        let lat: Double
        let lon: Double
        public let country: String
        public let state: String?

        enum CodingKeys: String, CodingKey {
            case name
            case localNames = "local_names"
            case lat
            case lon
            case country
            case state
        }
    }
}
