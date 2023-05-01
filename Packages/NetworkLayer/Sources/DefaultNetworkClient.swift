//
//  DefaultNetworkClient.swift
//  
//
//  Created by Sergey Tarasov on 07.11.2022.
//

import Foundation

@available(*, deprecated, message: "use DefaultNetworkManager instead")
public final class DefaultNetworkClient: NetworkClient {
	private static let decoder = JSONDecoder()
	private let session: URLSession

	public init(session: URLSession = .shared) {
		self.session = session
	}

	public func perform<T: Decodable>(
		request: URLRequest,
		completion: @escaping (Result<T, NetworkError>) -> Void
	) {
		let dataTask = session.dataTask(with: request) { data, response, error in
			if let error = error {
				completion(.failure(.unknown(error)))
				return
			}
			guard let response = response as? HTTPURLResponse else {
				completion(.failure(.invalidResponse))
				return
			}
			guard let data = data else {
				completion(.failure(.noData))
				return
			}
			switch response.statusCode {
			case 200...299:
				guard let decodedResponse = try? Self.decoder.decode(T.self, from: data) else {
					completion(.failure(.decode))
					return
				}
				completion(.success(decodedResponse))
			case 401:
				completion(.failure(.unauthorized))
			default:
				completion(.failure(.unexpectedStatusCode(response.statusCode)))
			}
		}
		dataTask.resume()
	}
}
