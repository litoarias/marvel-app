import Alamofire
import PromiseKit

final class Client: APIProtocol {
	
	private let session = Session()
	
	func getCharacters(_ page: Page) -> Promise<CharacterResponse> {
		let (promise, seal) = Promise<CharacterResponse>.pending()
		session.request(.getCharacters(page)).done { (characters: CharacterResponse) in
			seal.fulfill((characters))
		}.catch { error in
			seal.reject(error)
		}
		return promise
	}
}
