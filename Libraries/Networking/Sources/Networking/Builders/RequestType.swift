import Foundation

public protocol RequestType {
    associatedtype Request
    var path: String { get }
    var method: HTTPMethod { get }
    var timeout: TimeInterval { get }
    var defaultHeaders: [String: String] { get }
    var query: [URLQueryItem] { get }
    var parameters: Request? { get }
    var authRequired: Bool { get }

    func body(from request: Request?) throws -> Data?
}

public extension RequestType {
    var timeout: TimeInterval { 60.0 }
    var authRequired: Bool { false }
    var defaultHeaders: [String: String] {
        ["Content-Type": "application/json"]
    }
    var query: [URLQueryItem] {
        []
    }
}

public extension RequestType where Request: Encodable {
    func body(from request: Request?) throws -> Data? {
        guard let request = request else { return nil }
        return try JSONEncoder.api.encode(request)
    }
}

public extension RequestType {
    func body(from request: Request?) throws -> Data? {
        nil
    }
}
