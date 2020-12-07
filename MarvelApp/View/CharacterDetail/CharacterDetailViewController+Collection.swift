import UIKit
import Kingfisher

extension CharacterDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		if collectionView == collectionComicsView {
			return comics?.data?.results?.count ?? 0
		} else if collectionView == collectionSeriesView {
			return series?.data?.results?.count ?? 0
		}
		return 10
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
				
		if collectionView == collectionComicsView {
			
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.comicName, for: indexPath) as? ImageCollectionViewCell
			let item = comics?.data?.results?[indexPath.row].thumbnail?.thumbnailUrl ?? ""
			cell?.setup(thumbnail: item)
			return cell ?? ImageCollectionViewCell()
	
		} else if collectionView == collectionSeriesView {
		
			let item = series?.data?.results?[indexPath.row].thumbnail?.thumbnailUrl ?? ""
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.serieName, for: indexPath) as? ImageCollectionViewCell
			cell?.setup(thumbnail: item)
			return cell ?? ImageCollectionViewCell()
		
		} else {
		
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
			cell.backgroundColor = .red
			return cell
			
		}
		
	}
}
