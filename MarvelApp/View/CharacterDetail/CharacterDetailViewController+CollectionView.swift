import UIKit
import Kingfisher

extension CharacterDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		if collectionView == collectionComicsView {
			return comics?.data?.results?.count ?? 0
		} else if collectionView == collectionSeriesView {
			return series?.data?.results?.count ?? 0
		} else {
			return events?.data?.results?.count ?? 0
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		var item: String = ""
		if collectionView == collectionComicsView {
			item = comics?.data?.results?[indexPath.row].thumbnail?.thumbnailUrl ?? ""
		} else if collectionView == collectionSeriesView {
			item = series?.data?.results?[indexPath.row].thumbnail?.thumbnailUrl ?? ""
		} else {
			item = events?.data?.results?[indexPath.row].thumbnail?.thumbnailUrl ?? ""
		}
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.className, for: indexPath) as? ImageCollectionViewCell
		cell?.setup(thumbnail: item)
		return cell ?? ImageCollectionViewCell()
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		var item: String = ""
		if collectionView == collectionComicsView {
			item = comics?.data?.results?[indexPath.row].urls?[0].link ?? ""
		} else if collectionView == collectionSeriesView {
			item = series?.data?.results?[indexPath.row].urls?[0].link ?? ""
		} else {
			item = events?.data?.results?[indexPath.row].urls?[0].link ?? ""
		}
		if let url = URL(string: item) {
			UIApplication.shared.open(url)
		}
	}
}
