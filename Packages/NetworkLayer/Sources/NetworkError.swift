//
//  NetworkError.swift
//  
//
//  Created by Sergey Tarasov on 12.07.2022.
//

import Foundation

public enum NetworkError: Error, LocalizedError {
	case invalidResponse
	case noData
	case decode
	case unauthorized
	case unexpectedStatusCode(_ code: Int)
	case serializationError
	case unknown(_ error: Error)

	public var errorDescription: String? {
		switch self {
		case .invalidResponse:
			return "Invalid response"
		case .noData:
			return "Empty data"
		case .decode:
			return "Decode error"
		case .unauthorized:
			return "You are not authorized"
		case .unexpectedStatusCode(let code):
			return "Unexpected code: \(code)"
		case .serializationError:
			return "Error serialization"
		case .unknown(let error):
			return "Unknown: \(error.localizedDescription)"
		}
	}
}
