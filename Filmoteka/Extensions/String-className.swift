//
//  String-className.swift
//  Filmoteka
//
//  Created by Sergey Tarasov on 16.12.2022.
//

import Foundation

public extension String {
	static func className(_ aClass: AnyClass) -> String {
		NSStringFromClass(aClass).components(separatedBy: ".").last ?? ""
	}
}
