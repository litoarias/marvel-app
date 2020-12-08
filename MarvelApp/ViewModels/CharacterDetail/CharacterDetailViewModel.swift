import PromiseKit

final class CharacterDetailViewModel: CharacterDetailProtocol {
	
	// MARK: - PROPERTIES
	
	var comics: Observable<ItemResponse?> = Observable(nil)
	var series: Observable<ItemResponse?> = Observable(nil)
	var events: Observable<ItemResponse?> = Observable(nil)
	var errorMessage: Observable<String?> = Observable(nil)
	private let session: APIProtocol?
	
	// MARK: - LIFE CYCLE
	
	init(_ session: APIProtocol) {
		self.session = session
	}
	
}

// MARK: - PUBLIC METHODS

extension CharacterDetailViewModel {
	
	/// Simultaneous call to fetch `Comics`, `Series` and `Events`
	/// - Parameter identifier: Character identifier, needed to make request
	func fetchData(identifier: Int) {
		fetchComics(identifier: identifier)
		fetchSeries(identifier: identifier)
		fetchEvents(identifier: identifier)
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
			self.setError(($0 as? ApiError ?? ApiError.unknown))
		}
	}
	
	private func fetchSeries(identifier: Int) {
		guard let session = self.session else { return }
		firstly {
			session.getSeries(Page(limit: 75, offset: 0), identifier: identifier)
		}.done {
			self.series.value = $0
		}.catch {
			self.setError(($0 as? ApiError ?? ApiError.unknown))
		}
	}
	
	private func fetchEvents(identifier: Int) {
		guard let session = self.session else { return }
		firstly {
			session.getEvents(Page(limit: 75, offset: 0), identifier: identifier)
		}.done {
			self.events.value = $0
		}.catch {
			self.setError(($0 as? ApiError ?? ApiError.unknown))
		}
	}
	
	private func setError(_ error: ApiError) {
		self.errorMessage.value = error.errorDescription
	}
}
