//
//  FilmGridModule.swift
//  Filmoteka
//
//  Created by Sergey Tarasov on 16.12.2022.
//

import Foundation
import UIKit

enum FilmGridModule {
	enum GetFilms {
		struct Request {}

		struct Response {}

		struct ViewModel {}
	}

	enum OpenFilm {
		struct Request {
			let filmId: Int
		}

		struct Response {
			let filmId: Int
		}

		struct ViewModel {
			let filmId: Int
		}
	}
}
