import UIKit
import PromiseKit
import Alamofire
import PagedLists

final class CharacterListViewController: UIViewController {
	
	// MARK: - Properties
	
	var tableView = PagedTableView(frame: .zero)
	
	private var characterList = [Character]()
	var viewModel: CharacterListViewModel?
	
	// MARK: - Life cycle
	
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

// MARK: - UITableViewDelegate

extension CharacterListViewController: UITableViewDelegate {
}

// MARK: - Data Source

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
			cell?.activityIndicator.startAnimating()
			return cell ?? LoadingTableViewCell()
		}
	}
}

// MARK: - PagedTableViewDelegate

extension CharacterListViewController: PagedTableViewDelegate {
	func tableView(_ tableView: PagedTableView, needsDataForPage page: Int, completion: @escaping (Int, NSError?) -> Void) {
		viewModel?.fetchCharacters(completion)
	}
}

// MARK: - Private Methods

extension CharacterListViewController {
	
	private func bindProperties() {
		viewModel?.hasMore.bind({ [weak self] hasMore in
			guard let self = self else { return }
			self.tableView.hasMore = hasMore ?? false
		})
		viewModel?.characters.bind({ [weak self] newItems in
			guard let self = self else { return }
			debugPrint(self.characterList.count)
			self.characterList += newItems ?? []
			debugPrint(self.characterList.count)
		})
		viewModel?.reload.bind({ [weak self] _ in
			guard let self = self else { return }
			self.tableView.reloadData()
		})
	}
	
	//	func fetchCharacters(_ completion: ((Int, NSError?) -> Void)?) {
	//		firstly {
	//			session.getCharacters(currentPage)
	//		}.then {
	//			self.reloadItems($0, completion: completion ?? {_,_ in})
	//		}.catch {
	//			debugPrint($0)
	//		}.finally {
	//			self.tableView.reloadData()
	//		}
	//	}
	//
	//	func reloadItems(_ list: CharacterRequest, completion: @escaping (Int, NSError?) -> Void) -> Promise<Int> {
	//		let (promise, seal) = Promise<Int>.pending()
	//		currentPage.offset += list.data?.count ?? 0
	//		self.characterList += list.data?.results ?? []
	//		let loadmore = currentPage.offset < defaultLimit
	//		tableView.hasMore = loadmore
	//		completion(list.data?.count ?? 0, nil)
	//		seal.fulfill(currentPage.offset)
	//		return promise
	//	}
	
}
