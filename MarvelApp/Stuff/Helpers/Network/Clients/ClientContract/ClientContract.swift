import PromiseKit

protocol APIProtocol: class {
	func getCharacters(_ page: Page) -> Promise<CharacterResponse>
	func getComics(_ page: Page, identifier: Int) -> Promise<ItemResponse>
	func getSeries(_ page: Page, identifier: Int) -> Promise<ItemResponse>
	func getEvents(_ page: Page, identifier: Int) -> Promise<ItemResponse>
}
