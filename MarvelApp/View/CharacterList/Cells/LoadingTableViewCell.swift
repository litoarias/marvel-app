import UIKit

final class LoadingTableViewCell: UITableViewCell {
	
	// MARK: - PROPERTIES
	
	private var activityIndicator: UIActivityIndicatorView!
	static let className = String(describing: LoadingTableViewCell.self)
	
	// MARK: - LIFE CYCLE
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		addViews()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}

// MARK: - PUBLIC METHODS

extension LoadingTableViewCell {
	
	func startAnimate() {
		activityIndicator.startAnimating()
	}
}

// MARK: - PRIVATE METHODS

extension LoadingTableViewCell {
	private func addViews() {
		if #available(iOS 13.0, *) {
			activityIndicator = UIActivityIndicatorView(style: .large)
		} else {
			activityIndicator = UIActivityIndicatorView(style: .gray)
		}
		contentView.addSubview(activityIndicator)
		activityIndicator.translatesAutoresizingMaskIntoConstraints = false
		activityIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
		activityIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
	}
}
