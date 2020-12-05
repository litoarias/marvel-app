import UIKit
import PromiseKit
import Alamofire
import PagedLists

let defaultLimit = 100

class ViewController: UIViewController {
	
	private let apiSession = Session()
	private var currentPage: Page = Page(limit: defaultLimit, offset: 0)
	
	var tableView = PagedTableView(frame: .zero)
	var characterList = [Character]()
	
	override func loadView() {
		super.loadView()
		
		view.addSubview(tableView)
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
		tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
		tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
		tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
		tableView.register(LoadingTableViewCell.self, forCellReuseIdentifier: LoadingTableViewCell.className)
		tableView.dataSource = self
		tableView.rowHeight = UITableView.automaticDimension
		tableView.estimatedRowHeight = UITableView.automaticDimension
		tableView.elementsPerPage = defaultLimit
		tableView.updateDelegate = self
		tableView.tableFooterView = UIView()

	}
	
	func cleanFunc(_ completion: ((Int, NSError?) -> Void)?) {
		firstly {
			self.getCharacters()
		}.then {
			self.reloadItems($0, completion: completion ?? {_,_ in})
		}.catch {
			debugPrint($0)
		}.finally {
			self.tableView.reloadData()
		}
	}
	
	func getCharacters() -> Promise<CharacterRequest> {
		let (promise, seal) = Promise<CharacterRequest>.pending()
		apiSession.request(.getCharacters(currentPage)).done { (characters: CharacterRequest) in
			seal.fulfill((characters))
		}.catch { error in
			seal.reject(error)
		}
		return promise
	}
	
	func reloadItems(_ list: CharacterRequest, completion: @escaping (Int, NSError?) -> Void) -> Promise<Int> {
		let (promise, seal) = Promise<Int>.pending()
		currentPage.offset += list.data?.count ?? 0
		self.characterList += list.data?.results ?? []
		let loadmore = currentPage.offset < defaultLimit
		tableView.hasMore = loadmore
		completion(list.data?.count ?? 0, nil)
		seal.fulfill(currentPage.offset)
		return promise
	}
	
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		if indexPath.section == 0 {
			return UITableView.automaticDimension
		} else {
			return 90
		}
	}
}

// MARK: - Data Source
extension ViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if section == 0 {
			return characterList.count
		} else if section == 1 && self.tableView.hasMore {
			return 1
		} else {
			return 0
		}
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 2
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

extension ViewController: PagedTableViewDelegate {
	
	func tableView(_ tableView: PagedTableView, needsDataForPage page: Int, completion: @escaping (Int, NSError?) -> Void) {
		cleanFunc(completion)
	}
}
