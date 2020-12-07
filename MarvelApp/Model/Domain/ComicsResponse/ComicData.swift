import Foundation

struct ComicData: Codable {
	let count: Int?
	let limit: Int?
	let offset: Int?
	let results: [ComicResult]?
	let total: Int?
}
