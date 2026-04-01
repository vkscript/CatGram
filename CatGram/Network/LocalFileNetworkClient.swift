//
//  LocalFileNetworkClient.swift
//  CatGram
//

import Foundation

final class LocalFileNetworkClient: NetworkClient {

    private let decoder: JSONDecoder

    init() {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        self.decoder = decoder
    }

    func get<T: Decodable>(_ url: URL) async throws -> T {
        try await Task.sleep(nanoseconds: 1_000_000_000)
        let fileName = url.deletingPathExtension().lastPathComponent

        guard
            let fileURL = Bundle.main.url(forResource: fileName, withExtension: "json")
        else {
            throw NetworkError.unreachable
        }

        let data: Data
        do {
            data = try Data(contentsOf: fileURL)
        } catch {
            throw NetworkError.unknown
        }

        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingFailed
        }
    }
}
