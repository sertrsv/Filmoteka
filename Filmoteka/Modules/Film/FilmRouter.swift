//
//  FilmRouter.swift
//  Filmoteka
//
//  Created by Sergey Tarasov on 19.12.2022.
//

import UIKit
import AVKit

protocol FilmRoutingLogic {
	func watch(url: String)
	func presentAlert(error: Error)
}

final class FilmRouter: FilmRoutingLogic {
	private weak var viewController: UIViewController?

	init(viewController: UIViewController) {
		self.viewController = viewController
	}

	func watch(url: String) {
		let playerViewController = AVPlayerViewController()
		viewController?.present(playerViewController, animated: true) {
			playerViewController.player?.play()
		}
	}

	func presentAlert(error: Error) {
		let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
		alert.addAction(.init(title: "OK", style: .default))

		viewController?.present(alert, animated: true)
	}
}
