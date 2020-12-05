import PromiseKit

protocol APIProtocol: class {
	func getCharacters(_ page: Page) -> Promise<CharacterRequest>
}
