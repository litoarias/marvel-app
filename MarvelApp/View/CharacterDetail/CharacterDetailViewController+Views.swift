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
		setupBackgroundImage()
		setupLabelTitle()
		setupTitleComicsCollection()
		setupComicsCollection()
		setupTitleSeriesCollection()
		setupSeriesCollection()
		setupTitleStoriesCollection()
		setupStoriesCollection()
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
		container.backgroundColor = .clear
		container.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
		container.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
		container.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
		container.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
		container.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
	}
	
	private func setupBackgroundImage() {
		container.addSubview(backgroundImage)
		backgroundImage.contentMode = .scaleAspectFill
		backgroundImage.clipsToBounds = true
		backgroundImage.translatesAutoresizingMaskIntoConstraints = false
		backgroundImage.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
		backgroundImage.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
		backgroundImage.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
		backgroundImage.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.height / 3).isActive = true
	}
	
	private func setupLabelTitle() {
		container.addSubview(labelDescription)
		labelDescription.numberOfLines = 0
		labelDescription.font = UIFont.preferredFont(forTextStyle: .title2)
		labelDescription.adjustsFontForContentSizeCategory = true
		labelDescription.translatesAutoresizingMaskIntoConstraints = false
		labelDescription.topAnchor.constraint(equalTo: backgroundImage.bottomAnchor, constant: 18).isActive = true
		labelDescription.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16).isActive = true
		labelDescription.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16).isActive = true
	}
	
	private func setupTitleComicsCollection() {
		container.addSubview(labelTitleComics)
		labelTitleComics.font = UIFont.systemFont(ofSize: 28, weight: .heavy)
		labelTitleComics.text = "Comics"
		labelTitleComics.translatesAutoresizingMaskIntoConstraints = false
		labelTitleComics.topAnchor.constraint(equalTo: labelDescription.bottomAnchor, constant: 22).isActive = true
		labelTitleComics.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16).isActive = true
		labelTitleComics.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16).isActive = true
	}
	
	private func setupComicsCollection() {
		collectionComicsView = UICollectionView(frame: .zero, collectionViewLayout: commonLayout(size: CGSize(width: 120, height: 180)))
		collectionComicsView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.className)
		collectionComicsView.backgroundColor = .clear
		collectionComicsView.showsHorizontalScrollIndicator = false
		collectionComicsView.delegate = self
		collectionComicsView.dataSource = self
		
		container.addSubview(collectionComicsView)
		collectionComicsView.translatesAutoresizingMaskIntoConstraints = false
		collectionComicsView.topAnchor.constraint(equalTo: labelTitleComics.bottomAnchor, constant: 16).isActive = true
		collectionComicsView.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
		collectionComicsView.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
		collectionComicsView.heightAnchor.constraint(equalToConstant: 180).isActive = true
	}
	
	private func setupTitleSeriesCollection() {
		container.addSubview(labelTitleSeries)
		labelTitleSeries.font = UIFont.systemFont(ofSize: 28, weight: .heavy)
		labelTitleSeries.text = "Series"
		labelTitleSeries.translatesAutoresizingMaskIntoConstraints = false
		labelTitleSeries.topAnchor.constraint(equalTo: collectionComicsView.bottomAnchor, constant: 22).isActive = true
		labelTitleSeries.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16).isActive = true
		labelTitleSeries.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16).isActive = true
	}
	
	private func setupSeriesCollection() {
		collectionSeriesView = UICollectionView(frame: .zero, collectionViewLayout: commonLayout(size: CGSize(width: 140, height: 200)))
		collectionSeriesView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.className)
		collectionSeriesView.backgroundColor = .clear
		collectionSeriesView.showsHorizontalScrollIndicator = false
		collectionSeriesView.delegate = self
		collectionSeriesView.dataSource = self
		
		container.addSubview(collectionSeriesView)
		collectionSeriesView.translatesAutoresizingMaskIntoConstraints = false
		collectionSeriesView.topAnchor.constraint(equalTo: labelTitleSeries.bottomAnchor, constant: 16).isActive = true
		collectionSeriesView.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
		collectionSeriesView.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
		collectionSeriesView.heightAnchor.constraint(equalToConstant: 200).isActive = true
	}
	
	private func setupTitleStoriesCollection() {
		container.addSubview(labelTitleStories)
		labelTitleStories.font = UIFont.systemFont(ofSize: 28, weight: .heavy)
		labelTitleStories.text = "Stories"
		labelTitleStories.translatesAutoresizingMaskIntoConstraints = false
		labelTitleStories.topAnchor.constraint(equalTo: collectionSeriesView.bottomAnchor, constant: 22).isActive = true
		labelTitleStories.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16).isActive = true
		labelTitleStories.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16).isActive = true
	}
	
	private func setupStoriesCollection() {
		collectionStoriesView = UICollectionView(frame: .zero, collectionViewLayout: commonLayout(size: CGSize(width: 120, height: 180)))
		collectionComicsView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.className)
		collectionStoriesView.backgroundColor = .clear
		collectionStoriesView.showsHorizontalScrollIndicator = false
		collectionStoriesView.delegate = self
		collectionStoriesView.dataSource = self
		
		container.addSubview(collectionStoriesView)
		collectionStoriesView.translatesAutoresizingMaskIntoConstraints = false
		collectionStoriesView.topAnchor.constraint(equalTo: labelTitleStories.bottomAnchor, constant: 16).isActive = true
		collectionStoriesView.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
		collectionStoriesView.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
		collectionStoriesView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -12).isActive = true
		collectionStoriesView.heightAnchor.constraint(equalToConstant: 180).isActive = true
	}
	
	private func commonLayout(size: CGSize) -> UICollectionViewFlowLayout {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		layout.minimumLineSpacing = 20
		layout.minimumInteritemSpacing = 20
		layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
		layout.itemSize = size
		return layout
	}
}
