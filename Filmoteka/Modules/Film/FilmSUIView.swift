//
//  FilmSUIView.swift
//  Filmoteka
//
//  Created by Sergey Tarasov on 10.07.2023.
//

import SwiftUI

struct FilmSUIView: View {
    @ObservedObject
    var store: FilmSUIViewModel

    var body: some View {
        Group {
            if store.isLoading {
                ProgressView()
                    .task {
                        store.onAppear()
                    }
            } else {
                ScrollView {
                    AsyncImage(
                        url: URL(string: store.imageUrl),
                        transaction: .init(animation: .default)
                    ) { phase in
                        switch phase {
                        case let .success(image):
                            image
                                .resizable()
                                .scaledToFill()
                        case .failure:
                            Image(systemName: "questionmark.square.dashed")
                        case .empty:
                            ProgressView()
                                .frame(height: 500)
                        @unknown default:
                            Image(systemName: "questionmark.square.dashed")
                        }
                    }
                    Text(store.text)
                        .padding([.horizontal, .bottom])
                }
            }
        }
        .animation(.default, value: store.isLoading)
        .alert(store.alertTitle, isPresented: $store.isShowAlert) {
            Button("Ok", action: { store.isShowAlert = false })
        }
    }
}

struct FilmSUIView_Previews: PreviewProvider {
    static var previews: some View {
        FilmSUITestView()
    }

    private struct FilmSUITestView: View {
        @ObservedObject
        var store: FilmSUIViewModel = makeStore()

        var body: some View {
            FilmSUIView(store: store)
        }
    }

    private static func makeStore() -> FilmSUIViewModel {
        let store = FilmSUIViewModel()
        let interactor = FilmInteractorStub()
        interactor.store = store
        store.interactor = interactor
        return store
    }

    // swiftlint:disable line_length

    final class FilmInteractorStub: FilmBusinessLogic {
        weak var store: FilmViewDisplayLogic?

        func getFilm(with request: FilmModule.GetFilm.Request) async {
            let film = FilmModule.Film(id: 1, title: "Title", posterUrl: "https://via.placeholder.com/400x600", description: "Culpa veniam labore occaecat esse ipsum elit laboris incididunt. Ex do nulla consectetur cupidatat pariatur anim do veniam excepteur tempor. Do officia magna eiusmod nisi. Nostrud consectetur ut exercitation officia. Velit in est enim nostrud reprehenderit occaecat dolor.")
            store?.update(with: FilmModule.GetFilm.ViewModel(result: .success(film)))
        }
    }
}