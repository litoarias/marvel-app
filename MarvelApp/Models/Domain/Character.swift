
import Foundation

struct Character: Codable {
	var characterId: Int
	var name: String
	var thumbnailUrl: String

	private enum CodingKeys: String, CodingKey {
		case characterId = "id"
		case name
		case thumbnailUrl
	}

	private enum ThumbnailKeys: String, CodingKey {
		case path
		case ext = "extension"
	}
}

extension Character {
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		self.characterId = try values.decode(Int.self, forKey: .characterId)
		self.name = try values.decode(String.self, forKey: .name)

		let thumbnail = try values.nestedContainer(keyedBy: ThumbnailKeys.self, forKey: .thumbnailUrl)
		let path = try thumbnail.decode(String.self, forKey: .path).replacingOccurrences(of: "http", with: "https")
		let ext = try thumbnail.decode(String.self, forKey: .ext)
		self.thumbnailUrl = "\(path).\(ext)"
	}
}
