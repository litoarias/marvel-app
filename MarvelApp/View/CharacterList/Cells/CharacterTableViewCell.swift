import UIKit
import Kingfisher

class CharacterTableViewCell: UITableViewCell {
	
	// MARK: - PROPERTIES
	
	private var container = UIView()
	var icon = UIImageView()
	private var title = UILabel()
	private var subtitle = UILabel()
	
	static let className = String(describing: CharacterTableViewCell.self)
	
	// MARK: - LIFE CYCLE
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		addViews()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setup(with character: Character) {
		title.text = character.name
		let desc = character.desc?.isEmpty ?? "".isEmpty ? "Not description provided" : character.desc
		subtitle.text = desc
		if let iUrl = character.thumbnail?.thumbnailUrl,  let imageUrl = URL(string: iUrl) {
			icon.kf.setImage(with: imageUrl, options: nil)
			icon.layer.masksToBounds = true
			icon.layer.cornerRadius = 5
		}
	}
}

// MARK: - PRIVATE METHODS

extension CharacterTableViewCell {
	private func addViews() {
		contentView.addSubview(container)
		container.translatesAutoresizingMaskIntoConstraints = false
		container.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
		container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
		container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
		container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
		
		container.addSubview(icon)
		icon.contentMode = .scaleToFill
		icon.backgroundColor = .clear
		icon.translatesAutoresizingMaskIntoConstraints = false
		icon.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 12).isActive = true
		icon.heightAnchor.constraint(equalToConstant: 72).isActive = true
		icon.widthAnchor.constraint(equalToConstant: 72).isActive = true
		icon.topAnchor.constraint(equalTo: container.topAnchor, constant: 10).isActive = true
		icon.bottomAnchor.constraint(lessThanOrEqualTo: container.bottomAnchor, constant: -12).isActive = true
		
		container.addSubview(title)
		title.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.heavy)
		title.translatesAutoresizingMaskIntoConstraints = false
		title.centerYAnchor.constraint(equalTo: icon.centerYAnchor, constant: -15).isActive = true
		title.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 8).isActive = true
		title.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -8).isActive = true
		
		container.addSubview(subtitle)
		subtitle.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
		subtitle.numberOfLines = 3
		subtitle.textColor = .systemGray
		subtitle.translatesAutoresizingMaskIntoConstraints = false
		subtitle.topAnchor.constraint(greaterThanOrEqualTo: title.bottomAnchor).isActive = true
		subtitle.centerYAnchor.constraint(equalTo: icon.centerYAnchor, constant: 15).isActive = true
		subtitle.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 8).isActive = true
		subtitle.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -8).isActive = true
		subtitle.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -12).isActive = true
	}
}
