//
//  URLSessionNetworkClient.swift
//  CatGram
//

import Foundation

final class URLSessionNetworkClient: NetworkClient {

    private let session: URLSession
    private let decoder: JSONDecoder

    init(session: URLSession = .shared) {
        self.session = session

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        self.decoder = decoder
    }

    func get<T: Decodable>(_ url: URL) async throws -> T {
        let data: Data
        let response: URLResponse

        do {
            (data, response) = try await session.data(from: url)
        } catch let urlError as URLError {
            switch urlError.code {
            case .notConnectedToInternet, .networkConnectionLost, .timedOut:
                throw NetworkError.unreachable
            default:
                throw NetworkError.unknown
            }
        } catch {
            throw NetworkError.unknown
        }

        guard let http = response as? HTTPURLResponse else {
            throw NetworkError.unknown
        }

        guard (200..<300).contains(http.statusCode) else {
            throw NetworkError.badStatus(code: http.statusCode)
        }

        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingFailed
        }
    }
}
