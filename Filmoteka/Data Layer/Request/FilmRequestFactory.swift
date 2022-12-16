//
//  FilmRequestFactory.swift
//  Filmoteka
//
//  Created by Sergey Tarasov on 16.12.2022.
//

import Foundation

enum FilmRequestFactory {
	case premieres
	case item(id: Int)

	private var path: String {
		switch self {
		case .premieres:
			return "premieres"
		case let .item(id):
			return "\(id)"
		}
	}

	private var method: String {
		switch self {
		case .premieres, .item:
			return "GET"
		}
	}

	private var header: [String: String] {
		return [
			"X-API-KEY": AppConfiguration.apiKey,
			"Content-Type": "application/json"
		]
	}

	func makeRequest() -> URLRequest {
		let url = URL(string: AppConfiguration.apiUrl + "v2.2/films/") ?? URL(fileURLWithPath: "")
		var request = URLRequest(url: url.appendingPathComponent(path))
		request.httpMethod = method
		request.allHTTPHeaderFields = header
		request.timeoutInterval = 10
		return request
	}
}
