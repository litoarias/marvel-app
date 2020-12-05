import UIKit

extension CharacterListViewController {
	
	func setupViews() {
		setupTable()
	}
	
	private func setupTable() {
		view.addSubview(tableView)
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
		tableView.register(LoadingTableViewCell.self, forCellReuseIdentifier: LoadingTableViewCell.className)
		tableView.dataSource = self
		tableView.updateDelegate = self
		tableView.rowHeight = UITableView.automaticDimension
		tableView.estimatedRowHeight = UITableView.automaticDimension
		tableView.elementsPerPage = defaultLimit
		tableView.tableFooterView = UIView()
		
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
		tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
		tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
		tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
	}
}
