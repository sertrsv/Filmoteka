//
//  FilmPresenter.swift
//  Filmoteka
//
//  Created by Sergey Tarasov on 19.12.2022.
//

import Foundation

protocol FilmPresentationLogic {
	func update(with response: FilmModule.GetFilm.Response)
}

final class FilmPresenter: FilmPresentationLogic {
	private weak var viewController: FilmViewDisplayLogic?

	init(viewController: FilmViewDisplayLogic) {
		self.viewController = viewController
	}

	func update(with response: FilmModule.GetFilm.Response) {
		let viewModel: FilmModule.GetFilm.ViewModel
		switch response.result {
		case let .success(filmResponse):
			let film = FilmModule.Film(
				id: filmResponse.kinopoiskId,
				title: filmResponse.title,
				posterUrl: filmResponse.posterUrl,
				description: filmResponse.description ?? ""
			)
			viewModel = .init(result: .success(film))
		case let .failure(error):
			viewModel = .init(result: .failure(error))
		}
		DispatchQueue.main.async {
			self.viewController?.update(with: viewModel)
		}
	}
}
