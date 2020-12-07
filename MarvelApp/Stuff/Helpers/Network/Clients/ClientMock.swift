import Alamofire
import PromiseKit

final class ClientMock: APIProtocol {
	
	var error: ApiError?
	
	func getCharacters(_ page: Page) -> Promise<CharacterResponse> {
		let (promise, seal) = Promise<CharacterResponse>.pending()
		switch error {
		case nil:
			guard let characters = Bundle.parse(
				fileName: NetworkConstants.Mock.charactersRequest(page).path,
				type: CharacterResponse.self
			) else {
				fatalError("CharacterResponse is required!")
			}
			seal.fulfill(characters)
		default:
			seal.reject(error!)
		}
		
		return promise
	}
	
	func getComics(_ page: Page, identifier: Int) -> Promise<ComicsResponse> {
		let (promise, seal) = Promise<ComicsResponse>.pending()
		
		return promise
	}
	
	func getSeries(_ page: Page, identifier: Int) -> Promise<SeriesResponse> {
		let (promise, seal) = Promise<SeriesResponse>.pending()
		
		return promise
	}
}
