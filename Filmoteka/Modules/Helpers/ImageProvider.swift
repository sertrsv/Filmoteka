//
//  ImageProvider.swift
//  Filmoteka
//
//  Created by Sergey Tarasov on 18.12.2022.
//

import UIKit
import NetworkLayer

final class ImageProvider {
	static let shared = ImageProvider()

	private let cache = NSCache<NSString, UIImage>()

	private init() {}

	func fetchImage(url urlString: String, completion: @escaping (Result<UIImage?, NetworkError>) -> Void) {
		guard let url = URL(string: urlString) else { return }
		fetchImage(url: url, completion: completion)
	}

	func fetchImage(url: URL, completion: @escaping (Result<UIImage?, NetworkError>) -> Void) {
		let imageKey = NSString(string: url.absoluteString)
		if let image = cache.object(forKey: imageKey) {
			completion(.success(image))
			return
		}
		let dataTask = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
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
				guard let image = UIImage(data: data) else {
					completion(.failure(.serializationError))
					return
				}
				self?.cache.setObject(image, forKey: imageKey)
				completion(.success(image))
			case 401:
				completion(.failure(.unauthorized))
			default:
				completion(.failure(.unexpectedStatusCode(response.statusCode)))
			}
		}
		dataTask.resume()
	}
}
