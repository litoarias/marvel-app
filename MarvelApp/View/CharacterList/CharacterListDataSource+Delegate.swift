import PagedLists

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
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if indexPath.section == 0 {
			let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.className, for: indexPath) as? CharacterTableViewCell
			let item = characterList[indexPath.row]
			cell?.setup(with: item)
			return cell ?? CharacterTableViewCell()
		} else {
			let cell = tableView.dequeueReusableCell(withIdentifier: LoadingTableViewCell.className, for: indexPath) as? LoadingTableViewCell
			cell?.startAnimate()
			return cell ?? LoadingTableViewCell()
		}
	}
	
	func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.className, for: indexPath)
		cell.imageView?.kf.cancelDownloadTask()
		if indexPath.section == 0 {
			let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.className, for: indexPath) as? CharacterTableViewCell
			cell?.icon.kf.cancelDownloadTask()
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
			navigationController?.pushViewController(CharacterDetailViewController.setup(with: item), animated: true) 
		}
	}
}
