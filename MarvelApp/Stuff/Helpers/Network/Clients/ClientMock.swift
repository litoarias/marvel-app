import Alamofire
import PromiseKit

final class ClientMock: APIProtocol {
	
	var error: ApiError?
	
	func getCharacters(_ page: Page) -> Promise<CharacterResponse> {
		let (promise, seal) = Promise<CharacterResponse>.pending()
		switch error {
		case nil:
			guard let characters = Bundle.parse(
				fileName: NetworkConstants.Mock.charactersResponse(page).path,
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
	
	func getComics(_ page: Page, identifier: Int) -> Promise<ItemResponse> {
		let (promise, seal) = Promise<ItemResponse>.pending()
		switch error {
		case nil:
			guard let comics = Bundle.parse(
				fileName: NetworkConstants.Mock.comicsResponse.path,
				type: ItemResponse.self
			) else {
				fatalError("CharacterResponse is required!")
			}
			seal.fulfill(comics)
		default:
			seal.reject(error!)
		}
		return promise
	}
	
	func getSeries(_ page: Page, identifier: Int) -> Promise<ItemResponse> {
		let (promise, seal) = Promise<ItemResponse>.pending()
		switch error {
		case nil:
			guard let series = Bundle.parse(
				fileName: NetworkConstants.Mock.seriesResponse.path,
				type: ItemResponse.self
			) else {
				fatalError("CharacterResponse is required!")
			}
			seal.fulfill(series)
		default:
			seal.reject(error!)
		}
		return promise
	}
	
	func getEvents(_ page: Page, identifier: Int) -> Promise<ItemResponse> {
		let (promise, seal) = Promise<ItemResponse>.pending()
		switch error {
		case nil:
			guard let events = Bundle.parse(
				fileName: NetworkConstants.Mock.eventsResponse.path,
				type: ItemResponse.self
			) else {
				fatalError("CharacterResponse is required!")
			}
			seal.fulfill(events)
		default:
			seal.reject(error!)
		}
		return promise
	}
}
