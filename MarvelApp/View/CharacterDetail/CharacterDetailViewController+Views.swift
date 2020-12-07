import UIKit

extension CharacterDetailViewController {
	
	func setupViews() {
		if #available(iOS 13.0, *) {
			view.backgroundColor = .systemBackground
		} else {
			view.backgroundColor = .white
		}
		setupScrollView()
		setupContainer()
		setupLabelTitle()
	}
	
	private func setupScrollView() {
		view.addSubview(scrollView)
		scrollView.contentInsetAdjustmentBehavior = .never
		scrollView.translatesAutoresizingMaskIntoConstraints = false
		scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
		scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
		scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
		scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
	}
	
	private func setupContainer() {
		scrollView.addSubview(container)
		container.translatesAutoresizingMaskIntoConstraints = false
		container.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
		container.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
		container.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
		container.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
		container.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
	}
	
	private func setupLabelTitle() {
		container.addSubview(labelTitle)
		labelTitle.text = "The standard Lorem Ipsum passage, used since the 1500s"
		labelTitle.numberOfLines = 0
		labelTitle.font = UIFont.preferredFont(forTextStyle: .title1)
		labelTitle.adjustsFontForContentSizeCategory = true
		labelTitle.translatesAutoresizingMaskIntoConstraints = false
		labelTitle.topAnchor.constraint(equalTo: container.topAnchor, constant: 16).isActive = true
		labelTitle.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16).isActive = true
		labelTitle.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16).isActive = true
	}
	
}
