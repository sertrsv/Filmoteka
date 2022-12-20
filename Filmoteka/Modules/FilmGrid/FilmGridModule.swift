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

		struct Response {
			let result: Result<[PremieresResponse.PremiereResponseItem], Error>
		}

		struct ViewModel {
			let result: Result<NSDiffableDataSourceSnapshot<FilmGridView.Section, FilmGridView.Item>, Error>
		}
	}

	enum OpenFilm {
		struct Request {
			let film: Film
		}

		struct Response {
			let film: Film
		}

		struct ViewModel {
			let film: Film
		}
	}

	struct Film {
		let id: Int
		let title: String
	}
}
