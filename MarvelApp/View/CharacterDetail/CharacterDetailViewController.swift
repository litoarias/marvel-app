import UIKit

final class CharacterDetailViewController: UIViewController {
	
	// MARK: - PROPERTIES

	private var character: Character?
	private var viewModel: CharacterDetailViewModel?
	
	let scrollView = UIScrollView()
	let container = UIView()
	let labelDescription = UILabel()
	let backgroundImage = UIImageView()
	let labelTitleComics = UILabel()
	var collectionComicsView: UICollectionView!
	let labelTitleSeries = UILabel()
	var collectionSeriesView: UICollectionView!
	let labelTitleStories = UILabel()
	var collectionStoriesView: UICollectionView!

	// MARK: - LIFE CYCLE

	init(viewModel: CharacterDetailViewModel, character: Character) {
		super.init(nibName: nil, bundle: nil)
		self.viewModel = viewModel
		self.character = character
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func loadView() {
		super.loadView()
		setupViews()
		bindCharacter()
	}
	
	static func setup(with character: Character) -> CharacterDetailViewController {
		var viewModel: CharacterDetailViewModel!
		#if MOCK || XCTEST
		viewModel = CharacterDetailViewModel()
		#else
		viewModel = CharacterDetailViewModel()
		#endif
		return CharacterDetailViewController(viewModel: viewModel, character: character)
	}
}

// MARK: - PRIVATE METHODS

extension CharacterDetailViewController {
	
	private func bindCharacter() {
		title = character?.name
		labelDescription.text = character?.descript
		if let iUrl = character?.thumbnail?.thumbnailUrl, let imageUrl = URL(string: iUrl) {
			backgroundImage.kf.setImage(with: imageUrl, options: nil)
		}
	}
}
