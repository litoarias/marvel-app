//
//  LoadingTableViewCell.swift
//  MarvelApp
//
//  Created by Hipolito Arias on 5/12/20.
//

import UIKit

class LoadingTableViewCell: UITableViewCell {

	var activityIndicator = UIActivityIndicatorView()
	static let className = String(describing: LoadingTableViewCell.self)

    override func awakeFromNib() {
        super.awakeFromNib()
		
		contentView.addSubview(activityIndicator)
		activityIndicator.startAnimating()
		activityIndicator.style = .gray
		activityIndicator.translatesAutoresizingMaskIntoConstraints = false
		activityIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
		activityIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
		activityIndicator.heightAnchor.constraint(equalToConstant: 48).isActive = true
		activityIndicator.widthAnchor.constraint(equalToConstant: 48).isActive = true
		activityIndicator.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6).isActive = true
		activityIndicator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6).isActive = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
