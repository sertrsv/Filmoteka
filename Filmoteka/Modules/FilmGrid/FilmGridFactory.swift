//
//  FilmGridFactory.swift
//  Filmoteka
//
//  Created by Sergey Tarasov on 18.12.2022.
//

import NetworkLayer

final class FilmGridFactory {
    init() {}

    func createViewController() -> FilmGridView {
        let viewController = FilmGridView()
        let presenter = FilmGridPresenter(viewController: viewController)
        let networkManager = DefaultNetworkManager()
        let interactor = FilmGridInteractor(presenter: presenter, networkManager: networkManager)
        viewController.interactor = interactor
        viewController.router = FilmGridRouter(viewController: viewController)
        return viewController
    }
}
