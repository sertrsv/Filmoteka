//
//  FilmGridRouter.swift
//  Filmoteka
//
//  Created by Sergey Tarasov on 16.12.2022.
//

import UIKit

protocol FilmGridRoutingLogic {
	func routeToFilm(filmId: Int)
	func presentAlert(error: Error)
}

final class FilmGridRouter: FilmGridRoutingLogic {
	private weak var viewController: UIViewController?

	init(viewController: UIViewController) {
		self.viewController = viewController
	}

	func routeToFilm(filmId: Int) {}

	func presentAlert(error: Error) {
		let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
		alert.addAction(.init(title: "OK", style: .default))

		viewController?.present(alert, animated: true)
	}
}
