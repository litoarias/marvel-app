import UIKit
import Kingfisher

extension CharacterDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		if collectionView == collectionComicsView {
			return comics?.data?.results?.count ?? 0
		} else if collectionView == collectionSeriesView {
			return series?.data?.results?.count ?? 0
		} else {
			return stories?.data?.results?.count ?? 0
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		var item: String = ""
		if collectionView == collectionComicsView {
			item = comics?.data?.results?[indexPath.row].thumbnail?.thumbnailUrl ?? ""
		} else if collectionView == collectionSeriesView {
			item = series?.data?.results?[indexPath.row].thumbnail?.thumbnailUrl ?? ""
		} else {
			item = stories?.data?.results?[indexPath.row].thumbnail?.thumbnailUrl ?? ""
		}
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.className, for: indexPath) as? ImageCollectionViewCell
		cell?.setup(thumbnail: item)
		return cell ?? ImageCollectionViewCell()
	}
}
