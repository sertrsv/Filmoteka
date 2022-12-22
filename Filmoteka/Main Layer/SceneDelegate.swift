//
//  SceneDelegate.swift
//  Filmoteka
//
//  Created by Sergey Tarasov on 15.12.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	func scene(
		_ scene: UIScene,
		willConnectTo session: UISceneSession,
		options connectionOptions: UIScene.ConnectionOptions
	) {
		guard let windowScene = (scene as? UIWindowScene) else { return }

		let window = UIWindow(windowScene: windowScene)
		window.rootViewController = makeNavigationController()
		window.makeKeyAndVisible()

		self.window = window
	}

	func makeNavigationController() -> UINavigationController {
		let factory = FilmGridFactory()
		let filmGridViewController = factory.createViewController()

		let navigationController = UINavigationController(rootViewController: filmGridViewController)

		return navigationController
	}

}
