//
//  UserDefaults+Extensions.swift
//  Orientation, Alert, Persistence
//
//  Created by Luis Ligunas on 3/29/23.
//

import Foundation

extension UserDefaults {
	func decodable<T: Decodable>(key: String, type: T.Type) -> T? {
		guard let data = self.object(forKey: key) as? Data,
			  let decodable = try? PropertyListDecoder().decode(type, from: data) else {
			return nil
		}
		return decodable
	}

	func setEncodable<T: Encodable>(_ value: T, forKey key: String) {
		guard let data = try? PropertyListEncoder().encode(value) else { return }
		set(data, forKey: key)
	}
}
