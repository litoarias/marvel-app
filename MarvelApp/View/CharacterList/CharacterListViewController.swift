import PagedLists

final class CharacterListViewController: UIViewController {
	
	// MARK: - PROPERTIES
	
	var tableView = PagedTableView(frame: .zero)
	private var characterList = [Character]()
	private var viewModel: CharacterListViewModel?
	
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
	
}

// MARK: - UITABLEVIEWDATASOURCE

extension CharacterListViewController: UITableViewDataSource {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 2
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if section == 0 {
			return characterList.count
		} else if section == 1 && self.tableView.hasMore {
			return 1
		} else {
			return 0
		}
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		if indexPath.section == 0 {
			return UITableView.automaticDimension
		} else {
			return 90
		}
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if indexPath.section == 0 {
			let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self), for: indexPath) as UITableViewCell
			cell.textLabel?.text = "\(indexPath.row): \(self.characterList[indexPath.row].name ?? "\(indexPath.row)")"
			return cell
		} else {
			let cell = tableView.dequeueReusableCell(withIdentifier: LoadingTableViewCell.className, for: indexPath) as? LoadingTableViewCell
			cell?.startAnimate()
			return cell ?? LoadingTableViewCell()
		}
	}
}

// MARK: - PAGEDTABLEVIEWDELEGATE

extension CharacterListViewController: PagedTableViewDelegate {
	
	func tableView(_ tableView: PagedTableView, needsDataForPage page: Int, completion: @escaping (Int, NSError?) -> Void) {
		viewModel?.fetchCharacters(completion)
	}
	
	func tableView(_ tableView: PagedTableView, didSelectRowAt indexPath: IndexPath) {
		if indexPath.section == 0 {
			let item = characterList[indexPath.row]
			debugPrint(item)
		}
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
			self.tableView.reloadData()
		})
	}
}
