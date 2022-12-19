//
//  FilmGridView.swift
//  Filmoteka
//
//  Created by Sergey Tarasov on 16.12.2022.
//

import UIKit

protocol FilmGridViewDisplayLogic: AnyObject {
	func update(with viewModel: FilmGridModule.GetFilms.ViewModel)
	func update(with viewModel: FilmGridModule.OpenFilm.ViewModel)
}

// MARK: - UIViewController

final class FilmGridView: UIViewController {

	// MARK: - Section and Item

	enum Section {
		case main
	}

	struct Item: Hashable {
		let id: Int
		let title: String
		let imageUrl: String
	}

	// MARK: - Properties

	private lazy var collectionView: UICollectionView = {
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: generateLayout())
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.delegate = self
		dataSource = FilmGridDataSource(collectionView: collectionView)
		collectionView.dataSource = dataSource
		collectionView.register(FilmGridCell.self)
		return collectionView
	}()

	private var sortAlert: UIAlertController?

	var interactor: FilmGridBusinessLogic?
	var router: FilmGridRoutingLogic?
	private var dataSource: FilmGridDataSource?

	private var staticConstraints: [NSLayoutConstraint] = []

	private var collectionViewConstraints: [NSLayoutConstraint] {
		guard let view = view else { return [] }
		return [
			collectionView.topAnchor.constraint(equalTo: view.topAnchor),
			collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
		]
	}

	// MARK: - Life Cycle

	override func viewDidLoad() {
		super.viewDidLoad()
		setupComponents()
		setupActions()
		getFilms()
	}

	override func updateViewConstraints() {
		if staticConstraints.isEmpty {
			staticConstraints = collectionViewConstraints
			NSLayoutConstraint.activate(staticConstraints)
		}
		super.updateViewConstraints()
	}

	// MARK: - Functions

	private func setupComponents() {
		navigationItem.title = "Премьеры"
		navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
		view.addSubview(collectionView)
		view.setNeedsUpdateConstraints()
	}

	private func generateLayout() -> UICollectionViewLayout {
		let layout = UICollectionViewCompositionalLayout(
			sectionProvider: { (_, layoutEnvironment) -> NSCollectionLayoutSection? in
				let isWide = layoutEnvironment.container.effectiveContentSize.width > 500

				let itemSize = NSCollectionLayoutSize(
					widthDimension: .fractionalWidth(1.0),
					heightDimension: .fractionalHeight(1.0))
				let item = NSCollectionLayoutItem(layoutSize: itemSize)
				item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)

				let groupSize = NSCollectionLayoutSize(
					widthDimension: .fractionalWidth(isWide ? 0.25 : 0.5),
					heightDimension: .fractionalWidth((isWide ? 0.25 : 0.5) * 3.2/2)
				)
				let group = NSCollectionLayoutGroup.horizontal(
					layoutSize: groupSize,
					repeatingSubitem: item,
					count: isWide ? 4 : 2
				)

				let section = NSCollectionLayoutSection(group: group)
				section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)

				return section
			}
		)
		return layout
	}

	private func setupActions() {
		let refreshControl = UIRefreshControl()
		refreshControl.addTarget(self, action: #selector(getFilms), for: .valueChanged)
		self.collectionView.refreshControl = refreshControl
	}
}

// MARK: - Actions

extension FilmGridView {
	@objc private func getFilms() {
		let request = FilmGridModule.GetFilms.Request()
		interactor?.getFilms(with: request)
	}
}

// MARK: - FilmGridViewDisplayLogic

extension FilmGridView: FilmGridViewDisplayLogic {
	func update(with viewModel: FilmGridModule.GetFilms.ViewModel) {
		collectionView.refreshControl?.endRefreshing()
		switch viewModel.result {
		case let .success(snapshot):
			dataSource?.apply(snapshot, animatingDifferences: true)
		case let .failure(error):
			router?.presentAlert(error: error)
		}
	}

	func update(with viewModel: FilmGridModule.OpenFilm.ViewModel) {
		router?.routeToFilm(filmId: viewModel.filmId)
	}
}

// MARK: - UICollectionViewDelegate

extension FilmGridView: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		guard let item = dataSource?.itemIdentifier(for: indexPath) else { return }
		let request = FilmGridModule.OpenFilm.Request(filmId: item.id)
		interactor?.openFilm(with: request)
	}
}
