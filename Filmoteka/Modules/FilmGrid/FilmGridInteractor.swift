//
//  FilmGridInteractor.swift
//  Filmoteka
//
//  Created by Sergey Tarasov on 16.12.2022.
//

import Foundation
import NetworkLayer

protocol FilmGridBusinessLogic {
	func getFilms(with request: FilmGridModule.GetFilms.Request)
	func openFilm(with request: FilmGridModule.OpenFilm.Request)
}

final class FilmGridInteractor: FilmGridBusinessLogic {
	private let presenter: FilmGridPresentationLogic
	private let networkClient: NetworkClient

	init(presenter: FilmGridPresentationLogic, networkClient: NetworkClient) {
		self.presenter = presenter
		self.networkClient = networkClient
	}

	func getFilms(with request: FilmGridModule.GetFilms.Request) {
		let request = FilmRequestFactory.premieres.makeRequest()
		networkClient.perform(request: request) { [weak self] (result: Result<PremieresResponse, NetworkError>) in
			var response: FilmGridModule.GetFilms.Response
			switch result {
			case let .success(films):
				response = .init(result: .success(films.items))
			case let .failure(error):
				response = .init(result: .failure(error))
			}
			self?.presenter.update(with: response)
		}
	}

	func openFilm(with request: FilmGridModule.OpenFilm.Request) {
		let response = FilmGridModule.OpenFilm.Response(filmId: request.filmId)
		presenter.update(with: response)
	}
}
