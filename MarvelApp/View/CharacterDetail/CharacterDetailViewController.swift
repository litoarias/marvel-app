import UIKit

final class CharacterDetailViewController: UIViewController {
	
	// MARK: - PROPERTIES

	private var character: Character?
	private var viewModel: CharacterDetailViewModel?
	
	let scrollView: UIScrollView = UIScrollView()
	let container: UIView = UIView()
	let labelTitle: UILabel = UILabel()
	
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
		title = character?.name
		debugPrint(self.character)
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
}
