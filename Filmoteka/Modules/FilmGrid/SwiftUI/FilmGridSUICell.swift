//
//  FilmGridSUICell.swift
//  Filmoteka
//
//  Created by Sergey Tarasov on 24.09.2023.
//

import UIKit
import SwiftUI

final class FilmGridSUICell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        contentConfiguration = nil
    }

    func setupView() {
        isAccessibilityElement = true
        accessibilityTraits = .button

        backgroundColor = .clear

        contentView.backgroundColor = .clear
    }

    func update(with item: FilmGridView.Item) {
        contentConfiguration = UIHostingConfiguration {
            FilmGridSUICellView(item: item, size: contentView.frame)
        }
        .background(.clear)

        accessibilityLabel = item.title
    }
}
