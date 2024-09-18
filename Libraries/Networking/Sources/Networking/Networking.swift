// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import Combine

public struct Environment {
    let apiKey: String
    let url: String
    let requestBuilder: RequestBuilder

    public init(apiKey: String, url: String) {
        self.apiKey = apiKey
        self.url = url
        self.requestBuilder = RequestBuilder(
            config: ConfigURL(apiKey: apiKey, url: url)
        )
    }
}

public enum NetworkingError: Error {
    case `default`(error: Error)
    case invalidUrl
    case unknown
    case unauthenticated
    case unsupportedMediaType
    case unprocessableEntity
    case invalidResponse(response: HTTPURLResponse)

    static func map(_ error: Error) -> NetworkingError {
        .default(error: error)
    }
}

public protocol NetworkingInterceptor {
    func transform<Req: RequestType>(urlRequest: inout URLRequest, request: Req)
}

public protocol NetworkingType {
    func request<Req: RequestType, Res: ResponseType>(request: Req, responseType: Res.Type, completion: @escaping (Result<Res.Response, NetworkingError>) -> Void)

    var interceptors: [NetworkingInterceptor] { get }
}

public struct Networking: NetworkingType {

    private let session: URLSession
    private let environment: Environment

    public var interceptors: [NetworkingInterceptor]

    public init(session: URLSession = .shared,
                environment: Environment,
                interceptors: [NetworkingInterceptor] = []) {
        self.session = session
        self.environment = environment
        self.interceptors = interceptors
    }

    public func request<Req: RequestType, Res: ResponseType>(request: Req, responseType: Res.Type, completion: @escaping (Result<Res.Response, NetworkingError>) -> Void) {
        do {
            var urlRequest = try environment.requestBuilder.build(request: request)

            interceptors.forEach { $0.transform(urlRequest: &urlRequest, request: request) }

            Logger.log(.debug, "Request: \(urlRequest)")
            Logger.log(.debug, "Headers: \(urlRequest.allHTTPHeaderFields ?? [:])")

            session.dataTask(with: urlRequest) { data, response, error in
                Logger.log(.debug, "Raw: \(String(data: data ?? Data(), encoding: .utf8) ?? "")")

                guard let httpResponse = (response as? HTTPURLResponse) else {
                    completion(.failure(NetworkingError.unknown))
                    return
                }
                switch httpResponse.statusCode {
                case 200..<300:
                    break
                case 401:
                    completion(.failure(NetworkingError.unauthenticated))
                    return
                default:
                    completion(.failure(NetworkingError.invalidResponse(response: httpResponse)))
                    return
                }
                guard let data, let response else { return }
                do {
                    let value = try Res.decode(from: response, data: data)
                    completion(.success(value))
                } catch {
                    completion(.failure(NetworkingError.default(error: error)))
                }
            }.resume()
        } catch {
            completion(.failure(NetworkingError.default(error: error)))
        }
    }
}

extension JSONEncoder {
    static let api: JSONEncoder = {
        let decoder = JSONEncoder()
        return decoder
    }()
}

extension JSONDecoder {
    static let api: JSONDecoder = {
        let decoder = JSONDecoder()
        return decoder
    }()
}

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}

