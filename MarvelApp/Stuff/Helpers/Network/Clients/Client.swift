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
	
	func getComics(_ page: Page, identifier: Int) -> Promise<ItemResponse> {
		let (promise, seal) = Promise<ItemResponse>.pending()
		session.request(.getComics(identifier, page)).done { (comics: ItemResponse) in
			seal.fulfill((comics))
		}.catch { error in
			seal.reject(error)
		}
		return promise
	}
	
	func getSeries(_ page: Page, identifier: Int) -> Promise<ItemResponse> {
		let (promise, seal) = Promise<ItemResponse>.pending()
		session.request(.getSeries(identifier, page)).done { (series: ItemResponse) in
			seal.fulfill((series))
		}.catch { error in
			seal.reject(error)
		}
		return promise
	}
	
	func getEvents(_ page: Page, identifier: Int) -> Promise<ItemResponse> {
		let (promise, seal) = Promise<ItemResponse>.pending()
		session.request(.getEvents(identifier, page)).done { (events: ItemResponse) in
			seal.fulfill((events))
		}.catch { error in
			seal.reject(error)
		}
		return promise
	}
}
