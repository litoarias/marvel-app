import PromiseKit

let defaultLimit = 50

final class CharacterListViewModel: CharacterListProtocol {
	
	private let session: APIProtocol?
	private var currentPage: Page = Page(limit: defaultLimit, offset: 0)
	
	var hasMore: Observable<Bool?> = Observable(true)
	var characters: Observable<[Character]?> = Observable([])
	var reload: Observable<Void?> = Observable(())
	var errorMessage: Observable<String?> = Observable(nil)
	
	init(_ session: APIProtocol) {
		self.session = session
	}
	
	func fetchCharacters(_ completion: @escaping ((Int, NSError?) -> Void)) {
		guard let session = self.session else { return }
		firstly {
			session.getCharacters(currentPage)
		}.then {
			self.incrementPage($0, completion: completion)
		}.then {
			self.appendData($0, completion: $1)
		}.catch {
			self.errorMessage.value = ($0 as? ApiError)?.errorDescription
		}.finally {
			self.reload.value = ()
		}
	}
	
	private func incrementPage(_ request: CharacterResponse, completion: @escaping (Int, NSError?) -> Void) -> Promise<(CharacterResponse, completion: (Int, NSError?) -> Void)> {
		let (promise, seal) = Promise<(CharacterResponse, completion: (Int, NSError?) -> Void)>.pending()
		
		currentPage.offset += request.data?.count ?? 0
		hasMore.value = (currentPage.offset < defaultLimit)
		seal.fulfill((request, completion))
		
		return promise
	}
	
	private func appendData(_ request: CharacterResponse, completion: @escaping (Int, NSError?) -> Void) -> Promise<Void> {
		let (promise, seal) = Promise<Void>.pending()
		
		characters.value = (request.data?.results ?? [])
		completion(request.data?.count ?? 0, nil)
		seal.fulfill(())
		
		return promise
	}
}
