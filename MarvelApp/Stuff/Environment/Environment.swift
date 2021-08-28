import Foundation

public struct Credentials {
	let publicApiKey: String
	let privateApiKey: String
	// This is an intentioned tip, to be able paginate list of characters for the Marvel's api
	// always send the same timestamp
	lazy var timestamp: Int = {
		return Int(Date().timeIntervalSince1970)
	}()
	lazy var hash: String = {
		return "\(self.timestamp)\(self.privateApiKey)\(self.publicApiKey)".md5()
	}()
}

public var credentials = Credentials(
	publicApiKey: "f1a6c7ebb56e86db833d9c1eaba5d39f",
	privateApiKey: "b264468b7ee37e0e4d4e8bdb40cb2d23b69e9876"
)
