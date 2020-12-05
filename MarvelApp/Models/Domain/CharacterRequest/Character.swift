import Foundation

struct Character: Codable {
	let comics: Comic?
	let descriptionField: String?
	let events: Comic?
	let id: Int?
	let modified: String?
	let name: String?
	let resourceURI: String?
	let series: Comic?
	let stories: Comic?
	let thumbnail: Thumbnail?
	let urls: [ChracterUrl]?
}
