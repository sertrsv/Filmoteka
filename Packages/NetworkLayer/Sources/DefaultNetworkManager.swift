//
//  DefaultNetworkManager.swift
//  
//
//  Created by Sergey Tarasov on 01.05.2023.
//

import Foundation

public class DefaultNetworkManager: NetworkManager {
    private static let decoder = JSONDecoder()
    private let session: URLSession

    public init(session: URLSession = .shared) {
        self.session = session
    }

    public func perform<T>(request: URLRequest, for: T.Type) async throws -> T where T: Decodable {
        let (data, response) = try await session.data(for: request)

        guard let response = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }

        switch response.statusCode {
        case 200...299:
            do {
                return try Self.decoder.decode(T.self, from: data)
            } catch {
                throw error
            }
        case 401:
            throw NetworkError.unauthorized
        default:
            throw NetworkError.unexpectedStatusCode(response.statusCode)
        }
    }
}
