import PromiseKit

protocol APIProtocol: class {
	func getCharacters(_ page: Page) -> Promise<CharacterResponse>
	func getComics(_ page: Page, identifier: Int) -> Promise<ComicsResponse>
	func getSeries(_ page: Page, identifier: Int) -> Promise<SeriesResponse>
}
