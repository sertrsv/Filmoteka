//
//  Date+month.swift
//  Filmoteka
//
//  Created by Sergey Tarasov on 23.05.2023.
//

import Foundation

extension Date {
	var month: String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "MMMM"
		dateFormatter.locale = Locale(identifier: "en_EN")
		return dateFormatter.string(from: self)
	}
}
