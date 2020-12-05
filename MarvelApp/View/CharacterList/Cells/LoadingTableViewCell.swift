import UIKit

final class LoadingTableViewCell: UITableViewCell {
	
	// MARK: - PROPERTIES
	
	private var container = UIView()
	private var activityIndicator = UIActivityIndicatorView(style: .gray)
	static let className = String(describing: LoadingTableViewCell.self)
	
	// MARK: - LIFE CYCLE
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		addViews()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func startAnimate() {
		activityIndicator.startAnimating()
	}
}

// MARK: - PRIVATE METHODS

extension LoadingTableViewCell {
	private func addViews() {
		contentView.addSubview(container)
		container.translatesAutoresizingMaskIntoConstraints = false
		container.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
		container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
		container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
		container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
		
		container.addSubview(activityIndicator)
		activityIndicator.translatesAutoresizingMaskIntoConstraints = false
		activityIndicator.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
		activityIndicator.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
	}
}
