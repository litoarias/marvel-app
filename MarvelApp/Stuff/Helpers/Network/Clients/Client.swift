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
	
	func getComics(_ page: Page, identifier: Int) -> Promise<ComicsResponse> {
		let (promise, seal) = Promise<ComicsResponse>.pending()
		session.request(.getComics(identifier, page)).done { (comics: ComicsResponse) in
			seal.fulfill((comics))
		}.catch { error in
			seal.reject(error)
		}
		return promise
	}
	
	func getSeries(_ page: Page, identifier: Int) -> Promise<SeriesResponse> {
		let (promise, seal) = Promise<SeriesResponse>.pending()
		session.request(.getSeries(identifier, page)).done { (series: SeriesResponse) in
			seal.fulfill((series))
		}.catch { error in
			seal.reject(error)
		}
		return promise
	}
}
