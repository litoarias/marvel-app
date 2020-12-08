import UIKit

extension UICollectionView {
	func setEmptyMessage(_ message: String) {
		let container = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))

		let messageLabel = UILabel()
		messageLabel.text = message
		messageLabel.textColor = .black
		messageLabel.numberOfLines = 0
		messageLabel.textAlignment = .center
		messageLabel.font = UIFont.systemFont(ofSize: 22)
		messageLabel.translatesAutoresizingMaskIntoConstraints = false
		
		container.addSubview(messageLabel)
		messageLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
		messageLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
		
		self.backgroundView?.layer.opacity = 0.0
		self.backgroundView = container
		
		UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: [], animations: {
			self.backgroundView?.layer.opacity = 1.0
		}, completion: nil)
	}
	
	func restore() {
		self.backgroundView = nil
	}
	
}
