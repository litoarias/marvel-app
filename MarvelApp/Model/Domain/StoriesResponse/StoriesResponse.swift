import Foundation

struct StoriesResponse: Codable {
	let data: StoriesData?
}

struct StoriesData: Codable {
	let results: [StoriesResult]?
}

struct StoriesResult: Codable {
	let thumbnail: Thumbnail?
}
