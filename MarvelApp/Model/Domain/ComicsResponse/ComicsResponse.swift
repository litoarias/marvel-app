import Foundation

struct ComicsResponse: Codable {
	let data: ComicData?
}

struct ComicData: Codable {
	let results: [ComicResult]?
}

struct ComicResult: Codable {
	let thumbnail: Thumbnail?
}
