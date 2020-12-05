import Foundation

protocol CharacterListProtocol {
	var hasMore: Observable<Bool?> { get set }
	var characters: Observable<[Character]?> { get set }
	var reload: Observable<Void?> { get set }
}
