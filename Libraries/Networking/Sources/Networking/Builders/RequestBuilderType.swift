import Foundation

public protocol RequestBuilderType {
    init(config: ConfigURL)
}

public struct RequestBuilder: RequestBuilderType {

    public let config: ConfigURL

    public init(config: ConfigURL) {
        self.config = config
    }

    public func url<T: RequestType>(from request: T) throws -> URL? {
        guard let url = URL(string: config.url + request.path) else {
            throw NetworkingError.invalidUrl
        }
        return url
    }

    public func headers<T: RequestType>(from request: T) -> [String: String] {
        request.defaultHeaders
    }

    public func query<T: RequestType>(from request: T) -> [URLQueryItem] {
        let query = request.query
        return query
    }

    func build<T: RequestType>(request: T) throws ->  URLRequest {
        guard let initialUrl = try url(from: request),
              var components = URLComponents(url: initialUrl, resolvingAgainstBaseURL: true) else {
            throw NetworkingError.invalidUrl
        }

        var query = query(from: request)
        if request.authRequired {
            query.append(URLQueryItem(name: "appid", value: config.apiKey))
        }
        components.queryItems = query
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        
        guard let url = components.url else {
            throw NetworkingError.invalidUrl
        }

        var urlRequest = URLRequest(url: url, timeoutInterval: request.timeout)

        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.defaultHeaders.merging(
            headers(from: request), uniquingKeysWith: { $1 }
        )
        urlRequest.httpBody = try request.body(from: request.parameters)
        urlRequest.httpShouldHandleCookies = false

        return urlRequest
    }
}
