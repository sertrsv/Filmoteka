//
//  NetworkManager.swift
//  
//
//  Created by Sergey Tarasov on 01.05.2023.
//

import Foundation

public protocol NetworkManager {
    func perform<T>(request: URLRequest, for: T.Type) async throws -> T where T: Decodable
}
