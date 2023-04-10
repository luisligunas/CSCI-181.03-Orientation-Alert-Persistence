//
//  KeychainSwift+Extensions.swift
//  Orientation, Alert, Persistence
//
//  Created by Luis Ligunas on 4/11/23.
//

import Foundation
import KeychainSwift

extension KeychainSwift {
	func getDecodable<T: Decodable>(key: String, type: T.Type) -> T? {
		guard let data = self.getData(key),
			  let decodable = try? JSONDecoder().decode(type, from: data)
		else { return nil }
		return decodable
	}

	func setEncodable<T: Encodable>(_ value: T, forKey key: String) {
		guard let data = try? JSONEncoder().encode(value) else { return }
		set(data, forKey: key)
	}
}
