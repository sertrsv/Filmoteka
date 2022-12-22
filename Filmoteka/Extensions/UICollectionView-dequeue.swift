//
//  UICollectionView-dequeue.swift
//  Filmoteka
//
//  Created by Sergey Tarasov on 16.12.2022.
//

import UIKit

public extension UICollectionView {
	func dequeue<T>(_ type: T.Type, for indexPath: IndexPath) -> T {
		let className = String(describing: type)
		guard let cell = dequeueReusableCell(withReuseIdentifier: className, for: indexPath) as? T else {
			fatalError("Could not dequeue cell: \(className)")
		}
		return cell
	}
}
