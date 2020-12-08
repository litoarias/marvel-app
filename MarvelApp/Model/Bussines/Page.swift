import Foundation

struct Page {
	var limit: Int
	var offset: Int

	init(limit: Int, offset: Int) {
		self.limit = limit
		self.offset = offset
	}
}
