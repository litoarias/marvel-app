import UIKit

extension UIViewController {
	func popupAlert(title: String?, message: String?) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		let action = UIAlertAction(title: title, style: .default)
		alert.addAction(action)
		self.present(alert, animated: true, completion: nil)
	}
}
