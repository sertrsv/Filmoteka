//
//  FilmGridDataSource.swift
//  Filmoteka
//
//  Created by Sergey Tarasov on 16.12.2022.
//

import UIKit

final class FilmGridDataSource: UICollectionViewDiffableDataSource<FilmGridView.Section, FilmGridView.Item> {
	init(collectionView: UICollectionView) {
		super.init(collectionView: collectionView) { collectionView, indexPath, item -> UICollectionViewCell? in
			let cell = collectionView.dequeue(FilmGridSUICell.self, for: indexPath)
			cell.update(with: item)
			return cell
		}
		collectionView.register(FilmGridSUICell.self)
	}
}
