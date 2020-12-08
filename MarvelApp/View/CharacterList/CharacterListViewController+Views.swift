import UIKit

extension CharacterListViewController {
	
	func setupViews() {
		if #available(iOS 13.0, *) {
			view.backgroundColor = .systemBackground
		} else {
			view.backgroundColor = .white
		}
		setupNavigationBar()
		setupTable()
	}
	
	private func setupNavigationBar() {
		title = "Marvel Heroes"
		navigationController?.navigationBar.prefersLargeTitles = true
		navigationController?.navigationItem.largeTitleDisplayMode = .always
	}
	
	private func setupTable() {
		view.addSubview(tableView)
		tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: CharacterTableViewCell.className)
		tableView.register(LoadingTableViewCell.self, forCellReuseIdentifier: LoadingTableViewCell.className)
		tableView.dataSource = self
		tableView.updateDelegate = self
		tableView.elementsPerPage = defaultLimit
		tableView.rowHeight = UITableView.automaticDimension
		tableView.estimatedRowHeight = UITableView.automaticDimension
		tableView.tableFooterView = UIView()
		
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
		tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
		tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
		tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
	}
}
