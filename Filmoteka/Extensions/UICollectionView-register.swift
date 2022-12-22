//
//  UICollectionView-register.swift
//  Filmoteka
//
//  Created by Sergey Tarasov on 16.12.2022.
//

import UIKit

extension UICollectionView {
	func register(_ cellClass: AnyClass) {
		let identifier = String.className(cellClass)
		register(cellClass, forCellWithReuseIdentifier: identifier)
	}
}
