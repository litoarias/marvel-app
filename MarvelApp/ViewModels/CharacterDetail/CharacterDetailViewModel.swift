import PromiseKit

final class CharacterDetailViewModel: CharacterDetailProtocol {
	
	// MARK: - PROPERTIES
	
	var comics: Observable<ComicsResponse?> = Observable(nil)
	var series: Observable<SeriesResponse?> = Observable(nil)
	var stories: Observable<StoriesResponse?> = Observable(nil)
	var errorMessage: Observable<String?> = Observable(nil)
	private let session: APIProtocol?
	
	// MARK: - LIFE CYCLE
	
	init(_ session: APIProtocol) {
		self.session = session
	}
	
}

// MARK: - PUBLIC METHODS

extension CharacterDetailViewModel {
	
	/// Simultaneous call to fetch `Comics`, `Series` and `Stories`
	/// - Parameter identifier: Character identifier, needed to make request
	func fetchData(identifier: Int) {
		fetchComics(identifier: identifier)
		fetchSeries(identifier: identifier)
		fetchStories(identifier: identifier)
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
	
	private func fetchStories(identifier: Int) {
		guard let session = self.session else { return }
		firstly {
			session.getStories(Page(limit: 75, offset: 0), identifier: identifier)
		}.done {
			self.stories.value = $0
		}.catch {
			self.setError(($0 as? ApiError ?? ApiError.unknown))
		}
	}
	
	private func setError(_ error: ApiError) {
		self.errorMessage.value = error.errorDescription
	}
}
