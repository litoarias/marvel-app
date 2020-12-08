import Foundation

struct ItemResponse: Codable {
	let data: ItemData?
}

struct ItemData: Codable {
	let results: [ItemResult]?
}

struct ItemResult: Codable {
	let thumbnail: Thumbnail?
}
