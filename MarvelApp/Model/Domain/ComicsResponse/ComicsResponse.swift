import Foundation

struct ComicsResponse: Codable {
	let attributionHTML: String?
	let attributionText: String?
	let code: Int?
	let copyright: String?
	let data: ComicData?
	let etag: String?
	let status: String?
}
