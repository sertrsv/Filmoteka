//
//  FilmFactory.swift
//  Filmoteka
//
//  Created by Sergey Tarasov on 19.12.2022.
//

import NetworkLayer

final class FilmFactory {
	private let filmId: Int

	init(filmId: Int) {
		self.filmId = filmId
	}

	func createViewController() -> FilmView {
		let viewController = FilmView()
		let presenter = FilmPresenter(viewController: viewController)
		let networkClient = DefaultNetworkClient()
		let interactor = FilmInteractor(presenter: presenter, networkClient: networkClient, filmId: filmId)
		viewController.interactor = interactor
		viewController.router = FilmRouter(viewController: viewController)
		return viewController
	}
}
