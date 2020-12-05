
import Foundation

struct CharacterData: Codable {
	let count: Int?
	let limit: Int?
	let offset: Int?
	let results: [CharacterList]?
	let total: Int?
}
