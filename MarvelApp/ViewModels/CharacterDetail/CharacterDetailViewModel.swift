import PromiseKit

final class CharacterDetailViewModel: CharacterDetailProtocol {
	
	var comics: Observable<ComicsResponse?> = Observable(nil)
	var series: Observable<SeriesResponse?> = Observable(nil)
	var errorMessage: Observable<String?> = Observable(nil)
	private let session: APIProtocol?
	
	init(_ session: APIProtocol) {
		self.session = session
	}
	
}

// MARK: - PUBLIC METHODS

extension CharacterDetailViewModel {
	
	func fetchData(identifier: Int) {
		fetchComics(identifier: identifier)
		fetchSeries(identifier: identifier)
	}
}

// MARK: - PRIVATE METHODS

extension CharacterDetailViewModel {
	
	private func fetchComics(identifier: Int) {
		guard let session = self.session else { return }
		firstly {
			session.getComics(Page(limit: 75, offset: 0), identifier: identifier)
		}.done {
			self.comics.value = $0
		}.catch {
			debugPrint($0)
		}
	}
	
	private func fetchSeries(identifier: Int) {
		guard let session = self.session else { return }
		firstly {
			session.getSeries(Page(limit: 75, offset: 0), identifier: identifier)
		}.done {
			self.series.value = $0
		}.catch {
			debugPrint($0)
		}
	}
}
