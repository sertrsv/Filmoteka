//
//  AppConfig.swift
//  Filmoteka
//
//  Created by Sergey Tarasov on 16.12.2022.
//

import Foundation

enum AppConfiguration {
	static var apiUrl: String {
		guard let apiUrl = Bundle.main.object(forInfoDictionaryKey: "ApiUrl") as? String else {
			return ""
		}
		return apiUrl
	}

	static var apiKey: String {
		guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "ApiKey") as? String else {
			return ""
		}
		return apiKey
	}
}
