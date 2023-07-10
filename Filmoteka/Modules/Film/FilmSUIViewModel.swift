//
//  FilmSUIViewModel.swift
//  Filmoteka
//
//  Created by Sergey Tarasov on 10.07.2023.
//

import SwiftUI

final class FilmSUIViewModel: ObservableObject {
    @Published var imageUrl: String = ""
    @Published var text: String = ""

    @Published var isLoading: Bool = true

    @Published var isShowAlert: Bool = false
    var alertTitle: String = ""

    var interactor: FilmBusinessLogic?
    var router: FilmRoutingLogic?

    func onAppear() {
        let request = FilmModule.GetFilm.Request()
        Task {
            await interactor?.getFilm(with: request)
        }
    }
}

// MARK: - FilmViewDisplayLogic

extension FilmSUIViewModel: FilmViewDisplayLogic {
    func update(with viewModel: FilmModule.GetFilm.ViewModel) {
        defer {
            isLoading = false
        }
        switch viewModel.result {
        case let .success(film):
            imageUrl = film.posterUrl
            text = film.description
        case let .failure(error):
            alertTitle = error.localizedDescription
            isShowAlert = true
        }
    }
}
