import Foundation

protocol CharacterDetailProtocol {
	var comics: Observable<ItemResponse?> { get set }
	var series: Observable<ItemResponse?> { get set }
	var events: Observable<ItemResponse?> { get set }
	var errorMessage: Observable<String?> { get set }
}
