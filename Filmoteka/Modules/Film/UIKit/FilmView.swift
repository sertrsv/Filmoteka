//
//  FilmView.swift
//  Filmoteka
//
//  Created by Sergey Tarasov on 19.12.2022.
//

import UIKit

protocol FilmViewDisplayLogic: AnyObject {
	func update(with viewModel: FilmModule.GetFilm.ViewModel)
}

final class FilmView: UIViewController {

	// MARK: - Properties

	private lazy var scrollView: UIScrollView = {
		let scrollView = UIScrollView()
		scrollView.translatesAutoresizingMaskIntoConstraints = false
		scrollView.autoresizingMask = .flexibleHeight
		scrollView.bounces = true
		scrollView.showsHorizontalScrollIndicator = true
		return scrollView
	}()

	private lazy var posterView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFill
		imageView.clipsToBounds = true
		return imageView
	}()

	private lazy var descriptionLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.numberOfLines = 0
		return label
	}()

	private lazy var activityIndicator: UIActivityIndicatorView = {
		let indicator = UIActivityIndicatorView()
		indicator.translatesAutoresizingMaskIntoConstraints = false
		indicator.style = .large
		return indicator
	}()

	var interactor: FilmBusinessLogic?
	var router: FilmRoutingLogic?

	// MARK: - Constraints

	private var staticConstraints: [NSLayoutConstraint] = []

	private var scrollViewConstraints: [NSLayoutConstraint] {
		let safeArea = view.safeAreaLayoutGuide
		return [
			scrollView.topAnchor.constraint(equalTo: safeArea.topAnchor),
			scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			scrollView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
			scrollView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
		]
	}

	private var posterViewConstraints: [NSLayoutConstraint] {
		return [
			posterView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
			posterView.topAnchor.constraint(equalTo: scrollView.topAnchor),
			posterView.widthAnchor.constraint(equalTo: view.widthAnchor),
			posterView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.429)
		]
	}

	private var descriptionLabelConstraints: [NSLayoutConstraint] {
		return [
			descriptionLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
			descriptionLabel.topAnchor.constraint(equalTo: posterView.bottomAnchor, constant: 12),
			descriptionLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -32),
			descriptionLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 17),
			descriptionLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -26)
		]
	}

	private var activityIndicatorConstraints: [NSLayoutConstraint] {
		return [
			activityIndicator.centerXAnchor.constraint(equalTo: posterView.centerXAnchor),
			activityIndicator.centerYAnchor.constraint(equalTo: posterView.centerYAnchor)
		]
	}

	// MARK: - Life Cycle

	override func viewDidLoad() {
		super.viewDidLoad()
		setupComponents()
		let request = FilmModule.GetFilm.Request()
        Task {
            await interactor?.getFilm(with: request)
        }
	}

	override func updateViewConstraints() {
		if staticConstraints.isEmpty {
			staticConstraints = scrollViewConstraints + posterViewConstraints +
			descriptionLabelConstraints + activityIndicatorConstraints
			NSLayoutConstraint.activate(staticConstraints)
		}
		super.updateViewConstraints()
	}

	// MARK: - Functions

	private func setupComponents() {
		view.addSubview(scrollView)
		view.backgroundColor = .systemBackground
		scrollView.addSubview(posterView)
		scrollView.addSubview(descriptionLabel)
		scrollView.addSubview(activityIndicator)
		activityIndicator.startAnimating()
		view.setNeedsUpdateConstraints()
	}
}

// MARK: - FilmViewDisplayLogic

extension FilmView: FilmViewDisplayLogic {
	func update(with viewModel: FilmModule.GetFilm.ViewModel) {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
        }
		switch viewModel.result {
		case let .success(film):
			descriptionLabel.text = film.description
            posterView.fetchImage(from: film.posterUrl)
		case let .failure(error):
			router?.presentAlert(error: error)
		}
	}
}
