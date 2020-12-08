import UIKit

final class ImageCollectionViewCell: UICollectionViewCell {
	
	// MARK: - PROPERTIES

	private var backgroungImage = UIImageView()
	static let className = String(describing: ImageCollectionViewCell.self)
	
	// MARK: - LIFE CYCLE
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addViews()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: - PUBLIC METHODS

extension ImageCollectionViewCell {
	func setup(thumbnail: String) {
		if let imageUrl = URL(string: thumbnail) {
			backgroungImage.kf.setImage(with: imageUrl, options: nil)
		}
	}
}

// MARK: - PRIVATE METHODS

extension ImageCollectionViewCell {
	
	private func addViews() {
		backgroungImage.contentMode = .scaleAspectFill
		contentView.addSubview(backgroungImage)
		backgroungImage.layer.cornerRadius = 5
		backgroungImage.clipsToBounds = true
		backgroungImage.translatesAutoresizingMaskIntoConstraints = false
		backgroungImage.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
		backgroungImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
		backgroungImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
		backgroungImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
	}
}
