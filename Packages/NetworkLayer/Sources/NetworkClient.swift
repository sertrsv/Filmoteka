//
//  NetworkClient.swift
//
//
//  Created by Sergey Tarasov on 12.07.2022.
//

import Foundation

@available(*, deprecated, message: "use NetworkManager instead")
public protocol NetworkClient {
    func perform<T: Decodable>(
        request: URLRequest,
        completion: @escaping (Result<T, NetworkError>) -> Void
    )
}
