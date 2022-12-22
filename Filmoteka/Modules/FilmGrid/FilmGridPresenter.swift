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
		let viewModel: FilmGridModule.GetFilms.ViewModel
		switch response.result {
		case let .success(films):
			var snapshot = NSDiffableDataSourceSnapshot<FilmGridView.Section, FilmGridView.Item>()
			snapshot.appendSections([.main])
			let items = films.map {
				FilmGridView.Item(id: $0.kinopoiskId, title: $0.title, imageUrl: $0.posterUrlPreview)
			}
			snapshot.appendItems(items)
			viewModel = .init(result: .success(snapshot))
		case let .failure(error):
			viewModel = .init(result: .failure(error))
		}
		DispatchQueue.main.async {
			self.viewController?.update(with: viewModel)
		}
	}

	func update(with response: FilmGridModule.OpenFilm.Response) {
		let viewModel = FilmGridModule.OpenFilm.ViewModel(film: response.film)
		DispatchQueue.main.async {
			self.viewController?.update(with: viewModel)
		}
	}
}
