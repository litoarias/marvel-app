import UIKit

final class CharacterDetailViewController: UIViewController {
	
	// MARK: - OUTLETS
	
	let scrollView = UIScrollView()
	let container = UIView()
	let labelDescription = UILabel()
	let backgroundImage = UIImageView()
	let labelTitleComics = UILabel()
	var collectionComicsView: UICollectionView!
	let labelTitleSeries = UILabel()
	var collectionSeriesView: UICollectionView!
	let labelTitleEvents = UILabel()
	var collectionEventsView: UICollectionView!
	
	// MARK: - PROPERTIES
	
	private var character: Character?
	private var viewModel: CharacterDetailViewModel?
	var comics: ItemResponse?
	var series: ItemResponse?
	var events: ItemResponse?
	
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
		bindProperties()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		guard let identifier = character?.identifier else {
			debugPrint("Without id can't be showed data!")
			return
		}
		viewModel?.fetchData(identifier: identifier)
	}
	
	static func setup(with character: Character) -> CharacterDetailViewController {
		var viewModel: CharacterDetailViewModel!
		#if MOCK || XCTEST
		viewModel = CharacterDetailViewModel(ClientMock())
		#else
		viewModel = CharacterDetailViewModel(Client())
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
	
	private func bindProperties() {
		viewModel?.comics.bind({ [weak self] comics in
			guard let self = self else { return }
			self.comics = comics
			DispatchQueue.main.async {
				self.collectionComicsView.reloadData()
			}
		})
		
		viewModel?.series.bind({ [weak self] series in
			guard let self = self else { return }
			self.series = series
			DispatchQueue.main.async {
				self.collectionSeriesView.reloadData()
			}
		})
		
		viewModel?.events.bind({ [weak self] events in
			guard let self = self else { return }
			self.events = events
			DispatchQueue.main.async {
				self.collectionEventsView.reloadData()
			}
		})
		
		viewModel?.errorMessage.bind({ [weak self] message in
			guard let self = self else { return }
			DispatchQueue.main.async {
				!(message?.isEmpty ?? true) ? self.popupAlert(title: "Error", message: message): nil
			}
		})
	}
	
}
