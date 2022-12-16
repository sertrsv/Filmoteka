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
		guard (scene as? UIWindowScene) != nil else { return }
	}

}
