import Alamofire
import PromiseKit

final class ClientMock: APIProtocol {
	
	var error: ApiError?
	
	func getCharacters(_ page: Page) -> Promise<CharacterResponse> {
		let (promise, seal) = Promise<CharacterResponse>.pending()
		
		switch error {
		case nil:
			guard let characters = Bundle.parse(
				fileName: NetworkConstants.Mock.charactersRequest.rawValue,
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
}
