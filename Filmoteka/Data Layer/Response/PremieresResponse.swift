//
//  PremieresResponse.swift
//  Filmoteka
//
//  Created by Sergey Tarasov on 16.12.2022.
//

struct PremieresResponse: Decodable {
	let total: Int
	let items: [PremiereResponseItem]
}

extension PremieresResponse {
	struct PremiereResponseItem: Decodable {
		let kinopoiskId: Int
		let nameRu: String?
		let nameEn: String?
		let posterUrlPreview: String
	}
}
