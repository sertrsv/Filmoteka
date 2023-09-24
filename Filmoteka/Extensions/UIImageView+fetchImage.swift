//
//  UIImageView+fetchImage.swift
//  Filmoteka
//
//  Created by Sergey Tarasov on 02.07.2023.
//

import UIKit

extension UIImageView {
    private static let cache = NSCache<NSString, UIImage>()

    private static let placeholder = UIImage(systemName: "photo")

    func fetchImage(from urlString: String) {
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async { [weak self] in
                self?.image = Self.placeholder
            }
            return
        }
        fetchImage(from: url)
    }

    func fetchImage(from url: URL) {
        let imageKey = NSString(string: url.absoluteString)
        if let image = Self.cache.object(forKey: imageKey) {
            DispatchQueue.main.async { [weak self] in
                self?.image = image
            }
            return
        }
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            var newImage: UIImage? = Self.placeholder
            defer {
                DispatchQueue.main.async { [weak self] in
                    self?.image = newImage
                }
            }
            if error != nil {
                return
            }
            guard let response = response as? HTTPURLResponse else {
                return
            }
            guard let data = data else {
                return
            }
            switch response.statusCode {
            case 200...299:
                guard let image = UIImage(data: data) else {
                    return
                }
                Self.cache.setObject(image, forKey: imageKey)
                newImage = image
            default:
                return
            }
        }
        dataTask.resume()
    }
}
