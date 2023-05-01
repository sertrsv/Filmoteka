//
//  FilmInteractor.swift
//  Filmoteka
//
//  Created by Sergey Tarasov on 19.12.2022.
//

import NetworkLayer

protocol FilmBusinessLogic {
    func getFilm(with request: FilmModule.GetFilm.Request) async throws
}

final class FilmInteractor: FilmBusinessLogic {
    private let presenter: FilmPresentationLogic
    private let networkManager: NetworkManager
    private let filmId: Int

    init(presenter: FilmPresentationLogic, networkManager: NetworkManager, filmId: Int) {
        self.presenter = presenter
        self.networkManager = networkManager
        self.filmId = filmId
    }

    func getFilm(with request: FilmModule.GetFilm.Request) async {
        let request = FilmRequestFactory.item(id: filmId).makeRequest()
        let response: FilmModule.GetFilm.Response
        do {
            let film = try await networkManager.perform(request: request, for: FilmResponse.self)
            response = .init(result: .success(film))
        } catch {
            response = .init(result: .failure(error))
        }
        self.presenter.update(with: response)
    }
}
