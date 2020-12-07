import PagedLists

final class CharacterListViewController: UIViewController {
	
	// MARK: - PROPERTIES
	
	var tableView = PagedTableView(frame: .zero)
	var characterList = [Character]()
	var viewModel: CharacterListViewModel?
	
	// MARK: - LIFE CYCLE
	
	init(viewModel: CharacterListViewModel) {
		super.init(nibName: nil, bundle: nil)
		self.viewModel = viewModel
		bindProperties()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func loadView() {
		super.loadView()
		setupViews()
	}
	
	static func setup() -> CharacterListViewController {
		var viewModel: CharacterListViewModel!
		#if MOCK || XCTEST
		viewModel = CharacterListViewModel(ClientMock())
		#else
		viewModel = CharacterListViewModel(Client())
		#endif
		return CharacterListViewController(viewModel: viewModel)
	}
}

// MARK: - PRIVATE METHODS

extension CharacterListViewController {
	
	private func bindProperties() {
		
		viewModel?.hasMore.bind({ [weak self] hasMore in
			guard let self = self else { return }
			self.tableView.hasMore = hasMore ?? false
		})
		
		viewModel?.characters.bind({ [weak self] newItems in
			guard let self = self else { return }
			self.characterList += newItems ?? []
		})
		
		viewModel?.reload.bind({ [weak self] _ in
			guard let self = self else { return }
			DispatchQueue.main.async {
				self.tableView.reloadData()
			}
		})
		
		viewModel?.errorMessage.bind({ [weak self] message in
			guard let self = self else { return }
			DispatchQueue.main.async {
				!(message?.isEmpty ?? true) ? self.popupAlert(title: "Error", message: message) : nil
			}
		})
	}
}
