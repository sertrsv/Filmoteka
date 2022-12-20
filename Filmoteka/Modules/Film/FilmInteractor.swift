//
//  FilmInteractor.swift
//  Filmoteka
//
//  Created by Sergey Tarasov on 19.12.2022.
//

import NetworkLayer

protocol FilmBusinessLogic {
	func getFilm(with request: FilmModule.GetFilm.Request)
}

final class FilmInteractor: FilmBusinessLogic {
	private let presenter: FilmPresentationLogic
	private let networkClient: NetworkClient
	private let filmId: Int

	init(presenter: FilmPresentationLogic, networkClient: NetworkClient, filmId: Int) {
		self.presenter = presenter
		self.networkClient = networkClient
		self.filmId = filmId
	}

	func getFilm(with request: FilmModule.GetFilm.Request) {
		let request = FilmRequestFactory.item(id: filmId).makeRequest()
		networkClient.perform(request: request) { [weak self] (result: Result<FilmResponse, NetworkError>) in
			let response: FilmModule.GetFilm.Response
			switch result {
			case let .success(film):
				response = .init(result: .success(film))
			case let .failure(error):
				response = .init(result: .failure(error))
			}
			self?.presenter.update(with: response)
		}
	}
}
