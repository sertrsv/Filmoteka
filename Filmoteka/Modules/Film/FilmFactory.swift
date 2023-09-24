//
//  FilmFactory.swift
//  Filmoteka
//
//  Created by Sergey Tarasov on 19.12.2022.
//

import NetworkLayer
import SwiftUI

struct FilmFactory {
    private let filmId: Int

    init(filmId: Int) {
        self.filmId = filmId
    }

    func createViewController() -> FilmView {
        let viewController = FilmView()
        let presenter = FilmPresenter(viewController: viewController)
        let networkManager = DefaultNetworkManager()
        let interactor = FilmInteractor(presenter: presenter, networkManager: networkManager, filmId: filmId)
        viewController.interactor = interactor
        viewController.router = FilmRouter(viewController: viewController)
        return viewController
    }

    func createSUIViewController() -> UIViewController {
        let store = FilmSUIViewModel()
        let viewController = UIHostingController(rootView: FilmSUIView(store: store))
        let presenter = FilmPresenter(viewController: store)
        let networkManager = DefaultNetworkManager()
        let interactor = FilmInteractor(presenter: presenter, networkManager: networkManager, filmId: filmId)
        store.interactor = interactor
        store.router = FilmRouter(viewController: viewController)
        return viewController
    }
}
