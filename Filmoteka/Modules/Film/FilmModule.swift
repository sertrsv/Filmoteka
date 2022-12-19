//
//  FilmModule.swift
//  Filmoteka
//
//  Created by Sergey Tarasov on 19.12.2022.
//

import Foundation

enum FilmModule {
	enum GetFilm {
		struct Request { }

		struct Response {
			let result: Result<FilmResponse, Error>
		}

		struct ViewModel {
			let result: Result<Film, Error>
		}
	}

	struct Film {
		let id: Int
		let title: String
		let posterUrl: String
		let description: String
	}
}
