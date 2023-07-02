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
            DispatchQueue.main.async {
                self.image = Self.placeholder
            }
            return
        }
        fetchImage(from: url)
    }

    func fetchImage(from url: URL) {
        let imageKey = NSString(string: url.absoluteString)
        if let image = Self.cache.object(forKey: imageKey) {
            DispatchQueue.main.async {
                self.image = image
            }
            return
        }
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.image = Self.placeholder
                }
                return
            }
            guard let response = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    self.image = Self.placeholder
                }
                return
            }
            guard let data = data else {
                DispatchQueue.main.async {
                    self.image = Self.placeholder
                }
                return
            }
            switch response.statusCode {
            case 200...299:
                guard let image = UIImage(data: data) else {
                    DispatchQueue.main.async {
                        self.image = Self.placeholder
                    }
                    return
                }
                Self.cache.setObject(image, forKey: imageKey)
                DispatchQueue.main.async {
                    self.image = image
                }
            default:
                DispatchQueue.main.async {
                    self.image = Self.placeholder
                }
            }
        }
        dataTask.resume()
    }
}
