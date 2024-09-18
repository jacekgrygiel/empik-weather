import Foundation

public protocol ResponseType {
    associatedtype Response
    static func decode(from response: URLResponse, data: Data) throws -> Response
}

public extension ResponseType where Response: Decodable {
    static func decode(from response: URLResponse, data: Data) throws -> Response {
        try JSONDecoder.api.decode(Response.self, from: data)
    }
}

public extension ResponseType where Response == Void {
    static func decode(from response: URLResponse, data: Data) throws -> Response {
        Void()
    }
}

public extension ResponseType where Response == String {
    static func decode(from response: URLResponse, data: Data) throws -> Response {
        String(data: data, encoding: .utf8) ?? ""
    }
}
