//
//  FilmGridPresenter.swift
//  Filmoteka
//
//  Created by Sergey Tarasov on 16.12.2022.
//

import UIKit

protocol FilmGridPresentationLogic {
	func update(with response: FilmGridModule.GetFilms.Response)
	func update(with response: FilmGridModule.OpenFilm.Response)
}

final class FilmGridPresenter: FilmGridPresentationLogic {
	private weak var viewController: FilmGridViewDisplayLogic?

	init(viewController: FilmGridViewDisplayLogic) {
		self.viewController = viewController
	}

	func update(with response: FilmGridModule.GetFilms.Response) {
		switch response.result {
		case let .success(films):
			var snapshot = NSDiffableDataSourceSnapshot<FilmGridView.Section, FilmGridView.Item>()
			snapshot.appendSections([.main])
			let items = films.map {
				FilmGridView.Item(id: $0.kinopoiskId, title: $0.title, imageUrl: $0.posterUrlPreview)
			}
			snapshot.appendItems(items)
			let viewModel = FilmGridModule.GetFilms.ViewModel(result: .success(snapshot))
			DispatchQueue.main.async {
				self.viewController?.update(with: viewModel)
			}
		case let .failure(error):
			let viewModel = FilmGridModule.GetFilms.ViewModel(result: .failure(error))
			DispatchQueue.main.async {
				self.viewController?.update(with: viewModel)
			}
		}
	}

	func update(with response: FilmGridModule.OpenFilm.Response) {
		let viewModel = FilmGridModule.OpenFilm.ViewModel(filmId: response.filmId)
		DispatchQueue.main.async {
			self.viewController?.update(with: viewModel)
		}
	}
}
