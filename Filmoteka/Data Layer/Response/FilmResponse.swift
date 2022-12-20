//
//  FilmResponse.swift
//  Filmoteka
//
//  Created by Sergey Tarasov on 16.12.2022.
//

struct FilmResponse: Decodable {
	let kinopoiskId: Int
	let nameRu: String?
	let nameEn: String?
	let nameOriginal: String?
	let posterUrl: String
	let webUrl: String
	let slogan: String?
	let description: String?
}

extension FilmResponse {
	var title: String {
		nameRu ?? nameEn ?? nameOriginal ?? "Unknown"
	}
}
