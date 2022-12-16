//
//  NetworkError.swift
//  
//
//  Created by Sergey Tarasov on 12.07.2022.
//

public enum NetworkError: Error {
	case invalidResponse
	case noData
	case decode
	case unauthorized
	case unexpectedStatusCode(_ code: Int)
	case serializationError
	case unknown(_ error: Error)
}
