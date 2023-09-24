//
//  FilmGridSUICellView.swift
//  Filmoteka
//
//  Created by Sergey Tarasov on 24.09.2023.
//

import SwiftUI

struct FilmGridSUICellView: View {
    let item: FilmGridView.Item
    let size: CGRect

    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(
                url: URL(string: item.imageUrl),
                transaction: .init(animation: .default)
            ) { phase in
                switch phase {
                case let .success(image):
                    image
                        .resizable()
                        .scaledToFill()
                case .failure:
                    Image(systemName: "questionmark.square.dashed")
                case .empty:
                    ProgressView()
                        .frame(height: 100)
                @unknown default:
                    Image(systemName: "questionmark.square.dashed")
                }
            }
            .frame(minWidth: size.width, minHeight: size.height * 0.9)
            .clipped()
            Text(item.title)
                .lineLimit(1)
        }
        .frame(maxWidth: size.width, maxHeight: size.height, alignment: .bottomLeading)
    }
}

#Preview {
    FilmGridSUICellView(
        item: .init(id: 1, title: "Title", imageUrl: "https://via.placeholder.com/200x300"),
        size: .init(x: 0, y: 0, width: 200, height: 300)
    )
}
