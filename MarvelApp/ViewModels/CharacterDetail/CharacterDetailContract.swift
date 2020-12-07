import Foundation

protocol CharacterDetailProtocol {
	var comics: Observable<ComicsResponse?> { get set }
	var errorMessage: Observable<String?> { get set }
}
