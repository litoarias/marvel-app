import Alamofire
import PromiseKit

class Client: APIProtocol {
	private let session = Session()
	func getCharacters(_ page: Page) -> Promise<CharacterRequest> {
		let (promise, seal) = Promise<CharacterRequest>.pending()
		session.request(.getCharacters(page)).done { (characters: CharacterRequest) in
			seal.fulfill((characters))
		}.catch { error in
			seal.reject(error)
		}
		return promise
	}
}
