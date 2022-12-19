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

		let navigationController = UINavigationController()

		let factory = FilmGridFactory()
		let filmGridViewController = factory.createViewController()

		navigationController.setViewControllers([filmGridViewController], animated: true)

		let window = UIWindow(windowScene: windowScene)
		window.rootViewController = navigationController
		window.makeKeyAndVisible()

		self.window = window
	}

}
