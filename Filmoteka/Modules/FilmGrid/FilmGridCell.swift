//
//  FilmGridCell.swift
//  Filmoteka
//
//  Created by Sergey Tarasov on 16.12.2022.
//

import UIKit

final class FilmGridCell: UICollectionViewCell {
	private let posterView: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFill
		imageView.clipsToBounds = true
		imageView.layer.cornerRadius = 4
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()

	private let titleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	private let activityIndicator: UIActivityIndicatorView = {
		let indicator = UIActivityIndicatorView()
		indicator.translatesAutoresizingMaskIntoConstraints = false
		return indicator
	}()

	private var imageProvider = ImageProvider.shared

	private var staticConstraints: [NSLayoutConstraint] = []

	private var posterViewConstraints: [NSLayoutConstraint] {
		return [
			posterView.topAnchor.constraint(equalTo: contentView.topAnchor),
			posterView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40),
			posterView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			posterView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
		]
	}

	private var titleLabelConstraints: [NSLayoutConstraint] {
		return [
			titleLabel.topAnchor.constraint(equalTo: posterView.bottomAnchor),
			titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
			titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
		]
	}

	private var activityIndicatorConstraints: [NSLayoutConstraint] {
		return [
			activityIndicator.centerXAnchor.constraint(equalTo: posterView.centerXAnchor),
			activityIndicator.centerYAnchor.constraint(equalTo: posterView.centerYAnchor)
		]
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func prepareForReuse() {
		super.prepareForReuse()
		posterView.image = nil
		titleLabel.text = ""
		activityIndicator.startAnimating()
	}

	override func updateConstraints() {
		if staticConstraints.isEmpty {
			staticConstraints = titleLabelConstraints + posterViewConstraints + activityIndicatorConstraints
			NSLayoutConstraint.activate(staticConstraints)
		}
		super.updateConstraints()
	}

	func setupView() {
		isAccessibilityElement = true
		accessibilityTraits = .button

		backgroundColor = .clear

		contentView.backgroundColor = .clear
		contentView.addSubview(posterView)
		contentView.addSubview(titleLabel)
		contentView.addSubview(activityIndicator)

		activityIndicator.startAnimating()

		setNeedsUpdateConstraints()
	}

	func update(with item: FilmGridView.Item) {
		titleLabel.text = item.title
		accessibilityLabel = item.title
		imageProvider.fetchImage(url: item.imageUrl) { [weak self] result in
			DispatchQueue.main.async {
				self?.activityIndicator.stopAnimating()
			}
			switch result {
			case let .success(image):
				DispatchQueue.main.async {
					self?.posterView.image = image
				}
			case .failure:
				DispatchQueue.main.async {
					self?.posterView.image = UIImage(systemName: "questionmark")
				}
			}
		}
	}
}
