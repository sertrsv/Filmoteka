//
//  FilmGridInteractor.swift
//  Filmoteka
//
//  Created by Sergey Tarasov on 16.12.2022.
//

import Foundation
import NetworkLayer

protocol FilmGridBusinessLogic {
    func getFilms(with request: FilmGridModule.GetFilms.Request) async
    func openFilm(with request: FilmGridModule.OpenFilm.Request)
}

final class FilmGridInteractor: FilmGridBusinessLogic {
    private let presenter: FilmGridPresentationLogic
    private let networkManager: NetworkManager

    init(presenter: FilmGridPresentationLogic, networkManager: NetworkManager) {
        self.presenter = presenter
        self.networkManager = networkManager
    }

    func getFilms(with request: FilmGridModule.GetFilms.Request) async {
        let request = FilmRequestFactory.premieres.makeRequest()
        let response: FilmGridModule.GetFilms.Response
        do {
            let films = try await networkManager.perform(request: request, for: PremieresResponse.self)
            response = .init(result: .success(films.items))
        } catch {
            response = .init(result: .failure(error))
        }
        DispatchQueue.main.async { [weak self] in
            self?.presenter.update(with: response)
        }
    }

    func openFilm(with request: FilmGridModule.OpenFilm.Request) {
        let response = FilmGridModule.OpenFilm.Response(film: request.film)
        presenter.update(with: response)
    }
}
