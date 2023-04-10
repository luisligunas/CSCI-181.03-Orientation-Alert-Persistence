//
//  ViewController.swift
//  Orientation, Alert, Persistence
//
//  Created by Luis Ligunas on 3/29/23.
//

import UIKit
import KeychainSwift

class ViewController: UIViewController {

	@IBOutlet weak var textField: UITextField!

	let userDefaults = UserDefaults.standard
	let keychain = KeychainSwift()

	private enum Constants {
		static let textKey = "text"
		static let personKey = "person"
		static let debugDivider = "--------------"
	}

	override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
		return [.landscapeLeft, .portrait]
	}

	/// Note that you can also save Encodable objects into the Keychain like you can in `UserDefaults`.
	/// Go to `KeychainSwift+Extensions.swift` to see the functions you can use.
	///
	/// Similarly, you can also store primitive types into `UserDefaults` using the built in functions in a `UserDefaults` object.
	@IBAction func onSave(_ sender: Any) {
		if let text = textField.text {
			keychain.set(text, forKey: Constants.textKey)
			print("Saved text to Keychain: \(text)")

		}

		let person = Person(name: "Luis", age: 24, height: 166.0)
		userDefaults.setEncodable(person, forKey: Constants.personKey)
		print("Saved Person to UserDefaults")

		print(Constants.debugDivider)
	}

	@IBAction func onClear(_ sender: Any) {
		keychain.delete(Constants.textKey)
		print("Cleared text from Keychain")

		userDefaults.removeObject(forKey: Constants.personKey)
		print("Cleared Person from UserDefaults")

		print(Constants.debugDivider)
	}

	/// Note that you can also read Decodable objects from the Keychain like you can in `UserDefaults`.
	/// Go to `KeychainSwift+Extensions.swift` to see the functions you can use.
	///
	/// Similarly, you can also read primitive types from `UserDefaults` using the built in functions in a `UserDefaults` object.
	@IBAction func onRead(_ sender: Any) {
		let text = keychain.get(Constants.textKey) ?? "No text stored yet"
		print("Text from Keychain: \(text)")

		let person = userDefaults.decodable(key: Constants.personKey, type: Person.self)
		print("Person from UserDefaults: \(person.map { String(describing: $0) } ?? "No Person stored yet")")

		print(Constants.debugDivider)
	}

	@IBAction func onShowAlert(_ sender: Any) {
		let alert = UIAlertController(
			title: "Hello",
			message: "This is longer text that can span multiple lines.",
			preferredStyle: .actionSheet // You can replace this with `.alert` to use the Alert type used more often
		)
		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
			print("Cancel was tapped!")
		}
		let goAction = UIAlertAction(title: "Go!", style: .default) { _ in
			print("Go was tapped!")
		}
		let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
			print("Delete was tapped!")
		}
		alert.addAction(cancelAction) // Notice how the Cancel action shows last even if you add it first.
		alert.addAction(deleteAction)
		alert.addAction(goAction)
		for num in 1...5 {
			let action = UIAlertAction(title: "\(num)", style: .default)
			alert.addAction(action)
		}
		present(alert, animated: true)
	}
}
